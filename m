Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72314628AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiKNVAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiKNVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:00:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055F25CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:00:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEKhgMC024578;
        Mon, 14 Nov 2022 21:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=qhv2M620bwheV0dYuoSrIEGWQ8xvwSBR3h5/I9B8Sc0=;
 b=3OHNJOAGKgIwCfz6OShkRE04mfszKZxD2aKRzVXIoAzyR/ddqQD6dxm4V4ZVW7oO0JSJ
 /Yy9fKNFDQ8UqZr7rQAHJrix56e0TFJwizyENrEDQVupyxrPTAz38LV3euWw9o/XtJ0c
 67BOipL352pGN3aKOOGmF3ViaArjTdO8/901x5TXyC2RkLo1Cv2HKWNLnz1/CXlOCU9M
 idXploTBURMMtoDi7buU+tbxC6a1ksrt2KOqKqo+GwKUBzV1awd0Nt/LvCLpS0lNpQBS
 cHGL0Ttzu3P/OD1gsT7F4t/ZeLFCAnubb54iFR7tZ85Zm7WrNy5UzGYyBa3GoKtKC9Bm oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2egn6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 21:00:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEJTmNW004526;
        Mon, 14 Nov 2022 21:00:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k5gnu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 21:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqcCZcPeaMh+yvORJR9/bCgFmEpArqjy65VcAVB7pVxHw28b36lONsiFBXZvkx7axUu+JsqMOwpS1M/sEnoJgPRFHdOof8aQVtY8pqjcqgIirzKSLchn6ZGV1xkKhP30yis1Wm9oWUAJYjaSmkpmknm68mQfk0mGwvTo8p3dVudFJwTADmpjaH0+jDyz/TmJMoN2b5E3cadf7lRFdKjjzQGG3byxWL+EU6EAkUG1EO5a+YF6/0VcqOfIAVCRHyHR/39r6JdOi/LD68jqVHCkSl6lygm8XKCGD6heD81MYdljhN02XKpDylgIsTrFxT5Tv64n7fnVRry3RHttDAXkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhv2M620bwheV0dYuoSrIEGWQ8xvwSBR3h5/I9B8Sc0=;
 b=BwBOWLoF+G/aIWA5TrdocNF5u+ZEXe+yU6+rFjcGAFp9rUU0S+CNuxKOdSA+eKEDT/ec1X0IFDEPJqCG7p5bsmVcgrYVrE2trJ9a7Ub1iDlxkOnKzfLXj3IGmAT2y/Ahcy+CQdn2WIKLLp6faQ2v6X+Pf/Z1rwPgpgS1KZhMxzN3rkDmL/EeZrfieexuMgljrNhfQ5eLV21tb7JtZkGcBuodI/7VK7YLvX57oa5e1JIErN4QX2dwPwxBfcnRAumF5r6twfAD2eJLpn9GnlLiTTpFWQIocXYPdCHzzsyMRU2S8w9CmAq8JimoSdfwv5vQQr27vCQHIXCZATUI+g/zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhv2M620bwheV0dYuoSrIEGWQ8xvwSBR3h5/I9B8Sc0=;
 b=kQ8TJ8iIdGUe9pz0B/HfxA0+ITgj5wavhdr25Xp+yxBXT71L1PvQuaCsN0i9SBmHTzh5Bkr7rJVN/68O15vwGLrjN9kp6Hh7Rroox997rXVw7OEUNvANHk0Nfvs1VVzHIvR3CStG3xX3UTIiQr3BUnhCcvCUuf1Se7XQDdhOLXA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6670.namprd10.prod.outlook.com (2603:10b6:510:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:00:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:00:25 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Nelson <doug.nelson@intel.com>,
        syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com
Subject: [PATCH v2] ipc/shm: call underlying open/close vm_ops
Date:   Mon, 14 Nov 2022 13:00:18 -0800
Message-Id: <20221114210018.49346-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb16634-b633-431d-7c12-08dac683407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEZn/V5GJ8GumTXmnI0tbBkz8esFJoC6xn56JpuYJtTfuKt524EHpc8HYO+bjgL/AXE+rCRBTYhODPfvvNEDMu3sN4/AdP4NprdygdSh/c+zGWAmYDADoFPLVfStE3OLx9c8EWsj0IWCJ3qkI8ipJY2EvJOrhSujLrkp9wrP0wyKFDObNRg61430qZBnv89emzZ+8eWmrXcPyUL6Oar5PrS5XnxwdUOOXbiMryTrbezMix9UWX1n/JRRZPlFQG9nS10+AduFh2/iEh4b3EjdLfK2Tcs7ReuxjTIvjoGMpEkQSlD0W/4L/awsPDtdGV/u49Utz1ywGiABgBe7Wbsi4EiFICxGqSC+9JM9ufIzlGEF6bohGHwr70rsa1bjFEwFDXJ5zz5P13slGpgwPxdd/nROXxOk1qFX5M5k+Wdi2YG5oBAr0zgUucGjHbbZnnZB5yitRgYgUB2RN2EaD8EGBLE6LezWTVglQbwq+Csm4qKa8cw2Cuq3XQMOUYloSVtOWsKYHUsRW0IiV77pKPHqoRNZgHEU4vFPiMVslOeLp47zby/c9Eo3E2fjt0OpFHO9o2YUzpBBitIuMyqsdVZSA7sfM9QKqv6mT1Z0+DgF8A27kdoByI3CXOBIQvXX/Bo7prptrOXNVcVkS2rJcEB0mcyWQVqlgk77EXm0uNUP9e8vqjVYrh5lMa/BIt1JFoeYlbHtyzMnu8ZSnHopbmCDIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(54906003)(6506007)(1076003)(186003)(6666004)(86362001)(2906002)(6486002)(66556008)(4326008)(26005)(8676002)(6512007)(66476007)(66946007)(478600001)(44832011)(2616005)(38100700002)(5660300002)(7416002)(316002)(36756003)(83380400001)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDX0mzgHT1Fm7RkJeGLwcdOig3R/Rdgmu9jrml9aDYWbHSqq7aPVlktskgFi?=
 =?us-ascii?Q?I+RT0vkJOAkfkzn/3oXQQ15lAUcEA4c1+yl1bzQ/mIIJ4GLAp9n0X3xLYVSt?=
 =?us-ascii?Q?qx9nZAzopi3SUDly1RzDPRhLZvuogeCxK/aqOOLl1GzXJsOQI/zYy7j9sylF?=
 =?us-ascii?Q?rhSg9d5kPiXpQGUD8PLP4UFd2hPMDBAe8Kiken+hupPe9QFPAeWAH8v39ero?=
 =?us-ascii?Q?UPwa6svPydqPdw8pq+9aIASNWFjQMXqJoCQdxVt3/uUrgG/LdnsNxgjbeg1O?=
 =?us-ascii?Q?uhYqxjtH2dk2G+3jHiUl0OGzZT6Ecb9Edv455Mb9WFAziymqhvyIWTrBVx5Y?=
 =?us-ascii?Q?RivLgj6KT/GKSH17BcmPCRpQEwZ+OfxpvItXzG2aNrMGzEgzVSG/4ZnaM2eg?=
 =?us-ascii?Q?99PSZabvxByNX8pdz4H9WAWMUo3JVbgr8erFnS/zxjeRLKJCLMqsGjjzcIEt?=
 =?us-ascii?Q?3Y5T1FkAqsvvYchwVxhDSxm//y0J69m7oWP2Yf5g0UDTQr/2CprMA2fj5U1q?=
 =?us-ascii?Q?VcW5ytxTUpMXuuPIOrI7YF518od3zjKtdUyam2R1BBB4hjQFWAvt1m/UOmkR?=
 =?us-ascii?Q?I//t9jphvl1lXjYlz5YMK5y+IyQknMbiCjEkfrjV63PxRoWZFSzIVkq+ilZF?=
 =?us-ascii?Q?NZjve1hFhtLeBBdxICsuOObj/ZdLVTNfRnNcK/A78iOcNeaWJwx8Rro3BNQb?=
 =?us-ascii?Q?CJ/7C7LGcQ8aj8Q77v1X1EHod/mqwVOGLIwWeN2wJXKon1GIP4A3x40yrtnv?=
 =?us-ascii?Q?oH8xxfZ611R9oBuoTWK6FyJLsXeMO7smyVI8m/JBwATRaXo3rukW4ukgHOwq?=
 =?us-ascii?Q?mp7zL53tOF7Ub5j+RHa20gM8XZxUqSdf/lyWwWLJayyJQnoLg8ID//wPk1FK?=
 =?us-ascii?Q?x+EpokQovuXytTKlQLmxuvSVCerAI+hnNIR+O9GaBlbtvZ3Mb5XGsfhOZww/?=
 =?us-ascii?Q?0dgYcYKdqBtlM3tTsOCM05JrSDUOSmR/GkRDQmzlmCsiK9/WGgFLQf0PZqkK?=
 =?us-ascii?Q?BRvJ61dNstIKsVWgEncfDh1qxae+CXMwXlBc7RsTrQ0gM0h/Ixzru08gIVyh?=
 =?us-ascii?Q?bJdQ2B46B9yUjn0oUmSM4/AytM6YXZiiUOOk3qIdXuE433Ww5YrPku5ZPpUs?=
 =?us-ascii?Q?oOkUkyYai8mYkB/V3vtaos4uX1GlTn5uADXENqeHxhj8eBk1ttW+yY/1XMoT?=
 =?us-ascii?Q?zVKL4eoQjteHIQtw6+L0zF0MeK7PigogDy7g+mljc0HmuQhmEzxjeC1Ct4kV?=
 =?us-ascii?Q?kx8AmUVtH8Tr4cdbd6C5J3qxlYOoUAzyzV39tlyBuXJVcLS1vrK6gJ0Nfrds?=
 =?us-ascii?Q?qOMW5RLD8BviRUtx9IR4trcz9mOzf42lGOAcqUBAXHaSB74c+nNCBd4hhmew?=
 =?us-ascii?Q?g/gU2/l9kU8mli0bQMO5HBNn3oXk2wypCjgalZbATF6lbq5tvdIlKb8VMuVS?=
 =?us-ascii?Q?b0A5Dq6CY9M+GQgx7oSoRF6slvtP0iYtRJJlApF1eMeADhNGbHRjrQ75CoUD?=
 =?us-ascii?Q?gDOC3Fsd+Pgm5NyqvXxlacjEUt/Bded7TfndSaG9bcysKO10wjW9Ml5xdlR2?=
 =?us-ascii?Q?1CrogeVdSfRjiiZhadIV5PL3D0xczFQmPpst/AltBfdkqVah9VwNqHDJvVX6?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AODZY2Mhrl9Uj1shmxr8A4uro3fHwTR10yAHqiQiLXYKOoQJi28g6Q7PXMbd?=
 =?us-ascii?Q?PYwEd7bTr9/HhYpshHsPr/pGLe0MgnT76Jh+0XbqaDkxw70VeniK2VVHGkoJ?=
 =?us-ascii?Q?dMVFI4bvM23CenWD2ULtv0/4brlHX8neG7yQ35IGTQ++ZbCBmd+9RfskB81H?=
 =?us-ascii?Q?fVNNr3vztn1LXuu8an9ZqCz6zLY0kHQmDv/G5WJi2g9LYGLIxusCbjfIGSKn?=
 =?us-ascii?Q?30NAKhs4FbaFB4wqhp496zO1gk2VAZUhAuJD0u5YxUF74fjc9qn2OSUkiEYj?=
 =?us-ascii?Q?LIeThFgeyOtIUQsERkK3cPyQA38430+BpxCxI9DLpzY3ra+hp1a46PwTR1af?=
 =?us-ascii?Q?JN1frTIhn4QD/fa/SerbFJ35z2gRPF9JWGdjHnuORjlUs78lTMpGjKvVq0yk?=
 =?us-ascii?Q?4ccwjk7Au9nKXYrAbHNtif4uhVQPkPLvBxPtV4QemH/Iblr0xOoot6J2dIY9?=
 =?us-ascii?Q?xmmCcmVTIYtzlCArAe4DqfcswZM9PzVuRqfbS3UneMv2yTvvo6AepI+09rLo?=
 =?us-ascii?Q?VMI286+2MNTSvD1+ayRCGUCRdcq1zLpcaxVyHzu4NdAdOaexOuoVkeYUiApp?=
 =?us-ascii?Q?H0DVCHjvvv78qedUbYYxBRHtagX82rHFPHQ+gqGDiEtMEwjPSi36pQNOAK9S?=
 =?us-ascii?Q?RNXMCz0EgM9bZmT00lW01YQtkIhdxRRoASflfWuj6RvrKQErYI2o0W0AT2Ul?=
 =?us-ascii?Q?0qAHt14DcL+PI+vkr7Sh4e3CL+fLK2e99vmmAUB7nFlU9ro3Y4KwHD506Reo?=
 =?us-ascii?Q?DXQWZyKmLWLJHA/cvHrLX3QlsazIXVKUuvArvg8q4cizVneQSwTV+GFhrILM?=
 =?us-ascii?Q?HBNAJ24947+VXYVsVNSiOEnKahIcCFOnS0t4QzYni9/pVMFzViL1ceWyH0DW?=
 =?us-ascii?Q?r0oVZJ+MdovrSr9idP22FmqKBzDUL1d+0WJOxlyWLBVzAqevoh2d1sBTaMfR?=
 =?us-ascii?Q?k80UIu6lAFOMyVUIeIq+JtSyVvc221YoN6ZUnSXhcAr8AXX+hJw6tC3lTrQq?=
 =?us-ascii?Q?CTH9kOkxOm9rHNFLJLivliW6Mh7pTU/AG8R82CL8pRip29TMdxXmFhu5gqyB?=
 =?us-ascii?Q?oMLEcNs21BlSmIni0dnCc+T8m1/U0umU7uFDa1ucXY8OHW1NRFHW1r2lgByK?=
 =?us-ascii?Q?lfSl1G2rnPE9T2QgFcezT2Jkp7a9LDKxdg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb16634-b633-431d-7c12-08dac683407b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:00:25.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOzJFXWb/vElUO5SCzIEy6YwLGJxnT/7u5Ymt4ptq/FQebAtMOXK8QXP9ftpD8kU62VoNqMRLlh8wRrvSh1Yyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140148
X-Proofpoint-ORIG-GUID: dJvCdkOH_ggecZiO9Oi4OGpyoHYYjHsi
X-Proofpoint-GUID: dJvCdkOH_ggecZiO9Oi4OGpyoHYYjHsi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared memory segments can be created that are backed by hugetlb pages.
When this happens, the vmas associated with any mappings (shmat) are
marked VM_HUGETLB, yet the vm_ops for such mappings are provided by
ipc/shm (shm_vm_ops).  There is a mechanism to call the underlying
hugetlb vm_ops, and this is done for most operations.  However, it is
not done for open and close.

This was not an issue until the introduction of the hugetlb vma_lock.
This lock structure is pointed to by vm_private_data and the open/close
vm_ops help maintain this structure.  The special hugetlb routine
called at fork took care of structure updates at fork time.  However,
vma_splitting is not properly handled for ipc shared memory mappings
backed by hugetlb pages.  This can result in a "kernel NULL pointer
dereference" BUG or use after free as two vmas point to the same lock
structure.

Update the shm open and close routines to always call the underlying
open and close routines.

Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: Doug Nelson <doug.nelson@intel.com>
Reported-by: syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com
---
v2 - Fix call to shm_close in shm_mmap before setting up sfd->vm_ops
     as reported by syzbot.

 ipc/shm.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 7d86f058fb86..bd2fcc4d454e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -275,10 +275,8 @@ static inline void shm_rmid(struct shmid_kernel *s)
 }
 
 
