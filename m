Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE9640811
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiLBN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiLBN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:58:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD720975F7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:58:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2B14wY027513;
        Fri, 2 Dec 2022 13:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dU9gygmlXbcZh/+sHYearnOg5z3xjTvBtCvV0LHygHY=;
 b=cXuHkbL73oM++TCA1k6ZWcIDszRurtP3vL2/Jxs50KA/ck6KxJpkeoHyqwOo1Xrr+03S
 6/mb3NFDCx+nDwPJvszPI+2GSe2Y9qKWMDmu/PUIeAWD4Zy3X7E+HfPRADuIBfGpUkiZ
 IIlV4uEaJJbRx9/O2Xau37G40OZDWWS0xDq3rfkNqVpgx2En5MBjIDys7CQrF2diNE31
 jZQe9MIbeZvR/iMDC62/N9TGAPHLMU6JD+ZE/ktGvg2eIcttSUAgKsj/LWTo5wVsTg4r
 /pMpMthHUsPISP2OHYgmtErEdB9QeZamOAHyjl+n8QdnsFDprppWkbumI1TE6i8Huw+L rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m782h9bsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 13:58:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B2DhMsD003581;
        Fri, 2 Dec 2022 13:58:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398kaftb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Dec 2022 13:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inH77jZXIiooS0oKXqNMKz57YhWj1YCtA3DqLGp6VhU4O3oPgk9kBo5ijbUmTOsDbyl3bXRIb8uq+yyke2Uaw/4WgRb6NVOj1gXkYfxU9G6tB1O9j78tg7v8XsDoYaTh0OJcbddb9VhVoujPbJuE3n+eAw+K8Z8ctLtV1Cpr7tAneQ3SssPVDjC1yjPKIgtK7TzC71jBJ7B3SIbFUqm8mH9hi9zACxaITF7GKtLM/uc5a6jb2jbPXevcTdtg3LizFhH3ePfKgJL3giItw3w3NrZoTq8ltmBmw1tBgVE2m42VLlUtvqZ/y3GEWgMgTYaVTusJsVzz84+BiKBb4ubarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU9gygmlXbcZh/+sHYearnOg5z3xjTvBtCvV0LHygHY=;
 b=n56cboL9Zdx3roZTJpJQerJJ63U07IQ0WRRSstr4rqXg6kegt6e0c9Ha6THCTVLA1wBqbMbFWM+xfeWGKLSCsU7MYFu+dSka63jqLt2tO69eHV3umG2us6FKIS70G2u4T8rsuBtQ8FM5pQK0PnlSiTHxr0mKKEUnwFKNkLncCbOhHxVMS0DLMZLeAkZmtmbARaWIlgHWseEiEbt53r9Kw5TwdfFroXaEVq4zN0lyoxLWSJB4cwnXFrSA2z33kKjkuqjY8fSuxeP7oFXt9v+MF1reFLHeKaREXZaYfXN7+Ob0bfDo4fnYGMfJfiLOAuO2e2Rae/J0CqSAuW6WbhsEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU9gygmlXbcZh/+sHYearnOg5z3xjTvBtCvV0LHygHY=;
 b=GLYicuF508Dxw7/BZ2L33T/dqJFiAZHA06Mj6s7FqTDVYeQrYvhXW1qrHZ0IBFpi+/ELJOA0HeyXSkxcnTo6rBAOOcHgklveT87YXdWrsSeflwkaEEVvtLdntgcRQIs0PVEMkpsh5nm+iC5A4S6P9F1NgOHS1yX0ruRxoloK56o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 13:58:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 13:58:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap: Properly unaccount memory on mas_preallocate()
 failure
Thread-Topic: [PATCH] mm/mmap: Properly unaccount memory on mas_preallocate()
 failure
