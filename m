Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A51F665370
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjAKFTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAKFSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC913DF7;
        Tue, 10 Jan 2023 21:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE090B81ACD;
        Wed, 11 Jan 2023 05:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE078C433F1;
        Wed, 11 Jan 2023 05:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413794;
        bh=d79BeaLYaAmRZtpm7PXveKnuE7MZC2EDajoPN0022T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5yRLVLLWhSBRAlu+oKbWJyLuGbeZQqYK9fuBOgEMsAKrQziuDOgo0VmnckmgOPE1
         uLEurFgJNPMd2pm+F/R6HgsGty7qQ3CRYnM5YEBO9ZT5JOgMzk2O0Dqu5PHqG98xZj
         Pw7AN1IGRDSjBVU/J0oKljOZvbax2IQb3oNnxlGmZFQ4apLgVfPFIL35qJX+8vZL03
         xaNqr66ipcRXrdrYwv/u4bBLIQCmDgp4jdHzzoMTBmLNC8E0t2ciCSeidxFvR+QASW
         NcUi45n9pyvpFsPUYMvUJ5+MpBQR+ZyGRevZRx+W+cOc0JS3mXargz6I/HGVx7FE1j
         IrNmXWk+ejUeQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
Date:   Tue, 10 Jan 2023 23:09:19 -0600
Message-Id: <167341377731.2246479.6659391181878271049.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221230135044.287874-1-konrad.dybcio@linaro.org>
References: <20221230135044.287874-1-konrad.dybcio@linaro.org>
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

On Fri, 30 Dec 2022 14:50:42 +0100, Konrad Dybcio wrote:
> Some addresses were 7-hex-digits long. Fix that.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
      commit: d8b4ee9379e4b6df44bbaf6020461514b401b8f6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