-static int __shm_open(struct vm_area_struct *vma)
+static int __shm_open(struct shm_file_data *sfd)
 {
-	struct file *file = vma->vm_file;
-	struct shm_file_data *sfd = shm_file_data(file);
 	struct shmid_kernel *shp;
 
 	shp = shm_lock(sfd->ns, sfd->id);
@@ -302,7 +300,15 @@ static int __shm_open(struct vm_area_struct *vma)
 /* This is called by fork, once for every shm attach. */
 static void shm_open(struct vm_area_struct *vma)
 {
-	int err = __shm_open(vma);
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+	int err;
+
+	/* Always call underlying open if present */
+	if (sfd->vm_ops->open)
+		sfd->vm_ops->open(vma);
+
+	err = __shm_open(sfd);
 	/*
 	 * We raced in the idr lookup or with shm_destroy().
 	 * Either way, the ID is busted.
@@ -359,10 +365,8 @@ static bool shm_may_destroy(struct shmid_kernel *shp)
  * The descriptor has already been removed from the current->mm->mmap list
  * and will later be kfree()d.
  */
-static void shm_close(struct vm_area_struct *vma)
+static void __shm_close(struct shm_file_data *sfd)
 {
-	struct file *file = vma->vm_file;
-	struct shm_file_data *sfd = shm_file_data(file);
 	struct shmid_kernel *shp;
 	struct ipc_namespace *ns = sfd->ns;
 
@@ -388,6 +392,18 @@ static void shm_close(struct vm_area_struct *vma)
 	up_write(&shm_ids(ns).rwsem);
 }
 
+static void shm_close(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	/* Always call underlying close if present */
+	if (sfd->vm_ops->close)
+		sfd->vm_ops->close(vma);
+
+	__shm_close(sfd);
+}
+
 /* Called with ns->shm_ids(ns).rwsem locked */
 static int shm_try_destroy_orphaned(int id, void *p, void *data)
 {
@@ -583,13 +599,13 @@ static int shm_mmap(struct file *file, struct vm_area_struct *vma)
 	 * IPC ID that was removed, and possibly even reused by another shm
 	 * segment already.  Propagate this case as an error to caller.
 	 */
-	ret = __shm_open(vma);
+	ret = __shm_open(sfd);
 	if (ret)
 		return ret;
 
 	ret = call_mmap(sfd->file, vma);
 	if (ret) {
-		shm_close(vma);
+		__shm_close(sfd);
 		return ret;
 	}
 	sfd->vm_ops = vma->vm_ops;
-- 
2.38.1

