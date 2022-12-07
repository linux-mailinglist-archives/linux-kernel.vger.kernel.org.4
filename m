Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD48646444
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLGWvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:51:16 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92166C93
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:51:14 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v71so36010ybv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q70zMajQN3RUVFb5jkCxHTvNYz2tKhzpWMyOAgqeSWs=;
        b=YaQVG5/8b2Au5Iifv0PFohGstar76Groyj5Eak8Knb5o/77fcpfcFF8m/O3FUnXI9D
         2+EObm0HMCQY4RbnNUVbLbrP7clfB4Rq1LidiW2eqpQfCsIiZ2A29GV3qQMhWnbRn7jj
         W+p6I8zcg6vcRDC+g9sirbcbUHkb0Lbyx4sL3BHIVLLecrJjtICIQAyctENsssYRVEOb
         g0Nhi7ePzXteH0D5ArFhzCNc49uXHlbmb8egRJYVTlkFJbfurPwx8cNx4XhDNAsrLJU0
         +KMjxnM4NOCrAVJgzCeIePHOjeXvzdB0yG5QlppqEPwPQA0ABW/dtj/B21PBje04hbd/
         kIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q70zMajQN3RUVFb5jkCxHTvNYz2tKhzpWMyOAgqeSWs=;
        b=tNRHLspnnaz9cNiHVanIZ3HKQTzpZWuYU8mLHIv3KAi7WstFBXeyS3yXOB+bFMmOxw
         U2mnsyJgXzOsayg4oRbQ0XOgVLbGFuvzSlHHsau+3D1Ri3z5Oa256tie9/Ynz0D2M8oQ
         +EztGhv3N/kMRqk63xIRAqfLwE/uhRxBAMr9fYLc/8RjJAHD85eoIrf6ObR+7RETUCTC
         ymn7h3iuQXqyZ9x/6ynsVYqItTFcMvAU0wB1PPZwGnFU3n8SZgMRMpbRnp5VZ/a0Pxtb
         Jf1aMjLLnmLwTTSt9JBjLDx/CvMjDWwWcTXvAM3myrCKZ9h9piHt8EgcqRc4m+SCtA1j
         GQog==
X-Gm-Message-State: ANoB5pklf//Vdg2ypIsxLgVfg9iFizX3G+bFGjU8vB/rU/uFr71OhwPN
        NHPjbh58zT0IRUnsYbaZi/JJ+iZda33v/lW5OaZv1A==
X-Google-Smtp-Source: AA0mqf6E4b1OitgdYd6xtlE8c5Hia/us74kWULIzqFQGy4mdatmzGwOkYwjda1PmUQ6lvE7ojAsAbDs0flTD5Nb+gYw=
X-Received: by 2002:a25:d84d:0:b0:6f6:6d03:cdc3 with SMTP id
 p74-20020a25d84d000000b006f66d03cdc3mr47015052ybg.238.1670453473938; Wed, 07
 Dec 2022 14:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20221128054820.1771-1-clin@suse.com> <20221128054820.1771-3-clin@suse.com>
In-Reply-To: <20221128054820.1771-3-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Dec 2022 23:52:29 +0100
Message-ID: <CACRpkdZKmMpbWSFke4s4u8Z7x9POYNN-ONTTZp4VJzVGSSMA_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
To:     Chester Lin <clin@suse.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 6:49 AM Chester Lin <clin@suse.com> wrote:

> Add the pinctrl driver for NXP S32 SoC family. This driver is mainly based
> on NXP's downstream implementation on CodeAurora[1].
>
> [1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt
>
> Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
> Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> Signed-off-by: Radu Pirea <radu-nicolae.pirea@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>
> Changes in v2:
> - Create a s32_pin_range matrix in the driver for replacing the "nxp,pins"
>   property in DT.
> - Refine the compatible name to "nxp,s32g2-siul2-pinctrl".
> - Fix the copyright requested by NXP.
> - Remove a few recipients from the Cc list since these email addresses are no
>   longer available.

Overall this version looks very good. I will be happy to merge it once
Andreas comments are addressed, and it is rebased on v6.2-rc1 once that
is out in some two+ weeks.

Yours,
Linus Walleij
