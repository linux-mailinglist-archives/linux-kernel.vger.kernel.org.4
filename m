Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E05745667
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGCHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGCHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0698C1;
        Mon,  3 Jul 2023 00:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AFF660D57;
        Mon,  3 Jul 2023 07:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D97DC433C7;
        Mon,  3 Jul 2023 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688370653;
        bh=mw1kB5g47+1kqOiJpj4v5Yyeeh+7VgH/Pp8ZIyYeny4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nm9nzudM9U0wCWCPbMqCCeH8Lxa7Iw+XJfsDgo9Dqm74ksHdCeFKxsJai+kEGMT1f
         wId3EHkP+lEOUGn2bOHe18p+kfVv7JjRTD1FWYzIH8pTukhZWRyNDjwCH/6KVpI6aV
         /79FZabjV8pHAGPq9r+0edLyj8uiFLVICUWjArjr2CfUt7vqqvWlGtdaB8uokh7uJ9
         ttawvCw9IoYTmFI+204Ap9TZuwC5gCNlMaY4QSC6BQRhcXG3fRORrBpWIN/Er2nUHn
         +AGsEZh4ImEX3FfablNrTmti7Ibp2hb0eQlngof6yslpI7ruJH0Gssc+ZMA7nipFbp
         8vSleP7K7FoCA==
Date:   Mon, 3 Jul 2023 09:50:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20230703-dreharbeiten-waggon-4a4432ecb886@brauner>
References: <20230703094250.40be7092@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703094250.40be7092@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:42:50AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pidfd tree got conflicts in:
> 
>   kernel/pid.c
>   kernel/pid_namespace.c
> 
> between commits:
> 
>   b69f0aeb0689 ("pid: Replace struct pid 1-element array with flex-array")
>   dd546618ba70 ("pid: use struct_size_t() helper")
> 
> from Linus' tree and commit:
> 
>   757777eef55b ("pid: Replace struct pid 1-element array with flex-array")
> 
> from the pidfd tree.
> 
> I fixed it up (I used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I'm dropping the patch since we fixed this in mainline.
