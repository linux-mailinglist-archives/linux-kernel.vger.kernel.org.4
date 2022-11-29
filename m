Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEF63C57C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiK2QqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiK2Qow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35425F873
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo8i012293;
        Tue, 29 Nov 2022 16:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8rfJBQyWGishCBgNUAzGadHqOqccStyZdhQtcGI4EgI=;
 b=168I1k9qhlj2TGTWBjkOhnKQZC8pxZ6t0+fW/BFB9OCEX51KRFgXsTVgZm6s5dWBftYL
 /CkThtiPVdAJTWA0WipHwzKlhiZJNRqhOtVWoyMzROCvYyh6IHm/oa+a5ywqb23wmAl9
 FKXNS3yfOEHrkDES3GXQY4OBg8pV1GL40g6cTEn/vZKewcLjThnfRLWdbIrOoVIsHFyt
 JEAi9wK3Lq5l6Oym0ytUCi6uonTl+f9nTXFwOouLLtB1mGugGQMj9pGh7ZyaCGCpOqKG
 AuuLBHSS6cSQkhezvDUQhT+tgVfnigYbmV9/QkFmQSE0Pr9yYxO8Tb+e9ckbSTc37B+h PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPp027963;
        Tue, 29 Nov 2022 16:44:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QljeSUWWuU6bhCEO1NlY2Owte7DNmqDVo2r0BmEIfu5rNoYJeKBFaWhONK8LbUCOQ0NB067/ORyVNcJX6bhbiCzsfd6UJYsZQDxTqMkWsmYK2C7bJJWCeUdUnaAzBPiP8do4+mHsfxSJl8mf7KsyYwBmmxdUTmSmPiaz0CbDrJ+gjd8jHQUi67pYmZnOE6y+tznkYJzpNEoyek397nuly/lz5bVqQd81BCuwdXQ9a0fs9hgo+2r1VdSs0BCR+Nor6AEbBzv0Jbt9pEGGxJibfim8tC1O8+FdL1Lszc+0nWBhPB2u+6T7LkOQoNBnjarCE4LDyPIh76Ta/Y/yPui+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rfJBQyWGishCBgNUAzGadHqOqccStyZdhQtcGI4EgI=;
 b=O2YbvVZEolQfbQUgG5jpUhTTDR/jV+1Q5LyzIZxqryjLHPip6X4OJggk4z5omHdDqctKG98fvklYi4qJQTuSP26sgkucFpKAJ/F7KhktShlp0ULI7g6AA9liJK6zveEPLp9eViX50Xc2AnHA+rtRrxkDNL8Gn9+f8qcYN6ZLLUSvsK0ca5Dx2QdEiLyyR3Roy02zw4I5+ydYzJd8vvjpykW7/X7mx4OO1SQCv1F3lcqDEt6J1U86TJEaNIQ2DWRRoQ6Z6iNgLJXT5Ckms0xMqLNTAxpL8YoNLfc4bAVegCWb15nOCRRAD+a2W0eTI826c/mzSOQcNmDV3J471sOu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rfJBQyWGishCBgNUAzGadHqOqccStyZdhQtcGI4EgI=;
 b=xYjQ4nddrOp0XoVm+S4fIUs6udAi2v/81Iu2IgzArpFE2Nxsi6wLn5KfkYFzFtXUkq8G6pr6sCx8aZsvU7agyx2LXWkayUawAuOZsaT2Rw6h0NhfsffaWcbSfZcbsZDFgdiOzCFhcp8IVrhjmmn+jO82K3nXHW4n8gAhEBxqdig=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 23/43] mmap: Use vmi version of vma_merge()
