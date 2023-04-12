Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6A6DEB80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDLGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:03:54 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E3F7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq4FrmaegyyjfkEdzYxwlHouFIejXJKw5pUkWK1duAa8YlHkNkpHsXdTsTpvo9CqWGB7AvJJEOCdpDvkB4cfmP6wqpfOn/WtGsNpJB0nkQLiJ7Yb1Rz0dua44iNEZcuNo/pJ7Y6qJu1G5rZZhCgVn6WaV2o5tRoqleMrid4wOByNFKMm+v9Tc5uqjLolbZxqVGc6hkYAn5HAbe7YMbJ+YZ8M6hlfJnGj3HVazEMxpYq2Oa9S47UjfGqStWenltFkm76s0ubAhExg5T2xLaI5Oq5Mpcq36646mh9UNalS1GcR8M7uWoUnG4c5SEm06vc5wReEIxdbbm1BjOxmXWo06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdDVX5wgMsJwOp7AOjUDbTABhWXKxHOmzBhN0i/OU1E=;
 b=ofg2FVHZx3k/fnJaY7qerzf6aZzsMWtLYFon23LC+VGeAO6xMTVvyDiflomK5p9jR1gAJvYFxjpBc2ZbSeWx/auuyJ+ToW+7O+MFqw8+8Gk9jJ/lDqClUP47cooKXApBJqws3aQ64JcWRy+vuxZDtsshdOLSmzhljmmCTt61W4B9fvzxBhzZnSbEGcPyPm0ECvxBIEXSaNUG0emEOImTly18ORNqKDCFcmFXbRrnekA0EKE+K8/IH6om7ZhbJGrtYfiyetjUqraQtKmPXa5NZgHZz2Qfx5dQ/P6FMYUeYaHJMXVKoW3reZ7ZzLOOxyX6fhHJS44I1sP3Nu4BKLAwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdDVX5wgMsJwOp7AOjUDbTABhWXKxHOmzBhN0i/OU1E=;
 b=LaB5yc+52VjrN/NVh5uBN+70jrBx3y8XH9QfSwI8wuXljOxCPg6qkXxE2eMwp2kkJ5JNW1Gpk5vakG6PNslyjtdBJ9h/tjb7+C9z9pLQrBB9m6Lb3KvU2Vf4P5B6w4KFhUn2EDoscec+bP4i5UtLXo0diocVnnPO1YesQHgFjbPS04drWC3FWHySUFElzIFnl7BveMceRAktWjUldEYVJbheOqrwadcqZMec0lFfID/ibU7/CfjnJoZJ4wJmWQk4N1SodOUpOnGe8S+3QEKgevz5sEvtytq3WY+QX9qWzWeX5d0IC4IX6mCR0Dskufl6QGZmWmWc2rR6mOhTs5a3Hw==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PAVPR10MB6814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.25; Wed, 12 Apr
 2023 06:03:48 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7235:3b3e:b256:f116]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7235:3b3e:b256:f116%4]) with mapi id 15.20.6298.027; Wed, 12 Apr 2023
 06:03:48 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>
Subject: RE: [PATCH 1/1] n_gsm: Use array_index_nospec() with index that comes
 from userspace
Thread-Topic: [PATCH 1/1] n_gsm: Use array_index_nospec() with index that
 comes from userspace
