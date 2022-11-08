Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09016208B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKHFCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiKHFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:01:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E16BB6;
        Mon,  7 Nov 2022 21:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F3D7B818B3;
        Tue,  8 Nov 2022 05:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEA8C433D6;
        Tue,  8 Nov 2022 05:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667883712;
        bh=uY2J6/i7ChrGZanEOQgMgV6TUMGexsT52cLvRz/45UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gC5Y0e2umNjAhS6ck9kN60FveHqnT5Xf6gYjQd9awLkOD5WD0Aa0C8HUBp337qF3m
         RDCImOipjQmodOaxkv+a4qOe/Owmb0k1pa0pGZv0bi7XnV9orraUKvq+oxldNASEOq
         BNStE9XXJ6Btw7diToZ4NkK1J+mf7t4WMoc7JeE8N+ogqBmrppvJlLyJVZLHW7ohlm
         dEBRUBJl2XinvAy//MLpVY3eHxyDXaWpJR4/Xeqi90DKA5Oazl3iBg1Kie1ip9Cvsw
         1PY7ZfA8xMUtfh8u7/FcdtzLuLQgKeyJE11qBrS3BGK0tf06JxuiawGU7ZOhxBhhJx
         AJm5YEXapuL5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, angelogioacchino.delregno@collabora.com
Cc:     Tony Luck <tony.luck@intel.com>, keescook@chromium.org,
        marijn.suijten@somainline.org, a39.skl@gmail.com, lee@kernel.org,
        robh+dt@kernel.org, kernel@collabora.com, ulf.hansson@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.sharma@linaro.org, gpiccoli@igalia.com,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        jic23@kernel.org, srinivas.kandagatla@linaro.org, lars@metafoo.de,
        luca@z3ntu.xyz, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/9] MSM8956/76 and Sony Xperia X / X Compact support
Date:   Mon,  7 Nov 2022 23:01:49 -0600
Message-Id: <166788370693.629864.14863450709842430879.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
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

On Fri, 4 Nov 2022 18:21:13 +0100, AngeloGioacchino Del Regno wrote:
> This series adds basic support for MSM8976 and its lower spec variant
> MSM8956, along with two devices: the Sony Xperia X and X Compact.
> 
> For now, even though I do have a tree in which these two devices are
> fully booting, only a basic console boot is provided as the rest is
> awaiting cleanup and some more dependencies.
> Especially every device requiring IOMMU support, like MDSS, MDP and
> Adreno GPU cannot work with the current qcom_iommu driver, as it
> needs some code to get the ASIDs right for MSM8956/76.
> 
> [...]

Applied, thanks!

[4/9] dt-bindings: soc: qcom: qcom,smd-rpm: Use qcom,smd-channels on MSM8976
      commit: fe7e7def2ffc2962644de7abccf2ce85b5f07509

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
