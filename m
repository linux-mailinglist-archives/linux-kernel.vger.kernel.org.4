Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479AD6953D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBMWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjBMWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D61EBE5;
        Mon, 13 Feb 2023 14:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A3EB81990;
        Mon, 13 Feb 2023 22:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C9BC433A1;
        Mon, 13 Feb 2023 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326872;
        bh=8oN0F3hRVKt/dFknr9686lGepBv5AWcCCCg6he0sI24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BngfERpHsoTxySdPGwJEg6LcJzQfU88P11Ju0IoKXH49lhnKSSfSUEgWH/D3Fj9U+
         SMDlSnN0/ToOOqgeUYroJ33uiYUqgRkI0nw4NuF3VpAC2j739aI0YSKGk1jto5wA1e
         h5+5w8GKhEF1VP80FYaK7CWdF8fF1n9akVQwBgZdAtQS9sw6Ek4p5TgZ/u7GBxHp5t
         HOilochIDfM9S6yYkdtVYmiyt2tvv1dFSVN0W46axsuoE6k7XcjmVBr0ke6CsuPOEb
         NDfrWlG9G5fATCKS0E0GuwNVXQUfSqZST636j5iqXLh5vzTKZpzXeZVRLZfuNO3s/+
         r0Iyl+BS+X5Wg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5] power: supply: Introduce Qualcomm PMIC GLINK power supply
Date:   Mon, 13 Feb 2023 14:23:08 -0800
Message-Id: <167632698310.557014.1588583713960967711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207144241.1767973-1-quic_bjorande@quicinc.com>
References: <20230207144241.1767973-1-quic_bjorande@quicinc.com>
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

On Tue, 7 Feb 2023 06:42:41 -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The PMIC GLINK service, running on a coprocessor of modern Qualcomm
> platforms, deals with battery charging and fuel gauging, as well as
> reporting status of AC and wireless power supplies.
> 
> As this is just one of the functionalities provided by the PMIC GLINK
> service, this power supply driver is implemented as an auxilirary bus
> driver, spawned by the main "pmic glink" driver when the PMIC GLINK
> service is detected.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Introduce Qualcomm PMIC GLINK power supply
      commit: 29e8142b5623b5949587bcc4f591c4e6595c4aca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
