Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6ED5FA31C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJJSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJJSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:03:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D977E9E;
        Mon, 10 Oct 2022 11:03:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so10952891pjl.3;
        Mon, 10 Oct 2022 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaemP1XrXXg6smvlpbj+/HGqR51jspSSkIvsRr/7Mok=;
        b=UXz1IztGv0MJRf/rNTh2fpKfswkqZf2u2PfLFPmQI2KD0qi6IYKkdPs2gj8sCJwsta
         oqMQ2NZm6ZLCaMSei270ANMuwiCQH4mYhMKUY2e5F1AdeX3ZvnxFP/oxrnAvpc9wypQ5
         +31Iz3e09rAmjtOFEbrSgcAJViWRMD60lfzJVHaEOOL3qPYH0vau15r/YbtuIYlWGdm3
         RzTD7bVE6gh3p/+kbbBFYVygGy+yL1Dd3ewfHB7SNynYghMSjfOw3GWp6atXRdc2MvdX
         4DxeE6nQJRxOXTtgeZ8YdM/KQ07dAUqX2leMyxRRqVEHkdeu6v874tl/4VBPJt6VFFuR
         Yp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaemP1XrXXg6smvlpbj+/HGqR51jspSSkIvsRr/7Mok=;
        b=yw+g7yJsztwVg07ndckKwsgKF3Hy3rMRkDLB2TFzMupaJv3W5Fe1Zl6hVdn2vuBMYq
         LLQeU8XWJF2xgOk9Sl04RIr+un8I9rnkqL02g5+T6J6ZaiXK1Ejq5bmCXhBPHg01m+Ag
         ITP044rHFfoP8M/ZGEeJY8q1R6aDLpLdSU8kqRjfAB+RuYcopi83Idg0eW8WKeCJL2ei
         2IfM4j2f77AAQQkWeBL4CWrZWf+vLeww1c+RUl5whl2/ts6rBR9xzwbSiu2s3dYIOQzX
         i3alXpnpOM/ZkPIYxEbpK36VIcHP3xIeylKqFREEnjoQkYL4mwoIxYX976qfCp2LYWgA
         BtoA==
X-Gm-Message-State: ACrzQf1ILqPEc/EBF4Vvt8aEJpF0IO9lXOJQ2pTkJhHzL6ddh9CAxQH8
        CTwhhoBYrOBSa84Hb/GVps4=
X-Google-Smtp-Source: AMsMyM5EqKg0p76lXgbaT9WekyGmD9TCKMXS1H1yWX1MAOjXpyUCSUkDV0/qx9p5b5T8vQJYAtSZWQ==
X-Received: by 2002:a17:90b:388e:b0:20d:4a1f:d5ae with SMTP id mu14-20020a17090b388e00b0020d4a1fd5aemr5658239pjb.51.1665425014041;
        Mon, 10 Oct 2022 11:03:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bff:9bd3:c2da:5f42])
        by smtp.gmail.com with ESMTPSA id 24-20020a631558000000b0045feab454f6sm4639268pgv.51.2022.10.10.11.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:03:33 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:03:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: input: mtk-pmic-keys: add binding
 for MT6357 PMIC
Message-ID: <Y0RecjEx9Eyhe0i0@google.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-2-f17ba2d2d0a9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v2-2-f17ba2d2d0a9@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:57:22PM +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the PMIC keys on MT6357.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge through MFD with the rest of the patches.

> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> index 2f72ec418415..037c3ae9f1c3 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> @@ -26,6 +26,7 @@ properties:
>      enum:
>        - mediatek,mt6323-keys
>        - mediatek,mt6331-keys
> +      - mediatek,mt6357-keys
>        - mediatek,mt6358-keys
>        - mediatek,mt6397-keys
>  
> 
> -- 
> b4 0.10.1

Thanks.

-- 
Dmitry
