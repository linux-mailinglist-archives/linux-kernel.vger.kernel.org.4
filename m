Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1F6C0B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCTH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCTH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:28:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AE8A57;
        Mon, 20 Mar 2023 00:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97B09B80D4C;
        Mon, 20 Mar 2023 07:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C57AC433D2;
        Mon, 20 Mar 2023 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679297303;
        bh=QDq3psYYPI1XmtNVdVpK0cyJmaeS12aYbyEfukWS36E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDCbyys/slXK5DDVUObA4SBOtaa8YAdB+OqCPeP8nqwHsxDAIDCkfBEfiwUMGiTaD
         LqQr2CiMvEgVlJJb9IlBF7wGYguOlmGF1rypy6g5LLDuCGvWayecp943rG5xBP/0lz
         wTFXv8W5NHwRND1G5ozBAXND4N8DtGAXT369dsE08VAGO7qVTfrRn9opP/A1j21Ahr
         ICpJ2yWfq7NTOui/uxyfuGiqNjpJ4Q/RWBda9DTaudL497rqozGJGEg5iG1vOFzF/K
         T7pHENHw1+U7982Jg3wJkPY3sDtBpV7boFEo1y00D/xVPbgIIOfjQgl06kZwcalgtc
         9aJUhZA2qThvg==
Date:   Mon, 20 Mar 2023 12:58:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     rashmi.a@intel.com
Cc:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@kernel.org,
        yuancan@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com,
        kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v2 4/4] dt-bindings: phy: intel: Remove Thunder Bay eMMC
 PHY bindings
Message-ID: <ZBgLEv9FMphyaHyO@matsya>
References: <20230316120549.21486-1-rashmi.a@intel.com>
 <20230316120549.21486-5-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316120549.21486-5-rashmi.a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-23, 17:35, rashmi.a@intel.com wrote:
> From: "A, Rashmi" <rashmi.a@intel.com>
> 
> Remove Thunder Bay specific code as the product got cancelled
> and there are no end customers or users.

Applied, thanks

-- 
~Vinod
