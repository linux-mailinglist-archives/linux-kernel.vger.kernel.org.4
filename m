Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E125FB80A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJKQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:13:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4ABA47C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:13:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BFOS2G001157;
        Tue, 11 Oct 2022 16:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1PaMQ7fzJu5FUv02gLCDGBpDY3SfngXtJ1CQ6q6wcxw=;
 b=Bv9Pah6EKcpTZkwfbAHNmMS0yCysycssu0j/RkAcPdEthoNVmEi5lpd+2ocCR87RI6Q6
 FVNsGpKakSYJvaKdwGEVlJXWd1fCd7VUTMYP8gJJn7BiusJ37KuHtomfAmdPGd9GixM0
 Pj7Ez0RodafXBWmgVQ3xPZz2Q7gsIm8QFDxBBjpHP+mFny83Gcq1mI+X/Ucn/UE9V1dk
 UPr03huuC7sBr/DQJA8l0jCK4QySeFO4Dn92i6sXL905SkOu/QMBxm94+mnS1jKPRYzk
 AekUKuwPkjWvKnb/LF8RUXp00hUkK4UdOehsT3ywTuE1Rj1dQ8i3g+jBINLf3ZNwtp/H NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3139y5p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 16:13:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BErp6e039788;
        Tue, 11 Oct 2022 16:13:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynak1e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 16:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIfytzQglahceHQKmDFVp+iMbzAfNMRKPuzHhk+334ePTAXKcOeObp4hYFZY/QcLn1nBIfnW95MC6pUSOCK2Mr82BCfC5NpULL5ALTzI2l0MvFO/JpWy24r8F6WNTSqJQlj2GKf0WPfc3R7mSZ2hhnZ+gC6tW3lRblQbMuqC2gugVaYGaE0sBlzGwySZJcft54DmExIp445mvt8LvHZGr3XCj9tpXJ9HvYI8A0nJ8YwQ5lttVpEmI/VFfJAXbcmTNPalXEFdyLGWF1lYLdKg8Gbb0hG49tTzFNchup/0xux6A/9TgGAOlVius9SzzQT6eSJdENcMZy6PJBOBkcolWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PaMQ7fzJu5FUv02gLCDGBpDY3SfngXtJ1CQ6q6wcxw=;
 b=OR4XvRWofkLKUx95gmosxgtJA7osDptKxH5ToV/F5jRKsOyXqOvTKGSVrSnA9ZZ5ZOeAmyI+3znXJGYt6+MDmf+4tUSceFmPkvKAjacF8GtDazcFUn+Clk3rLyBY2RrybLd41xvk61ykr1gK6oQweKKTRMAq4OpJkixq/j43KQicmVRwhA8V7uQESI9a9WccL1GhDqeRUlZ1AyGAs84vut9jcvur1/uC8NcokSmXSxvHXtJd7cuTqLZWmzMe45jP36ZKYkMDuvJUob/3m2L9iTCNVUCg05tze8ZDJLnTEE096rV2R+/iBqZkfnMi9AiYf2YjwntoNNEdmRJPLRrZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PaMQ7fzJu5FUv02gLCDGBpDY3SfngXtJ1CQ6q6wcxw=;
 b=E3I3akUJUQnFwrWvN4p/IjV8blgqHx/+AyV85ywEVXtN98+SsbYb0MJSKHRlmdJKwY6S1DJ70u6h2vwqOcCD53L8wkXsd5zYWJQ0++BUiCm6CLeKA+eVdtaRkULVpFpowosh5e+RLa+9nNqBJS1r4lhbfMcMnRSTMas2qjM6v9o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5320.namprd10.prod.outlook.com (2603:10b6:408:12a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:13:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 16:13:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 07/70] lib/test_maple_tree: add testing for maple tree
Thread-Topic: [PATCH v14 07/70] lib/test_maple_tree: add testing for maple
 tree
Thread-Index: AQHYwimsOU/pt4mXXEG8Xyio30e2za4JUiEAgAALOwCAAADlAIAANg4A
Date:   Tue, 11 Oct 2022 16:13:02 +0000
Message-ID: <20221011161254.mnt6da2357lhhlff@revolver>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-8-Liam.Howlett@oracle.com>
 <alpine.DEB.2.22.394.2210111414020.303227@ramsan.of.borg>
 <Y0Vn7o4nmy2FNkLC@casper.infradead.org>
 <CAMuHMdWHzWxc-pq27+sdV9VeGvZYX+MXH1OZ06NVMuykDBpeMw@mail.gmail.com>
