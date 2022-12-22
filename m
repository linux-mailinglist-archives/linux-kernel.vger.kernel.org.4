Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9C6546B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiLVTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiLVTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:33:28 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A51902C;
        Thu, 22 Dec 2022 11:33:27 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id c129so2833021oia.0;
        Thu, 22 Dec 2022 11:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYZuAOCMovMvktU5KUPbfgtaY37Eb8Oc8FmMFnt3Lvc=;
        b=mcAguDuK5avfJxm8WYNxDPJ8K1vwdb0ShvablK3ss9VR1/dFmm+wn/H7fe0eN0AwUe
         LiPi1P+f+s+20jQLMKjUi4SvjrSAS2h/vI4rs9pNOaEJsGVLztL7wCl97Cj39i2QLgTx
         sPxLRmFy1wXbb9J3dZ8R7nf8yizYxPBvDmet6aFEqB0VFCqwJQm4xMRF7tCcaITiODUV
         EKBGpje8qGcfzlrNbQGBdPTA/wPGeKWcdHmvfWUsNNstYgq+/CDyglaKyPW45r8E937a
         v/qZoXOr+HqLbyWMaB9huDwkE3cUR0kGeIfgaDtbgezdPgSuaP394k48tev3jii3XM/L
         eYXQ==
X-Gm-Message-State: AFqh2kqBNHobVq+5VWrHFbLspE3viHoMhbRjVM04U497fMfJuzKKP4G+
        smTMQ2009QAB9MtvfCWSySpkh7qN6w==
X-Google-Smtp-Source: AMrXdXv/kgIlpx844AJKnleHRaPETuExD06FHseWyuKu9K1+X9Ay09uxx4A14i873JeeiGCBmoHlhA==
X-Received: by 2002:a05:6808:190e:b0:35c:b79:8cf8 with SMTP id bf14-20020a056808190e00b0035c0b798cf8mr3875792oib.6.1671737606641;
        Thu, 22 Dec 2022 11:33:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n67-20020acabd46000000b0035b451d80afsm651127oif.58.2022.12.22.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:33:26 -0800 (PST)
Received: (nullmailer pid 1948183 invoked by uid 1000);
        Thu, 22 Dec 2022 19:33:25 -0000
Date:   Thu, 22 Dec 2022 13:33:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        inki.dae@samsung.com, hjc@rock-chips.com,
        linux-rockchip@lists.infradead.org, neil.armstrong@linaro.org,
        gregkh@linuxfoundation.org, andrzej.hajda@intel.com,
        linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com,
        philippe.cornu@foss.st.com, jernej.skrabec@gmail.com,
        airlied@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, dri-devel@lists.freedesktop.org,
        sw0312.kim@samsung.com, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, daniel@ffwll.ch, heiko@sntech.de,
        linux-usb@vger.kernel.org, jonas@kwiboo.se,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 03/17] dt-bindings: display: dsi-controller: move
 clock-master property
Message-ID: <167173760428.1948132.16098364997799838917.robh@kernel.org>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <1c3b18ad-350f-e862-de98-a775e11e132c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3b18ad-350f-e862-de98-a775e11e132c@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 15:24:51 +0100, Johan Jonker wrote:
> The clock-master property is used for the controller and not in the panel,
> so move it there.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/display/dsi-controller.yaml       | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
