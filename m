Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280766D464
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjAQCgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjAQCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997452B082
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H091BY006716;
        Tue, 17 Jan 2023 02:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=70VD0FV6++Xvp93lhJdXkO/1eLAxSinyU0u4BGcxwpE=;
 b=LLk7v9CO81SCconK57H/s+yQrDwi/LHE6T53yJhCSBDm3EbGc6GYcgbMJL87J+9Rwk89
 kDTOVY0ec5WZHTrSZeoqSpvNG16JN80QN2+m/LS5Il99x2Y3PN8zLDakj0IkEqEccnjG
 kTunfkMg1go7jyS1sxtqPJ4Nyk4LJzLxyogOMHKtFt6PXwUEbH6M2RGLIYtNWAzWx+bP
 Btv84JqDbg5Q8v2EBr2ouONeUMdnrc+8Xm7JIIhQ36SYO01qBEvu0didkc8YhQ/QmO5E
 jiROYr7wk0gVovSvMf7zAtCplysmoyENvmGYHcm7cxxoDkplxqucZAfpb3tfB1V5MCCS LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tkp08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0V004833;
        Tue, 17 Jan 2023 02:34:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSRBJbK/rb9zOflgamISTpR2OlP6BkmIR0u0Mr0zsW1RtE8kI4hQJ4YkGVOSYmNuMLEClb5Rh8sfo6zpH1XZ87Kjs952YCWSUMHS8oXpZnGA7y+0QejAM1eKyrTlM9u5fAvLHULjO+O9tyzsb84+UQUgV6wXCVIs1akKX2GQgt8uLv/deU4wkaXtw/FF2FOGqzAoL2wshRoX1NtzcfIPxYNLlpwpAlkpSpfGdKPtErXgFmolUdRnWLWLbeNje0E+I8n292M68+Q6SLkLerU2B73+rtg/s3TX22Q1wVshnjH3ghhNF6lDQVfoBNE15cePcc7dkTn/EcEu79EnaVycww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70VD0FV6++Xvp93lhJdXkO/1eLAxSinyU0u4BGcxwpE=;
 b=IaJ01SffOOuef56FLUAZ8QmLrh/bJXWUkLkYYTIFhre+QXkjEDIffL3nEOgD1pyc1RaZaXGwDtAbeP1VIz04tK+nG4BFpJp9IQO8LSwU2j0leSlgrY9s0kWxJSnFNGu9hqtRUkJhMCFxD9+lMIeAG74dGMQNa+pCvY/8KKGh5AJKeuAi+3g+/GG8gKgD9XoGO8WcdRMO1cARTTdPw+bpJLeQalucncvO2K9JbzvsG+95YmYmeFxnCe53uSBKA5u61vRrSB+FFWhEB6pYg5yQBiw2GQn0rHXBeWbZGLuYHNpUGYTPzcuv+XifQlv1y9KCCrzvOIuJRVMtcGWPHK8PSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70VD0FV6++Xvp93lhJdXkO/1eLAxSinyU0u4BGcxwpE=;
 b=AQCLeMoUtdn4V+ZPr7OQtHiiUlBSGwD4Xsp5aITFSJ78F5Nl1XmkV3uLzO8mqFlZ7vZiLSvFzHjR+JZr9zLUKauN2/DlWTqiZiEO9bvWzWjDIcWkk/4toJwQk/oVBs/xF0mTWkVWlXiZcBJEqXKild3SChXI/XyJLEl7G6EJxLQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 21/48] task_mmu: Convert to vma iterator
