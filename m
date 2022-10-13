Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66445FDDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJMPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:55:43 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E53B1DC4;
        Thu, 13 Oct 2022 08:55:38 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l5so2179558oif.7;
        Thu, 13 Oct 2022 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYclH+AU0uDsjdL9yX3maHxQPLG1CbVvXWtgf7N5YNw=;
        b=BLSsbL9ECOKW46IPgEQXcMzsSWvEfNf8WH38+B6J7iksTuyABU8b3Kh32IwAEL2BIy
         ngfDSafq6cFNlAyHfb55JlPAujtk9gj+n7F9meybsExq0m8MWGIpLvPorAf+xpzkE6/7
         eKY3tuOo8LklYiGjKNX1Cd9MERC5fZYhUguPHV3OrcY/XFhVjBP3fL5kWqrsE4ZVdSo4
         dzdFTYHZLcvxlTMDBDTfW+8Qoyj8Lu5Z/7VCqTI7NIPTMSztS5KmTFMVwUqy0o5tIyWW
         OppVE4Ibq06WM6AZco8YOovAruf87iiGyxQK6XRdZS2SY04qksa5Lug+bF0ruEfEA+DU
         OiiQ==
X-Gm-Message-State: ACrzQf2xXRsG4YSVFYifPPK3ghcg0mdNyE3X07twFfa1ymgm4zjgyIey
        b4NGQ5eXN1drHJZDrk+anyp34u9YmQ==
X-Google-Smtp-Source: AMsMyM6dDBIHv8Xu07nccWXkNNxJlTQAuUDsjISsABDxijdxjs4YI+QAHzD67QDw6sWTrqJBhEavmQ==
X-Received: by 2002:a05:6808:282:b0:354:9454:af5b with SMTP id z2-20020a056808028200b003549454af5bmr228146oic.20.1665676537881;
        Thu, 13 Oct 2022 08:55:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a056830418600b00661b6e1eb3csm96328otu.38.2022.10.13.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:55:37 -0700 (PDT)
Received: (nullmailer pid 384630 invoked by uid 1000);
        Thu, 13 Oct 2022 15:55:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Pin-yen Lin <treapking@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <20221013105116.180380-2-allen.chen@ite.com.tw>
References: <20221013105116.180380-1-allen.chen@ite.com.tw> <20221013105116.180380-2-allen.chen@ite.com.tw>
Message-Id: <166567436493.334966.17548882165028995639.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: it6505: add properties to restrict output bandwidth
Date:   Thu, 13 Oct 2022 10:55:38 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 18:51:13 +0800, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml   | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dtb: dp-bridge@5c: port:endpoint: Unevaluated properties are not allowed ('link-frequencies' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

