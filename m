Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F368E251
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBGUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBGUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:54:47 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF3402FA;
        Tue,  7 Feb 2023 12:54:13 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id j21so13764115oie.4;
        Tue, 07 Feb 2023 12:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG1dkQbvjDItv2L+Miw1rSt0efQ50QIrV6acj+RBGA0=;
        b=Pb5HlpWt0VnQClymK4p0+Cdo7y5OOkxdqXMAsJNVViQPPYcelldhwSt/K9FpoNQ6/W
         ZHouJmY1sFbq+gS1Jh4pj9ciHVNyV6LDb2Vpelw0BJD1j8r4uh4CnonPiMv3ymPNfPnQ
         JljHsGNnDo4Rh+D5lnEid/UrNnxIoUEvAxpcdIgHFqFpg8Y3Q6vTHKdmzJQZtofuV69v
         1qKtYKTjbHvgbKRR09W3j/V53DA3hmJGX2racydjAJEZ5xHTOx2fFoCLypR23TBrk4Fh
         AUaewMM22yr2HY1Wv4wmeDBe8zqCLGe0USC8Qd+x+O4Ni4Oll6MMDs/rDpiMm4whEpri
         7zZA==
X-Gm-Message-State: AO0yUKVvoA15ejAy16EBhSFSx/6hHI5uO/rY10JWtynRUmYzGM0e5jBX
        nBf1/ZqJDesWyLbz22KOfg==
X-Google-Smtp-Source: AK7set/0vSNAvhopmd8vgvuz2HXxNJD6l+0qvCpVo6Pu4PixiCMDs8mv6MJYq8tIE8A1X5lt+F3XRg==
X-Received: by 2002:a05:6808:b3a:b0:378:974b:4fe6 with SMTP id t26-20020a0568080b3a00b00378974b4fe6mr2084995oij.8.1675803253067;
        Tue, 07 Feb 2023 12:54:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j24-20020a056808035800b003436fa2c23bsm6123653oie.7.2023.02.07.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:54:12 -0800 (PST)
Received: (nullmailer pid 4137996 invoked by uid 1000);
        Tue, 07 Feb 2023 20:54:12 -0000
Date:   Tue, 7 Feb 2023 14:54:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp-usb3-dp: document sm8350
 & sm8450 compatible
Message-ID: <167580325163.4137958.14459903168469624324.robh@kernel.org>
References: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-0-ed849ae6b849@linaro.org>
 <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-1-ed849ae6b849@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-1-ed849ae6b849@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 10:58:56 +0100, Neil Armstrong wrote:
> Document the USB3/DP Combo PHY compatible found on the SM8350 & SM8450 SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

