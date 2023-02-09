Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31F5690853
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBIMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88732F7B2;
        Thu,  9 Feb 2023 04:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auajaBoPCNBXVVSnu0ETSKZKtRpzCb1AFoVCbsGN2aTvh0rX3Dfp4Syg1in54vtrSKu54D6waKtKkV+8Zk3iHKBymHg6oNQS7drA+wPsZZrHLiWxKm+v/7Hrfh0nzz1ju7ksqm2L2MJu5ypYiFd24lHRQjAnC4kQaaBADMT3Ogt1sKzhbvA9X/nSa/BC/rl4Me4IPpoqSV9Wz3sA7oksh3Vb6YJeKCD++urHo9B1YpuiaUxpkio9kPldI/BIXaYj9265JddKbSQWeFZss4pLYPpCU1/ZtPAtWUIqtP/QzgFqKIe7ePfGfhCaYA8tzYVgdP80jbI7e84v5djRrMjtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5xiit1uIBprR9d9NhQn9EZCT5rwy6+4X1oOTF7Wv94=;
 b=FgDIrlKH+37r6B8ea6hrr8J0f8HqcnRe1Guazjp6jwZ4NYLawEG/d0CMYdEDeUdm4lVP2fWICY3gJgUGkXwuXLKqDZdt6/Kern+3RWPxw4hMGp77GB8MVLkUh1XDshBLxqM6Fz7fBjF04WYnmXfV11JrA1M0WM8maqwg3ZN6DpkADb7ArYKmojjLYnvcsrsBOCVMjR3wGgScKcET7ApChUfBDzMFLo6ijjW8+yJPNaEEUb/gtxDxVGm5ieSD269ilAbDx2rVMdf/v5r24Xqu4mEYcqssE92Wdjamfr3rsnhjmqYhlxXZkjeHC73NBq4ASAcvNankdArSugAoms494g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5xiit1uIBprR9d9NhQn9EZCT5rwy6+4X1oOTF7Wv94=;
 b=alFYaemak/UHXci2Ijj3hhXH1TKcMJKP9lD4EqiprHAiVGSTfjX3m+DCPjcJIblijV7rlHZFXDvdrsF4fGPNyz6U176+9HevWmfmXXXNZnvpTiduDZ0tSd2SHI5qN68pR3SgWkPkPreLuiKXKCAa5rJSmirIhLuQrqLA5xTErfzRdnfPnL6+3N3RDWgahkBUvGoH/loyIURgZE3zbnAdC4rygnWrp/iH4OEf9vlXqdyQk5J6Ku4TQN3jPacgKf3wA35i5s+NsfD45jq/g8AIIOQt6K/jFvXrkqQ+M7PHepBDu6AkphHPjGB/ZpZqhNmyAexVpUC5HPlmI9hZL042Fg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PRAPR10MB7623.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 12:09:04 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 12:09:04 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH v4 2/4] tty: n_gsm: add keep alive support
Thread-Index: AQHZO7eMpDhLbhqmwEm/tSXMF5bxIK7GhypA
Date:   Thu, 9 Feb 2023 12:09:04 +0000
Message-ID: <DB9PR10MB58818B4443F5EA3CB8766DF3E0D99@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230206114606.2133-1-daniel.starke@siemens.com>
 <20230206114606.2133-2-daniel.starke@siemens.com>
 <Y+OTN4E6W5h4oztW@kroah.com>
