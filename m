Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D95B64A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIMAtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIMAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:49:02 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4775073A;
        Mon, 12 Sep 2022 17:49:01 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id l40-20020a4a94eb000000b00472717928b5so1693279ooi.1;
        Mon, 12 Sep 2022 17:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Kl+mcyI7K+bHUEe8mEiULT1Uqn9PVfiU+o79MQhfZdY=;
        b=lKYBsafwI8XBWS1UWKmAu76LFpogrMMBsqXR6pfJxTwzd+gP1qTBL3vGYUbyYV2epe
         VJkSQr7j4bdDQFUcwyQf9XmF5DY4o1BCFE2Fzku0k61hjNbGIVi26o8G/j5rY8PyYq5q
         3zH51+bUE6nWFQMTqScaRd0WGEXK8a2B5qpkc8QGzFrP2utVK4v6Gwk8O9uk+XBMwMXY
         n/5LGn+pcCUIwEn5g198HfuCfSYr2sCyNzDm/FsiP/T68o20mX0oNMb6IMTfk3Ru7ltF
         Py6VBnD2TcfHbPWhCkOULUeU/dtjQM5Z/CwHJHv+t0KXkguYhR210UZwE9M4Km9j7dzE
         fpSg==
X-Gm-Message-State: ACgBeo2HqBqQvofRZJoIuo/BQDiLBpmsyV9RhPHhZlh3C4kSti4ylKU4
        3ypCwDRRRRuzWzvv6OrD+A==
X-Google-Smtp-Source: AA6agR4nz4mIBICAeW9Ftda30sK3EAo1oFyMsp1Q0xTr4HubZ/xyLCNfO2RWksWaiAL5s15+nEOQXw==
X-Received: by 2002:a4a:bc90:0:b0:475:67a4:2bb7 with SMTP id m16-20020a4abc90000000b0047567a42bb7mr3049206oop.20.1663030140971;
        Mon, 12 Sep 2022 17:49:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o6-20020a4ae586000000b0044afc1ba91asm4768492oov.44.2022.09.12.17.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 17:49:00 -0700 (PDT)
Received: (nullmailer pid 2215651 invoked by uid 1000);
        Tue, 13 Sep 2022 00:48:59 -0000
Date:   Mon, 12 Sep 2022 19:48:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: Add support for DSB element
Message-ID: <20220913004859.GA1948424-robh@kernel.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-2-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662626705-13097-2-git-send-email-quic_taozha@quicinc.com>
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

On Thu, Sep 08, 2022 at 04:44:57PM +0800, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB element for TPDA.
> Specifies the DSB element size supported by each monitor connected
> to the aggregator on each port. Should be specified in pairs (port,
> dsb element size).

What is DSB?

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index eb9bfc5..1bb3fdf 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -40,6 +40,13 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,dsb-elem-size:
> +    description: |
> +      Specifies the DSB element size supported by each monitor
> +      connected to the aggregator on each port. Should be specified
> +      in pairs (port, dsb element size).
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

The binding (not yet upstream) says there is just 1 port (port 0). So 
why do you need more than a single uint32?

Rob
