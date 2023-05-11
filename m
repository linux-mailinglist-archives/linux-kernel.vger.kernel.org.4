Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6626FF950
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbjEKSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjEKSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6557EF5;
        Thu, 11 May 2023 11:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BAFF65089;
        Thu, 11 May 2023 18:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F1C433A0;
        Thu, 11 May 2023 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683828294;
        bh=mco4oTL57mosI1X2KV83dSvjzytX/uT+qJN5u+MQ7Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFeLBm+ZZSjBmLA3UskkIK/7uK8zfqd8LM37nyi62+cAYUlOZMos7al4f7Kp7vMy2
         CMet6Gt3TCKIvzR1Xqd6WkOKY+v1eoK/qpr9Zf5D7kfX0ezUUIArPV6nmRj2eMWjaQ
         Cy/Vje0wDpvLJRm0xMmLlDb4wzJkQV3VVUFPf7wxnFiNwZBgW89pSUEp+jjDQWXckS
         iMIbbzm4vDwHN0ieD1qDh9RfCToK7g5jyba/moPlqdf1CD6011BPK9IAk/BhAHaN60
         Dms1Mndk9HG8j1GILNxCROgTEH/cCFcjCi+e00O03YVogaXikJNompg/sJNnfvjWqT
         /9LMrrWx8w91A==
Date:   Thu, 11 May 2023 20:04:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the
 vfs-idmapping tree
Message-ID: <20230511-fragil-lohnt-618b71af4669@brauner>
References: <20230510105543.165f102b@canb.auug.org.au>
 <b5c0b1b9-9896-2637-458b-ca1003ba7d74@kernel.dk>
 <20230511110750.76a33556@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511110750.76a33556@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:07:50AM +1000, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Wed, 10 May 2023 06:48:39 -0600 Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Yes, since Linus didn't like the original approach, it was redone
> > and that particular patch was originally forgotten and then redone
> > without the 'nonblock' variable. So you should just ignore the
> > old version, and Christian should just drop that branch from his
> > for-next tree as it's dead.
> 
> That appears to have been done now, thanks.

Yeah, sorry. LSFMM makes it a bit hard to be consistent about my
replies and after my first reply I only had rolled vfs/for-next rolled
forward but not vfs-idmapping/for-next. The latter repo will likely go
away soonish and then only vfs/* will be left.

Christian
