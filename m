Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527668631D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBAJtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBAJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:49:03 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62E269F;
        Wed,  1 Feb 2023 01:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm0Cl156Nlmf+dDxkk3/hL2XEgTxhT8eI9AsP2rgHnV93zJzCRZuep7D/UhS/Old1OicOcTZBz0HoNTkBfePNTXtwPHH8ZHGnpn333YtQXQ9/6kHUO6IlshT1jskIeLrkt4kx4H/nAPPSK6DxQzluu467p3LmlMGerTEUoJUXdu0cBryE04kXQgKOZZiK8fDtm6GuLFinsQfFLLBy0N00yO00Wa0rHhnVV6tt9OWAuJhJG2GOng56Fiib+NpRfWB4+fM1r0u1Jcux6s7fsyqgpvigOh1J725q74QMaRRgPYJmJBt7EIFW/fKGJKZUUlAFp6sSHRkNc18rBYHRNShCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72v1EzYIkSW0ZdpsnG6/NPILyd/HtpbaQ1mt+F3OCd4=;
 b=iafJrcZYNsLsrEO2ZDny8RmHw7gPBQ/M/Er9gd9yt0rJiorOoVkgERrdKNKwX49c9LV+8qOxsHJdlVRbHjsBDDPuKHqYs6jPlheuceXWPPGwg0NO820p9KTQ8x3zxOe0V5QDGYp647HtizFJ/KESHUsauLPunsBiOUUHryd8Chmhk3FQ0DKiYOcGnA8VzEKzYiy3A39v390Xi5yLdOoQqOLjeftmzD6ox9KZ4y48F7CjGtfRfjfBtfBzTOnzy1v3vXGM5HaQ946RPH9gmnS38mwZFkLevVoKnLVbaGADpMblyIUWPKIgWUd0vnxVyjzfjv1AmGTFNR/WeNuOZ46CjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72v1EzYIkSW0ZdpsnG6/NPILyd/HtpbaQ1mt+F3OCd4=;
 b=rquz5oz2OyDU7qD7fvcwQxRk3Wi5Zs7QGFrW4gCC8V+TtmMeURFsnQK8gU3ICuTmHxiT7bU6VOMw502AiEfOioM9Q+o1NmCjcH2hNxopWmQSyh172nDqa3ANciz9d/lmmwHAJ/EPS7XC80fWVx9Otcl6pEQS+n/jJ9gsKr5kK55wDio76Ch9UxuNJMBnolfGjq57hxx6gz8jJ+IzycCWVCWqd6vIwGuS4UMscGAabpjFLisF+btx5c+HqyKZmrtoak9owknLdERZ+k+oSU5tlcm8ajb8Cx5meqrOHNzMxO6YSYh08C5UbM5h0AEpYNGCMGs54+hR8ucgTb7tQHZ9XA==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB8PR10MB3595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 09:48:58 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 09:48:58 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH 1/3] tty: n_gsm: add keep alive support
Thread-Index: AQHZNhjWVUvjeWMSkEi/GfrXE3Mzea65z9OQgAAC5oCAAAXj0A==
Date:   Wed, 1 Feb 2023 09:48:58 +0000
Message-ID: <DB9PR10MB588101762F5AA07EE43F0658E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <Y9olcm0PiSCSikri@kroah.com>
 <DB9PR10MB58814F4711FC3403F7AF089BE0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <Y9owmfZwKn9+1xBf@kroah.com>
