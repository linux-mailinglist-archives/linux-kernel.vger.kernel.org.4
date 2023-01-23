Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC182677EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjAWPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAWPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:07:52 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C675F751
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:07:50 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p188so15149277yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM1EiOocNtSZA8MsnSOByXfINK+alIpF0Dhm3T9y7wc=;
        b=M2x2MjTHjmUlY72HKk4rlnXeJkdFfgeXmtMqYIyp8cmQJ8MtURsID4V59mR9+0Cn8U
         stkKjYi7X8vbNQipHx9DzCo5RgQyzvB6dknGpuiE2l1ptYtEc2rzCbOVgw0m7H4XAL8o
         +33Ibf5zFZ7swAPkUpjetRJkoz78HepNsRNWQ6hKfnyVD+7J3g+/TWrKGY9bKjHhpOAB
         UpYZdp852Txr3UQCAxYOFzoCRl8im3RVsf6FIRyK4TTq6k6UUy8cfgqeU7UC2MbTxumt
         Pu1wxP/1iGZTTYVkRqg3vdhp89nB6/obEXACanGagUvroApU7sosjl94Y0xWiiFpDO7k
         v56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM1EiOocNtSZA8MsnSOByXfINK+alIpF0Dhm3T9y7wc=;
        b=Xt/ikXKntzYrXQWGX11Z47mQAOUyNW+54jsFMIaH2tnWT1WPddhfB7659dFQLCpqrk
         IWa38y8mMPCY6mSEGh11lDPGkeXDQDZbB+8Ubh+fZXFn3QBKsmj6MTm+6MsvYk/BqJgk
         FiEfVe0+l4soHIvO3H0jdtQThV8r5kl+1/HvOvJCqJs62QJxIBqutRWketaK0o5ti6Vy
         7yt5aK+y4sKp8wpNBGxGlqQJhLiqR8VZuzLJWiSU5ZjY2SMyoiW1yGzXXrVkN36d0Aqm
         +rSVYie0TcLrAlWEzUd2nlUQTj5QbZw/iHizSpjV5R+lwgUxpIXSNlDcWenW2afFFRhn
         p9lA==
X-Gm-Message-State: AFqh2kpm3skEj7U1FT8c3Y+YEAZOly8ezuDrpyzOcFv8+ZVwYMJFj7fR
        Zx+lDGippB03itH4gR6fRCOvUnVNGypplJzByNcIfg==
X-Google-Smtp-Source: AMrXdXtou+r1eGkUjO+yV5sepHYYEBThh559isR/Qxq8Kt/3Do7Ef2BAHj6FQrPgGPw8IKZFv6I1Yuaq3ctMN14OTH4=
X-Received: by 2002:a25:690a:0:b0:70b:87c6:4fe with SMTP id
 e10-20020a25690a000000b0070b87c604femr2900478ybc.550.1674486469535; Mon, 23
 Jan 2023 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <20230120082054.610626-1-michael@walle.cc> <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
 <Y857VOG5upNJfpdM@sirena.org.uk>
In-Reply-To: <Y857VOG5upNJfpdM@sirena.org.uk>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Jan 2023 16:07:38 +0100
Message-ID: <CAFGrd9qww=s1iox+cye_-JW=LPpUdKjLfGO1+V_1J92z7eniOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 23 janv. 2023 =C3=A0 13:19, Mark Brown <broonie@kernel.org> a =C3=
=A9crit :
>
> On Mon, Jan 23, 2023 at 10:37:58AM +0100, Alexandre Mergnat wrote:
>
> > Yes I want to expose the SPI on the pin header for two reasons:
> > - It's an Evaluation Kit board, I believe exposing SPI helps new
> > customers to try/understand it.
>
> That's not how this works.  Anyone connecting something to the
> SPI header will need to update the DT to reflect whatever they
> have connected, if that is something that should be controlled
> with spidev then they should add the compatible for that thing
> to the driver.  If that is something that has a regular driver
> then the regular driver will be used.

Got it. I think this series should be dropped then. If someone needs
the SPI, then he should use overlay (or modify the DTS locally).
I thought I could use spidev to bring SPI into the userspace, to help
future users play with it ("/dev/spidev0.0").
