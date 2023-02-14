Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D6696C05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjBNRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBNRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:50:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573F1C58F;
        Tue, 14 Feb 2023 09:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BD9617C7;
        Tue, 14 Feb 2023 17:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9709C433EF;
        Tue, 14 Feb 2023 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397022;
        bh=gVWfNS9bFuITErua/q4NQzGP4jnrM0MQLwshGiQMrII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXJ/aMsfY/OV9tE0eOGc6q7gUfBkObODPrSGuIdNcT5CeJ4t+lK1xag+vDY8Ah99e
         tBel1WVVq4tQZpeT01nt3cwyaot/kxI96+1Zyobon92hkBnhWb9TZrdNejmuLLkAgJ
         R0O8xXU84MQCKq7tkmPQTSFWAJuNFCfsEpm2HjaspcYsKCmXaR2w6Ejcf/YfFD5rR2
         tq/CEoycDMAZswtULVgTNrNECxtNsbj8vyPpeBPAFa8ImZrQrvKmpZvAkNJhwzoFvX
         KMNz3RHrFG7Ur4g8cepY1R+HZoXDsloELq3ePQYtaQUlLXMzk5yxcjMBr+KTECEK0R
         8BB92SCMSqdEA==
Date:   Tue, 14 Feb 2023 09:52:26 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: soc: qcom: aoss: Document
 power-domain-cells for aoss
Message-ID: <20230214175226.e3sstj6pk3naavbr@ripper>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-4-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213185218.166520-4-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:52:12AM -0800, Melody Olvera wrote:
> Document "#-power-domain-cells" field for aoss devices as required
> by power-controller bindings.
> 

99512191f4f1 ("soc: qcom: aoss: Drop power domain support") was merged
in v5.16, so I don't think this is correct. Please let me know if I'm
misunderstood your intent.

Thanks,
Bjorn

> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
> index ab607efbb64c..bcfa8e2e6a04 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
> @@ -60,6 +60,9 @@ properties:
>      description:
>        The single clock represents the QDSS clock.
>  
> +  "#power-domain-cells":
> +    const: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -97,6 +100,7 @@ examples:
>        mboxes = <&apss_shared 0>;
>  
>        #clock-cells = <0>;
> +      #power-domain-cells = <1>;
>  
>        cx_cdev: cx {
>          #cooling-cells = <2>;
> -- 
> 2.25.1
> 
