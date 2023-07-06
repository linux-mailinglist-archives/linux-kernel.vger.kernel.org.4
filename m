Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9567474A410
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGFTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:02:09 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA111AE;
        Thu,  6 Jul 2023 12:02:08 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-34574eb05f4so3924305ab.0;
        Thu, 06 Jul 2023 12:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670127; x=1691262127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHyEaPrZCKQByAh3DFl+UnNETs5AwZcjbcPbdv9JJW8=;
        b=lmNsfV7WSyNs1OYQGl6F+KLWmR/NYN0xzDnzf852zg/QEIC0q8lkMpyRd7BWZ3TNCQ
         9axPmcQ3wa4gu+LfLSBQb51JMu4kKEgcDldBoOEj3y5+glvV7vdItMF3n1f2bRKgCsqT
         O0YDI/+CtvDPGHBhLp3T5+gX61taXqzvt6Gxrbx5Uk8WUhC0wLJ/sY3DDKcG8h9zKrxL
         P97K/VxPkcoBzjyoPJ0OvxInY7efxZPFyqltjFslkWu8HBYAkUKZaafKc/HHEXqmsDCO
         ybSNYoSDRvjRGfdR1cOvYsUVx7Leot8RiCwmddMNF4ZcIoOM8EQdbroVgSkWoFvRwFNS
         O28g==
X-Gm-Message-State: ABy/qLZfCJMpdh4+g5Iptz2Kr5UHicB1zFW+Dv+NhBCIrw4QA7kZxKWX
        YNI5LUazm2yCv9soF5ioug==
X-Google-Smtp-Source: APBJJlFbADYE6+hk4uSXwI2HJZPLgzAEGH3jTEX9QJwf2mycuUE2+lpXa4xdL1M7WZg+jYHFc5CghQ==
X-Received: by 2002:a92:c9d1:0:b0:345:787a:cb27 with SMTP id k17-20020a92c9d1000000b00345787acb27mr2839568ilq.21.1688670127186;
        Thu, 06 Jul 2023 12:02:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z11-20020a92cd0b000000b0033a50ad8176sm703067iln.18.2023.07.06.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:02:06 -0700 (PDT)
Received: (nullmailer pid 154245 invoked by uid 1000);
        Thu, 06 Jul 2023 19:02:04 -0000
Date:   Thu, 6 Jul 2023 13:02:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com, tanmay.shah@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH v2] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Message-ID: <20230706190204.GA144696-robh@kernel.org>
References: <1687892226-3784452-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687892226-3784452-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:27:06AM +0530, Radhey Shyam Pandey wrote:
> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> UltraScale+ platform. As of now TCM addresses are hardcoded in xilinx
> remoteproc driver. This binding will help in defining TCM in device-tree
> and make it's access platform agnostic and data-driven from the driver.
> 
> Tightly-coupled memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> 
> The TCM resources(reg and power-domain) are documented in each R5 node.
> It also extends the examples for TCM split and lockstep modes.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v2:
> - Add ranges property to r5fss cluster node.
> - Use regex "^r5f(@[0-9a-f]+|-[a-f0-9]+)$".
> - Drop address/size-cells and ranges from r5f core node.
> - Mention "reg" and "reg names" as r5f core node required properties.
> - Mention address/size-cells and ranges as r5fss required node properties.
> - Modify commit description to remove ranges from R5 node.
> - Rename r5f node labels(r5f_0 -> r5f_0_split/lockstep and
>   r5f_1->r5f_1_split/lockstep)
> 
> The inspiration for integrating TCM nodes in R5 nodes is taken from
> "5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
> on TI K3 SoCs".Once the binding is reviewed/accepted will send out
> driver changes in follow-up series.
> ---
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 90 +++++++++++++++++--
>  1 file changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> index 9f677367dd9f..958044b08e86 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -20,6 +20,17 @@ properties:
>    compatible:
>      const: xlnx,zynqmp-r5fss
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description: |
> +      Standard ranges definition providing address translations for
> +      local R5F TCM address spaces to bus addresses.
> +
>    xlnx,cluster-mode:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2]
> @@ -37,7 +48,7 @@ properties:
>        2: single cpu mode
>  
>  patternProperties:
> -  "^r5f-[a-f0-9]+$":
> +  "^r5f(@[0-9a-f]+|-[a-f0-9]+)$":

If reg is required, then you don't need '-[a-f0-9]+'. Though new 
required properties is an ABI change which needs justification.

>      type: object
>      description: |
>        The RPU is located in the Low Power Domain of the Processor Subsystem.
> @@ -54,8 +65,19 @@ patternProperties:
>        compatible:
>          const: xlnx,zynqmp-r5f
>  
> +      reg:
> +        items:
> +          - description: Address and Size of the ATCM internal memory region
> +          - description: Address and Size of the BTCM internal memory region

Drop 'Address and Size of '

> +
> +      reg-names:
> +        items:
> +          - const: atcm
> +          - const: btcm
> +
>        power-domains:
> -        maxItems: 1
> +        minItems: 1
> +        maxItems: 3
>  
>        mboxes:
>          minItems: 1
> @@ -102,31 +124,85 @@ patternProperties:
>      required:
>        - compatible
>        - power-domains
> +      - reg
> +      - reg-names
>  
>      unevaluatedProperties: false
>  
>  required:
>    - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    remoteproc {
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +
> +    //Split mode configuration
> +    remoteproc@ffe00000 {
> +        compatible = "xlnx,zynqmp-r5fss";
> +        xlnx,cluster-mode = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>,
> +                 <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
> +
> +        r5f_0_split: r5f@ffe00000 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
> +            reg-names = "atcm", "btcm";
> +            power-domains = <&zynqmp_firmware PD_RPU_0>,
> +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> +                            <&zynqmp_firmware PD_R5_0_BTCM>;
> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +
> +        r5f_1_split: r5f@ffe90000 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> +            reg-names = "atcm", "btcm";
> +            power-domains = <&zynqmp_firmware PD_RPU_1>,
> +                            <&zynqmp_firmware PD_R5_1_ATCM>,
> +                            <&zynqmp_firmware PD_R5_1_BTCM>;
> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +    };
> +
> +  - |
> +    //Lockstep configuration
> +    remoteproc@ffe00000 {
>          compatible = "xlnx,zynqmp-r5fss";
>          xlnx,cluster-mode = <1>;
>  
> -        r5f-0 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
> +
> +        r5f_0_lockstep: r5f@ffe00000 {
>              compatible = "xlnx,zynqmp-r5f";
> -            power-domains = <&zynqmp_firmware 0x7>;
> +            reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
> +            reg-names = "atcm", "btcm";
> +            power-domains = <&zynqmp_firmware PD_RPU_0>,
> +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> +                            <&zynqmp_firmware PD_R5_0_BTCM>;
>              memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
>              mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
>              mbox-names = "tx", "rx";
>          };
>  
> -        r5f-1 {
> +        r5f_1_lockstep: r5f@ffe90000 {
>              compatible = "xlnx,zynqmp-r5f";
> -            power-domains = <&zynqmp_firmware 0x8>;
> +            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> +            reg-names = "atcm", "btcm";
> +            power-domains = <&zynqmp_firmware PD_RPU_1>;
>              memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
>              mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
>              mbox-names = "tx", "rx";
> -- 
> 2.25.1
> 
