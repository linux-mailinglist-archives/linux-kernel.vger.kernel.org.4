Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C565F444
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjAETS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjAETQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE340F00C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT0gm017286;
        Thu, 5 Jan 2023 19:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t1VE+uP0jqC3jOm7XpSKuCal+vp1A9FT1kzszqwq+lA=;
 b=3IyfxdvICNGw0MOANOY6drWtKh+zEhc12aSodEu1uE+4OGf3/eVJGIRErgoY3pwyd6Ud
 JHhva+pHmZxsxe/ORcdBiWeWzGkidAlueZbkHbIvl2YHMW1mZNV+o/c4dgCD2AEMhI8r
 2yYXTi8dvkcbqp74ne/fVFk5GIUJ9QuY7qq4OwvdZGl8Z/6GxEZWbkOcnlZFNDXiPYDV
 hGz08neTKRT49b0SNMcMH9pfarqbCu/HXSUjRPrSPtzJ4hnR3OrcbboE9uTALI6M8rtj
 EfvdCvWAyRdwvcUKGNPdCiPNkh73R2furGbdMN1rIlM94LhHGDwpMi69BiDZt1E3Ir62 SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv31nsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKc033879;
        Thu, 5 Jan 2023 19:16:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPnpavZrNiZzmYaqDOhIzDTSWMqwfRy7Yd95g+zjfpJQch3p4/u8kqatA31xHMhzJrZzuWAetKrD7FckDZCKLwzXr2MuecCUOg4QyaHbFAxpBeIUG1itx/wVCzBvetstmno3uScQy4h9ptPno3wHe/ofng/+l61O/hWovr58Y56m5U70BpUnFMQw1/pPFG2l3srOw/nCIStuGqLjm3mx9GpXhdEmnIgv0tKg6bXFNkjqAwdtbgfyC3NQiGt+zXEJqHcN7bOHhcz3ad22edcNbR6OaZbFs4zb/wH54ykb8DhvGajzVkP0bSqF/vU+huf2yftq1bdNSCKlgs2W1FIocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1VE+uP0jqC3jOm7XpSKuCal+vp1A9FT1kzszqwq+lA=;
 b=NpCaJFKrl1mjNblsy9sfr6wZv7KRpvNuqrniexAdaSESTDDCWrXGuq81eas38utj8z/QJk5Z132nTZFUnQ75hbJWazX+5LnFsLl1WEFBGPRP/eoXAs45ryrp0g0IgGTSWRTHOvnKDjaHgAbcfSgX5Jwu6rLj07jhcJ76vmuAocbqAAI332xY59yL/MyBKBzVPomju9xOKf+8Cc5SCdpELg02l32KjdoN4GRA60V/fIEcurfd6GWWgy0lN4/yOLo4uam1VS9nWCHvL4LklOd3kmsVbXYoI0mXsW5dwmzyutpQY7Mo1RwaIaEr9Apq0v7mOuVEtwhPTlR1vjGK9IGwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1VE+uP0jqC3jOm7XpSKuCal+vp1A9FT1kzszqwq+lA=;
 b=UNrgVQ5t+xXl5Ot9SUcza+KrDqW1cvGeNI2DZGNNbjCMcSazFhPJptgNSF4FFyNz45S9pF55LI6pfz30aW6NFEkUDEET6aYLSTD/tHP6JaVoBxkMRTKot4e1RMLb4QwjGzpNypDMr1ZjrUrqaPtsmx2qpLgVr+5gTXn8HLSlTKE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 28/44] mm: Pass through vma iterator to __vma_adjust()
