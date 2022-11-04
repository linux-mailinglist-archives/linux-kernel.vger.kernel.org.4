Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001B5619F6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKDSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiKDSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:03:39 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47C2AE26;
        Fri,  4 Nov 2022 11:03:38 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso774009ooo.4;
        Fri, 04 Nov 2022 11:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/H6tH1T19zPir63G4IjFf14dpF+2I+FJK0jn9RaHLc=;
        b=5FwfHo32kXpQpmAbmziIdo/DY5FvZOk6AGLGZKVmuPe63vsHSB8Zn/vlHJPXkM63Gd
         f9QYPey9MtCo8L/s/mj4a7LzCki/1ZBHLSwM3O9n5t6OaRif2gquNz24g87VujYXti5+
         nnIKAdBhxnSxScdsn0R91SzwwI7aI8i96fQ7ssRK3H9S9YzfXrd4uz5oBqHcJ5r0mSm8
         PLSb+PKSBX9cfcDNfjTb/JDjI3YTRuYhl+0wi4tQ6pKDSKiOo/UN4nvENcZWT97e2fka
         ArwHO0zZ39JD2yUlECoqcqaORj2S3h6cJ7YZ62UAFfos52mOXqQulOyoa1tLP7hjZV/B
         f9HA==
X-Gm-Message-State: ACrzQf2V5PZjhbmwlIByv04gs3zIIc9n7oVguBd7ngwiGyS4G3qQKRGR
        qyO4L9IQFTrfFKTYdRk79g==
X-Google-Smtp-Source: AMsMyM66fHRV+R/ARMYtiXVHLPRSZBNpfBH8YPLsVf1YT19J77mGQsHZqha8apV2mlQjAuCEsedmYQ==
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id r62-20020a4a4e41000000b004808a3ca797mr15670730ooa.71.1667585017929;
        Fri, 04 Nov 2022 11:03:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id em6-20020a0568705b8600b00127d2005ea1sm2079274oab.18.2022.11.04.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:03:37 -0700 (PDT)
Received: (nullmailer pid 2087245 invoked by uid 1000);
        Fri, 04 Nov 2022 18:03:39 -0000
Date:   Fri, 4 Nov 2022 13:03:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        quic_avajid@quicinc.com
Subject: Re: [RFC 1/2] dt-bindings: firmware: arm,scmi: Add support for
 memlat vendor protocol
Message-ID: <20221104180339.GA2079655-robh@kernel.org>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
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

On Thu, Nov 03, 2022 at 10:28:31AM +0530, Sibi Sankar wrote:
> Add bindings support for the SCMI QTI memlat (memory latency) vendor
> protocol. The memlat vendor protocol enables the frequency scaling of
> various buses (L3/LLCC/DDR) based on the memory latency governor
> running on the CPUSS Control Processor.

I thought the interconnect binding was what provided details for bus 
scaling.

> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 1c0388da6721..efc8a5a8bffe 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -189,6 +189,47 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@80:
> +    type: object
> +    properties:
> +      reg:
> +        const: 0x80
> +
> +      qcom,bus-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          minItems: 1
> +        description:
> +          Identifier of the bus type to be scaled by the memlat protocol.
> +
> +      cpu-map:

cpu-map only goes under /cpus node.

> +        type: object
> +        description:
> +          The list of all cpu cluster configurations to be tracked by the memlat protocol
> +
> +        patternProperties:
> +          '^cluster[0-9]':
> +            type: object
> +            description:
> +              Each cluster node describes the frequency domain associated with the
> +              CPUFREQ HW engine and bandwidth requirements of the buses to be scaled.
> +
> +            properties:

cpu-map nodes don't have properties.

> +              operating-points-v2: true
> +
> +              qcom,freq-domain:

Please don't add new users of this. Use the performance-domains binding 
instead.