Thread-Index: AQHZbJVZiiysqBkbzE+VAcmCypb2IK8nL+ug
Date:   Wed, 12 Apr 2023 06:03:48 +0000
Message-ID: <DB9PR10MB588179D96A0DB239603F7FAEE09B9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230411164532.64175-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230411164532.64175-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-12T06:03:46Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=94fdc0e1-69e3-49e7-bc39-485eecdddef1;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PAVPR10MB6814:EE_
x-ms-office365-filtering-correlation-id: 127eb378-a61c-47e6-fc30-08db3b1bae7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IulJD+Ax/2uqUmkVfyCpWE+9a4WN/4n5srqvjee95Kt7xTXz1pwZQg6PRvdevdQOXGsDY3kt/VPYuwRXkCx0BJ5CluGJdgyUDLBoa3m6+2nXGLZbhConxz6XgbbuTIqtSIBY+ueut8HQGUrcNH93YGporVNuJ2RrDNiELyCfWK5lxyAdcwrtKBaPaIWy0jBY5Q2mi4+4K5kNYXGDzpMLGbJY1UaiKArE3faE9CDwg0t39kpjUT6piy81UKmvwQ+AX+a8cSwYX8CdBNs25aP/aHqHtL/kn7RAnXmsWnfJeLhSqHb1J00cSvsitFmvnRFI6nN8JGisTPb43MduLj4x+0QTcxwD+8xhjHAqaNOuwZ9nj3yTmvxYL44sKOn3UkbQNZliY8Apq9GS9mC8Q64isbYWfdHzXCNNMtr/JXC4qDxLkRzuOU5XYF8yiKWC/wmTt0QOqtdUCAX5B2A/acjQLcuupOk6Uh5UfyW+FMX9XKq9rtYPqoULz4qaRGUfHUh2eaFEnRFjSonep1Ckt8FkCLqvlTwQ1lPY+UcUWhbR4/mFtvxMfv2UG/fLxYJkyDbfxBvnMY7VuTDvi2ReiXqAJxSB38PhPyRAF0gjCVSEPwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(66556008)(71200400001)(8676002)(38100700002)(8936002)(316002)(82960400001)(41300700001)(76116006)(55016003)(66946007)(66446008)(66476007)(4326008)(64756008)(478600001)(110136005)(122000001)(33656002)(186003)(2906002)(9686003)(26005)(6506007)(83380400001)(38070700005)(52536014)(5660300002)(966005)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x1lqprr9G27E+4Jda0FeSw4IRpATgGv8ns6AliYFzfUXeN/08cFqRX7ukK?=
 =?iso-8859-1?Q?DLwXF3+Sx2nAFVRBLVmdHoIy5JJzOulLj9LfCNl2E25uCT8PAOC8YeRmoc?=
 =?iso-8859-1?Q?qm/vTEp3659Q7zpn4F5s5sWdzhKSTMO074LSJ44rmZ1VjgXCOmclMY4lTz?=
 =?iso-8859-1?Q?EExTbC1kxS+jttV1gZQndPPl63HXag7Ml41qWMEQOhfMFy+7z7n9h9OWPr?=
 =?iso-8859-1?Q?FoTAYtFwL1IJj68h28GRiLLTori9mRONuUjnAvQnesNZDFSz9OesWVeGNK?=
 =?iso-8859-1?Q?ixaXc6vMULB4C15Wd6CYB+e9khvumf/mlevGWgVnjFgR3RhJKWeBT6XMTZ?=
 =?iso-8859-1?Q?h66KmtEErVBuZQn65JAwGqRG44+qwjvSZTlBFYdP2fwuBVsDYH6kC9vQbj?=
 =?iso-8859-1?Q?OEZtKApMTvFjTrUO0hvIOPm3d22KxCeYTgGUCkY+QFeUzA2Vs5Z3FRs5xC?=
 =?iso-8859-1?Q?F2BDUk7arfqZ2L3hE5AZKKKHVbPOzLKffz//hogmzqYZ/vkvP0cuR24Mxe?=
 =?iso-8859-1?Q?8WXPg5eYEYqvyWnqmbuCGSJXbSQjPdVDmf9T95t71p/Me85RrtJb+afIfh?=
 =?iso-8859-1?Q?yhvxYX499dm7T3Jx8cndDcRYTiokLKcRjNoeqBvTtOZ1P7ii4vpU4LQ6b0?=
 =?iso-8859-1?Q?iBYXKyfvZICEEdzf9RmaxPTdDGaYyyAt6l2Urq6LU1LbCnRtET8FjIUfoO?=
 =?iso-8859-1?Q?h+IDKMMrzizwobXxSgr7B/awqhVLuS2zy+dnMns6elihv0YW42QiwIND1D?=
 =?iso-8859-1?Q?DfyzNWbRZ20nGgs3Y8P9pO0iUFLrs8qVrM/Pq/cC8OT+U9JjDOM+J9tpzL?=
 =?iso-8859-1?Q?KtQNcLLGqx2+qqSzuniVWkc5W2grdtRejnEIj/eaDiLSwv3zoBM1UN3oVF?=
 =?iso-8859-1?Q?mxGTskbEPH4eM0Sgzu9fyMJUF/NFHRH4VglNZq647NyF/IXuLX3x7k5fyy?=
 =?iso-8859-1?Q?v/eRFtHFb3sBdO8HczPAZ/QHZbWHe0AKIQtJlMfa69x7cR1/IZ/t+9NjbD?=
 =?iso-8859-1?Q?PlKrtScqT0qn2WJvTO68kR4TzOEy98GCyC10bDgCNLZ7QhGVTP+YNBNeIH?=
 =?iso-8859-1?Q?V7r5BGuPvycAY0csxv410PmSMofrCnw69cZxTJgBksZeP24NJO3Uf//cND?=
 =?iso-8859-1?Q?XQRpstYgLddpyGPgtLxlZ1QMDChxVaWFqMOQY8Jn2HGndu+IXAdo3HHUr8?=
 =?iso-8859-1?Q?h3eoY60WwIXvLtWmoWaWnOK9UAO6Ly8jRNy9OZhnVqtxlfHy5e59E9Q1s/?=
 =?iso-8859-1?Q?rKKx+3f03ZRPQJ01fa7R4A2EMggaUhNvOYZyW936odZDaqWVyZOxUE9Jlq?=
 =?iso-8859-1?Q?lDhEgeRGnGGwT58o1hqMhgpQpPJe3Mi6xqMAOJ7XoTJz1wAp9s8uXZSUpn?=
 =?iso-8859-1?Q?GznqKOcJhTM4iLqnU8Us+slc4IOfeQDVHtvIOmGAEfGzpUNf/2VOEq7aV9?=
 =?iso-8859-1?Q?ZsThd5dB57p2N5Yzo4RXhJ9Czkj/jFBzOgWSLPJD3lu8bi/Vr7fNIYxsog?=
 =?iso-8859-1?Q?diS8lTQ76tqlbUiXWYDMoKGPdEeL65Vxp95Ex2+yLEK70rcCM96Rx63Ya/?=
 =?iso-8859-1?Q?TDGjqKyHLdkdyciYopmt8z98yJS1dU6b5CrWMYGejlhHATtKczOGTdn3d0?=
 =?iso-8859-1?Q?g7R/x/2y4Hp1sHYTmw4pD/gIfPXfOp46wt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 127eb378-a61c-47e6-fc30-08db3b1bae7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 06:03:48.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiQDG1jYXwqLEeYsv7P5kMQ5GFNrNmERq22Y3MBoQwCTW0zI74ekWHEiJnctws1RLXfGt1dMZyoZpLM81lC2nzjsb9icILbBI198efNV49U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> dc.channel used for indexing comes directly from copy_from_user(). Use
