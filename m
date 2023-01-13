Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA8669EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAMQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjAMQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:48:46 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D36ECB8;
        Fri, 13 Jan 2023 08:46:19 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id r132so7561149oif.10;
        Fri, 13 Jan 2023 08:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuYGM5xxgSpVt2SshCQN8JM0QSvRbusS4+7wjpXp+iw=;
        b=oLcNTCTFXTWPndW626haFCrCFa6y3nkzlIO7I2oNrPAjw2SFgdgj3dKUEEnXpEC3yi
         PsFgPsU7a1C24IZr2J4681POn6BPlFj+U+aCgEQHoQib4Qw3aCBuVd2b0afNuawoVVku
         RHaq/dAw4UGdF0byRxxvt6AnjEA65TozC+lJZxW0E9wuDKjwNXmnHwvrvoMy/PFo1mr1
         eFXmD5FwHjpZ8NMpRIhZ57cXIH2eTU4vhRE4dxkltkPSyE1fHBsB5eOl7TgGTER/53X7
         hdSYCbe26nQTY/I6y7FqPaMNdc2LZZTXwohdYzPNkdCTMHxGp2UX/4CE66EzKeSHKamJ
         Wvug==
X-Gm-Message-State: AFqh2ko3r5va4HOuzKmyhyvdtXa8j9erSEuaykD5bg5pkSoVw8AJQCG4
        /NqbHu4YNF2cnEW12tFPGA==
X-Google-Smtp-Source: AMrXdXv5q+MKQguVvhn/MeERISvFu/aJ07yG2Y++7z30CokWEYQNareqHHYHvXp2723AU/ZOiHMEJQ==
X-Received: by 2002:aca:4406:0:b0:364:6230:ee4c with SMTP id r6-20020aca4406000000b003646230ee4cmr4415875oia.37.1673628378519;
        Fri, 13 Jan 2023 08:46:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r16-20020a0568080ab000b0035bce2a39c7sm9350347oij.21.2023.01.13.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:46:18 -0800 (PST)
Received: (nullmailer pid 2377411 invoked by uid 1000);
        Fri, 13 Jan 2023 16:46:17 -0000
Date:   Fri, 13 Jan 2023 10:46:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        ", Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH V2 3/6] dt-bindings: nvmem: convert U-Boot env vars to
 NVMEM layout
Message-ID: <167362837658.2377356.15364092039384096184.robh@kernel.org>
References: <20230111073102.8147-1-zajec5@gmail.com>
 <20230111073102.8147-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111073102.8147-3-zajec5@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 08:30:59 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables can be found of various underlaying storage
> entities. This binding should be defined as a layout on top on NVMEM
> device not a NVMEM device itself.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
>  .../nvmem/{ => layouts}/u-boot,env.yaml       | 29 ++++++++++---------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 17 insertions(+), 15 deletions(-)
>  rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (77%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
