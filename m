Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031446327D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKUPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiKUPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B67C77F;
        Mon, 21 Nov 2022 07:23:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A004A612A0;
        Mon, 21 Nov 2022 15:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA66C433C1;
        Mon, 21 Nov 2022 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669044220;
        bh=QQw8NxuV8G4Qi2Nafk+TR8YSN0dQyB1OpYIiPoiXKG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JhTVilP0jmaBMOHakjdhfUVVZlW4tP3isgRF5S8XzQvcJPkJTcTUijQsfSr/i+m8n
         S31YVTsEx9jpFiAwhSQp950pCO00gvQdISUOvATioTlGkhbbtM8MZXENUQQvcuUSJ7
         +s4w5qP0uIryz9YnR0kO39Do1eKUkpZ2ZzYID/JC5OGnO1XpnDywdN5yYzjxB466p/
         a5pSKrm+LeYQZVmcbqVq98hoEXJJQ+AZVX9B1xW80wOvpDve+SNJRSzne49eIZ8qy0
         Y4Rii3W2Qy6gy5gTd4+WyjloZ7cta1dqSPfhBhcUrHNRVG0X7e2wtf6rs3usPUWgnT
         xyEWr2PIA9J4Q==
Message-ID: <3bc11449-bd5f-f4c4-98da-ebc0d7c8b309@kernel.org>
Date:   Mon, 21 Nov 2022 17:23:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221118182245.31035-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Melody,

On 18.11.22 20:22, Melody Olvera wrote:
> Add documentation for virtual rpmh devices. These interconnects
> are not controlled by the application processor and thus
> require separate bindings. Also, move compatibles for sm8450 to
> this document and add them for QDU1000/QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>   .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>   .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>   2 files changed, 55 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> new file mode 100644
> index 000000000000..5cbaa51df863
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>

This email is not valid anymore, so please replace it with djakov@kernel.org.

Thanks,
Georgi

> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
> +
> +description: |
> +   RPMh interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources. Virtual interconnect providers are not
> +   controlled by AP and do not support QoS; they should not have associated
> +   register regions.
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-clk-virt
> +      - qcom,qdu1000-mc-virt
> +      - qcom,sm8450-clk-virt
> +      - qcom,sm8450-mc-virt
> +
> +  '#interconnect-cells': true
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/interconnect/qcom,sm8450.h>
> +
> +      clk_virt: interconnect-0 {
> +             compatible = "qcom,sm8450-clk-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      mc_virt: interconnect-1 {
> +             compatible = "qcom,sm8450-mc-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index a429a1ed1006..bd474f49deb0 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -123,11 +123,9 @@ properties:
>         - qcom,sm8350-system-noc
>         - qcom,sm8450-aggre1-noc
>         - qcom,sm8450-aggre2-noc
> -      - qcom,sm8450-clk-virt
>         - qcom,sm8450-config-noc
>         - qcom,sm8450-gem-noc
>         - qcom,sm8450-lpass-ag-noc
> -      - qcom,sm8450-mc-virt
>         - qcom,sm8450-mmss-noc
>         - qcom,sm8450-nsp-noc
>         - qcom,sm8450-pcie-anoc

