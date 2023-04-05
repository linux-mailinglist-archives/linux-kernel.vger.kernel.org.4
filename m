Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B276D85A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjDESFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjDESEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A117EDC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A6C62A57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB4CC433D2;
        Wed,  5 Apr 2023 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717826;
        bh=axZLtRNGipNwctWvgcZ3aS13Kb+zE9C4A/X+8BbNxew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjGKyWacjC7Lu9nl0ARwzUgR1efEK/rpoHsS8hzP2Sbxq3VIFCk00LpSnrWTxZLE8
         0Vy6DZHB1iJSUntLhNZF7jHg9Ynz8hQgy8n5MNxc5IG7PeAX9A+qxlb3LzU5zWk9L9
         ihRoV06CuIDvvcHtYj2KRM7Sy2oSp53DiL3YprzPKrqyERkJcT00sTkfKUvLCvC5hP
         oQ7yfDlI1z6d2EjFSppwGz90QkwLR4H7Z2X2eZmD+V3dcTGpEsYr253T2YIq12sTsF
         unghIhwR0r7XL9qhsrLZrED5rf16w1gYLHyDQNIivzB2nY1PaHwbB9QFh/ZHLYfHMy
         LI1U7N3T+jAIg==
Date:   Wed, 5 Apr 2023 19:03:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230405180340.GV8371@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
 <20230405153651.GS8371@google.com>
 <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
 <20230405163906.GT8371@google.com>
 <185fbb80-7fa3-4c88-9f96-92894370a3aa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <185fbb80-7fa3-4c88-9f96-92894370a3aa@sirena.org.uk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Mark Brown wrote:

> On Wed, Apr 05, 2023 at 05:39:06PM +0100, Lee Jones wrote:
> > On Wed, 05 Apr 2023, Mark Brown wrote:
>
> > > Whatever it is you need to do to be happy with and apply the shared bit
> > > of the series.  We're somehow on v10 here for what seems like it should
> > > be a very simple change, I've not followed the ins and outs of how that
> > > happened.
>
> > From an MFD perspective, reviews happened followed by an approval in v9.
>
> > I can't do anything without an Ack from you or some indication that you
> > want me to apply the first 2 patches and share an IB.
>
> Yes, please apply and share a branch like you usually do.

I usually encompass the other subsystem's patches in the IB too.

To enable me to do that, I need an Ack from you.

--
Lee Jones [李琼斯]
