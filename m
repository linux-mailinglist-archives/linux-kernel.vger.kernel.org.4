Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BCC63C586
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiK2QrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiK2QqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:46:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9669DE9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:56 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGQ1wH012682;
        Tue, 29 Nov 2022 16:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WCzbFNCHID8ATnEHut/rkD+7xDHl0WXUtnEUwL54p4Q=;
 b=gnR4DEkOViVvRmVTphbHHbDjMq4fMT7/K0GwaARYY98h3gIXz+g0+guKJ0WosP9+AELD
 5vnngfM1xicGNkDqAl71SLquxFyBhdMH7IGV0axbYNfzteIXYgGGhbwPn6vDjrDyp7BW
 7uUQRiBZzNmIh7NLPOZ/6IY9Lm3gKW9BKV5pccOagerY/DTZj5haWRHIOV7OEMg4bU0m
 rtKOp0L7UABjG4N5tGlRKtbXKNQPBhV3UmYUME9F3Dygmj8NeveP0l5t9FLUWDNqQ5xW
 V+f4ZZ618d5Z6F+lOqRBE5pR5St5T9W0MP/7SvWl7AoQ5koAj3/LolhZJ2u5a48u1N4e oA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPk027963;
        Tue, 29 Nov 2022 16:44:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAIFJYsLrdlen2e7/dsLtAdvA/rL0lfi46lNS9myGqlKRGHaB9bPt3w2uAqwcU03yvD+o1rn5N4leXHv06pDqKsmvE2/uc/CsLZIavyWhsgXYEwIwiFj2i61h8JkN2AEPDBx4HqUaVLSPpV6drefQbP5t54n4Vs7IhALPjkVcS2K2YVYmWmssp2wrrlzcMK571eeb0IzyeS9UtCY0kenPakEDqUHyAGniGsqpKRP3KX67ucWeupk9woyWb0JUD9FwJ400ae713/v1yF34APwLG2TvWV1GAftcKW0EzQZ9G31IdLp+GqdNIxs6vEQFA6F67uZGPEtwSr6VvUn23X+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCzbFNCHID8ATnEHut/rkD+7xDHl0WXUtnEUwL54p4Q=;
 b=Giagn3aosE+2xAxDe0oij2fvm/i5jTGfrlkUsVld7BXbQSwNzmjNZYkEa0NjZUaAH6iPsRo2eU0/xhgjaFfQ1uWKiOcfVLLgo+i1DZjsOq4TUyKgEsDrp/82eF3H4C/I0W22smAM3i/o7Nz7/GLOQ5fO2G7xLtUIILN/wpAui7NuZyQheC62ph2Y3+TJL/XsnIxULjoHu+wuN668ohztzQpYx8CEP5zIJ2rxkP/VcE3fJll2zfZVOJQL/V9iB9wxmS6YZf5wnLa1ikxWX7jjW9yfrwLjAd2UKczJdXLYAanR4jaVFHTJ+HXUJX/hmUrkLEa/05clXd7ILm0br1a+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCzbFNCHID8ATnEHut/rkD+7xDHl0WXUtnEUwL54p4Q=;
 b=aar0dvFu1N9sg0rPoFYK8VWgJgCkRCWwLHrjhdj1D4njvbVc+tWQSoFHkatkCoumM9AbTuZjY51HzLNzRJuYtB4Unbs/i/9Us7UTJjzax3mdy8KZwDFId3Le5vI3IZTfoPjeWNBkEBVBU7tUihTE28DoyAIAfv08oA+yzF3s5Do=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 18/43] mempolicy: Convert to vma iterator
