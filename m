Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F625BBCC3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIRJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIRJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:23:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A72714F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:23:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u18so42236477lfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=byqt1b1ojiY3sXCMGLeTpHoX4I7WfR2tBMiZpGWSOKs=;
        b=eud2Wzh4uwEu2eImoEGsi77nKrWpsfZryv2A+9Vn4ZT9jiNwP73gISAkMHv9eLaGqv
         OQkZ5V8If/MY39uMwCMVFrg1zQpoOYWdtP4jzelPt5gPwkQ7ZNliAuy3PMRgPgjKfoAy
         yo1YUblUPk9CZ3yNAnmb6Bq29E+dL0ldfNFUwDiGWAZHn0XFwZ3D1Wfle/JN3Rs/3KOD
         eoQbvb3vWAKQyu04Kk5rSaI2Fef82n6A77xiPb/+jLGkf9LVQoqF430KXdhMdERCIosW
         va8+2PFjj52EQp/j8krCo5DuuXcY1pT/KO9ctCirItODfatbN0clZC1AhUjZyvXeHrod
         Dcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=byqt1b1ojiY3sXCMGLeTpHoX4I7WfR2tBMiZpGWSOKs=;
        b=ndQgAq0B2pWypAQM/YyGVxjBptidDGwmh7xLMKusuks3qj0F99ES+Sn/Oe/JEH2cDv
         BaS6GSDnnjqxpWD6Q7KZ0oCkKbPlce60YIv3uAWw7pcCSU2RnWV9otOxbB1dKAg84D0e
         Cla2poQi86z2qRw0dOsXX4aDxPmgkgQVy6ILPIF+giZgi7QXrGFrLOb4gxRtr8bvbyjK
         ngJUkjlvCeCcTBJvg40QKbYI+bf2pEYEGctukUc0bf7kl+gu2LFfpQpd2CGCYqojsHh7
         K6rV0+BcrnRbqq3YE4eLtLUUYop3SZX4oGKI40XCHgfMCKKAZwfdLJHitiNB/j5/oI9T
         +psw==
X-Gm-Message-State: ACrzQf33MIlOCNA/aUGG+aVqat5Fb4OqPdWDNjdPURVoqV6jP0PJIdLv
        4aVr/o0FAp8Sj1SjsGPPgbXYUph2e5DY7Q==
X-Google-Smtp-Source: AMsMyM7o4L8ezkzMdonVp1vOb4DHjo0u/q5ypFyX4mVeYy5qPB5tEXZ716h35oPCEzXTfdvhKmrqcw==
X-Received: by 2002:ac2:4f03:0:b0:496:d15:e70c with SMTP id k3-20020ac24f03000000b004960d15e70cmr4032879lfr.102.1663492988175;
        Sun, 18 Sep 2022 02:23:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be30-20020a056512251e00b00492a0f02758sm4570105lfb.28.2022.09.18.02.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:23:07 -0700 (PDT)
