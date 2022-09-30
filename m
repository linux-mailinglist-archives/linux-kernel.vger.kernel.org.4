Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7345F0FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiI3Q22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiI3Q2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:28:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940915FC73
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:28:22 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87ABE1EC0657;
        Fri, 30 Sep 2022 18:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664555296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BQlYaQrYeBSXEC+SFeCNA5Xu5O65plOEiXrylzf6jf0=;
        b=oz7Dr0YPEMkyzvrxjfaKypelTYTcWzo7FaRtnvn1oWvN52BcoXf9hfLAgowOzpswStTzCn
        PJj9Y3TrSNPBNCMVaeRr7DO/gWpKszswZtJo/161oGE0L558XAJk0ExA8zEpGFCT2w685j
        QDB8Lms18SXby6IYeaTln7H4FoRss/4=
Date:   Fri, 30 Sep 2022 18:28:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task rcu_gp:3 blocked for more than 122 seconds.
Message-ID: <YzcZHOMOxqCBvasV@zn.tnic>
References: <YzVkyxSjifFghj8H@zn.tnic>
 <20220929153722.GG4196@paulmck-ThinkPad-P17-Gen-1>
 <YzbCtvNWue+qUnT0@zn.tnic>
 <20220930161129.GH4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930161129.GH4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:11:29AM -0700, Paul E. McKenney wrote:
> That can be annoying!  I well recall one bisection session where each step
> took several hours, and where each step required manual intervention,
> and where the bug was urgent.  I got the bisection overnight, but was
> pretty useless then next day.  ;-)

Yikes, I hate those moments.

> It is possible that Peter would want proof of this.  ;-)

Yeah, figured it out while we were talking about it on IRC:

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=fdf756f7127185eeffe00e918e66dfee797f3625

Ok, one down, gazillion more to go.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
