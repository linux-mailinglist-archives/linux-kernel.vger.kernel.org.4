Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6860D15E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiJYQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiJYQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:12:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253F1F41B4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:12:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFSjZB016474;
        Tue, 25 Oct 2022 16:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=mDJv/6A3wkeQ5O0YCC7p9Df5JnAF8PKG4G3ASgHFo2w=;
 b=JF8FlUdEKje2NybwYzFoORdKSFlZjhgWoimIrm18LtqUC05PsjMAyinyPMjOWmBpFOq+
 Xy5pZL3Yg7a1REPeGu6eVqkUcwMFUz46lCy1VUtjIJmqNfM3YY8UgBieQuw3ET3JL3G5
 5BglfBDOwvyir6CvrqTF2s3bDN6RRiLHi/IM4yl2AhxmLZKeF5QBi3tOuWCeIezKqrkM
 fsV8Wxy0lFehN1TytOkhCd8HhMUqxKYQXSe+1/tYYjaZFXGgShM52lho/6aCk2SmByDG
 Zlj0RQ2NTfvHXs8tnnNb7/wf4ez2ycKFvqSPAOWZethjDpKiixLRFhe3S96jULg6P2z9 uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a344tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 16:12:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PEivXR014663;
        Tue, 25 Oct 2022 16:12:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4hbb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 16:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyjA+HL85MHQiHzSDmy1Jqnd+dH0kT2EGjfMpmc9PgwsojQe95NJSuCIvX1C5p2ou62D0DB331LK/d4IDxcA8oIdbVqlOKAsRSky2TJzKQHsEsA30W82IkrXf1e0b9d3+Dj3B4vDBb6uV5uqFaXeYOgHsbeWvE1M5WarxeJlW8qs9VLQCsik6JsHTCYHO0N4Ftw0beW3D/vq4XW1NQgpyzscnqGbN2q8b+YIvsPpv8GQibDBzdrQBM+VtXjOs7QFETvbLkKV2NVahyxmfizkGVqJHN5t+061TOPnK/hlsdwbEpTEwkZ5a0M00YEdtsk3yCA2TSEDhe0SpG10YQFy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDJv/6A3wkeQ5O0YCC7p9Df5JnAF8PKG4G3ASgHFo2w=;
 b=B2vIJeGcygz1+h77y07o2S7UZhakxx5fsjy2zk4c/gjTUEURHWoG4c8dHlSYWDkEh4SY8hxug19TAjH/h1aicIAFUdSmJI5Exur0+KQ0L5ZlReqX82wH0H7m6EFGMPdjbl3HFD7h5gq2o9fM9Q8WGFRBP2paJWhyL0jJVLZ+EsB4aruXVT90iq5P2OkWVnhlhRTyzdl3RV0qSyrLhmeVZhGaGciDlzCV1i8slgkq9CRJtvAh/oPH//ayCpbTdW/KiV0Q3rOdWdaz7g5BhfFuFi0IIpat0Cg+LPLCb3TDA4hpPMX3O+oJbZbLNd40x8Pj0EXXXhdl+aFJ88GbhmQpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJv/6A3wkeQ5O0YCC7p9Df5JnAF8PKG4G3ASgHFo2w=;
 b=TbY0JaKufhRsSctsGAb3NwpH7Ocrikk9xVz+cdIUa6XxvEbj5qenXH+gfnWlvLtEiH9xZc2+sDQlN/9n5U36Ujq+7q0oDToCnSRmISBSDKWr6PLLekIlFtgfxOaoEyyiHJKk/2CUcE0azcfVcFi3Tvp+lMaMpXucynIS+YMhNmc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4135.namprd10.prod.outlook.com (2603:10b6:610:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 16:12:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 16:12:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: [PATCH] mmap: Fix remap_file_pages() regression
Thread-Topic: [PATCH] mmap: Fix remap_file_pages() regression
Thread-Index: AQHY6Iygbsm5ohIXz0CHpn0VpwhKoQ==
Date:   Tue, 25 Oct 2022 16:12:49 +0000
Message-ID: <20221025161222.2634030-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH2PR10MB4135:EE_
x-ms-office365-filtering-correlation-id: 39046459-48f8-4bc7-7600-08dab6a3c31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt3uvgPhNO/tY6ZMS9rG+PBOaALEqXKBvVXnBIOqLVYt2T3zb8giw9Q3O/rguyu0dn55PBXYhsMF9ol7Wh1mLlDLNc0QbjGF5cI78gjmZ/HmrJuIVJi6ekhk8gKqDQlaTrzkedpSGbcFSzFCMGNXw8WUjci+fmW1dUacyRnckGz1NrYMXG3facG5u4psI/VG2i9mB9yyMEYelPBtom4mUQRpb2WgbkQWayQ8MEZaVxJDyIOwu/7P1gGTckip02k0yGxUEX9nOjmDVj5hjI6XA1N10j2+MTuPhI4CkpN+azAh0NgoldL1T/UcehMLnECc/x0cy1PKvRTLqREZAC4N1kVMrmAcaGCQyaoAvk2fCeQjedN4PFjckuZvCUzHkNFuVgEB9i7GYSyxKz9ZyOE6IhpTx8dicynpYyMFU/oty+6hu18qPpmQE30T2kb827XAWGla+LCwptf93a6xSS6ICeGIKxBIJE+EaCjETHVg/imcuQG07bJGmxhG+pDhei9+m+H+CxD04u5WJwn21i0HB9g+/tSMFVH5UkcvMmQgj8zk8NQ2BHJZxNBY1sLVxk8PTwe9jjm3ZBaL06SAms5/MZKy8LV2fnYJJzbP4x5N+zlR6BUsDdOSrK6KIqvHwvR3/BX3Tgvnna9Owxs7MOUMbeegXxuZm6iFNmqvZVKGIe34bEavKleLUUUU+sMQHLPM710+fh2cFD1UWtxYORESYZBfnkjxJGHgAT3hVa+EjH73Krfid1xHg3vW1vuPcUkzRddT/AsT4gBqGV/n5gvhuQfEmIyexqj4Cyy0HHFRhDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(316002)(54906003)(478600001)(5660300002)(966005)(110136005)(8936002)(6486002)(38070700005)(83380400001)(38100700002)(44832011)(41300700001)(4744005)(122000001)(36756003)(66556008)(76116006)(2906002)(66946007)(66476007)(71200400001)(66446008)(4326008)(8676002)(64756008)(91956017)(6512007)(186003)(1076003)(2616005)(26005)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mxAB1mjd9eYboBmklHZr7qumiTXnG9MRGZziOVcIdOBT/kl/dlus8dxv9O?=
 =?iso-8859-1?Q?fm0xpp3Fi248D+YzkRmFlmggoqXHCakThJIsoNfxKk+tKCSESVWFgQR11W?=
 =?iso-8859-1?Q?DynobukSIwUdfOJ/8MMKgvAc6C9GXGhw1662QfXLfS4bqNKKsPWet8P58M?=
 =?iso-8859-1?Q?2ozIoWIdtP+9Q0H5jZ3xs2jamYq32LVSRCLAbi2oEZ4UVVns4dKn9SvCdo?=
 =?iso-8859-1?Q?c744csDZL2yKxSxSQQTgJr/PgvKWquvNurw/8Vo17uh/p0EjRqUk4rrx9h?=
 =?iso-8859-1?Q?2ccS7kuv6ypua8/O1Fwa44NrXbMUYuTQeEh5FIwWypl/u53QiYsqzkuN7Y?=
 =?iso-8859-1?Q?oiCm6ZGOW/XwMlnInvhZIj+pXec32FF3fiz6jhK/nDq5iG8Mh8hTA3vQw0?=
 =?iso-8859-1?Q?u6szr3djVSy1rZgXkpRB9fstISsyc11xpHluJc8fa4KePdgxZd26/qp+Lo?=
 =?iso-8859-1?Q?06exX1cXoaciSQDwI/6yACYgM9Nn09kqbDJdaaxgSRffCV+AK6W2qlqpdh?=
 =?iso-8859-1?Q?i/ve8mZ7k2Il5rVAIYFQ2NRriYNGg9Gr5DQO7LDglWppdkrSFKWIyC5Tp7?=
 =?iso-8859-1?Q?d+ZBxTgrHgcXGP5IHSlQVhdTNr1jBWm3svO+sI4ZoCux32x2Q/yLj44JtO?=
 =?iso-8859-1?Q?DxA5S/GWkUE1oyqQduNAC5gxHTXFe5GrOR1bLJgcd3JU4R797JYtW4fLLo?=
 =?iso-8859-1?Q?XVzCH/uk61ctMUs0T/Z5sXywLWWLFHfHBCkLjDLCf9Us2ysbQ56oz5SwNM?=
 =?iso-8859-1?Q?HX4OMwu9OS3unbofz9eU6z9wdQC4j23at61z5lwKuk0+yRKs/CsfRvjDS1?=
 =?iso-8859-1?Q?ZiXOsDmKXzv6x7vRZjS38D7qtxu6H/NSGJ6yRx0aYdSHnOCf3XlvW8BT7s?=
 =?iso-8859-1?Q?AR8/RqVWgbahzr5muyHI4G1tOF6c9nOqXpZASs0JN1Rct2gg59h44NAUSW?=
 =?iso-8859-1?Q?MTi7u9w1fGAr23Xhqo/zW5xiKD+0n/xPuE26qJYBsZHS+vwrBn/peKaJKl?=
 =?iso-8859-1?Q?RweDXCpC/1v2bWthD1kytxHn8C9m861wKibh0SW9DEr5MA/ssEthbEhEpg?=
 =?iso-8859-1?Q?zFuJhhuhJ2d6NLZtEexZ3jKc//a/DHijQFpxmlMzFdPVfVnZhypEju4res?=
 =?iso-8859-1?Q?l2q6T/6aZW4bXJqBByqScWyf6w1k7UKUHD1q2RxhK37RhunURHItjCgRYc?=
 =?iso-8859-1?Q?eg9lPqURljoZcpgzsrkIw/jpYeTpApJAdHkujX9AfSDYBWmCdY//uUOTNV?=
 =?iso-8859-1?Q?Y2UJ+wxrrcY62D7xgrhMnK8amE7KPyXKKHlu4ixn8UHZP0L8ONa5yIaFIt?=
 =?iso-8859-1?Q?m06aXzKRnGfEOaJTI3u/9Nl2BQjvc4hCfxXY4DvZOzau5YckY5mKn3jcVl?=
 =?iso-8859-1?Q?OATxcRSAt36yIn+KVzBwul2WQbWyf7lR7wwYspKWaa72QBu815U+sz7TV0?=
 =?iso-8859-1?Q?S4zdf7Q/2o5O69qVdiC13qhKrULqRXOlFCh3YtDYJOGSUvz/TZpLmzeY4N?=
 =?iso-8859-1?Q?q+cpNmI0mjwj64L8CQj+SCT5s+GviDSHP6wK1vgYZHazz7iavw+x0IqUKW?=
 =?iso-8859-1?Q?KIyK5KzNRq14q1xEmL3X0XLbLy38YRJ6Nu796yyJIaXQ3QaggpzZyQMlsK?=
 =?iso-8859-1?Q?qZP4xCveE5mDD5HX5Yuhp9FBbGWRsU18RJBkKX72ednqkBRa3mIyjNAA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39046459-48f8-4bc7-7600-08dab6a3c31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 16:12:49.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epmeAmrOL17OKrLAxGqq5c3nTQTTH3PgQQpmyftVFctmzufD8PuxBxGvuUpGSGVqvLM84Bo1B/SeUe7dUqKZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=914 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250092
X-Proofpoint-GUID: Ntpy80KzMZdN-Fzz4ae2tPQpDc7T3SL-
X-Proofpoint-ORIG-GUID: Ntpy80KzMZdN-Fzz4ae2tPQpDc7T3SL-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the VMA iterator, the final execution will set the variable
'next' to NULL which causes the function to fail out.  Restore the break
in the loop to exit the VMA iterator early without clearing NULL fixes
the issue.

Link: https://lore.kernel.org/lkml/29344.1666681759@jrobl/
Fixes: 763ecb035029 (mm: remove the vma linked list)
Reported-by: "J. R. Okajima" <hooanon05g@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 22010e13f1a1..ff670e88b6d0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2851,6 +2851,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			if (next->vm_flags !=3D vma->vm_flags)
 				goto out;
=20
+			if (start + size <=3D next->vm_end)
+				break;
+
 			prev =3D next;
 		}
=20
--=20
2.35.1
