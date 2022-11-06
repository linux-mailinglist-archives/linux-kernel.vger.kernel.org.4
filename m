Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDD61E130
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKFJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKFJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:12:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C26FC6;
        Sun,  6 Nov 2022 01:12:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so23032273ejb.13;
        Sun, 06 Nov 2022 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwgxMlKkvmgXvqoUQfR3pyVEjoh63QBFd6KeQ5QkK3Q=;
        b=jIxTKOmWNL7JnXZXgzt06JEdm9koiXW9A5AC5HFYmwRfbcEE1WvFJvRyXahxhiLwvv
         vvp5pONw1P6EU4XZgH3G7hdIdkYfxA1M4b9oum1nUbJ5/YhoEw8szFFSc7PmfKV38sIO
         3VBb/xBr7i8Dw1H6uaWu/fWbdxRXN0dwI32tcYeJpv7im+WLgF9rbJIoyeBsyns2QMC0
         rZH+QxkOMB+y6stoTaVNUvw3nQ8K/0051x9Jfqunutr/MgbQymJl6zKQnWbmVU4cMSwW
         XwOZBTjpXJzgRdyEGpCA2PrrrOlcJ16VA+ab+IXQ+ueWVeNT1RyP57Dv9i4WX1UqlRJk
         0S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwgxMlKkvmgXvqoUQfR3pyVEjoh63QBFd6KeQ5QkK3Q=;
        b=KZt5nsI5blwneQdnputPWhA52NdCcp63p05cmuIEkq/5hScM5IcHr9WabjaoPvGySz
         836Mb9Sbt6GdNqdY6ZDxVu+c+ObvCiCgdO3lc9OH02t+4+fZJa9AyFn1/kxMImKc7cU5
         im/XQVdN3UmGR3gQHdopUpHIHiojsCQUTRz4wjJFq3fQR09FLw8BZFJNMHuYv17iD1NG
         6Ugn1zoC0Ui+GYeAalR8q595oGf7hIAnICqxPI1r3qpwOCxcyjJquTuCzcXV7zeAaPau
         BE0RolzTyatRG4pHJ0cpq9YnoTw2sNjHw3Nb6zdv8wz7cG1GUQR5bpLpeetYtuiOP9rQ
         YqDA==
X-Gm-Message-State: ACrzQf0S877zcZ6K5cDPmMpDKspyxJ+kl05UEBNScdTha097h2WeTQPh
        C4WXl7h8/lj5DmK0M6iQTsA7KS1wHjbYLg==
X-Google-Smtp-Source: AMsMyM61T2Dbg/kh3O2rjB8fG5pZ9TJGhPo0uOztCGusLOrdZtIIiyBwdbtErIpCnkLiigwdwId/Pg==
X-Received: by 2002:a17:906:5f8a:b0:7ad:ca14:3ae with SMTP id a10-20020a1709065f8a00b007adca1403aemr36671412eju.509.1667725944828;
        Sun, 06 Nov 2022 01:12:24 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7cc03000000b00461aebb2fe2sm2356015edt.54.2022.11.06.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:12:24 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 3/6] staging: media: Add support for the Allwinner A31 ISP
Date:   Sun, 06 Nov 2022 10:12:22 +0100
Message-ID: <2320492.NG923GbCHz@jernej-laptop>
In-Reply-To: <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com> <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 03. november 2022 ob 17:37:14 CET je Paul Kocialkowski=20
napisal(a):
> Some Allwinner platforms come with an Image Signal Processor, which
> supports various features in order to enhance and transform data
> received by image sensors into good-looking pictures. In most cases,
> the data is raw bayer, which gets internally converted to RGB and
> finally YUV, which is what the hardware produces.
>=20
> This driver supports ISPs that are similar to the A31 ISP, which was
> the first standalone ISP found in Allwinner platforms. Simpler ISP
> blocks were found in the A10 and A20, where they are tied to a CSI
> controller. Newer generations of Allwinner SoCs (starting with the
> H6, H616, etc) come with a new camera subsystem and revised ISP.
> Even though these previous and next-generation ISPs are somewhat
> similar to the A31 ISP, they have enough significant differences to
> be out of the scope of this driver.
>=20
> While the ISP supports many features, including 3A and many
> enhancement blocks, this implementation is limited to the following:
> - V3s (V3/S3) platform support;
> - Bayer media bus formats as input;
> - Semi-planar YUV (NV12/NV21) as output;
> - Debayering with per-component gain and offset configuration;
> - 2D noise filtering with configurable coefficients.
>=20
> Since many features are missing from the associated uAPI, the driver
> is aimed to integrate staging until all features are properly
> described.
>=20
> On the technical side, it uses the v4l2 and media controller APIs,
> with a video node for capture, a processor subdev and a video node
> for parameters submission. A specific uAPI structure and associated
> v4l2 meta format are used to configure parameters of the supported
> modules.
>=20
> One particular thing about the hardware is that configuration for
> module registers needs to be stored in a DMA buffer and gets copied
> to actual registers by the hardware at the next vsync, when instructed
> by a flag. This is handled by the "state" mechanism in the driver.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

This is pretty complex piece of code, so I trust you that it's tested.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


