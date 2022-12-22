Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23065471B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLVU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLVU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:27:23 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6285411802;
        Thu, 22 Dec 2022 12:27:22 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s186so2910642oia.5;
        Thu, 22 Dec 2022 12:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifO+UAb4xNHYoZtmeqbH6nY6NZq3pB8gzBwpCbepYe8=;
        b=MxtE/Pl8qZIvgB0ej88cLB+wsombumY6+bPlFoH6laKG8CB9OTMeHMESYa7a9ODFns
         LJ/FQIMP6UXoeKooSRm8uG3ifk8aShdbjXAjj5rF3b2ahBo/JEWxsXLdN5j2M/6Iu5eT
         m6K8fAGMbzmd3SJM0h4t2hNKEsQdbCmbBE9Zt8rAi5hPjADERVGwcAQXqkM9kDi4LgvZ
         gIe8wyXtv4M2Nk0CbP18svXRYbv+D5/7r2xOfEMr59Y46u5oA0FzYYVCLKPVDVbJVaUy
         SD1mCDBG0un0bof/NOyw14S+IzzMAmVlthRO4X27I9Lxj9vyMttvuOAJen8muCy5yNy3
         m5yg==
X-Gm-Message-State: AFqh2kpEbEMtHfnd8Kal/E2VzplI0zYDPqQx8PB0pC+VxrNzuGtfLFUo
        7NAzSAqlAvcxiXld0sEIyg==
X-Google-Smtp-Source: AMrXdXsNV2YU4gEBnEdlry3c9jg4+8vMg41WSp11kX/VLN3MsjK7Vxqq46+/Co64urW6ujdTjBb0Fg==
X-Received: by 2002:aca:3205:0:b0:35e:b08e:13e with SMTP id y5-20020aca3205000000b0035eb08e013emr8711520oiy.18.1671740841648;
        Thu, 22 Dec 2022 12:27:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l1-20020a05687014c100b0013b92b3ac64sm687863oab.3.2022.12.22.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:27:21 -0800 (PST)
Received: (nullmailer pid 2067521 invoked by uid 1000);
        Thu, 22 Dec 2022 20:27:19 -0000
Date:   Thu, 22 Dec 2022 14:27:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     inki.dae@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel@ffwll.ch,
        kyungmin.park@samsung.com, airlied@gmail.com, robh+dt@kernel.org,
        alim.akhtar@samsung.com, sw0312.kim@samsung.com,
        linux-samsung-soc@vger.kernel.org, jernej.skrabec@gmail.com,
        robert.foss@linaro.org, linus.walleij@linaro.org, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        andrzej.hajda@intel.com, hjc@rock-chips.com,
        neil.armstrong@linaro.org, philippe.cornu@foss.st.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 07/17] dt-bindings: display: rockchip: convert
 analogix_dp-rockchip.txt to yaml
Message-ID: <167174083761.2067426.17125312795413534693.robh@kernel.org>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <88a5a9e3-9bc8-5966-22ec-5bdb1fa7a5b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a5a9e3-9bc8-5966-22ec-5bdb1fa7a5b1@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 15:27:35 +0100, Johan Jonker wrote:
> Convert analogix_dp-rockchip.txt to yaml.
> 
> Changed:
>   Add power-domains property
>   File name
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../display/rockchip/analogix_dp-rockchip.txt |  98 -----------------
>  .../rockchip/rockchip,analogix-dp.yaml        | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