In-Reply-To: <Y+OTN4E6W5h4oztW@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-09T12:09:03Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=3e5b5f60-02d7-4a09-b961-81a0110cffcc;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PRAPR10MB7623:EE_
x-ms-office365-filtering-correlation-id: fddd6284-38da-4aa1-31d8-08db0a96700c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+WG3qaCyMJ0fR0xC9MAcOD0TdgABQUaWpwi3dfFN19WJpT6c0LWhsoEfq0U3a2bMnuuCyL+FbrNK7xxOpWjhc5rQRGEhb80qHT1V1ARld5lFzBGqWZcmpYHSxwn6ZTk3sLZl2tW9UsuBQCzbZ6KVLNYotghxRF2dkQoDN6raEDlHMFbt6yuYbkcSdZ71iE4wekN7HLs1q6izeYwwOJ8bZdQ5SUvq24KUJEsN7VxR2d4LgcHi5Ay2xB1OA0mRw127wGxftxnSZ0OOULzIfTbwQnOttV8ateXFlx5gE5NqjbuQRFQ9Dbsd3gbqlXXWavOEpOPvtLjxIzoO10g0xNiy1CzZGw1w0BPESfCpAwKxjSXIThhLgXprSuebRlHpJALrrG849GjB7jbi7fG4T6zdffdvbTmBaakDucmmX8ku7tVtWJRo+Dvs0fubUmnseOTbmJfujyLSIl+N2u54Q3ZA0ykom5f32HLER7eoZ2NN53wNgArXw4iUVTDjnd0iqEsctOarZlMXAXi9ptMpfTIpwjuxaRbVz+yDl91jIMB4ui2Z8W02MpDJ0OSIORK9PYjB1Rdv7/j6MMXPlHdylMpQ4yQeZ4Yc5ll/XKmojtNHTDAK7ZIs3ryTSznZewVbckRw/3c4jtqSVFpIj7VAuQ6X6OWTX2+uRrsAQMp7gFEQVpVS6Z5iVMfIHeNeLrqO++UHXHHR+lD0RZp89yLss12ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(33656002)(316002)(54906003)(83380400001)(71200400001)(7696005)(9686003)(26005)(186003)(6506007)(478600001)(52536014)(82960400001)(8936002)(38100700002)(2906002)(86362001)(38070700005)(5660300002)(66946007)(66556008)(76116006)(55016003)(66476007)(41300700001)(66446008)(122000001)(64756008)(4326008)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HT+jC7kpih6E25BgSrtUinJ0smERUbkIY9wDvsd/1Un/JqdxDV3065Cj0r0X?=
 =?us-ascii?Q?qxrEz9JajBjUXB51Lu22nTBGLaVpNDpG3suNVBGQJu7t0p506LCwi2YKUCWg?=
 =?us-ascii?Q?zjsbuQQ8SUSasxaNo2MxtAYNCm7ynxEzgJWtrbvaR9CsJVkgcK9psqmRuUCr?=
 =?us-ascii?Q?m3RO9NbGXTEVZbWLHdIrapl7SCpLij94aVX19uFiiC+EzWnF5k7zraXoelg8?=
 =?us-ascii?Q?cBo8eBWxECSOcbiMYiYG9s5L7YlIlpiCZ1XvZtyCYgexsRAD4RjcJsoqyPzT?=
 =?us-ascii?Q?y7Fc1E1m5AtrHj1YTpa7sgz/Xqh8uQipsK+O7ay9+tvN34I1GyY/AXEa9Gj2?=
 =?us-ascii?Q?SGrVw+pnXqrEkMxv+DS/KmZHCgM88EoEuhA1FBjTbrydCW/A6QXmAZAkGnO3?=
 =?us-ascii?Q?97FIt9g68hVsmEyO1adGZaf0T15xAYLDQBjjA13N2fTNyxoB0D7y68PYoaIK?=
 =?us-ascii?Q?iuANxSUXiBOvnIK/Lq7jv8h/ogcTLGox+mOoy6G/S95jozULJF1lX9cWghxB?=
 =?us-ascii?Q?p26cXrwsT5v2Il4i8rsO19GtJ2ulXqaHo5wHmOguH/tY6kdwt3UwhxYXoEUF?=
 =?us-ascii?Q?ZqOS8mwP/2VtdVt0I94b7khyYy/be5h/2dL0LAGn/YpSh+/GomQCWZak4Lu1?=
 =?us-ascii?Q?ytPOXxBpIc/C5K7iXZdyHbSvUqpxgj3iWI9ShKxwa9EfdK2R6WA5ZGTSb5Vw?=
 =?us-ascii?Q?5FOvMX0ekBkbCJDoplxmFg1hTQMpP6p69D5on1JbeeY6M4ruautqjI1l7y46?=
 =?us-ascii?Q?XqvA1DRhfRcFSeRfQgdT17URzZAZKp+W6A9XHMyKmGsDyG5ZYFUpsKAOZ3RO?=
 =?us-ascii?Q?2m7DY8qo1y1qLnoZos0KCXIxKOMaYuMWctL5CK19r3DOjXWNEczAN8lN4lYM?=
 =?us-ascii?Q?AB8qUcw6A8/B1KVunHdwJ4jRO/uKquezgI+3YjiTQy4ISIV1fqfmmhIyk7dN?=
 =?us-ascii?Q?SFJKEG4F7j4VbZvMcZ+onwtH1JBBoK0Lvrn2YShnk5+6kOvh63XVA+rkblrE?=
 =?us-ascii?Q?XNnJ38JmdRzrTm6xTycWPSSmSB95FZtWJD+CWkLBTdlp4MkyKjci85AYUhKI?=
 =?us-ascii?Q?UDe/4rRtvma8ef3dCtlBJ2g1iIiMstfOvfL/0jfE39Pdj1OxePsHFO+KX5Px?=
 =?us-ascii?Q?vanC2w190e753zAVbt3RufcqngSQgCZ0lCSYbrfDs/hPoAbryYxQs5CL8uka?=
 =?us-ascii?Q?mgTvvZxoHCpzKOi4jcXajnLIZItM/WA2/RUa+mZfqr1WMxggTsKbGMTFJ0XW?=
 =?us-ascii?Q?pLPQyyFKWoPKO4pVb+HFeYhULCfsSs3m5rSBcNfJ0JU620eCOsEDn5Ew3ln+?=
 =?us-ascii?Q?BCbg6k3dmEPgC45Yhrtgr1uqY7pCFXxrTkpg5kKEOppHsFM5GJqvFMTG5ShF?=
 =?us-ascii?Q?IJLniFMrIP1ihCGs6GCAX4KAQFBtNzPNt9JBeOcXoCX/2aV1xBRciHL4nLoh?=
 =?us-ascii?Q?0PsqCYQkDj/1ycaSRp++qvuEJdsnn/PlOLJx6Le+GOB/3uPwd2Yis//lO3cl?=
 =?us-ascii?Q?D9O2dQupLtsbOH9VD0LS6DAxDGZoW9EKiDrJ64XCR9FnBdbdAmuAzm/YMXgO?=
 =?us-ascii?Q?yMeogZCiWQkpOrzZ0b3o9235yXAKmjW/JhUdKVH1Rb/h4/5jvO17gaVcBEUb?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fddd6284-38da-4aa1-31d8-08db0a96700c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 12:09:04.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6d3ivWrUcyCoAm9233Azf9HE7ZvQQxKQDCtSgibSG4n8kNnXnuGzi8028hYVSQlbO5x23MYl9UPdpK+O7/O7FiSm8qHcmDXWmYrIWg81ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB7623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for this detailed review.

