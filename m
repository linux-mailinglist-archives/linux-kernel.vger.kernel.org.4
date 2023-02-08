Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833568F01F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjBHNqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:46:10 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B961301BD;
        Wed,  8 Feb 2023 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675863956; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oJ2prIYzaB3FffPQnM/YnYw5nD2OYJYmy00NF8sViE=;
        b=vj+1lyKx//JjOr6qeU67hiMBRf81ef1Cn/weiEu0pPLiR3nv3jVRQ/vbmydOk6lyGiHCLX
        nzOsVkS+G7S0YgA78m3deAVW1vOg4XJzCFke7bEgmqzBeTpVmd6MjuiGukJ85Zib9ahqZv
        ENdCtCQDWF7JBmobnUau3p17VTDtKyo=
Message-ID: <a8af39da7805bf51cbbdc101dc5db2d156d3d242.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Wed, 08 Feb 2023 13:45:52 +0000
In-Reply-To: <Y+OQUpZFdplQUcdJ@kroah.com>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
         <20221104131031.850850-2-s.hauer@pengutronix.de>
         <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
         <Y+OQUpZFdplQUcdJ@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Le mercredi 08 f=C3=A9vrier 2023 =C3=A0 13:06 +0100, Greg Kroah-Hartman a =
=C3=A9crit=C2=A0:
> On Wed, Feb 01, 2023 at 01:32:51PM +0000, Paul Cercueil wrote:
> > Hi Sascha, Greg,
> >=20
> > I have a breakage in 6.2-rc* that I eventually bisected to this
> > commit,
> > on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
> > configured through gadgetfs.
> >=20
> > When plugging the board to my PC, the USB network interface is
> > recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
> > reverted on v6.2-rc5, everything works fine.
>=20
> Ick, that's not good.=C2=A0 Can you send a revert for this?=C2=A0 Sascha,=
 any
> ideas?

Yes, I was hoping Sascha would have a better idea, but I'll send a
revert tomorrow.

-Paul
