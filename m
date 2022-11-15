Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D6629C19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKOO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiKOO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:27:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBB2AC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668522425; x=1700058425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v2dw/nt1frj54fCDm/sG+cvibl+O1+E505keZdO1t2k=;
  b=dKdYu7S5srmUjBeaTzyv6Bx3e0nyXi1JrB7jQGgTwHjPl4KaLwtquwL3
   vCjRfINWCknjsJF7hNEh9F6WWvH5yHzpqq6+evf0D5hPTycIVAq/hxXMu
   ugsF3zBi37jDIgT4o21sQNkQrnzo2Hzq9yomENhIHHtbYIYnLKa9OzZ0o
   yFNzxPdl6R8sFCJ8mRaWUewyMMCRcN6rI6JIaxA6W2h6+ASzXDqFENOJr
   MQW78FJj2w1fqWHtVnNqXhYhUXYVuM3qbJqAiR1KSp8095nDRw9nFPlWY
   zcr7jJNz9dPvvKbSKDyeWSQqIIGBQ6ogpPbrbTHJGN74yp35Jc3VAOWrq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299786752"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="299786752"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 06:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589804289"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="589804289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 06:27:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 06:27:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 06:27:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 06:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERdMaBHzjxQsTZPDtXWyYx8RNsStSAgFdBfBq2nYT8YZWGA0delqHP6anK/Dm89oCGqUcrhuhQr/Elhz9UsO/ZPWK7kDWVnV/5SA63/QsMETXf+/SNqHBgFalyX+WKlC+8Bxfkg5j7Xa3siayitvrvB4vF7LOQ/A92XPT8oVml6Ms6iXRe2BiRZ121U2jDSJCTCAfb6eoKRrv7nOA7eemJA+IqIU+MGJg8aJlBhNckTwq750nfsDfB0fppNag0nWfUkQUl7+C5OK+REgXyI459aIPrRJQZQZ4yJvW7EcgBd41qtlF9RrbCO9Kr5JokNjnhoSgMSar1tCON0eFJO9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F+3ayQEkTfvOsiXGU59c4OJ7O9F2NLSA8tJ8Cf5OU0=;
 b=FTTlRfPxgpv61rL+p/nPZIPuIO4HlimEzSoBqQkYTrE4CSddq58KfoYk+S6HDs7mAxVniNdeu8iqu7yNAdT/IOhgWCWUdndpuUmLiZ0+Wb3mLcO7eE15SOeH+VYYO4NXYb24cM3T6q7LsO0S8/FXKOnDbSZb+O+j19n6FAgMQcysmRtW3jQD1ytxTlKmo+KM/IMvLuPMU6BW11eSfZK8qk0DT4GlBksAHui3Rg0uCIqw882P39/vrm9fyLc6mKYa5P3/rgDgnTU3Upqe3ma+ODxa7GaD8tqmJTLzuFm92OCKzenDO6ppbWV90dMjWnycEla9jZa+9Sz9kO4D/hCBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 14:27:02 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6ea8:4558:aa7c:3814]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6ea8:4558:aa7c:3814%8]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:27:02 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mei: add timeout to send
Thread-Topic: [PATCH v2] mei: add timeout to send
Thread-Index: AQHY+OODfSM6e9Ka6EqHJp2MXQDTC64//0YAgAAERNA=
Date:   Tue, 15 Nov 2022 14:27:02 +0000
Message-ID: <CY5PR11MB6366ED268D5D4EE194C6469EED049@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20221115111438.1639527-1-alexander.usyskin@intel.com>
 <Y3OX+uQ7PN5thWSU@kroah.com>
