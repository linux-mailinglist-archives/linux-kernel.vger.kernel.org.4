Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61D667E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjALSj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbjALSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:39:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA269519;
        Thu, 12 Jan 2023 10:11:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3ADEB81F02;
        Thu, 12 Jan 2023 18:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D532C433EF;
        Thu, 12 Jan 2023 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547078;
        bh=e9yPK7TZJvP1zoLJQk/+QeUmK3azBWzZaBFbPTCZohg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ooxc0flHYymtC64vxIBgO57px1OutEmc0gG+ScIIm2Gm0ibgCfNM4TZIniIQVwvRd
         HFYWodA9eNtwklxbIa35Z80q6587epj1OtdIDUrT2Qzb8NXT45TfhHivKubo7Y40Ko
         6CmUP9CQ1Kx3K4vT0lgslAWT1OiuDRMTAwmedVe6IQc674QKmbVGUagVgkQZdmWZX/
         R6dKWNOQPDW6eO5nBFgqQZx+bHaIht/Yz1r94xK2ZyWnWFa4OL0mURRsLzhGlcCXtA
         9gQjBRo2Q6xUKGraDc2d79ZWErpp6kMk0Zy9fgbMCnPzJLMdBVOitV5C/Hkq7dj6Dw
         zumkcz+vgp8xA==
Date:   Thu, 12 Jan 2023 23:41:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
Message-ID: <Y8BNQZ/CFljuxsSL@matsya>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-22, 19:39, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
> The newer Qcom platforms support configuring the UFS controller and PHY
> in dual gears (i.e., controller/PHY can be configured to run in two gear
> speeds). This is accomplished by adding two different PHY init sequences
> to the PHY driver and the UFS driver requesting the one that's required
> based on the platform configuration.
> 
> Initially the ufs-qcom driver will use the default gear G2 for enumerating
> the UFS device. Afer enumeration, the max gear supported by both the
> controller and device would be found out and that will be used thereafter.
> But for using the max gear after enumeration, the ufs-qcom driver requires
> the UFS device to be reinitialized. For this purpose, a separate quirk has
> been introduced in the UFS core along with a callback and those will be used
> by the ufs-qcom driver.

The series lgtm. This fails for me to apply though due to other patches
I have picked up.

Can you please rebase the phy patches and send those 

-- 
~Vinod
