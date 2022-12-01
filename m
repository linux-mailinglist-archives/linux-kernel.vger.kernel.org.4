Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC12D63E70C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLABVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLABVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:21:14 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D690750;
        Wed, 30 Nov 2022 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669857672; x=1701393672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2nlDzxy6i1WrSAAFrzW7fDeRGMM5uB23etCroAmyBsQ=;
  b=S/xjA1NROMzLF981XyoDzbW71Z5+49q7X40JAAiz4uWaX22S/I1ulk6s
   XCioVBzvvLVIjN5VUMS4y1e2SebJKkV005uy1P3y9yGG9OM8tvkjPnvWF
   1Kp7ixtWqxuRWx0+SPkNG96Ex0L6w9aTcvU3JcGaUDKCbsnNky4+tlwce
   Bwzpu7nkgB3yksU4RPa+gN0VguhwksGko4VCVui7H/omMgtT5NtzxuR4/
   iLTlMv1NfToZ2iDwcZNZvJDPPv4vECtyPgFUBrRW0CjHvqxoo+DVWcuio
   BBpNNRP+k5K1YM9DRwYaFujX7Xn+OxZCEhkO0wbSTsxrgahS+OujIV2Vq
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665417600"; 
   d="scan'208";a="217890756"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2022 09:21:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nREuBn+y41CXhO/Hucsb+y7JsENjlslYgSSEQ1Nkb5+GQAaQjcKpf6wU3FSB3wxa2F+2qD0CHq9tPi3WrUljG9bYa3bi+I+CdjeKGrOOrdIi0ux7OZTTSfEpAysJ1EDNvVyO7xxzGDVa0FVOdIIr4apuqLeQztwwQiTtWcZ8Sq+7/mV2YCNwInrhZ8Zd075hf2rkyTw61j/NnopvWdzMZqi5zVNvON3wmrJ9cCfUYtPYXq8p7GquJulOvC71XC1v7iI31eDsax5IKV6RuDwKMFKp3mvGi2qWTSUx+8hHZL4n/eN4WmVEiHUMfVxusWW+3Uev4RJuBvZWksJ3F5bpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7lCrBaEh9fJIw5+xeQyQ+WFM4UkYLKyxg0dlGr71Jk=;
 b=Ace4HtCHWt2aylmjRTHke1EY593F2nehtRibanpXRcdIo0znomwncLLQYNTqa4CdYkDM/vXREzx/YYfvkBwnyRtWDszRSk/PwQt6btCKfG+z4fZda1Z8vHOohbqfz8EXWv3EPESItBrXd8yQnfwKYAFKdqMVie1AOjNGKFAQCktsZ1Re0+nWXaU7twTflHIrI8UaGmR/MiCMGI/lR6goFok8+P2RdNf9a8r6ajX9KNT+z+wcD3wqMvzTomsCdk/45I+q4UkWnBk9kNgzRsSRQLR4YA/hrHPcY9C1D+bJtx0SBeGPGifXZVpOtMInkz84DhBHJM8RRakbXBtijvJRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7lCrBaEh9fJIw5+xeQyQ+WFM4UkYLKyxg0dlGr71Jk=;
 b=Bmm0a6DsBMX3lbw2pk0mtjwFFUGjEXXPYKYM5vnKLyR5aePqMPAauqAD/BbNOwDSkb+kcAarkjxHl/N+J6Q8rf0JQPRtr1kdzrIBItZ3U9bzcGbkjUsHu/yRPIOIKLdHvf/why50am515zIX0GatFMAHShA0fBTwkin7OpbHQ0k=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0800.namprd04.prod.outlook.com (2603:10b6:300:f8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Thu, 1 Dec 2022 01:21:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 01:21:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Topic: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Index: AQHZBEpV3/vIPNnSTUWn9aHpK6AE0a5XGscAgAEDsACAAB9SAA==
Date:   Thu, 1 Dec 2022 01:21:08 +0000
Message-ID: <20221201012106.wrultudwilepwmnt@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-2-kch@nvidia.com>
 <20221130075932.nfbxiixykfpxrweh@shindev>
 <bebfa1a2-1bf6-b515-00fb-4a7be7eeeae5@nvidia.com>
In-Reply-To: <bebfa1a2-1bf6-b515-00fb-4a7be7eeeae5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MWHPR04MB0800:EE_
x-ms-office365-filtering-correlation-id: a2188d30-e323-41c9-0a26-08dad33a5365
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lR+fNRBhlLXXbDspYECIR3xUPM23tciMpOpbifSq/CAsPQ8MZCFLeGTet0+RO2kzdD1/AsTM07foizKsVibSOUqDY6pUS4nh8trOqN7LzydrIVtTe4QSZaUavHIFRkzgUmGnBlNqdYIvBCn6PxGlcmO4M+2dXdUUjSNe0V1PCm+36LL/ApuWSCQ+jGRWR4pfxCd9INlsPY30FCE3eWx0zjk2A8Wr62bdPHkI61FOtHrqe7CZb6HhzWISGwuEAUPFiBoQBFQC13lKgvBC85rPNb57/b3V3eVLfHU7+tOPbA3GKYh2Q7ILHO6nZXRTFwrFHR9KbU7DWVtCOLQuM8sFd9Z8Sb5CPodGrcFveEwFi8eFQbP4q9NJMQDYKTKhnKDr2Z8PLZ10iO6RqfKpBQrGNWeWc+EREVmMsAzfrZTaZja8NtBIYswyDyWlZVwgZQMeecq/Qt4wnVzqgNmJ2uMNVA5+Agp9zS3RE3vHunc6fAnTysMBErHBPQvSA3pPc+plR4ubiEeDxoJ6dihIIegg8hBVDZ+pf2yS8xcJXa6LE2YkQHkPLCEP7Z1F8Tr4YDg1aHXegoKI6u1ZL93Ei+B6cJXOqzWZKHNFeBIpBbVHHlghnuiG/JSIXYByFKjnUeLBqotof4feJXaMJXm6CJf5kPQySwlCLCp+MBcGCaNW8T99sVEtIRbSWNgQU8sD5rN2bh8homCMKk28L02zx22lEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(478600001)(5660300002)(186003)(6486002)(1076003)(8936002)(71200400001)(86362001)(9686003)(33716001)(38100700002)(2906002)(44832011)(6916009)(122000001)(41300700001)(76116006)(66446008)(4326008)(6506007)(66556008)(64756008)(82960400001)(66476007)(3716004)(54906003)(8676002)(66946007)(316002)(6512007)(26005)(38070700005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4oVKv4P8oz4bXkzOjrr0uCTIeUiAIHD9vnaBFi/HHt0MAfK0hLkeSJ+eI3fH?=
 =?us-ascii?Q?vn5UMoX/DGAGq+RYxU8miJy97lO2UtXPgHJPGJNgUsuj2FKPNcnZeTbczKnj?=
 =?us-ascii?Q?VPMqpBAlCZfwPu3pi1cRojsmvhcY84qtfQbdH17uwf2lRaQXwo1iVhhZSqbz?=
 =?us-ascii?Q?saYtcEOqvlPTQG/ZpawtRDkhYa4KStVIosNcxkZ2cUZ8M2h01yh9S3yWF5gO?=
 =?us-ascii?Q?UQ32ufrch3Z+oJg5Tcbk8vfvRjacVOsU2ictTf5aSTHljIv926zxa6MgcCDR?=
 =?us-ascii?Q?Qkcsy74XgNhqKs1NWhMQVMKl7GzYCG3QMg1XITj/3wZA8efAMEv418TSHPcm?=
 =?us-ascii?Q?PGr2hFJgzSQ3AzAeY89SVtfWli0C3AkW9kLej+DqtsTGg8vipv2S+aLkeuay?=
 =?us-ascii?Q?kB6CqZAsY/HI//DXLLNMTHf1b/IAdgrgLki5ulW+35IXvxGwkay77Of8Bbqm?=
 =?us-ascii?Q?LYurHg27iY+cImO0bAEnZwY6JSI9RPViVdPqS+By9qMFzTbi7qD/zitoZI0M?=
 =?us-ascii?Q?aqSssondotoPpdF2wqC5Q4HzzS3Bfgkj4JloP7ft/pR6npfNrn/qdPkrxbHe?=
 =?us-ascii?Q?hdxAS9LdPRgleBK1jJtl8iHPZqihA7Q5q/lLLOXOUpzhMkW/HDUQjWD3t55w?=
 =?us-ascii?Q?+p+pjVtWzZy3UWWyu0oHr23GlfBj10PjwSvgndDS4yxQpNj9Tc3qMr/eKF/c?=
 =?us-ascii?Q?sPXLOaGFGMNdn1LAuTHUd0s2Xz9VUK7DI5lHXQtQ85YmS1SC6mYB1tmkzyI6?=
 =?us-ascii?Q?/9tDEQctoTS3W/WH7dIbYNY+49qnJZTq1Vi+7o52W8Y6KDuMmOTPwPMWAyiV?=
 =?us-ascii?Q?tKS/WHgD4w1uNFYzRxPbQwEsasPkghbfCTlT0xl8rcSQNRCr6XzyzxnFbADC?=
 =?us-ascii?Q?lkAMe9oZwrmpa2sYsQCdTGn7sbqEWO77arJJNxkepG6jKScAJY5XlBOl+OYj?=
 =?us-ascii?Q?UBWGOM6p8DDCIFhaIujp7nQuQTGVa6cfsMjYx2p/r1uDO9ETNvwkfTeoT6Jh?=
 =?us-ascii?Q?0r2c7RnG7JaCTlSj6evbT3yXnsiJ8JzIfec/2GPnZuyD0dbsTwnbSt8oRhw8?=
 =?us-ascii?Q?tuEIyhFwXnSEKnTy7CTE7Er1bnMomla1xNLAJwqNQVv9NxjqiLNjw+2nRlUT?=
 =?us-ascii?Q?nxbACRcHzRDUSTV9iSViA8niTRvbi0IG3oPX5qizDkaMp5aNL4683o6xvtAA?=
 =?us-ascii?Q?gdocgyt8jYlTWh1eTmk8hEPYKTcv6X2bMf/y7rT966S2FFFzaq6u8ybG2lhJ?=
 =?us-ascii?Q?pgamE06yQr61fL4zwG/+yw5kj3dCmyMdZbn6CVMMWeKD/e8DREZytrIqzk3l?=
 =?us-ascii?Q?nQUvIItudLG9Q1ON+qnnwz90Z0QQeUrUis1Dy8Jfnl59GRaAjqGgf8QoXcTP?=
 =?us-ascii?Q?Z+3/qZFFF4VhD9jHENxrMhpS9LaziRhUV+8wjrtKu2CwoYHcsBlcb+jclE6B?=
 =?us-ascii?Q?OqTRN7sOIJr2UTqYANVcExXaG+Ax/oZ6DsSXGfFBt7cN9qSwbON6eJ42KLNx?=
 =?us-ascii?Q?0ND/95+0rypVTvUM1IQRzMGph3oR+8LP6GcVb2MZ9elfimcQZqnn+KH8DHkk?=
 =?us-ascii?Q?6ILe9spfeRnzoLNZ7ZNVrh4gD20ZUYbkbIlzsBA/5GqNeCfMpkkNkoUvwcHB?=
 =?us-ascii?Q?Qo82kBh2wXTdgytQ+5JFDqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBB0B815DE366A4C8FE79CD8072026C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XzPzm9YOocqVeMB7liKbqssacbdsvvK0zjVngydZmHDaXYFeNP87ecyZulAk?=
 =?us-ascii?Q?1gxGcF7P2XrG9vP0idzPH3xeXRmYvDcs4+6h2zshPR2gmVcZZExrvmXTrn6B?=
 =?us-ascii?Q?gA0q6cYbMPXGb/YeBZnDGV9Mn6D3cWZm6AjL6CvcRp5d7tT61CXArwVEtJ96?=
 =?us-ascii?Q?3t3DO1jSz+PljjLfGUxM+wAuHeF+YEYB6H+k22NiMns1q0j+7Q+D5OM82F0v?=
 =?us-ascii?Q?WJfca/VRTXZJbpgNjgAlie5De2gQY9qtqAzoWddcgZ6Ce58YyeBLeKKZBpKA?=
 =?us-ascii?Q?5vSh0phV+MvcA1xmk1sx6/YWSIdWTficLa7EQ9KU1a/gYZBHXjJ51DaHzTRJ?=
 =?us-ascii?Q?Yg8i0FlkrAupVdIPTUQrJ0KNrh/13K7ipESOTFLK1eRHm4l7jp3N0VCxTQOA?=
 =?us-ascii?Q?Am+JfDo/auhbFIny1urruLGu+9yIJz8LB6crDc2kV8KIaPAZ5j7x8LiEWcda?=
 =?us-ascii?Q?F0cYpJhw5IwHzCpHn7OS4n6YeVyVXIWhIlAdhbjqmgTgnZBRFmkmRM5H5oqr?=
 =?us-ascii?Q?AKymFpfC155F8kBWZHAFDReB1x6LievJHRN0dlhyHyBsXxs2Q2p+f4l6jeF9?=
 =?us-ascii?Q?uWomHK+rYkp1cv4atmlPS9fV532nEtpL/F6/WMNENNODepCoHOvX3FavtywC?=
 =?us-ascii?Q?lennIF9xClslIBFR0Xo9s0ZKl54m928MWX2frNaq4QZUBQd7XPc4OP7MmaUI?=
 =?us-ascii?Q?AB7vOOyG1X1B6ms+dUjsuQZOJ6DjF8Int3N1ZqUw9cvI56mfCxDzi3NNSfYr?=
 =?us-ascii?Q?MMc/3keJnUGJCFBZksxkfi4m62hCKN3HaPFQuYh46Fjk8a9v7VCGZFBedTKY?=
 =?us-ascii?Q?VvnagtKKv1yUi62IwJwLgJVYok8Qcr8nuQE+OlzM0WwXjvXUk5O5RTbi2JZI?=
 =?us-ascii?Q?EOH0kqPGsKxBg9v6f4F5cNsjhuAahjKS42Gm6BHpHERd8VY3cbSiwqMhW8I5?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2188d30-e323-41c9-0a26-08dad33a5365
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 01:21:08.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtRVtPwDphxrI0VAFKqUjbrMcuFGnUl2R8T9glzmnkBejWxOVKVsfUSqDp81PD+Sakg8hBwyfkPnudTrgIG6qRyYQ+D55Aj68UYL8se4uko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0800
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2022 / 23:29, Chaitanya Kulkarni wrote:
> >> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> >=20
> > This motivation sounds good. I tried this patch. With a quick test it l=
ooks
> > working good for me. Please find minor comments in line.
> >=20
> > [...]
> >=20
> >> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> >> +			     sector_t nr_sects, bool cache)
> >> +{
> >> +	struct radix_tree_root *root =3D cache ? &d->cache : &d->data;
> >> +	struct nullb_page *t_page;
> >> +	unsigned int offset;
> >> +	void *dest;
> >> +
> >> +	t_page =3D radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> >> +	if (!t_page)
> >> +		return;
> >> +
> >> +	offset =3D (sect & SECTOR_MASK) << SECTOR_SHIFT;
> >> +	dest =3D kmap_atomic(t_page->page);
> >> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> >> +	kunmap_atomic(dest);
> >> +}
> >=20
> > Did you consider to call null_lookup_page() for __null_lookup_page() fr=
om
> > null_zero_sector()? It may simplify this function a bit.
> >=20
>=20
> I found this clear and easy than going over call chain when
> debugging.

Okay, then the patch looks good to me :)

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
