Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2A6E012B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDLVtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDLVtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:49:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5547527A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:49:12 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id op30so1996264qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336152; x=1683928152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pe152ZxpOtlNNDhY6CtkNvt/6HH1FOB+gbav0iLNO6A=;
        b=Z1aRT4ET/+o4RD+ge1uczp22qmhKNnyV1c4dyeYw0eYI4cIBrA2NYezv0jlbqjNQ2R
         PnIZS9gCmVbjXhepJ4Ube0N+1lH0VmmXk0NYC5dcEwgLRbfotfNm5ohsrORDFILSZYyR
         Cp5fxq46zPY/gzV+9mLAehFKlzEPOIpPUBKGoRKxtH5ctjX7DBTBU5UKaKKZR5tqCbKu
         O79Lev7NmrQXYJcY82kUGzJJBadKQ6Fg3zKtRPRIY1WAR/KA6d8ruWp9ILw15d0Ip1LH
         THn0aUcIJQxGaScohjhpXxr3gBr1d5a6zAHrxYgImrpEUzCy7QS0x5XD4ln038EnmOvH
         tyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336152; x=1683928152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pe152ZxpOtlNNDhY6CtkNvt/6HH1FOB+gbav0iLNO6A=;
        b=M+OMB3MEwFCDjyc/ImUV547kYMJF0GO1IYYPaSZHet8PXry22vMHq3GKNDLb8j9Ng/
         i4WKLM6iVdNoK1s4jt1Pc1B56MoV7RsFE+Le/C2iybucUrb1Vxd1sFCFt8urKz8eneUN
         FLLwcvJeXFsINMADi0UZYB+8XWm9okZVSdC6pfqjglr3Hkuh4R3/NmPALHHu2mTTOl0w
         bFxOkIaii9sVn7cyQZ5woHakTstPBvoixz8I+N2vsI4+9bfnH+39T5PkUVjYUc2IRRYj
         RNcna5ae9POrTo1CRmJjHjHwcscXw6wMlh8HE5CXDg63COjCFs+/QMgtXzR0sD9K9Hgu
         HOlQ==
X-Gm-Message-State: AAQBX9chS2XPipyMMUU9AAgn8AtGxkUss6ns/lOHPNxcElVGQViF2ruD
        H5NA/tAqXRA5UTA2dipmkHY=
X-Google-Smtp-Source: AKy350bRA12LE8AIunB6s2euq+/3u9Afr6bplFVu3TXtSz5nZAB8Fp7mxRj7U+JovLlltl1twNHIxw==
X-Received: by 2002:a05:6214:d81:b0:5ee:e4b2:d95b with SMTP id e1-20020a0562140d8100b005eee4b2d95bmr5801819qve.50.1681336151936;
        Wed, 12 Apr 2023 14:49:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05620a260700b00746aa080eefsm986qko.6.2023.04.12.14.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:49:11 -0700 (PDT)
Message-ID: <abb8db38-5fb2-76b6-ea07-de3c72eaf553@gmail.com>
Date:   Wed, 12 Apr 2023 14:49:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] ARM: compressed: Enable ZSTD compression
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <20230412212126.3966502-4-j.neuschaefer@gmx.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230412212126.3966502-4-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 14:21, Jonathan Neuschäfer wrote:
> With the previous two commits, it is possible to enable ZSTD
> in the decompressor stub for 32-bit ARM.
> 
> Unfortunately, ZSTD decompression has been quite slow in my tests
> (on ARM926EJ-S, ARMv5T):
> 
>   - LZO:  7.2 MiB,  6 seconds
>   - ZSTD: 5.6 MiB, 60 seconds
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

