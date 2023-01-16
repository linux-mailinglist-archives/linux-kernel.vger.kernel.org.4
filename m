Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23C66C92B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjAPQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjAPQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:46:02 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004321953;
        Mon, 16 Jan 2023 08:34:03 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r9so13046778oie.13;
        Mon, 16 Jan 2023 08:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4huBua94elx+S0dnn6JlkXQ/ae6vTMdKSQQftNSDjjg=;
        b=N1aMt2OFN7Z1vwIzuCvhMANebQkZxqn+SF2aPY8lRC3x3RxOSfPxZminZrU7SAzEOs
         4SatWiHPEZs0hk37jEMUdnfoZpBAwANEpHDQvqpoRAAHIs54GrDg5GprogvlGj+/zWGe
         Hk9q+CSavrCz37eqHP/vCHeWClqa6T2Hw80RItkOEsq7tA6BIabgZH7RRvDPPOhMWgzV
         9LF+dxJFXFHXKNsf8d9O56ZV5sUWWpJVVrNj8EZzSF6gkkJ7boGO8yMPenO7d+05cgOd
         E7ikUo64WcGOuvHOvrB2/YO3ypRS20+ja1Uc6rvNV0mMmuq2KTpjddPB3waHQBqgRakc
         NJJg==
X-Gm-Message-State: AFqh2kqcpWHEXVKBgh9gOap0y/+PpMYtrnnRIzU9itftBYMdVTgjWut/
        9OR28LSz+3ySZaRq4MnNZg==
X-Google-Smtp-Source: AMrXdXvijm6IULxGaKfPRggOh9kVhDpjnGY/kyDVbaab+Gai7JUFuW7J/tR5M+GetLrDA+kg+eZ8ew==
X-Received: by 2002:aca:180a:0:b0:364:5934:1126 with SMTP id h10-20020aca180a000000b0036459341126mr10460258oih.45.1673886843098;
        Mon, 16 Jan 2023 08:34:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bi38-20020a05680818a600b00353fe4fb4casm13107743oib.48.2023.01.16.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:34:02 -0800 (PST)
Received: (nullmailer pid 602566 invoked by uid 1000);
        Mon, 16 Jan 2023 16:34:01 -0000
Date:   Mon, 16 Jan 2023 10:34:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com
Subject: Re: [RFC v4 1/5] dt-bindings: usb: Add bindings to support multiport
 properties
Message-ID: <20230116163401.GA2371990-robh@kernel.org>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115114146.12628-2-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 05:11:42PM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 6d78048c4613..3ea051beb2f8 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -81,15 +81,26 @@ properties:
>  
>    phys:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 8
>  
>    phy-names:
>      minItems: 1
> -    maxItems: 2
> -    items:
> -      enum:
> -        - usb2-phy
> -        - usb3-phy
> +    maxItems: 8
> +    oneOf:
> +    - items:
> +        enum:
> +          - usb2-phy
> +          - usb3-phy
> +    - items:
> +        enum:
> +          - usb2-phy_port0
> +          - usb2-phy_port1
> +          - usb2-phy_port2
> +          - usb2-phy_port3
> +          - usb3-phy_port0
> +          - usb3-phy_port1
> +          - usb3-phy_port2
> +          - usb3-phy_port3

usbN-portM

>  
>    resets:
>      minItems: 1
> @@ -360,6 +371,22 @@ properties:
>      description:
>        Enable USB remote wakeup.
>  
> +  num-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This property indicates the number of ports present on the target that
> +      are to be serviced by the DWC3 controller.
> +    minimum: 1
> +    maximum: 4
> +
> +  num-ss-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This property indicates the number of SS capable ports present on the
> +      target that are to be serviced by the DWC3 controller.
> +    minimum: 1
> +    maximum: 4

This information is redundant. 'phy-names' tells you how many ports of 
each.

> +
>  unevaluatedProperties: false
>  
>  required:
> @@ -388,4 +415,18 @@ examples:
>        snps,dis_u2_susphy_quirk;
>        snps,dis_enblslpm_quirk;
>      };
> +  - |
> +    usb@4a000000 {
> +      compatible = "snps,dwc3";
> +      reg = <0x4a000000 0xcfff>;
> +      interrupts = <0 92 4>;
> +      clocks = <&clk 1>, <&clk 2>, <&clk 3>;
> +      clock-names = "bus_early", "ref", "suspend";
> +      num-ports = <2>;
> +      num-ss-ports = <1>;
> +      phys = <&usb2_phy0>, <&usb3_phy0>, <&usb2_phy1>;
> +      phy-names = "usb2-phy_port0", "usb3-phy_port0", "usb2-phy_port1";
> +      snps,dis_u2_susphy_quirk;
> +      snps,dis_enblslpm_quirk;
> +    };

Does a different number of phys really need its own example?

Rob
