Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D8736713
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFTJLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:00 -0400
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [IPv6:2001:1600:3:17::190d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B4C9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:10:57 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qlgpl2Ck1zMqG2G;
        Tue, 20 Jun 2023 09:10:55 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qlgph54TmzMs39m;
        Tue, 20 Jun 2023 11:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687252255;
        bh=9QOzYcU1hRHf8r89BJZ0gc9MnlN0gaNwkaFO67Nk67o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hsq8IWdFGzXJceYf0owNoUq/doKeR+ZcBQTqCH6P0dfRDvSk1x42GPBT16zJmB+26
         jXLOdRhzqoFWIVWxL5YUDwQSPBuAHkqguQOlXfwlNc5hNSylxkxz1xBdTmwYN86adW
         wdjVf8oOMwT6scYIE/1jRJ2Ap1DQN6AhXsiLp+zo=
Message-ID: <b57481af-5824-72f7-d20f-cfd78fcde519@digikod.net>
Date:   Tue, 20 Jun 2023 11:10:51 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: linux-next: manual merge of the landlock tree with the tip tree
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230620135536.1f820a48@canb.auug.org.au>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230620135536.1f820a48@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

There is a (trivial) merge conflict because one of your commits adds 
ARCH_HAS_CPU_FINALIZE_INIT and one of mine removes ARCH_EPHEMERAL_INODES 
in arch/um/Kconfig.

I don't plan to add more commits to my tree until the merge window and 
I'd like to send a PR to Linus as soon as it is open. Would that be OK 
with you to let Linus deal with this trivial conflict or do you prefer 
one of us to rebase on the other's tree?

Regards,
  Mickaël


On 20/06/2023 05:55, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the landlock tree got a conflict in:
> 
>    arch/um/Kconfig
> 
> between commit:
> 
>    9349b5cd0908 ("um/cpu: Switch to arch_cpu_finalize_init()")
> 
> from the tip tree and commit:
> 
>    74ce793bcbde ("hostfs: Fix ephemeral inodes")
> 
> from the landlock tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
