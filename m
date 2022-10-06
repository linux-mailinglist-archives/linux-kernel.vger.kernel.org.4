Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5E5F6600
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJFM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJFM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:27:57 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247AAB85E;
        Thu,  6 Oct 2022 05:27:57 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id s192so1832972oie.3;
        Thu, 06 Oct 2022 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IivXsPp5lB5UeXK+nUb21Vu9wuwXJqHD7QS9qHFH17M=;
        b=c/MbcbpS33CpNHuGjD7Os9bjbk4Y8TctPJU/nW5teyWnR0fz3uYYpeEMVkTRATn7nn
         J3sif4eNc803gUzTO7zQJcfHhK8k2Myg4uI4uOmfR3Mda8Tj6XEMExglAiM1k2hmdchD
         s+sqDcBC7PF/YRN5HT2v80bQWuvqngqkFYoMXMnvZTgX0ATMk7s0Zou2orggFKpzrhAy
         XoiVIckRhlE2LUqEbb2CsKoBJ5ESstGBy+xzt3D6rx9FNJaBInvXnlhL12tILec2c/FA
         utmA3Zdt30PpTskTtMFL289+/cXlF1/NT3yUpyGQaT3wZztg5FDY75tPbaWQyBFjMNQw
         GjZw==
X-Gm-Message-State: ACrzQf2KV1oNRrjWWlaCyQnE7DGlg5TBeUk0JjSptja8BEFNzY9cN6tf
        0ObGG6jItMvc62zn/M6T9w==
X-Google-Smtp-Source: AMsMyM6v4daLPkZQEVW4dBm3lahUxfM8urW8wX2Qa4pW/2l5uyythd5T/wl5E/sb0t6hvvgholskYA==
X-Received: by 2002:a54:4485:0:b0:34f:b741:9932 with SMTP id v5-20020a544485000000b0034fb7419932mr2235426oiv.42.1665059276383;
        Thu, 06 Oct 2022 05:27:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a056870d28f00b00132218cb7afsm5706785oae.42.2022.10.06.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:27:55 -0700 (PDT)
Received: (nullmailer pid 1613448 invoked by uid 1000);
        Thu, 06 Oct 2022 12:27:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>
In-Reply-To: <20221006020444.15823-2-allen.chen@ite.com.tw>
References: <20221006020444.15823-1-allen.chen@ite.com.tw> <20221006020444.15823-2-allen.chen@ite.com.tw>
Message-Id: <166505880800.1601475.16626115923147161854.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: it6505: add properties to restrict output bandwidth
Date:   Thu, 06 Oct 2022 07:27:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 10:04:43 +0800, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml: properties:ite,dp-output-max-pixel-clock-mhz: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

