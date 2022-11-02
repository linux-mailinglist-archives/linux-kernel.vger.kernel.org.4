Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4E615727
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKBBuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:50:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E957D2F4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 18:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0BFB61799
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC71C433D7;
        Wed,  2 Nov 2022 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667353847;
        bh=qGqh4q3o9BH6UWoao+yGfX/V7FPbcVQG7BCjeSFxnok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxNmSzPB2pEuSgzd0yub7bPxnB5xIDA00d75eNNM9lH9bIEMIHn5zsR8r5r+KpZD5
         tjFeW2FcEQhPKsxSb6eR6Bydh26PHx7YZwl7l/yt6CCAw5xM545DyTLSYq5ybz6H/b
         hUGjexGCvzKc8dnXEVszgsnQDS000SfrT/36pzYk=
Date:   Wed, 2 Nov 2022 02:51:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     error27@gmail.com, ztong0001@gmail.com, chenzhang_0901@163.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] staging: rtl8192u: Fix typo in comment
Message-ID: <Y2HNKwutTJh6kHXS@kroah.com>
References: <20221102014154.14344-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102014154.14344-1-chenzhang@kylinos.cn>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:41:54AM +0800, chen zhang wrote:
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>

Please follow the documented rules for when you submit a change based on
a tool like a bot such as this.

> Signed-off-by: chen zhang <chenzhang@kylinos.cn>

This email address does not validate as actually being sent from this
domain, so I can't trust it, sorry.  Please work on fixing your email
system so that this can work properly.

thanks,

greg k-h