Thread-Topic: [PATCH v3 21/48] task_mmu: Convert to vma iterator
Thread-Index: AQHZKhwxCx8GvgirI0CZkAgmDYLl0Q==
Date:   Tue, 17 Jan 2023 02:34:16 +0000
Message-ID: <20230117023335.1690727-22-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: e1393d10-a8b4-4e57-2407-08daf833560a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJmZggIOEvFYbZ2u3gTkL48sKQxF3hyxd6T8uikBgPIsfFRsr/uq8/BIP1CBw6vYd4zYkMo+0fySlkk1Z7DEowIf38I2fpjgP1XX/mpN1/WiRet95czagbunjsCogHT7vINQzU984kZmmPTG4AXHzlrTmCbWu0QyOMRWrQJqjRL8EtKHnbJE9A7CJPAVRZChrRPv5j0HbDf/JOP1SykutE58aD7eMhpy70ufWglkw2JiEZGrvmMiQLIvVTdYf+d9/p3a1XT3rKdRIbHedP4cas8SOWhPk/4VZSlr/c3a/vNYZ2IDXm5DW1Ci5XKP9s9wbXevtEW9vGeBLqYlUnC2yKaZyfjxS9ndhcFlodJQuW5dU53LMssOFB85NGvMjSDAjI9QFhvj8al9GvWCudrsdETt4nNKtosubRO+UcMOpPXNv12whQKDH5gsfT5/D/vGpn5JSnEBgjqwVlF6+muPkbK6uDTGa9h/49eT+Uaqwh8RjRNm26QjBLQMCnpTZ+C2Nm1zXz39z82Q7vYIH5xUuSnyzZNegCGg+V6AG0fe/NVh1+UISKK33NqAqjNl14H7G76rKK3Q2t3jIMo2tD6kLt4nhFxV9fTprS+9LZDYVicLNLJ5y5jiDYK99U6aO1doK6edRTRptedKUErM4UnFkK3SyjitvIKPVNlAm2dRfu+5t1HaE2WE7bqUv1nPbl1lBJno86050cyRXZo6vOjoOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cao/ocZTjIQXf2gEFYy/7Yr79FfdCqluclHMHjAh9oQJ4AJcCv0TbSfGEI?=
 =?iso-8859-1?Q?6OTY3l7LCAjVKjSmV1teoMzBDTY0w1q4tzMsTdwGHYY54+LFtLYXXdiljm?=
 =?iso-8859-1?Q?vS7blYoWQ24fCPasZ5qFrHRx6rqpdIUhWbGFL/BScUy80ri0qtz0UVmq3+?=
 =?iso-8859-1?Q?Tog2YveJCCJ3oCmeYyGCXnzHLpNeTkghFQW1eHtA6f1cbGbl0hZ0zS7Tz5?=
 =?iso-8859-1?Q?mDBRczNOdMyT5sJlbJxeFMg+M64Pdz5UH0CSizJnyALrll+gZA/dYKXt3i?=
 =?iso-8859-1?Q?7xjUDOhjOR5OddoMIE0oPGZsoX6DIIVllqY+/wKx1uECQd4/SxOx57g9CE?=
 =?iso-8859-1?Q?9xYn48falhoTcu3+8+0/k+R97tZtj4+SElYm4xBx4XRZgEw3Te+FaCxt4D?=
 =?iso-8859-1?Q?2RKK7dWUuzm3WmKLRmkf+BqA/J/PUUwBvkdvqhRx8j71PGz3mJ8h5xeZZu?=
 =?iso-8859-1?Q?p+e4X9hGcrESlhRLR2CFawkAwMQTOA9WnH6uN9TXnQBkU9AUJ4Y0nrQCt/?=
 =?iso-8859-1?Q?r0QPbFsSYdwbeOrH6VhL0tgOfm++xjx+eIxHtsPC0Qhet80Hm+VOxn9Nod?=
 =?iso-8859-1?Q?JslF6Xv7tAPFs6CBzcw90wpZAagzZLD8RLpu8E1cQ/nYqLsM9ePeTxXksp?=
 =?iso-8859-1?Q?gTfxOY9uF6HUfscQgNHPwhxlJRoaeZE/33PYBhKC9lp8EU7j/a9zvT5u0p?=
 =?iso-8859-1?Q?hVaUvlThckdrimQ1utXIRPdR+Wte9eGdlHCWfOlZ0ijpuw+BfzYQxV5evN?=
 =?iso-8859-1?Q?qy8QR03aLvBmgcZbhsz3pWorDaY8uJ3udoa035TPi6+86/qD5olg75szKR?=
 =?iso-8859-1?Q?QHo5rc4tHTdY1c/yBagyVEcf2tJ18JGuUHu9L3SVbY9ZH1/NfiKLbN/VHY?=
 =?iso-8859-1?Q?Pb205mui1wezMRodR8u1BFDWtV6p3Kc2oIknPpHZmu81qE9Uh1fMUTFy0r?=
 =?iso-8859-1?Q?laQbrfR12xpFAYDRV3/t4qTg4DkQOpx8hBWaWMn0PxV08bvTLjQV/Exnco?=
 =?iso-8859-1?Q?0Lu4GNDuaAyIeabpU0DlO84L7Ojebr5/M3UELySHZRJcXoKSWr5rz/Kzi7?=
 =?iso-8859-1?Q?ofHoXMa6Lo0dKssNcCXPbvgUGg9crH5HdIVkt1niRUv7rlaLrXM1i3IA2U?=
 =?iso-8859-1?Q?qPpPclQDI60G/Y8t9i+go5dV7IDeWLsVdh93KUZceAqG0flt9Mg3fy/x0Z?=
 =?iso-8859-1?Q?5g2LFuoBr0/BhdJ71qBmqCPA9RcIhxdnkYTO3Pd8XIMRiWE3hTV2ceLKJ6?=
 =?iso-8859-1?Q?sINp2kH1xF6fArsCiyaDEMcecG8Ayu8+Ldlb/HUUZ5HZdRDl4Xqzgw4giO?=
 =?iso-8859-1?Q?clIltgMHWHvWPEEwTklk8mar7LAS5p3fVxhLDqjdzBIE0mka8rs1My+uRO?=
 =?iso-8859-1?Q?4PEn74dzjSb1EOtLBLWNIORahhU4PuM5r0Axc2lHiVSsWL7SzUsnlBOz6K?=
 =?iso-8859-1?Q?YxGRErnb27UYC/rHrXk9Hb34jdXHiPWDExrb2OfVug8kLJyFXcpO2WORJP?=
 =?iso-8859-1?Q?v0Q7ezdlbadj9TGFG8L63CPWLFQyOLocFVSp+iqRKevjdFLYr2KXsxJcBe?=
 =?iso-8859-1?Q?/T5FJ/e6QqD5ajrh1U+u32Fadc9v+qn0LIaXFwNCzXooLLJxzpphh8cQUH?=
 =?iso-8859-1?Q?qkt5RvQOuJmltIoYgYJhB3gKyN7Oc3J1QpdvEa2p81cbTBeXloW84yhw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UwApPphCwYhuGUVOAFRCdSS/tuCXU9G4LwHcQiWu/ImP7jisIKp6JX85gGKHjZeeZWDsBevIsQ7vNSdSNY3wU0YFwhLxqLjJKrQ8B1ptRYah8KFGSKD59AWWrZ4DtTCy1N0r7KFwgGP6KeWp2Hiilusma3/bpD/snov51buqFYprEfo4MEEXoe53mWITcRAbunGSmJvcf9ebLc13BMTmbyHtEjGVLBuaJXvK3I42Cq51xXY3sbW7qJCCk35mj2cJ63Nq9gEVHdXcLt/2LLycz2zPvpWtnRfoUk2u8+Oja5kKvWB1fZboKjA2ieNslMcsmfpRa7int0QfooqRu+wtwIpy2T2NRpb2dVD4j0c6HgwtZLx7Rtg00id7oGCOY+/WPKHhSwE7q4Md652ftrMulM7u/3DQE2RceF/6rjNdcsrw1CIGRHHToHwLL+zy+Hza5LhIgooN7VQ2TF61iE+I1R2NC0Q0jxUTZB5QdQHkyPbFkoxOJ2+gdXKKw/xB6rK3wgzxy6BaYGADdKSOuWxAC42es2YwvxrB7+asOU8jCRh4WK22GwQdd/UfwrQYZrPAb84Qf0ypMl7S9aXKiTqMq0wtbcJ51YI6vGKvZjyk86dSZlJ6xgNtfvoJDKwUYtN0Y6ERLNBiBpPIqaZjIu3PstQdbMPeJ899LG5YEYHEGYmjFyrj0Ul/Qi2t+16hEdUmcirdDKN+FHowghcaoZvW7X1QPsL90M0x4rs7Hd0TNtv+DBADMhwEYHtfLPGAq0BxbksTZNhUemM1+EbKy29fXyGZrpotJTT6M0l8QgM+ZbonDyc/9cMhipP+iJuoDQiNSja3/2+z6SwCpvkuwQJrgz/pI/Qqcr2oMVk2roqT47Jg32SyeKOQYOtW142mmMesfl6hJbWUCT+3mTdiVA7XZg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1393d10-a8b4-4e57-2407-08daf833560a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:16.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Cxw9Kvc94+V/qTQS5m//+f8XP71qZSpsHwOT4yA8fE6Rl61Uk0xdPq16PCUPhonssmQrBIAUrcoEAyk3flBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: KduFsRjvXVWXfZR25154aESC5iIE5ZWy
