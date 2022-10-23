Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A96E6091D7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJWJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:06:10 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A345FF57
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666515959; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JrzpiFWU5QBv41VZlKxsAeaSvlOa+84QdcGKsFRClwfq1GLE36l/JNgBaMpKe1ABJAyuo4qFOHckZE6Y88txSIDI1LR45D8Bx1HgB8qjpkxQGccapkYpu/o/7+bWHlwwUwn8Iag2+ahg8ZaSVrveRbIQNOQ7YjPm6998WHuGF/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666515959; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0rOuIG6qt8WPxHPXhtiCyN7VKQ7GPvMiBmq66pv+LPU=; 
        b=TcnEHnf8c9GKnB5PRrhHkoVNasvp+m61ndyChIL7DKSru7hg261RUcBQO1qx3srwi2UPxcC4PIMdeU/QTQ3EOPq0CmfmQN3GZ8jF0Ea2Rkz7eMaTGLkRR9XDC7vO4rva+aw+fThO2dHtw21DDHa38qM2S4rUuhgMRNtT5abvj8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666515959;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=0rOuIG6qt8WPxHPXhtiCyN7VKQ7GPvMiBmq66pv+LPU=;
        b=M98urZqeTXfvMtjdicLW21Mm7ADtZEKp4WY1jl3bpWbrxdOX8SPyXQzg1/ur7ppM
        Kt1CnFiHXH1S8zAbMI6PRnYwXJMP2DCCV4vmH/tiUwuE4KHnJGBkIlBgSiX6w2CkW2J
        HRh2EPktWp1z97hVXvd9fNPRSmH4XVyjXiQQYets=
Received: from [192.168.0.106] (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 1666515957272213.95334367704515; Sun, 23 Oct 2022 02:05:57 -0700 (PDT)
Message-ID: <58a34e59c75e2f9fbb918d632590f3115a585bfc.camel@zohomail.com>
Subject: Re: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing
 blank space
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sun, 23 Oct 2022 16:05:50 +0700
In-Reply-To: <20221022182100.GA16464@nam-dell>
References: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
         <20221022182100.GA16464@nam-dell>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-10-22 at 20:21 +0200, Nam Cao wrote:
> On Sat, Oct 22, 2022 at 10:48:08PM +0700, Aaron Lawrence wrote:
> > > From e6635103e3cf2426220767955b99d2e2b62a7329 Mon Sep 17 00:00:00 200=
1
> > Message-Id: <e6635103e3cf2426220767955b99d2e2b62a7329.1666450553.git.t4=
rmin@zohomail.com>
> > In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
> > References: <cover.1666450553.git.t4rmin@zohomail.com>
> > From: Aaron Lawrence <t4rmin@zohomail.com>
> > Date: Sat, 22 Oct 2022 20:46:25 +0700
>=20
> I think you messed up something here. These are not supposed to be in
> the email description. All your patches are sent separatedly, instead of
> being in the same thread.
>=20
> I can recommend follow the instructions in this website:
> https://kernelnewbies.org/FirstKernelPatch
>=20
> > Subject: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing b=
lank
> > =C2=A0space
> >=20
> > Added a missing blank space as per the Linux kernel coding-style
> > regulations. The issue was flagged by the checkpatch script as a
> > warning.
> >=20
> > Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
> > ---
> > =C2=A0drivers/staging/rtl8192e/rtl819x_HTProc.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/stagin=
g/rtl8192e/rtl819x_HTProc.c
> > index ef3dca51cf99..b763cf0ba356 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > @@ -70,6 +70,7 @@ static u8 LINKSYS_MARVELL_4400N[3] =3D {0x00, 0x14, 0=
xa4};
> > =C2=A0void HTUpdateDefaultSetting(struct rtllib_device *ieee)
> > =C2=A0{
> > =C2=A0struct rt_hi_throughput *pHTInfo =3D ieee->pHTInfo;
> > +
> > =C2=A0pHTInfo->bRegShortGI20MHz =3D 1;
> > =C2=A0pHTInfo->bRegShortGI40MHz =3D 1;
> > --=20
> > 2.38.1
> >=20
> >=20

Ah, I see. I (hopefully) will be sending the correct email=C2=A0
patchset format next time. Thanks.

Aaron
