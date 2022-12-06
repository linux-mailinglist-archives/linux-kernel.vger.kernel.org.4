Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7B644B26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLFSUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLFSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992DB4B3;
        Tue,  6 Dec 2022 10:19:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547D7617F2;
        Tue,  6 Dec 2022 18:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEF4C433D6;
        Tue,  6 Dec 2022 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350780;
        bh=5IIMsF3hyMhRWR1C0sOBc5Q+GX2fXKnSorHbhuPPsrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+/luLFArmMBihoJ/T5ti21pasRUOs7wlBPKIOKYVSJobl4pfhykrsSYe3DPdLDjQ
         SvEOOaxHxchf7hKOhXAR9brEb14N5TM6laHnrhGWPY/usdeHoOx19dhjvoKtie/1Bx
         Oie/lBe4a24l/2ErWyfe1MScQBCfKPlJTahnk2ciOJPs+viDvxUiMTqAplLxVrX8dv
         4+3ING3BhjEY3JvWV1f9BROnsAw89WFSvneZahvjQGaLh40M7r797C9pCMIZfNX+HF
         F1D9Gtl+qX95viCm2mILsoY0/2WfNYvekVW2hH8yVEZ8UFD9rpzTUBgr3IU8O4jpyE
         FQRguYePYm3Sg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@kernel.org,
        dmitry.baryshkov@linaro.org, devicetree@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Cc:     robimarko@gmail.com
Subject: Re: (subset) [PATCH 1/2] phy: qcom-qmp-pcie: split pcs_misc init cfg for ipq8074 pcs table
Date:   Tue,  6 Dec 2022 12:18:46 -0600
Message-Id: <167035076325.3155086.2621246704414752041.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221103212125.17156-1-ansuelsmth@gmail.com>
References: <20221103212125.17156-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 22:21:24 +0100, Christian Marangi wrote:
> Commit af6643242d3a ("phy: qcom-qmp-pcie: split pcs_misc region for ipq6018
> pcie gen3") reworked the pcs regs values and removed the 0x400 offset
> for each pcs_misc regs.
> 
> This change caused the malfunction of ipq8074 downstream since it still
> has the legacy pcs table where pcs_misc are not placed on a different
> table and instead put together assuming the offset of 0x400 for the
> related pcs_misc regs.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: ipq6018: improve pcie phy pcs reg table
      commit: 08f399a818b0eff552b1f23c3171950a58aea78f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
