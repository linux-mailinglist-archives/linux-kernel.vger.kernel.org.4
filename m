Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19AA63DCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK3SMM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 13:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiK3SMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:12:10 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFD84DD8;
        Wed, 30 Nov 2022 10:12:09 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id u10so6936800qvp.4;
        Wed, 30 Nov 2022 10:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3Y+CLKsmq/zvpZ9sIIrYnKxsjyLVOCHxaKyu/MIB2Y=;
        b=f1YOfcdonv8tB3vlRGBdrZJhKfv+AE0IZwE+HDJJI2uWmDCjDmOl5IfNoI7/7A5ulp
         pS0LnRPIzwtj3rXdviqiN35+kOOJXMIlJsTOH86hY0SqEqQklQ9gyji8YrnUh/jSaaPp
         DNOSM2jqRgTd9hYLYENLhUXol41OCPQk8Ox552QEe4gvZqULzdWEROll5/MKYW6t89Ft
         DGLXPpBiPhSi8BcYUc2ubgfiNfkEPgU1BNGi4Jgspihl998j3cBiSpIjSjP/Hd8GCPcp
         06ukalabh3nMCtoYzx2nnoYSLOJyrJoE+aUSkJbNOe0ew92muk3+Fft+BErqcryM0Zfl
         tY2w==
X-Gm-Message-State: ANoB5pl6IoLLzftIFU7ipI6XJpKTp4BALhtfqzjkAZA8Zs7WpLOeMmXT
        sN/RuzjMrT6YXTJhQeJoEUGIhLu5zw0ssA==
X-Google-Smtp-Source: AA0mqf5JbxYzXrQmTqfhbWbuWoVvfemRiSmRQnnYA7TaDzjJYTcUgq6Jl6SJpTz11WtjP0PzzdRscA==
X-Received: by 2002:a05:6214:448c:b0:4c6:b1c5:9111 with SMTP id on12-20020a056214448c00b004c6b1c59111mr42036207qvb.18.1669831928454;
        Wed, 30 Nov 2022 10:12:08 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a29d200b006f9ddaaf01esm1710055qkp.102.2022.11.30.10.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:12:07 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id v206so5898662ybv.7;
        Wed, 30 Nov 2022 10:12:06 -0800 (PST)
X-Received: by 2002:a25:7a02:0:b0:6f7:952d:b145 with SMTP id
 v2-20020a257a02000000b006f7952db145mr12544760ybc.604.1669831926518; Wed, 30
 Nov 2022 10:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20221129102225.3598044-1-j.neuschaefer@gmx.net> <20221129102225.3598044-3-j.neuschaefer@gmx.net>
In-Reply-To: <20221129102225.3598044-3-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Nov 2022 19:11:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+d3tW1kVN6011m9JDuW53aGedKOUVt33yCOmhs9Oong@mail.gmail.com>
Message-ID: <CAMuHMdU+d3tW1kVN6011m9JDuW53aGedKOUVt33yCOmhs9Oong@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning
 in example (missing reg property)
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:27 AM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Add missing "reg = <0>;" property to the flash@0 node in the example.
>
> Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU) bindings")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> v2:
> - depersonalize commit message
> - Add Krzysztof's R-b

Thanks, this fixes "make dt_binding_check" for me, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