Message-ID: <6f692ece-b3ac-4115-370a-3c5e255dd0f8@linaro.org>
Date:   Sun, 18 Sep 2022 10:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio,pci-iommu to DT
 schema
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916132229.1908841-1-jean-philippe@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916132229.1908841-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 14:22, Jean-Philippe Brucker wrote:
> Convert the binding that describes the virtio-pci based IOMMU to DT
> schema. Change the compatible string to "pci<vendor>,<device>", which is
> defined by the PCI Bus Binding, but keep "virtio,pci-iommu" as an option
> for backward compatibility.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../devicetree/bindings/virtio/iommu.txt      | 66 --------------
>  .../devicetree/bindings/virtio/iommu.yaml     | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
> deleted file mode 100644
> index 2407fea0651c..000000000000
> --- a/Documentation/devicetree/bindings/virtio/iommu.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -* virtio IOMMU PCI device
> -
> -When virtio-iommu uses the PCI transport, its programming interface is
> -discovered dynamically by the PCI probing infrastructure. However the
> -device tree statically describes the relation between IOMMU and DMA
> -masters. Therefore, the PCI root complex that hosts the virtio-iommu
> -contains a child node representing the IOMMU device explicitly.
> -
> -Required properties:
> -
> -- compatible:	Should be "virtio,pci-iommu"
> -- reg:		PCI address of the IOMMU. As defined in the PCI Bus
> -		Binding reference [1], the reg property is a five-cell
> -		address encoded as (phys.hi phys.mid phys.lo size.hi
> -		size.lo). phys.hi should contain the device's BDF as
> -		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
> -		should be zero.
> -- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
> -		an endpoint ID, described by the "iommus" property [2].
> -		For virtio-iommu, #iommu-cells must be 1.
> -
> -Notes:
> -
> -- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
> -  virtio-iommu node doesn't have an "iommus" property, and is omitted from
> -  the iommu-map property of the root complex.
> -
> -Example:
> -
> -pcie@10000000 {
> -	compatible = "pci-host-ecam-generic";
> -	...
> -
> -	/* The IOMMU programming interface uses slot 00:01.0 */
> -	iommu0: iommu@0008 {
> -		compatible = "virtio,pci-iommu";
> -		reg = <0x00000800 0 0 0 0>;
> -		#iommu-cells = <1>;
> -	};
> -
> -	/*
> -	 * The IOMMU manages all functions in this PCI domain except
> -	 * itself. Omit BDF 00:01.0.
> -	 */
> -	iommu-map = <0x0 &iommu0 0x0 0x8>
> -		    <0x9 &iommu0 0x9 0xfff7>;
> -};
> -
> -pcie@20000000 {
> -	compatible = "pci-host-ecam-generic";
> -	...
> -	/*
> -	 * The IOMMU also manages all functions from this domain,
> -	 * with endpoint IDs 0x10000 - 0x1ffff
> -	 */
> -	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> -};
> -
> -ethernet@fe001000 {
> -	...
> -	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
> -	iommus = <&iommu0 0x20000>;
> -};
> -
> -[1] Documentation/devicetree/bindings/pci/pci.txt
> -[2] Documentation/devicetree/bindings/iommu/iommu.txt
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.yaml b/Documentation/devicetree/bindings/virtio/iommu.yaml
> new file mode 100644
> index 000000000000..d5bbb8ab9603
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/iommu.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: virtio-iommu device using the virtio-pci transport
> +
> +maintainers:
> +  - Jean-Philippe Brucker <jean-philippe@linaro.org>
> +
> +description: |
> +  When virtio-iommu uses the PCI transport, its programming interface is
> +  discovered dynamically by the PCI probing infrastructure. However the
> +  device tree statically describes the relation between IOMMU and DMA
> +  masters. Therefore, the PCI root complex that hosts the virtio-iommu
> +  contains a child node representing the IOMMU device explicitly.
> +
> +  DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
> +  virtio-iommu node doesn't have an "iommus" property, and is omitted from
> +  the iommu-map property of the root complex.
> +
> +properties:
> +  # If compatible is present, it should contain the vendor and device ID
> +  # according to the PCI Bus Binding specification. Since PCI provides
> +  # built-in identification methods, compatible is not actually required.
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: virtio,pci-iommu
> +          - const: pci1af4,1057
> +      - items:
> +          - const: pci1af4,1057
> +
> +  reg:
> +    description: |
> +      PCI address of the IOMMU. As defined in the PCI Bus Binding
> +      reference, the reg property is a five-cell address encoded as (phys.hi
> +      phys.mid phys.lo size.hi size.lo). phys.hi should contain the device's
> +      BDF as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be
> +      zero. See Documentation/devicetree/bindings/pci/pci.txt
> +
> +  '#iommu-cells':
> +    const: 1
> +
> +required:

Also: compatible

> +  - reg
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie0 {

Node name: pcie

> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +

device_type and then you will see a bunch of warnings.

> +        /*
> +         * The IOMMU manages all functions in this PCI domain except
> +         * itself. Omit BDF 00:01.0.
> +         */
> +        iommu-map = <0x0 &iommu0 0x0 0x8
> +                     0x9 &iommu0 0x9 0xfff7>;
> +
> +        /* The IOMMU programming interface uses slot 00:01.0 */
> +        iommu0: iommu@1,0 {
> +            compatible = "pci1af4,1057";
> +            reg = <0x800 0 0 0 0>;
> +            #iommu-cells = <1>;
> +        };
> +    };
> +
> +    pcie1 {

Node name: pcie (so probably you will need unit address and reg)

> +        /*
> +         * The IOMMU also manages all functions from this domain,
> +         * with endpoint IDs 0x10000 - 0x1ffff
> +         */
> +        iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> +    };
> +
> +    ethernet {
> +        /* The IOMMU manages this platform device with endpoint ID 0x20000 */
> +        iommus = <&iommu0 0x20000>;
> +    };
> +
> +...


Best regards,
Krzysztof
