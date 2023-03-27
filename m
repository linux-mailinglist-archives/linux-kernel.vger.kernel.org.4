Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6686CA49B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjC0Mw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjC0MwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:52:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AC173F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D28F2B811D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A993C433A1;
        Mon, 27 Mar 2023 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679921537;
        bh=ERkDPrE1t41RAkQ/wfC7GUX0HHhzIsOCq5HwwVyTEOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pb3H6HnS3ls35CnSmyWzLYbqa4xY7gJ+ODpuHIC9lt+69cXWEgPdYbJMjRRC8/yXO
         rTQMFxKC1dAkOYS/Zt9YoMjlb3cYjH21bvbxn9T041nfigSreDeLCCqIPF5tbFK1FC
         XnCBEfrWgVZKIAn7pcvXTzx9KBJKb4Thht6yqjXswouC3pbjR6EMIdu/pixvwRXyvH
         MpSX3QRyl6tOLVeVgledhX5ohLI/nbsf4FnlQ2YYzssgVF/4l9m4ho93K0SS91aS9a
         e/KshNU60hgoA+WeCd6SjfVoWet5QMHq9S+47R3YnFNS/MHnurZgI4c3QVOVZ679Yo
         abZfuCTBHfmRw==
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        steev@kali.org, iommu@lists.linux.dev, johan+linaro@kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date:   Mon, 27 Mar 2023 13:52:01 +0100
Message-Id: <167991987524.1305084.466646756285487652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
References: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 13:30:29 +0530, Manivannan Sadhasivam wrote:
> Some platforms support more than 128 stream matching groups than what is
> defined by the ARM SMMU architecture specification. But due to some unknown
> reasons, those additional groups don't exhibit the same behavior as the
> architecture supported ones.
> 
> For instance, the additional groups will not detect the quirky behavior of
> some firmware versions intercepting writes to S2CR register, thus skipping
> the quirk implemented in the driver and causing boot crash.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Limit the SMR groups to 128
      https://git.kernel.org/will/c/122611347326 

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