Thread-Index: AQHZBgosFvC/U+CT0EupbxT06inHsq5aoCWA
Date:   Fri, 2 Dec 2022 13:58:24 +0000
Message-ID: <20221202135811.jklcbe5jbaog3ujx@revolver>
References: <20221202045339.2999017-1-apopple@nvidia.com>
In-Reply-To: <20221202045339.2999017-1-apopple@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH7PR10MB6379:EE_
x-ms-office365-filtering-correlation-id: 035bf992-4878-47eb-0c8d-08dad46d4806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEsuDmUu8Xz9SjehiwlNb3K8pON1ZtBnSG563hy77xiQVQjf3EGnW3OlNWbYl1kNbfIhgR+icYVk51cEbuUye7zvLCwvkGNLtnK+eC9KXA5r8RCuG+EiJqKL/pahau2dkAgm7EovOPVhoZuZhl+hTB4RpLuIbejSYPQjlDfmLSZ6S//DeOQCrhtrxrPUGsN06nLAb6g44Ajf6dP/vUQtnZAS21XBOmX7uvVFsoYFSRh/w8WpRYP0CKk4FANzQYw6hYVsK+GnSkG6iq0ORHcwdep19vDdPPO8+EKv3KdH610EiKkF8oLZ2jOdWo2nEq0BZtkKgywRAA3i9cEOJr5ttzPO54lOpblBqszK2+5F08RR+EOM2O+MPj7+akc56xKFtvdpFwO01ekpGXtkPKP/yAFZzopUdXmLT94P9wBvh+pC6XehZNTMWj9DCsHSDLrLVRmHfN58F1VTDoQTGvQ5cvn+trBdAq/PEvrzpbxKYmFBZzds3TcBPtXvlo4KFIfQ85yTTKnc7YYHgzuOo6FRpgkA+QFj3HCU0fBdnZ/0DZzCkAX5fxYEGzhfgwWz0VTgpkG3a+wn4qZnoxQ9g7qIb43FodXx+9NCVUC6kKULO9jveJ9zBgFyGnGhYjXguhrhEjmDJZa2Jn9Cag0ZKVQyQZQvQAgZgq9Tp/saHk0XgGiCTouSNGnW7h/P/w/UqE7VWyQZP2FYgnt7D5XAmRlH9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(71200400001)(9686003)(6512007)(6506007)(26005)(478600001)(38070700005)(186003)(316002)(1076003)(6916009)(54906003)(6486002)(33716001)(83380400001)(66946007)(66476007)(66556008)(8936002)(41300700001)(5660300002)(91956017)(86362001)(66446008)(8676002)(44832011)(38100700002)(64756008)(4326008)(2906002)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1uynlh+zAZZl6eMolPH+RLMdHD1arv1QeE5IL9RZeGPK8Ej4EMN8XdzKIxL?=
 =?us-ascii?Q?KT93XYBqFWXSAujo6J5q6n7brXNDpRaATc04ncAKJYtSXuuPjyVXIQ/HPPlO?=
 =?us-ascii?Q?63Tw72Z4/33ZjGw/UgG4DxtX2kXhG3gVPbXC23u/c8+DjOIRWw1Wpyl0eEQ9?=
 =?us-ascii?Q?1F8/y4aW9vJi/3QR1Hu+127F24l2AV/uakTOULiYBULqwewpkxwBNxHcGJXl?=
 =?us-ascii?Q?aj90RnrqGsd9yN41m9imdIzBd/+DNsIzqdKvwZayn6HfBtjmR8zWgoEyEk8u?=
 =?us-ascii?Q?ITychFXO9slTSnXOwSYmHy3e+FssTRnalDYEgUMvrGmtXNldbbphssn2KTcO?=
 =?us-ascii?Q?PYwpzIqyeNaAKFLOqoUxz5sityLF9hJ8rRkJ+PSwOalBcU2h3owm4lQrQ9uE?=
 =?us-ascii?Q?2y6PInw74HEhzOtFq+UtQgWDuf3dB10VknOvKIOYisEKMT7vAvn8EgvseSFe?=
 =?us-ascii?Q?//Gr0h7yIDI3nJl+wHzP/wheI86/WrREScs/DPRj6BknpD013GFUDZQtn/+p?=
 =?us-ascii?Q?6S9pu4da/pWCjXMdl4g43wgPn/bCP4FyHihTWpjGZHQnwqLEB3/BQR97Qn1+?=
 =?us-ascii?Q?9kc8/FNdvM3eQtga8o2mYRZKmh8YE3qeJGVVrUTkdls4/V9Zj0KYR2yat4iu?=
 =?us-ascii?Q?TeRCNMuS5BHkC2tBtv2QIrKlPwMz9ckjsQEUr98LnydTykqeV3Cnii/h36r+?=
 =?us-ascii?Q?qIQBbEVEi0GnntVIt756Npnh4wZzuY92Sr2+d+WlDelqcmuADkgI6C5GjxhB?=
 =?us-ascii?Q?Ul68Lc6Cz8DCZk3kp/MUTf6YjhCn40NOtZAO6+KqHQYibcFOmCZ/A4vvAWoo?=
 =?us-ascii?Q?ITdKUBaIRRJn5k76TctBjca4vyXebIu0lcigeBeb7sMfvro2307+a3qOBptu?=
 =?us-ascii?Q?F1hEM+zLDaL8b+dP9j0OvxxGUxAJEQO740ANrmC6q41YXowj0K7PdzgGhVtl?=
 =?us-ascii?Q?d2LsdBccPL2Td+SsYqwXUddyoTWRCfis5gSsEwl2m2N++I0z6/rdn4A54O0V?=
 =?us-ascii?Q?3qfxwkucoc0E9c8SFpt1epvzSe1/eET0wCAQSOZph53RBsih4X/izfYCgn7V?=
 =?us-ascii?Q?7++431iFaYG6np2v9or2nz2rP08eFaxf2ritTilf5OeRm2Qrw4pYuxZ1r3sh?=
 =?us-ascii?Q?e0D0IeA9ZLXxg8QBCu2KXy2DXnG+BCTLXgU1pdvFLyVqrY4EPB8th88InE2Z?=
 =?us-ascii?Q?75BA+37HqEpkfIHuHaBZtj1H2Pp4OlpSIk3u5sjMjV1V7LIqD0vPKp/Z/me+?=
 =?us-ascii?Q?jnJP29Z4pA9ec0UuTRZbSeEHGpZZ/CMTeE4eIJEw/somDjnGv2dngRqdz0d9?=
 =?us-ascii?Q?uiEcJQ9UGDTBz2ApGsSZATcAIil9NeqdREDTYytsHn+6ERR8teUi8xNPogZs?=
 =?us-ascii?Q?DlesR9Gn6UGW0KJXu75YysFUTM1wI62rNTYKbeLSdRw3JyM6MaqThW5lSh2p?=
 =?us-ascii?Q?O+65bawH3cwL+hFIb0dsH3brV+cviAfsfzsUuNArmKAykveppXCiIsDSg9ss?=
 =?us-ascii?Q?laNBolYrsbh1EMtZ5wxptzgNPxHMMMA1nOyWo9UK8Fw9UogWH92ibykN8OJB?=
 =?us-ascii?Q?RM3NflH1HGSumRlpxM3H4s+uIdXe19Ospwk4tOAh3Xjw7rhsZUfx2TVGVAKT?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B03EE36465D3434D92C6CF9FAEDEA5DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iDV+kkgqQar6zIPCur0QvNWnc0TD/1zoOeCVg6Dm4wzDCzYECuBEVLdIaoiwOW/JtjC2Iy0kCyOGrSrXD13x3Wpw7X4tzlg+Df+7goXPlfEqHlTGDRQawfUDyAtCmmgqL4nBvXVT7mYr8G7DHWIP9TeFnp3OigF9kixPQtw1EP/qfDtlLvSQC7hqaIP0ktESCr/4wW8wHeMIOH6+7OMZvQHtnkfr8Wb1WFaSZaSLh6VlhcvUVAjiNtTgBZKXIwL2DL6E8pgAPFV20XEPDi9x+fJkPrCaINLb6FOvzk1tT/smyVl1Rk+ZpI0Rzp/kqZBiskILwkHeTaunVw8fyop2x6jDc/G04yCMfDt7HR0B7WU1cPC4R1AfOVrEUWa9iYYE+SF1jId302TxvE2HA9LEF4soKqhgyuu8QDLqqQ2lPhzwBracQGdezdzzk1k2laTebJjsLR7p3NpS9/DHrHR2lv99uea+ILBudga7x3flo1X98V3QH+dQ11NMCeE4W+SO1oEDxM6uJqJAKeVJ0zypNCF+NEDrfy4WkFmV30/a467IqACboXW0GkJ1z1nj+DS3uvmxezIZ7/OQkUzcXT9jkybdRr/GDIImfkvS2qFGv6M2DA/GNQdWuj0uMM/ysEHCNi7Nr2OOWweiyOyqB7N6pzAFjXI8oPZFs58XKSF6QXgxQNczM8xNNP30iN1iN3wkOTnVPX3/oT3f4e9njy6q3/A2LyU3g1ofqcswuAfX8B05q26uQJSXpzceHBnAy30U9nYe8MuuI5+FzNMldX/2b2sxvk92huk4Sw9bb+AStLVSER5mDnT4utTIrBwriON+0e3Zv58yjmxPe1fqpaOwJXx0pwoxSEvIET5saXtu6nzh4guRHnthuqxFv1AmGv6l
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035bf992-4878-47eb-0c8d-08dad46d4806
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 13:58:25.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2pmjhNH06lJZi/P78NJJ/PaPyrexG+O7k6qQI+l06dJqLxtDmv6YMy9DVNE2QVNIYQbDPuuXVEUYZ6x0z2ezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_06,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020111
X-Proofpoint-ORIG-GUID: GcOoQWuaaHI5V73avwqOaYYfjxpb3iRF
X-Proofpoint-GUID: GcOoQWuaaHI5V73avwqOaYYfjxpb3iRF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alistair Popple <apopple@nvidia.com> [221201 23:54]:
> security_vm_enough_memory_mm() accounts memory via a call to
> vm_acct_memory(). Therefore any subsequent failures should unaccount
> for this memory prior to returning the error.
>=20
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 28c5609fb236 ("mm/mmap: preallocate maple nodes for brk vma expans=
ion")

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>=20
> ---
>=20
> Pretty trivial fixup that I noticed was needed while working on the
> code.
> ---
>  mm/mmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 74a84eb33b90..3e50a571c3c4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2954,7 +2954,7 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
>  	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
>  		mas_set_range(mas, vma->vm_start, addr + len - 1);
>  		if (mas_preallocate(mas, vma, GFP_KERNEL))
> -			return -ENOMEM;
> +			goto unacct_fail;
> =20
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
>  		if (vma->anon_vma) {
> @@ -2976,7 +2976,7 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
>  	/* create a vma struct for an anonymous mapping */
>  	vma =3D vm_area_alloc(mm);
>  	if (!vma)
> -		goto vma_alloc_fail;
> +		goto unacct_fail;
> =20
>  	vma_set_anonymous(vma);
>  	vma->vm_start =3D addr;
> @@ -3001,7 +3001,7 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct *vma,
> =20
>  mas_store_fail:
>  	vm_area_free(vma);
> -vma_alloc_fail:
> +unacct_fail:
>  	vm_unacct_memory(len >> PAGE_SHIFT);
>  	return -ENOMEM;
>  }
> --=20
> 2.35.1
> =
