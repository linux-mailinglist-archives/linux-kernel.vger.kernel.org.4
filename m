Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3B64352A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLEUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiLEUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:01:33 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D5E3;
        Mon,  5 Dec 2022 12:01:33 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-144bd860fdbso1616078fac.0;
        Mon, 05 Dec 2022 12:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSX39vKmXuqwX+fTD+qMgj/4K2o3+oTbZp823bxtf0I=;
        b=AhV0aT9Ehz+Vi5aIvCjEL+lmvko/ZSAu0KiiCWgTvEhn7PUFxrz5uLWIVIY/v9rrgT
         BIFk89LegF5Ym1nEuRJ8pFbRgU+ki/P92MnyobZfERAj9Ik/6ztgqH2aNKmjLFTYMbO+
         03gKa/c8fnJm0wH5oSUt8AtZZKteH/uOZMoRl1ZpikIGYpbnJOXTDwnC0q8RALwvNlaO
         J7MwsFMESXMLby902zmwpIngQO+jQ9V8c2Q1K0OgNGC8WRXzQBO+g5bHxJ7UkYbzJ7i3
         pF5aBvaiYloV3UgTxjGD2aImOF+BV0NkWa5T58QZJto8Wq0E7mNIxDV8rjje5n8WkTXC
         98ww==
X-Gm-Message-State: ANoB5pnVYxVtzO5oli4gZtMwIKasP3CllUY+OlMBc81Y69fu9vABsgkJ
        +gU9/bsFoSpCWvkhBGPzUYgAr4oxCQ==
X-Google-Smtp-Source: AA0mqf7OXOdswdIEFK3K6AKcJB+N4aK+DS5mjsDXBKv0xWYZIXbOXudLCFmGfWCu+kJS6Fhgrbq4HQ==
X-Received: by 2002:a05:6870:6c02:b0:143:80af:e36a with SMTP id na2-20020a0568706c0200b0014380afe36amr25413419oab.254.1670270492592;
        Mon, 05 Dec 2022 12:01:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y30-20020a9d22a1000000b0066ea9650da8sm3508174ota.20.2022.12.05.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:01:32 -0800 (PST)
Received: (nullmailer pid 2498426 invoked by uid 1000);
        Mon, 05 Dec 2022 20:01:31 -0000
Date:   Mon, 5 Dec 2022 14:01:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        agross@kernel.org, robdclark@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        david@ixit.cz, airlied@gmail.com, freedreno@lists.freedesktop.org,
        sean@poorly.run, swboyd@chromium.org,
        dri-devel@lists.freedesktop.org, andersson@kernel.org,
        dianders@chromium.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/18] dt-bindings: msm: dsi-controller-main: Add vdd*
 descriptions back in
Message-ID: <167027049028.2498344.6160191617059564658.robh@kernel.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-9-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125123638.823261-9-bryan.odonoghue@linaro.org>
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


On Fri, 25 Nov 2022 12:36:28 +0000, Bryan O'Donoghue wrote:
> When converting from .txt to .yaml we didn't include descriptions for the
> existing regulator supplies.
> 
> - vdd
> - vdda
> - vddio
> 
> Add those descriptions into the yaml now as they were prior to the
> conversion. In the .txt description we marked these regulators as required,
> however, that requirement appears to have been in error.
> 
> Taking the example of sc7180-trogdor-wormdingler.dtsi. The avdd and avee
> come from GPIO controlled external regulators, not the SoC and in this case
> there's no need for vddio to power an I/O bus. Similarly the regulators for
> the LCD are controlled by the panel driver not by the dsi-ctrl driver.
> 
> It would be possible to connect a different type of panel to the DSI bus
> here in which case we may or may not want to make use of vdd, vdda or
> vddio.
> 
> This is also the case for older chipsets like apq8064, msm8916 etc the vdd*
> regulators in the dsi-ctrl block are helpers not dependencies.
> 
> Add the description of vdd, vdda and vddio back in for the existing
> upstream dts where vdd, vdda or vddio are already declared but, don't
> declare those regulators required - they are not SoC requirements.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
