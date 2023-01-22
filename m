Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C867707F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjAVQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:26:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8771E5EF;
        Sun, 22 Jan 2023 08:26:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D748D308;
        Sun, 22 Jan 2023 17:26:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674404814;
        bh=eujLJzueQN/rr7uEp/mzOY8lg5QhIUlSSUUSueSHrF8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PF6/H4pYaje1DHtCKKhBZbSIvmIwHe93BCVej26Ongx+mvhibGt2Oi5X+QyVzt/zW
         Ba14W9Q7TkuJNfBb91mHNK9g1hMRHziTVg66FcIqfaYwxhqU4Lcv1MnIvKY2XvyiTT
         +uz8AO92TN2BXqlf9oWFcN0E34k3Lr2KhJX5M72g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d5363f85-44e1-eee1-f7a5-61102637ef53@i2se.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com> <d5363f85-44e1-eee1-f7a5-61102637ef53@i2se.com>
Subject: Re: [RFC PATCH 0/4] Drop custom logging
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Date:   Sun, 22 Jan 2023 16:26:50 +0000
Message-ID: <167440481093.3533645.5465896340839457121@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Quoting Stefan Wahren (2023-01-22 14:21:05)
> Hi Umang,
>=20
> Am 18.01.23 um 12:58 schrieb Umang Jain:
> > Drop custom logging from the vchiq interface.
> > Mostly of them are replaced with dev_dbg and friends
> > and/or pr_info and friends.
> >
> > The debugfs log levels (in 4/4) are mapped to kernel
> > logs levels (coming from include/linux/kern_levels.h)
> > Would like some thoughts on it as I am not sure (hence
> > marking this is RFC)
> >
> >  From drivers/staging/vc04_services/interface/TODO:
> >
> > """
> > * Cleanup logging mechanism
> >
> > The driver should probably be using the standard kernel logging mechani=
sms
> > such as dev_info, dev_dbg, and friends.
> > """
>=20
> at first i want to thank you for the work on vchiq so far.
>=20
> There is something which is not directly related to this series, but it=20
> is also about debugging. The driver has a buffer which is accessed by=20
> it's own DEBUG_* macros. The content of this debug buffer can be dumped=20
> via the /dev/vchiq which is also used by ioctl. I would appreciate to=20
> move this dump feature into a new debugfs entry.

Do you have a full list of the tasks you'd like to see completed ?
(including/or above drivers/staging/vc04_services/interface/TODO)

It would help to have a clear picture of tasks needed to get this driver
destaged, so that we can support the ISP upstream.

Regards
--
Kieran
