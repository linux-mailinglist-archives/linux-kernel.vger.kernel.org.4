Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F069C6246AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKJQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:16:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC73193DD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:16:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAG5clr031411;
        Thu, 10 Nov 2022 16:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LTcFxQEKMuN2DBh/ob1gnrlpkhXzPm24I99i5SRKrAA=;
 b=H4vzvDVax1o/lBbr/7hdAeJKl/AKmGnMfd446JL2pU2zaZDVBcB4nMudn2CXVAy7RT65
 0aKA/AQqXmKYKl08fG4RzyMS3sRZ6YEZrhfB/gs9Meel54Alan4jzcgvsq83lRjZk66y
 K1SKYq6EIofk7YNn3/Vg/QYzWEGqBVklE72J7nSChw+vck5BTV4Mj3URDPUEjBGJjy5A
 ZlQryR45fzEyf58pMf+VEXMCThBZNYs1c/wknZv5nK210ZM7ksjIfXbu2OibSlbzbZbE
 /h5USNNmDgJRI3CxDwaIvGN1kRAO70GjWc2SlzpiEruKdufSlC+EvKZbx3FdAGQLcL4f Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks4gyr1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 16:16:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAGD6eX014924;
        Thu, 10 Nov 2022 16:14:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctfbysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 16:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj97CCGyuxN1ZVxXUuGfQyv3n5NEioavhKm/7vB/DESPG2OmK+3HUDQCqaCJUSFaHm0M1dx5vERZzxFUB4zUVUbYljmkqZUYD3gHmTkt1SWqrBhyBBJxVDUbIXzuZXnHBOU8TYeJQfE8eufaFPPHwTV2ZeQqdxrjI+wsij+hfHqHBOI+3yLnHTmHW0j2PFimZgOSnpYGzi1C37db76rxFaJfjUO0BYR4xGvPt8Bb7emTOOTKXyFwjzIwzL/vpF+Mk4kMnGxYcJcqxUW0KZIY8TJxA5zwI2nohncz1A0q7uixhk6EO4iuDioo1jai+HuciEl6WJBBBpMIg/TBnF26Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTcFxQEKMuN2DBh/ob1gnrlpkhXzPm24I99i5SRKrAA=;
 b=EFnPKrWEkqg1IcVgh0gtUHK93kmq+lGlNUA/55VsNKlbLYRlVAqIqJaeY3/Ifm1rqCW5jh72A5ydBXh2bAuLEqORM33dCFrAdU6S6YOvGlAUjfmOGag+epRDfXrYrNcYhqnZE4qFzSwSLbcy/LUHlPehCAdBpW0RM5c8KBqKYseNcla9iIcNSNnpbY9iSrzRA0oPvLhZEkfBL7TTx9U6kcD1KhMVAUktJ4kBu1AdZGTEyJjKSYwR3fmabj1OgGIEu2JIfkVs6IFmSp7bMz5cRwmpuBsYMfprx/itO2xl6OzLXivnpImHwcyE5vh6zmMly0qsrQQKk/FufKLNMXgJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTcFxQEKMuN2DBh/ob1gnrlpkhXzPm24I99i5SRKrAA=;
 b=Il3pwJcj2BL+uOugyKrHsDn2iKI776LXbaBWKIZlodp1YQkN+InreFi9XWo8G6Gk2kBdYEHId55o6icKjaTBEyW3m+dm0AIJdXkL7MjDuzCTx+W0qTXFUP9SIuR34DhSiuvKdwoCV2Xm3fYFzZcdXDxWkGYcKUyUsOgfd+GXNls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 16:14:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 16:14:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] maple_tree: should get pivots boundary by type
