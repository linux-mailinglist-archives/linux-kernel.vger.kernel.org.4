Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59B629CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKOO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKOO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:56:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9678F593
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:56:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFDxFZ8008998;
        Tue, 15 Nov 2022 14:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KBvKxpx/x7mzxcinGKIpkfy1XzIP/2D8DAGS9eH8xsM=;
 b=tXAfuEcONOCuGJix2jOoNOWLRxAljrkEcUrweryJ//vqp80SYONTqPw/S/PAqbCGOGwh
 MlAtw8Zwjs5F9GvcfqHaOQNE9C6BwmyUmbADtsFG0YxYxqz5jAbVrvUklngigy9ya7ef
 asJqZCz4og0kTlu48s+hisgm31evuJYSAvuI/YhcTsqjy+tR2yhhzoQxfOFsJlqpikOb
 zQ6GLqRhDfTT/MEisg42c1xsQzWShfHWFn6etS9dO/Ni9DUT2WK9Ec5hlqeQQW/OLh2X
 C0mA2uDtQ+zR3X3YB8EOcdX2u82WzsvxUUY4X9doqxa64pGryXJLtHsK0iWAGqfNqkjl Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jshm9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:56:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFDUHKK010229;
        Tue, 15 Nov 2022 14:56:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xc5k0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVRzPTcNHWlMqp2rpwfoSgs855MP5RiGIs3dEA1PV4mfJ1Y9BPtM8FN1ruMm5Ioo3cqoByGCORncVuNLwv3SdWgnCgq5WgO3c7x9pRreAB67/hriHmiRIL6pPn2QTTSlOj7ZrODscqxgsoVLFeaYXiYKETllxJp3jlsyUnNaswzAS7Sy6Sgp1GFWjbvL9paCMucEORjJAYnET3aBNsSpC52kqtewX12R31YffNPGzNa0v2HKER1mRa+aGnl6cal0+6keInphBZQ2ohnZLU4pLLRWJPJr+Dg7g6foJfGdz7REaIJ9yZTUA6izApVJQLjHArm3ohxaeN0lZHSAnqm9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBvKxpx/x7mzxcinGKIpkfy1XzIP/2D8DAGS9eH8xsM=;
 b=VRHKH1vH2gjxev8DLrzSByERKTLUcSpSG91YZELypppvYf8JzEetlo/mUGS+j9K6GJT7dkD3wBUhe//8C0f00MHioD3WI9x/8QmV4FOlOFKQBcQv0Hi7hct9Z5uiKXifuv7sLDVDvHAYv1QaB09tqr27Q1fFVLGwwubBVmkY2h8h2FsIKFvinVbZY9jfKzuNxoZk1UDEzK32iBPPBN00YV9Qizxo3V9SZwKID/8KGiVPD1t4aPJiGkkBYqfA/gYshzKQLXEaoSftFaXbrIUEJtpSS6KHFduWRTt00w2iDVNlEzTC4ckpu9dwSzc/koJrKjwe6AbO/nHfmduiFsOAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBvKxpx/x7mzxcinGKIpkfy1XzIP/2D8DAGS9eH8xsM=;
 b=y5pA+fD4eBp7QpjSMNPvoah6qq+VgVNk9oncpPUni8uWX8T7Gq+W5GlaS/xwIjMZ1Yof3EwnNSK6vzTasJaPxrs+j7Ujsx8J4qoURwwb294xY4yBni/ePXKsC4/dQVn/giOkG2SPY2grv87I8yUeb7IfvpqWbmS+OQ9o/JvL46w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 14:56:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:56:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Wei Yang <richard.weiyang@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT
 since it is not a root
Thread-Topic: [PATCH] maple_tree: not necessary to filter MAPLE_PARENT_ROOT
 since it is not a root
Thread-Index: AQHY9vrPxktSaU9LZEKczgR5mXVsla5AD08AgAAHioA=
Date:   Tue, 15 Nov 2022 14:56:20 +0000
Message-ID: <20221115145613.6wheb3gnsvparvki@revolver>
References: <20221113005618.29679-1-richard.weiyang@gmail.com>
 <20221115142914.x6d2q3qz4xurikrq@revolver>
