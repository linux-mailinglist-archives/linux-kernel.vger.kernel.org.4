Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E23748463
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGEMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGEMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269E10EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A01B561509
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D1C433C7;
        Wed,  5 Jul 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688561411;
        bh=d7a6GkPhluBoRXGrdvQ+tLE2/bakbLYEs6DgmYGaaCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exjns/51qWISjCo8RiNE5kNO6GW+xVTpe7JakD+7qMXGCTg9XwU8DoD1x96CcCzyx
         RCHxymaJXyZO+Fx9CP4TZ5lF7j6gRHOHUnfSnN7N0lnEVVNfT3HoyI8IHiWfGH8WVw
         d5MWztJjD3O5LwqpKIZFgVkKQZRtzyhGzzIPAW0z4gYylhGsvT6A/YB7Bl/KC3K3vp
         jetpy1dg4otPpKvWkEV/T1CjFS6ZMCXPhqCqL+eaGB2CRxJsjP5hkPPxH9SGXK7vKE
         p+smdN3hkbJhkrWI/6CAstz4ZrHWimH1D6YJE989zGG0QIv+y5y5kaqlXycG0kJxp8
         B8a6zrIhEIf9w==
Date:   Wed, 5 Jul 2023 21:50:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] probes: Update for v6.5
Message-Id: <20230705215007.4b755158b530ddc76d044173@kernel.org>
In-Reply-To: <CAHk-=wghSiMXEaWq6MA6C8ye8-Wek7WmnkWYpCNwv=N8R+rQgg@mail.gmail.com>
References: <20230629101316.d8eff69f9899f6c895ac64f5@kernel.org>
        <CAHk-=wghSiMXEaWq6MA6C8ye8-Wek7WmnkWYpCNwv=N8R+rQgg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 10:51:59 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 28 Jun 2023 at 18:13, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Probes updates for v6.5:
> 
> Heh, after five emails, this last email still ended up being a
> confusing mess where you had apparently cut-and-pasted things into the
> middle of the email, so things still showed up twice and jumbled. I
> don't know what odd mix of auto-generated and manually edited content
> causes it.

Sorry about that. It was my miss-operation. I will take care of such
issue next time.

> 
> But hey, the end result is an understandable if slightly messy email,
> so I've pulled it.

Thank you very much.

> 
>              Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
