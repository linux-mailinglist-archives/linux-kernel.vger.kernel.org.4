Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB3629C24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKOOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKOObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:31:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD93BF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:31:23 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFDmPco016588;
        Tue, 15 Nov 2022 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sBEHXI/9ShxX+UvwwSA9U2H6aOFQrnExKRcQnTH3SDw=;
 b=hl3qya7ekOmt06T3ERL5Iny3xD+VfjA9ui29R+V0yG5wPwcUQGuQP69r6xDrl+ytthIP
 zuiRMDq4qpjuHB5cOSUyYK4d/Xs1YYahgeprocIGH5tf6dgRp+PMlIKgSWU1MfcW59y/
 /B+h2dZUe+5K/kFjS3uvJm8OPRciE6gdi4DWlGQ3r+Nw1tIwRGFynULbn50qHsGcE1F7
 MYAScWUmDXydKru6E1vbzKVIgZh3jDKZ2KHrZ0TMt8blgebaDq51cwumCiHKbDNqfVS3
 nn1lT+8cBjOEWsW+H3neMtnOUpejr63XVA6RgHZaDJVDcNu+zjHPpR9q8Khe/TdX1TfU uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykgps0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:31:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFDSi2L010251;
        Tue, 15 Nov 2022 14:31:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xc4fx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHtYP6yjL9D/wKJg+eqKkC3MHNhX5xVxkwIZrDtMb698NTcPJRByDGsOdYmfLWNsPcDUVi/6580qpNAIIoWiKVLEhn1ibs5S/zuROC52sfRcRGgUyc2s3FhdJRWQLqKGC4uYaRp6Ol2XCMWCstBwGaG22B3GT0e+ps1CuOQkGDqUjaezoSbL2ejq5LkaqipbL6XHZSEUb45g21sBH4U2OqMZEmqomHxB1XFblPDxPXGu7Qyzn79Gj3rMpQ9DJSQYfXWK89v+M48pmuSpabcsg9gXc7Lr82g3wdJ6OLfLlhimlifRG76amTDSewC72P/rm6hrtKL0oFzi64RCbopgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBEHXI/9ShxX+UvwwSA9U2H6aOFQrnExKRcQnTH3SDw=;
 b=NoF5sZX9WpF6IyLPQCtOdzsMNq+3eW02TrxizL/K9ReLWya263xodwAnKLejZ+0MOloCsutlAI1kihfflU2ymP1OrBSF9zPTFAKlJlUeJmtGI6oS7G9xe43OxqClFJEwYw6N4jfZzvj3Jpa7aI1TmypUMg2JmweTIZPygcSggIn8+5lcRC/P7TUUFejWvKcHM8d04sgVqS4tu5UidvNt+ERhnpX+g3goGamsK08vOp/OTcRYZPek7imRZlfmXhL1m1391GDV4ClBbGDfHto/fy+E8GdxWe2ZGUYWZfldnK94KvwYJoN38Lf/0SFyA0zU6IJQp9Hwlt5KHsUxAHSaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBEHXI/9ShxX+UvwwSA9U2H6aOFQrnExKRcQnTH3SDw=;
 b=iolbX7xh58I2Ft9HC2pn0pZBCmkFUs1UVCgRJksnaCLf1oe5ihQUvcUK80GU5PZd5BgyaF1LXzaGnY5Q/VDA+44+iq7KS5K0wjR4OcCd1bXyGtHlyXcpy8B+teBLNlDBRxp1TfLPgwfsSvtlosJ/aZn2sjmIb9YFQCiUtq/qv6E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 14:31:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:31:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT
 since it is not a root
Thread-Topic: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT
 since it is not a root
