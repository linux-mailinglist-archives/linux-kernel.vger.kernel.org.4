Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB6722B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjFEPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjFEPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA58FA;
        Mon,  5 Jun 2023 08:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5449262729;
        Mon,  5 Jun 2023 15:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6800C433D2;
        Mon,  5 Jun 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685979574;
        bh=sk/6csv09QzAZsCVw89hyVmoT6X4fAwVBTUDtzlCaqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3DS1aPN52xZLBz/61LYSKi/INp49YsP1ayDLaFROtPa2oVFCe98LResBzCGIcvCq
         x1IGxfu1UZStAEQwhxHjbGpHP1yTcrIndNn5I+fGppeDXX/FAb+3tboq9R5ZSHAsSk
         gByf9Z38mGx5ZghQSUExsPgj1SW3ifD6bNK2T9WytR0UQUO9M9ZdAlyHPQat0hNB0z
         w/zPUi87EKKJL7ydAD4+SB1oYcUBDEMyf2BZYEcWnW4WVUihrGcRzGi7NmX1exhaFB
         Sjbskk+Wyz86C07AoXzIpqeqQpJtw+XmOHjVJX5RP7kg2maE/HvJVqIACi9FqeKsTZ
         NtWQUN/yJqyyQ==
Date:   Mon, 5 Jun 2023 16:39:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Message-ID: <20230605153928.GB21796@willie-the-truck>
References: <20230530144931.188900-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144931.188900-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:49:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The GPU SMMU will require the clocks property to be set so put the
> relevant compatible into the adreno if-then block.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Resending with all IOMMU maintainers in CC.

I've picked up the earlier version (which is the same patch). There was
a trivial conflict with a similar change allowing clocks for the
'qcom,sc8280xp-smmu-500' device, so please check when I push out the
updated branch.

Will
