Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB865244C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLTQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiLTQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:06:56 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1A1DA60;
        Tue, 20 Dec 2022 08:06:02 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id k7-20020a056830168700b0067832816190so2569900otr.1;
        Tue, 20 Dec 2022 08:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8YG3bJMRRAs+4R88/SEWWX5CeSnSiZ81eWgJ4ufJLU=;
        b=oeQswiBC13kBL6AcPCVBL6aEUt3mfScswJjFbvy2R5z14KAaOnVu/o2EIOUZx1lhER
         9XgZkNGd/wYkSz7xQ4axGTxKY+9eGTFTWiHrUJde526gEBslM+0nwcnY7fq9UtQ4QIZa
         +PZh34N4w2sPyO5GdqDWMK5Pb1skGsyv1mjy/jUN6vugEhyyLyVs3aTcrJlgbPGvN06E
         4fYsRRfZrQejsHuT6SxUx55k/4niKisF7Qqwhc4PoWpBGqyQEjOlRV08IAoCnP+iEScg
         q63iSVHd5vLjayx4NGg6h2KnuBIoLFfmWm7JNCP1gcKHvsrjw3xGV9bmeOwV+TUW/Vxk
         srOw==
X-Gm-Message-State: ANoB5plhAOyeYIHSiWTI+Ln/bqvvk3432lXt4lXna795LIc+MmdIhFSi
        VR5BQUPD05NNT2CMbRcund3UNnKwNg==
X-Google-Smtp-Source: AA0mqf4tF/ZFxy5NOQx96hQL7bxwIeaLFezvzgFmcVU3atu70GP5RGx1Qg1PVYgEEW9vY6fEOhgs1Q==
X-Received: by 2002:a05:6830:4cd:b0:670:73fc:fa3c with SMTP id s13-20020a05683004cd00b0067073fcfa3cmr17408144otd.36.1671552360486;
        Tue, 20 Dec 2022 08:06:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v15-20020a05683018cf00b0066c3bbe927esm5798631ote.21.2022.12.20.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:05:59 -0800 (PST)
Received: (nullmailer pid 635046 invoked by uid 1000);
        Tue, 20 Dec 2022 16:05:58 -0000
Date:   Tue, 20 Dec 2022 10:05:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kishon@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        vkoul@kernel.org, dri-devel@lists.freedesktop.org,
        hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, linux-phy@lists.infradead.org, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Message-ID: <167155235801.634980.18150426131189597701.robh@kernel.org>
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
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


On Mon, 19 Dec 2022 17:54:16 +0100, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
>   Filename matching compatible style
>   Drop "Regulator phandle for "
>   Specify properties and requirements per SoC
>   Sort order and restyle
> 
> Changed V2:
>   Fix title
> ---
>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>  2 files changed, 170 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
