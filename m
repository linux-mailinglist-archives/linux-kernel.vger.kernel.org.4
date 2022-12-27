Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE717656890
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiL0IxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0Iw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:52:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479A21B5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:52:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E6F60FBC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF98CC433EF;
        Tue, 27 Dec 2022 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672131177;
        bh=Z194cUyzUzLCYhqb7iJzQShl9/IPzyNO267kinhb2ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBVAMzUpLerii4C4u0aeAZeYrjprDwKvn69wCmsXO47Kza3Yzrhg98L+/EqRI8bV+
         Z0OHEhcerZHLnM/6i6b537jtOxVMOcWTBtOhhO7lg1aNeIw/gnwT9gbTjpyI/HK46a
         wXQCPzrRcbRVo2FXvkkWwvW6YykxGKyQD7E3o1UKek/2GrLNX6Yc+B3Jql8QvA5x4s
         KDHCWwdV+GL1UVeB74CFqu5BV6i3U/C8WUMv1+McXnbERbEb4YSNmP7yszROkpT39Y
         3n3AsSD02Mi7S1Stc3ZrLoleLAsLBVM0jD56l8zdLRVnUfxaralFRisK8YF83f1oJz
         38V6yuGVdGArA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pA5hf-0003MK-TT; Tue, 27 Dec 2022 09:52:56 +0100
Date:   Tue, 27 Dec 2022 09:52:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add usb serial support for quectel modules
Message-ID: <Y6qyZ4Vp5Dmc/339@hovoldconsulting.com>
References: <20221225185657.3962-1-ali.mirghasemi1376@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225185657.3962-1-ali.mirghasemi1376@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 10:26:57PM +0330, Ali Mirghasemi wrote:
> Add support for following modules
> - EC200U
> - EC200A

You need to sign-off on your patches here. Make sure you have read and
understood Documentation/process/submitting-patches.rst.

You should also CC the linux-usb list.

Please also use the common prefix for USB serial in your Subject and
include the output of the usb-devices command for these devices in the
commit message along with a description of which interfaces are used for
what.

Here's a recent example of what this may look like:

	https://lore.kernel.org/all/20221214043546.10339-1-duke_xinanwen@163.com/

Johan
