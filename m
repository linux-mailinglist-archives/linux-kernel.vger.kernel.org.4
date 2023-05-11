Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661C6FF8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjEKRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjEKRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB06A76;
        Thu, 11 May 2023 10:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC7561525;
        Thu, 11 May 2023 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AB1C433D2;
        Thu, 11 May 2023 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683827383;
        bh=tDn7RONyY0VoFaYA3Xkv2rz9SOdI4zHAs1KUbSVjiPQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PnYO+TeGKUAr2kTnTsjAANir+22QWfyDNVWxlFyW1kFayz2b3ZtNfx8paecaeeX7Y
         PBJyPgvxb/b4tAh99DQsrx7sQDpbAJK5ePYYNwsSMP7CkWogIWEe5R6G5T9biihreg
         jMihRt+svufhdPIMdu3VeLCbf6uPkSpjIb45i+mEk67PntX5wLEfDgrqkzV+7ujziD
         0S3WBIh3C3KXHn7t6Sizz8tcGjKl99flJ6iUth//dIq3KJBSA2eWwjSCMATOR9Basn
         SO9NhFBrgtIyHpFY8GN0vi2/vGuIRUHxU+QESgXrhxJ3cJG2F8P5ZY6IeCJ73mvxrE
         N/wHA1AxXiLTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5EDCCE0FED; Thu, 11 May 2023 10:49:42 -0700 (PDT)
Date:   Thu, 11 May 2023 10:49:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 6/6] torture: Remove duplicated argument -enable-kvm
 for ppc64
Message-ID: <cfad7e8f-ca9f-446c-9c54-e9a11989d220@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-6-paulmck@kernel.org>
 <CAEXW_YRRMfbfXJwCA89hD_VCpbxR8AoEvv9xzrX=W_4Ffi-g2A@mail.gmail.com>
 <CAABZP2wGXaMUwu372HG-654z2RCvUayiR8tBpDg+SDgcyg+OtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2wGXaMUwu372HG-654z2RCvUayiR8tBpDg+SDgcyg+OtA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 02:18:57PM +0800, Zhouyi Zhou wrote:
> On Thu, May 11, 2023 at 1:26 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, May 10, 2023 at 10:13 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >
> > > The qemu argument -enable-kvm is duplicated because the qemu_args bash
> > > variable in kvm-test-1-run.sh has already provides it.  This commit
> >
> > drop the has.

Good eyes, and thank you!

> Thank Joel for the fix ;-)
> Should I resend the patch, or would Paul do me the favor instead ;-)
> 
> Thank you all

I will do it on my next rebase.  ;-)

							Thanx, Paul

> Zhouyi
> >
> >  - Joel
> >
> > > therefore removes the ppc64-specific copy in functions.sh.
> > >
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> > > index b52d5069563c..48b9147e8c91 100644
> > > --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> > > @@ -250,7 +250,7 @@ identify_qemu_args () {
> > >                 echo -machine virt,gic-version=host -cpu host
> > >                 ;;
> > >         qemu-system-ppc64)
> > > -               echo -enable-kvm -M pseries -nodefaults
> > > +               echo -M pseries -nodefaults
> > >                 echo -device spapr-vscsi
> > >                 if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QEMU_MAC"
> > >                 then
> > > --
> > > 2.40.1
> > >
