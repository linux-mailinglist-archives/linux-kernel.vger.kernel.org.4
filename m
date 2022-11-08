Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE74620625
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKHBfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiKHBfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:35:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E4318;
        Mon,  7 Nov 2022 17:35:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A916138B;
        Tue,  8 Nov 2022 01:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2523C433D7;
        Tue,  8 Nov 2022 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667871302;
        bh=CaOtS9DpigUdgBy9GcO6JpdTu6k3Z4wrn9fz0iD8uZo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YIjTOIBzzH0ivtSFAa2oIjihinZmzs3n0VpKxbbYdnbQObDE91cOdJ4UrOfbVAyf+
         cZe8w9A4DbSKl5P6AQK15XQ5UIP9PmLmS3G5mFl82L0gKG3mLfyx6y85bZdIvvTQAn
         Q/rLalSa/WG63zPA62rDBjYgu2F1XAI3MmjBctl+i8QSfGGCF5Z1Eybkota8q+3S7K
         zi7yVq1WIbwdMNQCwtq0O3Ve3SGa36c4WZdZiboDthCkpgSNQkgAv39o4Hc29FzkVi
         Pzr/TeLC0KuA6Blq3G0uh+k56qD33CZai5jj+Fj2i5/ZUCRNphCBNjmzfD7WpNJj6D
         BIR4ZFsJ13R0w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        martin.botka@somainline.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
Date:   Mon,  7 Nov 2022 19:34:59 -0600
Message-Id: <166787129211.608852.3612758150409416915.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026163646.37433-1-krzysztof.kozlowski@linaro.org>
References: <20221026163646.37433-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 26 Oct 2022 12:36:46 -0400, Krzysztof Kozlowski wrote:
> SM6125 comes with SDCC (SDHCI controller) v5, so the second range of
> registers is cqhci, not core.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
      commit: 3de1172624b3c4ca65730bc34333ab493510b3e1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
