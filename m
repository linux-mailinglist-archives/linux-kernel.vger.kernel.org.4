Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D168B5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBFGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBFGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:40:55 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885918B14;
        Sun,  5 Feb 2023 22:40:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBxWPsXPGpUNDJS3z5QahiCRmYb2o/miw6rbX8bNpP5Jz6/9Nd8rSd3OD8C7FdbXzzalVBfn2saQ+DHj1GXbfgXdqvfmsiD+6jx5FlNuQguLX0WAeXXrKgnvhCjD4IDm6YyuLg40LepM2h5CFhLdqHSdPmfMAPOsRX7iS/EUefLl8jC4E77Wqjf6be4puD3p9sO9T7V7kynLAkg9SgnRmxx9S3OL7tysqUpriWMWTTMWk4+doZn+6N+w8cKStpF2z5oF/GvztUjQI4KAm7yUAXpt9xPUYqg009Gp5LdyRsFTtMzxIhZuMzaC1O6aikZiaZ3DbE6vvobduiuR/iz0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqJ2hJLOPneSHoPSaQVED16zR71RyK4r6WnEcrIzCa8=;
 b=ew1IQv+uA+b0JwQBLLJkX8THYi3mwuYkZqaJ2CBpVvyKUtywWSHf8Gs53mYrgvYLlK7Hgve1/2NWUb+Yjp5xyDavrrsVkQVc0SVI4UCYwozF2uViRJHDBXmezyZEilGRyvCmGw80twm+4uigYhUJzyS/BqmTp8Iuvl7GtKDWgYPpJYIlvXcwZGaHQasb0TMnUI0JLkJk14pGcfkPvez6Ac8L+3G7IIujPBxTWH71P8S91y/eP79ykwVuxmidi6jRo08VtAjCUlUbv5VHzhhUPl2+e8Bsd65Jw1fqfOTrtnPsERyQQq9noOKHsqpDFY4iMlHzEKaGMUDzB3Ll7GzCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqJ2hJLOPneSHoPSaQVED16zR71RyK4r6WnEcrIzCa8=;
 b=oY4dYpAHi6ur4FGyuX4KHRNRjt18HuWEOsRnfP0ajHL44ZzMA8jYAPBpMkRvZQBtS2iq9LxElZh/qj5Ko8Ow2ET5pyi+I+JhIRQFT0n3Ptqi0hCIU/a7XXw+A352OiDvsTY8z/HwKxYfq1x5A/8Z+V9SVmxwjx9jb73AVdTrQ3EmQzBKJTsI7XCOHaAiPkCuRLSro8NxkGk3/tUqO1Zf6lB9SxkW+iYTNwNdTh9mpaaXvrUwXJHqRa5dVQ7NVtcOKVdr0uA2oy4pOGZiyBmYUdezB87JL1mxUQHQ+iV+vcrOVuIvpsuIoz/xcc2uwkC6aKOJ2PGS9ihDW3uS4R9y2g==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DU0PR10MB6825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 06:40:51 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:40:51 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH v3 2/4] tty: n_gsm: add keep alive support
Thread-Index: AQHZN/BZXHwi/lQ56UCRVZUPmitX+67BfAfA
Date:   Mon, 6 Feb 2023 06:40:51 +0000
Message-ID: <DB9PR10MB5881B173B65CF0895A185B22E0DA9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230203145023.6012-1-daniel.starke@siemens.com>
 <20230203145023.6012-2-daniel.starke@siemens.com>
 <Y908hEeZdDw/0Wkp@kroah.com>
