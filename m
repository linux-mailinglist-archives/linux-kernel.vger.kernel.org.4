Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3165F456
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjAETWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjAETUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1686F943
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUR34002869;
        Thu, 5 Jan 2023 19:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5JYDubWmB7EXh60uJz7Pi7ZedtauCJpMP8gKBFFvuxo=;
 b=B9xNfZgDVSWykte8mOUqOXoeJgAccjzalsAI+PSTyZitxriEJ21M4Y7ij/Q7DLlXibVF
 3quVBgoZJH6hHgXz9OAD2Xi+FhPk0SBZqn6JiPUbojEfBZiKL6j3kPML7NfgSD+S7L08
 OiLC8+NmvJ6uwktiqJQ5WqUX54PuePQ6otHZGakteaLdcbtSo8eUEFg/SwdjWGUuocZ5
 xb0n77lbJObva8thhHEptBTCIZprbmO5jCNaC/H88ZoX5jd5pjxfw1SSHCZhA8GwxUAU
 Ma+uXZt3T+LKBlp68pXuRgt3BzJA8Dw5HSqLKHyeK4Hie2mBRkDw6Acc2WU0710kgDfu 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11q2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I9Tnk012151;
        Thu, 5 Jan 2023 19:16:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0u4xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOzkADEc9xCBPkVN77rvlj/W80W3afvzOb1Ke5vLqPQDDZ6tyg9n4tcH0mtRVt+5Jh5mbl5hLteV+1Y9NwWDsnvUsg3XqT10NsuXxbHqsXd5aUW+4jtpYjSVEF2T+Tye/ttGpTeqSIw1+E1Wcbdps1VlR9vkiRiS1w8S6EF06rE5XnsfsZpT9pG19yEJMJEbBEzowPUKtEIJtgR0b5UpNM3qILB2jM2TvjMds51MVtdqASdw3DsiDtE/B2hoiM0FC4xa6lRb5tWWRg1TAIGcRGRXYUy03v4x9n+g4t+EuMLB11uY7Xa2sc7+GKVJ746y0Vt2jBR8WdlC4727a/o5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JYDubWmB7EXh60uJz7Pi7ZedtauCJpMP8gKBFFvuxo=;
 b=SyNLvTx1RkIgf4F4JWQLi6I/ye+hGfUE3CEndUqg5HKUQ+wDU1JZZtEmLdQcQSJjGacG4uaZzVftrijOVI50rsDWHFSaLsq5PkTwoEapTXv5YZmI3Ko8/lxZb5xVQrJkW6UNFCmX1SPREX6ekHApXY/F1IOswbmcwO1CMRPL294A2jQg2BuaPZ2aFrJlKG2521RIqJm6lQNrNtu0ZnR9LOqEAw/p1DVuWiSQDzsk2XM7nZF70XSM8rpZqKixD5+qX1Iguf+prW9nXnfJ7GKKHKeydJlprmiclAlpfbATNRTiPOjVouZbHCcO9mJ8v01OxcGsUnFUU9Me9h7VXI2eEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JYDubWmB7EXh60uJz7Pi7ZedtauCJpMP8gKBFFvuxo=;
 b=cvveWnGO9YUphKPIdi4PZkfiT2VN5+Xwu+tFoyTOxaRcFEpnsfyWVJ/mnVbrUlXccTdQBOFm6JOwHH+yzT92Xy6UNuMpgB6oP+DCj2RD9BTpQn8KnLSrsJt8e48ozgq1zGaQfP/c8Y5D9StvDOKvueutnsWSm7Jt5lAD6O2JXVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 42/44] mm/mmap: Convert do_brk_flags() to use vma_prepare()
 and vma_complete()
Thread-Topic: [PATCH v2 42/44] mm/mmap: Convert do_brk_flags() to use
 vma_prepare() and vma_complete()