Thread-Topic: [PATCH 18/43] mempolicy: Convert to vma iterator
Thread-Index: AQHZBBHYqhL1Jdjebk6SmrW+9ULbHg==
Date:   Tue, 29 Nov 2022 16:44:28 +0000
Message-ID: <20221129164352.3374638-19-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 6e3c80d7-7e3e-45fb-2be7-08dad228fc39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBPmFXwVYx7Vbf4yKoqzhORYG3YDioMInSZRRR7gb4RExHGH+haNyudDj/Q+aKK1/bUtG17AeP5eVpmoZjC2fQZUHCzzyDiA4aLKM5aA3DA+Q2hhG2xdboQukurgMFc00wkdIjX06FQxJDsmQU6eS4ELbV4Qv3HybbCe4+iPs0M+lPEmMDSQoo2JcKfbRrS7wROqmRX9mqWf4Fbl9FKq8jbBaJ+/vlpwfvVY8vMC2R2BGFvHc0ZOHMrKuChzrt+PLbwWfjCaYA4S+FEURSO7XvXXAvcMtafSYM4xlcSeYcOLo0GbdhtKP1nlzyfYM+pwAxBe5gXbqPSdXf72TxZH2WPb+jNaT4h42OGwmm5Aa4nMQVUNyx4+Xp+U2jRSN7aRJjJjSq778DRVAKMLl4zg4It3jox8QgAJg8M098sccCev41G4XVAc+yGzcDQTIjKbmvI9mpihftqrEsYJYEv+/Pcp9dMv/CPjKM3bEhmLgUyV6MJ5g5qivReuD4KLQbhCVuFMhoJ+agAKD/yhx+nw5R8+39sE3amJ06/jVMjUh2Bt3NMXQsWPiC/4/IUR8pp0ItMnDwj/bsDoCN0ar/6/fC5lKwF9QuUHAQw2jJ6s2NAMU8IlzCNRau/X8jjyurogqcnnuA2EdUJpZETwCmMV+szBqm4J8QfuwmAA0cVpK7TihlJor6Be7rUzKH5ZiQqwoqvLFE1mMDl1FG4fkZwZyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NosAFbsXebxQpAfHo+9NkwBOzAzpUQjOjUtJ4dXPjDFFIC5eYI6qLLb3hO?=
 =?iso-8859-1?Q?A5BrOCivwoyjmKASnq0IvYVkUzmaEKvgijNYVd6visYVm2uT8cGR8gqzgc?=
 =?iso-8859-1?Q?wijUXm1fPo4CcjuzR/im4H1yxtU5vl6dqbZqIQFwSN5E5olIFgbpFlpl7U?=
 =?iso-8859-1?Q?tAxLMdZM/MSN6IW8C4y+lOdC/6oatyT+DCk6O1k5ZzCcAH0RrVDoRksw+t?=
 =?iso-8859-1?Q?/nR/nuCqiJFrXLoKH7IDkz2SPRNElH0EJXoHYVY1gS9pLrB9hoCBVH5Pwa?=
 =?iso-8859-1?Q?Y0BiZ8rnScZURTVd0A09K34/87g4o86NnAMFULNt6k8sOT7nJdGHNRDSqK?=
 =?iso-8859-1?Q?FsUfywUb7YNk/SKTvLE0r3JZ6IPzflshs5Jz4X1znts6cyRkuw5pCJT3n0?=
 =?iso-8859-1?Q?kJMD1UifNJAhUZQcNX9EHJyfwheA3RbfluBLajKrg0Hd+rfGoV+EKee1vs?=
 =?iso-8859-1?Q?nSZjKRs8TgqgiVpCiSiktW2HNss98zFPVSzzW0t6CR96EzkpmpyphVRSZy?=
 =?iso-8859-1?Q?3n78e/3cd0pboAS4XKkaz9xZ5j9FhVQyz99/EP9NyPmOuV7i9LvqZQH4Zi?=
 =?iso-8859-1?Q?aIw0d9coHA8nTsZQ0wA9FrF7PJzYxPMQVotNpcftSjSaLy4GJsffZQ7jwq?=
 =?iso-8859-1?Q?J9pO++ZUiPeHSaoIqPJZjR5Qs5M5wBPVKtXN1ShtfEgX3JWjEI6zg7tB3X?=
 =?iso-8859-1?Q?0o94iqtlVNt082UmInyqZMoUOqHQdKflP5SjxHwn6517VX6zcDKAN3QbXQ?=
 =?iso-8859-1?Q?WldYcDBNMkgrjTwb21Xybhjqywv0RdITfgmO/Sq3J2iaGOlVgvmXYdMV6H?=
 =?iso-8859-1?Q?fPU/r1w4hx5gfTNMwdMTCOYqWaljKbzNlp5vqcdGPggNLSvlGrn/lcb6cH?=
 =?iso-8859-1?Q?Yd1+46PERPD61pOzqFGi18VJu8IFVTiud/sRd3vmHSxsRGKCjqVdJVR542?=
 =?iso-8859-1?Q?Fp9rkmDNlGjUYjKsr9UHXyMuoJV+/n/RfiP2AF9QefC2Rr5jvWoA/Lhq2+?=
 =?iso-8859-1?Q?QfrTsWnyoEs3z5W/za5RiYE4/apCbwj1FZfeCyxrdEgsioYC/0HpO7S70l?=
 =?iso-8859-1?Q?X8XMSqGE7ybRoMwF2EDc+eB1mfO0Aw1qr8A1uRTCQw1T+ss4taQnDE+qes?=
 =?iso-8859-1?Q?IU9Aep8GJgHPVpW7bkoG67c28LOTwYBkQZpVl3yQ/k9lwBrgXWf8I5hdLK?=
 =?iso-8859-1?Q?B9VbEYKNeGD9935223xcZAuoDom2SauqmnvuTFSsVX6j94xPH1n2eskpdL?=
 =?iso-8859-1?Q?25zAiYlfpG0NOOYNQhVWu3zdpZrcON402nMg+bpZAe5dIjILHoWaVt5qOC?=
 =?iso-8859-1?Q?Vk7FdrMLBn/+RxewkK7BNiq2zazW0okTGMyUUBJKZkhUptRCeWZh7X1nXN?=
 =?iso-8859-1?Q?S/Lkc+CxwuNGz27bbfGKlRvRvP+6GmAXqNpHDDDi9X3UpiV7E5ZPf6Sg7q?=
 =?iso-8859-1?Q?VUfz07DyxPhxaFonyTPeYeIOS4bQyrmafIuk72Qkws6kBOtGWQwBdreNjQ?=
 =?iso-8859-1?Q?3OQL877M5V2ape4RUya2sTN+z4tE86gx48KvVnXFVpe38ZagPHpOJ2vvPD?=
 =?iso-8859-1?Q?kjk01DBIrrV7ltZRHxHfSPkPw/NhFx0V8lrNMxcYROgV3qspy/mGflekne?=
 =?iso-8859-1?Q?Ypj/XPFawEltKNICl/OF3a59q1IAoTVRhPuBpFOkvrCnbcE2epq1gEKA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tlxWaVcESzRclb00N1pt4SDiBbGENZEzZ01uXihj+PwNPtkz3EIxwt95xkKmHoxp78eS/CHG55WiF1Rt51gkzPPcAANmhiyPMe4A5/h7DxoCNnmWTe9aq3pRhz9MKoHdd0nRXetyyTdZzeiSw3ecEyNnzzzfDUrlfPCF9I1L9l9QEunXuSq1ju4DmU6Qho5uP6lB2uhpX7OJ0ffTlFEcaYqofFDPsDQKdUWu6f/I0lGwYUX9DocpItCvPZ7FK56gUmXo3jiTLV6VJf/vZ7khFGocbObD9mQXmK5wFTqvcWJGgsuimpyWvDmor7vFUxC0ETWssRZYaeJgKofPVZ4u+TMgQLIygv51xJLmqbQYuvdmXkbKsgsDPl8zd5mfquI+MVyyR3hbsR8PJNNJkdpTAbH4f64Mj2DUuEqW9r/roC2VgyTphgchiF2futT4SvnTsOnALQu711sVk0AEqQTDJbW7FkdsfOgl8Z3V7uwTgDLbO5tX0KLmLVcH4NN0Pf3y5YPLAkI6NsJKK8RtD9IoIBYZ9bJPcsAzDXKobDYxJ69+8yEdJgwn+E5urR1B5eNkePNmBNcn5D/3T75D4aqMfH5SrizqyxUPI1yA6F5+tv4rvInMt09VYCcIfCYWdyNgncns3EbkFbp+QXPbEufjYxj4VC8ANg11XtBz/Ni3eUqMCsFBPHhPVDMDOjr35v6SEcWLnaN/R2CmladTRRM69/l1V0keDDhBdFPY85Sle2DAycbGkYHZRhmqNHmvQ3SCd62AhzekLn5+Uiq4QxqtPxhS2Racqn8fn1+8vxPFoc0h1Fs9f/XZ8GO4B950FjFEB2CPzBuZj80jUxS5p/7ZOQsjiZjtoIm1y+lA1G/vmT7p6wjM6YhX6oneTGRPjTYwD/jqQBYCohZdFEgJfzZgVg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3c80d7-7e3e-45fb-2be7-08dad228fc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:28.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vxh/4eh71xwEJfzyh4nBlbiH8SvvviCtzDNbtPh36ULBNSbGQX+DcwkPt1pVW4glFs8RxyImXygZwNhuoF2etA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: 7iY1iCxjeEVUtGBrIfrmAjfd4R6gbxK0
X-Proofpoint-GUID: 7iY1iCxjeEVUtGBrIfrmAjfd4R6gbxK0
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
 mm/mempolicy.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..5bf4ab8eee49 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -787,24 +787,21 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
=20
-	prev =3D mas_prev(&mas, 0);
-	if (unlikely(!prev))
-		mas_set(&mas, start);
-
-	vma =3D mas_find(&mas, end - 1);
+	prev =3D vma_prev(&vmi);
+	vma =3D vma_find(&vmi, end);
 	if (WARN_ON(!vma))
 		return 0;
=20
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
-	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+	do {
 		unsigned long vmstart =3D max(start, vma->vm_start);
 		unsigned long vmend =3D min(end, vma->vm_end);
=20
@@ -813,29 +810,23 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev =3D vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
-			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
 		if (vma->vm_start !=3D vmstart) {
-			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
+			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
-			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
+			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 replace:
 		err =3D vma_replace_policy(vma, new_pol);
@@ -843,7 +834,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 			goto out;
 next:
 		prev =3D vma;
-	}
+	} for_each_vma_range(vmi, vma, end);
=20
 out:
 	return err;
--=20
2.35.1
