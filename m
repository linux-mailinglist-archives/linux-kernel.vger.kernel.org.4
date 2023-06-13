Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F572EAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjFMS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFMS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790C1701;
        Tue, 13 Jun 2023 11:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FAE633F3;
        Tue, 13 Jun 2023 18:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638C9C433D9;
        Tue, 13 Jun 2023 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680915;
        bh=/D3YYRMFOxqtGYTim6YsH/QIEOLyRikQxfcIqm7Q9CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LMOpkFDyGl8VngQ9e6e5EXkezJaA/iY/p72Nv7SmYBStPo/y2m9FJ1gMHUTaDViQS
         WjoddG2ndc2qFJbIOIKCh0cbKv2Mst+g1lPqrx84hTmoqN1zppG3Qa6KkAA0uumk5a
         Roj5fHWZq49Vx+VWVKz3hxGYyHzrerjh4GbYnbjDk89FWJtGa5oGfKkgXrjAXSqa6t
         TGFZGkz7RLoTAh3GtqjX8MwZ+A73/lUw7niu4aXAEQJbhV9r4tSdqHwd/ml+L+pCor
         tEcAPKSEi4ZYqiyX0r1+oKYBzPL1kIfLZcDjeuYHjTO8heHwjzhDZpYB3aLKxDnuaL
         jQwPMNRe5bv5w==
Date:   Tue, 13 Jun 2023 11:28:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <20230613112834.7df36e95@kernel.org>
In-Reply-To: <871qifxm9b.fsf@toke.dk>
References: <87y1kncuh4.fsf@kernel.org>
        <871qifxm9b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 20:14:40 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> I think this sounds reasonable, and I applaud the effort to take some
> time off during the summer :)
>=20
> One question that comes to mind is how would this work for patchwork?
> Would we keep using the wireless patchwork instance for the patches
> going to -net in that period, or will there be some other process for
> this? I realise the setup we have for ath9k is a bit special in this
> regard with the ack-on-list+delegation, so I'm obviously mostly
> interested in what to do about that... :)

Whatever's easiest :) It's probably a good idea for Kalle to write
down all the local rules and customs and share those with us.
