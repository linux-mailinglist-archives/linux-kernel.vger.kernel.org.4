Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E7712ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbjEZVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908CBC;
        Fri, 26 May 2023 14:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E9F61454;
        Fri, 26 May 2023 21:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61467C433D2;
        Fri, 26 May 2023 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685135674;
        bh=sFVJeNDGSRnmSp5P8Iti+S0l7ZgKTimSNErApLz72Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=LLchCgTdfd5zpsTOrL4HBZuqRDdohvbMFTfGuCqqDaXj6jFxLdW+7wLNl6Ni41T6b
         fkToFwrnhyIRReD48NWy1yJ9Ga5ozCM3U8qs5BdU4vx1FnMKGch48KUWHNDngbveHs
         O3aO5z9E1lnOTIZXdKIxmK7myoFAGi9W2nZRTSm+er2uTa7JZup2JRVmX2SWt50nri
         Yl9o4ZsYdH7zskEX9DP4pf5lw2O1Oby7dqIVAwNAcxCWeR0PN2mEdJP0Qx648Iw7Z9
         RQvV3zxRgOVZ5b7NwmrH5ITGfeZZaAEVP1+AsCf+EqCvMxuL0fw/LfEhD1IfNBhjGN
         I9N3egOQl2UgA==
From:   SeongJae Park <sj@kernel.org>
To:     mhocko@suse.com
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Docs/mm/damon: Minor fixes and design doc update
Date:   Fri, 26 May 2023 14:14:17 -0700
Message-Id: <20230526211417.1902-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 21:43:04 +0000 SeongJae Park <sj@kernel.org> wrote:

> Some of DAMON documents are outdated, or having minor typos or grammar
> erros.  Especially, the design doc has not updated for DAMOS, which is
> an important part of DAMON.  Fix the minor issues and update documents.

By the way, I started writing this patchset before LSFMM, but Michal's feedback
about DAMON documentation has definitely motivated this work, and was helpful.
Thank you, Michal.  I just wanted to say that.  Of course, more documentation
improvement works will be continued.


Thanks,
SJ

> 
> SeongJae Park (10):
>   Docs/mm/damon/faq: remove old questions
>   Docs/mm/damon/maintainer-profile: fix typos and grammar errors
>   Docs/mm/damon/design: add a section for overall architecture
>   Docs/mm/damon/design: update the layout based on the layers
>   Docs/mm/damon/design: rewrite configurable layers
>   Docs/mm/damon/design: add a section for the relation between Core and
>     Modules layer
>   Docs/mm/damon/design: add sections for basic parts of DAMOS
>   Docs/mm/damon/design: add sections for advanced features of DAMOS
>   Docs/mm/damon/design: add a section for DAMON core API
>   Docs/mm/damon/design: add a section for the modules layer
> 
>  Documentation/mm/damon/design.rst             | 309 ++++++++++++++++--
>  Documentation/mm/damon/faq.rst                |  23 --
>  Documentation/mm/damon/maintainer-profile.rst |   4 +-
>  3 files changed, 285 insertions(+), 51 deletions(-)
> 
> -- 
> 2.25.1
> 