> > +	u8 ka_num;			/* Keep-alive match pattern */
>=20
> What do you mean by "pattern"?

Keep alive uses the test command which expects a byte pattern. This pattern
is simply echoed by the peer. We use a different pattern / byte value for
each keep-alive packet to distinguish between interval and re-sent
attempts. I will add ka_num to the commit message to make it clear that the
"single incrementing octet" refers to this field.

> > +	int ka_retries;			/* Keep-alive retry counter */
>=20
> I know padding doesn't really matter much here, but you are adding holes
> here to this structure, is that intentional?

This was not intentional. The same is already true for the ftype field and
I need ka_num to be 8-bit. Changing the field order does not really make
this any better. Therefore, I would like to keep it as it is.

> And why "int"?  What is the range here?  And shouldn't this be "signed
> int" to be explicit you set this to -1 in places (and what does -1
> mean?)

ka_retries takes the value from the field n2, which also happens to be
"int". I will add -1 to the field description as "not yet initialized".
I will also change it to "signed int" and add an appropriate cast from n2.

> > +	/* Or did we receive the TEST response to our TEST command */
> > +	} else if (command =3D=3D CMD_TEST && clen =3D=3D 1 && *data =3D=3D g=
sm->ka_num) {
> > +		gsm->ka_retries =3D -1; /* trigger new keep-alive message */
> > +		if (dlci && !dlci->dead)
> > +			mod_timer(&gsm->ka_timer,
> > +				  jiffies + gsm->keep_alive * HZ / 100);
>=20
> We can use 100 columns now if you want to.

I will change this for better readability.

> > +	if (gsm->ka_num && gsm->ka_retries =3D=3D 0) {
> > +		/* Keep-alive expired -> close the link */
> > +		if (debug & DBG_ERRORS)
> > +			pr_info("%s keep-alive timed out\n", __func__);
>=20
> info for a debugging error?  no, please don't do that.  Please fix up
> the debugging mess in this driver, don't add to it.

I am aware that the current debugging concept of the driver does not align
with the kernel philosophy. However, this is the established way it is
handled in n_gsm right now. Cleaning this up should be done before adding
new concepts here. But not printing out any information in case of errors
does not help during use and development of/for this driver. Also note that
all these outputs are only enabled if explicitly set via kernel module
parameter. That means syslog does not get polluted if not intentionally
set so. Unfortunately, I do not have a better proposal for now as neither
ftrace nor dynamic debug are available to the normal Linux user.

> > +struct gsm_config_ext {
> > +	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
> > +				 * second (0 to disable)
> > +				 */
> > +	__u32 reserved[7];	/* For future use */
>=20
> say "must be set to 0"?

Right, I will add ", needs to be initialized to zero".

> Where are you documenting this ioctl so userspace knows how to use it?
> Where is the userspace tool that uses it?

I will extend the description and code example in
Documentation/driver-api/tty/n_gsm.rst. Should this go CC to
linux-man@vger.kernel.org?

Best regards,
Daniel Starke
