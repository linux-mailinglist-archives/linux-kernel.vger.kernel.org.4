Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233DE72878F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjFHTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFHTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01EA2717
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6231E6507E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0C3AC433D2;
        Thu,  8 Jun 2023 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686250845;
        bh=y4lE6oEoFP0eJ4zD6nKH61KcwLbt8oaSqhE3jRkPibQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XW3BWEIUmz2OEOxxB1GEvyV74zD+DZZUY7dbA0oCX3lH+ItDMpHna8gnaAdlF1T0z
         GrAX8GVltruvjshhFTpsaLL/oZWsaVqM7+Z7k4XwFhoG+ZfqazJi5hdjyIUiAJJlz3
         hLgzgDi39o5Wd11CT/7wFRR26vbNtd1kaPUDdPI6xhfvwXDkbcj9qx2N1ESSLrSqTF
         dTtMM/MoLfkqq3xNWppiXvumHHAV5gkEwiQqrAhFpQ7BZRWyOCzfsL9z8eXrUeQTTh
         ODGdaPE9zcdAEirrKk+ceUpkEKyLlIAMhyzpHQPFHEfkbaIt0HQ5NzZFT62KrQiFwI
         kdtjY9ZNEKX+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CC0E87232;
        Thu,  8 Jun 2023 19:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: fix kprobe __user string arg print fault issue
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168625084565.18888.13800044190125074326.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 19:00:45 +0000
References: <20230504072910.3742842-1-ruanjinjie@huawei.com>
In-Reply-To: <20230504072910.3742842-1-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 4 May 2023 15:29:10 +0800 you wrote:
> On riscv qemu platform, when add kprobe event on do_sys_open() to show
> filename string arg, it just print fault as follow:
> 
> echo 'p:myprobe do_sys_open dfd=$arg1 filename=+0($arg2):string flags=$arg3
> mode=$arg4' > kprobe_events
> 
> bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6
> 
> [...]

Here is the summary with links:
  - [v3] riscv: fix kprobe __user string arg print fault issue
    https://git.kernel.org/riscv/c/99a670b2069c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