In-Reply-To: <Y9owmfZwKn9+1xBf@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-01T09:48:57Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d3f68aaa-fad3-4656-a56b-0cf1933e559e;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DB8PR10MB3595:EE_
x-ms-office365-filtering-correlation-id: 64230821-a126-404c-d567-08db04398aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWGWMSvJC1QCB69irWJGAWuFfJf9m6NYrCge8ZUrwlXSGIxMEfg690nQBeJEcbpo+6/37PnqWVIGl5nEt6yxMyaYyu/C7713L5skPLQmYFp4Xlwl3qhmKgLP6CbuMOiSomDkqh//+AdGbbf6jI3Dk2oEGJVRxr3v9+Xee66EesB9qC70F29LByaALhNPseN2GX+lWAHCCCK1fdedFPrQ8atzXTK4cPQeEEvzojVgie4Zj/aLWCNx2036cp+pBtBQrHzf5TPapmvy1bgqG5b6UM9f/4G76W84CsWOjrXGuG3lYx4Uey9llVxrhYCr8RoiIWIVuQZqEQu60C7S8shHBnJ29HGrZSY0ChzW6/6C66i2y8PkrjIH3+Ik4pLHn6/jxL4akgSl5TML2cn+mejybtja9alFzM3m0Ju6aBF0efS2InsHitvcCz4Da0Atd07gpt1zQZWvxSNMVHVC+isgIzysf7wS4KHT7JkYmgBMq4fnHIqkRgucC12NFyUW3ptL9csEo6r039UekIgsT4DWc1e5mHIijtOCF96Dmfva7AmWQpwzCwCb1b2FBaKOkuaAz+AJl+SVDoCMV14RQ7+yrJofauq6+hF21C9ag06y9b9Uk/SsuYjAEh1ysUoQVm03QY7+L3Z/F/jnIihmQHJkl/Dg7p6dNkwnuXgwFOQt4+oxP6IjbBnyizpcQdyrT5xctOTtlcMub6doIS12TW9mZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(8936002)(52536014)(316002)(6506007)(86362001)(7696005)(38100700002)(26005)(38070700005)(478600001)(122000001)(9686003)(186003)(71200400001)(54906003)(82960400001)(5660300002)(2906002)(33656002)(55016003)(41300700001)(4326008)(76116006)(66446008)(66476007)(64756008)(66946007)(66556008)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M765IlE7zqDzkf1O3De9Zgmn0RFASluGiEfeAA+T0lgghrXkkFjUaf+dFEJo?=
 =?us-ascii?Q?nuUhiFDR4llS9OwTlHZ3HwNHijB4zSZileC6w2GVNngkEuuNY2YzdIKWOZb9?=
 =?us-ascii?Q?lQvWasjj0c+sN2mzz2hK6LRjrPWtX/A/gc4gSneDxfuLLldPzvYWBWE9r5oQ?=
 =?us-ascii?Q?oJfgYBQJmhodz6qTJGZJGdHrmkrAHAY12tU0uG+ns+62B5/K8ZYW77Vqoykn?=
 =?us-ascii?Q?igmqE52QJnBl4HVWoHtXMFOPRUuDQ26EDJi45B/STvoX2pIQh+4ER1WiWw+Y?=
 =?us-ascii?Q?ql2auuogh/7O0VDcnqr1oWvsPJ+JljKKB7RF4VWHSeV+fLOjPjx6JZCoSOvu?=
 =?us-ascii?Q?U8xv9kKu1+CP2hye2fRo5R2Tr2Tild+Kya280CL+Mw2Ak8NCF5G76k92td6A?=
 =?us-ascii?Q?zlQwy0m4lDs1TjyrxUtYgnqwPeKnWwcyqiiSCR2OmSFoU/D9Rd4DjQngiWvq?=
 =?us-ascii?Q?EIOKjaYz6wefQ45J1ojXbuct0qPb0FgoO+N8tvBz8DgCVCckLvIXen+niWzi?=
 =?us-ascii?Q?s3xVbBQxeAhLmSI8/5YQDl8Yc8cC5z0I+xnPh3aabREPHa1CuPOFx1uTGLpv?=
 =?us-ascii?Q?bxwaSj5v3AmkK7eqW6i+iBspUWVY8QcB4PKF7UtJSYuNEDValjy4y05o+zFT?=
 =?us-ascii?Q?5vLLS9Rg703LaoBex8/ljWXg+lac5GdOB3k6ZCMsScZxvZno1Gdes7ob17tN?=
 =?us-ascii?Q?oAWXWWgdKCb/n+J7NaPtWRD5kir5YZ0j2Bw1g5ZxSJyGoNYcSca10+GqykUx?=
 =?us-ascii?Q?EIp8b36R9nhjJdfMPRO4fNV1CYK5aFgHMR2uQ2fT0QBlkGgZ2nvK/xEnQSDO?=
 =?us-ascii?Q?FFnuPXx4nJ2/m94IraHZmSM41Sz3CSgH7Lt9OkAr3rGEOf04dQZLmyJznOUl?=
 =?us-ascii?Q?olCZg+sXhoAMTWBO/4esHEfBlh42hy0fBfChpmMb4jc9WDzxz+BRwVnZHel8?=
 =?us-ascii?Q?m/zq/kSAQztFG3M7V2vzUCDgSSAnjy7joHQF0qzzWlqso5Fc279hymxs9ox2?=
 =?us-ascii?Q?eNAWp4uzSOOJCKsJI1sl4ZiVweyAdDBuv1sHqm07VNUkedOfaRQ3xH8HobeR?=
 =?us-ascii?Q?MnmMtze0EXY+WwV/jXyB3sihaKlLRoiWJFsD8XPDq+BNMu3O7YK1YuWtZ7UN?=
 =?us-ascii?Q?uxFbEarFA0cbXuTuGDGV1lBx4yFzQxuUAQyiUKGyMabgPYqxA6w+debs9Cv0?=
 =?us-ascii?Q?QcP/EMArCI3p7gTFEb2ivoP+FRFNW1clvUGSfC6pKwZFQSIDlWmQbbBUomTB?=
 =?us-ascii?Q?i9qwpUKthzF1fFXskwKmJfgu+lE/PxHiiUgt+vmnaqayeI/PjtIaq87eNo0Y?=
 =?us-ascii?Q?kAY1fneIgIKfyapjqJIDfxHErUHxDZgQ2hK8AqVsbJoO5vW7eLMLBHjZ8oTS?=
 =?us-ascii?Q?r6lwLGSGQ9LKpw7FdldlOFbQ48hUJiqV/9CljFVb89zJgXiAVIKN1sJ9dukO?=
 =?us-ascii?Q?9UV6USk2KFAhOOFG+9xtzluSUH87UWY3pVl9sv7mdGwZWCdn3+KUrAi7rU/A?=
 =?us-ascii?Q?FeiRfvALh+ZSU2j8exqzzyfEtsvXMoqfLaJeoS72DQe0govFZwiiU3BVQchB?=
 =?us-ascii?Q?V3s5FBmnrmwPGSbTLFWEA8wuP/Uz5oE8njpBftrRF2jxeoYlekmwXBQysH0G?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64230821-a126-404c-d567-08db04398aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:48:58.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wWBs8juSfj37FcRaKQose61nrZwtvroGR9OGKpQlXRjr6JRWitNrz/IZCR0ht9/wqiIEAlluldMYyRABLaEbmaHI1gmSuIXk0QiblJqJGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3595
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > index cb8693b39cb7..b64360aca1f9 100644
> > > > --- a/include/uapi/linux/gsmmux.h
> > > > +++ b/include/uapi/linux/gsmmux.h
> > > > @@ -19,7 +19,8 @@ struct gsm_config
> > > >  	unsigned int mtu;
> > > >  	unsigned int k;
> > > >  	unsigned int i;
> > > > -	unsigned int unused[8];		/* Padding for expansion without
> > > > +	unsigned int keep_alive;
> > > > +	unsigned int unused[7];		/* Padding for expansion without
> > >=20
> > > "unsigned int" is not really a valid uapi variable type.
> > >=20
> > > Shouldn't this be __u32 instead?
> >=20
> > I know but changing it to a fixed size data type may break compatibilit=
y
> > as this may change the overall size of the structure.
>=20
> Will it?  It shouldn't that's why using the correct data types is
> essencial.

Well, unsigned int is defined to be at least 16 bit. Using __u32 will break
systems where this is true. I am not sure if the Linux kernel targets any
system which defines unsigned int with 16 bit. But sure, I can change it to
__u32.

> > This is why I
> > took a field out of the "unused" array for the "keep_alive" parameter.
> > A value of zero disables keep-alive polling.
> >=20
> > > Should you document this field as to what the value is and the units =
as
> > > you are creating a new user/kernel api here.
> >=20
> > I will add a comment here. Comments for the other fields remain subject=
 to
> > another patch.
> >=20
> > > And finally, "unused" here is being properly checked to be all 0, rig=
ht?
> > > If not, then this change can't happen for obvious reasons :(
> >=20
> > This was not the case until now. I assumed there was some coding guidel=
ine
> > that unused fields need to be initialized to zero. Obviously, checking =
it
> > prevents misuse here. I will add relevant checks for this.
>=20
> If the value was not checked previously, then you can not use the field
> now, otherwise things will break, sorry.  Those are useless fields and
> should be marked as such :(

What is the way forward here? Should I introduce a complete new ioctl?
Or should I use a different size for this structure to break existing code
intentionally? Does this mean that we cannot extend this structure at all
in the future? I had planned another extension here to properly support
parameter negotiation.
In case we need to keep the structure as it is: Would a comment be
sufficient to mark this field accordingly?

Best regards,
Daniel Starke
