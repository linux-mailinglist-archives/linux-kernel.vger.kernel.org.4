Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714273863F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFUOIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjFUOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C718C;
        Wed, 21 Jun 2023 07:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 507E76153B;
        Wed, 21 Jun 2023 14:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C49C433CB;
        Wed, 21 Jun 2023 14:08:47 +0000 (UTC)
Date:   Wed, 21 Jun 2023 10:08:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-doc@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Tech-board-discuss] [PATCH] Documentation: Linux Contribution
 Maturity Model and the wider community
Message-ID: <20230621100845.12588f48@gandalf.local.home>
In-Reply-To: <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu>
        <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 11:51:19 +1000 (AEST)
Finn Thain <fthain@linux-m68k.org> wrote:

> - Maintainers should be "automating themselves out of a job" to whatever 
>   extent this is possible.  git is a good example of this, as is all of 
>   the tooling and workflow automation that grew out of that (e.g. gitlab).

I agree with the above statement.

> 
>   Because the Linux project is structured as a heirarchy, I think Linus 
>   and senior maintainers have a crucial role here. I don't think it's a 
>   co-incidence that git was the brainchild of the top maintainer.

True.

> 
>   Making the maintainer role more lucrative will provide a disincentive 
>   for more automation (with or without level 5 performance reviews) unless 
>   remuneration is tied to metrics that reflect maintainer effectiveness.

I'm not sure I totally understand your point above. I do not think that
making the maintainer role more lucrative provides a disincentive for more
automation. I'm constantly trying to add more automation to my process.
That's why I created ktest.pl, and constantly fiddling with patchwork to
get patch state automatically updated when things move from different
branches and git trees.

If your point is mainly the second part of that paragraph, which is to tie
in metrics to reflect maintainer effectiveness, then I think I agree with
you there. One metric is simply the time a patch is ignored by a
maintainer on a mailing list (where the maintainer is Cc'd and it is
obvious the patch belongs to their subsystem). I know I fail at that,
especially when my work is pushing me to focus on other things.

-- Steve
