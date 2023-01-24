Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC06679F93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjAXREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjAXREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:04:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8E3F2A4;
        Tue, 24 Jan 2023 09:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22AE5B81002;
        Tue, 24 Jan 2023 17:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4FEC433D2;
        Tue, 24 Jan 2023 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674579830;
        bh=cRsNy59JbjSM2KBpp9Xo8rFDoNSq0kgEc8yFXVeEjMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8kQSnVSQWl5vF2hNFN57zbHYOLozWx4a6x7xx3k0eYt6uQRH7nDeVy4aH86HfxKP
         hAEIXPLUqmIg5DJC4sRTW5RalSZ95HIEy37FOaUfciQotNPUopDaCp3FqFoOALC4qp
         K7pulfpQBduPVNOJbbF5SkA2Zr8IhIBAz9yIQuoY=
Date:   Tue, 24 Jan 2023 18:03:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v1 2/2] thermal: Fail object registration if thermal
 class is not registered
Message-ID: <Y9APdJa5xxzT9irb@kroah.com>
References: <5905717.lOV4Wx5bFT@kreacher>
 <4780418.GXAFRqVoOG@kreacher>
 <Y8uW374CM37m0/wI@kroah.com>
 <CAJZ5v0heCTm+1sv9taAoMe8PGgLPEzsTxh9ZdOGjdhDLuvc-Zw@mail.gmail.com>
 <Y890oFSRSG4G2kp6@kroah.com>
 <CAJZ5v0ju0h9FbswXqB9GEy_ZjANvy=6NGday1Qn5PrRV7TkQfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju0h9FbswXqB9GEy_ZjANvy=6NGday1Qn5PrRV7TkQfw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:57:55PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 24, 2023 at 7:03 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > > Oh well, we may as well just allocate it dynamically.
> >
> > Allocate what?
> 
> Well, that was a bit terse, sorry.
> 
> This patch implements what I meant:
> https://patchwork.kernel.org/project/linux-pm/patch/5660360.DvuYhMxLoT@kreacher/

That looks good, I like that change, it's much simpler overall.

greg k-h
