Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31A715A38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjE3Jbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjE3JbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DB819B;
        Tue, 30 May 2023 02:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B4A62C6C;
        Tue, 30 May 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A25D5C4339B;
        Tue, 30 May 2023 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685439028;
        bh=Gs9p4IGSlyQzi0lIVyq2sYGgSph1oKPP7IXR+a2jmEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BarS5hq9qnInSkZmX3L5UU22yIPR2YDZ9n5rHEqqVxEYxFZ6eOvCOE7da9QD9Hqy5
         1DcRMVdHvO7cEJTZt9AUWmkxY1BXB+XH0YjkydpFkiKvKI/kw2dP6zWZSUS5HFpgCv
         Cwk9eI4vv5mS3h5u40AZ1vv/AFbiN8Cl97iSGq5lQJLqPo7XXHwdW6SP0wyMNr9zn/
         hzCQC6Q7FpRm3kBP51SZ/NNNiIqRIMXAc8aOkkGcHpFVswfuXpfQrqk2Yjv7P8PeHo
         By1E1xWzoVFXsDji4OewKLQY2LYLQHhmKCziq3Qd4hr830l6Zu6eisqcd6r/Jj6fOB
         0xgOKM0XE2iaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81D69E21EC5;
        Tue, 30 May 2023 09:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Two fixes for SMCRv2
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168543902851.21397.17672525174578554637.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 09:30:28 +0000
References: <1685101741-74826-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1685101741-74826-1-git-send-email-guwen@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 May 2023 19:48:59 +0800 you wrote:
> This patch set includes two bugfix for SMCRv2.
> 
> Wen Gu (2):
>   net/smc: Scan from current RMB list when no position specified
>   net/smc: Don't use RMBs not mapped to new link in SMCRv2 ADD LINK
> 
>  net/smc/smc_llc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net,1/2] net/smc: Scan from current RMB list when no position specified
    https://git.kernel.org/netdev/net/c/b24aa141c2ff
  - [net,2/2] net/smc: Don't use RMBs not mapped to new link in SMCRv2 ADD LINK
    https://git.kernel.org/netdev/net/c/71c6aa0305e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


