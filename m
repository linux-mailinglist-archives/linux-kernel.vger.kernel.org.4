Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E585B54E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiILHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiILHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:00:30 -0400
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F3E099
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:00:27 -0700 (PDT)
Received: from imsva.intranet.prolan.hu (imss.intranet.prolan.hu [10.254.254.252])
        by fw2.prolan.hu (Postfix) with ESMTPS id CBF287F505;
        Mon, 12 Sep 2022 09:00:21 +0200 (CEST)
Received: from imsva.intranet.prolan.hu (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B7C134064;
        Mon, 12 Sep 2022 09:00:21 +0200 (CEST)
Received: from imsva.intranet.prolan.hu (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10EB53405A;
        Mon, 12 Sep 2022 09:00:21 +0200 (CEST)
Received: from fw2.prolan.hu (unknown [10.254.254.253])
        by imsva.intranet.prolan.hu (Postfix) with ESMTPS;
        Mon, 12 Sep 2022 09:00:21 +0200 (CEST)
Received: from atlas.intranet.prolan.hu (atlas.intranet.prolan.hu [10.254.0.229])
        by fw2.prolan.hu (Postfix) with ESMTPS id D951A7F505;
        Mon, 12 Sep 2022 09:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=prolan.hu; s=mail;
        t=1662966020; bh=kTBK0ARmVjg18iD+1nZbDolmxsHFuR3obhf/lZol4ok=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WQVqdkHW+VqY+VJo125qNyqw0ZNbXheEUeioST2Ttzf1z8Nho9yArUzN1bRfSJmsr
         gbIHMHL4T8GPdwnwEyQkiVkVsIpw5Qkire941N3/+JARXwezEl0kUafGYakIJvApLb
         wPlEI2sJYSSRrwZySazcdXtyTx6ElD202KSwhniT0K3w96RxsnD2rD/wP8YvEwB3je
         swRVJ/j/bPD0K99BgoSCueMe86BvS7+cyLg2akolpF0WgH3Xz5SKRhetK0OpBKA/gd
         QYeZw3BIYYOQEOZqFurOR0RwPHPmx1kjJLT/TXl6iidAabXdt/dzIkieeA1oyGx318
         KzipCukbFgIZQ==
Received: from atlas.intranet.prolan.hu (10.254.0.229) by
 atlas.intranet.prolan.hu (10.254.0.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id
 15.1.2507.12; Mon, 12 Sep 2022 09:00:20 +0200
Received: from atlas.intranet.prolan.hu ([fe80::9c8:3400:4efa:8de7]) by
 atlas.intranet.prolan.hu ([fe80::9c8:3400:4efa:8de7%11]) with mapi id
 15.01.2507.012; Mon, 12 Sep 2022 09:00:20 +0200
From:   =?iso-8859-2?Q?Cs=F3k=E1s_Bence?= <Csokas.Bence@prolan.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: Linux 6.0-rc4
Thread-Topic: Linux 6.0-rc4
Thread-Index: AQHYxVzjiZP9/E6GFEWcqcE/R/hO3q3bXhfT
Date:   Mon, 12 Sep 2022 07:00:20 +0000
Message-ID: <7488bc1ff5b34b7aa79ef31c7d19f5f2@prolan.hu>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905125637.GA2630968@roeck-us.net>
 <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
 <752fba06-8ccc-d1e7-68d8-f141eece1230@roeck-us.net>,<CAHk-=wj1obPoTu1AHj9Bd_BGYjdjDyPP+vT5WMj8eheb3A9WHw@mail.gmail.com>
In-Reply-To: <CAHk-=wj1obPoTu1AHj9Bd_BGYjdjDyPP+vT5WMj8eheb3A9WHw@mail.gmail.com>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.66.172.55]
x-esetresult: clean, is OK
x-esetid: 37303A29971EF4566D7564
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there, perpetrator here.

It seems b353b241f1eb9 is botched, and may be reverted. I am working
on a replacement fix, but I am working remotely. Please do not revert
f79959220fa5 just yet.

Bence

> Let's bring in the guilty party and related people..
>=20
> It looks like b353b241f1eb9 ("net: fec: Use a spinlock to guard
> `fep->ptp_clk_on`") is not sufficient to fix the problems caused by
> f79959220fa5 ("fec: Restart PPS after link state change"), and in fact
> just causes more issues.
>=20
> By now I suspect that both of those just have to be reverted.
>=20
> Hmm?
>=20
>               Linus=
