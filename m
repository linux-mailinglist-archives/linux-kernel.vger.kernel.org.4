Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A30681E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjA3Wpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3Wpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:45:31 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43C55B5;
        Mon, 30 Jan 2023 14:45:30 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso4970184oti.10;
        Mon, 30 Jan 2023 14:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl5Si2GhIDsH6kxBYyiKSWExT/rTdUC4vy4aVHfukIs=;
        b=aCcEbg/Oo/rk4sZ5gbqhpNwKCuAdxEuUleMzi/Sc1nrtdTQcXdnuJyhFmHfNxeofry
         sa0Wv28D60spxJLFFfRgYu/4SEXVFHdZmVMc3PF9RRwNxFqTtjMYgOMKMq0dpNvIzIRk
         ecxSriW9cQ/Zq2qSDXjFeSdwmvwayzIiQfuOtl8xsITOoQWjWJ8VWGoIY33Nu4HN42T5
         2AIJ0Osm2ELqxZZxM8usYyKq8WEamGuCo8yeca9m95AEnJlkjFyRCyMp6SdeR9sLl4Jw
         bskUIFzxSt+Z7Vu0PgiPHN+aO6kWgt3Lg6mN11bSXBj+SAkZznyvl/UxUUULvfX3Xiab
         d/oQ==
X-Gm-Message-State: AFqh2krW3+GBhOEAIkVcKhHDZb4YRlNJlgsxzSIvCUnCATCJcYfUDMPD
        LGzcvzCdVvVgaSJmCJwXfQ==
X-Google-Smtp-Source: AMrXdXtb1f6y0s0BvCG7NQRNwf/Ax2t7nmaLT/0pkkZYz2bwokwIXbng60XbbCWFBezlRztymhKYVg==
X-Received: by 2002:a05:6830:6216:b0:66e:6e2d:77fd with SMTP id cd22-20020a056830621600b0066e6e2d77fdmr29205457otb.7.1675118729510;
        Mon, 30 Jan 2023 14:45:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s126-20020aca5e84000000b003645ec41412sm5159210oib.27.2023.01.30.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:45:29 -0800 (PST)
Received: (nullmailer pid 3663497 invoked by uid 1000);
        Mon, 30 Jan 2023 22:45:28 -0000
Date:   Mon, 30 Jan 2023 16:45:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     NXP Linux Team <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Guo <shawnguo@kernel.org>, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: media: i2c: add imx415 cmos image
 sensor
Message-ID: <167511872765.3663437.604082212385648435.robh@kernel.org>
References: <20230130084710.297004-1-michael.riesch@wolfvision.net>
 <20230130084710.297004-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130084710.297004-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 09:47:09 +0100, Michael Riesch wrote:
> Add devicetree binding for the Sony IMX415 CMOS image sensor.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v3:
>  - move description from clock-names to clocks
>  - drop clock-names property
>  - drop "link-frequencies: true" in endpoint description
> 
> v2:
>  - fix reference in port (must be /$defs/port-base)
>  - describe data-lanes in more detail
>  - remove unexpected property clock-lanes from example
>  - sort properties in example alphabetically
> 
>  .../bindings/media/i2c/sony,imx415.yaml       | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
