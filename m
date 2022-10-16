Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3D5FFF22
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJPM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:26:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA37357DD;
        Sun, 16 Oct 2022 05:26:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so8534260plb.10;
        Sun, 16 Oct 2022 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pNStEG1FkUfh4Si/j7M8p6afBo9Oypw8Af/t053Cwg=;
        b=G/hYXwm0CNhdQl6LDzGSNFQiXU1KKYsY02F3Cdrb17AUvBw7cDzlWF36xpSLJ8ZhBS
         5KBIooQGSXHYLJTZg1ohT5clZzYxVa610jYSoxTFuQfhcY1YbLKGuGKURyvUICoLmoef
         Rdk7U0KMVyOR/FRkJ/M2pXCBqNy1ImmsRRF6GQKhC19rDrA3HyGHvHtcqjjqExS36Mva
         RCivXpE0EP4/fzZRFQyI8dDvQCPtLtw+GIRPtyIlrVn1cNAznUgmvH7rCetS8F1KLfJ9
         A7tWxA/fdjDqFf+LZo4QBr24T3OXmVc33yn6h2xzTd+Ar8ligTodPQMum/PviT6rS2oN
         wQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pNStEG1FkUfh4Si/j7M8p6afBo9Oypw8Af/t053Cwg=;
        b=eBzggk9GcIsMeo7nfB8E0Egp424ak1zNjlRuSWH2Qn0ldWMde9vuikDY4aHxrH1vqd
         AaXuZu2ZrTpzU8DCwSea7mspvJLvgOzZu5OjDTskGnijQU3lI0A+E3SXZome/LhNuGR7
         DDja6vBNqa9Llz/uLDTE4E7utv0BdXofj32QDmr85FDj44TUOnQ20DMLIUh9aXaP3dg6
         NyfZjRt20l8jS823smgjTItNUZrORx8pIMRFUfXC7fyti49qTRQ5jOk6R18Ca7mJRFuo
         15kC84SGvVsDIfZrbj/Vr4jEbE1fOFXv5cO3SZST+1beipI94Bhv8MCh0TBFOdUY1Egp
         LPfQ==
X-Gm-Message-State: ACrzQf3zUmnNu3yIAJd8D4XBow4OkgBMlMdwrPFxtRibVqBdsn0J5z7B
        6is2mwYBwBNllJ+/liUNRRrti+nRkJk=
X-Google-Smtp-Source: AMsMyM5GOyhNgPXUX5ftVQdF4dNSjxOH8qSlzvCgpktEmHmtN+k/5/ergje1cciHWqgY2+hsTA8JNg==
X-Received: by 2002:a17:902:ced0:b0:17f:92d6:f5ec with SMTP id d16-20020a170902ced000b0017f92d6f5ecmr6703479plg.34.1665923190525;
        Sun, 16 Oct 2022 05:26:30 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-46.three.co.id. [116.206.28.46])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b0017f205d91d9sm4739774plh.118.2022.10.16.05.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 05:26:30 -0700 (PDT)
Message-ID: <55fc0cc6-01fc-6b93-ce82-bad5452314d9@gmail.com>
Date:   Sun, 16 Oct 2022 19:26:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <Y0tz1/pR/s7+j6s+@debian.me>
In-Reply-To: <Y0tz1/pR/s7+j6s+@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 10:00, Bagas Sanjaya wrote:
>  = ===================================================================
>  0 Disables the misery mode - just warns the split lock on kernel log.
> -1 Enables the misery mode (this is the default) - penalizes the split
> -  lockers with intentional performance degradation.
> +1 Enables the misery mode (default)
>  = ===================================================================
>  

Oops, on the table above, s/Disables/Disable/ and s/Enables/Enable/.

-- 
An old man doll... just what I always wanted! - Clara

