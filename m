Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A768721702
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjFDMkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFDMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D4290
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A459660C11
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66BDC433D2;
        Sun,  4 Jun 2023 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882432;
        bh=GBORFx6NZf+SmGL2+6CkgHcVVNLUpOpIAqVqVfbfRS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gW4+HLoVIrumo4kp1p0NRGQ34x9aXqQi//3YhN1Ampaqpsk/KuuO0uzLRlXbz928V
         r/AU6kb9wlj/+LuyTnLGUk/jrGHwCKwZ7lFh9btigIM0PBBFQOzAz4WjaTb9AKYYwR
         uHVdAYOrYp2SSIrbRmgguHtx5GHw+TTi8/BFvH/+p3/Nx6Fhj4nP6GaX3YgAgU02iG
         b4U0AAf/9oTGKHIX0KUEvC/NaNC/jGMeazMVgb3/vQvV05ubcvpRANSYfPo9PwVrv/
         w4WHVieRmAuv0uPtpDgRFvMz3oumITfrTi+b0jdxb58PkFQiYOimc02fy3HNxtIezZ
         GPpg2kZkxNMlw==
Date:   Sun, 4 Jun 2023 13:40:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report  for mainline [2023-06-04]
Message-ID: <20230604134006.7c5c3f63@sal.lan>
In-Reply-To: <168588069830.1422846.3733273600224627850@leemhuis.info>
References: <168588069830.1422846.3733273600224627850@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun,  4 Jun 2023 12:13:57 +0000
"Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info> escreveu:

> Hi Linus. Nothing much to report for mainline, all business as usual. I
> had hoped Mauro would sent a pull with the media fixes, as they would
> contain one fix[1] for a bug that at least two people hit, but I guess
> it can wait another week.
> 
> Ohh, and in case you care: the Logitech HID bug[3] from the 6.3 cycle
> was not really fixed[4] by commit 6199d23c91c or we dealt with two
> problems all the time (I guess it's the latter). But that will take a
> few days to sort out.
> 
> [1] 14b4bd01f8e ("media: verisilicon: Additional fix for the crash when
> opening the driver")

We opted to use a different approach for the same bug [1]: 
14b4bd01f8e5 ("media: verisilicon: Additional fix for the crash when opening the driver")

[1] https://lore.kernel.org/linux-media/e674cfcb-6b1b-8052-7f29-e0e97bdda3be@xs4all.nl/T/

Patch is already at linux-next. I'm sending the pull request in
a few, together with other fixes.

I was planning to send this earlier, but I got sick and had to take
some days off to recover my health.

Regards,
Mauro
