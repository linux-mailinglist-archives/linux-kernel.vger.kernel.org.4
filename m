Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0E667E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjALSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjALSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:24:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDD728BC;
        Thu, 12 Jan 2023 09:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 129C4B81EE6;
        Thu, 12 Jan 2023 17:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9F9C433EF;
        Thu, 12 Jan 2023 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673546361;
        bh=5yOeBifgHvnIKA0Pfcw2MGNhJhycBSIeJ80Fy30rcY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMW00NxLgFKvkc8KoKzZRB16R4IXCPmXQ+YD0jc0NIRfLXy8r+WftxBNpNW9oT3zf
         /VK61Wu7z3dFYYm/nR3XqKOp1uemwQhoeVvb7DithKgT9uNiQIakyV/VZjJhNhrR8C
         Qdiq6YwemyvlzJ6ip6/Nm6L7HtBnxHXP8vQlFeaNdVZhlA9VroMAlxzsfMfsdXg+qr
         +c6H/YQ1cxEEPn4/4OL1E9JH0WCvGY4sxp8pjQMsJxFjc269K9eF3XQunV1kILZJL2
         L4CkMuo1FbcInGri4KG2D2+U24DVATNNBlBHtQw4yP9wMeIxrtSaJgCoyC1+vf9Dg7
         2pMfj1Ixr9kcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG1rN-0005hJ-MQ; Thu, 12 Jan 2023 18:59:29 +0100
Date:   Thu, 12 Jan 2023 18:59:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EC200U modem
Message-ID: <Y8BKgcoBuDT9DIeZ@hovoldconsulting.com>
References: <20221228113847.8550-1-ali.mirghasemi1376@gmail.com>
 <Y8A8yZXqg0usMEk8@hovoldconsulting.com>
 <CAHBoX=aDQ67BoG9vd+0Ndw-KL+RDN5ZrAjwgFwWuyKcvWEWb3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHBoX=aDQ67BoG9vd+0Ndw-KL+RDN5ZrAjwgFwWuyKcvWEWb3w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:26:43PM +0330, Ali Mirghasemi wrote:
>  AP: Application Processor
> CP: Coprocesso

So how would these be used?

> MOS: could'nt find real words, but it use for debug modem

Ok, thanks. Apparently, I've seen this in one patch before.

> Do I need to send new mail with an edited patch?

No, that's fine, I've already applied the patch. It's just for my
understanding.

> On Thu, Jan 12, 2023 at 8:30 PM Johan Hovold <johan@kernel.org> wrote:
> 
> > On Wed, Dec 28, 2022 at 03:08:47PM +0330, Ali Mirghasemi wrote:
> > > Add support for EC200U modem
> > >
> > > 0x0901: EC200U - AT + AP + CP + NMEA + DIAG + MOS

> > And for my enlightenment, could you spell out what AP, CP and MOS stands
> > for (or what they are used for)?
> >
> > Now applied.

Johan
