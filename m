Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C965236F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLTPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLTPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:06:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FA1A838
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:06:03 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDIa6W020601;
        Tue, 20 Dec 2022 15:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ePUZL/bsROm6HrElckq0xAm+Xc9ADJ5b3IDdxLO4W74=;
 b=1HxYNqH/DvMdCr6h4np+wXiIICUdwod4Qj6XJKUUhviZtY0OjifXYr6jMvNj0sJVAggy
 QXhUjOIiqEfPcLSdIe1bHTk+/D3/sRVmCKoNGWFzwGDIdkqXoOApH+5+QagUdPDvqhti
 uJHsx4fuoa0/FTpliSTOTd6Y//QIBRNbwz8Hqs+aRBGaK2/Zybg40jfVXBPYqtSL0/PX
 D68+vH1wqPCWeCq6DhkrkTIct8har+GxuSWe4egrW0/lwm8TARp5zFxc+3EXzTAr5GRE
 QaUyRwhI/8HeFCC87awi0rStgx+MOnekx+c3iSHvUHR3bI0WATE6LLijZhik0eeJihs+ 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmx05t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:05:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKEOOn3004642;
        Tue, 20 Dec 2022 15:05:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47bg0hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuvnLXNQKK/i5FlarXdatWNtlW6z26T+dQHSGM2bIALLyzqueh83lbWXxahBTr/oLVL4TD6alzjlT2evM9islEkPlPkPdzKYC6P63HsMRb2aaRzd7/e0hKZ/UjdCdhqhBsGaNwN7plJDP1eKoKCgeaN9oWdoH9gc/lhrcVbDgyrJWrMf2pbO7u+hNQjKo3CLwvn/p6a/rMN3/9DwLTaeSb/sJV5K5lt+I1HyAeSSjsollCmz3KXslEooCTYYouX8Oi5NsfAC+Ei7PJFcrV2CvArwvIQXWkditkZ62uIiB6DwQnF9CFSZIS0Aofzg/20FvNfPTfbcV9y8j71OrYfcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePUZL/bsROm6HrElckq0xAm+Xc9ADJ5b3IDdxLO4W74=;
 b=WLMvXQIht/5hMg4ibPtc2QGDznR6KnArydhDQ6ai7e9bBpu0MOMfWR03B8IpePcOQZa0TUFpxbelVSW3yTQZz+90eqUaE0g8ky4yZR6rm5lyDNjEmJdod+SlX5+aBV1HHhcOQVEofiMUDjSDxMwXlK1+YaZjI4VWcxfalJfAbATvr8L7RjTV1y8FZ5j+GXlxaz3A+jtYzajeDIe1ZJFmtmv2dfRBSZXu7ILwFcPLD57+Oi5fKSMI4Kwgt31LlT/CZ/THkMm8xm3m4oG0gPlzcQpGB7B/jNwtR5zZcPklHGANBu31K8IFiuU0vBGvcVu1sfSNCqF/AHmSIYX7N/G3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePUZL/bsROm6HrElckq0xAm+Xc9ADJ5b3IDdxLO4W74=;
 b=gspT56IaqFC64XGiwi3Jznxwc/P7ho/D7YDLiznPxOkhWVpMNBPNDx3WDZiqLk6WmeCPblQS2yVN5ecm78ymJvkmWvmRTLwf4jhIDMkO1PTqk8bNcvIMzhYRWSJLAyORezUYsOwsdQn4qJpHeFQ5cwQAkUgHKdzsO0P2/3242LA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 20 Dec
 2022 15:05:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 15:05:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] maple_tree: refine mab_calc_split function
Thread-Topic: [PATCH 8/8] maple_tree: refine mab_calc_split function
Thread-Index: AQHZFH8bNh9ZARRI6USUgFq5Cq9BYq524BkA
Date:   Tue, 20 Dec 2022 15:05:52 +0000
Message-ID: <20221220150550.y5kknqwjc7q5bv75@revolver>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
 <20221220142606.1698836-9-vernon2gm@gmail.com>