Thread-Topic: [PATCH v2 28/44] mm: Pass through vma iterator to __vma_adjust()
Thread-Index: AQHZITolvrlluW5nEEKNn1b7D+IWCQ==
Date:   Thu, 5 Jan 2023 19:16:01 +0000
Message-ID: <20230105191517.3099082-29-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 99e0722f-ade7-46c5-fea8-08daef514b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxtACwZf9DxZ0tqzD3OEDvnoMm63kHCA398KLcZcRkAesbG2o9R4Dz4NNuAm/NJYjN993yVHM5fyXY3A0XrBLuYFfF7FfamA8vJt6LO3AMfU0OqeyYTo5Tn1SsGoHhZEHSyeOSe3yXvK32nfWZtP3UtT9YjTYzVC9R+q9Ip7VKKZNxb0R3uMjgH6E9gb/I+dZEDXoITKJHTNdP9oNhgDrBc6ZkZWYfSHVgrKTqjCwRdFFLENadH1JcdfRhkd39xXUfoutWnJw5gCU+2+HGQKzpjyy8oz/RQ0WJ4FV1v7nkZi68pDFOyvw3dTTrQgh62WYhIBV1IB8Ir7Ovl4qmQJebSlFd8wA/OG3Ye3MzZOWP/6JFIXpAmoHvgO+8PWJNtRv5GYzD4Nd/OpbBkijg2GF2KrvwP/Xckk4iflCgSzHhwB0+sZ4DgwC9YIcw5kHEH53i93Z8S+fb/2qj0qIKbsXickKgfWB3DWGiFaTlBVhJ7kpi9mopczy5clcEb6LC48JXmybevPRJ00QXcCv2DewLLHKr3/SQbOreyu6WXRq2HJE5bVbCbl/vrnrK7Bccf3N9p1nS22PdEekoZ4hvDzeE+Y+5zZpic0W+a+mubPkUod9tj5PjD8/7IootIzTq8SKID4dLIdZH27wVsgxaMJ+6eoxp/xkedZcXlkj4xk7TGO9W8V2nF+D/GCOHpVAa76qtWY1xbIs1rxnkxdXBZtPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hsFKI+6x3AWw85kCJ3s/qJhviJS31gqszTinpvuFJ2xge+tP4Mc10zwoNz?=
 =?iso-8859-1?Q?dRqOGTYyHbQAIrMBGKGsTWxFwjZELHTY/0EaWDmfEsSc2hwHJs6htmIs0l?=
 =?iso-8859-1?Q?MJgyIfOjg54LM6MXSmjEwlNHZzKNk2FwxoRlp1CmFa06wYX9HMu1YuZF4k?=
 =?iso-8859-1?Q?L7DJkX4/xO/W8u1AgmrmKsKQTtTHWe5Wj/CGKufsqKsqSZqoX18t+jS5Yo?=
 =?iso-8859-1?Q?gIrHKUejq5WiBFR/Zj44UvXdL7mS1zsGMxNUSUbnTkeHbVI0Z3EZ673uSM?=
 =?iso-8859-1?Q?bcqUMfzDYqHc9ASjm1ccK6eDx6/o/dg1al4Cf8kxxLS7Ql5/xmI0WKKFf/?=
 =?iso-8859-1?Q?A1iY7aDDjZpcjrcm2ovD8qKROpuKMYEfMAoVX53sbPuZ1CUbKVv9CH0/yP?=
 =?iso-8859-1?Q?CKEocBkC219OeN+9a1/E1n3cThV/dUnfrw5fwGjrRj6bK0EzgUiJkROov5?=
 =?iso-8859-1?Q?wzsus8Vb3rBMxX6mHClpBeqxXsgLFpPWSEpG9rtQD55LW6HMNy6pBe66nK?=
 =?iso-8859-1?Q?VaSsnZ//4ayqUnLYvDlqFJBpw8iDDM0k9bQSu/nduQgg7yFlLgonay/wdU?=
 =?iso-8859-1?Q?wCG8Pvg6A/1ClPNGn6ejc2f1LHEL6apNyJDNK+c9haFGVEwY42zqi5A8Lz?=
 =?iso-8859-1?Q?/HU1SLghumw2oT0cPFjWbAJnnSbD2JEpTOBOrR/3Sid0D1lNDAq0z+06XN?=
 =?iso-8859-1?Q?ktyU3asi8zmMdMztvSdPYA3JWbiK0YGP9Bth8HszykkwDvU35MN83JMyAC?=
 =?iso-8859-1?Q?exlIX8mKknot0G45D1ACVQeDyEzcDAQQU6/qwY8FJU7bGZtPxDgh5EjS3o?=
 =?iso-8859-1?Q?9+3H4FCUz+Vb+PkmaVW5fW0hfG2AYCLUzlBuURHXxIUWXSL25u906oD1dX?=
 =?iso-8859-1?Q?RLF43aTmOHFfoTjbj1/R/3knX1wPfWSmNYV59FPAAw54Gdf0Qt8pM8hCFg?=
 =?iso-8859-1?Q?rgDW+AZcurhddNmn0JLlEJSPfnT+LCKfr6FVtRpK6CP4/NS5cMYFNpk8A2?=
 =?iso-8859-1?Q?sBjs7ZCVP93XbxHmrgT/echD9bxN949L1VqlWmy2Iaomh2UA+RuZOiU8/Z?=
 =?iso-8859-1?Q?TRvZkY5WI3QSw0SZLLTuShSrRr6bPRRrJOGZhsmCWr8uBMrxhqrt+truKH?=
 =?iso-8859-1?Q?Ir4wRcCzIU7EdE19JOm/+TCPX+5hRSey59cTZ26ztf/yHFOT4TstQFtihO?=
 =?iso-8859-1?Q?jsIQUjtjkf8GruYcoZOHiBGPhEPyV/L44G7CA1+vJQ+qMqLfozhSUHcfQe?=
 =?iso-8859-1?Q?wV8IPZdEAdAXFR5C18S1ZpybidId00Kg+8l0UXP/5SUsKfY45AC2Kj2b2G?=
 =?iso-8859-1?Q?NlnhYiLPD42Hv2V4U0C7PZ0eikMvetOv7uwnTum2GG0Tm+eifTogPvRvUz?=
 =?iso-8859-1?Q?k0DfekQAANzYJuAhh4a+86q7izMLJ28/rq3JpYebG+VJYcGbQi2esRjuyu?=
 =?iso-8859-1?Q?lJUzL/WKKp8FCvgUme9M+Cd0HowdThJnAFbpLDqpRQh8T/491urQPH2yXW?=
 =?iso-8859-1?Q?EFEL0VZ4rZ8AJks6+8LPbmgZaAUYd2irCnUV3gzaAFXVbh6LOLHhFtM6oN?=
 =?iso-8859-1?Q?ml97Uy6RjbCBYFxnoRvJkkxp2kywZzwnZ13l96oV+Osmxv3Qcibk+Cw72Z?=
 =?iso-8859-1?Q?qlVLAdhXzfsXR9/yfLJe7drwNB8aAjLe+qjvLcx5SaDl4dLnGO7dEjhg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bhVWzYVXySCAD72upex1tMIOkKeIgpkAIXXAwAeGDAdGn0cl3Ne2ajNUsKG74cv6TJ6GQTALHq2w4kYvFlqIX1k6lTKE5WqA8IpbcBbricAkQyhTvRx7iPkl3Az4mznd6OM6OsCuJEAcyUTTPGIrSsAJbMEESIPnVbT3ib6TiV/e1INkZbvhWiDqYvm3HERfcpCgZjwdQLR+4QHEBXaXT8lN318Yz9k2Ca+a0vrUK7JaeaclGCOGdM4ITa1L6iW+oFHqQ2vHOrHL3lo78Rj+GwZIl3jIrQPGm0BisIOiMRFIyI70cqAfsEV9jPXv7GR01xhhjs6HHW2FxroNMurJTIRJH77MtaHmWR030iso+2hcUhmolgWYd5akQOuLkae3/w9jEwBU1kQ9C5TkdsJzYneKoikQnGNo3bIBTevb4Tx6kneTtJGTRwSTW98jlQREa+dQLEdmO2nW51oyA7pknPB7XKCFvy/vkW7MMu9U2Vvq4mzUGoRtOEA1n1/K5ZIdIIrnVnb7nq6Gp8Sl1EO2XGlOTS2Q4tbeUAZFmUJ3Pj9yQD01HnTH01IHT30p6C3XLbIdAntCfO5taLrLLabRMnVXMNkOVAHJqYbThwQUdJ/4Oh3zHVxJoJeXQNPCyCHrUgB90KpM/zk+hQs+6h7iXe9PBQKcFAuEBYNQF5+Xn4fFoVutb1MEepEs5dZZtQppBWmmPTCbIpzP4w3223cel15jJFYefsJTsciA2ZYZbaFgo4QsS+Usk6z6btSpL63pVwMJ/mOJQVYruF+X1uNWpoqJPA9tzW2Z3orGPxMmqkRHuSS0AkwkuUk5gtbgtE3cCR+LLV9aSEytEZm8PE+WPxJk+4RYp100z3jO0JDZhI3Ly+DwcOu7LDilGqKt+UjJ1PYevQZ3QePfwom+gFOq6Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e0722f-ade7-46c5-fea8-08daef514b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:01.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAaU7VSqZdVaqlLOKef0KZlyDpourmWmMhkCDY/Tmqy6M0KKtyO+0JzCNe6EWh01EV1RdkTeX+yIP0y+KIU6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: ODxzG7vlXyD87ivXvSY04y1hW1qs06-y
