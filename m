Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A47191F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFAElz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAElx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96FAD1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 21:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545EB63F7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6318AC433EF;
        Thu,  1 Jun 2023 04:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685594511;
        bh=ky4mR1cJE7WCesKxH6aaf+JK5+lIqgajYd9irBlEbY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pB3wpVHxZZar5qF3MQ9DLa2z79UUtaxFs2gPclrFKJvyigPrAS25/N3E0GYo6ej58
         uwD6gtP/WdOObwuHRL0x1xi0QLR2SrOY+eLXuv6aHqAEyMnIqdbRPfm8TNiU02TR9X
         879GYrjN0ddGnWtZlqsLCce1BG1VYrhrSdGf4/8XJOKXiGjWkq9qU/7mcYk57bHBDL
         UIK7BO03MA8HaPzQlPobzV5q3B4rGlRmUuKv/HVLrJih8luoPVox1YPii5ykrYJ8FD
         jHNfR8mN3I5mFEcLZ3uMGYxuYcfqnIbWwW2uyIgcjGDYck+7WgfwAj9YaOaaFaHh7y
         2SXK9dnsQZRsQ==
Date:   Wed, 31 May 2023 21:41:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "privat@egil-hjelmeland.no" <privat@egil-hjelmeland.no>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: lan9303: allow vid != 0 in port_fdb_{add|del}
 methods
Message-ID: <20230531214150.2e0f03d1@kernel.org>
In-Reply-To: <20230531153519.t3go47caebkchltv@skbuf>
References: <20230531143826.477267-1-alexander.sverdlin@siemens.com>
        <20230531151620.rqdaf2dlp5jsn6mk@skbuf>
        <426c54cdaa001d55cdcacee4ae9e7712cee617c2.camel@siemens.com>
        <20230531153519.t3go47caebkchltv@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 18:35:19 +0300 Vladimir Oltean wrote:
> If you want to be completely sure I didn't just throw a wrench into
> your plans, feel free to resend a v2 with just my review tag
> (dropping my Fixes tag)

FWIW if you worry that the Fixes tag will get added automatically - 
for whatever reason that still doesn't work. We add them manually
when someone provides a tag in response.
