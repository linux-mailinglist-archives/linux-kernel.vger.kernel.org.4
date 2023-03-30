Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3F6D00D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjC3KNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjC3KNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:13:15 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC478A7A;
        Thu, 30 Mar 2023 03:13:09 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id m16so2431609ybk.0;
        Thu, 30 Mar 2023 03:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiQtdZgzOCieHIQyt+UuoiOVmv0W3cDpr9ArTRdEFcQ=;
        b=Cf0Wg1g9ZDlWEyBJ5jftqyHp8Y7VJb1UQVwd84vE/fjfOzA0jCggavzTHL3whf1tfb
         dmcN0t8QPWwkqkbc705cSp+Tuy50s5sqVpzdJsU4CwmLV0RfoboVmNKGATllXak4PXym
         7TGl1uiN9edtSFSfUmvC9Jyp7N2D6mBxFZ4qUu2E4s1jDGLSI5QzVMCN4yKcY6ipE184
         l68WufhN221p6CnZeQwoeyYuPNyZZCJDL0cxZHbmY9uxRZArA94VZmSzL8uTBDWSBr55
         xCjIrVNzRiA4K096J3pKAPLBao/mPxz7PWf+3NHregfEl/ksT6JppBLZe95JvLy69u6t
         DpCg==
X-Gm-Message-State: AAQBX9fy5viQ5Zmsk5Gtk4yMqDhaBzZ/JHlRG7/wwBoipKBFLDlLjmYT
        6HsY9HtNEMkOZCt4Ms81rV33xKvFTSEsDg==
X-Google-Smtp-Source: AKy350Yfn1ou7bsAOJzOvc0vyzvWto3jAIElGlJUgo9Kt8BgFvZXJZ2bwaxX5Ez7fuNYCiTnvfX52w==
X-Received: by 2002:a05:6902:102a:b0:a27:33f:cba7 with SMTP id x10-20020a056902102a00b00a27033fcba7mr26348109ybt.33.1680171188281;
        Thu, 30 Mar 2023 03:13:08 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id l186-20020a8157c3000000b00545a0818494sm3467569ywb.36.2023.03.30.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:13:08 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5456249756bso345049517b3.5;
        Thu, 30 Mar 2023 03:13:07 -0700 (PDT)
X-Received: by 2002:a81:b617:0:b0:544:4008:baa1 with SMTP id
 u23-20020a81b617000000b005444008baa1mr11162541ywh.4.1680171187711; Thu, 30
 Mar 2023 03:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230322125648.24948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230322125648.24948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 12:12:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVayx_jz+JHO8kd6kdDHp_f+61o2zTDjr1LdGPp37vBjA@mail.gmail.com>
Message-ID: <CAMuHMdVayx_jz+JHO8kd6kdDHp_f+61o2zTDjr1LdGPp37vBjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 2:09 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
> using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
> that RZ/G2L alike EVKs can make use of it.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> setenv bootfile kernel_fdt.itb
> tftpboot ${bootfile}
> bootm ${fileaddr}#rzg2l-smarc#ov5645
>
> v2->v3
> * Moved the gpio.h and rzg2l-pinctrl.h headers to
>   r9a07g044l2-smarc-cru-csi-ov5645.dtso

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
