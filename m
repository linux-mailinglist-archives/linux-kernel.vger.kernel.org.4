Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699B6D280F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjCaSrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjCaSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:47:05 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35301D90C;
        Fri, 31 Mar 2023 11:47:02 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso11671783otb.4;
        Fri, 31 Mar 2023 11:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkseuN6EQE7Ox7VHfjMNPwBRFbWM28gSepVze7lckmI=;
        b=KZflzkX6aA6x9JOG0gzo/g/muFMe+tXKQ262h/d1HmHwLHMQ4pFEmBXG7qT5/VzbWc
         Wc3ZsHR++a1UyXVd0PN9y/xi028hEkp3kzYPoThi2KBBnYlEuGlhtRTjvKU+epzV0yrW
         mMDaWR5p0DsgI0qew665uPe7iXWK4z1XuzMSIQvyDLLx7Us4v/yOhbZ+zzG2A6Ofacka
         FvDjUgLAfli9cJAS5jzjza/Lz6bJqbKlCxODUYRONQO10M/eJMuV4QtwloSUZG4AY3bm
         5mxqGA8U1dJlmjZU7C2qrWoUqg6Isz4C7CgibRCUnJ/UmZ93aOnY8Ls/FPShsyf7qOtC
         iReA==
X-Gm-Message-State: AAQBX9cO1FK/19F5+m0zUqny/mILrKNXONwStT82acU3+vm+lno7F+pv
        Sa43Ge6lcQP22eKF3pzqLg==
X-Google-Smtp-Source: AKy350b7+lgd07pvqApJZH2J0ZDEybBc2nhXoQp2Y1busPxFSRbfC6apVQYZP57zQ8jv7W1Hx3ywkQ==
X-Received: by 2002:a9d:77cd:0:b0:6a1:3101:8e2e with SMTP id w13-20020a9d77cd000000b006a131018e2emr8695069otl.29.1680288421913;
        Fri, 31 Mar 2023 11:47:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a9d7385000000b006a14579a8besm1441266otk.43.2023.03.31.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:47:01 -0700 (PDT)
Received: (nullmailer pid 1933933 invoked by uid 1000);
        Fri, 31 Mar 2023 18:47:00 -0000
Date:   Fri, 31 Mar 2023 13:47:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
Message-ID: <20230331184700.GA1920623-robh@kernel.org>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-3-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324061608.33609-3-quic_hazha@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:16:07PM +0800, Hao Zhang wrote:
> Add new coresight-dummy.yaml file describing the bindings required
> to define coresight dummy trace in the device trees.

The diff tells me all this. Please explain why this is needed and needs 
to be in DT here.

> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> new file mode 100644
> index 000000000000..7b719b084d72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Coresight Dummy component
> +
> +description: |
> +  The Coresight Dummy component is for the specific devices that HLOS don't have
> +  permission to access or configure. Such as Coresight sink EUD, some TPDMs etc.

EUD? TPDM?

I don't really love 'dummy' used here. Maybe the OS still wants/needs to 
know where the sink goes to even if not configurable.

You *can* have multiple compatibles for a single generic driver if those 
compatibles might be useful some day.

> +  So there need driver to register dummy devices as Coresight devices. Provide
> +  Coresight API for dummy device operations, such as enabling and disabling
> +  dummy devices. Build the Coresight path for dummy sink or dummy source for
> +  debugging.
> +
> +  The primary use case of the coresight dummy is to build path for dummy sink or
> +  dummy source.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,coresight-dummy
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^dummy_.*(sink|source)_[0-9]+.*$"

Don't use '_' in node names.

Convention for multiple instances without 'reg' is '-[0-9]+' on the end, 
but you are allowing anything after that.

> +  compatible:
> +    items:
> +      - const: qcom,coresight-dummy
> +
> +  qcom,dummy-sink:
> +    type: boolean
> +    description:
> +      Indicates that the type of this coresight node is dummy sink.
> +
> +  qcom,dummy-source:

Incorporate source or sink into the compatible strings.

It's also somewhat redundant with 'in-ports' vs. 'out-ports'.

> +    type: boolean
> +    description:
> +      Indicates that the type of this coresight node is dummy source.
> +
> +  out-ports:
> +    description: |

Don't need '|' unless you need to preserve formatting.

> +      Output connections from the dummy source to Coresight Trace bus.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Output connection from the dummy source to Coresight
> +            Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +  in-ports:
> +    description: |
> +      Input connections from the CoreSight Trace bus to dummy sink.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port:
> +        description: Input connection from the Coresight Trace bus to
> +            dummy sink.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +oneOf:
> +  - required:
> +      - qcom,dummy-sink
> +  - required:
> +      - qcom,dummy-source
> +
> +examples:
> +  # minimum dummy sink definition. dummy sink connect to coresight replicator.
> +  - |
> +    dummy_sink_1 {
> +      compatible = "qcom,coresight-dummy";
> +      qcom,dummy-sink;
> +
> +      in-ports {
> +        port {
> +          eud_in_replicator_swao: endpoint {
> +            remote-endpoint =
> +              <&replicator_swao_out_eud>;
> +          };
> +        };
> +      };
> +    };
> +
> +  # minimum dummy source definition. dummy source connect to coresight funnel.
> +  - |
> +    dummy_source_1 {
> +      compatible = "qcom,coresight-dummy";
> +      qcom,dummy-source;
> +
> +      out-ports {
> +        port {
> +          dummy_riscv_out_funnel_swao: endpoint {
> +            remote-endpoint =
> +              <&funnel_swao_in_dummy_riscv>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