Thread-Topic: [PATCH RFC] maple_tree: should get pivots boundary by type
Thread-Index: AQHY9NWT1J4wfyUtEEayLl5nEGbTbK44VUmA
Date:   Thu, 10 Nov 2022 16:14:31 +0000
Message-ID: <20221110161239.crapogyt7owdqd7y@revolver>
References: <20221110072459.23656-1-richard.weiyang@gmail.com>
In-Reply-To: <20221110072459.23656-1-richard.weiyang@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SA2PR10MB4796:EE_
x-ms-office365-filtering-correlation-id: a1f7b19e-75a2-43db-2777-08dac336a699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FsgnE8qws68q7yqU81ffdtbIOB1KYxhGJL1afGlj0M3T3ufTP8+ycBJ/RWxhMK+nxAQJZhfRP1Cu/ss8a4N1OXifpN6aF3vaVki4O8S636cihrqpnsZ4BFze6XdFJgA67MnHGdSMTzaDxeSL0q0y1oZENVFkyxi5x3lQqJTpA2GjWCtyJDjwCfyhXGwjolYEJ2C5mTKhLGJN8uJZ8qLIUu0T3LbOy0fN+ViN0ypu2JQRxenEmaLi9zfd8FlCkEsyGpWyYkxGxFzvVqonT9ZSO7wbtkQwLqvu9ZqeuPYFHgsPtv5Qd1lXG93PmglZsbJSIvuNAUbmuGlngzoq995Ein3yrYC/tuNZoIfmIqNB9usgO0vI8bRRF4U4WgCZ59ELqzTvaDoKkMB3pBq+uQlfUPPdbANdZmT5CYogW4dZggj5VAvTbWC65ayqhxJmZBXSElrGbIuuZReTndXGB4Xg2uBe6jsn5K4dK3q8UdX1h4RnzjeHEDkVCpTORs2K8VJEL9si9eibp4GQc5nIizzPjRtfqJtrXfcqukuotsjkqSoVMs9JsvKouVqnKHUIQpa5f+38J7lStRJ4s1zpkFrj3LHJBK5kn2cJtsEHJZEjQvudUrCJ6WLzSKPDdIDXsLMEGpxTRe5cSfPVBsOuRY3IAtEZ+wl5/dwVO6NxPH6Z/2qUiLXd9H3ERbpfLLsZdsrYdunk0vZqhCuNNp39nr67Rtz133BXsdPS6zHFX60hPRclBHrY06MgxTLshzLYCiHFZ7fASfzJLrmESw2CBHHQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(54906003)(8936002)(478600001)(5660300002)(86362001)(6916009)(66556008)(8676002)(76116006)(4326008)(26005)(66446008)(64756008)(66946007)(66476007)(6512007)(9686003)(91956017)(83380400001)(316002)(41300700001)(6486002)(33716001)(71200400001)(44832011)(38100700002)(2906002)(38070700005)(1076003)(6506007)(122000001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mnu3oW2hGEhegGJ4GRVtAa+XZknVVxYl50Wi3eMCi3vEmfkMRbSfb/cL84SC?=
 =?us-ascii?Q?gvzcPuH7fh6lXS73fvh0yKITZBMZ8ylHby+xRn34PS0j2zoRcOzYqJSNb8xz?=
 =?us-ascii?Q?9oJf1D7p2ePnY3JhY6s/Ro9hDm8QJy0Dh7qPrCGvBCayzIiSYvzy3s0Gi/F7?=
 =?us-ascii?Q?Kn1BIDxQ0b1f7VZkaKUVnX+njh+jWNjTYhZD2RKXZNAlyZQdrqxoluetv7Lk?=
 =?us-ascii?Q?jQnpnhavO2QeYWekWQwT6eMyIZjwTeHTDIoeWBfdzGPCOglrUJFcp5TvRyEo?=
 =?us-ascii?Q?pbvHN/hwdu+sMgQxhVhPsiU9Ljcu3X/OLQwerx7c3y/l4mxp8AuIGcPF68bL?=
 =?us-ascii?Q?eyHtAqLUsQipaQYIR9a+f2LodfYETkfvi65yywJ2dj8WIYDrdHIea2OTZXIc?=
 =?us-ascii?Q?sLiR0gmbKCcubDgaTSsaP89QNB/wZnUCSsJjVlHlF41Aq9tLNzkdp1RloM42?=
 =?us-ascii?Q?E3rVTp7/sxXc2QHdH5lGYaLymTtHGC4b5sl76auLWO9MbX8xnS6oxltI5fXf?=
 =?us-ascii?Q?R4D+nOIjnRUgM4C+suaKUCB1yQXnKQltk0gZZuISvhn3nNzMbv3ie92BPS/+?=
 =?us-ascii?Q?jj6mekSuV/FzSR0PxjeybfGEemIwbqD1WTNgW6BfuyYdJtnnn+nW1yZzRkRz?=
 =?us-ascii?Q?AdJ0Ra8fGmAZzv8koKe6Kn0jFoVSo9o9HwMmYJDBiyLo2ppE6M2B2JeG9tU3?=
 =?us-ascii?Q?r693dmTKp5jZzJZrqaMKiIebToZP7dONF+SABvvjv9tA8F1FHhUpZDQ8XWmd?=
 =?us-ascii?Q?a0sz3Ugr7lnZV+jiG24VztcoeZU3Kton5oaV4+d97TFUkKXGoSk+9QqO/uQV?=
 =?us-ascii?Q?b9UEl6rEv1Eihbasw9DL0WK5wUB8gcmhPyKY/DzLs4J/0Q0Wg/cwTIu5Uxk3?=
 =?us-ascii?Q?ZazBSK+SbW4zXUDIlHt0mQdSrfC07O+qXf14ZGQ1Y/L8zUz9iKwLLrTr4ZLy?=
 =?us-ascii?Q?Jb8/CxkCv70uETXPznA4d1h/4FIfvnXUDTNe1LJyZzlPFpkLKt4XGA4i/qsI?=
 =?us-ascii?Q?ttq09L/quMHezTSWFralM2yBERmt8m3WKBp+eSpHI6zlsd5WxmyodJfE/wmT?=
 =?us-ascii?Q?eWD89otxqI+yRDhYjCZKGW2c42TCaLHs7Gm0WuoUHwf/c/i6AV6X7IsSIgpp?=
 =?us-ascii?Q?gcUE+UiSInDlDD9TIrLxIsdS14Kz0uINX9RVNLkvxp9iEmf45Gcrnw+uWQCe?=
 =?us-ascii?Q?+x+zl5hX5u8Ilt6qCXeM6bxgWWr1YniyjZ5YHhkcwZHN8+MzfA26vJFawOOU?=
 =?us-ascii?Q?zxHPfcFQX12s7mvZLx5QzrUHf3Jw7axcSliY9icztGV0/NkGnjm4KtV1lYZe?=
 =?us-ascii?Q?hYuV56C2sSPE1p4QTaPEKDZ9VxaEQt92CTlVoQ8jWCkB/qPNuw1s1xYsND0k?=
 =?us-ascii?Q?XEby5srluMYUwM6XBTercgUzb1anvmAr/QGu2U8OEuiiG2TGYqKbxMypj33i?=
 =?us-ascii?Q?gAdEp+6uG8dad83OzsNl9L6qZuV1d1+uGB/Qa2FpSauIKSYtwxIHwxa6UE8B?=
 =?us-ascii?Q?09Haeime0Kfo+jKTzYgIo7hcAIc380HXa3rNpLYtgHxCy647XzpoB5CN+QNW?=
 =?us-ascii?Q?IjijJ7Fbhb9oix1PHVKTM8pkjMe25cX9CyN9RK+Qx6DV2IH7jlU0/LHoDzOv?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64A62F2FC8624249A2101EED5FF728EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f7b19e-75a2-43db-2777-08dac336a699
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 16:14:31.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6xHFeFnfmMQnWRMKgMF1by2dILl5GuYM/5bvqlp3piy3Z6y9jLr4p78ukSEdrt38I8TMoEBFNuVziFYED3hKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100113
X-Proofpoint-GUID: uILxnsrGhej6TToVuRTconkDWWl2MLMe
X-Proofpoint-ORIG-GUID: uILxnsrGhej6TToVuRTconkDWWl2MLMe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wei Yang <richard.weiyang@gmail.com> [221110 02:25]:
> If my understanding is correct, we should get pivots boundary by type.
>=20

Thank you, yes - you are correct.  This is a bug, and should have:

Fixes: 54a611b60590 (Maple Tree: add new data structure)

Please fix your commit message and add the fixes line and resend.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> ---
> * kernel build looks good
> ---
>  lib/maple_tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 73e2e6434e2f..2123d1930a9b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct =
maple_enode *mn,
>  				 unsigned char piv)
>  {
>  	struct maple_node *node =3D mte_to_node(mn);
> +	enum maple_type type =3D mte_node_type(mn);
> =20
> -	if (piv >=3D mt_pivots[piv]) {
> +	if (piv >=3D mt_pivots[type]) {
>  		WARN_ON(1);
>  		return 0;
>  	}
> -	switch (mte_node_type(mn)) {
> +	switch (type) {
>  	case maple_arange_64:
>  		return node->ma64.pivot[piv];
>  	case maple_range_64:
> --=20
> 2.33.1
> =