In-Reply-To: <Y3OX+uQ7PN5thWSU@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: c1a9231d-48b7-48bf-23ce-08dac7157697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pRtpQft59cEn5r0lg/nJBIwzVnCBj3Pr524fRiC6XCjHbMaLWJ8gwteP+tQ+OWzTl1q7x/qZ2PDU59mD6o4fqNHzvZzEiqlDDyx8f/8YhwQm3v3AU6k0hlmtnXm8axVNk0dLzu+zhAgvVtTGJ7tmmuxqO5C7OryIurJJm8M8kBwhzTHpL0hamHBjLhjeHu7VGjehRa+RUKXEZbx2EHYk2FV2o/PA2uuNTuXOICw19/qHdMW5MoAIKpB3Jznesx7FJpM0FkNOfgeq9gE57KGLQ6URGKVJkmDgknR7c82wXc0NDKXK5YCJ7tW2QMZzYbrirA27/UvI8q4+mTy6T+RPKlf9fpj3gshwf80pCWvBEtJJfCQ8SF1uPOS+ZDHUIS81YfZI2F0i8/l8PdRtLxO9c2lLCBaBVSl4772WpYiWB28diMj0MEloaOXXpVa3q0i0bOWUyTFTBEMxyaJS9TJsQSLvtNtDFfy/0nurM7WkkpU2d6ESYd3mp1vKnGr65Or2IDZS9cZ3dGtuzD08jIAGvtErzUheuEOKinc7dxm1MwAySRy0n4PeK3zgp7+7AoXPMiH6ctzl72uNeXPVxvEDw2OzFd11OiZLu8jLP2/Iu5JBSG8FBdJ38wcZWO9brChRe7XW+yZZkDfp5QGABmGH6Dp/tJkSEWAjUS79u8ZcFCkE36ujqimVGUp7mf3Y0rMeu5FmR6K+ck5JkwIz+Bs+uzz7YfokimMrrtbkbtB8MxOo0Cr3oisklEzvEsbu1Ecv2oTLuFemdLgUnyJnNwP4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(26005)(66556008)(66476007)(66946007)(66446008)(9686003)(64756008)(316002)(6916009)(76116006)(8676002)(52536014)(8936002)(5660300002)(186003)(4326008)(41300700001)(7696005)(54906003)(6506007)(83380400001)(2906002)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(55016003)(122000001)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?as1fFVfzaUxzXRyQF2sPXs/WidrHbQV8ZwaulwcgdLMFiP7cSDfsTCSTnK+C?=
 =?us-ascii?Q?v4P7vgNsVACAuOOJBUBTlKTQt8pM+L7O9rJCznSh1pHv8Ig4Qvbl7m5e6tmj?=
 =?us-ascii?Q?KpxdA8/uZ3rwF/vubPjsw4KJ0zcmHa+qRxkbUFoLl/p5BJcxwpVtn6VHBObm?=
 =?us-ascii?Q?ri/f1yozwUA63q7lc/Jq/+U+rVk8as43/HYqLrkJcykQ6idNjOIdApW39O09?=
 =?us-ascii?Q?gB5PJusu1zuX6drAiWcxtRMaRWivgI17QW41y2pEcbbrpcueA+MSMVI8lums?=
 =?us-ascii?Q?5MDRqpuankioClJxepjWA8CuQfN9z/a2ue0vmIDvijMwgJmFZJMFXg46u4aB?=
 =?us-ascii?Q?wGAxwSrY0bNjy1UHKxn5562Gr44zTIWQQNwPVC/4K2scvXjfmHxdzTwsVufb?=
 =?us-ascii?Q?zheLXaVstST4W/4/ahLup/LPvPoSv6yPRSKPS4EbOw0czc5HVBQwdMhYglP3?=
 =?us-ascii?Q?nIbl7Xlw0tt2Sa8UgBbQUJRhfatmUM/C6oDXbquHZUGBqXRfyb98gMobxzpF?=
 =?us-ascii?Q?zgxjYM02836x2tQb6ib6hHALHWGHdCXgZ9/r0VtAzTFSbKNvOCb6Me4Bagut?=
 =?us-ascii?Q?7P1pyljS9DItb1YDT55dgVxOp6+sTJu+HFK3cjMpBazKv0KxVHY1LWKwYkN2?=
 =?us-ascii?Q?CPz1z3eIp2n8ItD7+f55AJdu8wIHb0Sc0SBbXq+Jj9whY7VItJRNoRcKrsYt?=
 =?us-ascii?Q?23wzhsShdEUvEj2LVLKlYrnu+1b0bW0BANFsSr0kb+prBpRWjw4EkFoAEKf0?=
 =?us-ascii?Q?amoDQeL02ZL+COcFbauxPu0+/nDr3TPX/xoWxRHqmU6EeoNg1XFIIDIsez/B?=
 =?us-ascii?Q?bL3pCFtXwRGr+4wmX8+rKQ6r9bKRlWps/xTxpbqcaJUPrzcGNbd8cfdIMOix?=
 =?us-ascii?Q?WZXhjBvtXgxw0SzrNeEyC5XsTFJ8318T+2FCHlpSajdaDnjHk5UCPaWw6PME?=
 =?us-ascii?Q?d8pOeBNL2PakhpKtc2CkzDexIBV3WWAld9SEjFVBtHiONn0DnymfeLC1u0EX?=
 =?us-ascii?Q?B40hdvdr/nLc5yThNcjWkPDfVscqe5+15Xgxv+PtubpKaXjcrnLuzZ3yqcSf?=
 =?us-ascii?Q?aC5xwzN+1tvkjxjJPup0AwJDOLbHhfGJs1NfoUhw9R4oik/IXagmNMeGCwvy?=
 =?us-ascii?Q?xMfz/maUN6oFQ+d2yMo0FeaR8RgsyAy0EBXvSjjK50TSBgyBJiNzfclo6Zfy?=
 =?us-ascii?Q?gYVR+d77AR8gUehVrTZqvH9BowL+ieWzFitYiYxNmnSKJwyOkb0MLzT8JmQB?=
 =?us-ascii?Q?5ye3QVRzaWi8BrG7HzxVTzeBL4ehRiWeFr+QxrG7hHOXJYL0WYxuCdQTVpzP?=
 =?us-ascii?Q?dBhf5h2cqrWoYsuz/XRRkcZVQH0Zsx9S9g3/7iAbYQ3KuLkmQEHnA6XlxOJh?=
 =?us-ascii?Q?0/dt9xnUc83bUQT9lf1yV//QP7d0XGIGD9KMdjxxEPDD+LpQ9mVqdB72aiZg?=
 =?us-ascii?Q?Uj2HM6bLnhyMwly1qvO11wsAG32EaaX8oo5C7seS0+MMiQr3fJIXQAq/zTPv?=
 =?us-ascii?Q?EQHCYH6s2ukBrBeh9OCLCiwegEbil3+ToYt+bJT3mCZPG6tDkLPYk5Gk3vWF?=
 =?us-ascii?Q?Hc/Ag5qidgIxBSLAte2vx1yoALQbL2er96BeHJ07bXyyV/aUYt2EyG0G9sRU?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9231d-48b7-48bf-23ce-08dac7157697
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:27:02.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Li8LeThXqJSvyKxU/Ny0o3zMPGyPcbFYLVZumnY9HpXCRIhhFmD2EJmwErYQCqpQ3pUIoUoPtBwxVRXcstlDklVdspDpP4b0BhJe7Kpcdyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > When driver wakes up the firmware from the low power state, it is sendi=
ng
> > a memory ready message.
> > The send is done via synchronous/blocking function to ensure that
> firmware
> > is in ready state. However, in case of firmware undergoing reset send
> > might be block forever.
> > To address this issue a timeout is added to blocking write command on
> > the internal bus.
>=20
> Odd formatting of the text :(

Odd =3D=3D not balanced? Will try to do better in V3
>=20
> >
> > Introduce the __mei_cl_send_timeout function to use instead of
> > __mei_cl_send in cases where timeout is required.
> > The mei_cl_write has only two callers and there is no need to split
> > it into two functions.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > ---
> > V2: address review comments:
> >  - split __mei_cl_send and __mei_cl_send_timeout
> >  - add units to timeout KDoc
> >  - use MAX_SCHEDULE_TIMEOUT to squash wait to one macro
> >
> >  drivers/misc/mei/bus-fixup.c | 14 +++++++++-----
> >  drivers/misc/mei/bus.c       | 22 ++++++++++++++++++++--
> >  drivers/misc/mei/client.c    | 18 ++++++++++++++----
> >  drivers/misc/mei/client.h    |  2 +-
> >  drivers/misc/mei/main.c      |  2 +-
> >  drivers/misc/mei/mei_dev.h   |  2 ++
> >  6 files changed, 47 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.=
c
> > index 71fbf0bc8453..9959b8e8e91d 100644
> > --- a/drivers/misc/mei/bus-fixup.c
> > +++ b/drivers/misc/mei/bus-fixup.c
> > @@ -188,17 +188,20 @@ static int mei_fwver(struct mei_cl_device *cldev)
> >  	return ret;
> >  }
> >
> > +#define GFX_MEMORY_READY_TIMEOUT 200
>=20
> units?

