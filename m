Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDD6ECF79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjDXNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjDXNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520C7EE9;
        Mon, 24 Apr 2023 06:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54EA86238E;
        Mon, 24 Apr 2023 13:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B6C433EF;
        Mon, 24 Apr 2023 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682343844;
        bh=jfxujIgG79vWgMPYndiEWGBgQuKO0XiSzt48/BMJAWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wdq4RpLR/Ocij9jrlLN8knIOqwg31NLrg7LkefXR0vLXBx7T8E0gWidujXbsXcgon
         yJ5f4f6ZlnrYGkKg91VbbMSav6/xZRUayE7SlrBD4y4GzaZRMLosUzcQ6gU/rGHN+p
         kSISPQNJfqjTh8egK84bd/poi7pn7n4PJcoia9wYZhMRLKQ8Uyd616LyMsD04+GS9Y
         2rowxANwMOlThCwnJE8/K5z8HPyAC7uSgz1JD27wthLNp0DKH8rIq9HPPzYzr6pKzi
         yI/5KFRvNW3tWc2IRc6nnmCVR1OQDk6NOEGCBBZ674ALZV2Derme5Lz51l37RgfI/C
         Wld4GZtgv1U5g==
Date:   Mon, 24 Apr 2023 14:44:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Martin Schiller <ms@dev.tdt.de>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/5] leds: trigger: netdev: rename add namespace to
 netdev trigger enum modes
Message-ID: <20230424134400.GI50521@google.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419210743.3594-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Christian Marangi wrote:

> Rename NETDEV trigger enum modes to a more symbolic name and add a
> namespace to them.
> 
> Also add __TRIGGER_NETDEV_MAX to identify the max modes of the netdev
> trigger.
> 
> This is a cleanup to drop the define and no behaviour change are
> intended.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 58 ++++++++++++---------------
>  1 file changed, 25 insertions(+), 33 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
