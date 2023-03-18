Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EFC6BFB30
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCRPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCRPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:25:09 -0400
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Mar 2023 08:25:07 PDT
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE6F18A96
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:25:06 -0700 (PDT)
Message-ID: <e872037e88af46ee4a329a2bee39806533365018.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679152549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR0CuRyOezUnFd4VADqINnV0NjCLi52z5JOf95rttMc=;
        b=nkBTJv/plWRp2yCy0P23isJwXeNfkbNbENfU8+lTZkCIW+dwnF7+QREz9rFYCuCEkV+JJo
        czxTLKhE4R3uCvLVTZGgfDgp3g/JwpnLAemWp1UH4Wb6osoXt1SxWQSZEy9EwdtXa6Yd9K
        XXuW91zDtpaqstTSIH2YGt4dF4xdHoc=
Subject: Re: [RFC PATCH v1] usb/phy add sprd ums512 usbphy
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cixi Geng <cixi.geng@linux.dev>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, arnd@arndb.de, tony@atomide.com,
        felipe.balbi@linux.intel.com, paul@crapouillou.net,
        linus.walleij@linaro.org, cixi.geng1@unisoc.com,
        gengcixi@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Sat, 18 Mar 2023 23:15:33 +0800
In-Reply-To: <ZA7DUH+qJyMmWBq5@kroah.com>
References: <20230312171438.177952-1-cixi.geng@linux.dev>
         <ZA7DUH+qJyMmWBq5@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 07:31 +0100, Greg KH wrote:
> On Mon, Mar 13, 2023 at 01:14:38AM +0800, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >=20
> > This driver is support USB2 phy for Spreadtrum UMS512 SOC's,
> >=20
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>=20
> Why is this "RFC"?=C2=A0 What is left to do on it to be accepted?
this is just the driver code, lack of dt-bindings=20
>=20
> > ---
> > =C2=A0drivers/usb/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > =C2=A0drivers/usb/phy/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/usb/phy/phy-sprd-ums512.c | 511
> > ++++++++++++++++++++++++++++++
> > =C2=A0drivers/usb/phy/phy-sprd-ums512.h |=C2=A0 39 +++
>=20
> Why do you need a .h file for a single .c file?=C2=A0 Please just put the=
m
> all together into one file.
>=20
> thanks,
>=20
> greg k-h

