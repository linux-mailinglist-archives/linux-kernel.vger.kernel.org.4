Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C066881D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjAMAKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjAMAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:10:42 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE53FCBD;
        Thu, 12 Jan 2023 16:10:41 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so11468205otp.9;
        Thu, 12 Jan 2023 16:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa4bJd4FpH5J8PcBXntkqApcXjG667hIZgm37d7PnJs=;
        b=2YLw+2DLMPxDoMCRT/n64RQrktJBjAp1wf7MpAZiDhWPbxD3zpe7HbYB4iLQmuEh6V
         VS+TMEe3Q3bOllNUxZq5aoCXl9mxfqLIxoLnaxdTTKl5kzfz9SQD27vRQ20w7TfQQohV
         MDQyFpEAWoqE5UHNhdT/nGWzFnvwUkAjN+u/GpqhkA/SXVegBfrNHa0HxuEQadwpS0gB
         nOUvHia5SAtAahCngm0sdj/27BTAkxaLHjD7qBlTpjPrQ5cIIL0BLO7Vn56VTkWC06HF
         Wh6XBireilFdvMYqHi09RknFysKxtNZJBVjmMz+HoXW54KRk8OFarD4+NjPgb+YpyTnv
         h1ww==
X-Gm-Message-State: AFqh2kriSQIzoJncV59O3OBxS7gkG7OScnCjrIQD340O3ssJYB+rYnXc
        RP2cHbwiT209vPYbwLp9Pw==
X-Google-Smtp-Source: AMrXdXsCm+dOf8HVHiGAZD0eySI8muKiDK59xiObAtl+2yolg7B9eZifleapRpBiiS57/n3VNls3Og==
X-Received: by 2002:a05:6830:388c:b0:671:7bc7:dabe with SMTP id bq12-20020a056830388c00b006717bc7dabemr49626972otb.21.1673568640879;
        Thu, 12 Jan 2023 16:10:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e26-20020a0568301f3a00b006770e855c61sm439545oth.31.2023.01.12.16.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:10:40 -0800 (PST)
Received: (nullmailer pid 501210 invoked by uid 1000);
        Fri, 13 Jan 2023 00:10:39 -0000
Date:   Thu, 12 Jan 2023 18:10:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv5 06/10] dt-bindings: mfd: add rk806 binding
Message-ID: <167356863889.501159.246967021598779982.robh@kernel.org>
References: <20230109172723.60304-1-sebastian.reichel@collabora.com>
 <20230109172723.60304-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109172723.60304-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Jan 2023 18:27:19 +0100, Sebastian Reichel wrote:
> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/mfd/rockchip,rk806.yaml          | 406 ++++++++++++++++++
>  1 file changed, 406 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
