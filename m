Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2E6485BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLIPnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLIPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:43:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0885D2314A;
        Fri,  9 Dec 2022 07:43:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EE762296;
        Fri,  9 Dec 2022 15:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED432C433D2;
        Fri,  9 Dec 2022 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670600582;
        bh=oCEIGuHeYhxQrCwVo/soAElAtMLWGb4yuO0SHkYdARw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ik/yRMpIxgLkVL0fgXhIFgSsHW8u0esK0EQWhBy/bY5hAzu3m1YsNUwdBhGcXoYrE
         hCAkf3JzdJXtnU/SR6apKalZFVs21lPhQzUnJZ62pfj2KGJgt6sHUWfM/YZZw7FxDb
         7PR6OBtqptEbYnTbj782MsCVZE9I95cyUQIvJN0dK8q4j6upYgVSinVBzmUm/6xd+G
         PTkMdvx6ftPR1+IWfZlV4ynHnswJ+nTJ0N4WcPIgcXtuu3dSS6ja6V+pFI9mkjtmNl
         Hc7eoVYYCazXTNYgvi4LEW4fHChYVwzDEe8kqksIwObb48uG16qkF+MIwPEjOaTDa7
         seddbxDxq4WTw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p3fWw-0001TN-5z; Fri, 09 Dec 2022 16:43:18 +0100
Date:   Fri, 9 Dec 2022 16:43:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
Message-ID: <Y5NXllrF3K+ga/GR@hovoldconsulting.com>
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:29:47PM +0100, Luca Weiss wrote:
> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
> in the bindings so the existing dts can validate successfully.
> 
> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
> sm8450: add Inline Crypto Engine registers and clock") so move the
> compatible to the correct if.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> (no cover subject)
> 
> The only remaining validation issues I see is the following on sc8280xp-crd.dtb
> and sa8540p-ride.dtb:
> 
>   Unevaluated properties are not allowed ('required-opps', 'dma-coherent' were unexpected)
> 
> Maybe someone who knows something about this can handle this?

That's being addressed here:

	https://lore.kernel.org/lkml/20221205100837.29212-2-johan+linaro@kernel.org/

Johan
