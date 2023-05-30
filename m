Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A02716090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjE3MxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjE3MxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B3129;
        Tue, 30 May 2023 05:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC5D61AD5;
        Tue, 30 May 2023 12:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB7C433EF;
        Tue, 30 May 2023 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685451127;
        bh=oevBEs+dx9KfQQJHe/Budkz7y0IyMsmern9/98xwUIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDvGyAbqToyk2/obb4diQCN2NQXotTl63dwNe0MQNXdnkZhBfzFkXPa3wkWPNcg4x
         bXAW6UyGUI0w/093gpR2hGgWjTgvTjZKHz0GEflep2qPkeExUKDLKb1v7lTTh8fB1l
         ufvEhbog54OnOojhZZ5EEH98zX+C9VNeCPnKqBdk=
Date:   Tue, 30 May 2023 13:52:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragos-Marian Panait <dragos.panait@windriver.com>
Cc:     stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1 1/1] bluetooth: Add cmd validity checks at the start
 of hci_sock_ioctl()
Message-ID: <2023053043-duo-collide-fd9c@gregkh>
References: <20230530122629.231821-1-dragos.panait@windriver.com>
 <20230530122629.231821-2-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530122629.231821-2-dragos.panait@windriver.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:26:29PM +0300, Dragos-Marian Panait wrote:
> From: Ruihan Li <lrh2000@pku.edu.cn>
> 
> commit 000c2fa2c144c499c881a101819cf1936a1f7cf2 upstream.

What about newer kernels (and older ones)?  Do you want to upgrade and
have a regression?

greg k-h
