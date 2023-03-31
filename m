Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3886D1493
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCaA7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCaA7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483961024E;
        Thu, 30 Mar 2023 17:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D26262290;
        Fri, 31 Mar 2023 00:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7989C4339B;
        Fri, 31 Mar 2023 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680224375;
        bh=u93Aieiy1n2F3ZSl10cyi1S6xA4Q2nfZg8Rkf0kFO8o=;
        h=Reply-To:From:To:In-Reply-To:References:Subject:Date:From;
        b=JfBwaRCk2f9+gurayXX54OE0eBUGgB0oDyVPL35RzETRVsl2eOV7jq91DMK7YR1qi
         gfNfm9U0RbBAeLI7TgwVBCA6457l3g6DvDpHEieSzOr0JHB0tMA5yISs/TfU6cSCHq
         4feYEpi1P5LCLRPW9Tq11NJIG3GNmC9yVNSH//zTwdysJXzP7o3FBD5WglCV3AELKu
         QMm0ik81iEN+l42va2Q9OxG6KrxRE2AdAoUC6WbFfz4Jpl8lbHGdoc4EM29LBAvxHG
         3/9PwJAwtrPteVsVK48Iwykq3fybU/CGnLP1WCig8TW3IEd3UZQQwP0qrhoY7wTxzW
         9eAdfx28pLdmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9685E2A03F;
        Fri, 31 Mar 2023 00:59:35 +0000 (UTC)
Reply-To: pengfei.xu@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     linux-kernel@vger.kernel.org, bugs@lists.linux.dev,
        mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        mricon@kernel.org, pengfei.xu@intel.com,
        linux-perf-users@vger.kernel.org
Message-ID: <20230331-b217267c2-62770cd7e0a6@bugzilla.kernel.org>
In-Reply-To: <20230330-b217267c0-15b9c837ad2e@bugzilla.kernel.org>
References: <20230330-b217267c0-15b9c837ad2e@bugzilla.kernel.org>
Subject: Re: [Syzkaller & bisect] There is "soft lockup in
 sys_perf_event_open" BUG in v6.3-rc4 kernel
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Fri, 31 Mar 2023 00:59:35 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pengfei.xu@intel.com writes via Kernel.org Bugzilla:

Thanks, and here is the LKML community link: https://lore.kernel.org/lkml/ZCQmnkqDaP7C1EVi@xpf.sh.intel.com/

Thanks!
BR.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217267#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

