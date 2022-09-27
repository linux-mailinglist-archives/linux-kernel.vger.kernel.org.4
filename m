Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B485EC9AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiI0Qhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiI0Qh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165751DB561
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68F861A7E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B6C433C1;
        Tue, 27 Sep 2022 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664296618;
        bh=b7DMYOVHj6bw7lfroBwVWDotsAjlOj5X15xgOnCYkUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9SMIpacaBeGg/NJQgpBA/5BVuMLYaYEXxAMud8uzEAWvqhbt1NNTjtpK0FGu8SGx
         2bqP8+l/Q2j3WfC4YacKT2Kq2JibjgU7TyasnyA3LiPZa9n6ehdaX6CCqY7Hgm96jS
         VP8uAR3XmCsjQxhNddB5ds5Llyn0pnA56W2wPqbo=
Date:   Tue, 27 Sep 2022 18:36:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <YzMmp9llFUN1yUDH@kroah.com>
References: <20220926043618.566326-1-zyytlz.wz@163.com>
 <YzFkpRfkdnwgDDw6@kroah.com>
 <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not top-post.

On Tue, Sep 27, 2022 at 10:12:58PM +0800, Zheng Hacker wrote:
> Hi Greg,
> 
> I've resent the patch. Could you please review it and apply if there
> is no more problem?

I do not see any new submission, please provide the lore.kernel.org link
of it.

thanks,

greg k-h
