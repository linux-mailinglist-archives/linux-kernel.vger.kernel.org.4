Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51507696B82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjBNR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjBNR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:28:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FA35A7;
        Tue, 14 Feb 2023 09:28:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9721CB81E4A;
        Tue, 14 Feb 2023 17:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F8C4339B;
        Tue, 14 Feb 2023 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395698;
        bh=yiAILAJmg9xgfD7FAIcgVGbrN8PNZm2XqZaijsJEnpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jm0SZYXACEPN5nd16ZObfOSPPXAElVri8SQA2k0TTeLj2Engpu4brhGpjA5PY3W5l
         MQe9Pee9yrr5y5jQnA0ApNd01sJ8WRj9CEEsLaQrFc8v1AzlOo25SiBD+ooLUKNLoO
         rNeo6HF+l9DQbvnvNNvDRvQDluJUXwYq2daEM8XXzqZ85SPNP7UniLGyXT5uSTUFz3
         vr7M/SOev+81xIkcIcrzNC8067lAoHMjLoARtNMU8F+xAN/9SKQ9K77/URDFAljpzl
         Rvp3e5Cy9k2ZNTZr1ceKP8zmUZeWjgw6X6xxc+j4brYolCFruhR0WRptRKvh5F1vu6
         2ErBK2Xi2I00w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 0/6] rpmsg: glink: Misc improvements
Date:   Tue, 14 Feb 2023 09:30:17 -0800
Message-Id: <167639581473.996065.11996915356480231505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 07:52:09 -0800, Bjorn Andersson wrote:
> This series refactors glink_native to move IRQ and mailbox handling to SMEM and
> RPM driver, in preparation for more work. It then introduces the logic to fail
> glink transactions and pending intent requests in the event of the edge being
> torn down.
> 
> Bjorn Andersson (6):
>   rpmsg: glink: Extract tx kick operation
>   rpmsg: glink: smem: Wrap driver context
>   rpmsg: glink: rpm: Wrap driver context
>   rpmsg: glink: Move irq and mbox handling to transports
>   rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
>   rpmsg: glink: Cancel pending intent requests at removal
> 
> [...]

Applied, thanks!

[1/6] rpmsg: glink: Extract tx kick operation
      commit: 8278fd3144779d883779d1f5bcbf49da36587fd1
[2/6] rpmsg: glink: smem: Wrap driver context
      commit: ab9fdd41d970c38ddc0fd59e5f8f37e8d966d454
[3/6] rpmsg: glink: rpm: Wrap driver context
      commit: 178c3af447f92c58d5b1153df2cd02b755c083c8
[4/6] rpmsg: glink: Move irq and mbox handling to transports
      commit: f424d1cbe8c7ef78a4b639502fa9904c4198387b
[5/6] rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
      commit: 9c96bacf1af51bc71898f31e025f08338c6ca4da
[6/6] rpmsg: glink: Cancel pending intent requests at removal
      commit: fb23b97346f9aaa9f7b7a996e7baf066c88d69bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
