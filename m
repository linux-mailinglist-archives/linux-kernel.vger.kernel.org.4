Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A041669EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjAMQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAMQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:49:40 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FF7188F;
        Fri, 13 Jan 2023 08:47:58 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15ed38a9b04so4217487fac.8;
        Fri, 13 Jan 2023 08:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcrFc4jdvlDwh9W9dFniLVotEshlIzTbEVTh7avnPjU=;
        b=TUYt6CQZqWQoYuWIYXbJ0cxxnZVT7eFiFW486vhKqvbzkdIwcHCNRehqlH7KQYjXVr
         cJDBkQglNRiX9WP0BvTtyxf+6W367nQChWw2Y4SeOIMW9DjWi+g7VtLpUk3TZ9xZzalg
         QZ+ZxylB35Fb/bCPuWc9sYi0pehfL7CHwXDZJJGhPkEKA/zusMcRnpIDBMq+BQG5vmAS
         oaVjghaayk8myORnb2fCnBQCF2tOkcVeXybmAmCLjnW92t347eVDaSnkO/AqO/ya6r/b
         +F7jwjnTltny+EF2+Cn5NUBlAx5Xa5dS1CgaxOCh6/yGObamMz7KysVsx/GT0KahSR7p
         1Z3g==
X-Gm-Message-State: AFqh2koaTcpwFS+LeXEsOl6wmThBnMT0vEkyh3riWQ5XeZKra9VA19+L
        /T0F++CojfrChvaOh91qHQ==
X-Google-Smtp-Source: AMrXdXv+k98p64UgHJm4EP5V4/yJKF55uhIGbsy/sWBBjdpj1YQAUec/vQvkLdsRb85rPqzUQqOsWA==
X-Received: by 2002:a05:6870:d79f:b0:158:450f:1cc1 with SMTP id bd31-20020a056870d79f00b00158450f1cc1mr11184186oab.45.1673628472454;
        Fri, 13 Jan 2023 08:47:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id er14-20020a056870c88e00b0013bc40b09dasm10676115oab.17.2023.01.13.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:47:52 -0800 (PST)
Received: (nullmailer pid 2379179 invoked by uid 1000);
        Fri, 13 Jan 2023 16:47:51 -0000
Date:   Fri, 13 Jan 2023 10:47:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>, u-boot@lists.denx.de,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH V2 5/6] dt-bindings: nvmem: u-boot,env: add MAC's
 #nvmem-cell-cells
Message-ID: <167362844818.2378726.12657196612848519101.robh@kernel.org>
References: <20230111073102.8147-1-zajec5@gmail.com>
 <20230111073102.8147-5-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111073102.8147-5-zajec5@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 08:31:01 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot's "ethaddr" environment variable is very often used to store
> *base* MAC address. It's used as a base for calculating addresses for
> multiple interfaces. It's done by adding proper values. Actual offsets
> are picked by manufacturers and vary across devices.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
