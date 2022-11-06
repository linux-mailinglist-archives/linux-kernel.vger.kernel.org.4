Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FEF61E037
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKFDse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiKFDsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3496CE14;
        Sat,  5 Nov 2022 20:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ACB9B8091E;
        Sun,  6 Nov 2022 03:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333ECC433C1;
        Sun,  6 Nov 2022 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667706506;
        bh=iMNkY5XUiFrsfECPbiHaxPG9ZDHoXGLcq+Z6Mx7HhfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRXtzVJCCQHGWYCYrONmgB+Ixdu7B6Wao/KDhAaiKa0Z98+I6KubIuBXhuix3W1tT
         afTqHznfCKHDGJmEJZG9Jr7/uAd1B5UIoFv83y0XWtU89slZhGs8nMYVSee5RTpPZi
         nEx02thIXxb6F6Uyn8AzNumWf5QkySRp39ICNQLHcrkUdz7z8LNWgCUrt2FbD0LecL
         b80s1kI3JgTpwdEsc2nLelRGiMxjE39LdxFIr8s+k339yahjl4atU9M8gybmw4JbfP
         5RzXg1SG591OEvgpwRqDxD0OmIMKLA9WPtCH+XDaIIBvuMZyO4xjL18XydJwRTynGu
         TQrH+Bt8V4cuw==
Date:   Sat, 5 Nov 2022 22:48:23 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Message-ID: <20221106034823.quftsxs7zpvb73tv@builder.lan>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v3-4-e5e045644971@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-4-e5e045644971@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:27:56PM +0200, Neil Armstrong wrote:
[..]
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> new file mode 100644
> index 000000000000..6531c8805894
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Resource Power Manager (RPM) over IPC

It's true that there's something executing elsewhere in the SoC
acting upon the request written to the RPM memory region.

But for me the phrasing "over IPC" applies much more to the SMD/GLINK
variant than to this. So I would prefer to just name this
"qcom,rpm.yaml" and omit the "over IPC" phrasing.


Binding looks good to me.

Thanks,
Bjorn
