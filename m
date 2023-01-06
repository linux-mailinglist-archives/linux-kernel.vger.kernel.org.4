Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6644066060A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjAFR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjAFR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:56:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBD7D9E7;
        Fri,  6 Jan 2023 09:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF41361F0B;
        Fri,  6 Jan 2023 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A179BC433EF;
        Fri,  6 Jan 2023 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027761;
        bh=ot+tAafudNV7hoY7I2KoYwEZhq9iuC+POIAR3srNPPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VO1gdWoxPVKG1w4XeWigCGI++6zlHzV8PLbl9wH7VSr3blZwMmz8b/uKTAWyWrAij
         K4WFX3d5vgVnYL5H+2Q79lQiDGIAQq3K4yL0V5lWSem6GPyewV7gX8ZrMrbtWgyXHh
         sH5cdkvPtiz1mzY4mXWNVNC+Hc3ip1JYHL+3P1OiapEDfsa6j6Xdr718JUDLWNJmiG
         10H9sk/mROjM1vKLcN3y6xcx7ht+VmiXYhzvOFZ6T8onVM0UGvS/camNu3ep80RZgN
         qaRBbez0PQRRIHRBcg84qFawDcnagdgOTnxRX4YdXzeHtLrXpWuPEnNdMZLQKsLfxq
         UvwgT1iyh81KQ==
Date:   Fri, 6 Jan 2023 11:55:58 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: reserved-memory: rmtfs: Document
 qcom,assign-to-nav
Message-ID: <20230106175558.7sfutxaishdlwhoe@builder.lan>
References: <20230102165034.830620-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102165034.830620-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 05:50:33PM +0100, Konrad Dybcio wrote:
> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
> others really don't want that. Since it has to be conditional, add a
> bool property to toggle this behavior.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Rewrite the newly added description
> 
>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> index 2998f1c8f0db..4026788a4e40 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> @@ -31,6 +31,12 @@ properties:
>      description: >
>        vmid of the remote processor, to set up memory protection
>  
> +  qcom,assign-to-nav:
> +    type: boolean
> +    description:
> +      Whether to also assign the region to a third (NAV) VM, as opposed to
> +      the usual 2.

For better or worse, the binding currently takes the vmid of the first
instance in qcom,vmid. Would it not be cleaner to turn qcom,vmid into an
array and pass the nav vmid as a second element in that array?

Regards,
Bjorn

> +
>  required:
>    - qcom,client-id
>  
> -- 
> 2.39.0
> 
