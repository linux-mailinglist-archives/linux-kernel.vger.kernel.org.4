Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E6665399
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjAKFVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjAKFSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741D13F51;
        Tue, 10 Jan 2023 21:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9746A61A35;
        Wed, 11 Jan 2023 05:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78400C433EF;
        Wed, 11 Jan 2023 05:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413812;
        bh=5ZQkAeOwSOFdX3rARdIcp/cOkOziijQYtIOpt7jR7Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ7HCCkUnb+jW0gwWMOTJeIxbL1uFAIHWlboDjRd7JZLhQaifZ70ocqB2ybQuI9JA
         4tIa9YsJC23uBwkPEFpxpI9HjEpMwBwZUznmNp1iOxahBfoOvTKUqCA2BUpxv04mtz
         DOqDXsJ67BE6vVjC2OmEhPSWRtUt1pDyMx/3YsIcvJX8T+1EolJIubSsQKlFYrjIRu
         UrsCgibVdRJ7n8X4dpXMiHRai0Q5TyYRJAGsM3Q6FlOEcOM9p7OTQwM/zWTjUApt1L
         VxGz8oRqyXEPdqOisHzVWdf+i1w32N+7vosdXD6ofaguVZ7fGzn9PDLf/tcYQFrPaO
         bfQIE8CBbAbYQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, konrad.dybcio@linaro.org,
        angelogioacchino.delregno@collabora.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH] soc: qcom: ramp_controller: Make things static
Date:   Tue, 10 Jan 2023 23:09:37 -0600
Message-Id: <167341377717.2246479.15783192376122802527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110042004.2378444-1-quic_bjorande@quicinc.com>
References: <20230110042004.2378444-1-quic_bjorande@quicinc.com>
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

On Mon, 9 Jan 2023 20:20:04 -0800, Bjorn Andersson wrote:
> The five msm8976_cfg_* objects ought to be static, as reported by LKP
> and sparse, fix this.
> 
> drivers/soc/qcom/ramp_controller.c:235:27: sparse: sparse: symbol 'msm8976_cfg_dfs_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:246:27: sparse: sparse: symbol 'msm8976_cfg_link_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:250:27: sparse: sparse: symbol 'msm8976_cfg_lmh_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:256:27: sparse: sparse: symbol 'msm8976_cfg_ramp_en' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:262:27: sparse: sparse: symbol 'msm8976_cfg_ramp_dis' was not declared. Should it be static?
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: ramp_controller: Make things static
      commit: d45fb976f46600554e2db02ce5d16d1dff84d106

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
