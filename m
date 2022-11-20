Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09F6312BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKTGw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 01:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTGwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 01:52:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AE93737
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 22:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE58160BD8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18448C4314B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668927140;
        bh=unX76QKH95pBc8VMtK0DMu4SdkXMf/gkRIw9iatMLXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JHz0T5yDc36FyNAnp++6tNSmk6dj1fmNPPnFwJ/GbuaQ5q+FbAixvEvnzapVM1GYU
         5BKSSHWhZFtzPt9KD0aUDPusKHcMmZ6svhGnlD+8BSAkbrTd6UQ+qmVmNf1PNPU5wt
         ckoa/XLszalnfnAKop2Rz+R+BdBvTymcRJFw/VyYu4e0VrkLidpTckYQrGdRmsuOVX
         yBP0Knq9FCx/CFlh4OB/xK/ZgCN1cCA86mYSFLr8YkRH8Ar92R1SouSnum0pYGwajX
         KQuBfi9ikzeC6O4tGvw2yv48N4dOPjcVTpbzzaqbDd+amWFylJXATpm+C+f1EEid4w
         Bycke5StjDlnQ==
Received: by mail-vk1-f174.google.com with SMTP id j24so4323416vkk.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 22:52:20 -0800 (PST)
X-Gm-Message-State: ANoB5pnp7sz0+8IgMxyeEDPTK+Rp7sab7ZvlH7lvuyGt/54g70F3jcsE
        eaUBf90AuxGc+vUMtArXHOZvAgnDAjelgfDSGnklQQ==
X-Google-Smtp-Source: AA0mqf5arwI+1Ek3mx3soz8ohE6WHnF+dcjdCqRzErREao2c5D+qmuXG9A9UQ0DaiieR0JHZqysHYs4Di4jY3Ome4F4=
X-Received: by 2002:a1f:5f50:0:b0:3ae:dce4:457 with SMTP id
 t77-20020a1f5f50000000b003aedce40457mr7127292vkb.26.1668927138878; Sat, 19
 Nov 2022 22:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-tsens-v1-0-0e169822830f@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Sun, 20 Nov 2022 12:22:07 +0530
X-Gmail-Original-Message-ID: <CAHLCerPKz9cP5di+8VeaLgO8mmh1Nj5x3fC70otyhPDONFVwaA@mail.gmail.com>
Message-ID: <CAHLCerPKz9cP5di+8VeaLgO8mmh1Nj5x3fC70otyhPDONFVwaA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Add compatible for sm8550
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 3:40 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The Qualcomm SM8550 platform has three instances of the tsens block,
> add a compatible for these instances.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@somainline.org>
> To: Amit Kucheria <amitk@kernel.org>
> To: Thara Gopinath <thara.gopinath@gmail.com>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@linaro.org>
> To: Zhang Rui <rui.zhang@intel.com>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f0bd4b979e28..09dbd96d380e 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -58,6 +58,7 @@ properties:
>                - qcom,sm8250-tsens
>                - qcom,sm8350-tsens
>                - qcom,sm8450-tsens
> +              - qcom,sm8550-tsens
>            - const: qcom,tsens-v2
>
>        - description: v2 of TSENS with combined interrupt
>
> ---
> base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
> change-id: 20221114-narmstrong-sm8550-upstream-tsens-dfaec218c321
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
