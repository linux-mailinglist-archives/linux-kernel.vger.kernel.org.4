Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1866B0F5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjAOM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjAOM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:27:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077DBEC60;
        Sun, 15 Jan 2023 04:27:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso31434180pjt.0;
        Sun, 15 Jan 2023 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=md31HFYE5YCxXfuRLzSQsGi/ksRGDmls2ZiH7xI3PQ8=;
        b=fdP+i3nAQhApXR2J1OsPjW3WUeEij207YPPkebCAgGGJeZxyH3NnqoecIFFKJYPMMg
         eTbyUYbhci7uk6lyo/omyPd2IZm1FJzIoA4Fe93pEOuLN8x1o8cHY+EjMUUkkMpHms9w
         xy8POcc4PC1f0Pd8hcCFMQfKDpl7spXsFi1PeaL2a8GIvT1EsqqXfH5XbxqNZ9a4TAcs
         GNrwf8xzxBJv/ORoapjLbis7zCBeTPnuK4UnCxf4KJ97sZkhU5UCHmNRLmQKkihauEhR
         SluvMGgvoGGV19xqCPHru90+Q234KmGrYyE2OCkyU/kx5tOofcQS0AQ8fvrdwEN3Rand
         rS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md31HFYE5YCxXfuRLzSQsGi/ksRGDmls2ZiH7xI3PQ8=;
        b=efOnla6xIhpYKioD+6TTZ37J/OWZ63UizMQnMBPkLUQN0REo1E6g+8VuAULReJTKQI
         F33wwwb3k0OflkObnxPQPNgLVZ4f4d83YqX1VrYwR3BiVvE8Se6H6mLNfFK3QwcPeEIA
         NKvJe4u4K7wuCuV04nLxgKc4xcL1GpcwiFohbWlChVjXk80Ytki8gY8KqCfvYqjwaTRs
         O/dv+9G5FZwZVUOKTida+Mfu3rMMp5aGpuN0fb2JbaSLVW6xTLym040x1kCeY8wO1VUK
         mmXftO9u1vp3xYphTXvWIDs+5QkjreuhkwrgDOsw+/Bdtuw6XLPaqWqgowV597EDurf3
         JYkQ==
X-Gm-Message-State: AFqh2kpMCpsR0M57sQsrcn6O9UQMA7yGaHi5dlI1gCjOQUSlpYw+K2IL
        jjgzwBg3lSIKcdmrC94BV0Ngc0l09KOCMshXLDk=
X-Google-Smtp-Source: AMrXdXu/LKdj4DjkuA3D4kGVNv5jp1l/1Q6lJt+5tTIxAHfEWgB6bSXrumxdMjdqktuti5VGtDyE058FlkVVv5Q7f5o=
X-Received: by 2002:a17:90a:cb11:b0:229:5037:d9 with SMTP id
 z17-20020a17090acb1100b00229503700d9mr324322pjt.195.1673785639428; Sun, 15
 Jan 2023 04:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20230115103217.9232-1-pierluigi.p@variscite.com>
In-Reply-To: <20230115103217.9232-1-pierluigi.p@variscite.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 15 Jan 2023 09:27:08 -0300
Message-ID: <CAOMZO5CdG=Tx98DVYo9QZFM7Y65b0KGLNc=XskYDuRqORBiLSg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
To:     Pierluigi Passaro <pierluigi.passaro@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, pierluigi.p@variscite.com, marex@denx.de,
        peng.fan@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eran.m@variscite.com,
        nate.d@variscite.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierluigi,

Thanks for the patch.

On Sun, Jan 15, 2023 at 7:32 AM Pierluigi Passaro
<pierluigi.passaro@gmail.com> wrote:
>
> According section
>     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
> of
>     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
> the required setting for this specific pin configuration is "1"

Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
