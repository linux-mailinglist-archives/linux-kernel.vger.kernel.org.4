Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE286E70E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDSB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSB5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46DA1705;
        Tue, 18 Apr 2023 18:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFC763372;
        Wed, 19 Apr 2023 01:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F2BC433EF;
        Wed, 19 Apr 2023 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681869456;
        bh=FCT2s+tjoEAO4WaqpR4CNs/KcNexv8a/2U0HgeW4Av4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIQLXO++vNxhItgu5js5jf2BJUZDv+lIH13pRMWbxXfNuRkL4zbzyS54Q33E8xi1n
         ATReCtbh4oISPduzTeGPM2E9NpykkYDyZvQ9oewFQZQotoFcRU1RuSOQQlEoSSKIuv
         hLYjCWpEifWOCTVtERw/b5ssXEbusmoOukr5CQJr/LeuFnlVhwZp2hVKC9bEJ6Iwd8
         Mjb4y6WO3tzmJrJ6+oq8BsSJRvtl7a7Gn16ttCb5qqFSkVzOJ5SrdsiclJU0UTieDt
         DUi9WgU+a7d1FOFuoxy8Vzga5F4DC9iCrZeSAIanl9YTKbp/wKwFKbWstVJtElTJIu
         1R6SRSm1oavpg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rpmsg: glink: Fix + cleanup in __qcom_glink_send()
Date:   Tue, 18 Apr 2023 19:01:08 -0700
Message-Id: <168186966272.1517024.17052926442905008994.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418163018.785524-1-quic_bjorande@quicinc.com>
References: <20230418163018.785524-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 09:30:16 -0700, Bjorn Andersson wrote:
> Found these two things to fix/cleanup while poking around in the glink
> code.
> 
> Bjorn Andersson (2):
>   rpmsg: glink: Propagate TX failures in intentless mode as well
>   rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
> 
> [...]

Applied, thanks!

[1/2] rpmsg: glink: Propagate TX failures in intentless mode as well
      commit: f187a431c494348d8afdb77900fc879be73bdbf3
[2/2] rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
      commit: cc888eb072b6a48642e429a030b065d4da1d594b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
