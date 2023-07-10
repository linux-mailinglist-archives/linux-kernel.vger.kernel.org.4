Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55C174DBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGJQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGJQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2391B1;
        Mon, 10 Jul 2023 09:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6EF161121;
        Mon, 10 Jul 2023 16:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EADC433C8;
        Mon, 10 Jul 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008121;
        bh=92QedKxPnNh0nRPl+lEtvbAjvdZYrtCfYJAIUUcekKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h9XLo4wu7lBg0N5oGAc759RbT0fju5NSf+fRgRNGKv5KrBtoihuXqUzVUUs7BXkMw
         ZTgs8YaMAjE28qU+zL1jrVmXhmRFPr41gUPd7zAtoFlb6E4x1xOYNCv9R4K9puEZDv
         LyRhqxK7QNLgDUVVH3hO4494TbUbjgeLhgDu7ATjo6SP0SMnXbTTjGMmTkAIzkSHCf
         xfx4unSSVitYNuZF3CC+e1Oqbqyry2HOEdBgxpcRF1BRiUje4z2s8/M+RgkICU4Al+
         jjcovcDLDMrNRkfxxoce5M8+MCQFoTtism9s18iuPBMlfK5LQm0/nzMPovRKHYFPh9
         eI9H1aqDZYMcA==
Date:   Mon, 10 Jul 2023 09:55:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Andrew Lunn <andrew@lunn.ch>,
        Ross Maynard <bids.7405@bigpond.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: 3 more broken Zaurii - SL-5600, A300, C700
Message-ID: <20230710095519.5056c98b@kernel.org>
In-Reply-To: <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
        <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
        <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
        <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
        <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
        <14fd48c8-3955-c933-ab6f-329e54da090f@bigpond.com>
        <05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
        <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2023 06:36:32 +0200 Linux regression tracking (Thorsten
Leemhuis) wrote:
> To chime in here: I most agree, but FWIW, it broke more than a decade
> ago in v3.0, so maybe this is better suited for net-next. But of course
> that up to the -net maintainers.

I'm surprised to see you suggest -next for a fix to a user reported bug.
IMO it's very firmly net material.