In-Reply-To: <CAMuHMdWHzWxc-pq27+sdV9VeGvZYX+MXH1OZ06NVMuykDBpeMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB5320:EE_
x-ms-office365-filtering-correlation-id: f607efb4-6547-460a-6996-08daaba37945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xsKYk8jpdG9AA5tRI5d2/WO4HvfbnFaix2Vx76ww57U1xDGcG3DTQmENeFlr68SG3UDfBrTUeIimlMRv46C00yWK2fL5Vn15rKKhOWw0AVvYRlYqCkXFmJKLPb56Bz/8GlGdFKVz3ByM4VNpoRR6nCMDlhS4dPef/50HxbAaUoBvQIyXuBZetH64MqmonWAtt6gCsQsZGZjewVmUDbp/ESSiB1zHM+h6uaejxt8pvQw3C8XDbnQ0mpdsTGkaIgU6HXv+FeErQFiDfC+1tCk3kfVbN5wq7DTJJ2m+9B1otZfaouLk4H/FuocYU9F7aDdxJUhmOJk2D/GCcOuwPuPK3kxh1LNv7GjzBFKvHWRJZPvzDquIXSoPiNZuuZzwDqtdCi0rjHRLnU8ojV1sCQaCFEvYJ2Mj6yBH78HruYQMFogO+JFQzyce8fhaWsvXIjX4OWerz0eGkyy9jUIf2q0HFMgzlfkuLPWlBrptWPa4DfH3PvMADk2MSpU1GgGlV9nQS97sTlJg1fw8BKeO8nKx52n09IrX57Qes2fp5odxVCLmS9SUDCJIX37zaiZCZAV33qJDHJ3/jyKphxY+NlBbm0KmNh67NOE/ulT8kQzVdx8nhQc6stqE6mNtp1ofQusL0YnsEhqVU4ftXKHp4hTyG5aqtlo/CgMxZ4ar0wTCVD+MGg450wHXuUSusueWNNQR/5M9Bz+yjL7Ibk8mM+G/z9EBhBLbpygQVwLYCX5nqVh7A2hTP8UVYKabfY3ckOoqkoRdKVahKzGei4YN5/HeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(478600001)(86362001)(38100700002)(38070700005)(53546011)(4326008)(66556008)(66446008)(26005)(91956017)(41300700001)(6506007)(9686003)(66476007)(66946007)(6486002)(76116006)(71200400001)(6512007)(8676002)(44832011)(316002)(122000001)(54906003)(2906002)(5660300002)(6916009)(8936002)(186003)(1076003)(64756008)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yRF/ASiJ0dMgD1gnHz3oHNLAXPiGTKdTLKoXhyKTKN4YFTzpuPASgtv434HW?=
 =?us-ascii?Q?M/TgpFuUG9aZOiopijelr64a2ujVeAUatnNPKaqX/Bpe+RJCOJz1ymyDn7y+?=
 =?us-ascii?Q?/p6M4O1yPX+Bat9gVWYaBaI4pkzcyd3+ff+h3j1EzsajcpQ388Ta6iPjQpSM?=
 =?us-ascii?Q?VVFbRxVaXbvlKrSUVDNt2K3L12iDZ1iYH0BAxPgGKIOPmfsdP25s5PUYzSdX?=
 =?us-ascii?Q?WpzE6S43X9kUq0oGNTEOVy2haK4Pc4Bl2w9kT/Jc7Y28Yn7n28hgb/URZjdw?=
 =?us-ascii?Q?wvHvW+MNRDy9xNDC0ZhXtGGaEKmgcxKC6cy9K12CAFP37dRzYcuqoP8tIgHC?=
 =?us-ascii?Q?jRU8+asga4o7FOCoZJk0HPMSph8pFseEVEVsffxOsTDzsEjYD2jiPM3S8/xe?=
 =?us-ascii?Q?Ewj4uGXrmbY9oxucW7QhehTaZNgnJ1V42Bxw8VerNVIoV/IVytAjOYZcf7Oa?=
 =?us-ascii?Q?nLt1BSKfy6v8yCOGfUwXN/856vWB0LkTC3Bui8bQJy7534J574se58XI+4Gw?=
 =?us-ascii?Q?+OTrjl2dxvhnOA5OK1Iu2HwHNHZ5NsJ4R/fv1UIDK3sT61aU9iwSuZHdyVyS?=
 =?us-ascii?Q?qmKtFyLpaXeh4/ULHfk1OkZEvuIHXI0FaIZa8SWBduBAcG1ueDYGpHdSD1JH?=
 =?us-ascii?Q?IvjAOAVxjpBSrK/1jAkxU0frMm5l0GrwSLz4ffBEqzY0wX1HMcPfEeDsknSI?=
 =?us-ascii?Q?S94brdeAdCSdfn1nIR3z63V9OSJdJzeFlfbNjO1FfvqWGfYVFkrGYGV30eci?=
 =?us-ascii?Q?YEfD4ui7I2RYe80r+H4zKEdsWqzenWjZMVr3sKXdIRtWJRABARynfhOaotSK?=
 =?us-ascii?Q?+JzmpbxpmeFSxBqMTeC4w99NZ9LK3HUnTiwD5I/CcADuE38VmIqo5UWF+AJO?=
 =?us-ascii?Q?5/naZawLbt4CMXhXzxnSLW5KunJoYhUm7DDo9iaCl/mHyqXgmhIa7ty6hl9p?=
 =?us-ascii?Q?95MEkXzMHZN3SjmZ5Hw1ZZgSb6rccrvpPlYrFJxki+BbRBoB15+zF/wrxY9m?=
 =?us-ascii?Q?UgoNPPPWEpBRSm89v9wr0RBiZRPrOecuIA+5WWa3TrReuuBXgyblw2BWUKXA?=
 =?us-ascii?Q?HL+sVGza1gi8Gc6xEuNVCykvfWLzt4AlxFWtrLlTBtQxwuE20MRFpYQvf93z?=
 =?us-ascii?Q?+isRSsqk2kUjscfLDbw/uyimD6cWf3vuJo3yiWEvmRP/UagaUfTQbNhSuAlb?=
 =?us-ascii?Q?0p7q3DINbIgdAjY37fLqKCi818ZIm7EuOh1lhnbHyTbO15D25ibpqjXIlirT?=
 =?us-ascii?Q?wv6xpkqSTWuktBZRBaX2zG+DyDo988oQ5cqFdyYIagQh6jdhIr32OVfVdCXE?=
 =?us-ascii?Q?S2664DOtRq5iSVxyKFjMax9mEoWtAlsjFBJZEo/Kaf/7dgXNxQLy29W/UPEz?=
 =?us-ascii?Q?XtIxm5hvutq+HEmJ7DWdRVWX5UnuHNJ4S4yTfaxkvLR1jvURwUvqPxhWKYHc?=
 =?us-ascii?Q?cT00pm5L/0h9FQ93LbCujCAZz1+7STDYvsQauQw0m4XD30+17AVT65yYim0U?=
 =?us-ascii?Q?bxwTXD/UyFWntAnOFUeLxlRLHNAUCk1ymk9ClVjyB5alt1Z3qXJq+4bqvRJs?=
 =?us-ascii?Q?QJHA28+seaLUA9XS17mso0rX67bz6rmRou32BkvmmLefJbU3UeGkOa0pOJgd?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8AA3205537CE14D8D169214E1B586D5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f607efb4-6547-460a-6996-08daaba37945
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 16:13:02.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c09Z3jcl7UN80hffQk2n91SgQYGtl8X7y1RC6prH6v3SJuVuNwEFsNkvfUu1LBoscaOHQeCmm53DKbuAsbblfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=879
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110093
X-Proofpoint-GUID: RuPBcweW8flEs9YgerQDssk2QGjBIMFS
X-Proofpoint-ORIG-GUID: RuPBcweW8flEs9YgerQDssk2QGjBIMFS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [221011 14:59]:
> Hi Matthew,
>=20
> On Tue, Oct 11, 2022 at 2:56 PM Matthew Wilcox <willy@infradead.org> wrot=
e:
> > On Tue, Oct 11, 2022 at 02:16:02PM +0200, Geert Uytterhoeven wrote:
> > > > lib/test_maple_tree.c             | 38307 +++++++++++++++++++++++++=
+++
> > >
> > > Does this test really belong under lib/?
> > > All other test modules there can be compiled and run as part of the
> > > kernel itself.
> >
> > So can this.  It's just like test_ida and test_xarray; it can be
> > built as a module, or it can be extracted into userspace and run there.
>=20
> How so? I can't seem to find the glue to do so, or the Kconfig symbol
> to enable the test module.
>=20
> It's different for test_ida and test_xarray:
>=20
>     lib/Makefile:obj-$(CONFIG_TEST_IDA) +=3D test_ida.o
>     lib/Makefile:obj-$(CONFIG_TEST_XARRAY) +=3D test_xarray.o
>=20
> What am I missing?
> Thanks!
>=20

Thanks for pointing this out.  I must have dropped this over the
development cycle.  I'll re-add it.

> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds=
