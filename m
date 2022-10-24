Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DECD60AE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiJXPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiJXPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6518378;
        Mon, 24 Oct 2022 06:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF70E6135F;
        Mon, 24 Oct 2022 13:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB6DC433D6;
        Mon, 24 Oct 2022 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666618959;
        bh=npUzDokCFKIiAdimAhqsnveOhFiTo1EqmOPDHREtYdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7AVxxYhF2t/RdYjyJwiIwwzuUKTTWjPw81iADE5FKer/+H94HdXLq5u3gtUh2h1C
         2fFveOPOe4CZI8lPgratIhREPY8y9sUlkXzoTabq7KPUbfbBWYh2T7Au45fd5AOuXm
         prAeRwBUS9pI3lYoD96ikKD5vwT/2Sxl0qH1bj16yIX2nLsI4ursC/5yjHuDBRBxow
         KyeRVoou9G40FU33poXoMRVAkBGypu5BWKw5hhU2qXz0bYqJwQ+3RZGJ9RzRy4Xd1B
         J38qTF2NUGNQ7J07DX8SWgZ0BCgvjdVBD2Qcm8/SuX824sjxqu/3It5khgOVQsaQsL
         nNvg6ei638N7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1omxig-0008VC-Oj; Mon, 24 Oct 2022 15:42:22 +0200
Date:   Mon, 24 Oct 2022 15:42:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: add TCSR node
Message-ID: <Y1aWPhP7/ft8s+bh@hovoldconsulting.com>
References: <20221024125843.25261-1-johan+linaro@kernel.org>
 <94e05a63-e7f3-a78f-d0a6-8efcae619726@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e05a63-e7f3-a78f-d0a6-8efcae619726@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:34:22AM -0400, Krzysztof Kozlowski wrote:
> On 24/10/2022 08:58, Johan Hovold wrote:
> > Add the TCSR node which is needed for PCIe configuration.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
> 
> Please send the patches together with the binding. There is no need to
> have this split and it causes additional effort during review - lookup
> of the binding.

I was under the impression that the dts changes should be submitted
separately from the binding as they go through different trees. (And
last time I posted them together the subsystem maintainer ended up
taking also the dts changes by mistake).

The binding has been picked up by Lee now so I posted the dts change.
Could have added a lore link though.

> Also additional effort during binding review - lack of usage of bindings.
> 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Johan
