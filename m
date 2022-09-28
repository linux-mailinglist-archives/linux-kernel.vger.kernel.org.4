Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7D5EE9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiI1XGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1XGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:06:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B48696F5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:06:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r14so2180935qvn.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rOdQ2BRERV7zL+T7IaesD2A0gwVZ2UwwP2s3/GYWoCc=;
        b=LdtLLhmDhjDwi4NVuZ1pJTpHVdhaZONxDFnvMHIde8LHifJwe3kNlpcjXCgHSECaAn
         k38wUwHr3oKnw7CgoDggoqRrPEdOtSDIpy6hsyTdXC4d2yCzuhDgg8abSDFJVBIzExk+
         32qefQ4/7xOB1sinZ068/mCrbAeT17tC83MYPqLDeLOc5mnwJgjmDwFFN7kw94lQ4WO7
         7NfDMgXVbWVJQRsDbKI4aXhxfPb+bqd4gHEOZzIFZwZRhSD3ru34B9eH/dmYvJOgjzc5
         o+k83d3BGsD10AbEnT9AaexbGIXcLWkJXoXkgItEEC5ywFZw5hBJc0jBD/74Ss2I4LUj
         niAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rOdQ2BRERV7zL+T7IaesD2A0gwVZ2UwwP2s3/GYWoCc=;
        b=yq4BH45rKMMA/800GYfUL58eMR1aNrB76Up/l9YhRu1FT6y6OHFtqFirMdQ5LEjS7g
         fifDhgnsx0NcVhodQpHUJmhgFlTQeMDxdTFTEGsSnSrVxt99/2WbSbOu5Fx/im/Mazzy
         5O7GLozmLSEdDXtE1dkh9gl8jy1HMhkL8iyTfyTUDZdhiye9a4ZgmUEnLOr5xj7CoOid
         xprbCbuMagiBVNbEUFAP0eKbUzwxE8KRzCmD+rz5iujUbtIXEgvv70ifbn0lcfk2tTsD
         EzocKbFYaH17AjupllwcKd6FHX1GPrMGhGnCLledWqHwvnqE7Q53ZA9+v+ZSDy3lHLLs
         CvLQ==
X-Gm-Message-State: ACrzQf3DCyvIdECkcUw6+BlWyAwo9juaT/xx9EVZLPbhc/oq/eNLV0dJ
        O56l+ZXlb5EMtkGMimFtStk=
X-Google-Smtp-Source: AMsMyM5wHIpoDiSwffOIuoBnlDBxUmFLUHdJycPk6YJF0sLQ6Dm1iErTPnjiFfPS2nqsaqVrKJRIBw==
X-Received: by 2002:a05:6214:62a:b0:4ac:b768:ac53 with SMTP id a10-20020a056214062a00b004acb768ac53mr381437qvx.120.1664406390812;
        Wed, 28 Sep 2022 16:06:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u4-20020a05622a010400b00342e86b3bdasm4461476qtw.12.2022.09.28.16.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:06:30 -0700 (PDT)
Message-ID: <729030b4-c341-966f-05ed-3754122cb4f7@gmail.com>
Date:   Wed, 28 Sep 2022 16:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
        william.zhang@broadcom.com
References: <20220928174739.802806-1-f.fainelli@gmail.com>
 <202209281100.5311EE081B@keescook>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202209281100.5311EE081B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 11:01, Kees Cook wrote:
> On Wed, Sep 28, 2022 at 10:47:39AM -0700, Florian Fainelli wrote:
>> From: Seung-Woo Kim <sw0312.kim@samsung.com>
>>
>> To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
>> from arm confiuration. Basic kernel bootup test is passed on arm with
>> CONFIG_UBSAN_SANITIZE_ALL enabled.
>>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> [florian: rebased against v6.0-rc7]
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Ah-ha, thanks for testing this. What devices did you check this on? I
> know boot-up on arm32 can be very device-specific.

This was tested on an ARCH_BRCMSTB system which is using an ARMv8 CPU 
booted in AArch32 mode, so virtually equivalent to armv7l. A raspberry 
Pi 4B is also happily booting with it.

> 
> Which UBSAN configs did you try?

All CONFIG_UBSAN_* work with the exception of CONFIG_UBSAN_ALIGNMENT on 
my ARCH_BRCMSTB system, however it works fine on the Raspberry Pi 4B.
Florian
