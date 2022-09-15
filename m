Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F75B931E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIODfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIODfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73C78BE7;
        Wed, 14 Sep 2022 20:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE30262073;
        Thu, 15 Sep 2022 03:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37874C433C1;
        Thu, 15 Sep 2022 03:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663212943;
        bh=14mpXxKRo+6XuJ0Gg9ChAvQ6g/o45p4uV2lg6Nt3yTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9kQ/3FbtkzP5+q9h0RPZk5GTSWF/L03BJ+bz4dDdroqWmhANL5opzJl1DVFyqqsL
         g3thYwnwBkhDh+q2GjUAkRW3OED+VH1K6PxMqbLaKTINdBX9r4EXVGoEKzHYlFCRuN
         U81okINiT5Ypm0kOsAFjxt+VO0AjGRPegb1uyP+tke7rf1oqb8kDIX3KV6CW/NG7t2
         X+4+BpB72l/UoMUspLU0EKguacM+J6PkAIgRYouz9BUOH7OdUHzVVwSeMC0jV5+H5B
         X9kVtM7yUvsRquM26ZZwKEtLgKfbOQGSVOT9T3xWoBUv9wrZqqfDbaAay+P90+wGer
         zyq9QQxupUNHQ==
Date:   Wed, 14 Sep 2022 22:35:40 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
Subject: Re: [PATCH V9 1/7] dt-bindings: Added the yaml bindings for DCC
Message-ID: <20220915033540.jb4q4bjd3oomsfl4@builder.lan>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
 <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:31:11PM +0530, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> new file mode 100644
> index 0000000..b7a6619
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Data Capture and Compare
> +
> +maintainers:
> +  - Souradeep Chowdhury <schowdhu@codeaurora.org>

Please update your email address.

> +
> +description: |
> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
> +    configuration data or system memory contents during catastrophic failure
> +    or SW trigger. DCC is used to capture and store data for debugging purpose

An empty line inbetween description and properties would be nice.

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8150-dcc
> +          - qcom,sc7280-dcc
> +          - qcom,sc7180-dcc
> +          - qcom,sdm845-dcc
> +      - const: qcom,dcc
> +
> +  reg:
> +    items:
> +      - description: DCC base register region
> +      - description: DCC RAM base register region
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma@10a2000{
> +                compatible = "qcom,sm8150-dcc","qcom,dcc";
> +                reg = <0x010a2000  0x1000>,
> +                      <0x010ad000  0x2000>;

Please remove the double space between address and size.

Regards,
Bjorn


> +    };
> -- 
> 2.7.4
> 
