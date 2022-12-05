Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817DA6436A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLEVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLEVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:16:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44813F62;
        Mon,  5 Dec 2022 13:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F19B6145B;
        Mon,  5 Dec 2022 21:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF00C433C1;
        Mon,  5 Dec 2022 21:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670274986;
        bh=2YCgsYtgXchcK2HQN9j4UPzSu5I9SAEgamI3XGdIwNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzViI502CGY9RMc9HkFPZ2iRr74SbWdCu4D9+c4rSejbfKimjFp+wxyI+ozoKzLjk
         6eg9yP+Gu5/0fsUwcgwwI43jpxqCuBk5Rdo/57F4WzvJZQz/AQcbvuh/5b9im5D+A+
         JutQF2vxoBzxuhFz/kOCYQG3E9DtW7itTK5DxeVUPJ85wG6xkDsnuue6lBtK2mZjN6
         ytV2/2uy8rm5YBxKsStNmV8UR7l8YTdvgqXlukU+PCSueCiJz23tfMaIsU29ULDlfn
         9cGRMGag+Bvz/6qJB2csMTFKPOlU/GsZs+ViuZ1iqzXd8U7gWb7/MefwaVsBSWm5G1
         nv4Mo4jCt1GZw==
Date:   Mon, 5 Dec 2022 15:16:23 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: aoss: Add compatible for SM8550
Message-ID: <20221205211623.extu4b22fsowilyd@builder.lan>
References: <20221116113128.2655441-1-abel.vesa@linaro.org>
 <adc327c7-9e99-4f2d-9641-2981b380ee47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc327c7-9e99-4f2d-9641-2981b380ee47@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:43:26PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2022 12:31, Abel Vesa wrote:
> > Document the compatible for SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Why this is not part of other SoC patches? I just received many single
> patches for this SM8550 topic. All these should be set of few series,
> not 10 or more...
> 

Because these patches are independent of each other and done in this way
means the maintainer can merge each piece on its own. I much prefer this
over having these series with 20+ patches being sent over and over
because one of the patches is getting feedback.

Regards,
Bjorn

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
