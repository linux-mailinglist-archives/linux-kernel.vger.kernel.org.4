Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC276791F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjAXH3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:29:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74FA1BAEF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:29:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vw16so36570484ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6qG3BxsU9DzBi96t2cPx3U6M9c7IcgwUtyH0SLYa4g=;
        b=XQJEBD+Y7xXVzz/nDHd/S0HvH752rWzTMP0DGsUG38TNK8qbInkeX38e7aL20QWe6M
         kBVcoZbmlAMEKoI1tVfFsZpem66CouQRKsddSFwIgsX5WGdyHserqv6Cz18iyTVwfS51
         nRepPkKhPh77MF1ftu2fBC1KafiG0Apx3fp/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6qG3BxsU9DzBi96t2cPx3U6M9c7IcgwUtyH0SLYa4g=;
        b=t2pKgprWu+JHam4UxV0SfhOiNnLq5jPsRMIURi+zohALOTfBLrosYS92TpWOhLBADB
         tSDr4147TNebaGOglemMU/mLfq6VmaPNeUKubYv69+NAR0/tBlzNr0y7wyPq9YD5tsku
         gEmi2oaYLzGwBoGfU5GjPEDav9pp1T7p8U3lJmU50R9F4pvCW/A8OmbDqHfVIS6qQhPm
         Z//8Cb9I5FfE6CfJ2wxuj2DXyrhUPpMy6wN2C8r4goGzpM13+N5HLt1e2IfOTOpNfzq8
         ofFszj0TtAJekyZU1nDNZYM651QC9yRdp9ayYx/MF30b65u/lqQiB6NG9nISuve1cDxg
         AIIg==
X-Gm-Message-State: AFqh2krlBmyBaPLspZe+XzJcy8wUm8/arNs3q8sXZl7ZmdaxSJOFaw5/
        D2OBYjq4xynsrvJL6aN5iT/SG3Vc3CKBvv3wcNhWvA==
X-Google-Smtp-Source: AMrXdXvidJI1X9Ofw2tlxMTOMXNJKUk8KX9Nvo9V+Ox1qGGWLz9APdwv7vOmlMKgq5MPZP8u79+DHlr5adylHiaktg0=
X-Received: by 2002:a17:906:f9d5:b0:86e:65b8:e908 with SMTP id
 lj21-20020a170906f9d500b0086e65b8e908mr2065436ejb.450.1674545367480; Mon, 23
 Jan 2023 23:29:27 -0800 (PST)
MIME-Version: 1.0
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
 <20221214134620.3028726-1-peter.suti@streamunlimited.com> <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
 <CACMGZgZY4Zb+3vHUDAS0+3r55K4_J40dtbsTPTFZMd6duBikpQ@mail.gmail.com>
 <7c4aa0d2-d8e9-416b-b2ad-f5c3c8ea33de@gmail.com> <CACMGZgaS7z2YoViA3jV-gVBvASSq1maiGj_6hfrJQ3zr69esgQ@mail.gmail.com>
 <c6d797f8-8177-75c7-4522-eea3da6b56d8@gmail.com>
In-Reply-To: <c6d797f8-8177-75c7-4522-eea3da6b56d8@gmail.com>
From:   Peter Suti <peter.suti@streamunlimited.com>
Date:   Tue, 24 Jan 2023 08:29:16 +0100
Message-ID: <CACMGZgbR_aE9Wph3ZGZ8yGy+V2qjG6GXV8w6JMkw2WYzk8gdow@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 8:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> > v1 and v2 also fix the issue, but v3 does not correct the bug when
> > WiFi is stressed for a longer time. And therefore it should not be
> > used.
> > Could you please give us some advice on how to investigate this further?
>
> One more thought:
> When checking device tree I found that my system uses IRQ_TYPE_LEVEL_HIGH
> for the SDIO interrupt. meson-g12-common.dtsi uses IRQ_TYPE_EDGE_RISING
> in mainline Linux, however vendor kernel uses IRQ_TYPE_LEVEL_HIGH
> in meson-g12-common.dtsi. A wrong interrupt trigger type may result in
> lost interrupts.
> So you could check which trigger type your system uses for the SDIO interrupt.
> If it's IRQ_TYPE_EDGE_RISING, re-test with IRQ_TYPE_LEVEL_HIGH.

Thank you for this suggestion, this change fixes the problem fully.
With the interrupt trigger type set to IRQ_TYPE_LEVEL_HIGH everything
works as expected even when WiFI is stressed for a long time.