Will add here too, sure.

>=20
> > +
> >  static int mei_gfx_memory_ready(struct mei_cl_device *cldev)
> >  {
> >  	struct mkhi_gfx_mem_ready req =3D {0};
> > -	unsigned int mode =3D MEI_CL_IO_TX_INTERNAL;
> > +	unsigned int mode =3D MEI_CL_IO_TX_INTERNAL |
> MEI_CL_IO_TX_BLOCKING;
> >
> >  	req.hdr.group_id =3D MKHI_GROUP_ID_GFX;
> >  	req.hdr.command =3D MKHI_GFX_MEMORY_READY_CMD_REQ;
> >  	req.flags =3D MKHI_GFX_MEM_READY_PXP_ALLOWED;
> >
> >  	dev_dbg(&cldev->dev, "Sending memory ready command\n");
> > -	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode);
> > +	return __mei_cl_send_timeout(cldev->cl, (u8 *)&req, sizeof(req), 0,
> > +				     mode, GFX_MEMORY_READY_TIMEOUT);
> >  }
> >
> >  static void mei_mkhi_fix(struct mei_cl_device *cldev)
> > @@ -263,12 +266,13 @@ static void mei_gsc_mkhi_fix_ver(struct
> mei_cl_device *cldev)
> >
> >  	if (cldev->bus->pxp_mode =3D=3D MEI_DEV_PXP_INIT) {
> >  		ret =3D mei_gfx_memory_ready(cldev);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> >  			dev_err(&cldev->dev, "memory ready command
> failed %d\n", ret);
> > -		else
> > +		} else {
> >  			dev_dbg(&cldev->dev, "memory ready command
> sent\n");
> > +			cldev->bus->pxp_mode =3D MEI_DEV_PXP_SETUP;
>=20
> What does the mode change have to do with a timeout?
With timeout the mei_gfx_memory_ready may now fail gracefully
and we should not move state if message is not sent.

Should I split this fix into another patch or document in this one?

>=20
> > +		}
> >  		/* we go to reset after that */
> > -		cldev->bus->pxp_mode =3D MEI_DEV_PXP_SETUP;
> >  		goto out;
> >  	}
> >
> > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
> > index 1fbe127ff633..63043e8df980 100644
> > --- a/drivers/misc/mei/bus.c
> > +++ b/drivers/misc/mei/bus.c
> > @@ -32,8 +32,26 @@
> >   *
> >   * Return: written size bytes or < 0 on error
> >   */
> > -ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length,=
 u8
> vtag,
> > +inline ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t
> length, u8 vtag,
> >  		      unsigned int mode)
>=20
> Why inline?  The compiler is smart enough.
Will drop

