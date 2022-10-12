Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD95FCBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJLTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:46:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A7FF206
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o2so3971865qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqVjwdfWBCkE1pMlDL/Z2pQcjfWQybozAXivNmMDNMQ=;
        b=UMLXhkeYINQ+w1SyTH6+H0gWx+iYVm/8RvH4L/zLJZa6OaLz3yQhAEhAhRHrbLisfI
         0n+mH8vwkV/XL2zhWMcMCbqSm9zhNDKC93CkqWFScmvbQUpOMitOzNzzwx+PukE3p05l
         VYlSsN2XQGc6VcfSBNJbDoFcjeIuZNHWYfFvNlFguhtioKTtSzQXb36neAbE2go+6Gnh
         QrqXHJ4/9uxfv4VjG/37JcnZ77QKqX/XqjI/vzsyI5DlumTpTmdpDovws1jqbAQTDHxn
         w2nK1uh3n5yJ7GpZmTa5TFNX2EbGUdYB94k/rK3r4eAgvDjfXLGpIKy5rpLoJ3dCLZfi
         UF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqVjwdfWBCkE1pMlDL/Z2pQcjfWQybozAXivNmMDNMQ=;
        b=5qDVdMM+iEcYwcxWBC8CnvRTcB+nWnql9EqkEuvkCuSy7Vpt9CcC55LRG5JKA4+k0h
         D8ezcg1ORIJDu+ACyVrywJnmQeQzrLIC/Sg6CUchggydqVqun00Th1G0QwqiWsMcrJsW
         MlCxqYcbTi2i3CGT1dTbginNA4T6Y3njX0xwaFsUX6gSJfkkvI4UzV5gn4Nwy2C79V5J
         SxpQddefYlwjKNeZGlUER9uNVmQ376IGSIL/R6vuorOwzqsOyCiiBkZprwow0ix3geXL
         XG1xd3Rg30noi7ggie5ROvbqY0FnmV7mQpI7G5l2YQ+chMLE5gjKQBvAU8BZ+4Q1pYQv
         GRBg==
X-Gm-Message-State: ACrzQf1tbLi3IQOtoyqcjS+21LG+cHPIqF08AESKijeJxh7px5o1Hclm
        uSUUMxp9Y5BnEOEEralXUCA=
X-Google-Smtp-Source: AMsMyM4rKf1DCsej7rV3ji3XZakebGVSFxa4Loth3omWOrqL76g7wS4jo5fx082j1uQaN67fXYt7OA==
X-Received: by 2002:a37:45d4:0:b0:6e9:bdf3:6d17 with SMTP id s203-20020a3745d4000000b006e9bdf36d17mr18403810qka.535.1665603999996;
        Wed, 12 Oct 2022 12:46:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bi37-20020a05620a31a500b006dfa0891397sm6420878qkb.32.2022.10.12.12.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:46:39 -0700 (PDT)
Message-ID: <2d9fb6c3-c331-b663-1789-b4c9d7f75483@gmail.com>
Date:   Wed, 12 Oct 2022 12:46:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
        william.zhang@broadcom.com
References: <20220928174739.802806-1-f.fainelli@gmail.com>
 <CACRpkdYfDM8mbtpJa5dQrhY1VCShwawnk0urG9zH5-fu53VhKw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdYfDM8mbtpJa5dQrhY1VCShwawnk0urG9zH5-fu53VhKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 01:51, Linus Walleij wrote:
> On Wed, Sep 28, 2022 at 7:47 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
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
> Pretty cool that it "just works", I was thinking to myself that I
> should try this one
> day. Sorry I was late to look at the patch.
> 
> Have you also looked at KCSAN?

Not yet, that would be next. Most often, at least for ARCH_BRCMSTB the 
same hardware and set of drivers run on ARM64 which is typically much 
more feature full, so we get coverage on *SAN features that way.
--
Florian
