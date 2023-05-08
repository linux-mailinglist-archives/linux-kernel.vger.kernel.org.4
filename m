Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3237E6FB562
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEHQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEHQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC89729D;
        Mon,  8 May 2023 09:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E64661D3A;
        Mon,  8 May 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E5C433D2;
        Mon,  8 May 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683564020;
        bh=Z1S2WxHXv0dY97Bv20SX+YjyzBEFp89NppLz7eb9vvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSGDpR5MiaG8+tlV6qOYszul738jTaG7Armfi/kn0G3duuw5Qp3Ph268Pcqx5JOjo
         1C1Ay4PZFsAyF3gU7Zn3ADgRctn41RfenNrZcRGHlqSbHZ2VMBdCbt6boYHqZzkZ5y
         woIZSggOji7Z7nIzKveqVcJTfaxGHxh29qQDxX9MqPWU3LJ0pJkr3KkoZ/GhgJZNpB
         b+i3dxVDWDaBC7uokzLdnFgmBxYfodWaxLJsFPH7T4hIAdfAZQVVqKTXdRKZ5iPAKM
         iHojiZHlSjpkMevcJm1OFkYU4D8GeskawkZaaSEC3myd2K+xjjnNU7b4rYVSPH2KYG
         x1fE3ubW71YnA==
Date:   Mon, 8 May 2023 18:40:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-idmapping tree
Message-ID: <20230508-kiesbett-werben-04b4a8cc7544@brauner>
References: <20230508105626.4b7fbef1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508105626.4b7fbef1@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 10:56:26AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   85ef56bc2d65 ("ocfs2: reduce ioctl stack usage")
>   ec30adeb289d ("pipe: set FMODE_NOWAIT on pipes")

Hey Stephen,

This ende up going through Jens' tree in the end. I'll drop these
patches now.

Thanks!
Christian
