Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969736E68ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjDRQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDRQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F9A5F3;
        Tue, 18 Apr 2023 09:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7BA6363C;
        Tue, 18 Apr 2023 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E0C433D2;
        Tue, 18 Apr 2023 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833975;
        bh=tOJ1So/lkQYZ1dXqAXduZ3FghSn5PqnZguZxMb/fFAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rknt2bVajEwu9llHT+cdMysW+QEmBKLwIwvLnxS+mau45SKr+pooGTmFA+as5oe3G
         bPBUO8gFeDOzT0v489+Aiw05CaTzgT+oUmio21YT01yxHBDtmww+i+R5/8P+FZUp78
         uAVXkxUBUcLukyoFvDhDsfLaiPEyYk7sMnVdo7hu9/ycf4lUe1TNG8I5wi+G3IEXlR
         xb8+b4sxORGryIsovm4J4yjxcniHvzebdrKT8BSHyK32yF9VSwDO8VCdmbRK7Rz7JZ
         tBo7gnTyLgraXQ/hnmfFmUtqyWZUWtlpMMVhibwptdOgyHdyvjAhKw7zw7rQVYR1/h
         xROnYUUmWeSqQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] rpmsg: glink: Wait for intent after intent request
Date:   Tue, 18 Apr 2023 09:09:46 -0700
Message-Id: <168183418160.1484313.14958797737671661515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
References: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
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

On Mon, 27 Mar 2023 07:46:15 -0700, Bjorn Andersson wrote:
> When written it was assumed that upon requesting an intent, the intent
> would arrive followed by an intent request acknowledgement. But this is
> not always the case, in which case the current implementation would
> request yet another intent and when that is acknowledged find the first
> received intent - if the remote didn't run out of memory and failed the
> second request...
> 
> [...]

Applied, thanks!

[1/2] rpmsg: glink: Transition intent request signaling to wait queue
      commit: c09c7a59bfdd9a5d02a75ab640ed73ad56b3d1bc
[2/2] rpmsg: glink: Wait for intent, not just request ack
      commit: 62efe3ed777c180a924a8576ca0b5a1a55eba9ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
