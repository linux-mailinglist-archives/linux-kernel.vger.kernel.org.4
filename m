Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336B61FF36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiKGUMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiKGUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:11:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F225C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:11:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JNsLk029390;
        Mon, 7 Nov 2022 20:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=iEhGQBORrPVumnBMxTMLBFbKr9wQqOi5a+QB0GVHkd0=;
 b=aYtTWShI2naZ5BLIU8BpbMYqwdpv9Hk91BrQsU0BEJc9NaYvmETi/Co0+0z0Vu5eeU+5
 EeHFgZpVwnAHJUBRo1kL4baSz98BmldA4uZX/DUNsKLFk2yf+Ee0T3mfVLKtgTO4fJ/O
 2CV6gH5O51Ah3KSBaxmYA82E2CdSJL1ODgxC4pYNTFJA/9/FLANmaOqYFV1ERu5kZc+E
 u+qnD9tqKi5+PpIRDEOqwVFax132Ok10eengmjCwA4UPUZmm1fR4DJRng6DxlzO1e+/T
 AhDE0LHzAJ7EC/A0iZa0aBFStTgJotx3VgVoDMVxKViRFhp/+fK6y+Ejouc2N4Tkfud0 iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj4v2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 20:11:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7IHgHU034422;
        Mon, 7 Nov 2022 20:11:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcscpqw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 20:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmP1xIa+RENwQ5IpEU/XBCYomod6l04FlVdSE3fD8oXRABpwp5BAlQcHh3DBO2JlBbLwfuNO/DEPK67+f+KpWXemqFcgv47bnrpckZFagPM9Q7NKIL0eMRRnLt3nHTgZWdoVm7HaFigVo/SLThlfVQNIlzFc6xRmrlj23EJYpE0XFccnNK44Q2yf9s68RHRRVQIwHzseWv2JkAoeNlfVK4CwszVZJPnXWNFf9fxUzXuqDMSY53czI5AQ2ZzDiYQvApF8ABEWxsmkYywKESf0h734x4c6i4Gp66EOqKm585YR4TX/pI0pzUzLdafOlD2chGKonJQpm4UIeKdy1Vnk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEhGQBORrPVumnBMxTMLBFbKr9wQqOi5a+QB0GVHkd0=;
 b=F9K+MVIDz5G+noq6uCie5Aw7ORDi18qwx72qPegaMn4SRT8WbycUX3CJaDdM8rDdNX+T2mZ/SNJfutsLdjbfpRiPaWIxpdzIcuedh96TUp54L+JrrI2OoJogPerVSRFqbegjjaHkFe71gfmR0Vm4xCIqP9PwqfOop1tpMeHxE9VyTivc0Ic64uVAr1FOamJ1x7Ja4SqrXnZpy2+2VOz41um3X2dpqgXZwC4k5qs+xNLzvtXU3Z17QWrxt2oGO00mgP9Lo+ltzjNcWGQEJtm2RmVyr8zUK9ZaSL6UB2ZKuxGzp+czC6qPJRBzxzo+PGzsVZfgk+itBiC0eW/g+k+sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEhGQBORrPVumnBMxTMLBFbKr9wQqOi5a+QB0GVHkd0=;
 b=zckah8y4Cn/7nOoGqY7F2Dd5RxrLV+czPHyTHLhhYxPLh0/1ALeGv9L1/szN/BZbMWXkAbATCWFhZfGbRNf9NGw2PH4tvBqksgrmIepnyXFwu4LcP9Z5yv4LQn4tWAOdyd09gA2UTJ0OLyX6E5KUD4xy6qzN/CoDpwij78Wetsg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4806.namprd10.prod.outlook.com (2603:10b6:510:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 20:11:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:11:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com" 
        <syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com>
Subject: [PATCH] fs/userfaultfd: Fix maple tree iterator in
 userfaultfd_unregister()
Thread-Topic: [PATCH] fs/userfaultfd: Fix maple tree iterator in
 userfaultfd_unregister()
Thread-Index: AQHY8uUn9z2eFZfR+0CuLW4biB/bkw==
Date:   Mon, 7 Nov 2022 20:11:42 +0000
Message-ID: <20221107201121.1169273-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4806:EE_
x-ms-office365-filtering-correlation-id: f7139114-7f10-443d-09eb-08dac0fc49d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YiD66a8qORCaKI0LVrJdSMkwwP60XSkxmSoHOyL3f0/2UwgRMqFs5FNDiCoCwDH4AXtnA38HxDze1N3XEwPAGzEJcj1PfA9hrG44ct6IiCKfWH8eekNUVbzc0fDl3IVgzbqVPAtgU447n3SEydB0B+VoNEig4fhp6ioTfyxhDFSxTy4KjUvzqCsjbZbR8kweI2JwUvmOQ+3kzdAOcG/ZZcBZ15GTWX6MukaxjqB129JifZp6+2nWLtCfWGXeov9KrQU5u45DFcL4lP4eFXXheiJ78+0u+YXvSb6CCOcbfxXI6DSleA6+Za0JaGNM2fVSGVHPfwNyPjlYRK7UcN76QKMcAsuGEqzEoStw+H9oDdRWedB3Eta2fsv8dV/YMEg1g4ohQyC/iiGwXCp1HEG0BngiPysdPDyfMpKShdXzxiXHAOS8rEkg+Z6WPYbM1BawiGSWx+3sWSyMPF3Omjx07fifFqiaJrF8sz9X2VHMpMTz5NjNYPIgh/98mLDg9I70z6/3ok/EqXC+Eir1/JZU4cLiHBJFtaNocM4MsnKUWu/HABlM9IvAo9UPjogwycXRXx5ePg/nTLb5ahpvQaOLfjhPX0oP9QWOxwuFElVt+lMHrKZlvHMVgw8iN6MbCYQWnb/OGeJWe3lY6cEDOPST2mIHpFT2onPFi30ggeDv5z1/UIh9oh7J0NDDhtOxxVFgActTrDGTQM/lhQFNJ9Lcnk1joa/KFx/uRr62UL432UCnQrjfO4mTk8ZYgWBKghrTbaMMHjwnbFGQ08dcUYOtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(2906002)(478600001)(8676002)(66556008)(4326008)(66476007)(64756008)(91956017)(66946007)(66446008)(8936002)(76116006)(41300700001)(44832011)(110136005)(6486002)(71200400001)(316002)(5660300002)(83380400001)(38070700005)(122000001)(6506007)(86362001)(186003)(1076003)(6512007)(2616005)(54906003)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ukvLBKL8k+X1DVuXPhqBqYaL98BNC4Nx3JrxD4g5jsZOfUxvCijNSS9Ky?=
 =?iso-8859-1?Q?ZIesRwgvYOY++tSS3EceznXq1eC5lw7BKJ5nqPSOP6m8m5nSGdBSMt0v2M?=
 =?iso-8859-1?Q?H8JQteFM3rg7BGAeRyZfVXzQ5u+wY4Tg9SYvpbOCRYmmnepvBLxVzBMmZH?=
 =?iso-8859-1?Q?Vw+NW+WKhgCV+I8pSaGsuI0Dfsfj5mJdFqQHwSf2qF3+7IMICRU+p97Hc5?=
 =?iso-8859-1?Q?fqneJA3HTbJ56IA7rImoO9TSZvhaz1650mgdVlCmlmG3ojyV+vtU5RfLgR?=
 =?iso-8859-1?Q?RenzU+eRnweh0nyD8Up4n9wD357zhF0ei6c3FUwdu0V+tDHyPq8f/y0rPG?=
 =?iso-8859-1?Q?KYVP+Gi3243bJZglFlDkI1sbyX0JreJySry49Eg1lgepPwH366B8OXmAqZ?=
 =?iso-8859-1?Q?TJAll51p+sjfoVppFdYKhCCdpdYbAjv93hCD8ZGPr3Dqx4fTJR69Y690vI?=
 =?iso-8859-1?Q?s9dmB+HTCno6L9QU6+B9gvvprA4ezXvwXf1yMQN0/ZxutejcE2DT8/0eYF?=
 =?iso-8859-1?Q?uS+gupazU+jZ0KcpimLRUn26zQWmEJHD8Axj7d/bSNVC5hlSyBYl5U21Da?=
 =?iso-8859-1?Q?TJ7GYCu2pwMxqSacXCW77RmNWAnHaCD8weQjYh3tcl77IJtvmDIcfV3/jT?=
 =?iso-8859-1?Q?2cMo1RITWKXKj3jOn4uDdZ0zrmmiWiFIMi4pS8Ne4hhyu97r9djXIF7JcI?=
 =?iso-8859-1?Q?JYtaQ8+yKOJEJP9bRe0CSEkSsFrBDihenOVM3zBbA2+vzgzIbn0mB022Ov?=
 =?iso-8859-1?Q?26AdeIdMaPeiywicLeQZci0WPnCgwE0LHtJL9ipTWYxHBgXcBlbknF8mDu?=
 =?iso-8859-1?Q?oQ3QZtZVcXmJmZruxOjW5H6ypxcRujlClwf11zhIOU84zXlAWa6BiiAEEO?=
 =?iso-8859-1?Q?Lg62W/WNhyUwDYfMF7MzzAPHZwx/hSsZHdPxp2islD4Z5scNdeEmK3XTb0?=
 =?iso-8859-1?Q?AmQox9NIbBXF1wDXVW6lWuQHFl3QlCWkx3NB3OEpS5mXAcnsOWcmhqThL6?=
 =?iso-8859-1?Q?B8J+urcGprsk/y+BzlD5t2J/HGxZvQ71gY2EqP+KrnMPs6cq7cGj+Phwbw?=
 =?iso-8859-1?Q?b8Tn2ccB/pqFz5VNfUuEWHaXpnFoyjQHkCVGcy/bw3CPt1+oj7ybroJNuQ?=
 =?iso-8859-1?Q?qHdJ4nOapP1vVeoZvdm9x4m6hKoZcKnX/lZhc1elq2eBSRMJsy+PpP7WU2?=
 =?iso-8859-1?Q?TN47Edp/J2cFhK8uLlJ1zYN8y0P9PEKlfNQzQaTnbAglmhLFTh7epitjZR?=
 =?iso-8859-1?Q?8aTNctxOO3gh6qAhWkg7UiHAB6NJFSql9Xlc1rxW7+eDKPuz1B9vhUv7GN?=
 =?iso-8859-1?Q?X/fbMudVFBjg86Bq15ws4JBh5vZePY4gSn5v73vXwh5EjHOeoun9iPZdE3?=
 =?iso-8859-1?Q?CJllSzTD3No8UDP2pZML+MGsmFWLB9f34emF71QFNpxtt1zClJEBX0LTsS?=
 =?iso-8859-1?Q?b+5A97Eb2IWhexgA9wC2rgwgSA/mF5a/Hnw3OVuW6qZvi46pRKZOjiB0+5?=
 =?iso-8859-1?Q?6eDa6C9jOEk1CB9mXNoD+Hvi/tYQY6FDLfxi1fximRKUqy0QVY2S4NFDqP?=
 =?iso-8859-1?Q?ulGMsZweKIzGkQ6O8Irw37N++CVQT7qdZbtVUZ1d8S6Qmo00XmPt49hkdP?=
 =?iso-8859-1?Q?KSuOHkZ9eNmp3vZpM9TyK0PrMJTI51D52cEMWsayeDdKJKDGcXgCG5Lg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7139114-7f10-443d-09eb-08dac0fc49d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 20:11:42.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1ZiPKhWhd1Xv+TogOjk7mmLyBQMvT47dPfPDz+YpiR5KGekjkya8rHFjSQaivs5fJ9UdcOjtXy4eOvWYHA/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070159
X-Proofpoint-GUID: xwawAvHIIE_oZlBj7kZSKt--9E3Ei_IS
X-Proofpoint-ORIG-GUID: xwawAvHIIE_oZlBj7kZSKt--9E3Ei_IS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iterating the VMAs, the maple state needs to be invalidated if the
tree is modified by a split or merge to ensure the maple tree node
contained in the maple state is still valid.  These invalidations were
missed, so add them to the paths which alter the tree.

Reported-by: syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com
Fixes: 69dbe6daf104 (userfaultfd: use maple tree iterator to iterate VMAs)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 091d95ddf9a0..a5ed75271c15 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1630,17 +1630,20 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma =3D prev;
+			mas_pause(&mas);
 			goto next;
 		}
 		if (vma->vm_start < start) {
 			ret =3D split_vma(mm, vma, start, 1);
 			if (ret)
 				break;
+			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
 			ret =3D split_vma(mm, vma, end, 0);
 			if (ret)
 				break;
+			mas_pause(&mas);
 		}
 	next:
 		/*
--=20
2.35.1