> +                $ref: /schemas/types.yaml#/definitions/phandle-array
> +                description:
> +                  Reference to the frequency domain of the CPUFREQ HW engine
> +                items:
> +                  - items:
> +                      - description: phandle to CPUFREQ HW engine
> +                      - description: frequency domain associated with the cluster
> +
> +            required:
> +              - qcom,freq-domain
> +              - operating-points-v2
> +
>  additionalProperties: false
>  
>  patternProperties:
> @@ -429,4 +470,127 @@ examples:
>          };
>      };
>  
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    firmware {
> +        scmi {
> +            compatible = "arm,scmi";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            mboxes = <&cpucp_mbox>;
> +            mbox-names = "tx";
> +            shmem = <&cpu_scp_lpri>;
> +
> +            scmi_memlat: protocol@80 {
> +                reg = <0x80>;
> +                qcom,bus-type = <0x2>;
> +
> +                cpu-map {
> +                    cluster0 {
> +                        qcom,freq-domain = <&cpufreq_hw 0>;
> +                        operating-points-v2 = <&cpu0_opp_table>;
> +                    };
> +
> +                    cluster1 {
> +                        qcom,freq-domain = <&cpufreq_hw 1>;
> +                        operating-points-v2 = <&cpu4_opp_table>;
> +                    };
> +
> +                    cluster2 {
> +                        qcom,freq-domain = <&cpufreq_hw 2>;
> +                        operating-points-v2 = <&cpu7_opp_table>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        cpu0_opp_table: opp-table-cpu0 {
> +            compatible = "operating-points-v2";
> +
> +            cpu0_opp_300mhz: opp-300000000 {
> +                opp-hz = /bits/ 64 <300000000>;
> +                opp-peak-kBps = <9600000>;
> +            };
> +
> +            cpu0_opp_1325mhz: opp-1324800000 {
> +                opp-hz = /bits/ 64 <1324800000>;
> +                opp-peak-kBps = <33792000>;
> +            };
> +
> +            cpu0_opp_2016mhz: opp-2016000000 {
> +                opp-hz = /bits/ 64 <2016000000>;
> +                opp-peak-kBps = <48537600>;
> +            };
> +        };
> +
> +        cpu4_opp_table: opp-table-cpu4 {
> +            compatible = "operating-points-v2";
> +
> +            cpu4_opp_691mhz: opp-691200000 {
> +                opp-hz = /bits/ 64 <691200000>;
> +                opp-peak-kBps = <9600000>;
> +            };
> +
> +            cpu4_opp_941mhz: opp-940800000 {
> +                opp-hz = /bits/ 64 <940800000>;
> +                opp-peak-kBps = <17817600>;
> +            };
> +
> +            cpu4_opp_2611mhz: opp-2611200000 {
> +                opp-hz = /bits/ 64 <2611200000>;
> +                opp-peak-kBps = <48537600>;
> +            };
> +        };
> +
> +        cpu7_opp_table: opp-table-cpu7 {
> +            compatible = "operating-points-v2";
> +
> +            cpu7_opp_806mhz: opp-806400000 {
> +                opp-hz = /bits/ 64 <806400000>;
> +                opp-peak-kBps = <9600000>;
> +            };
> +
> +            cpu7_opp_2381mhz: opp-2380800000 {
> +                opp-hz = /bits/ 64 <2380800000>;
> +                opp-peak-kBps = <44851200>;
> +            };
> +
> +            cpu7_opp_2515mhz: opp-2515200000 {
> +                opp-hz = /bits/ 64 <2515200000>;
> +                opp-peak-kBps = <48537600>;
> +            };
> +        };
> +    };
> +
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        cpucp_mbox: mailbox@17400000 {
> +            compatible = "qcom,cpucp-mbox";
> +            reg =   <0x0 0x17c00000 0x0 0x10>, <0x0 0x18590300 0x0 0x700>;
> +            interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +            #mbox-cells = <0>;
> +        };
> +
> +        sram@18509400 {
> +            compatible = "mmio-sram";
> +            reg = <0x0 0x18509400 0x0 0x400>;
> +            no-memory-wc;
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0x0 0x0 0x18509400 0x400>;
> +
> +            cpu_scp_lpri: scp-sram-section@0 {
> +                compatible = "arm,scmi-shmem";
> +                reg = <0x0 0x80>;
> +            };
> +        };
> +    };
> +
>  ...
> -- 
> 2.7.4
> 
> 
