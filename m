Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC28D64A2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiLLOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiLLOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:14:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246DFDF30;
        Mon, 12 Dec 2022 06:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1A73B80C8C;
        Mon, 12 Dec 2022 14:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BDBC433F0;
        Mon, 12 Dec 2022 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670854467;
        bh=4rnwveyKqiOjTTvFsSiwrZeTN9NHsVO4DY/MAvqUSlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYkDXB0CESKifaoyTSdLIB/dcBDZGUNNgarhiaYGcNo1BQ0ApcorHZWMaaNffc1Y7
         uhrlo+q6sey1HpSyCaXcVA4tM+7rVhkV04PxaeTQSj5CTy8djlOuO7wU7HyJ1CUMtB
         DR+B7c88srX/EPWMGIKRGPVQBcFvHPLEw5Xtqb3p2mJxwXGUR20B+sYA4lVAiTKCU/
         /cfWw24DSwboikVC4AVtX7cf1rRiCkQdrl6bHnkZWfSp+wxlKyWO1QmMaeR2k8sJph
         4edaxX9SiXiFM/jTgNklQxhRQ/B4X4IXegwd4k2EPS7kvyDHlHU0VEq0ncKHHEI8zQ
         JrjVj8YH3ld5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4jZx-0007Bz-Nk; Mon, 12 Dec 2022 15:14:50 +0100
Date:   Mon, 12 Dec 2022 15:14:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5c3WWKyohzkspnw@hovoldconsulting.com>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
 <Y5cvPulXceujfZv6@hovoldconsulting.com>
 <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:04:50PM +0100, Oliver Neukum wrote:
> 
> 
> On 12.12.22 14:40, Johan Hovold wrote:
> > On Mon, Dec 12, 2022 at 02:27:46PM +0100, Oliver Neukum wrote:
> >> On 12.12.22 14:14, Johan Hovold wrote:
> >>> On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:
> > 
> >>> And in this case there was also no kernel doc for usb_get_intfdata()
> >>> which is equally self documenting. Why add redundant docs for only one
> >>> of these functions?
> >>
> >> Because knowing that one of them exists makes the other much more
> >> obvious.
> > 
> > I doubt anyone finds out about this function by reading generated kernel
> > documentation. You look at a driver, grep the function and look at the
> > single-line implementation.
> 
> Look, we cannot solve the issue whether kerneldoc is a good idea
> in general here. If you want to open that can of worms on lkml,
> by all means. go for it.
> But failing that, silently eliminating it is just not nice.

It was just added. It's mostly misleading and incorrect. Hence revert,
rather than put the burden of adding proper documentation on the person
calling out the misunderstanding (which has already led to a series of
bogus patches).

> > But it was never perfectly good. It claims that a driver "should" use it,
> > when it may not need to (think simple driver using devres) and talks
> 
> If you are presented with an interface something needs to be done
> specific to that interface.

I'm not sure what you're saying here.

> > about driver core resetting the pointer which is irrelevant.
> 
> But correct and topical. I am not arguing what people should or should
> mot know.

The comment is also misleading as it signals that this is something you
need to care about.

> If you just remove the last sentence, all will be well. And if you
> insist replace "should" with "can".

Since you insist, I'll just rewrite the whole thing.

Johan
