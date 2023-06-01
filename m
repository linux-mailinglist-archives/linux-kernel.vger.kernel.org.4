Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48637191A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFAEM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAEM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8FE7;
        Wed, 31 May 2023 21:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE4B638D7;
        Thu,  1 Jun 2023 04:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09825C433D2;
        Thu,  1 Jun 2023 04:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685592744;
        bh=F9vMGGWHUB8QgROB7Uv7rHd9Cbph3BOZVwGbgdiXM9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uysny3AGrwjP5T1mfVR+vqh7mnY4HUYmGFiTXGrW2cRt0JTtPE4BSULjPT+FHzyeV
         TUOI/H1YXrJeBOCqYjie6b1DMRSCpg+Bs9ID/celEn/+REygAONsNO9P8fP6lfdBZM
         zfTiW5GCog84LZrtBuVbiDTFKSOxiXjS8+8rUtpc=
Date:   Wed, 31 May 2023 21:12:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the kspp tree
Message-Id: <20230531211223.c8d8bf9f07eac1386410d13e@linux-foundation.org>
In-Reply-To: <81BE1A87-DED7-4A7C-AFB8-A5AA54D19150@kernel.org>
References: <20230601123056.59b281c8@canb.auug.org.au>
        <81BE1A87-DED7-4A7C-AFB8-A5AA54D19150@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 19:43:32 -0700 Kees Cook <kees@kernel.org> wrote:

> On May 31, 2023 7:30:56 PM PDT, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >Hi all,
> >
> >The following commit is also in the mm-hotfixes tree as a different commit
> >(but the same patch):
> >
> >  f7223ccc138b ("string: use __builtin_memcpy() in strlcpy/strlcat")
> >
> >This is commit
> >
> >  0af9b29c6efd ("string: use __builtin_memcpy() in strlcpy/strlcat")
> >
> >in the mm-hotfixes tree.
> 
> Andrew, should I drop this from my tree?
> 

Doesn't matter, as long as we don't both drop it ;)

I wibbled over cc:stable, decided not to.  I did however queue it for
6.4-rcX.

I'll drop this patch from mm-hotfixes.