In-Reply-To: <20221220142606.1698836-9-vernon2gm@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6220:EE_
x-ms-office365-filtering-correlation-id: 3d9e9f07-2cdf-4d8d-adc9-08dae29bb02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3w6iEWSCNtSjO0ZjAZbFzIf0EYWtlXGazhcVnfwIMghdTvEQAaxe8gztY7rk8NTB6N7d/w1V2NhXjs4gjjBZIjeB+HhzaV2KLLmo14oeoE1m9x9PO1wSSkg8VAZxHyKZ8n0kHd3+i2RbfG7wHm/NFX8R9C3malII1xXHW7GrHHES6+aAI/rXyTCUD3M94wtsXarQ/uK8BLnWiv/eE5bVBZkDZcpoEF6TkKYkVdIWoLnJ+GGJcSW3KHeIUlBcKp+DaDYnMrD7hcXh22T2vylydgE7VUHygPPAj/uBYjW5RHMEjEHd5zzMy4wITseEPALCLWlPQGqU11zv21mbKAwYH19zefFsg+YsU5lbHOdSQVVDqxlPmK9ls3alLzHEeY1pp3mdn3CZOLwq2V7OsCkv/PAkuK16yYxNqrQWC/Yv8YvjtGAviM+dDiaP6Ltl7C+n63YE2FiQW6/mXUoM5QvvM1GGHt4/5Y0keo1Jk0dLAshAh+BIoBiTSs5Prdmp3G3SKPb/UVLbt3RoRanslISZ8WJgVeHCNzzEOZZvbKQplYfFH+xk9kMm8p0MlczcCp3UpNDyTSL/wx4iKRFgLgWXETU0tu/L/FuSoRhkl0x4/je4jQ2GAH1FRNTPEZuJTXBDKgSxOmUJKaUZZs+/5PoJBQTgMUMKTETk9YTxFWcgL+a1v1lYwjAu2vzX9O9VbngPFOsGksC69/+BXOhFXogqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(64756008)(66446008)(66476007)(66556008)(76116006)(4326008)(8676002)(66946007)(8936002)(6506007)(5660300002)(91956017)(41300700001)(6916009)(2906002)(316002)(44832011)(54906003)(86362001)(478600001)(71200400001)(6486002)(33716001)(38100700002)(38070700005)(26005)(6512007)(9686003)(122000001)(1076003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGrWX+ie8AxiJJFY5lY0rAQ9h6wEYvhLfumGj24lOP1/RJFYiF1Usx21R/oe?=
 =?us-ascii?Q?ZfvUbYybVb0I5Dfd5Vo8EFBPNEKOAL7T7eUfxBOki3P3TlpbyHa6aAUhQsxt?=
 =?us-ascii?Q?6GNw+ct+lIV1cRK2JPowtCf6a56T72BxF3uMAPN/gb1S6IpSR5UVK/zNlZVU?=
 =?us-ascii?Q?FZ/v/9/MWhc1HHKeo+PceKLyCS3l/26S1FoM0dhOjVJEdTVKTt8oikvLONuq?=
 =?us-ascii?Q?9UBNqnE3OAeKcgZJZ4IkD5ReS5+BqjyD14sbWijaDo3K2rYvrn73UX50rxxu?=
 =?us-ascii?Q?4dZ1AYdFa/8iOCK1gzuc++EjaurvMnbGjPkYWRCBUtFgcYoyHUubz+ojtmx/?=
 =?us-ascii?Q?0+khjL6SCtLS/mR/zuBGV8y4T9k5QOop6wAZ4Rk8ksa/Hu5pZj6duZ+zIXTf?=
 =?us-ascii?Q?C0YZTX16XBCSd+Od295dZB0oZJFjqGxwF61HsdSwUlYHu5K4b+mdKCBN3OJp?=
 =?us-ascii?Q?o38kww/KJk3oPkDi3kW6q+CFlx/wSD2l9N2eeuDdjwa5nPqyTGE7jfbKxePT?=
 =?us-ascii?Q?IAblyYH+QpGdKacmwvjvkOXe/f954LT9dsUL61P78R+Chyce5dvSImrTW8NV?=
 =?us-ascii?Q?J/jsfHnCb51rS7pgyz3jinwJ/J+bu6Dw+oyAGqiFeq8JqVmCO0Y5vnjFE/9E?=
 =?us-ascii?Q?Td9VskkedkfaEP92mUMeQVHtJ0EFLN2Yj1NwBh0gbK4H5/DHclwFKbwysQwE?=
 =?us-ascii?Q?NoR+8VP+wYDfL/AChxmuVuAv04/Sq3wfmYZVoOzW2ctGCj1UeJD3zxkN354V?=
 =?us-ascii?Q?OArfR2RHKehDyIqIgbG0JHmEuv8sWXkqoTvb6FVCB6/EPNXo7Jeo+aWBC0pM?=
 =?us-ascii?Q?KlQTufLhdyEQvxIyp1S54DMHbG3SMdaMOQnN7j8eC1cuPow+tTJGAbsKX5t8?=
 =?us-ascii?Q?319wkXUyJc7LV05yVZXCxQ7Oeq97qRKQM/rG3iI9C7eVou3uEOv72UJfvGSn?=
 =?us-ascii?Q?OrVz79WFY3ollM88Vahfpc7wxfN8nhSiolUe8utDoMXQtuWSMjfOv5uBJpao?=
 =?us-ascii?Q?wYdglwwDUbC9qA+s3cjUU9abKYlfQjRyY+KetpNOmkTeIaXtpZw0uixRsMHO?=
 =?us-ascii?Q?OmvdlBXZfEUJXTZlA3B4zDspvhtYmuYM7KfsjIXkkXx+Sx0r8JdtVGWcFAs4?=
 =?us-ascii?Q?t4g0kt0h4y1NYSD1wW597sRchl/qjac9rcB3aVGTXePq6BQouD0LectMmFVu?=
 =?us-ascii?Q?70mqCbPqQoEnhnH4+m9M2E/sd7ToHGlAbYZL8CQmXXoAaCvHNuiptTxjkzrk?=
 =?us-ascii?Q?EiWtBE8SJlT8d7uHsUHkC0rYZa613hihQeKXduItMwRG3Z8Qj1BOFVZ2U5gM?=
 =?us-ascii?Q?4corZ0U6TmHtN9OxIw1jcYQTyG1w14j3qicU7Q29acnuUouzMo81c9tSbpey?=
 =?us-ascii?Q?BxAtrum/+aXX8Tw5ydmIKKOpGKobvRCEmlEVfpbpcE6iYRky+fBjOKdUC6xo?=
 =?us-ascii?Q?m00Oc4LlWpkUmkE72zxfQQaOnFSb09uyu5yI462yEDS4UIeVauorhh1GO34T?=
 =?us-ascii?Q?flNDP8s9aCDP+OI1VCwQfTEouYHJHohDHbQXoE+gYMi1UkqUa8rzCCRCDdiU?=
 =?us-ascii?Q?ohwiMipvExkWAcVC67XHMztVygby9/QMegiV3OZZofxLVqEIc4b0qkCeG5eS?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E94947CC4276244B9073951D4B60270@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e9f07-2cdf-4d8d-adc9-08dae29bb02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 15:05:52.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Nw0aJ6AQT4HBZx24rW6HSv7VAfMcrBfZTu6+75APHMoP6Bp5N3a1gRXY8EKQYw7jxDrSYbe44u39v1ZmnXGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=729
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200124
X-Proofpoint-ORIG-GUID: zKMhKuchj1BCuJu_iyeoDQe7qaP8D01E
X-Proofpoint-GUID: zKMhKuchj1BCuJu_iyeoDQe7qaP8D01E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [221220 09:26]:
> Invert the conditional judgment of the mid_split, to focus
> the return statement in the last statement, which is easier
> to understand and for better readability.
>=20
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  lib/maple_tree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 16cdcf309e97..d147669fb99c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1882,10 +1882,9 @@ static inline int mab_calc_split(struct ma_state *=
mas,
> =20
>  	/* Avoid ending a node on a NULL entry */
>  	split =3D mab_no_null_split(bn, split, slot_count);
> -	if (!(*mid_split))
> -		return split;
> =20
> -	*mid_split =3D mab_no_null_split(bn, *mid_split, slot_count);
> +	if (*mid_split)
> +		*mid_split =3D mab_no_null_split(bn, *mid_split, slot_count);

The function is written this way because mid_split is almost always
zero.  If you want to change this, then we should add an unlikely() to
the if statement.

> =20
>  	return split;
>  }
> --=20
> 2.34.1
>=20
> =