Thread-Topic: [PATCH 23/43] mmap: Use vmi version of vma_merge()
Thread-Index: AQHZBBHa3+JEZlfYfECeuY8p8LE2tQ==
Date:   Tue, 29 Nov 2022 16:44:30 +0000
Message-ID: <20221129164352.3374638-24-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: b4be7cf6-054b-4b0e-373b-08dad228fdf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAB2flg8xFRKsmc7BS/Z1uxVWviux5IwgDIsqBJ6u7Rp/3ydZHNW1cSSO9KUaSE1uxV9COD5m4V6bkdWHoSM8SBIGTxge0+GSm63PmYrQItI5tkcjp1abjJ4Dr5/7B0KmOEBuq6eZz51iHm9x/UMiRmgXFhpqYjRXMQAfuagqeVnlZGfx+wJehGkGQL9Vn1xfC5CCjlvKVXBfRv7iBEge+MMVmYVuQJjp0hA6sLwpQJoN1rkfmMvDZjAQYrORJxeLbXvV3LWhEXcmy1BdTFJmueJGr8ZeaIaJlQkX4+Yf3UkQCuAOVomy9OTsE3BLY3D1tn2Wmj3SqKEHDWoQlUY0mdSDq/SnOpAeMRmh5WAouDU+zht3Z4EUV468Iwd55QMxNxmU5COGxlGPvKufVx0LCyuy/R3jHRuyBGouZ0+H4mSWI6+NIrmX/K1L6AzHKlLtklEDqdbFkJe76Rg4sL/URXdmUaXTHqdtl8x9gkWlF9t6doWyWg/xP0Spp2Gr8WvYjWiEbZPwcpa0xnGkU+AGJKtbLGJ5PaTIs+Dsf7g/Wg0VCvMqMFSzF4aEuxbP6cRAZ9YzXWv5ZhWzMcNi0zCIG/nax3WMhaDozh4UgxRaZgtH1tVa4QX7MBvMwwJ8ayw4LfWrFYlKKDciJrR5RVUtfS7cMwbNBc8PrOkz0Qv58DSwCQm8Mje+tRVnP6znoen+nwewW01AriSkWDzQZCFrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PEjri0PESC2LXGVbe2D1sZMwIMqJAbXLzLkgnYFiqdHCrwApaPn4/IjRPF?=
 =?iso-8859-1?Q?W9qfQAvWD6BGX8/tOP8tPh8x48HcF5ITwr5rrCHPtfwxjMGRdu285e6M9A?=
 =?iso-8859-1?Q?UKIfoF8fTL5uXpHcmFJ7X+zysBY6ZQ5ihFuFI5fKYkH5wVommcSafBuJaK?=
 =?iso-8859-1?Q?4jhCmJqksjG3K55K4g4YyL710NbdccFxEDId75oEwYKHzamXAZGpc2qZiv?=
 =?iso-8859-1?Q?MI75JfqBEXd9INTNZXI/V8IKKiy8p6qOi1ZvPHPaOGRd1orgcC5rhUqK3V?=
 =?iso-8859-1?Q?/ABhsjJeP822f1TQ1Fp1ICCY36mcozTSlRAwmYq5D/EjdI+CxGdf94+dDb?=
 =?iso-8859-1?Q?VpZEgPW7gwg/oJ+SYwC953WEY9To5TSblhQ8o3KgDtJppWiZkG6yvuI/IW?=
 =?iso-8859-1?Q?cBr78Oe91dAy3D8wVP96yf31JJkjatlDkB7P5z2p8pMQttWq5KaxkRVu1n?=
 =?iso-8859-1?Q?vN/TKsa8e2qX8rT3K6eIN5K7vLPQtX2f5jzEAYkw0D7AAPxIyepRrIo8cl?=
 =?iso-8859-1?Q?rhgyQVyG47MPhy8mv+ISAygN19vcU/kPnCIFz/UECHfH+ktR0cz6YccC7H?=
 =?iso-8859-1?Q?XnuH3RWShKwzNZwf8UYm3Utt28IlX89/c/0Ca+YvYrA9HjgU8QuHKiKHOF?=
 =?iso-8859-1?Q?mf5Zla985ogMnwgpvvWSgjl9I7mUg2GTRGvoKxeQC3KU6/a15vABZV4POQ?=
 =?iso-8859-1?Q?L3yQMd1crHs0WlRwcH5wrq2PITUzcnMGNpH3fra7GBZeq34e9kfeiOQO1v?=
 =?iso-8859-1?Q?ihP9nX+v2nSM4UaGr+isvgBo9QAPhCEyro5nxGnDTPbEDfjoGaeg/Zspfq?=
 =?iso-8859-1?Q?GLH3Muadm/Q1VgcwUe9sypz0efwUyIfSfiZPgaqPpTtfMSo52Lv97zub+H?=
 =?iso-8859-1?Q?kPVxD4cAeefw9RIFU1PRJ1eDD7rixTzq2EIjMHSG0AloaO76bHo0G2SflL?=
 =?iso-8859-1?Q?ABvszvkyQWdwHVZ08acT9QWKvGBt2aeJfCapHQcqzkKa0udvmeZGRyaimh?=
 =?iso-8859-1?Q?xbyfacFC0vRHex36682lMnashcoAx8zHEr0Q9BAcRD4OoXkve5xQzWqMIp?=
 =?iso-8859-1?Q?fUTitGV2ziMuj7EeUJR/Ue1yDOZmO2avLOTpnMrWWJWnDQjJbSi6Hcg0OU?=
 =?iso-8859-1?Q?wpjWksxqvJkfMCndRh4T5U5AIgQaUSujU8ebiLy8/dDsMBuwr7oKqC0wAI?=
 =?iso-8859-1?Q?x8l8mJDiP5LAExUWHdVrQzjcKzxsNnpJaUHJtLQldHo9zDCVoqS4cS+3zJ?=
 =?iso-8859-1?Q?jRWLItR/Cb8+wHCCXZc0f0jJQcSH9awDRjqYCGR83Qbz/yeoOD04kAD5Dh?=
 =?iso-8859-1?Q?+4AyT3PXw5+evRzw2FOQccrmSigtOtO7iCCabb3HOgD8qfzFbXXEin1nEM?=
 =?iso-8859-1?Q?Ll9XbqZn9q4LiX7d610+Amla6b+7MPyudB2nds7yZx8BQgQ1078cUcS/Xo?=
 =?iso-8859-1?Q?dzFBsZTj8tX40JQqskOU8cbnyXoLJtftIJRtCV+aOKOdT2Khxjbd/7ytEx?=
 =?iso-8859-1?Q?Z+0Uc+wG4z18t7NG3k2FJOhCXlVyI/SgViPVOStvFdNFW8FQ6Og3hVBcBd?=
 =?iso-8859-1?Q?okCl8Yn7ZGiWalk5zUcA+KGQ2RyR1WlD7NaaSKLF8LrMmKuUIO7W5/GfAi?=
 =?iso-8859-1?Q?/GCfIJTm9Zv/UBXH0R9A6a21k+Jt7p4oEJoyefn4GBMY9mmYn0pbF/mQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YzYp28jmwZpOcRSUorI4gDoSpHZhpucG8MgdhFjuhD/MQCeAqupy034rmfVmi2UANrGDEHOheQTxMK+mtakaVyDQ4qK8MNnx3A/xqry9nvUGQbsnmLaGZ5aieAarul2i1MBfjwtWAdghjJkejk7gy7uB/q6mWZIXyBhlz89F1/qnX5+2CngBka56aP2YA5tgrAjfuA+je8zGYVGZmjFL1yYCRBGRzSTVHFd4UxbVaF9YfMq9C2q74OKs+YdZb40nENVQ0VU8m+prmdFt9tmMFz4eYG9AnB7Lyo/gQZm0XUu97HYlvVRe+NaJHS3hOOLkye8xbkLtVgSHyjlN9HhmhbMhCJWtBlQpyOS2skLQxzzp5pXgmNaTUaVXWJTqp/eQGJ9J1ZRTwqD/Dlbg2SOJ3q7q0bjXX/d9nk7ZcjVClz7xTJ++LJuRYMQs5D6IPBPs/Vx3VNz/Rtc6icPASfjMK+i59QAcq3QRTvN8KCdWywWXy4inMkD8lCYQWk8CG3foFlKvD1hK78u7wgTIdwnCw7jUMtOsDuCXyTkCAbpdV70Rj2Gi6354hEJOs/Bha3nZebBhL67tyMNTCMrfZuoudXmMvd5A3azcqQUCgVab16qnuiPDMB94bOC6zTJAQLctUxEpO7d7Vt7F/Tax/7bJ0TSR+Js7PqhD4+lD6iARaTm8S/XDY8XkIfrryZCCmhkEavxibEgvYFe0hEE1/OfFH5IcTdEBRLaIHI0brmfb2otuKJPKn6KHuEgPnV5b8df+BQHDGwcCp9yTyxbqu5P7vfDxVHJct2aydr8SRGU1CpKBuGtjlDBY+dZuZUHFyBpfKrtux/WTz8YQfGg7WYq/p5Q8c5+Hks3CnH90CK38BQ8ucc/6/ln3J9XhS3fuGRyUE2KbCn/svgjvUkE6S30qCg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4be7cf6-054b-4b0e-373b-08dad228fdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:30.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrWBXcGQ7b/roZvWNmuWBF75+u4LqUwvBfANn560YeKz2GzI7hqoi9RbeEZmC4L5FTYWnPltpdT+YiR1e0CVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=995
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: HA6i7Z3dqcJR5AxHevvEpwoCFG6Qxt14
X-Proofpoint-GUID: HA6i7Z3dqcJR5AxHevvEpwoCFG6Qxt14
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4dda84378831..c22365727ab4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2749,8 +2749,9 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
+				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
+				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3286,6 +3287,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma =3D true;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	validate_mm_mt(mm);
 	/*
@@ -3301,7 +3303,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
--=20
2.35.1