> array_index_nospec() to mitigate speculative side-channel.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-serial/64306d13.ONswMlyWlVKLGkKR%25lk=
p@intel.com/
> Fixes: afe3154ba87e ("tty: n_gsm: add ioctl for DLC config via ldisc hand=
le")
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/n_gsm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index b7e1369a035c..21985432794f 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -42,6 +42,7 @@
>  #include <linux/ctype.h>
>  #include <linux/mm.h>
>  #include <linux/math.h>
> +#include <linux/nospec.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/poll.h>
> @@ -3718,8 +3719,8 @@ static int gsmld_ioctl(struct tty_struct *tty, unsi=
gned int cmd,
>  	struct gsm_config_ext ce;
>  	struct gsm_dlci_config dc;
>  	struct gsm_mux *gsm =3D tty->disc_data;
> +	unsigned int base, addr;
>  	struct gsm_dlci *dlci;
> -	unsigned int base;
> =20
>  	switch (cmd) {
>  	case GSMIOC_GETCONF:
> @@ -3748,9 +3749,10 @@ static int gsmld_ioctl(struct tty_struct *tty, uns=
igned int cmd,
>  			return -EFAULT;
>  		if (dc.channel =3D=3D 0 || dc.channel >=3D NUM_DLCI)
>  			return -EINVAL;
> -		dlci =3D gsm->dlci[dc.channel];
> +		addr =3D array_index_nospec(dc.channel, NUM_DLCI);
> +		dlci =3D gsm->dlci[addr];
>  		if (!dlci) {
> -			dlci =3D gsm_dlci_alloc(gsm, dc.channel);
> +			dlci =3D gsm_dlci_alloc(gsm, addr);
>  			if (!dlci)
>  				return -ENOMEM;
>  		}
> @@ -3763,9 +3765,10 @@ static int gsmld_ioctl(struct tty_struct *tty, uns=
igned int cmd,
>  			return -EFAULT;
>  		if (dc.channel =3D=3D 0 || dc.channel >=3D NUM_DLCI)
>  			return -EINVAL;
> -		dlci =3D gsm->dlci[dc.channel];
> +		addr =3D array_index_nospec(dc.channel, NUM_DLCI);
> +		dlci =3D gsm->dlci[addr];
>  		if (!dlci) {
> -			dlci =3D gsm_dlci_alloc(gsm, dc.channel);
> +			dlci =3D gsm_dlci_alloc(gsm, addr);
>  			if (!dlci)
>  				return -ENOMEM;
>  		}

Reviewed-by: Daniel Starke <daniel.starke@siemens.com>
