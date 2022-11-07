Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9776201AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKGWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiKGWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:04:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687EFD25
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:04:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JNrhc004083;
        Mon, 7 Nov 2022 22:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F1ZwmkJ3BlGzBF+OBbbZBDIXt9T39jmmKatOFLvLRqE=;
 b=a0ONdBzoELW/g+OG+qvJ5d3woYOgXcMYzXOaAavopAsUA3qNKjM5zV+8iEoeXX1ZI4PA
 Xy6y8oL05TLDyAP6q0ksKCiJ9Dt/ZuWWuG7CAKHkmDGkndMAI2boT3N9fRNUgwxyBujI
 OGtKUAIX0P/XMSd8+dQSWkWHeslkykCWH9/DgINQKyicU497ve79dWFSy6Jyas9WXg/U
 y4N86A4xZlPIc0ecmR2uX8ekUdprY+Dk48O5Hnytwks+ZGBVE/C+Usoh3PS9R4Yf0PRn
 mDwGGUye4NMn77E7M3jZlS3rSXCO3NOZU6yuTzKE7lLNmvbEzq2L+w8eomFV2UC4EXHy zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkw5ffr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 22:04:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LFJXg030059;
        Mon, 7 Nov 2022 22:04:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjrfhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 22:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKF38EJMrGTrdZV+xcXdEijSpquV+7m5fjgeHaF1eB/aeuxrffnYt3xm5XzB+0cpSQH4/i+2j4rHmBtNEW5kYUmNrL+VdG2Zvzj3yCeeiB0YwpvY+0trS4LH6mN7fhEVoAWaFD0YDhiELsqZSFZz1TKZ6x/8Ni0qhZQQ7keVGQaUQSAmSUKuQig/uhX216zzNwPgCW+ZO/ddMjOUXHdmTX4cgm71MJhTZEwVVoBUCpgjqKiNzBF5fTZVeHUJJ+LGJk1joviEk404tm9EnOPdExFLfnqiCaxi36ImF5R98Y7F+zddSRUJ/kiwF2gW13dvp3Wkrkudc122THKE8Zuz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1ZwmkJ3BlGzBF+OBbbZBDIXt9T39jmmKatOFLvLRqE=;
 b=YYtqKiH02tI85rbp27OxkIx5MOYbNX6JT52mFEZg23ApKHlBCzaxnQdgBKnZBVBa188x8b62mVQDxfgAi5IyLviRsIzmOEozg6yULxmwWlJLNMMz7rgHtb8fyLs41p+LjQCOgvh2KTgKhfbm9I6aioA/L0iCwgM5rPuodYFKrP1JjJqvqTuAbl688M+K+xVyd0gOn9vRhNoDD0K+A8XxTwdNDHH8tHDGYetFzDNh3X6aK66gyal2AzmE38G/jnQ4dX01YKaLIhhmI9++PxhcF+bR/6bB85EVzLAqegKTzKOPeYZi8anxvpFRtk2L5FD0P88uM63vlW2LpUGXyKZvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1ZwmkJ3BlGzBF+OBbbZBDIXt9T39jmmKatOFLvLRqE=;
 b=DT6/ncNkG+bKHgjC/hC4FEq35xK7RpasXLgh3mzg9nSF7dP0bnTK0vQjqFJC5TQ5RWFcvQhIBC7Co96GcYFCqSrTbBMNaCQsvWHerzCHO+arApLqyy1Q7pANCFtoQ1c3l4OnEgQZrlo9uSawIRqUIyMkXYD3HM/aWCjTrMJlRWU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 22:04:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:04:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com" 
        <syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/userfaultfd: Fix maple tree iterator in
 userfaultfd_unregister()
Thread-Topic: [PATCH] fs/userfaultfd: Fix maple tree iterator in
 userfaultfd_unregister()
Thread-Index: AQHY8uUn9z2eFZfR+0CuLW4biB/bk64z9deAgAAODYA=
Date:   Mon, 7 Nov 2022 22:04:11 +0000
Message-ID: <20221107220401.dkhto2mp66tnmzuc@revolver>
References: <20221107201121.1169273-1-Liam.Howlett@oracle.com>
 <CAHk-=wg9WQXBGkNdKD2bqocnN73rDswuWsavBB7T-tekykEn_A@mail.gmail.com>
