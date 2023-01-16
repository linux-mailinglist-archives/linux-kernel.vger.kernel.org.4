Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37C66BB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAPKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjAPKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:04:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C68193F2;
        Mon, 16 Jan 2023 02:04:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z5so25868841wrt.6;
        Mon, 16 Jan 2023 02:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbIO2N193nCzeMIACK0SFaSPQ5nzZU2nDgITnTHRxbs=;
        b=dJxMfLb2RB28pwZidieiXoi0wehiMuiOL+2IskQXY3CwWbNYpwokm2jYhlL+kJRMHC
         8yZc2XvMvrUNFMxJ4caAGN/mx6hqU78vIvjWrPcEbft6/FlafkYoVcyW27N665yi65JX
         NzTiv9c4j7dxdF7dD8j5y2fuYKNhv87s1r9eZug/53kZyBcQBOuyKicRqkv4Kz2R6PCm
         UIiEfEPonuyJqQEG4SV7MegYgPi4UBmySkISbEzUoJW8bEFOTysvCi8y0E/2MVfZLCUB
         v7HRamfMvHd+4vZ3qT2/6G6LS8WgmBtVw5f0/gnALeJi/HvMw9ZiVkUuP29rSilM5RF8
         NZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbIO2N193nCzeMIACK0SFaSPQ5nzZU2nDgITnTHRxbs=;
        b=xVct2IXKf89ENUso4UXco3emNdzdd5F+ReQx+SEkfg77DNlEqEzLt6dpaADwketkxy
         Xkjdnts8c+B9Oz5SNzaOHuQHDs+dGHUSdsJizQ7hafa/3m1cwXH9FG1Uh2N0ec7/FYYV
         JPW5+J1+sfQiGzFOJvr+Kc4JJLBgFtVXDoj7sOfUY4DijT4KoxbhHMhnS5m+y5xFpYCz
         SZY5T9wAcROj5BxZRPc1T3LLZvYPzBAqXoztBVuMQrCaj+iGrK2BTy53s1QGv0cUazU1
         oCdN4PWDc7Gm/9qFXHgvELimkGd4yfW6OrWq+a90/60CkA4SLbx6RByS208DsrzldyW0
         67eA==
X-Gm-Message-State: AFqh2kpwjdInXAtA+pek6gUcAvppbP69XfHtC1yPRGqew/KBaaJfwt8R
        801Ocyb97HYJN7rbTu47+O4=
X-Google-Smtp-Source: AMrXdXuO/QQxJ4KmNkv0K3j6obl3Gx0l62TtiA7hL2J3w+HhEH7U1sE7KprVVzcaS9WniUcCeKw9mw==
X-Received: by 2002:adf:b608:0:b0:2bd:d76f:23eb with SMTP id f8-20020adfb608000000b002bdd76f23ebmr6745487wre.29.1673863467887;
        Mon, 16 Jan 2023 02:04:27 -0800 (PST)
Received: from localhost.localdomain (mm-88-61-120-178.brest.dynamic.pppoe.byfly.by. [178.120.61.88])
        by smtp.gmail.com with ESMTPSA id bq14-20020a5d5a0e000000b002bdf2739cabsm5856220wrb.1.2023.01.16.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 02:04:27 -0800 (PST)
From:   Oleg Verych <olecom@gmail.com>
To:     wens@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, mripard@kernel.org,
        robh+dt@kernel.org, sakari.ailus@linux.intel.com, wens@csie.org,
        Oleg Verych <olecom@gmail.com>
Subject: Re: [PATCH 04/14] media: sun4i-csi: Fix [HV]sync polarity handling
Date:   Mon, 16 Jan 2023 13:03:59 +0300
Message-Id: <20230116100359.4479-1-olecom@gmail.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20191215165924.28314-5-wens@kernel.org>
References: <20191215165924.28314-5-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chen-Yu Tsai

> -	hsync_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH);
> -	vsync_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH);
> +	/*
> +	 * This hardware uses [HV]REF instead of [HV]SYNC. Based on the
> +	 * provided timing diagrams in the manual, positive polarity
> +	 * equals active high [HV]REF.
> +	 *
> +	 * When the back porch is 0, [HV]REF is more or less equivalent
> +	 * to [HV]SYNC inverted.
> +	 */
> +	href_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_LOW);
> +	vref_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_LOW);

After this change has been made there is a need of explicit explanation
of what "Active high" / "Active low" in dts really mean.

Currently physical high/low voltage levels are like that:
(I'm not sure about vsync-active)

* hsync-active = <0>; /* HSYNC active 'low' => wire active is 'high' */
  CSI register setting: href_pol: 1,

That is confusing:

[PATCH v6 5/5] DO NOT MERGE: ARM: dts: bananapi: Add Camera support
https://lore.kernel.org/linux-arm-kernel/cf0e40b0bca9219d2bb023a5b7f23bad8baba1e5.1562847292.git-series.maxime.ripard@bootlin.com/#r

> +	port {
> +		csi_from_ov5640: endpoint {
> +                        remote-endpoint = <&ov5640_to_csi>;
> +                        bus-width = <8>;
> +                        hsync-active = <1>; /* Active high */

original CSI driver

> +                        vsync-active = <0>; /* Active low */
> +                        data-active = <1>;  /* Active high */
> +                        pclk-sample = <1>;  /* Rising */
> +                };
> +	};

[PATCH 13/14] [DO NOT MERGE] ARM: dts: sun7i: cubieboard2: Enable OV7670 camera on CSI1
https://lore.kernel.org/linux-arm-kernel/20191215165924.28314-14-wens@kernel.org/

> +	port {
> +		/* Parallel bus endpoint */
> +		csi_from_ov7670: endpoint {
> +			remote-endpoint = <&ov7670_to_csi>;
> +			bus-width = <8>;
> +			/* driver is broken */
> +			hsync-active = <0>; /* Active high */

this change patchset

> +			vsync-active = <1>; /* Active high */
> +			data-active = <1>;  /* Active high */
> +			pclk-sample = <1>;  /* Rising */
> +		};

> +			ov7670_to_csi: endpoint {
> +				remote-endpoint = <&csi_from_ov7670>;
> +				bus-width = <8>;
> +				hsync-active = <1>; /* Active high */

this patcheset

> +				vsync-active = <1>; /* Active high */
> +				data-active = <1>;  /* Active high */
> +				pclk-sample = <1>;  /* Rising */
> +			};
> +		};
