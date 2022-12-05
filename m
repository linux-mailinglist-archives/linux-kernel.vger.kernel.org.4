Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A00643493
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiLETr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiLETrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:47:37 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129052A42E;
        Mon,  5 Dec 2022 11:44:04 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q83so765889oif.7;
        Mon, 05 Dec 2022 11:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQzVdvVBCf/eUGpwToE6Ntfsj3J9nsllj1YkGsPYjqQ=;
        b=yRHf+xpvpZF+dT0FNc4F6+7Zr8xF+F990ptgf/qU9gKZMTjAbBbetSU2b0VOinNvMB
         bJHxxHPLPhUHRscTDANb5dROIhcqmtKvXykmPl0cQ84iXMcWCozset/JHGdokfhbEmvn
         u+cPF2v6LiUjknAf99/yXitd6XY37OCXdeF2eZ2pvR5+f2KSEy+1+xgLpx/KxdGiyU6r
         XEdiZMv0Wmkxqj229ip+Qne4OBZ6inC1lIIpKTFrSwYzhN+Ly7Prkj/U4TAaMy32zhhq
         uCm+NcF8jUA9pKw2o2Xm5inmL83kZ9Bfo4iuqH5ivwG+DImH9FKQ6IDEcQUzoSwke7A1
         MIqg==
X-Gm-Message-State: ANoB5pmcgORy4FOMimY+Hat9551nlpW+ZAX8OVl5LALtUYDOE/xqzcV9
        7irkqU45UFQY5FNyZbMvn8Likxmlhw==
X-Google-Smtp-Source: AA0mqf7b+4zUTozm5hbhuaD7wbOoaVSrzhgGn8fvTMrKL4MCB2VXcVReLBK54tTCECqtI7gKpxjEBw==
X-Received: by 2002:aca:a908:0:b0:35c:23ed:253a with SMTP id s8-20020acaa908000000b0035c23ed253amr4257656oie.91.1670269443185;
        Mon, 05 Dec 2022 11:44:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cv31-20020a056870c69f00b00143cfb377b4sm9657112oab.6.2022.12.05.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:44:02 -0800 (PST)
Received: (nullmailer pid 2473716 invoked by uid 1000);
        Mon, 05 Dec 2022 19:44:02 -0000
Date:   Mon, 5 Dec 2022 13:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 05/15] dt-bindings: remoteproc: qcom,adsp: drop resets
 and qcom,halt-regs
Message-ID: <167026944152.2473650.845853977501597417.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:23 +0100, Krzysztof Kozlowski wrote:
> Some remote processors (e.g. QCS404 CDSP, SC7180 MPSS/MSS) can be brought
> to life using two different bindings:
> 1. PIL (Peripheral Image Loader)
> 2. PAS (Peripheral Authentication Service)
> 
> They still describe the same hardware - firmware load for remote
> processor - but use different methods to communicate with that
> processor.
> 
> For these SoCs, the qcom,adsp.yaml bindings were describing the PAS
> method, however for easier customization of board DTS, the bindings
> combined additional properties from PIL: reset lines, qcom,halt-regs and
> additional clocks.  The devices and Linux kernel drivers, when
> instantiated as PAS, do not use these properties, so drop them from the
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. New patch
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 113 +-----------------
>  1 file changed, 4 insertions(+), 109 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