In-Reply-To: <CAHk-=wg9WQXBGkNdKD2bqocnN73rDswuWsavBB7T-tekykEn_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB4851:EE_
x-ms-office365-filtering-correlation-id: 81b133a8-12bc-40b0-8ef6-08dac10c0069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CYa3BLEyYpamGf2UReNQoBi5FI0eBXrv3q872HmzFf4/ixjnlUeCIHkL/lB9JgXk1m95OMJg7R7E65GLY3WSRv6pbxZxCLh9t31L6JOntWqzLYCx8wSPD2X+63Matin83/IeXDSiQz6+H5rc9jSAffYOOCS/MYx7tcatb3At0s3aZGVGWslhW1Puw+ok9yea9SzD6/2uxFpBk6DRPPwej98KbLmTPZJzp084MOTS04JmGD0THK80SwZBnay1XrQEM0PLBNnupbm3M6EKwDbCOSfTY/JEZEwcFvl44XR7d1/0Yn1J/HvcFvUT3kxXVO3dbam1YdylU8U7+ozBXtCzRI6U4+K4CB+qLQrdrf0iVygbRPKeiy5MvWQ4FoYjDBDr4hfAbO3QO+lKEPJcGWnois3NZwWXEApfprB+xabvB1v7thQufbBHolQOEPnwpPRC++KOZqQ6c48jaEyoE13bZNpgEbKWhQ2ynxZxTaxaDCuQ/WDptv9sjFsAeRRNW0ABnqadNcXDuQTxcwbB1BzvmD767XooJrJmCWhB5bJRX13nxF7s7SdRXHacP2GLKxAE7tELFbB8W6v8E8VkR6mV6BinADU0ENaij//eVQUQlC5ct91l8AFI7ZB4hXeR3tacyrYYnqEn0dwWAnF0XIDAd3ize2n5aFQiXaSAxjHhit23gmpRV48kKkcsUVgaPdSa3NWrv9cCdzoCNAWi6p3+RSpBp3gdwlNyahVXdzJ1NhU4K/ey3kZXSgD3E93J+7Y83rEfvPiUjVjkX7Fzf2hcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(38100700002)(38070700005)(76116006)(8676002)(186003)(66946007)(6506007)(53546011)(5660300002)(2906002)(33716001)(122000001)(44832011)(86362001)(4326008)(8936002)(41300700001)(83380400001)(6486002)(91956017)(316002)(9686003)(66476007)(6512007)(66556008)(26005)(66446008)(64756008)(6916009)(54906003)(478600001)(1076003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9tUrmkVN8vsdBP3dYaK12EObuI94v5IPwrz77f7MXTQP0RHkgeZZBEmAjC0I?=
 =?us-ascii?Q?yejTcY77cHays+aWmvpRuUuFf5xJO/LAOifqEdzwtLiD92V6epuCb1ATXC79?=
 =?us-ascii?Q?XaP+ItFQO3jCPWC+XN8jNCBAAkXyhnKgOrZkxc9edb1S03hOyz7elMtCR8gT?=
 =?us-ascii?Q?L4eEv3D4fLQUFMXM6UeZ7Hr95TTAvp5YsQJfpNY9ajR5zLRwN3zE4SNUKPWI?=
 =?us-ascii?Q?+yWtFELmqHG3tbGPNj4ayiHnmeRLAt9sZ1LH646zkm9nLUhYDmsWPUFI+3x7?=
 =?us-ascii?Q?a930szxMdzx1uXdCGHTDEw6XyvbZocGw3MTYmiU+zSJpmMSb4jsthJBmnR8L?=
 =?us-ascii?Q?gyDJo52tLBeL6xSO1A89XFRNVmlK4QQs16UHSKb+8xO6gatZxiJXVv66L1F4?=
 =?us-ascii?Q?t6vBGFr2WYuFyTS5rKR+IwAE2ug6sMeysxqpDiPjy924ZJRZgh8zL6SPoynP?=
 =?us-ascii?Q?lQh9wCXk40z0UEvacXQtdfCS35q0nVRyK2iOCIL2FbCrjC3jBzzzkFTTBRtC?=
 =?us-ascii?Q?D4EuDbQE3bzSncRqjgAT+OjFObWWjxyq/TBmq0nP/V5KM12AzP+5zlBzq3SZ?=
 =?us-ascii?Q?kfKbvxxb6b8mCzCXnxS8Uj1ijfbanP9OSzqwjbZS1VvztMebpiboBoGy5cu3?=
 =?us-ascii?Q?z24tGPUO9+yEktSsWIG3ec7nIMVe0vp2ptiJxOnf57e5Mgx7YsEhD6jhb0mB?=
 =?us-ascii?Q?KoM0ULNkBuO7x9FL1Ch3HG7xGWq8hPfuRXJplUgFX0+0zBKLkZ8K0R390a8h?=
 =?us-ascii?Q?SD0qGrsT4lhijCh2WecroMxEHE/gdQrKd5TdRikhpX8nD4wiM0wcfiu/exXB?=
 =?us-ascii?Q?Lc3oYzr7Qvc2uYjavk66Hjz/oz0QqFJj2RZfBcsMyjXXAzLP2k/bZogOD3tQ?=
 =?us-ascii?Q?KR1ippwUw8J4LQum2NJcQXMhdTaxVAwZMS6mlBTk1FCxYQ/+abETYCwfodZv?=
 =?us-ascii?Q?3RKHYR0+5clOvMd8So/lTOTyFcr4wuDV78pwhk2xfU+sJDzHBvu4WpdOlfvx?=
 =?us-ascii?Q?EGGejTddejRzK4enpci9V6R6X+luvgvXnC3iyEYEl9m/A3SIn+GY8LTQCY3t?=
 =?us-ascii?Q?TlM5Q+U+vvV7Q8YYloUqoatQ797zaqVo4P118X8v1bGNujBj6n2CJZDGS6Uq?=
 =?us-ascii?Q?sd3PoVSxJAXbk+dSZPj6GbnxA3PyCdTkYSIa0i5AxfGf3W7H+oTvLpFlr3sN?=
 =?us-ascii?Q?BwifNpHcCNgrEC+UhymgiwHgUZJuHZZn6W39uNYGoXeI6p+gsjVB5IH7c+Vr?=
 =?us-ascii?Q?UsKXrDr3OeSRX0qIn509wmo5YUFxF6OgCFnS7K87nwh6/WE7STRxy7oE6f/R?=
 =?us-ascii?Q?YOWrpLns8Myx6FHT66FM/guCiFBigm7+r7UxlNc6t84d5pr370PNbho83x8/?=
 =?us-ascii?Q?CYIgetmZUevUmr1o9uXm6A9ZyblyL71DhIhIpZFr0zRu0+9+06pRYue5O3CQ?=
 =?us-ascii?Q?Okvj/3hu2nu0HnF5+VeUAW/jJ8w2/0PkxcImIAI8ylCuk8D5ttaLvAwiuhvq?=
 =?us-ascii?Q?i1GmDhnjoLcM3zwormBD10SCO2qEcP7GG4GWl4KkXMO2lvst/jDjBCjTmnEy?=
 =?us-ascii?Q?v0u0EB783qWGbw3ajsmDf0AzFiJaPecoi/0y04SDYlAf7TQt2b5fICRmMFUf?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18044F835B5D224EAB272D428D791368@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b133a8-12bc-40b0-8ef6-08dac10c0069
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 22:04:11.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuH1DMrgCEgpsu1Ag+O4Am78uckm8XAy3GDNwwlDysrFte4yltWS3Ql2STqguQFpMby6wRDLmQdHki5loZcO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070168
X-Proofpoint-GUID: E_zkee9TFIe8-fTvTaOxtCysj5n7MUZt
X-Proofpoint-ORIG-GUID: E_zkee9TFIe8-fTvTaOxtCysj5n7MUZt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linuxfoundation.org> [221107 16:14]:
> On Mon, Nov 7, 2022 at 12:12 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > When iterating the VMAs, the maple state needs to be invalidated if the
> > tree is modified by a split or merge to ensure the maple tree node
> > contained in the maple state is still valid.  These invalidations were
> > missed, so add them to the paths which alter the tree.
>=20
> I have applied this as an obvious fix, but I would *really* want to
> also see longer-term
>=20
>  - I'd really like the 'mas' operations to have 'vma' specializations
> that get the type safety right
>=20
>  - that mas_pause() name is horrible, please let's just fix it to
> something sensible in this context
>=20
>  - moving the iterator invalidation into split_vma() and vma_merge()
> or at least have some other means of not having these mistakes
>=20

Yes, we intend to do all these things in the 6.2 merge window.

> From what I can tell, things like mprotect() and mlock() - end up not
> using the iterator at all because of this issue. Instead they seem to
> just do
>=20
>                 vma =3D find_vma(current->mm, prev->vm_end);
>=20
> despite having actually started out with the whole iterator state.
> Except for 'apply_mlockall_flags()' that randomly does end up usign
> the iterator (and has that mas_pause() as a result).
>=20
> So it would make *sense* to have "mlock_fixup()" take a MA_STATE
> instead of "vma, &prev" as arguments, but it doesn't.
>=20
> I dunno. Maybe there's some other reason for this very non-intuitive
> mix of "sometimes iterators, sometimes not, and always horrible
> naming".
>=20
>                 Linus


I will have a deeper look at the mprotect(), mlock() areas as well.  My
first pass on this was to just replace the easier loops with iterators.

Thanks,
Liam=
