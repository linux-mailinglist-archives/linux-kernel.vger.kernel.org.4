Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF410617CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiKCMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiKCMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:35:47 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7FCE34;
        Thu,  3 Nov 2022 05:35:45 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b103a3e5dso1960563fac.2;
        Thu, 03 Nov 2022 05:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yt3Or6Hc5rWqEW44VauNHB/7Tdn75AHTUvKCFRqx6Wc=;
        b=2WjMeBbPdh3AlSBURB/riF+SbSUaANbXERUrLPBWYN/BIbwkS2em62UA13Iv2YumRq
         OiBkah3bYPr/PZOPpyKbE0M0B4DmUr9pB1Q+mfvVNvnts+pYv4kMmOR9TqqV/6SZEhz+
         /Dl87guf/UXjZwg7Sctm6JpkTGCzX0SJkV1YbnIgnCoT9FBPi+5IkZnjkfljDU2X8bS/
         APzb/ibQW+0ZKGT9LPi20Y7d66bJZyaFbrX7+tZs6mWXKhV8W5gLGPlYh1go5lLE2Dzy
         A5YNpyi96rVraEEfDNH85roH7Q7gpWUNMjtNKK1qoyvEP4ZfJfbfYS4iUJB3wkm5Axku
         y9Hw==
X-Gm-Message-State: ACrzQf3L4jcQFthKCs6uYVnXJrY4f4PBJmD0nArOQKggmB8QVSExmNz0
        iiQqkzFCifFhRq8ZSDDSbA==
X-Google-Smtp-Source: AMsMyM5EZi2Ftm7ol57J/diP8OEESwv2NPojF/XnBc6X1Sc0OTdJguH3vf/QhIAZetkm6LiKQlU1qg==
X-Received: by 2002:a05:6870:f59e:b0:132:bcd:565f with SMTP id eh30-20020a056870f59e00b001320bcd565fmr26806687oab.254.1667478944707;
        Thu, 03 Nov 2022 05:35:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u11-20020a056871008b00b0013d7fffbc3csm261177oaa.58.2022.11.03.05.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:35:44 -0700 (PDT)
Received: (nullmailer pid 2140210 invoked by uid 1000);
        Thu, 03 Nov 2022 12:35:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        andersson@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, quic_avajid@quicinc.com
In-Reply-To: <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
Message-Id: <166747792111.2121881.1520386544436651390.robh@kernel.org>
Subject: Re: [RFC 1/2] dt-bindings: firmware: arm,scmi: Add support for memlat
 vendor protocol
Date:   Thu, 03 Nov 2022 07:35:43 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 10:28:31 +0530, Sibi Sankar wrote:
> Add bindings support for the SCMI QTI memlat (memory latency) vendor
> protocol. The memlat vendor protocol enables the frequency scaling of
> various buses (L3/LLCC/DDR) based on the memory latency governor
> running on the CPUSS Control Processor.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/arm,scmi.example.dtb: scmi: mbox-names: ['tx'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
Documentation/devicetree/bindings/firmware/arm,scmi.example.dtb:0:0: /example-3/soc/mailbox@17400000: failed to match any schema with compatible: ['qcom,cpucp-mbox']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

