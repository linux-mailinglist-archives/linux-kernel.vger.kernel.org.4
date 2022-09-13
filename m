Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D85B75B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiIMPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiIMPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:53:08 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E38E4C6;
        Tue, 13 Sep 2022 07:54:23 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-127dca21a7dso32714318fac.12;
        Tue, 13 Sep 2022 07:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=65PJEbjFYTeXGfTL+rGK4NnFiV7DNUWrNwWPhf9K4xs=;
        b=16srbxssGJryiEJbR5N9lhn/08qc7viC8FR/RX6hFgqt92xujKT6OCo2CdsIakM6MS
         ClRw+XiAdswMHJTV+fRHnSINtDQZWkZazlwZt2qWSe82W4/tLDtkNttHQYmNnXe2prx0
         6o8bJ3g5WLusNEK+J2fX/4hOcA8oT0WvqxrFpNJi41fDAncQCBAJO3eKneHYniE+otup
         UsZTESITKKIVU2xBQWLu0Qxgw0FNKBmf7bv0D81zbpl0hfX0IscjTI6hykPuGihhJGTr
         DooxElt6SYqwyGvT0HqzdCwSebMGgtj40hK058+NfKKDNKWhml/93N/+VmB1GktW6wGu
         dbwg==
X-Gm-Message-State: ACgBeo3K4m0Ekf8Wamo/H1TmyQHxzWgFSDi7dfIm6JvGnKF4fn8xbpub
        Qu0Uuh7F2RvDVMIF/VwZGg==
X-Google-Smtp-Source: AA6agR6td+yioCg7UVwjN1+fuYXabS/DfqUdfH+qW5g8tBKhJrI64w17jpYDB7zKkfooui9z24VdmQ==
X-Received: by 2002:a05:6870:f706:b0:11d:4f5c:e7b0 with SMTP id ej6-20020a056870f70600b0011d4f5ce7b0mr1996734oab.49.1663080734854;
        Tue, 13 Sep 2022 07:52:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a056871078300b00127a6357bd5sm3257078oap.49.2022.09.13.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:52:14 -0700 (PDT)
Received: (nullmailer pid 3655647 invoked by uid 1000);
        Tue, 13 Sep 2022 14:52:13 -0000
Date:   Tue, 13 Sep 2022 09:52:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v4 11/15] ASoC: dt-bindings: qcom,q6adm: convert to
 dtschema
Message-ID: <20220913145213.GA3655614-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:14:24 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm Audio Device Manager (Q6ADM) bindings to DT schema.
> 
> The original bindings documented:
> 1. APR service node with compatibles: "qcom,q6adm" and
> "qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>",
> 2. Routing child node with compatible "qcom,q6adm-routing".
> 
> The conversion entirely drops (1) because the compatible is already
> documented in bindings/soc/qcom/qcom,apr.yaml.  The
> "qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>" on the other hand is not
> used at all - neither in existing DTS, nor in downstream sources - so
> versions seems to be fully auto-detectable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v3:
> 1. New patch.
> ---
>  .../bindings/soc/qcom/qcom,apr.yaml           |  3 +-
>  .../bindings/sound/qcom,q6adm-routing.yaml    | 52 +++++++++++++++++++
>  .../devicetree/bindings/sound/qcom,q6adm.txt  | 39 --------------
>  3 files changed, 54 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
