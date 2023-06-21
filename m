Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73692738922
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjFUPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFUPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254EC2;
        Wed, 21 Jun 2023 08:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCBE3615C4;
        Wed, 21 Jun 2023 15:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93B1C433C9;
        Wed, 21 Jun 2023 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687361402;
        bh=aMJzfBDU6pwSgjC5jUNixMcZvbFUCFKs8Fm5whaA8bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTgpr7H7SqkJnQYlR8GOEQ5tQLg6zv7YuxOyaJoARmFSJTIYnzpOrAInbs/pYd+DT
         vNG1kVyaRYQftC8JAvXJFaP1UILYmH3kBqLCOhlI4GKL/bNqrFdwc6Uc4kOyYv26yg
         b2gBxUhrnydVr+CIH81qf3PCywS9StA8di2Rn80Y=
Date:   Wed, 21 Jun 2023 17:29:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/79] usb: switch to new ctime accessors
Message-ID: <2023062147-unbraided-cassette-64a7@gregkh>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-6-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:45:20AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/usb/core/devio.c           | 16 ++++++++--------
>  drivers/usb/gadget/function/f_fs.c |  6 +-----
>  drivers/usb/gadget/legacy/inode.c  |  3 +--
>  3 files changed, 10 insertions(+), 15 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
