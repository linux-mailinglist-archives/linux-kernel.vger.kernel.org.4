Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BF6BE248
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCQHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCQHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:54:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF857A6BDB;
        Fri, 17 Mar 2023 00:54:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c18so4484042ple.11;
        Fri, 17 Mar 2023 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679039640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhA8RgR8dB8dv5jmgXXgURpHIfzuS3rUgdc2khetgog=;
        b=LNWm66YajPKkn0uJ4706mVfXBVMwGg4Dz7LOGQ768LmNww3aarcc/DUSq/rmjod6oA
         kxfBRKLplugBuy5CIsncBMO5ZcLKUw28ynFScCoqVyKuXGYDVst1FKdmXJduEynGFU53
         q+Cect6Yw1xSFZviXlqheWH0SeqYPC2ZtPOAWOy+xwX4/j/tIov8TxfPuli+bEnWcb+F
         4OAk7w1gCUjdurreFYV1A21rDeVXCLLv9fcsDwgvvh7Nplm/ncDWJzflQGkgce198KO4
         1yW+2q1uuFpTUiPTny0fTMrK3ekeofB2rYOeoE1keT2+WAEhI2Ls/DUMwF0Yw9cYfbUn
         Awtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679039640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhA8RgR8dB8dv5jmgXXgURpHIfzuS3rUgdc2khetgog=;
        b=UfbtRSmTGVEk6zV41zQREoqVp0DJdL6tR4lOKeeHI9Agw9GpQ++ZcE26VG4VfOycfV
         Snm7TLos2JQfhNxzIwsmHi2g3iHWA4e5gyIbHPhF1j5Hu7YxYPVFOBhULSAGChx0/fQg
         cGcstAZKvxuCvNBVnAIzVu2ZariAXw7IjfiaAXexfcAI1+AnQ3FLsscfge78LERkS3Es
         tFLhIbH4IdGSRswtRapAVnru+U2hCjoDUhbw00WFfRBxRGIGXp+3HuCLt/96okokg/Da
         zt17GGarzAI/Wq2psNfsPl9n1WrGQMg2/xtF4P9DIbZ7UGb/yOZ72r9aFEwb0B7P8hwQ
         OP6Q==
X-Gm-Message-State: AO0yUKX/Esopaqxg/9IPUW+qR9P7MlfgYZ2jHwQG9F9OyYIFdz5LYbTB
        r7tq/h7fnPrEuhMImRk8zD4=
X-Google-Smtp-Source: AK7set+Jb79iNsQUzRM8WCMaeFg7baCx7NGQg2F9YNeYg0S87lETLGwcmqAzBb2Yy+pNhm/KXmV7dg==
X-Received: by 2002:a17:902:fb0f:b0:1a1:a06c:4892 with SMTP id le15-20020a170902fb0f00b001a1a06c4892mr2583827plb.13.1679039640414;
        Fri, 17 Mar 2023 00:54:00 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b001a072be70desm938904plj.41.2023.03.17.00.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 00:54:00 -0700 (PDT)
Message-ID: <b870ba3c-79d6-13a5-adf8-fbc12ee1cdef@gmail.com>
Date:   Fri, 17 Mar 2023 14:53:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Documentation: submitting-patches: Disqualify style fixes
 from Fixes: tag
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Outreachy <outreachy@lists.linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
References: <20230316082034.14191-1-bagasdotme@gmail.com>
 <fe15da9c-d03f-ccc3-ea6a-2b6401496aad@linaro.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <fe15da9c-d03f-ccc3-ea6a-2b6401496aad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 15:23, Krzysztof Kozlowski wrote:
> I think it is pretty clear already. The doc says:
> "If your patch fixes a bug in a specific commit,"
> 

Oops, I don't see the whole file before writing this patch.
Thanks anyway!

-- 
An old man doll... just what I always wanted! - Clara

