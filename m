Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF15F7366
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGDiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJGDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:38:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385CB0B2F;
        Thu,  6 Oct 2022 20:38:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d27so1203713qtw.8;
        Thu, 06 Oct 2022 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+7OrheKhEw/UgXjdWGZBr8IlT56BkbaBFYQu69ElzQ=;
        b=p4mjg/UnT5B0pgKEWX0oVNyE0j8bEqxntPJvbHYC6N3HTIjdoY2wngiqlA06Oj/M6v
         3TZLXSJNAUSBZYMMTbrNZ0ewhsG+0Y68p9U78mSo8jHYBVw/J5ITpoNqwsmHZHoFP8xj
         kh3SgOc0O3Zr0UvyWv4HSU/NdnB3jABUPbpvRdIGp7D6vrObef0SMT08Kg74BwmpRhW1
         N3KGzc9RToRvgOjSuMq9oSkSTPrg4AGuyw/QD16+whZYfSJM8DdoqmhB8Yt7IFdOYz3p
         GxHaRheOVP+jaCvgy8+LW+faKzllKKK0j4xXNWLbEKACDybHp+HWXVT9bG64qKDTs/P1
         ivSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+7OrheKhEw/UgXjdWGZBr8IlT56BkbaBFYQu69ElzQ=;
        b=P/mc6T3CxYZAVjLtrtLAmN+6eW3s7d6iYjicCkkXBzGBFI+Wq9JQ9fLMWaSozun8yV
         071DxhUeBYNgUL2jdJOWINtHjlYDYkSsuZyAucjerRZg4Q9sx4scxjau173AKEhM0kLk
         KW2Ip2BIYFVOtS7GnWJkzDKHQ0YY86IG5VSiGZV0KL8oYopUIHm0vz6S5F16+NOVJJBZ
         SnZvf1LhWUdsn+VwptG2/Zn2sqtTDlvBc1bNgI+7Hb7jrrRMEFLIf23RlibtpB4twVvM
         S/UcpKwUhDm/I9LGpADG7GnJjzMDcTJ+D7YlDhokBNbt94PtFidGLTEZOcvUE+H7rDJq
         JWyw==
X-Gm-Message-State: ACrzQf2katksvA2OJ0l7RjF1lKMcHUASfZGScDgqDjPA3+T6s/itth3S
        kqy7NgHSz60A9Riv1fw3VCXXWP0fjiU=
X-Google-Smtp-Source: AMsMyM7+6+ATWlbRWGEdM4cqMA1+okeU7ZdShfwV63Z8scEDotwILFioY5fN2ATl1gzhPLROX5vFkg==
X-Received: by 2002:ac8:5c45:0:b0:35c:cd2c:c8f8 with SMTP id j5-20020ac85c45000000b0035ccd2cc8f8mr2776338qtj.105.1665113880411;
        Thu, 06 Oct 2022 20:38:00 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006af1f0af045sm852241qkj.107.2022.10.06.20.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 20:37:59 -0700 (PDT)
Message-ID: <17ce5b72-c2c8-ae9e-de07-568619ca3c4b@gmail.com>
Date:   Thu, 6 Oct 2022 20:37:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Content-Language: en-US
To:     justinpopo6@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        justin.chen@broadcom.com
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2022 4:21 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Al Cooper is no longer the downstream maintainer for broadcom USB.
> I will be taking his place as downstream and as an additional
> upstream maintainer.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