X-Proofpoint-ORIG-GUID: ODxzG7vlXyD87ivXvSY04y1hW1qs06-y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass the vma iterator through to __vma_adjust() so the state can be
updated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  6 ++++--
 mm/mmap.c          | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 28973a3941a4..294894969cd9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,13 +2822,15 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
+extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
 static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
+	VMA_ITERATOR(vmi, vma->vm_mm, start);
+
+	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index a898ae2a57d5..a4e564163334 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -638,9 +638,9 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
  */
-int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand)
+int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	unsigned long start, unsigned long end, pgoff_t pgoff,
+	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
@@ -653,7 +653,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -738,7 +737,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -784,7 +783,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(&vmi, vma->vm_start, start);
+			vma_iter_clear(vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -794,8 +793,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_iter_clear(&vmi, end, vma->vm_end);
-				vma_iter_set(&vmi, vma->vm_end);
+				vma_iter_clear(vmi, end, vma->vm_end);
+				vma_iter_set(vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -806,13 +805,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_iter_store(&vmi, vma);
+		vma_iter_store(vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(&vmi, next);
+		vma_iter_store(vmi, next);
 	}
=20
 	if (file) {
@@ -832,7 +831,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(&vmi, insert);
+		vma_iter_store(vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -878,7 +877,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	vma_iter_free(&vmi);
+	vma_iter_free(vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -1072,20 +1071,20 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 	if (merge_prev && merge_next &&
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
 		res =3D prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					end, prev->vm_pgoff, NULL, prev);
 		res =3D prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
-			err =3D __vma_adjust(prev, prev->vm_start,
+			err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					addr, prev->vm_pgoff, NULL, next);
 		else					/* cases 3, 8 */
-			err =3D __vma_adjust(mid, addr, next->vm_end,
+			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
 					next->vm_pgoff - pglen, NULL, next);
 		res =3D next;
 	}
--=20
2.35.1
