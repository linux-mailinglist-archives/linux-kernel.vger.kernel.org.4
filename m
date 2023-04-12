Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056936E0128
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:48:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D482469D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:48:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l11so14669164qtj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336115; x=1683928115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OA4ifBjjUBhqxW1kL8wHvEfhchEHzp6wDC3omb1/uGI=;
        b=YxQ53+/Lvgn0A/3+q+D1DR+MFB0RM6t3VinLU+JbxQpL8aQ/V1AIbenP65zMHsLrH7
         wJpn5GTEHor/sWSKobH+vUrPBvoWCR6hKt9h9R2U2mmT7ZAKlELxDweSDEMp9dKfAf22
         GpdKgYgR+rCwQRVe1iASC8cJSXlnuoV6Rvo6R+Na6FzoD7x0a2q67BX/alM6Z6m7FOpb
         1+sw0ZM7fTWu2MXJgLACpvh0+8pYAXod6srHNhebCPws4XMIBfD/Sry6y2Rr4t7zeDgW
         FOu+HLJZYgxX8wnQ6mvSA/Ts02JVySetK9m6jnWOybb3S0KKKPaBEHAH+tNvub/Aoxtc
         B7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336115; x=1683928115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OA4ifBjjUBhqxW1kL8wHvEfhchEHzp6wDC3omb1/uGI=;
        b=Vxfw6sSi377u+ICa/MDEmXHu8sJEBgix0gMprPC/6Ly/pqV4689l0TlBiZzN6hoYYT
         gnwSCLfvCkh0huOFVePic0G3fVqnItm3OYWkaIj2SvJahec8wx8sHYLNT+59w1pClAB1
         yPYp+VX2Rrqcu7Jxr4e1rGFDrSmRTZpbSSDXOPneIdPF4xp1Rm2LtxNhtJtso9IoxRz9
         lkMwpfBpj8CSBMqzmNUN4UWr9dZ5yGBEH1j25lKFhvFln4j5VGZZUAe3E9HhFC4a1rg0
         IwzaqC7FivRJXayJkhLra5qZoKUeLTKjViYx56/vcXzineno2pKpPR29kd4ScPxVWZGH
         qEXA==
X-Gm-Message-State: AAQBX9clf/2K+Pga4eMMmAD0RUtdnRxQkPuuMZ9BqjfCBbBjkZxwYkc+
        XfMWYKsKYARzX2uO1xeFM8Y=
X-Google-Smtp-Source: AKy350YEqTIQ7X+Mrh6KNWSf9/lvz6I6UYu4ISdAZx5eL6cgvGTCkHjrKJ7virLFCTeR/6XDsSS1vQ==
X-Received: by 2002:ac8:5bc2:0:b0:3da:e3a8:b01a with SMTP id b2-20020ac85bc2000000b003dae3a8b01amr152551qtb.0.1681336115557;
        Wed, 12 Apr 2023 14:48:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g3-20020ac84b63000000b003e3910db4f1sm23201qts.35.2023.04.12.14.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:48:34 -0700 (PDT)
Message-ID: <95dae940-af15-d8ef-5ce9-4ac983dfdef8@gmail.com>
Date:   Wed, 12 Apr 2023 14:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] ARM: compressed: Pass the actual output length to the
 decompressor
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <20230412212126.3966502-2-j.neuschaefer@gmx.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230412212126.3966502-2-j.neuschaefer@gmx.net>
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
> ZSTD writes outside of the space that is necessary for the uncompressed
> data, when it is told it has unlimited output length. To fix this, pass
> the actual output length (the length of the uncompressed kernel) to the
> decompressor.
> 
> The uncompressed length is already stored as a little endian 32-bit
> constant before the input_data_end symbol.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

