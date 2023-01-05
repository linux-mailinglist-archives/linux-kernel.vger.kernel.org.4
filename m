Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51A365F44E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjAETVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjAETUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B36D519
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITwjC029109;
        Thu, 5 Jan 2023 19:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=38kJ5mbQ6p69SHQMpyl1qGQj4KMnaMdtXVUJDeG9MeE=;
 b=ytEmoXTyxICtGOSa1L56yeKLJxOswRg/7aaV3O4QQ5XycwpyG8mEXx3/c42Mr3TfPOi0
 ea1dFVrkmq/vCPH0ILeJJWVVLzVonKmXrLbYWoKIX9QbxAqH9psRw1GLj41HaLhcR/Pj
 0OUyAzjeDJXez0macE3m5WkUea67xWJ525XONaMho53Kr7KWNKsNjRPP+38tXBG407F6
 jd984sYD7lhZYTX7fmytSrUNFW2xKL5zM6VviqVdxitptLy7b2EjHWcl9giPqA8LzDIs
 mAwoaZBmKkCBxCi6bY245HyqmETPR+U1utRqN654m/umgS23j107E7Cxg00mvK0kRCJ9 SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPg033688;
        Thu, 5 Jan 2023 19:16:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoHeAUimNtMYDF0W4owLftjczeMgFKMATtOlHUe3ZUOmtlkSjDMaGsp5SOSo3IzQtona5pA0o+nRTQR4bxRJksT0KRgSskNzYnhcSrfIr1xRtfCXe7NJiDF0/Xy9J8EnvVXEuOWvF2zSOOluHq8FEbz4vQevfcL9hq82h/ag7TDFPhZUX8MU1yv+xcKdWfRJRlbDONvYUFVC6bp2wC2100ZTkOrPNwzRceS5oTFbJuMMc10KQf32HnhP/+QUBCx3luCs1bpP6LMkkGB+pSRJAgXoOq6xpNpfzWFgsXGZyBUq1Wt3QvJk0n73mZkmeBwo7N3V+3kJHIj4QOsUp4LXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38kJ5mbQ6p69SHQMpyl1qGQj4KMnaMdtXVUJDeG9MeE=;
 b=SvIK5047b1NFoSXoTKtClQ3iJIt56PVNBoic3mMgysbQ/x4SyA8/+z0JvsG8xng+k/7YR4PYpO25SLvBXi2a4CegAQe3BOuQkC/eDS04kabmv4J4aqxcmzsWPY4R5uxGfmsH3xTZz2hgErnsctpnU4Lp6xlqCP4SzB/JEJuZDSSyM6YBKB2IqG4d9hcxrlunZE230shkoYmgKsOnvT0dEi3yv918GGQ68doUVC89RTj1vTL+24PEQ+E1LgUM3idsiTeZ1Kmo84I8AfdC38ih30gh64L8SjVPIAeZ6iJAwtIXxcLH1qi2tF6FCekCbKkKoGxppABPSwRr+OPLKRj95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38kJ5mbQ6p69SHQMpyl1qGQj4KMnaMdtXVUJDeG9MeE=;
 b=x3CoBsLjcsizKmloq9TOgUPCP1/C12ZL/6M1jkmZMSXqiBRnMkarV1Aifet/R+t4KyTYN7XTgXBZUdCJeCngQQtTG7dX6Gs9JqRa1+bnGCN02S6GmB/oilfVp0uycTNX5v1O3hiHBoa6Xt6D1+1mj96uo+RxLk/NzKfB8SzuQ/c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 30/44] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Topic: [PATCH v2 30/44] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Index: AQHZITomnDYYbwncpkiHEXdmnxwsTg==
