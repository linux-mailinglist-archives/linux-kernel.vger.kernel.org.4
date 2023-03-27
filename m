Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0A6C9AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC0Fjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC0Fjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF14C02;
        Sun, 26 Mar 2023 22:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 949C660FC4;
        Mon, 27 Mar 2023 05:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF2C433EF;
        Mon, 27 Mar 2023 05:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679895582;
        bh=ThnZd8FO9ECrNL3YLRyB7v1hW/v0+nNQPMF7bwNZ5ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBYzAFgkj59cSfbNgjIGAa7J5PLiv/hHQ0ArVwUq3mwDBARFdzg1LITyRsD/dozAH
         q38ikWOMjhBHhIrVLABtlMZgOSQS6dM4GUz6VoZxxtRd/V92M7P1NuFC9F3EXVWLPX
         Dgfc2X1cBWqlad8qPIr86nAOsRDQvlboqWX2ekBvHVtvS7P39dnzm6LS4ZNeMR19gd
         KRAakPNY1AVIFMkTgBGp5OueqR61ro3l/iGSCZEmKudviVfIdQ1sjaJ3FuZLzkaxfB
         h8zndUpevjftlA0usbomrRktc6wX9cbGWIuen163leTiKV2PeniUcjoQ18acZL8FBd
         pQOPRuQzVX00w==
Date:   Mon, 27 Mar 2023 11:09:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sc8180x: Introduce Primus
Message-ID: <ZCEsGoOyso4IHPxY@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-12-vkoul@kernel.org>
 <967154b6-97a7-0c43-52cc-746274694c18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967154b6-97a7-0c43-52cc-746274694c18@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-23, 13:36, Konrad Dybcio wrote:
> 
> 
> On 25.03.2023 13:24, Vinod Koul wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Introduce support for the SC8180X reference device, aka Primus, with
> > debug UART, regulators, UFS and USB support.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> Please introduce PMICs in a separate commit. On top of that,
> the previous patch (in a very slim and basic version) should
> have been combined with (a very slim and basic version) this
> patch so that we don't introduce code that never compiles.
> 
> And the patches are missing your (as the sender) S-o-bs.

Yeah not sure how that got missed, thanks for checking

-- 
~Vinod
