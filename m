Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFB6645A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjAJQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjAJQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:09:08 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2A5495C1D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:09:06 -0800 (PST)
Received: (qmail 677922 invoked by uid 1000); 10 Jan 2023 11:09:05 -0500
Date:   Tue, 10 Jan 2023 11:09:05 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: add WebUSB landing page support
Message-ID: <Y72Noc+gTlXIGE78@rowland.harvard.edu>
References: <Y7G797A2CIF1Ys/t@jo-einhundert>
 <ca67837b-ef00-b314-2050-3274db8c8fc5@collabora.com>
 <CAMUOyH2M5V7wcdz_xNHkC0LeXVLRtzBoTyA7nEGynnUqnn09mQ@mail.gmail.com>
 <e1c43612-3f36-8213-c515-9fac11b184ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1c43612-3f36-8213-c515-9fac11b184ff@collabora.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:28:55PM +0100, Andrzej Pietrasiewicz wrote:
> Hi Jó,
> 
> W dniu 10.01.2023 o 00:19, Jó Ágila Bitsch pisze:

> > > > +                     buf[1] = /* WEBUSB_URL*/ 3;
> > > 
> > > Why not #define WEBUSB_URL?
> > 
> > in a previous iteration, I had that exact #define in place, right
> > above. However, another reviewer found it pointless. Maybe I should
> > instead put the define into include/uapi/linux/usb/ch9.h
> > 
> 
> Hmm. ch9.h had been called ch9.h for a reason. It corresponded to Chapter 9 of
> the USB spec. Adding to it something that by design is outside the spec might
> not be what we want. But I don't know.

It wouldn't hurt to create a new file: include/uapi/linux/usb/webusb.h.

Alan Stern
