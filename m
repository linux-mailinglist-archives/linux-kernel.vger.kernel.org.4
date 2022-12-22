Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904E654715
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLVU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLVU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:26:28 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9E664D0;
        Thu, 22 Dec 2022 12:26:26 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id k7-20020a056830168700b0067832816190so1747780otr.1;
        Thu, 22 Dec 2022 12:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bNa5Kdmcwa+mXleBewekipXDfwkrNZzap+jetEOYl8=;
        b=w/hCYbDPqaCKmk7aUtAtMVcDSfW9nmmQV1k6xohtgrkHVkzWb4GoifuxuFfU5gVxlH
         H8OTizlNhsM/mcXS8g8nkkYHbL+wTUjJ1rCcjcc5kbLH6Rmlh/OL4oi4QLp2G9PIT768
         PKg0mo/VTqytjQg7mDXUTl91lXCNjJfyEUhjG3W4vCLp7+anPOOAJyKhrxKyU8G6r5FC
         04iX1kMiD9AHyde2ej+lqepyFoZ5a1p3jFMABbEpu8xj6SGgvVDkVzBUkYM6OwIltr2H
         5bUjAHWg9DEkHQMxiY3uwKgkpT/BlE6VC2Nur6cyfQ6EWobMATDi+AUhoMOHLwA+2WfP
         h3BA==
X-Gm-Message-State: AFqh2kp82GUlNzIM5jGf7G7ePTSq/opsQMj+OTaPIk1/sMkjEw+yOhx1
        6xapyJkQspT3VV1Q1+AnCw==
X-Google-Smtp-Source: AMrXdXucxOZJROMeEnqXizAa6bJGOHQA+pgTrIZbg3P5Tml16wuho1SX/QIVObL8GR/stBrcV9KKJw==
X-Received: by 2002:a9d:6389:0:b0:661:dfeb:a975 with SMTP id w9-20020a9d6389000000b00661dfeba975mr3595710otk.32.1671740785784;
        Thu, 22 Dec 2022 12:26:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e26-20020a9d6e1a000000b0066b9a6bf3bcsm758618otr.12.2022.12.22.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:26:25 -0800 (PST)
Received: (nullmailer pid 2066452 invoked by uid 1000);
        Thu, 22 Dec 2022 20:26:24 -0000
Date:   Thu, 22 Dec 2022 14:26:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     alim.akhtar@samsung.com, heiko@sntech.de,
        kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        philippe.cornu@foss.st.com, neil.armstrong@linaro.org,
        linux-usb@vger.kernel.org, jonas@kwiboo.se, daniel@ffwll.ch,
        robh+dt@kernel.org, airlied@gmail.com, andrzej.hajda@intel.com,
        hjc@rock-chips.com, jernej.skrabec@gmail.com,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-rockchip@lists.infradead.org,
        inki.dae@samsung.com, robert.foss@linaro.org,
        sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 06/17] dt-bindings: display: bridge: convert
 analogix_dp.txt to yaml
Message-ID: <167174078307.2066361.1514368429127273992.robh@kernel.org>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <489e7bd3-fa26-885f-4104-8b0b29aa4f2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489e7bd3-fa26-885f-4104-8b0b29aa4f2b@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 15:26:57 +0100, Johan Jonker wrote:
> Convert analogix_dp.txt to yaml for use as common document.
> 
> Changed:
>   Relexed requirements
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/display/bridge/analogix,dp.yaml  | 63 +++++++++++++++++++
>  .../bindings/display/bridge/analogix_dp.txt   | 51 ---------------
>  .../bindings/display/exynos/exynos_dp.txt     |  2 +-
>  3 files changed, 64 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
