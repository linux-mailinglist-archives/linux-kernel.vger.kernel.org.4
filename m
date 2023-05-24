Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72E870F1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbjEXJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjEXJGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22590;
        Wed, 24 May 2023 02:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4FAB62E0D;
        Wed, 24 May 2023 09:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3F4C433EF;
        Wed, 24 May 2023 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684919204;
        bh=1gwA0+7veYTn5CPgea/1uyWcfPFLtZb7zxkaBffLLO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjofRXLlgeZxOgdNdp80GpQ1zhqLGpOnfrkeXmB09YkejuGL9SsCUTsIIfjRHf3zO
         cCBPTnB3T2c3qVuZ9glFOUKSZiv66IN5RFn0h5XaJh56W+pw/pmuu5L2Zuthk9WvIW
         ip/FDtQp83rzAII5uydlUrSkdOvXLkFufO0uJd3gIISz78lQE9XDSRGNpXONUuXIXK
         cdT8jHmtQCaRpp8Fnop9Hj7T2kWv/AZzsV8Zgznr4Ch63zalC7uhVEO3nFkjDT6/MF
         On1x4KVvM3VldAQTuzob/funFlmWIDvdNOSnhI9Wv1kP9TcEUylskiAd1f32LofvG7
         bsYzqCHmw4p+g==
Date:   Wed, 24 May 2023 11:06:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230524-golfball-bittsteller-7cd8e9a75fe8@brauner>
References: <20230524134623.733082d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524134623.733082d7@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:46:23PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-brauner tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> fs/stat.c:80: warning: Function parameter or member 'request_mask' not described in 'generic_fillattr'
> 
> Introduced by commit
> 
>   8fb690f6de31 ("fs: pass the request_mask to generic_fillattr")

Thanks, Jeff will send a new version of the series which should fix
this hopefully.
