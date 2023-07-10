Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD574D78F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGJNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGJNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF26C4;
        Mon, 10 Jul 2023 06:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5C760F55;
        Mon, 10 Jul 2023 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA40C433C8;
        Mon, 10 Jul 2023 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688995816;
        bh=fPtGNhRYmqCZsKEXFsgJHykQ1nGWwBfMuEqwsNgrA84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAAJFvFQF+uiP+FZRTMnYWv0aXjbbxP1TjpAEmH6i+JurN44KV2i2U2sfidXaqdQe
         dbkrQSlpg3JESpaUsgtxNhAXe3kBMeXCq4wzP4vqOYR4JvjEpGtPajfUrkVrTG8n+K
         JBTo+fAC7vGlUgL7/a5a2QQDTnYMllItKdKK7NQM=
Date:   Mon, 10 Jul 2023 15:30:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 2/2] serial: sprd: Fix DMA buffer leak issue
Message-ID: <2023071047-dragster-shortly-981a@gregkh>
References: <20230710080348.4137875-2-chunyan.zhang@unisoc.com>
 <69d56da8-9530-e729-d527-89879d2bab06@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d56da8-9530-e729-d527-89879d2bab06@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 01:36:07PM +0200, Markus Elfring wrote:
> > Release DMA buffer when _probe() returns fail to avoid memory leak.
> 
> I would appreciate if this change description can be improved another bit.

Again, I would appreciate it if you do not provide reviews for any
kernel subsystems in which I am a maintainer of.

Please stop, it is not helpful at all.

greg k-h