>=20
> > +{
> > +	return __mei_cl_send_timeout(cl, buf, length, vtag, mode,
> MAX_SCHEDULE_TIMEOUT);
>=20
> So this will block for how long?  Please document this.
>=20
> > +}
> > +
> > +/**
> > + * __mei_cl_send_timeout - internal client send (write)
> > + *
> > + * @cl: host client
> > + * @buf: buffer to send
> > + * @length: buffer length
> > + * @vtag: virtual tag
> > + * @mode: sending mode
> > + * @timeout: send timeout in milliseconds for blocking writes
>=20
> What do you mean "for blocking writes"?

The timeout has no effect for non-blocking writes (bit in mode parameter),
as they are returning immediately and are not waiting at all.

>=20
> And what do you use here to wait "for forever"?

The MAX_SCHEDULE_TIMEOUT indicates 'forever' - will add it in KDoc
This is implementation of Rodrigo's suggestion to use only wait with timeou=
t but with
maximum one if 'forever' is required.

>=20
> > + *
> > + * Return: written size bytes or < 0 on error
> > + */
> > +ssize_t __mei_cl_send_timeout(struct mei_cl *cl, const u8 *buf, size_t
> length, u8 vtag,
> > +			      unsigned int mode, unsigned long timeout)
> >  {
> >  	struct mei_device *bus;
> >  	struct mei_cl_cb *cb;
> > @@ -108,7 +126,7 @@ ssize_t __mei_cl_send(struct mei_cl *cl, const u8
> *buf, size_t length, u8 vtag,
> >  		cb->buf.size =3D 0;
> >  	}
> >
> > -	rets =3D mei_cl_write(cl, cb);
> > +	rets =3D mei_cl_write(cl, cb, timeout);
> >
> >  	if (mode & MEI_CL_IO_SGL && rets =3D=3D 0)
> >  		rets =3D length;
> > diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> > index 6c8b71ae32c8..02c278202ad7 100644
> > --- a/drivers/misc/mei/client.c
> > +++ b/drivers/misc/mei/client.c
> > @@ -1954,10 +1954,11 @@ int mei_cl_irq_write(struct mei_cl *cl, struct
> mei_cl_cb *cb,
> >   *
> >   * @cl: host client
> >   * @cb: write callback with filled data
> > + * @timeout: send timeout in milliseconds for blocking writes
>=20
> Again, what is the max, and what do you mean "for blocking writes"?
>=20
> >   *
> >   * Return: number of bytes sent on success, <0 on failure.
> >   */
> > -ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
> > +ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned
> long timeout)
>=20
> Why not have mei_cl_write() and mei_cl_write_timeout() like you do for
> "send"?

There are only two callers for mei_cl_write now, one with timeout and anoth=
er without.
Don't think that we need wrapper that has one caller, and no additions are =
planned.

The __mei_cl_write_timeout may be called by more than one user.
This patch converts one caller, but it is open for other callers in future.

>=20
> >  {
> >  	struct mei_device *dev;
> >  	struct mei_msg_data *buf;
> > @@ -2081,11 +2082,20 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct
> mei_cl_cb *cb)
> >  	if (blocking && cl->writing_state !=3D MEI_WRITE_COMPLETE) {
> >
> >  		mutex_unlock(&dev->device_lock);
> > -		rets =3D wait_event_interruptible(cl->tx_wait,
> > -				cl->writing_state =3D=3D MEI_WRITE_COMPLETE
> ||
> > -				(!mei_cl_is_connected(cl)));
> > +		rets =3D wait_event_interruptible_timeout(cl->tx_wait,
> > +							cl->writing_state =3D=3D
> MEI_WRITE_COMPLETE ||
> > +
> 	(!mei_cl_is_connected(cl)),
> > +
> 	msecs_to_jiffies(timeout));
> >  		mutex_lock(&dev->device_lock);
> > +		/* clean all queue on timeout as something fatal happened
> */
> > +		if (rets =3D=3D 0) {
> > +			rets =3D -ETIME;
> > +			mei_io_tx_list_free_cl(&dev->write_list, cl, NULL);
> > +			mei_io_tx_list_free_cl(&dev->write_waiting_list, cl,
> NULL);
> > +		}
> >  		/* wait_event_interruptible returns -ERESTARTSYS */
> > +		if (rets > 0)
> > +			rets =3D 0;
> >  		if (rets) {
> >  			if (signal_pending(current))
> >  				rets =3D -EINTR;
> > diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
> > index 418056fb1489..9052860bcfe0 100644
> > --- a/drivers/misc/mei/client.h
> > +++ b/drivers/misc/mei/client.h
> > @@ -246,7 +246,7 @@ int mei_cl_connect(struct mei_cl *cl, struct
> mei_me_client *me_cl,
> >  int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
> >  		       struct list_head *cmpl_list);
> >  int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct f=
ile *fp);
> > -ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb);
> > +ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned
> long timeout);
> >  int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
> >  		     struct list_head *cmpl_list);
> >
> > diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> > index 930887e7e38d..632d4ae21e46 100644
> > --- a/drivers/misc/mei/main.c
> > +++ b/drivers/misc/mei/main.c
> > @@ -383,7 +383,7 @@ static ssize_t mei_write(struct file *file, const c=
har
> __user *ubuf,
> >  		goto out;
> >  	}
> >
> > -	rets =3D mei_cl_write(cl, cb);
> > +	rets =3D mei_cl_write(cl, cb, MAX_SCHEDULE_TIMEOUT);
>=20
> Why this specific value?

Very big one, rouge equivalent for 'forever'

>=20
> thanks,
>=20
> greg k-h

--=20
Thanks,
Sasha