Date:   Thu, 5 Jan 2023 19:16:01 +0000
Message-ID: <20230105191517.3099082-31-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: de243176-22d9-424c-0d1b-08daef515e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AfYfMaGMFL+0ZJXHXfLhv5L2fEr9DhgpcL7HFELRp3Zj1UxfqxmGp7rU5Av/8ZFXOdTllSdJtK3/lEccygiEsACmRqntU+USr7CsXJSkfnMX/KoZodjVF5MFHdhsMiD73otr59fxtgYJrMebJ7wOCu46rSs9Li46DnUoNfaASrSae7Tjx9248DubuaiYW06GR3FZ+q3yWrPu95yRqwiHC+eQOrfg8c42lcjnVywMXQ7PiWhlOD9nhl55w0U2LbD1Gn29Rr2FQCP6DckfoNZG7RdnVTuMld7qD0Ua/cU5AwOD9hnHdamRdylqjFGjmUCSiyWe6hdrOOCSckot+dZIr2npqCnIdkuFN2c8o7itk/niyrpOvoVI1KhlyetBU6tMxQfTavcac/b4A/TKy9llnRVrt8+6n6dg1ZvMch5DbDVWrms/sdMUtEf2IxWcpabSzhx4g/dr/8H3B0slvfP2BO22rAQxMJhTYml9Nmpz7GFBoc/kXWpzbobJWStHDh3IykiT3/Llx7As1Onz5H1AtAKGOx8I4y9L2hQyZgEMKV18pviJ1ReUOjJZk95A7lEsKxPx8fIBClKR6t44PBGRhrNEHH6Vkipga4n/bQhKslLa5f12GRYgsPRU9zy9ykhMfgNLRgB0QTX3fd/aj6my/OKa2FngHBiaq4uKjhf157FcmWs/fi9G0IXWhX+Bs+nOPutK35BAXD4kDBi8/HWj/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(4744005)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gBC2aUj2PY0k6EfHBHWEZTefRigtZkzjRVDGcZy92FBv3wHFxV8gUEtFHM?=
 =?iso-8859-1?Q?ej/x2KGlg5hQ0Ywxa+T63thx8DX18zqYBKM8ZmYEEzyePlrM9/nvwkmSaH?=
 =?iso-8859-1?Q?Nq/f33vqY7aa5VvpkpEaPS88vN/F+G2gtNca8FP/GFJ+fiW/HS6HpuUOCh?=
 =?iso-8859-1?Q?GC2bgQnTgG+wEG2Wkone3JKHj1eCEmTDUExw552/+BVaLGhp30RwA/xPkB?=
 =?iso-8859-1?Q?PHT08GDcU0F9GzU2aJrjfp/P5p0ddnBetc4oNI0q679dxoqW2ltyaZRARw?=
 =?iso-8859-1?Q?1v2SDz5UR+pNmLOo7TNYQ7VSpt+RQVWymUAnt0vVECOpJbOEBKMqqoVBoO?=
 =?iso-8859-1?Q?oW9qStIFhtMhh3TIrV77e4nAQc/O3cFk1a2Ji+7+i29r4THLm42OFMPGei?=
 =?iso-8859-1?Q?a/UHGUf+kuF4cdvseP71vnYKLP3lHIcIKmV7iAHSHZYXEevKSU22u/oAfM?=
 =?iso-8859-1?Q?3DKtH9+g3R7BBhdL9IVNHbruoofP28YTSTYBu3Bb4xe08W1XgRJLNQjGIa?=
 =?iso-8859-1?Q?WT3SkBfl5SYvARIui0hDA2ZIYmLCqPx19EgpXDODrByBn5rlFJqGHd6YKZ?=
 =?iso-8859-1?Q?3vLH+NVdG3Myc9YEITQVrLzCdEz+1z/XaAyEpijG0Te8tg6/rpQtNtBF8H?=
 =?iso-8859-1?Q?aGr7+2dvqYAJeTN2ATFHscZ9YXkbduj4j81axmQwXZlaIJ+o00ToyILQwy?=
 =?iso-8859-1?Q?mbrWQ2hidyT45sjkHA3gkG1De2KLP/PEzT/FEADbsfrXfvgScAPQcpq16i?=
 =?iso-8859-1?Q?64wTSRyQo9F5DKJXiTLroRaCc4z7JJW99JmOTp41oud+wpclphTM19SwfI?=
 =?iso-8859-1?Q?70zd0Ll/8uepQNW18Ca6U6IALOO5ZXJyrCqvERzakqtdr+KdKcqkovRIqW?=
 =?iso-8859-1?Q?95FwoF9uHzpQqkoLEhUXE/1MvZE6SsJjqtMPpVWSpfKb960TVeipSguJom?=
 =?iso-8859-1?Q?+YgrAccXjshv8LiLWLGNYuAKiDlZZ3xFu1D9EEIoNnRob1NZft8cjPPQpT?=
 =?iso-8859-1?Q?ncaSeZNDCnvHKuJwRc9ak568YiwdOrLruHAezE1MAXE7v+zafy2eH6hFG/?=
 =?iso-8859-1?Q?GGsJqw/OsslA6EKNuKMgMN+RNMLgNiDfIGyY7Y8bjHlVtEVHJZ3U7CcLqM?=
 =?iso-8859-1?Q?wIH9kJDEspzpN69YEr6x5v0GBImUTc+O1V5ec6Jg2OKkgNzODbdZ1o7X+5?=
 =?iso-8859-1?Q?n51kIN4TUTFuoWmpAsnSrSBY+/z2ry4u97s/uVkC6GrjtINxeKWvOq2P97?=
 =?iso-8859-1?Q?U27DUHbomhcZel1sF14Ve91/7EMk9rmyQxGls+aeqLBc/Ckz1QIkI9ZZ1Y?=
 =?iso-8859-1?Q?YXUbVGs3h5HAvVwExenAGV3BUxNBNELgDRYi6ZYpA8UEkjatGcf7XS91zo?=
 =?iso-8859-1?Q?84scXXETF+6joHclXd3wTTJSDtCs6ap3q6YuzSZtDUh4KeU9Cdh7+TGtov?=
 =?iso-8859-1?Q?kyRhOuRSQuqnQmKMUzTdEmlViEe3OTMjIvLGlQ2N0vtSVaoKQs0rYM/Gsq?=
 =?iso-8859-1?Q?JJSqJrEOYzHu3fnZGKuEMyKJJ8zcoYljHxws+TNJASYeT1tOLe38+apCBX?=
 =?iso-8859-1?Q?QKoDcOauj7z0ngPK1jCug9IpGAbGrlTIG7PQ5pZ5x48zX8wyE7kGHwv7qb?=
 =?iso-8859-1?Q?qfXab0BoCWV2asUtOre/PF+A5d4rlfzPRnOX6eiRmTSFL2dHXIYa3oKg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dqGwifHSHWGanigKmYH5S1nIl+j9oiZNDElR1jlqFNPP+w6vLGptOPo9PKbpc4Jjn0oxuIEHg0JmNdT6MW1NwrnZCCUdmTRGbUeZDhzacZjzXDqtO5wgvjeSb/pBMdLMW9Xy02flAbiCibL24ShsDxR4qjXhLtIEoUC8Xd+LesI3p7Oct7HrBc4b2Dd/NwGIvHXtp9wubadTk7H+zvuhoQCLd0Pn4D9DHo/UFg/E5Rupj4VAKCHsiCofgVq/PvukxA3XC7KBXXg5RSq6A2g9teLVDj/BUAUWWNDzYjNRQu8Cq8fLvpbTUA9mkqoAw17K7SeU59QTI1RLDp8ir4tVh2jeWYP3dpjWMSKCvgQhpWm4DcYWzMdGBhAZy7lmsKcM3hUe/3LepBZxkBWWCILc3VA9M4m+u7+NmxO/qiKlJuJ076UXBlDLS0my0ojDb3RkQaSJQj2isfJ8gM2sEYQg6yJkeV8tZKhioQJ8cLQ/YPWDmr2h8w9Pt5dl8o+skaBGiKHDcXGwYytcXb0IlKZHo+r8WFoNoyAsm5Cb7w3uf6smi0FQiwQuFQ7pl0yhmCFWr8BNIXJQjeB5mHM/6lQ9Vu6i+mlEh/ovzotAQAcq/M8QMKr1xwjhfqbp94NT3wHn89I7s8xXyh+No2hU7thhFN+tqk3vS01Q+ScVo5sykCiXWcFRYzRYhqsnChbpaxrQq3NwT39WBg5zFU4HVnljpGZf96UAJRguf/jf5oh7Hd5iAe3vNrUD6QQh8i0Zlg8I74OEVk6lwDqI2jnMisc2PsszUoBvdJIZ2S2MG8NGiFGN5sie2xSvtIqTzPWWTWBTzkur7Zts/AaMOL0NECtpNrSU1kUaXDnf350ExFRdnjOmbFigj6ufVhDazVybcbu1K7/jWgZRs4xU/4uy+0dXVA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de243176-22d9-424c-0d1b-08daef515e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:01.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUnU8dSZE9CFJoG5Pq00GSZilbAd/sSqeX/VFt7Ujej+lu60tQ17rKopKlQOQ0FRV2YWeZDx1AtXghoXLnbJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: aBbkC6nehFphq-hBeRXl1F2UTEh5JeiZ
X-Proofpoint-ORIG-GUID: aBbkC6nehFphq-hBeRXl1F2UTEh5JeiZ
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

If the vma start address is going to change due to an insert, then it is
safe to not write the vma to the tree.  The write of the insert vma will
alter the tree as necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a4e564163334..174cbf25251f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -781,10 +781,12 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if ((vma->vm_start < start) &&
-		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(vmi, vma->vm_start, start);
-			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		if (vma->vm_start < start) {
+			if (!insert || (insert->vm_end !=3D start)) {
+				vma_iter_clear(vmi, vma->vm_start, start);
+				vma_iter_set(vmi, start);
+				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+			}
 		} else {
 			vma_changed =3D true;
 		}
--=20
2.35.1
