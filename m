Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F326D840E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjDEQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjDEQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:48:59 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804D3AAB;
        Wed,  5 Apr 2023 09:48:59 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id h1-20020a4adcc1000000b0053e9796cc7dso2931235oou.4;
        Wed, 05 Apr 2023 09:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713338;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7txYggN2JwlOgtYe4eHEvjrkY9LG17YWZv5dce4ogFI=;
        b=GXEJvW3djiNayPMTxsGpFxIlM0lWiVIKINTpF/VTSa4fNP0eRS113FsTd5XNrTmaRG
         sU0ATEllhVd5fPES/4wnoKzRZCKgEGAQVYDAiiZ/IA5ruFm0hQBJdchAg0+tw34ELM6g
         roVM63bxiKfs9BLBpG2+m1895ruCP55+ay5Y5ZVBQKaCcV0mkCLdYlPe7m6u3stbMmw2
         rvtRSiNdH880V7anY0ZypcC+VGqs8IQyqBDRh4ZNhxRj2B6X6jzS2O6vCHx7VoXxTpgP
         6RY2ZgfI2cw4QJ3pYPDvwOqtqZIMkuxxFLjnevmd5YFaBLQtQowNGvjnNXVag5w8rWmo
         CCgQ==
X-Gm-Message-State: AAQBX9fY/XAbRIC1i8xV40nUkbxDEBJtBU5QWVRjoCJdROtt8uYtgG54
        aqxDEQwxgZNeQwv8F97aey6Zyjn35Q==
X-Google-Smtp-Source: AKy350ZOWsoXuIh71UIF2+sLLrwOl+BpqIIgKkgejqQBZ32ulm5gvnnvuwY3zC6rOomi+M4QLEKW3A==
X-Received: by 2002:a4a:418e:0:b0:538:242e:803a with SMTP id x136-20020a4a418e000000b00538242e803amr3420413ooa.0.1680713338369;
        Wed, 05 Apr 2023 09:48:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c5-20020a4aacc5000000b00524f381f681sm6880102oon.27.2023.04.05.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:48:58 -0700 (PDT)
Received: (nullmailer pid 2821002 invoked by uid 1000);
        Wed, 05 Apr 2023 16:48:57 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>, ahalaney@redhat.com,
        linux-kernel@vger.kernel.org, quic_harshq@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_pkondeti@quicinc.com,
        Andy Gross <agross@kernel.org>, quic_shazhuss@quicinc.com,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_wcheng@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, quic_jackp@quicinc.com,
        quic_ppratap@quicinc.com
In-Reply-To: <20230405125759.4201-2-quic_kriskura@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-2-quic_kriskura@quicinc.com>
Message-Id: <168071287318.2812205.17997019926296843813.robh@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Date:   Wed, 05 Apr 2023 11:48:57 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 18:27:52 +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.
> 
> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Link to v5: https://lore.kernel.org/all/20230310163420.7582-2-quic_kriskura@quicinc.com/
> 
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:90:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230405125759.4201-2-quic_kriskura@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

