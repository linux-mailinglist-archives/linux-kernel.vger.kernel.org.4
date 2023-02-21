Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA269DC93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjBUJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjBUJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6FF23858;
        Tue, 21 Feb 2023 01:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E94DB80E8D;
        Tue, 21 Feb 2023 09:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE21C433D2;
        Tue, 21 Feb 2023 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676970630;
        bh=Hn9TPpjqKTRxQ6qlSumVmg6aQMvan7+ZcCq/+AA0Ifs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reFQHf2gyUmC0ij5RjwLjdTvtcAjlrCEazW1AQk2LEODnxp6vAWdxZXUxyNFoq60C
         t/g5SwiOWaRDZqd3clBkgxcP/0icu1K9N1KDIdVjSVhzs5mm1qDxNzaaiBNX8ILL5d
         Fdtt+kgp6bdNue7DVjxVzp4VwzzIiFWiSxDA4ijU/cSdVesBrSMaEamksTcwW06EVf
         qcFlyud1ZzhoQtyq1acmR9WCklUOIwE0ZRW84t0ksSj5KIso3CeW4x5v1pOpWhZB57
         DT8xaoJY8/Td/W0J/6PROT+sAd2yv6Wra6bGMsxWaO2RZp6gxDdyfTZOlL3zJvB1l7
         LFnPWbOwxHkhg==
Date:   Tue, 21 Feb 2023 09:10:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Message-ID: <20230221091024.GA26703@willie-the-truck>
References: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
 <bb6f65a0-a4af-c9e6-ddc8-6ff06452c9dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb6f65a0-a4af-c9e6-ddc8-6ff06452c9dc@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:26:39AM +0100, Neil Armstrong wrote:
> On 08/02/2023 10:13, neil.armstrong@linaro.org wrote:
> > From: Abel Vesa <abel.vesa@linaro.org>
> > 
> > Add the SoC specific compatible for SM8550 implementing
> > arm,mmu-500.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> > Changes in v3:
> > - update allOf:if: for disallowing clocks
> > - Link to v2: https://lore.kernel.org/r/20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org
> > 
> > Changes in v2:
> > - Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
> > - Dropped driver changes since we rely on qcom,smmu-500 fallback
> > - Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
> > ---
> >   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
> >   1 file changed, 2 insertions(+)
> 
> Do you think you can pick this patch for v6.3 ?

This is 6.4 material now (I sent my SMMU pull request for 6.3 weeks ago
[1]).

Will

[1] https://lore.kernel.org/linux-iommu/20230124142957.GA26873@willie-the-truck/
