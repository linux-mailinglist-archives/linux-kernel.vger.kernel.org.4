Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B036663BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAKT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAKT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:28:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62ECD13D;
        Wed, 11 Jan 2023 11:28:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6120361DD5;
        Wed, 11 Jan 2023 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2A6C433EF;
        Wed, 11 Jan 2023 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673465297;
        bh=vAIJ0GHg5o4SzZW9cRNsyfLPkpLNFLKbeDgQ/bhEni0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd/5PqdArErFkRkpv8ZuYxRAKmhOAWyKUsvxm15+okwJPiwr7kNCXyRgF2PB0rwLI
         9plu6MUhJgxNuSl1jhEn+um/724vFLPSuwQVWxkVJlaRZSsWOYWw2VWw1NaRjTA/oI
         L7q3Tmek1bdwdCBxDOdGtEBvgYcD0QF7/EHFt3vmww3Cn5ag8rA6vp1GfT1DJ2meLd
         Pa7GkxSbsN16teIYGdGoEZaqprkK5xKmBa4TtyY/ux9o70eyNiFioRh12nYzn3Q7ju
         99cDPhqO9yO70YFPWjcuBkSiCZ0vCpPHTf6IrNUPSugfuw/8KIjgystKl0N0fKUeKT
         z8Op6y2O3fvPQ==
Date:   Wed, 11 Jan 2023 13:28:15 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
Message-ID: <20230111192815.tyavlhr4nwyblpj7@builder.lan>
References: <20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org>
 <20230110-topic-sm8550-upstream-display-defconfig-v1-1-9941c8083f10@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110-topic-sm8550-upstream-display-defconfig-v1-1-9941c8083f10@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:34:33PM +0100, Neil Armstrong wrote:
> Build the Qualcomm SM8550 Display Clock Controller driver
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 851e8f9be06d..004c379eced7 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1107,6 +1107,7 @@ CONFIG_SDM_GPUCC_845=y
>  CONFIG_SDM_VIDEOCC_845=y
>  CONFIG_SDM_DISPCC_845=y
>  CONFIG_SM_DISPCC_8250=y
> +CONFIG_SM_DISPCC_8550=y

Now that power-domains will probe defer properly, could we make this =m?

Regards,
Bjorn

>  CONFIG_SM_GCC_6115=y
>  CONFIG_SM_GCC_8350=y
>  CONFIG_SM_GCC_8450=y
> 
> -- 
> 2.34.1
