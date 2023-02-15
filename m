Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167B669756A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjBOE2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBOE2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:28:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F0CA12;
        Tue, 14 Feb 2023 20:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84408614AE;
        Wed, 15 Feb 2023 04:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D697C433EF;
        Wed, 15 Feb 2023 04:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676435289;
        bh=eqDHH7byHA85yMuXRFFTfu7FKWx/ReUzLKXjNGLjH3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojUs1nSR/uN7jAKVoh6a5ihA1i8FmpUWL5Iy2MRWM9C2iRiDdtO58ko8OZKVqF8TT
         u1IsVJ3wabEoMmnS9j3GKBpKdeIRAyHMyC4y7GaHjmeJH6V6dH0UVSZCZdu+MT5Vtb
         JjAt83MVzId7M2ZSvbFYWhtX79EF3QeZuuswKSVeBCrbBnp7Enr335mubZrPedKNwM
         l256m5bGOGu/jnbw4HNBUvkhbWR2lp+H15Pwq5YFYv/4GD58rbKGbndSl6t4b9WXB8
         RtBMc8vhecrOHOHHu5x0nJrNHuOW0nf3MvXhSZeAJ/in66x2LMCP8XBMO+O5gv8CV+
         /jP/9AwEyojcw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: glink: Avoid infinite loop on intent for missing channel
Date:   Tue, 14 Feb 2023 20:30:11 -0800
Message-Id: <167643540672.1154547.14260994758435224496.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214234231.2069751-1-quic_bjorande@quicinc.com>
References: <20230214234231.2069751-1-quic_bjorande@quicinc.com>
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

On Tue, 14 Feb 2023 15:42:31 -0800, Bjorn Andersson wrote:
> In the event that an intent advertisement arrives on an unknown channel
> the fifo is not advanced, resulting in the same message being handled
> over and over.
> 
> 

Applied, thanks!

[1/1] rpmsg: glink: Avoid infinite loop on intent for missing channel
      commit: 3e74ec2f39362bffbd42854acbb67c7f4cb808f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
