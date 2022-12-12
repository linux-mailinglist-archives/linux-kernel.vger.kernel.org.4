Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5453E649799
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiLLBGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiLLBG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:06:27 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABDD2CC;
        Sun, 11 Dec 2022 17:06:24 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r11so9877199oie.13;
        Sun, 11 Dec 2022 17:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R095u0ECY7gduOhAdXH+aBPULHXe+RvaEl97K29Dlbc=;
        b=FCu9qVw9rnxLY/OF46HQyUUqxQrT4krC9E0ukCswU/VoCxeQEa5ZuUGpkKab9cIKWf
         kuucKOWNTzYCVN2FhSJAjFayaVUtkVWLoFFrIpV+lUuvNghpfCavojStLZ6Aa07HC+rQ
         5Ikf6IoC4f71T850u1q3FekHYLn31NvhQ+Mhn5nOua96k6Svd/lkJCxoBJ8ozkQF3NBG
         mbz1EmviGUQdriOZvzsuQUoN6HCtbCxHqegry9GIacBcocWW8Lk7LZT+cpNLz+0CvGkT
         hr26A8CofXXJ3nSO6P9fbcclBoqqjfN2w8dV1CidZVNv1Od53PZ3dzLreSulF2kWnB2o
         PbwQ==
X-Gm-Message-State: ANoB5pkNPemQWzhFG7bOo7nZGodh8l0fCA9eMagOanEw1fFkoTTj9Z0o
        QAc4jNzkK8wQEk00eTcQ2g==
X-Google-Smtp-Source: AA0mqf4/W5qvcKB1Y2rauksdOsUJfiC/Fln3B+N4KfJRRrTkSuCiywO02EfmqJ0oV5OYPEYAUPOi1w==
X-Received: by 2002:aca:db42:0:b0:35e:563:e0d6 with SMTP id s63-20020acadb42000000b0035e0563e0d6mr5827297oig.38.1670807183387;
        Sun, 11 Dec 2022 17:06:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a05680802ce00b0035763a9a36csm83036oid.44.2022.12.11.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 17:06:23 -0800 (PST)
Received: (nullmailer pid 4116798 invoked by uid 1000);
        Mon, 12 Dec 2022 01:06:22 -0000
Date:   Sun, 11 Dec 2022 19:06:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Yi Xin <Yixin.zhu@intel.com>
Subject: Re: [PATCH 2/2] dt-bindings: leds: Add missing references to common
 LED schema
Message-ID: <167080717944.4116695.13591532895115517569.robh@kernel.org>
References: <20221207204327.2810001-1-robh@kernel.org>
 <20221207204327.2810001-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207204327.2810001-2-robh@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:43:27 -0600, Rob Herring wrote:
> 'led' nodes should have a reference to LED common.yaml schema. Add it where
> missing and drop any duplicate properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-lgm.yaml       |  3 ++-
>  .../devicetree/bindings/leds/leds-max77650.yaml  |  9 ++-------
>  .../bindings/leds/rohm,bd71828-leds.yaml         | 16 +++-------------
>  3 files changed, 7 insertions(+), 21 deletions(-)
> 

Applied, thanks!
