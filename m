Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5773ECCC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFZVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFZVXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52084BD;
        Mon, 26 Jun 2023 14:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6E8D60EB2;
        Mon, 26 Jun 2023 21:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECAC433C8;
        Mon, 26 Jun 2023 21:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687814578;
        bh=m5tAbNXuwzu/wTbTJhZUflS9MvTlLgnUmPd2W8oqPUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d49M38lPe12UNxthVPgEwPskrnE7j0e7lFnrZqCgvgUIcPWXRGJjlTxOHSMLp4PBU
         j36UQSceNqPOYJtYYXZrg3vJo4LFaP7gJuBdHAi1yU2Eydtr+tr3Pi9+gw7N2/tF5w
         zzi3IugQnNheyRplFzh6DQ+Agyj8lkootV/Z3nCjmLaSyjmXCQFss7VDnVrRFLI2u8
         mzjRDgpxaaBtSmN5bZ8B8tBN5cHkhgt0Tj+JQ+jbWRlCAV75N04UCOAVblSRZCOsg3
         CEu3Y3GPVCA+Yg5MLuM/fSBQOA0Rkw+R1WZ0nQ5wxrLWyiDArslc+1p67yVj9V9zOD
         AFF5C8KvghIBw==
Date:   Mon, 26 Jun 2023 14:22:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
Message-ID: <20230626142257.6e14a801@kernel.org>
In-Reply-To: <3112097.1687814081@warthog.procyon.org.uk>
References: <3112097.1687814081@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 22:14:41 +0100 David Howells wrote:
> Do you know if ->sendmsg() might alter the msghdr struct it is passed as an
> argument? Certainly it can alter msg_iter, but can it also modify,
> say, msg_flags?

I'm not aware of a precedent either way.
Eric or Paolo would know better than me, tho.