Thread-Index: AQHZIToo1jpEoi8x9Uu43vq+N6ajBA==
Date:   Thu, 5 Jan 2023 19:16:05 +0000
Message-ID: <20230105191517.3099082-43-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 6a8d069c-abd1-48fe-93cf-08daef5160b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0jnPFzfSEnxPS2CxlgOlwOzged1H+RDcEHTX7o740eI2UCmcioVCFR/VN5cHP41uXK1jEbsDwII3eX246w8wlzLC15uRRi/oSaj4LMzrXEDfshEHmitwnzMiSb4ZtUMvEiWFYleZshbv1cjxuMrX8cvwbCzBxNja4XF3DOUGCzY1jifnFg5LrgwjZQYIFzDCCucfJ9b1+SBzj//I+oi1uZtiRj3y1nVnCt7Lbs43LQQgrTlgusQ+oymxoNuO+ABmMTJvhw5ozYFFVte04S1g2dwNikuM6x7GqjenqPdIXhQwNUNV+FdwR6z8h3m5lGXgP0130N/RwNlezF2A27KCRMm90dnmF9SqUDiWtG4XwY1BE8ribdG4W4yGQfg+z+y1WUWPMik0sU4+pg2NxaYhJ4b70oqfjjI2Oj5/Y6p/O/Jz58D27XufuPxhO7n/21mpjYsZ7HDnKRixeXvavyz/3Wi0Ukx706cIp1/2Zdl99iVteeoiqOU4pMoIiJdiHjyA/KXR/43iuXmzEjsdE+x5NSRIpYEsQUoVeJpPV7S25oukTUbI9KO6apt1blIiiAS7zJeMOM0B+uil3bnSEHf14JrhUp2IJFwQLgQwgzVHubRhzrKIMjSKRvnohIIDiR9JKzWugHLv133sBTeyW5cfGPgEY5qPpUT6RTTtEGB6ItHfsY/hFJ15wH/Ubn7ziNcXrNW4daXfwE20oCgSqpy1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CL/cPdwsA42VHkKoyiZ/FHqeHxu2f6Lhj7tHGkFbHpIuH1xq+hZLIn/qKT?=
 =?iso-8859-1?Q?bSyFE7Yj8TvEtobhcWUJwGJZwvKlrhcT+dpHab9pmNzSM3WcHtaqOhehK9?=
 =?iso-8859-1?Q?ZRlnY/oLWkjZXnqXyfMlpWWNipze1am+5UcFxL+8vq8cJUVaRF1xKU5ddj?=
 =?iso-8859-1?Q?YobjabM3hK+J/gtPMtUGDQG8Ap34y8mEoGuTXwMkXvB8nMlp8/799BxM5C?=
 =?iso-8859-1?Q?FZg/w2zlQlZ/m/0/RN+ZUDAHA1oUlr3RuzgEb92xgTxME0NG856NJyfDgI?=
 =?iso-8859-1?Q?T72mdyNTayUaXobVoyuZWI7vFplXeBCf4S+xiw/dPRW9mVb2t9j/27jgOn?=
 =?iso-8859-1?Q?NNcv3mcrSwK/Y5VwmBpXU3RwmosjyIIKgspfkV4NoH/Ty0Wgb5Pxy0BNA1?=
 =?iso-8859-1?Q?pAxOd1txOLCLl8d2nkNQHNDU6dXzZTdZCrB0P8wlW5Sz0BW6eSCXbQRay9?=
 =?iso-8859-1?Q?iVCIPk7DSqIxOia7UadNM1GoiR01FtCg7BWzZ7ZYgwL40Yxb8aweOMpirj?=
 =?iso-8859-1?Q?Oxy24dudBH1lrO23WBHseDwy3x9nGJfJVCWveLSvZgpJAb1ue5hLwW/sbP?=
 =?iso-8859-1?Q?MQtrG6O5i2p+q+5HibW3PxCzow2krUip6K0cbfr6NqrDp//iYt93lmM66q?=
 =?iso-8859-1?Q?q7ml64trUkN1ESfI+V7SKUW+J77ZnvV2d6Cyoj6qWP1w+mopalTcsEwRLa?=
 =?iso-8859-1?Q?ZiudfM3j6svovmdeRFLQPGIfjS6NkaoxfWUdGTKLlXQDgjVR8iLt18MXFr?=
 =?iso-8859-1?Q?Ezn0LdYSrFkwPSo+Dsqy/P7orgiodU/dLOgr58A28FaNOQGhqdjisW6v0k?=
 =?iso-8859-1?Q?b/BhxOh6jplLIDotIU5Gu2wEAho9+GD+F0ojw+StT2AQYCFYyoPlMP7vG9?=
 =?iso-8859-1?Q?vIG4xYq/2bjvqiwl5GHpymhpeC9mcoBvp67oxQom0AhKSuEa5UdhqdN2aY?=
 =?iso-8859-1?Q?82x3t4U+x3doOnzNFJB7+puvmE97XkNNGjxnWx1pcV0mMPupt7z/8RVVdG?=
 =?iso-8859-1?Q?hvZ/R4D6dP5ehqYXKOsAL/whmD1Oi3LqwuS1oVd+8DDEiPB/hqiyq4LwsY?=
 =?iso-8859-1?Q?1ucc980SMIslLcFnpcdG3eQsOXaF7xhRLy4TszWcTvbdjRWQTLwodV+G9l?=
 =?iso-8859-1?Q?PxXWFwfV4Lenu+Rv8G2sbFiDX3yJEdMgY+7aV8xgUV0OfQgqp/mmYnt3Gs?=
 =?iso-8859-1?Q?8/mbaSunAsVf5Bkq+uzudxkOAIpZabwPoqU69BeSnoX7B+KuAgnTIX+72r?=
 =?iso-8859-1?Q?XHS8UbvuJIbSD+mK4wNfMkmaUU63WRS+wAs5ZUsGV1nExdhnVEQHHkxr0k?=
 =?iso-8859-1?Q?VmVDWoH+jCu/RVQequR9iczeLBcjZ/Uy8TCIk7PTOqo997kgTZR+PTHeYb?=
 =?iso-8859-1?Q?Ww/lWCCaLwf2ahisVN+6wOir3NP3n3grlWmPYH103gYpU1B3dMjaUwPdbR?=
 =?iso-8859-1?Q?2SuM1lgdcKMe0GqLJbW536aXMBO1hpWV1KQ84G5NjETce2WJyMLCF/gJSt?=
 =?iso-8859-1?Q?m95GvdOMwQwGZfbTGbqbck5fybiWrwvM7KGKVDmJFPJqobUx+NapmV0vT+?=
 =?iso-8859-1?Q?borFEONrtyyoGPdIPb2NWNSupEbVCJTLX5yLXXNeWrGLV/s1ve1smOc4gc?=
 =?iso-8859-1?Q?GbIDhw3WbWHHZOZoQvsGlaRNEe7kM1OPxiOLGRZygbzfoaLcWSQ/ouVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jhUSM9vB+VVrJC3YTsNIO8MBPmeq3vmIMVFEHsV4DmchPlSFKDG7w+BLCZgqtz/fiiYriSWiON8aVm/SqS3V3tgHfWaELf8fv4Ms5fnf6YNsIof/J7NSu5cvbC1c46JTkzU2Zjb/C8rMcH4Vl2VjYuhB/Xs4BI2MBkGR5Q/SikVtoxVVrOQ334xR4ZjNRymrrgkYAThSW4jHEFJDUHDdQfWUDUPEisKyUkmGFmnnUdrefWv1N4c8hPOl+IngC5vBj9GNLlP9g+xMfqASErDj6ao4io1ZFcYfeD/HqW/QdPBZScMkrxUacc6eVkD4dgywi9fI1SG1fU9zp7HQjMSm+u8iUjhKu71jCCiBWMB6PKc1yGBd7ki+vCOPVUKbFtt3NBCg485/+vzKI+vEl5dTIoFGFnpps6/q1BIF6kRn3yFysvFiYixTSujkEkQxwmyn2PNwVOmhGu+WYRmRIu2Y5MvliHAAH1NwrI47ABqtv1y8IBr3L8y1nJVScPsNzH8HyicPNvokiVeVFPmrwUDKbjBJHyU0oDrK0q/tCBjm++PiF1xiENHtglZwFqW9bho6Qlti0Aw1a+UGBx8gktQdp5KuXpXqm6Hr9XG7CdeAjYlzvMiBevTIpDJUFZHOqoZMX38J2UcxQURZOd7uqDOl3TtQJKSdWo82B924NvTXrJ6Y/wzms3EbYrjGqaV9bcSmDLS4Zagn9rZlCalLuQZEugNqaZixcjqtEYfOA+Zor3QrVFHTJFphBF6Fv9G1HBMmg6IxPc2XuIUcHIh6HdprR79PfpnzdeW6XoB1zPU8NH4xdmPkzlwLUw0QKjo+n+bmx+8m+BZ0vQJXxoRMJ/CW2VHjUtS4GYSgXxbAiEvQI7mFSrUf4TnKIeggk82hgafAH/QLL8TbjfVD5V9rix4Y1A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8d069c-abd1-48fe-93cf-08daef5160b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:05.3751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfGaQVHihMRLWnab7rOGr9ePEd2YkrWFh6kmaq93MxMhyWD/ju7pKv6KiTxyw3CWnoXtE0nV55Oypt2yd6tIww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=931 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: GkJNdrijSKzPXYb_-nQCClCUYeKvt1jP
X-Proofpoint-ORIG-GUID: GkJNdrijSKzPXYb_-nQCClCUYeKvt1jP
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

Use the abstracted vma locking for do_brk_flags()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e9b8eb00d45..6dd34e5ff1f7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2979,6 +2979,7 @@ static int do_brk_flags(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vma_prepare vp;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3006,18 +3007,13 @@ static int do_brk_flags(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
 			goto unacct_fail;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		if (vma->anon_vma) {
-			anon_vma_lock_write(vma->anon_vma);
-			anon_vma_interval_tree_pre_update_vma(vma);
-		}
+		init_vma_prep(&vp, vma);
+		vma_prepare(&vp);
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
 		vma_iter_store(vmi, vma);
=20
-		if (vma->anon_vma) {
-			anon_vma_interval_tree_post_update_vma(vma);
-			anon_vma_unlock_write(vma->anon_vma);
-		}
+		vma_complete(&vp, vmi, mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
--=20
2.35.1