X-Proofpoint-ORIG-GUID: KduFsRjvXVWXfZR25154aESC5iIE5ZWy
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

Update the comments to how the vma iterator works.  The vma iterator
will keep track of the last vm_end and start the search from vm_end + 1.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/proc/task_mmu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a0398db63..be8d54e45226 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -892,7 +892,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 	struct vm_area_struct *vma;
 	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
@@ -910,7 +910,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma =3D vma_next(&vmi);
=20
 	if (unlikely(!vma))
 		goto empty_set;
@@ -925,7 +925,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
-			mas_pause(&mas);
+			vma_iter_invalidate(&vmi);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -950,31 +950,31 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 			 *
 			 * 1) VMA2 is freed, but VMA3 exists:
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA3.
+			 *    vma_next(vmi) will return VMA3.
 			 *    In this case, just continue from VMA3.
 			 *
 			 * 2) VMA2 still exists:
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA2.
-			 *    Iterate the loop like the original one.
+			 *    vma_next(vmi) will return VMA3.
+			 *    In this case, just continue from VMA3.
 			 *
 			 * 3) No more VMAs can be found:
 			 *
-			 *    find_vma(mm, 16k - 1) will return NULL.
+			 *    vma_next(vmi) will return NULL.
 			 *    No more things to do, just break.
 			 *
 			 * 4) (last_vma_end - 1) is the middle of a vma (VMA'):
 			 *
-			 *    find_vma(mm, 16k - 1) will return VMA' whose range
+			 *    vma_next(vmi) will return VMA' whose range
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D mas_find(&mas, ULONG_MAX);
+			vma =3D vma_next(&vmi);
 			/* Case 3 above */
 			if (!vma)
 				break;
=20
-			/* Case 1 above */
+			/* Case 1 and 2 above */
 			if (vma->vm_start >=3D last_vma_end)
 				continue;
=20
@@ -982,8 +982,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			if (vma->vm_end > last_vma_end)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
-		/* Case 2 above */
-	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+	} for_each_vma(vmi, vma);
=20
 empty_set:
 	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
@@ -1279,7 +1278,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
-		MA_STATE(mas, &mm->mm_mt, 0, 0);
+		VMA_ITERATOR(vmi, mm, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1299,7 +1298,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			mas_for_each(&mas, vma, ULONG_MAX) {
+			for_each_vma(vmi, vma) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
--=20
2.35.1
