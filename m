Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2715EB4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIZWyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIZWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:54:21 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749219C206;
        Mon, 26 Sep 2022 15:54:20 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so5401807oth.2;
        Mon, 26 Sep 2022 15:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5EDhuR5nnVVwjruloR7awR6vateNTWu+qdgS57G4+ss=;
        b=GfUjwaDqOstrMBTTtopMAPKiBM8bujqLDXr5hrkT70DVB9xXExIpv7GJBnI4NPrQsy
         Iwiu1kr0IWgCkbnn23j67fUeLKapv4nmouFhOY4i208x7pAbYLkular/gBDagKZyURdW
         dI3I5mkzWndU3wRiOLToiZP2bqQmYNCuFX6VwSoZA0cMgoddP/X/CcnGqk6p5rmuLrmg
         Ne9en0qLob6p2UxOnuMZoH+vi8F56ajZGbKsP1t2ffqrqxCKDJZ0JF5M30Alg7Ff344P
         /dQG9TypjQlLWTX2NRqiJ+g8PT68f8VCkyS4/+wqbYm6OzMkFnoj5BWGLdhbXL1xT3NN
         e4hA==
X-Gm-Message-State: ACrzQf0xLJ7RRl85NR2yXPRMt7rZMIZLX8gnYlE/vFCLUsYSV8XvOtt1
        3ylH820+s1tAC/G1GJfCcct8i1x3Tw==
X-Google-Smtp-Source: AMsMyM6gx0UiVSc1eGg+lhLXNtx8z9hFLkWGQk5YyWHvgLfIkYCb2AvYqItyYBiX19891NSJPHzzTQ==
X-Received: by 2002:a9d:7b56:0:b0:655:df1d:c9f8 with SMTP id f22-20020a9d7b56000000b00655df1dc9f8mr10227348oto.32.1664232859689;
        Mon, 26 Sep 2022 15:54:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a056870560d00b0011bde9f5745sm9491804oao.23.2022.09.26.15.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:54:19 -0700 (PDT)
Received: (nullmailer pid 3114680 invoked by uid 1000);
        Mon, 26 Sep 2022 22:54:18 -0000
Date:   Mon, 26 Sep 2022 17:54:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 09/11] dt-bindings: slimbus: convert bus description to
 DT schema
Message-ID: <20220926225418.GA3114619-robh@kernel.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923161453.469179-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 18:14:51 +0200, Krzysztof Kozlowski wrote:
> Convert the SLIMbus bus description bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/slimbus/bus.txt       | 60 ------------
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  2 -
>  .../bindings/slimbus/slim-qcom-ctrl.txt       |  3 -
>  .../devicetree/bindings/slimbus/slimbus.yaml  | 95 +++++++++++++++++++
>  4 files changed, 95 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
