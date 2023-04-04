Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583586D6524
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjDDOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjDDOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:22:10 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D38128;
        Tue,  4 Apr 2023 07:22:02 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id bj20so24316479oib.3;
        Tue, 04 Apr 2023 07:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ksvzbq2gQvGRcF4d3P6MDp1Pp3aLiB4KPYctYyISA=;
        b=bHbOFbGbGFsR9Pb4Oo+S7r9160sRZRxNEIy8ZYNvCJL2l3f6mKZnBBhV2NZyTbYl70
         PYE0uuDUo9Bf8YZ2DYyCn7aT01osXXkdpMhUzhEuU8WIAH53oDf1OhgLdbdEoaKxdX5v
         OicwVa7zfQRVrSAu8NP6o+OE01O7+CpvPW39dqfjUDgNFqysvCHP1hCEyZSuGO36JqgO
         5AgQS/IH68bD/O3GmX/nfE8YLXyxIaMKKMgk5kWXJB4ynEv5kBYbqknvVEnEWAw7Q2Sk
         mnYry+GZynLD8lDew/kiBd/5R5zuynfH+VOn9SaQLkK7KOc+Q1oZldDqetdXScXPNVBR
         abjw==
X-Gm-Message-State: AAQBX9eJ7kjarU4UUb6yJmBW1ZZ1x8lrhh0NdB5rOE5bD5vyuKite9m4
        uzEuydbMaXlY0DyeTJCbFA==
X-Google-Smtp-Source: AKy350bfLilcIpHOP2DnsH5J5CDj+2U3bSb1BmQbgZesFcN/dqwmrnUzaqaa+zuxaQlLVp6rk6pDMQ==
X-Received: by 2002:aca:bed5:0:b0:387:205b:70c7 with SMTP id o204-20020acabed5000000b00387205b70c7mr1313305oif.13.1680618121888;
        Tue, 04 Apr 2023 07:22:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p8-20020acabf08000000b003871471f894sm2497572oif.27.2023.04.04.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:22:01 -0700 (PDT)
Received: (nullmailer pid 3829375 invoked by uid 1000);
        Tue, 04 Apr 2023 14:21:59 -0000
Date:   Tue, 4 Apr 2023 09:21:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: soundwire: qcom: add 16-bit sample
 interval
Message-ID: <20230404142159.GA3827653-robh@kernel.org>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:24:58PM +0200, Krzysztof Kozlowski wrote:
> The port sample interval was always 16-bit, split into low and high
> bytes.  This split was unnecessary, although harmless for older devices
> because all of them used only lower byte (so values < 0xff).  With
> support for Soundwire controller on Qualcomm SM8550 and its devices,
> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
> to allow 16-bit sample intervals.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soundwire/qcom,soundwire.yaml    | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> index c283c594fb5c..883b8be9be1b 100644
> --- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -86,7 +86,7 @@ properties:
>    qcom,ports-sinterval-low:
>      $ref: /schemas/types.yaml#/definitions/uint8-array
>      description:
> -      Sample interval low of each data port.
> +      Sample interval (only lowest byte) of each data port.
>        Out ports followed by In ports. Used for Sample Interval calculation.
>        Value of 0xff indicates that this option is not implemented
>        or applicable for the respective data port.
> @@ -94,6 +94,19 @@ properties:
>      minItems: 3
>      maxItems: 16
>  
> +  qcom,ports-sinterval:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Sample interval of each data port.
> +      Out ports followed by In ports. Used for Sample Interval calculation.
> +      Value of 0xffff indicates that this option is not implemented
> +      or applicable for the respective data port.
> +      More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 16
> +    items:
> +      maximum: 0xffff

Why not use uint16-array?

> +
>    qcom,ports-offset1:
>      $ref: /schemas/types.yaml#/definitions/uint8-array
>      description:
> @@ -219,10 +232,15 @@ required:
>    - '#size-cells'
>    - qcom,dout-ports
>    - qcom,din-ports
> -  - qcom,ports-sinterval-low
>    - qcom,ports-offset1
>    - qcom,ports-offset2
>  
> +oneOf:
> +  - required:
> +      - qcom,ports-sinterval-low
> +  - required:
> +      - qcom,ports-sinterval
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 
