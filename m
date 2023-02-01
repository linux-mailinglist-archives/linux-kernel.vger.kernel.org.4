Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A2686C89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBARNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBARNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:13:10 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BECC04;
        Wed,  1 Feb 2023 09:13:04 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id s66so16284838oib.7;
        Wed, 01 Feb 2023 09:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTT6vZ5iHjnalpPNssmSbl29PhZdc5VcdM+DVzHurmw=;
        b=ZyBEfDYtp5TJYf5JqpLvAmVHpY6xKx/N5hP+KNKpYhu2kWOF9fi+ruzlsYd9zGH/jL
         hYKjDesRcOUAnt3HZ+6MEEMJgRVgTPpuQyUJJ6ViHe8H5zdiwq71LwkmBtU5rvgPTLpK
         wrXW1WsQjoYf4BdZFYEqzEYR8ltfIjFL0LfO2+zFRXIIkziQe3gGwX5gvFp+2C6fUid8
         rlJ0TjXEWZCdRS34rpaTtUu36BFwLOKgnjOVV2CFZ2BM1p9CGITKto+jXtpI6uJbF80T
         uas7V8bbDtAHmcwgEO96gzPej4CdrjcsDTgshtac1wy/oVwIXlDqBRisXpaznlD6Grbc
         m1mQ==
X-Gm-Message-State: AO0yUKVz8deUU9RCP50nVHJT8HrFdcQvJpLSaXFJ2gLiqKWEUYh4cGru
        GXKZFurYviEVJiB4biuOVQ==
X-Google-Smtp-Source: AK7set/Q3V23dp7mKwXccI7KFQBUKCUaOUrzdXAxKdKGV/QYcZJThdLz6qKE6su4zvbCHkKcRjF+Qw==
X-Received: by 2002:a05:6808:1913:b0:378:5f8c:45b4 with SMTP id bf19-20020a056808191300b003785f8c45b4mr1874203oib.18.1675271583392;
        Wed, 01 Feb 2023 09:13:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r133-20020acaa88b000000b00367080ab4casm525848oie.35.2023.02.01.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:13:03 -0800 (PST)
Received: (nullmailer pid 3681788 invoked by uid 1000);
        Wed, 01 Feb 2023 17:13:01 -0000
Date:   Wed, 1 Feb 2023 11:13:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH v7 3/7] dt-bindings: bus: add CDX bus controller for
 versal net
Message-ID: <20230201171301.GA3606391-robh@kernel.org>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
 <20230131084049.23698-4-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131084049.23698-4-nipun.gupta@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:10:45PM +0530, Nipun Gupta wrote:
> Add CDX bus controller device tree bindings for versal-net
> devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
>  .../bindings/bus/xlnx,versal-net-cdx.yaml     | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> new file mode 100644
> index 000000000000..8452185b9d70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/xlnx,versal-net-cdx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD CDX bus controller
> +
> +description: |
> +  CDX bus controller for AMD devices is implemented to dynamically
> +  detect CDX bus and devices on these bus using the firmware.
> +  The CDX bus manages multiple FPGA based hardware devices, which
> +  can support network, crypto or any other specialized type of
> +  devices. These FPGA based devices can be added/modified dynamically
> +  on run-time.
> +
> +  All devices on the CDX bus will have a unique streamid (for IOMMU)
> +  and a unique device ID (for MSI) corresponding to a requestor ID
> +  (one to one associated with the device). The streamid and deviceid
> +  are used to configure SMMU and GIC-ITS respectively.
> +
> +  iommu-map property is used to define the set of stream ids
> +  corresponding to each device and the associated IOMMU.
> +
> +  The MSI writes are accompanied by sideband data (Device ID).
> +  The msi-map property is used to associate the devices with the
> +  device ID as well as the associated ITS controller.
> +
> +  rproc property (xlnx,rproc) is used to identify the remote processor
> +  with which APU (Application Processor Unit) interacts to find out
> +  the bus and device configuration.
> +
> +maintainers:
> +  - Nipun Gupta <nipun.gupta@amd.com>
> +  - Nikhil Agarwal <nikhil.agarwal@amd.com>
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-net-cdx
> +
> +  iommu-map: true
> +
> +  msi-map: true
> +
> +  xlnx,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the remoteproc_r5 rproc node using which APU interacts
> +      with remote processor.
> +
> +required:
> +  - compatible
> +  - iommu-map
> +  - msi-map
> +  - xlnx,rproc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cdx {
> +        compatible = "xlnx,versal-net-cdx";
> +        /* define map for RIDs 250-259 */
> +        iommu-map = <250 &smmu 250 10>;
> +        /* define msi map for RIDs 250-259 */
> +        msi-map = <250 &its 250 10>;
> +        xlnx,rproc = <&remoteproc_r5>;

There's no addresses associated with this bus? Like the address range 
the devices are at. You should have 'ranges' whether Linux needs it yet 
or not.

Rob