In-Reply-To: <20221115142914.x6d2q3qz4xurikrq@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB5154:EE_
x-ms-office365-filtering-correlation-id: a461b07b-d87d-46c1-7384-08dac7198e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJTU7u2sNOz4z1+Po6BXMHVgDspsRgHaCNjHVdtAUI+t0oe1fL0TmRzHBNp8D7+rxldE78ItqQNaqNN9YIh8sxYQAbUXRGABB5ZF530iPGWvGSnIEpQTyfyq+SskPgdhRwLipHhk6a1yXi5EflJAey+ike+C7dcq67LRYtgQR8hrgHgXhN05UnBcQruKbsYDDdMYC8sw/HxA0Il+tC9Rtt8J0jvblPsZA20EggxPx88xk85Psg/FFFmeT8/TbDVbfMkwr02dFM3FqLgg+h/ZnrVCz/SQOd+Lz/ZcnrsDxM23afPlCDAysbbL/0pMTm22NTQtqyZ9rUcw0FZqqSrz9g0jlC2woyqpcnKNxXMzLzCV9ArUz8Y3anzZIohk9ueoejx1ZcXOVx1hWn8ThIYDp1ZiZrsKOvTOyDqofhg+F9Uu9zd3qnzDXicT7ZUSXVXdhJriktGRMLAZmrlgEHHy+pbHHbCJCptB71APlH4ClGKSERtbrIlv66p5TfmlP24dKM/DxjR7r/q0/PcOunwtvYgYwkMAinokTO1s7fWK+WnSTOANC0gGdvmr1rQ1clq5rgxKy+V9ufsRMKnd/gsBbw5fKdei8+o3o9sZj77Xf6/Jo5LjRGnUb51iOMu8ZhCpwjiv26++xw4b2koOMm2d85HCiTkIQcupveC41VWIGiZM/v3xwzyhVixI2xL8GRlBDNWmeQI8LRP6XwyGuItN72ZuXZLIrbMOAy6BGII7AgvWNKQV5V+MCZwpc2keTcx43Mp0Kpy2TDYYbzuFIEOWog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(38070700005)(86362001)(83380400001)(5660300002)(2906002)(44832011)(1076003)(9686003)(26005)(186003)(6512007)(6506007)(38100700002)(122000001)(76116006)(91956017)(66946007)(71200400001)(110136005)(33716001)(64756008)(6486002)(66446008)(316002)(66556008)(8936002)(66476007)(8676002)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdPLnl46NwZxcA+wGkfkEd2p1KCvZ6/wLRKTxnby2pojl05Z/Iy/0wJwD+fT?=
 =?us-ascii?Q?0C1Ohf9lz93fXrQupFoQZIjsFEyr0N4dVrUgxAzTEF5Fxze8xFqoDRK4UpsL?=
 =?us-ascii?Q?kb7ujBQ2b27Vanvp4Ty5WsNHSkXA6Wz819JM4W4I1ipwVH5qdguHAaDZDBV+?=
 =?us-ascii?Q?DHFHKM/2nByg3GO+WJ/tBbp09q4jx7cwGl4kqCcSQq5m8JRJl73+aQHwRw8/?=
 =?us-ascii?Q?nSjp19kCHCEMKCk3Ua6pFzMRIlyjn62bCDEZMvAR5TM+8XX7SBihyzpJXGuj?=
 =?us-ascii?Q?Sh2lQ9ITXEo5FFfDjlm6H3W9315jog8f3ctQjAvz7VoziUAd0qsGEyovN/3R?=
 =?us-ascii?Q?ZGVIlfHWA8Waqqdl4nVFnTERSq7rMapDYekVAZfQz7WJteCZJ0WmxMYLjbyv?=
 =?us-ascii?Q?IESJJQxpn+9mvWAIiCJPwWH2PTzmWwliajOQFrEyK7y2msoVfuWIQaxJlM0v?=
 =?us-ascii?Q?smn9mxRTinmEidzQM4cQgRQ0DxQr5rZrrENfxY51jAOffa8WiPPA2fDs3uFT?=
 =?us-ascii?Q?Vz0EXX/cSTkuDm73ZBwJI23Grl6xU8QnvE9DFqTmb4KsUqAieHdpMwgiUIuE?=
 =?us-ascii?Q?YRfckts4Fw9h5SuDOfFIbDig5ZKX1SpLJ7QapIpViGq3BYqaieYc+G/I+Rtn?=
 =?us-ascii?Q?Flqa8WvIdZ2xD997pw53F2Uvne/BIqwAExdPIq4twL6GNs8U6CrnS+Fo+LTz?=
 =?us-ascii?Q?oLGYTxXasRrcSCYqQOjclh3OXIrzuAvl4B99bof+gJIL9vf9Sc6S5e/nbP2e?=
 =?us-ascii?Q?pHWR/WmbkP9ifBK5nL/s8kKhIJfykxyrUA5bbNSehxWZNR9rwpaVzCUqrMVb?=
 =?us-ascii?Q?on9mrTObDB0qd7lPOUu72Bsk4buLAdfWeE+aOeFqJpsxdrBQOqOZ/hQskjV7?=
 =?us-ascii?Q?zZoT81USnRLlLQGtGvdid9SdLZbTEZKP2IBpoe/ZjXCgprYFnux7nTSVKAlM?=
 =?us-ascii?Q?r7I4/1qCWZe5Axnzkm1Kz2vu+igPfrtntx2bf+2W0rEbdokAmixqyOfhMdD1?=
 =?us-ascii?Q?cg4SG2/eK5JUdF4/D9+J0suUDI2j68JZ2SdCcUkBgQ/TDt93BpMHewWYfG2r?=
 =?us-ascii?Q?YlcidTy7/SAAp8owrRpncliyMHZDP4vmh7Koqb8Y69lDP1+LNppyzwsUYTv3?=
 =?us-ascii?Q?baHY2rvWvGqZFZazvFP/Nj1whZJcYf1MtTNoi0QPBiY6UDkuAnQ8IE5sXF+M?=
 =?us-ascii?Q?hogkPFISMKrugKWykJt8sFBz2sogLd8nJ6fMJtDxmOVfu2kjikZLqnRKFnJP?=
 =?us-ascii?Q?19zn92oJh8UchW0ehbTVTdgOIxubLFfhMbJtVbhPFhB5MBz/kKfja7WRBFch?=
 =?us-ascii?Q?NYGHQB2gVmw1x/DwVZuc7j2FpOOUih3zHxHWpCFY9dSo20x6DLa2k2w8kBJ9?=
 =?us-ascii?Q?C5xvQur0SQDuvR8REvkDisGKyKIRLUoLsDf9Iq4LUEyn3QhVn62rLh/D1wZy?=
 =?us-ascii?Q?SURBXrJyhwJZl3+tvmvfHh0QuNPeHwfZQRlTj25/yTAt7Y9gUiwvaCz2n+45?=
 =?us-ascii?Q?toHcLi7yGY0zancYNCy4wEbcAMUeVnHmKZ5Yxm1gzyNwZLXYfDySvAIEM9TA?=
 =?us-ascii?Q?HrP8/rDVcqwFvWy4q7c5Sz2fWlVFCILE9WeJx9njobTOm4Lku2vBG3NGWam6?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1583AF6F938284B9D263C6AB4BEFC2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WKAST/5p/aP6OjoOWT7n8V9YbUt9abMpBYtbP7+vKH0zP6DOFGYpjzCz2/rfMZD06+hr/iTPr8Xpz76rtFYCyicnjrFtP4frH3mnKOwaOENw1hv4ij+DiNaqo2RcBJnvxAo0mwXKkNApCi0pjaWGiUAyfcgGWgz/HT/+PojOe3tTGH155Bl3gt5iuEPZ3CBtm1s2SIF6oT8OmaDs0GgaXceeV2yGThIrhBYJ+VQCbqOAv0O9bvo9yvb+TwTjms3Kg++QcqmdCV5/1dq9YONEMjWeUP4mXFWrQ5lzN6OnC2mAXwf68TCaWYtcCHrDyK+ocsgQYuvbmAkWHTQDEg3MyswsSjejwG/hpjp5J5dSiWxrKsmgKxAqpmb/Q1IHAwpubl3ghOVLj3b6ww9OSxs+gTUCyrP5XBvO943BW9WYcAMhrMdb6NVKxJV0prDAOJWJgLb6rvV7jp/xMovl01Hd6iUc2bm5XjmXa5wiJC2cfG5bHNMMpknhjaIHtuSNqemVnKT90n6NUYt2TbSUAETTUpQqC+S+SQbQvNDpWanId8L8cnGt+QYeRM4bt+dy4k+cLumUw3gqIZC3jJLmhXpkjF5QWICQU3I/sO//4F2GojlqQaO9GIJz7vEka+EBRfC2Z6gFLT9aSgQzjfRAxv6GI3dQVApUo6/lQMKEdY3OyW7e93GbhTAjGqY3t4tB5Ra+P9Gl/Q9URWQUC04i681WLL6tLyAYgdjHFwgcMuJWX4EB7WHGiczHFxpTq9z3JqlJzgJ12UAkoeuf3m/RqRXrD60R19i5tU1fpjGzmlCwnKhn16+WRC5f86KxaojkkN07
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a461b07b-d87d-46c1-7384-08dac7198e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:56:20.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXwZmqVMNr4+pg838OAlWBjFzHF7fR9oNWgSLzsvtVRMnFjzTGe7XATH/o+80dmHcG9AkqqKyx6EtuwN0v5L3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150100
X-Proofpoint-ORIG-GUID: 3KVoowWOxc2eQUr_xAbhLIrjAKkAeZec
X-Proofpoint-GUID: 3KVoowWOxc2eQUr_xAbhLIrjAKkAeZec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [221115 09:29]:
> * Wei Yang <richard.weiyang@gmail.com> [221112 19:56]:
> > Root node is return at the beginning, so we are sure bit 0 is not set.
> >=20
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  lib/maple_tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 9aad98c24f3e..f8c4755e7c75 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -436,7 +436,7 @@ enum maple_type mte_parent_enum(struct maple_enode =
*p_enode,
> >  		return 0; /* Validated in the caller. */
> > =20
> >  	p_type &=3D MAPLE_NODE_MASK;
> > -	p_type =3D p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type=
));
> > +	p_type =3D p_type & ~mte_parent_slot_mask(p_type);
>=20
> I think there is a larger cleanup that can be done here.  It looks like
> mte_parent_enum() is called from one location and that location is a
> wrapper.
>=20
> The check for the root bit should also probably trigger a WARN_ON() and
> still return 0.  I don't think the callers are doing enough to validate
> it - although they should never reach this function with a root node.
> And, in fact, I am not doing enough in the test code since I didn't
> guard this correctly in the verification of the parent slot before
> calling this function.
>=20
> Thanks for pointing this out.  I will send out a patch to clean this up
> shortly.

On second thought, I will hold off for the 6.2 merge window for this to
go upstream.

Thanks,
Liam=
