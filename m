Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2E6AFB22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCHAb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCHAbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:31:25 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CEA2C2B;
        Tue,  7 Mar 2023 16:31:24 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-176b48a9a05so9678212fac.0;
        Tue, 07 Mar 2023 16:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0N0vVa1h3Mrpxxp+FacYSNAxWlsrmv0a+CI104Imq8=;
        b=ZngcIuYwB7zC5vIRio8ty61B9QcuB/ocG3K0j4m5brWqNnhlHwKlNmqNdpeeJISqw2
         rvbi7r5IpA8Cs7wm1rqvclLT8FVZvuizse3eRaexise9kjdoQjcWF9uNUIaJeAHHm3KN
         pMlKhePorVCd6nTYuADbTSCZRIkQ8NCGAJrJ1chhO+4Iu6SiJvzM9+ntxRTI3Yc8usnv
         i98CN6FQXWg/Ll3f3nj9PDQmRqsRz5lnP6fu5XYYJUYYB0oIIFVZZBvwpzt0t0BaRWyg
         7G6j49s3JPJSkT+FoxmnQAMu+SXf3OFgqLc9VwbCfjiD2ivtCjklMp+hFND7rJh0idoY
         zKyg==
X-Gm-Message-State: AO0yUKUnfuWyDwkojjG8CLvh08G0TWwnOY4DD54GOm2h3EQF6xVlJWCj
        NAgKHwNn4BS1GKR/2M0m6g==
X-Google-Smtp-Source: AK7set8urRj86KjT6p6ca6TH+1d7WiTNHwu7LwngJMmJXYNx4lNvyYL4MUVFcNoMxtMf6owAX0HfHw==
X-Received: by 2002:a05:6870:14cc:b0:172:5b7b:19d6 with SMTP id l12-20020a05687014cc00b001725b7b19d6mr10893062oab.9.1678235483937;
        Tue, 07 Mar 2023 16:31:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x38-20020a4a97e9000000b005251f71250dsm5587810ooi.37.2023.03.07.16.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:31:23 -0800 (PST)
Received: (nullmailer pid 538253 invoked by uid 1000);
        Wed, 08 Mar 2023 00:31:22 -0000
Date:   Tue, 7 Mar 2023 18:31:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: display/bridge: toshiba,tc358764:
 convert to dtschema
Message-ID: <167823547806.538132.10458902840268879408.robh@kernel.org>
References: <20230225160252.18737-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225160252.18737-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Feb 2023 17:02:51 +0100, Krzysztof Kozlowski wrote:
> Convert the Toshiba TC358764 bridge bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../display/bridge/toshiba,tc358764.txt       | 35 --------
>  .../display/bridge/toshiba,tc358764.yaml      | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml
> 

Applied, thanks!