Thread-Index: AQHY9vrPxktSaU9LZEKczgR5mXVsla5AD08A
Date:   Tue, 15 Nov 2022 14:31:15 +0000
Message-ID: <20221115142914.x6d2q3qz4xurikrq@revolver>
References: <20221113005618.29679-1-richard.weiyang@gmail.com>
In-Reply-To: <20221113005618.29679-1-richard.weiyang@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB5141:EE_
x-ms-office365-filtering-correlation-id: 5d639dd5-60c2-44ed-314d-08dac7160d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ly96/kn2MBpDclGpSC3LSOQ0tqVSp9NGqKEAgzHEOGFn/NfuautRPuoCRP+6ZIvamkYFTMdM0EW3BIRTI+XQggyodaTXg7f5HUKHjllC2OO12jEUdd5owhOTEQqCl9QiD8MvM1qjnHFjQdl0CZ3huGAT29U/pwHoYFigbYsaGRZ2W4Hieoa6yMKMP16pJpgKEmIvFfhfZo1rsxxhPiHfi7V3dsisNjUORthoYbOyd4sver5rp7uQrjndzQvOw7KHeYAjbm9yUxC69PQ6E5V2v4sbGYbmK1m/60xfkG404fPoOBHc786mO6rqdUJ60oSl3+wOFe9UOU0z6feVLYZtUJMFm0mY0L5dFJnjshmXZZMwErRtWHPcKW/8HY7gaLAPZuz6LIIhi+QdaKRSy76NZoq1dlXfUnq/Prt4n/5PA0yz/DhY2KkKEj2a+dNPg3yH0oeF4km3LX5khDDKwyp3Rc9zyJGXY1fNU4SyYOM7Hxyhs+Z42xUHKWqD1OXFa63xmLInGG+BtNBkQkOdImtSoPyEGls6FD+3ADXI+HJMFDCg6AlQS29hVPELT+c+WjkNmoJTSkYG9mz5JZo+eXlJSwUfovqELGL0/zUVZeHAGu/7lPAhvAYj058dXUAcW2htYeW/GMK6HoJ4muwua6qjZhX3WEQ8Ejoj2+8FJ6DQB9SjS0O5R5YMzMZaSR8fYfocDtd1FN3V3yFa5jtXjkjYQsQo0mPAJ50X4sOiS5gePWxBL5sTxaaW9CnUaWHarB0kBfQt1lYMa0G2QKQtvzZMFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(186003)(33716001)(1076003)(6512007)(316002)(38100700002)(9686003)(83380400001)(44832011)(86362001)(5660300002)(8936002)(26005)(41300700001)(122000001)(2906002)(71200400001)(478600001)(6486002)(38070700005)(66476007)(66556008)(6916009)(91956017)(66946007)(76116006)(64756008)(8676002)(4326008)(54906003)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rFHFz0r5xustq3iGdNBuC0gt42tJHR78XsKxjKfcYwB2h4wtsxZ14jWTXTkK?=
 =?us-ascii?Q?ALsjnNcHlGAb1E7oBkpfL8G/jYGA8T7NeFmmiP9y3G3zQFK0f6DeQ+StRHkU?=
 =?us-ascii?Q?L41pwKL7i00770NJKcNbRfKohd6Hkvgy3BuL7LZ3PQDNBgWw0w+4MMqY/7nx?=
 =?us-ascii?Q?caNgNgxc4o/SusIn8MHVvhiS9UKwDWZak08OQXi+r8gFjPKXm54VUCfdrMsd?=
 =?us-ascii?Q?ji91X3uo44HQdFZaW9xVkIb4A5PyPyiEw/vBcVM2ckg5ahDEv7OqiIPae/Xz?=
 =?us-ascii?Q?JvBE3u8luOHAi18ODtzBB8ja7ZsYI1cDOPNywKOKnqRECEmzoZQa2FnPZxM+?=
 =?us-ascii?Q?qLIIBZOCp8hMDw5DH41afiBG7z6An/rJsBmxIPzEpKvVkjkXzjJ1L4zleYDS?=
 =?us-ascii?Q?g5lUVfvw1onGhV+aiZx+mVaVXFzRlt3uVrwQz1cZOdjjZrlC1v/aS+t9m4kC?=
 =?us-ascii?Q?Cln9XCOEzkFvTF/pacVr3A6Nbm4231sP20dyO6j+BxhlQnueKVOsQGTqbxcx?=
 =?us-ascii?Q?L5NlZg45q9rDiXwRgGyTBkSh6QyK5HI6Hm9c9Ax4xMSzmDldzDc9/SIPI5aw?=
 =?us-ascii?Q?DwYYpopuMry5NqKzKpQRThdF3QbsPgEXqTABZntIQv1DBjuhk1T8WhcWmQu0?=
 =?us-ascii?Q?Ch99xoLz6DRHjmH/TE2So37aHvNS+0MGi++UDi0lSlKwWAO38er/V8rM1gYm?=
 =?us-ascii?Q?dGyKe8SFWZ4ks04hqxnQnXgXLQWWGGdhRuNbmDaGspUdvgAJvmOqRzylJQt3?=
 =?us-ascii?Q?231P6D9u7mGzze5XI0i76SWIpy9aBnh1Ls1Vz+g3P+rsIKcxlvO1Z4OYaZaz?=
 =?us-ascii?Q?1SL0Gj2Dpmgrl1ha7/lpxqyVAy5SXpSo8vYa3n1Fhby4zBGDYMZMIR2C/MZP?=
 =?us-ascii?Q?RrR6pAGWLj2DG/shzZ00klxCowoK8g17vmikiqp/BuSr9US4RtShBMxB6LGH?=
 =?us-ascii?Q?ISUFtIimJ96kZ/oEc52rg7iR7da7sKCjqu8ZR9JJPGjdLUb0KwkFez2/Av4D?=
 =?us-ascii?Q?E7woc2MfortwE4NkzHpdvOoPqBJgSIg//aLpHH7KfbQaap/2F8LgAoa+e9x1?=
 =?us-ascii?Q?dnKAwNFMk3QtkgUqGI42C50C6C/O5VnXL8L/d4yh/oCxsV7Gcr/Sd6oLyWKl?=
 =?us-ascii?Q?XZsgPmAejFzYGddnOcuK/gCZk4/aeEj9VxWo8Vy2Z1hUqlhCIZE730rK2++1?=
 =?us-ascii?Q?aPEkxAOASCLJogm4Sfxssw+/OvEjQ7olSdk0hPwDo6XQJbobCseaBou6tBaV?=
 =?us-ascii?Q?oawFfS7iJ0y0w+tGbWcz/+ZxzGRzvd7+37OahmhC3vuNgAvGmPEzYix7ii6L?=
 =?us-ascii?Q?cIh8ZzKLwKq0RCP/1uUxnUuyUxrQaxQaHH99+sjx1hvQBnL5mXHqaMsMydbk?=
 =?us-ascii?Q?ZgnBCn/JTvlgtCDSORzhuD0kHSIioZ6zx9TCOhtEIDWJJ4iI4EdaVS++nmYr?=
 =?us-ascii?Q?1tHfhTz89TdC9XFvZ3k6x+cCDvcIK6t20jduHLdveEsP33ACs79WePfa4b89?=
 =?us-ascii?Q?ToqTkdIOc9PWuwha2xB4AGXDVEt2OUcECBLV4RdN1mRL5Msqbu6TdT+9WTA/?=
 =?us-ascii?Q?zakzUbVGM/9Imn8bvZmNpiv65QUSKML7CngMyezNrY+rXYKLm9tC4x9Ew+gD?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E195313E735DE43917AD6CE1D871F56@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /kubVxSFc+jXrmm+XBU3YJiICwazQ6qdXwufNxhEArrMWBFtzeTRZ2EkXFGEBNTkg1U/o6chsVyTGsXSkM6iSWwB9okrEOg4ak1dQByWBTn8lLKO8VbGU7qiTz1Ux4gztR+R8F7dhdNz1v1pgmktSRzufjsrRg5KeVfiNK5Kp/ZWxpEFh1IbLNRvp+vOGcekbQj9cfM9HqaNu0qA7+goiy+ZhzX/FOi642SoN2Kf529tjCa/VaVCgB7bHNl4Mag4945TvIKw2TwtFrBzDmzFRd3k64yeQGlTTlCVAnnNJ/F1q7OUOK0vKNedmrIek61Q40viylopIBr8EMQtOl2+NwrQpAQ7brBXvw7mqbk9Wqky01a/nibNy08g4JqqRDvtIU47e8yg+8Ksgqyn5oEz6fmhpg/7hk7ZmrcT1V1rgUHgTyj28Uu0cUNua5DgySxdSHmKdT1UJ92ASH1fZntpU1blW0ql7+yHZACV9wNYgL1VF0NiuqoEoPFFWbdr+OgtLs+ePSzLooRNhEkHTNNmxtUV1+jjPyfTtUC1OZhMxKKXJBE8ALdwV49Oqay1lvE+3RUOLwxecUD2et90XqYnMMG+0xP7KudGSxFTEDIgoQz7uouDIIGZWx5YGJUfjKF1K5JUb+N7F66FG8FLbDzRg+dnJ01RlKk/8CJRFx4yMfiDlLn1FGYUhA+cfmfZe8FwOqCTCBF8m9aCOtnUrygwuSSyVQdPt6A/kZT0T5QJpv8bq6mG4yoFtNjwg77R/CSsu/4duZPYW9zREmhHAR56htDwkO7mPF8ZgYzG5U6FN7cBOK/a+rOJI4kv5jaiP89w
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d639dd5-60c2-44ed-314d-08dac7160d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:31:15.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0srg1CVtGtjBaTq+gkO6NZMY8wmA8U4zaHj7h1d8QGJYoMZhYHHPxFtzMHDDi7r2th2vw1tcfxRq23QiXyzqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=990 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150097
X-Proofpoint-GUID: v6UvQFXhkP33VKRiPGyA8FswB0TT6jOr
X-Proofpoint-ORIG-GUID: v6UvQFXhkP33VKRiPGyA8FswB0TT6jOr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wei Yang <richard.weiyang@gmail.com> [221112 19:56]:
> Root node is return at the beginning, so we are sure bit 0 is not set.
>=20
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 9aad98c24f3e..f8c4755e7c75 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -436,7 +436,7 @@ enum maple_type mte_parent_enum(struct maple_enode *p=
_enode,
>  		return 0; /* Validated in the caller. */
> =20
>  	p_type &=3D MAPLE_NODE_MASK;
> -	p_type =3D p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type))=
;
> +	p_type =3D p_type & ~mte_parent_slot_mask(p_type);

I think there is a larger cleanup that can be done here.  It looks like
mte_parent_enum() is called from one location and that location is a
wrapper.

The check for the root bit should also probably trigger a WARN_ON() and
still return 0.  I don't think the callers are doing enough to validate
it - although they should never reach this function with a root node.
And, in fact, I am not doing enough in the test code since I didn't
guard this correctly in the verification of the parent slot before
calling this function.

Thanks for pointing this out.  I will send out a patch to clean this up
shortly.

> =20
>  	switch (p_type) {
>  	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
> --=20
> 2.33.1
> =
