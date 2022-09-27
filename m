Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA95EB8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiI0DZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiI0DX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B404DB29;
        Mon, 26 Sep 2022 20:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5F361585;
        Tue, 27 Sep 2022 03:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD61DC43141;
        Tue, 27 Sep 2022 03:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248991;
        bh=bZonAAcYzPjbxgWAIwzer8elBdCorKx05VbGTfWGEiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChUgWNdCfEUYKElTZbeOm+uQxPAkp+iu0mYTMM2rQA9dElyAZGyHsmPnP7880UnFq
         3NxaYGA3ykRuyU6deClPPt6FkpGSIwJbXSWimNTX2lP/6X3J9JmLNCV+fpEXy4Cmd9
         KOSodwZ9Y8bZY9a0HonC8HmDjKkkE/vnzxwDxUxMCzmkCgSx6TdvVkvN+PwZpwsKUn
         T8CcUHM3iY0f5iRPdyVfQ54bDh5s1a10PHu3OOLG/7jDnkxqW01WfepuRYDZjsyAQE
         zpUtTnok2m7Dk7w7Zaa6AhqDKJ3i5WDY4cDiIx6LFi1kTRTec+42gm6odEndUk2P4Q
         4bxX+pVr7wJfQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, quic_c_skakit@quicinc.com
Cc:     swboyd@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH] clk: qcom: lpass: Fix lpass audiocc probe
Date:   Mon, 26 Sep 2022 22:23:02 -0500
Message-Id: <166424897970.1766486.10035457157175258141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1663673683-7018-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1663673683-7018-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 17:04:43 +0530, Satya Priya wrote:
> Change the qcom_cc_probe_by_index() call to qcom_cc_really_probe()
> to avoid remapping of memory region for index 0, which is already
> being done through qcom_cc_map().
> 
> 

Applied, thanks!

[1/1] clk: qcom: lpass: Fix lpass audiocc probe
      commit: 31e4fcf9713096c187f84bf3cb249637b8b681e1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
