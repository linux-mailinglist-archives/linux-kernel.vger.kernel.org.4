Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C83667A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjALQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjALQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C76389C;
        Thu, 12 Jan 2023 08:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA7F6208B;
        Thu, 12 Jan 2023 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE42C433F2;
        Thu, 12 Jan 2023 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673539948;
        bh=nN0UmsR4nQjr6Pe2C+5BfoRxIlTvSeYQue3M9gxh7xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKeKklGTtlgXvkGxo9oPXuL77YM6e6eEDd58lghd+ZJEb7XMMSe4JinmjKg91+NRp
         V/T1lMXu9uvTVEiBcsYYG48hux0Ncmb82SrR7BHFsxdxKETp9hZzavNd2qnhMfw3WU
         t7pnwT6NPAufY5dG4rZJ6ChLK6lO7e/zaPKR7pOD5HVDoFgJ7RrzopKW1pLguLxQTH
         2i1mj8Ea2CedTRPAVnV0MJ+c3TtDnSTGwNavOGWIvCanT+XElZek4OwA6pOuFpab+6
         9fDHrLK/jQoMF5nf+6bHdElxkFUqLOPtcPbQsvw/llQfxuZI0Grxg0p1AT+dYglj1k
         UGZdgDobSukUQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, quic_bjorande@quicinc.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Vote for CX in USB controllers
Date:   Thu, 12 Jan 2023 10:12:22 -0600
Message-Id: <167353993749.2393683.17825205360701248553.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230112135117.3836655-1-quic_bjorande@quicinc.com>
References: <20230112135117.3836655-1-quic_bjorande@quicinc.com>
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

On Thu, 12 Jan 2023 05:51:17 -0800, Bjorn Andersson wrote:
> Running GCC_USB30_*_MASTER_CLK at 200MHz requires CX at nominal level,
> not doing so results in occasional lockups. This was previously hidden
> by the fact that the display stack incorrectly voted for CX (instead of
> MMCX).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Vote for CX in USB controllers
      commit: fe07640280cd29ac2997a617a1fb5487feef9387

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
