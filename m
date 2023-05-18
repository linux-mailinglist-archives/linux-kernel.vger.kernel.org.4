Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865B47076C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjERAJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjERAJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37854124
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGmu7024476;
        Thu, 18 May 2023 00:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jwFiNCCgUL0VI3Ycq4EQVA93drqmxGxVRfjEFaK27dg=;
 b=KoreWqtZBFpkll4A4wlcCOJ6TGFFkVOg6rWLajfI7XKuoaMHoai0TvvO3xVEtRxK2at0
 ekuUPM6Ve/leeSFyVcOja/Ced60TsfAIxFaUmdADzWeyxtlMATZ3LlIDk78OeqA+AGZD
 KsSN0ymJjz87ZcsLq6P4Tx6aPCwPPF/I1HrqPHpt3ZzrwEZABcpmFE/IOyWYl2EtPaHw
 h7MHbxv1+pNk+7u4gOr7SIrua9cOTiX9kWUn4uM4f0RsgpN2lP2IbTJQQJ/lzxSDxRDV
 W1Tdys6qDesSNSsn7/hBhzqOoz+5vnYzuUpLy553rO26duES4z8kOANTtV706xKoQWfy 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphcu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HLRZr3036369;
        Thu, 18 May 2023 00:09:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm033xjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbWwarojPJ5i4lMU1j91byMZFGqN0eGQielT6TVDDAnGns3JhNK+63G3n3SrIhVSNEIO+bLHeJfyzttCpYo9DmReQbGcV0Lyozo0IgxEzeGkeBF+0f9IpH+zxF2d1lYlQIUKYbK0aS6OdQcUh/l8LzJdl9hMvIhZFYw/CboFwrVSffdfQ/CB9UX8X0KQVJeqmaS+j6+HSTkrO7QKB5nNUFG/qQG7AqZ1rmGA7NL+7OIJM2nrZl6UZrnEdRzZBaiX9Hb+K/lzPnFWCpsBAQzlqUFYcb7/ViX9T53RDavdOuA/B9l9ZF+phD5LgspXjtAopFlQynNGxX6TBm8utOjnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwFiNCCgUL0VI3Ycq4EQVA93drqmxGxVRfjEFaK27dg=;
 b=Of8HorSw0egy3DSJmGOPrhGrNb5QoFLjWtIbtP4st8+pEw/aEg2a2ysw6wEw+l87jLuSyjWcqk8LrIE+hvLU/JfXr5Li/88q1hBBO3Ix7/LOy2Bx3lNw58J7Q/69+vSmX1aVXSAmx2tCv3B1Sokzyzjmez1I3xRb8AP0K4Wz8l6HK9eq04IAru4OFCj3t2pq2B5Hy9KzHT2F9h//s/BOQCA13Ffle+QVzquNUoVd+d2cH2gJx+a1BUJgbD/AjfI6E+fi3jyDgWsYjjUG3ZfuXeb2NWRcfhYSo36ygLinpaiSaz4+V8P2Du3aEyJAdYjpbmLXmIUBpO29hJysG/+dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwFiNCCgUL0VI3Ycq4EQVA93drqmxGxVRfjEFaK27dg=;
 b=lS1/HL4+OS47xEbTPxTEZSdHiY0bQDui7JlLjLkfPx6p9/NKbQK4vFSGFfeMxwvWtDM85swEJ7jK7uxGuPfUfe85TvxQh/8MA2fZKiwto/nJb2SictBGSIshzN7wsGa3Qv0+i329F4eFNwZjAJ+u6DcLtdPK9jt6bT+x2ZsxFp8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5332.namprd10.prod.outlook.com (2603:10b6:208:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:25 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:24 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is set
Date:   Wed, 17 May 2023 19:09:13 -0500
Message-Id: <20230518000920.191583-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0065c-cba0-4b43-8051-08db57342357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x54PGkkDBZgxavPH8wccnbci4bUHgawyfnUVjVZbbcKWSW1QXLtZPo5Os5vyaCIBebZN9VmJ0rD7aQ+v0XBjkbnEIGtEp4MO50MHdSnLvjvES03zwcptQVTsmjIYxb5Gdq18mCDH7+YYt4kkushRelvtAe9Q/6Ow5dtsjWjjU1ovY9WjJhGRFAUrEkGK5wXFwvs8nxSy9srjJBDgexd6FEPoJ9LxjioClb9Etm8F0BBWbYfEUWJ/zKPLbAikcDM3TlC1OJ+zGbNuPtjSkuuTu8v0LpwpCAHPug1zA7P8dwtFLDyT1bTkeZmP8EsPCreOHVMLFtm5B/0pDkAhDwIsca5+f52im0rcbMKsKU8GeuPZQ42uOLp7jnY/PG6diV89mf+h6g+WBKEB48dIZGWNFN4L6ZJxtMncb2gHIWKIdxnHVkxTkrj2un6/uRZGhjjPCP7WNJuQrLoHTi4aBWdI/c0DQn1s9jUCRG7mgV5eC9PClCjsF+BWE0eAkpyxvaK3xvx+fMtTGoQ3xM01v0mQo7NwzoWvr5Ti/JnPiM481+GKQZYPgbf2RNwaq5shJb5Bgs4W4Tx8uDSnI8p41XhGILK9R3+fdm+0nnmd6zjrsfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(4326008)(6666004)(6486002)(107886003)(478600001)(66946007)(66556008)(66476007)(316002)(66899021)(41300700001)(5660300002)(186003)(1076003)(8676002)(8936002)(26005)(7416002)(6512007)(6506007)(36756003)(83380400001)(2616005)(2906002)(38100700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qa38ueTRsm54Mqe1ENHqxqrD9LGTTRBKe/GymDGFORU7lIFbqir7Dy7r7qrC?=
 =?us-ascii?Q?QcVyBUCyqMAdcLNEWNp01xKr3etj1oGUC5ThpwB4YiKBcVlMn+pjnBIiCPZG?=
 =?us-ascii?Q?FrckrDI2NCRe+pRcM5aEOJGt3ED2r3YI3hx0MD1l3pE+F9rOvRZ8kvAeMlGn?=
 =?us-ascii?Q?r2C01t4ZASDtxmMBvKFZlcfcGtIQf3pmXFVsdGb/URYwJfoRY/rR5gMjA5mz?=
 =?us-ascii?Q?Y3IwWTCKe/+DJGzRkOg/fslfSerWDibGRMfhR0rR2hz/Ug/ELfJKrbO5W0ak?=
 =?us-ascii?Q?Q4HTD3Zq2LUGwan2WxW6ohri1iH3/0M1ORxFunS6LoankTIifM8GzEeEOBzY?=
 =?us-ascii?Q?i9G9m5Pniku1b8NVS4e2c7c5mpWn8VDetrtOv3aWEUsS0hLR4PvmZQKOy9Bm?=
 =?us-ascii?Q?ijeroy+ATZvVPm4GG9tmkF1TrSqCmbcW0m4SsPR4P1dHnKxVzaCBVIw5o8nf?=
 =?us-ascii?Q?8Mqs8wkdmQMKyclKgDa/vEVI8IRcVTSMr+HHpAq14eghHVP0kqF44VV45lQu?=
 =?us-ascii?Q?zEzt53tUx9HierZQG76c1mvfI/3O/L43gt+Hy9faGQCkx5ou1c2qHr6+mx+f?=
 =?us-ascii?Q?lZGCtkaivZfVNVXRTsqMYNn0opGzrSjlTyc5RAWNWDgUweA21DK1dcXm9dSj?=
 =?us-ascii?Q?fO2vQxCOV7gTIXJ1DeFs5ZXrzYj/GkQ4WoisLB6jKawFkWGiwt9/HU/dVyFo?=
 =?us-ascii?Q?cFSaLwt05CshWk/00JsnvbuEE0Omh/186E1ERb0/aALZ6KI9X+weER3ycQEz?=
 =?us-ascii?Q?xtKKeuWNj/6JYYx0X+d2KAi/a6EoylhZXtf1NFxs4K4i0cYN95VckKHIEQUs?=
 =?us-ascii?Q?fG95JGMw7lpaH6MlL+NtaX5hiegI9czbjvp7pUD/9W50lS3iovIbrgouLlrL?=
 =?us-ascii?Q?Xec/9dCYaGHHkatPmuMnUT0h6pe9T0UbJVw/j3OFLEuqHSFo+kSzfBYm+5XM?=
 =?us-ascii?Q?8eYN8oKYptLHlkhwC0rxCAvrr9gk8plqAI8A+3SG0gBhMyivxdM+zHh2MjIo?=
 =?us-ascii?Q?AmXLQZgBmy510NzM+afn+PaNNzYdIXXnbBP2FWQiuw3VXuf0sBnWWmrR2Bq7?=
 =?us-ascii?Q?0YdqZOMN8lJBAgYsYKfqRlhdwmFAf1WedHNd7EMylt4O7Ro9IK1fxnu/h+Z9?=
 =?us-ascii?Q?S2CPBt5v3JD4orOuPNkN85DYzI5UIjaXDqBPAj4OFvxHDCLK7AdtQkMbuTTm?=
 =?us-ascii?Q?Nl/F9Ud6VL4OL9G0eAcXhC4oKMMuHEo5G7RfYoGtOX4dIlO9gS0RlDgQVcw3?=
 =?us-ascii?Q?mXKM5FbhseOv4b1m4i/FKycoMiiWQ33/5hUBkBpaJiqY5DvuMz7qgyNz20Fz?=
 =?us-ascii?Q?IfDqlFDUnGpbcudVBW0B7F0RiQXQ2eI62NomZ0OnBBZNXVAGEe6zXb597YGF?=
 =?us-ascii?Q?DtZc8T/e0jxRiZZXpeav6siWt5XPInVKL5RfuQc7BSKAal+TuFglKt9Wjtoa?=
 =?us-ascii?Q?w/iL4ssZbz6kBh2t+PMbjxxtahC1yBjgTIHsXqN1jGsnbjOe4gOss6tUJ2cF?=
 =?us-ascii?Q?pdd3bQL0+NFZG1C1HjOLmeqpH4VxJjWH8+tOlvNYCwf8tTU0pC2FrtLItJSK?=
 =?us-ascii?Q?HieX6G4I8MeeRFzD5TGMch+rFiqJqixuz7NKJgThPfu8widrAH8opKmcn2FZ?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oYUN+Np6cgf2jSRuqas5duvT0Ybt/4dFNZC87uknYVushpAUfIGFf6j84gPI?=
 =?us-ascii?Q?MRjztRUMlAo8ZUMhnTjmNHHe1v1JiG/SfQNN/ipCA+wWUUZIY6Onu7gnDc/A?=
 =?us-ascii?Q?diCRKuDJ2ZZBBzzZv3ooEvS/5RuqkWJYXB9BsqCBDUcbddd1DGK0wdt4aN5B?=
 =?us-ascii?Q?xjb9xPulRv75xklbrpQE0ox/vENzmMvYeTslfHcWdoHluHkPw/nzByFADETI?=
 =?us-ascii?Q?/Z8VAEBLLLqh/xP2WEPc1g5HPSgRxiLA+TThc7vRYX5nYt6tqd2Jqpohujlb?=
 =?us-ascii?Q?ZKvtoQAK2poZDcaJ3DxVHYdirTZjTVSDoGiQa2/YzMgI5d+3m54zrlA99hmX?=
 =?us-ascii?Q?ok5xOlp+6sfAO1V6X01NEKhhMtwH+0IJTeBRGVuaW93t3seQOy6XovDYyji0?=
 =?us-ascii?Q?cfh8po9RR1iZIlbQonSbWuv+bH20NJM9T4CP0xOMvSryMnXqW2KQp7hS/ILD?=
 =?us-ascii?Q?uVwnI1C1tqTqpAP3FX87XK7mE8II9Ktw8GsAurMT/iNXONH1F3m6lmOsvz2w?=
 =?us-ascii?Q?7ISX7ymx5gyCa9lac+R3WrPkCY9bk0PZWmqAaqD886WHAJ1rloFKAiJc9xwr?=
 =?us-ascii?Q?KURviNhtNuVO7M1GC3BmUXHUQ6DfS3GDWbdjX0AKrqM2ZSBg2ZxttTKhM2Xo?=
 =?us-ascii?Q?dp+pJJdVb3sUvY3g5N3BHJWdIB1PwvTH8V+/FDnhwuDnGg5lZOFwibeJ/cJU?=
 =?us-ascii?Q?WOdiEEfalR1cq/WWFvFm8r04m9RsT8ZjDL/q6w6pBl5uL1bZ7biX9MBOUUc7?=
 =?us-ascii?Q?U/ioPFaXoluhQ5y0dQ5EFz+1ehPoVGdAbugx1lntSaAOhcw+qdGfUduilMfN?=
 =?us-ascii?Q?RZ0nei83SHvo8wcsVw5CDPFK2HfGWxsuyDkS9CD/229+fkgqT8jfc/0RH59x?=
 =?us-ascii?Q?Xk46TZYQArJprRKKkOM6Q6KF8J7gPXQ+c93R3KKN7ggvZGz7P08Z2niIOtDx?=
 =?us-ascii?Q?kSgFsbiOzzO7Sh35e62WaAlKVJPDVKatyf94NtXM8Upl2nuZIMchgIGGpHaT?=
 =?us-ascii?Q?E8GEyjBMTtv35er0/8+LVsIZxEikP5uWE6Wy8EI2PI3OUungcs77ONd3oVyG?=
 =?us-ascii?Q?dAZrbtBe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0065c-cba0-4b43-8051-08db57342357
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:24.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFp3NYFitGmj0TQgVW9WSR3ryz7CJh9sKRwusIJwmxGifnavZcK8c821+6EmUjHccMZFgjdOifGxrLI6rexpNb/cESNLNOOq/J2eTqjts9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: 9afjv7DnKXY1bngethUvki5SIqEcxoDH
X-Proofpoint-ORIG-GUID: 9afjv7DnKXY1bngethUvki5SIqEcxoDH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has us deqeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is
set when we are dealing with PF_USER_WORKER tasks.

When a vhost_task gets a SIGKILL, we could have outstanding IO in flight.
We can easily stop new work/IO from being queued to the vhost_task, but
for IO that's already been sent to something like the block layer we
need to wait for the response then process it. These type of IO
completions use the vhost_task to process the completion so we can't
exit immediately.

We need to handle wait for then handle those completions from the
vhost_task, but when we have a SIGKLL pending, functions like
schedule() return immediately so we can't wait like normal. Functions
like vhost_worker() degrade to just a while(1); loop.

This patch has get_signal drop down to the normal code path when
SIGNAL_GROUP_EXIT/group_exec_task is set so the caller can still detect
there is a SIGKILL but still perform some blocking cleanup.

Note that in that chunk I'm now bypassing that does:

sigdelset(&current->pending.signal, SIGKILL);

we look to be ok, because in the places we set SIGNAL_GROUP_EXIT/
group_exec_task we are already doing that on the threads in the
group.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..ae4972eea5db 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2705,9 +2705,18 @@ bool get_signal(struct ksignal *ksig)
 		struct k_sigaction *ka;
 		enum pid_type type;
 
-		/* Has this task already been marked for death? */
-		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
-		     signal->group_exec_task) {
+		/*
+		 * Has this task already been marked for death?
+		 *
+		 * If this is a PF_USER_WORKER then the task may need to do
+		 * extra work that requires waiting on running work, so we want
+		 * to dequeue the signal below and tell the caller its time to
+		 * start its exit procedure. When the work has completed then
+		 * the task will exit.
+		 */
+		if (!(current->flags & PF_USER_WORKER) &&
+		    ((signal->flags & SIGNAL_GROUP_EXIT) ||
+		     signal->group_exec_task)) {
 			clear_siginfo(&ksig->info);
 			ksig->info.si_signo = signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
@@ -2861,11 +2870,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
-- 
2.25.1

