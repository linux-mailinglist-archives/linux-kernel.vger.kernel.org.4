Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAD666411
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjAKTuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjAKTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3121277C;
        Wed, 11 Jan 2023 11:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7B361E11;
        Wed, 11 Jan 2023 19:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88271C433D2;
        Wed, 11 Jan 2023 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466558;
        bh=BVWgNHxiw47ZvwtJJaBc2xW7w1EmjS97P5UQfS7vOLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lA0rRHMBcnGxdwhe3Vb77SAodnM6yXRKyWMlarD+oYoSMpxkRrachS3x5AldBqu4T
         p6GNkOqOfVZVJ/mEqVMfpZkmG03V9KRg5+XFHP4tYYJrk3HlxAYRrwGipmfBwqzcdl
         hocIhHzMMcef95/mS4SeSZk1YxxKJQjbtMwKla0eADTXran/Yibfz5cpSb4+JOUfDd
         DSUoH7ctWCn1kuhdaZk6W7vKd3h/Yd53wdIv7oieWsssre36Q6bvBaaHTgdiN9eLKY
         XfQQnmYWUnFUhSvHCgTNNxaxuP9mxacv1pTb4gcDvDBIL4JLCXbIfRANgyC3tfHp0o
         launZuB8XyUIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, quic_bjorande@quicinc.com,
        johan@kernel.org
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/4] arm64: dts: qcom: sc8280xp: Enable display
Date:   Wed, 11 Jan 2023 13:49:07 -0600
Message-Id: <167346654439.2315924.14828300044435518731.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
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

On Tue, 10 Jan 2023 19:59:02 -0800, Bjorn Andersson wrote:
> The display subsystem and display port drivers for SC8280XP has been merged, so
> they are dropped from this series.
> 
> The necessary defconfig update is also added to the series.
> 
> Bjorn Andersson (4):
>   arm64: dts: qcom: sc8280xp: Define some of the display blocks
>   arm64: dts: qcom: sc8280xp-crd: Enable EDP
>   arm64: dts: qcom: sa8295-adp: Enable DP instances
>   arm64: defconfig: Enable SC8280XP Display Clock Controller
> 
> [...]

Applied, thanks!

[4/4] arm64: defconfig: Enable SC8280XP Display Clock Controller
      commit: 41ddfbda83f23a7b007cf307409a17e3ece177c6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