In-Reply-To: <Y908hEeZdDw/0Wkp@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-06T06:40:50Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=e4373299-5756-4be6-8a03-ed08673cf55d;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DU0PR10MB6825:EE_
x-ms-office365-filtering-correlation-id: 16ed5453-375c-42c2-ceb5-08db080d16ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gy6zkVcYAUmgfYjLuPN/xiOHVgLzfvkYQQ9GyjZ6lAS+QEGxZsc6FwI9fhFhOP3cMEcGW9zjFv0JzhygFKaWie+Hg8kHN3pFb7a6VSfT2haIcGY2IhqiZpH6Vi6dfvP/5/nL6Z/EDzbU1V3maJMvCefD53dX3GS+OcJw2auOb0AkD6M/AZKa2Yb2f2Qr/Siyblr7JqCd+1qawMDnA1/FxF/8LbwD15I9rWnfA7UGCo9ZyqDjowQGIZJ/35u0fdayVBRpWiSO6q1JMXKmiE2YGdN2LKQmd4iblsLxyWqAwzMqkulMBTMdAvMPcfHgCRsMIK4HLYpletI1Xf1/1yw+2EPqcUy5VJqC7tweKPwR2ZVqzmfbG0JDG9tiO/1kdBeG/c9p6ZmQjgQuBxH8eVwOWWsoc3aGtV30XzbxhMoUZvmqOaKOJ4KGpeYsZ+F+2ZRg0jN6ff7H3qwK5fEhe/++KqxJVJn32woUY7HC6fvvFHrU1zT57FoDCcj8XmBDEtmQGx9UjqIBsPTz2wN22B6yH++0wcHdTfJ8miRrfyNst5NXHho/EULult6ko5qPCVlvbwpla7GVkIphbBAoS9+BtZ/ugdA3/CnMGzY4taivnEes8hL5Up/F2Rhni2ntGKNlINQk9YfC5PWAnJvmO5rDVfhVX5gK2sboThrHb+gXMBz6gwV2YjIhFCPBhmJklNqwNDfRZ0ifzldY3BMAP/XKlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(83380400001)(38100700002)(33656002)(122000001)(7696005)(38070700005)(82960400001)(55016003)(26005)(9686003)(86362001)(186003)(41300700001)(6506007)(316002)(54906003)(4326008)(66476007)(66946007)(4744005)(8936002)(52536014)(71200400001)(6916009)(66556008)(64756008)(66446008)(8676002)(2906002)(478600001)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?522d4tFxHVsJsuz3lyqbNDOaz8fX+kO912V/kgygwcEy0kcp+rUZcN6lKQlz?=
 =?us-ascii?Q?YlTNw4/mm3iIS78JeiJKYq0OgVlQ1WuXb19iYmt7iWby771Q1IBbKcJOYCtg?=
 =?us-ascii?Q?r6j1Nva2DxT2vwCg/y56tBALP0PzoPYXKH1/1l590bc03Eksk+pL0uNqwfmv?=
 =?us-ascii?Q?75uhi1bmNG59XT9ExpqyUFgMmSETADfaXG/FG6SLXCZm6qfJLpUHDE9l8vyd?=
 =?us-ascii?Q?GvFnuA6TqN92I/BorjPUwCd/X35SK5MTgLQ/GhQKrgxHuyMVEiogvvJj1vNZ?=
 =?us-ascii?Q?6mP2w2Q2p7cKYY82W1nFJcF/D8kck9g+tA5ezEVsk93n9mVEHZMDv9InLaZI?=
 =?us-ascii?Q?f+fthKhBG096fHTcn3Wdk5FAA33GwzDXxkq63CS4uiLS0SzkG9/pUEp+fXlJ?=
 =?us-ascii?Q?1IIU2aGegs5QnZA5vCQsGbDC19x7OMQH2LK0j27286OusRQKif9/Ansf8oIS?=
 =?us-ascii?Q?bugFi8viJrit39Ew0ttv+Aer1PBhTmdDX6KvuIs5TUaHQFJf9XXebwSnqJdR?=
 =?us-ascii?Q?8K7Amujq+e/+sGL6Jafwgbxk+xsIoVnXPP5cGROKumRFEqWmPR2VMe/FZq+Z?=
 =?us-ascii?Q?RPsFY2TrjYgnS6H2tUtZEzmNScIYASK3Fvvw7jL4TKlwOeyEcSlPhzWCtW3U?=
 =?us-ascii?Q?ALDBXT3Lebal3XszlAWTWOqZwiYWL8xRWQqAKZu5jmL5Qx2d9VQ+WuphcF1w?=
 =?us-ascii?Q?/f4FuUT1e11KxpfmCOls8WN02ERLrUU65SvYfqnhz4pVo+CE2Ji3r/5Fsy/0?=
 =?us-ascii?Q?bxknuVqNIvlmTvyt4uO5MTPO92Au/ZI9YngxEkWm/MtWMf+U7oOH72IOPL3m?=
 =?us-ascii?Q?bm0QdzcgKLB0JAfkdOCbLTnwBPRMja90dhBLdkQcCQbXj9esHFjjvfMT8/jY?=
 =?us-ascii?Q?CMANH/z1Jd99mibK8m0U8QBN0iOgLpjXbwk+MGT87sKa6LDt1s4KtGcjBh4v?=
 =?us-ascii?Q?bn0Rn/Xz9vFJyOM62mukBvmVYojRGJX//VauqY5RcI0GfLl+CJxt+YKrr18a?=
 =?us-ascii?Q?7rrN3Ixt0Wsy1FMvIp66pwWzm8wL/iV25OyoEZvT6iA4cIdFJv1AWHJEmqMR?=
 =?us-ascii?Q?IpV4U5Oku7NMxAt2QBvzXDDgwtI6myCRc59AKPUay9SFmSvTZSnkS6pI6PIJ?=
 =?us-ascii?Q?F+v2go5OWsIa8g67yYZL5peeZ3yv2OqEg3EgLhC3Ltyeww7oLD6lqS4zIJlC?=
 =?us-ascii?Q?AiAoRCftmVSYnXSpMLkxaLvUxeoDLOP74KtF91AbmI1EUsbqE2/efmYMusYI?=
 =?us-ascii?Q?lsYwa7v1Z6lbIxC9OkwWpig1cJMC0S4NJ7gB9MeHP/oxgxqJCZvlQ4k1XpGC?=
 =?us-ascii?Q?SiHWDR3Gh/ysuYoDBW3VFavTyvUyo6ux1QqvRlawGIFMHSa+0o7p6+CSJc17?=
 =?us-ascii?Q?OFa4u9NW5XHKET3Ucc25OEPfiyKFTB+L4M5OVAuF/4KA/L08C4+TgjIkUbgh?=
 =?us-ascii?Q?vKrPOBUcDkLrxO/bggCqyD3OKEKeoQPoZ2IV9tFqGljdQMzrgf7SfKeYjI+o?=
 =?us-ascii?Q?XpA4B6/HQ3moUixOp4PpYGwpHPvYhCpppBJwnysOvsj0xsvxtZ5BPGQ1Caiw?=
 =?us-ascii?Q?8ySVOvTmBD7/GI0gT4L3551UftwKlJ2KNd4PcgMz2BJKZzRk8ZCO3S1lFfde?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ed5453-375c-42c2-ceb5-08db080d16ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 06:40:51.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9KwJtTuKdl3COFqsj7PDciJwo1T6KRVYS7srcO05Io6ZZKwWA5kmKekyO1rRYg3dU2wv8+CLPVObaSs0drS0eKZBZ/iyG6QelVpQh1bxW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6825
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +struct gsm_config_ext {
> > +	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
> > +				 * second (0 to disable)
> > +				 */
> > +	__u32 reserved[7];	/* For future use */
>=20
> You are not checking these fields, so this means any future use of them
> will not be allowed (like the problem you have which required this new
> structure.)
>=20
> Please, always verify that the values here are 0, and if not, error out
> with -EINVAL.  That's the only way you can properly reserve this for
> future use.  The kernel documentation about "how to write an ioctl"
> should describe all of this, right?

gsmld_ioctl() calls for GSMIOC_SETCONF_EXT the function gsm_config_ext()
which returns -EINVAL if any of the reserved fields is non-zero. Should
this also happen for GSMIOC_GETCONF_EXT?

Best regards,
Daniel Starke
