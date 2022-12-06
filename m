Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB37644B55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiLFSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLFST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05E1F630;
        Tue,  6 Dec 2022 10:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01535B81B2E;
        Tue,  6 Dec 2022 18:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C6BC433C1;
        Tue,  6 Dec 2022 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350793;
        bh=JHubjQLH0ssWmLHugYbapmZtn6ZYmdiMM5ybOrx/NpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHOwUZjavmQYqTTJieMYijZYAfxoGLOvITPenjVjLZvoYUmX6mtKvLg3i0L1MjXpO
         D8nZsWPsVRPluND9SwNV67bpqW2+4Bsn5Co3Py5IiaKv4RJVjxF1bYme4++xW3/GxJ
         N09FZx8MOZ1jlLtlBN5tDSSqQAV1180O5RLvODgZ6G2xAnvX1vb6cDB9Nmhk2OLVsX
         sgpo10FeOC6heiRBisknqmvvcXzod19cyraosDLsp5nvKHj3+kiQhsWnFjQ+6naOhF
         g1CMOs/LJhg27uJ8R0B3QtPA6FUdtn+B8Amesn3fQ+wU46gzfpnn9k/4TuchACC3Al
         Umn+W0fg7xHJw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org,
        bvanassche@acm.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: sc8280xp: fix UFS DMA coherency
Date:   Tue,  6 Dec 2022 12:18:57 -0600
Message-Id: <167035076357.3155086.13854105575228009158.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221205100837.29212-1-johan+linaro@kernel.org>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
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

On Mon, 5 Dec 2022 11:08:35 +0100, Johan Hovold wrote:
> The SC8280XP UFS controllers are cache coherent and must be marked as
> such in the devicetree to avoid potential data corruption.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   dt-bindings: ufs: qcom: allow 'dma-coherent' property
>   arm64: dts: qcom: sc8280xp: fix UFS DMA coherency
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sc8280xp: fix UFS DMA coherency
      commit: 0953777640354dc459a22369eea488603d225dd9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
