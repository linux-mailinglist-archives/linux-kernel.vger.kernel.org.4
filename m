Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B539644FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLFXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLFXfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:35:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968FC36C4F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:35:36 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LIeee029952;
        Tue, 6 Dec 2022 23:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=IrbPa70IMHYzOt+AD1BT/B3H7kDMvBl3kPIuZCk9l3s=;
 b=UMRqu6ZgkKPoyuHHc6hZO1rb6uVyOA2rQHi1UmEUR5ACwLxbPVE5e9HQx9YwFeSEkoE8
 HZU+GqZEBcA0XzycH/YtKmUYScdWM/w3kgTtX6pzCb4O64UFjQVg146TynQTN1nmuQxP
 RbzbQikQmkGywRAdyAwFCmnQ0Y22wZeq+WDFU3kN5mby6kpYyvhG8tru8m7rcN/Tsx1O
 vhjZf2JVoxCUsa1K5zNipaJBITmjtA80Vqg8K6u2qKXDXgRzRYemcaj475prqIw5Crt8
 ahpPt4uf2jkdBIi9KZXdhUAAg9x51tYXnHhZPECm95h8gPqrjLRTWcg+GK1z/GvsGS9a NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgs41k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 23:35:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6LH48d026205;
        Tue, 6 Dec 2022 23:35:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8enxtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 23:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkivcXa2+bM1zkxLc3WBkl1Bmq8ro6MQh90gDblLrcwXfLt69v8NIsjFzPSWuAHcd2KUYsZI6FXe1x3lVZ3hgYMZihhAxLybfGx/NSePANChP+xOdKFDBj6x6R+Om5jvZwpgzsAD1uDXWrOMfxQCcNsDm2OipC1gPZKahIhUTwgkbVEXRfNEvylMwTnYPyajrBybIGkgFijFKSqngmhXCnLV8GJoyHYMa8w1FLYwpQY7zRGVhibc4GKNFVWcsT/iNOinUtIncHpuRTnH6w9I9l5D91ECeHM0mtKH/UyHKwasU9HTwoX4YDR4sXKAcXpi4sy/7dL8E+buYWRIOCmhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrbPa70IMHYzOt+AD1BT/B3H7kDMvBl3kPIuZCk9l3s=;
 b=lq39/pfI/aqK/j6L+26hc7HEH5RlT49E40bQnAuIzfonnr3UdxYcMZ92QQHUArMvpftZccpgNibonR6QmaMOHugjY/5kkRcpo5iJi+o+qrzlR/8jgGFpZ9febzjZDxXusSd+lB3SbizHpIwwTqK09kTIl2z+zWUu4P1q6o5VTqdMFTv3k1r3b6vz9YlVrXb9VzrKjYlGkEzOeGzwhq+ty6/HlPZkE79UKaJYE1t5QExCWNjpjLivyAps62vXf+SQy8InVf9khqAhe6JageO+zozoVGX9/TpKSs4Aj0Bc+BJdYadVTHFanEzwcdChhTuDVmuq5XSHAlkV6NmE9BPbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrbPa70IMHYzOt+AD1BT/B3H7kDMvBl3kPIuZCk9l3s=;
 b=BKj+zcS0EPpsOhVRxS7LnPE6xg+fJGIAn3rBe7kaH946XA5F1/9YkWoQgGdA/qEDvQS/l4O3VDypEkfIp7k9wdSqEBlvBeKRp7xXfrmy8JKGddoYc3Je7E9ccOS/f+brLNifEWj207uw2v5ytiadYUKi7GslLUM3qATRoKA9cBk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 23:35:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 23:35:16 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable] mm/hugetlb: update alloc_and_dissolve_hugetlb_folio comments
Date:   Tue,  6 Dec 2022 15:35:12 -0800
Message-Id: <20221206233512.146535-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 726386ed-0cfa-4555-a35e-08dad7e2879b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtfJeJMopXu4zS/U6pCKjlvgPVhEOjEIpmTreLm0ZPBXhzwXttSYxoL4BayTQxUngzfpDEf/5SEeFPHb5VgCwBBj+ToYlCYd9XaqnPhzJahGt08aeCR1qyulqLK96Kpdy8yMyL3TgNoZ4FGIemRn6FiD2mApp57mRgMIfSYcBEsb0naey+0v3deCNksYrCkFWFg1QQbCGF52lRpfU9L0jLC/vi598OdPK2ROjR4no1YAjMOgEWQ+0gyyxv8g2WRMUVoYnyJphSi1RguYJLZrjvIAtj/1nh7g7xQJ9/bI1rjxeCu6xMTAQ9Ck6FYuw655zPgUiK0xXW/HPtVBJPaOaVs9a1NDbGfDzjwFGh+FH25AZy817mbywwjM661VVApU/RUbPFhMSABh/NE0Goi7ZLLfwXbF7IRgfmKvcQJ83cVlNSlfF2hCwJGxgBr4qHzgqAgn36kCcuBZHPJ5NaOZ9OJyvyRRKI4O6e1bxZjFM1Rze/B6ZO63+5wj9f0Z1fBlkDRwVwFwbni71fxqruGvuUakVI3n74mddDJOFEpWJjPx19kCRqJPWGl5wgEad0yp3nZ1oNJlKgAQLWQPQEHJ5+E5lUkkU4kH4qJVNQhSeHqVtrPnOntF9UiMpS5QzDFmOqbBOgKRY5rVhi/6DymLvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(36756003)(86362001)(6486002)(6506007)(478600001)(38100700002)(26005)(6666004)(4326008)(44832011)(107886003)(5660300002)(41300700001)(8936002)(2906002)(8676002)(66476007)(316002)(15650500001)(66946007)(66556008)(83380400001)(2616005)(6512007)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PT1KNBiakDqc9zKJ1Mlk3AyPxXJ7MT956CK9PL0UJkEts0+gYvLzqDO3aSQC?=
 =?us-ascii?Q?wrIXEaznAW84RQAxEJsE++kdq+h9H3Je6ZCqZmgYEELot6TZWvLDlVe1Rxlp?=
 =?us-ascii?Q?PkmTLkR5g35+JivyY5JoctABn0QDmytBJRPLqowuDsnD0oygXtSbkYtcGkMA?=
 =?us-ascii?Q?ff5Nzi4QIc/6kiwwbOKXatvL/AaFnaULECdKe9+Z2AkUtolpcwtotkAiWNsv?=
 =?us-ascii?Q?3dTuFFEbIWolTX8k6XKT1evov2f3c2nrj642IYKVm/d2fufIt+c+S0uFepKv?=
 =?us-ascii?Q?+RtsiGF2aqJX5ldvtAMzKg1MFeCdCotp6Ot8p300IMFMxfDvm8qxLyQvVpVb?=
 =?us-ascii?Q?MlIe7xCw1+i9GedYOAU2CRTh1xLKtIZ6jJX5pxx03OTH9H/vil+85JrAm/JH?=
 =?us-ascii?Q?9UoZScRHgEP0CDpBImIxmZWDRHnZzy1niLf3AAAT/k+H2+89T3Cf2gM6Sv0Q?=
 =?us-ascii?Q?LDwFzb4IjSqC689+kXG0xWcrxAIBh2aPy+0mAgnoxgJHArEdtJkeZboeYwWw?=
 =?us-ascii?Q?xVRnN6+04QJLOEzxJhoV15CnZS5H001Hid5pypDxcUsvCz4B/RqB0a63Il1X?=
 =?us-ascii?Q?NZqVcMwBh4/05vI6UY+hrvHe3oUCBioTI5OpY5wdlJFcxgsoljnOyMSbFwn0?=
 =?us-ascii?Q?sgvZAw0nkFplMmQ1/+FeYlx6V6dALH4tMueefW5h+L0P+0urfClacUN2SGMR?=
 =?us-ascii?Q?TOVhizYa+FcNGG/osJVA7RGCfCQJQk5Tf1rZbCHdamBcqHRHLXTIPbXPluKA?=
 =?us-ascii?Q?RU+jB4F9jwhooTWAudemvvaF9MXOahVBKOGWn8MZYbmfGfiMLjXizrWFeXe7?=
 =?us-ascii?Q?wxY3KfWqf11Y4IU2moozPtMNW5zvae84buzN+NgBLzsbT0ylIfUQeVeN3WGF?=
 =?us-ascii?Q?fEfBTR0TIoFEfcsAwxrxJPv8flx9YWtQRlK12REXPZZ7SNcyrqN1s8dhA9fv?=
 =?us-ascii?Q?o8ZPqBixRwy3WoeTFo8BPMHp8D8dqrRl7ufS3qwsU9/wqWZaRX7OJdzj8h7J?=
 =?us-ascii?Q?+bhRtddDgfdnxPn9Lp6P1ER1HOSPfNTMrNQSrmY5ir0uYJzU2Zn6NO/r7OYM?=
 =?us-ascii?Q?w6LU+4hilWFo6UC7/k/XImBC2sIoohFD5W1SX4kz44Xl9R4T7QUFgCIm1SSc?=
 =?us-ascii?Q?1B4roUmKVl68z3IFax7HAjaMaDN7mudG9KGbsImZb+Yq9mNSuRniGfkkLjD/?=
 =?us-ascii?Q?6h9BJDlY744zVKJWGtrIfCuevp3a6k5mTooDRDQ8059StaLQ3s8AYuuFI719?=
 =?us-ascii?Q?ptm6kdiw2Ez+nAVn9H+/zuC33XA2xsNl+pHVtCkYecBxxZ7VcVnKdW7zfnVG?=
 =?us-ascii?Q?LiiriHN8gLZjb0WParPd5HW/3pB9kzWz25mIfXxpQ4CFxFpVc9P6x60zK1UT?=
 =?us-ascii?Q?POCoJIk1q0B5tgFPLQG2UwRPQHtE71vSioUoITP4tB4XhqgbGxkES3QKdjIB?=
 =?us-ascii?Q?ELE9u+YVVwxPOSm7XyNnYi/EupeSjiTT0qXs+Fm8Qh+XzeTiVJIrvy72CbGS?=
 =?us-ascii?Q?xLRnkLutzVA7BEN+g5gbrjbZ71iGT4RQbvO8cVfZP9f0G0IM3qfc5KdhiR+e?=
 =?us-ascii?Q?UVAtRdg7edL6znygE5AJoqogWwI56UMJ35LT9m8XqYTLEC0JBK1lzOKnKqdE?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dKPRS/BXRj+rxlRqtYylA1UfV4PB8I4otHbjxyTUJSejIpa32x9hp4tUgeUy?=
 =?us-ascii?Q?JGxQ9idvXX9o5lYjWo59l9waATC3kPhm9huFqGcq6daZoT9j4rmxZb2fY1Uu?=
 =?us-ascii?Q?sQIm0MTC0R+sxCk98R3VqsIVlfuHrgXZGTgvqlpebQJ7GwQqLWi4DweZ1AGL?=
 =?us-ascii?Q?2a7syDHmHY5UCOp2EDG4YNAbiSFnHi2SsDi/xGN+ovnN0AGDyNJAJwzm13aO?=
 =?us-ascii?Q?wPuiaEpdc+WmBJbRZXx1wF987ideTKtJjj/KCCBaIpWbOvn0lJabk3xyMmhD?=
 =?us-ascii?Q?LNUevxA0hCVUprSBWv54lZD43vDUHIq+Da7JY1DSB+9LqMMfYqWnLr2IRUtK?=
 =?us-ascii?Q?/3kSRMROMYgpfizMJm6JYvWGlJOgfcrJVHavq5UPQs0jKLVMVaEdEVc+ExS9?=
 =?us-ascii?Q?5j0RQRY9iSav1YlbQ307WhKer04046C6z+D/GwK7JSloawJXCUz2ZoSUnFMt?=
 =?us-ascii?Q?+vHcD4HN8cKtafnq5HaXhU5TgEbJ8loQdnt7oXCeTPlYrZOatdLnM3pZ7Pwl?=
 =?us-ascii?Q?p0MuCVVKEjucUZtAq7sbmAdLZeW97SSfXiQOqN30Vmy9UA1xTEz//sTwiVAc?=
 =?us-ascii?Q?Ko74nGJEPNJQ7YL+/MN6Qxi+wxcM5duOxaLWpSdPi0qgLaie9tV+TaUooRsv?=
 =?us-ascii?Q?tDFpCvgQWP0ZgKzVAQKoA2US4H6cRahrJRiVmo7E2N5uMF6xeXQMFm3vVsCk?=
 =?us-ascii?Q?bAEIr9/io+HJysHalv/k5Z0RQS1p4asBkYPyvr87X33110MCvDqznZ2n+nxP?=
 =?us-ascii?Q?pafcDs9CIQNwBJUvbPQ84rr3C2CB0hVwvUcvj1nfYDhQMfGQM6sJU2lyGTWX?=
 =?us-ascii?Q?4hWzTHWxHasayVuFdxRBju00RIz8+rMkQAiDQRI7OnqBXGaxa/PWDKSx9Ohm?=
 =?us-ascii?Q?O8VJQGhB2sprhb1nLuRbiQ/S4MGgJ82eaiIqOjsxpw6Rq7IFlHlFsszde2Fj?=
 =?us-ascii?Q?y/sRabG1Av9cB46J678sMfGNZEj/3/ZBaptbdRKVTD4HogKurnmrOw4Bv47C?=
 =?us-ascii?Q?wEkGmwjBxJBERBEdehVIDyRWmg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726386ed-0cfa-4555-a35e-08dad7e2879b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 23:35:16.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfDpxPGHvFyqzXIGdZZCX4CEHU3KVAFrzGLQsjMkME+ITD/uPPkWRYZp9WrpwMyBp9chqImBIw11BscV3J6F/SHN9WSrshu/v76eptfFwEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060199
X-Proofpoint-ORIG-GUID: -vRdcL6c-gO-lJUPSqfM1W3sAIL23jlf
X-Proofpoint-GUID: -vRdcL6c-gO-lJUPSqfM1W3sAIL23jlf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comments inside alloc_and_dissolve_hugetlb_folio to reflect the
conversion to folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

This can be folded into 73133b81bf715cc9d426d177c07d97f50061c28f
mm/hugetlb: change hugetlb allocation functions to return a folio
if that is preferred.

 mm/hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c946abb868e2..e70ff6768596 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2766,8 +2766,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 	int ret = 0;
 
 	/*
-	 * Before dissolving the page, we need to allocate a new one for the
-	 * pool to remain stable.  Here, we allocate the page and 'prep' it
+	 * Before dissolving the folio, we need to allocate a new one for the
+	 * pool to remain stable.  Here, we allocate the folio and 'prep' it
 	 * by doing everything but actually updating counters and adding to
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
@@ -2795,7 +2795,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
 		/*
-		 * Page's refcount is 0 but it has not been enqueued in the
+		 * Folio's refcount is 0 but it has not been enqueued in the
 		 * freelist yet. Race window is small, so we can succeed here if
 		 * we retry.
 		 */
@@ -2804,7 +2804,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		goto retry;
 	} else {
 		/*
-		 * Ok, old_page is still a genuine free hugepage. Remove it from
+		 * Ok, old_folio is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
 		 * incremented again when calling __prep_account_new_huge_page()
 		 * and enqueue_hugetlb_folio() for new_folio. The counters will
@@ -2813,14 +2813,14 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		remove_hugetlb_folio(h, old_folio, false);
 
 		/*
-		 * Ref count on new page is already zero as it was dropped
+		 * Ref count on new_folio is already zero as it was dropped
 		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
 		enqueue_hugetlb_folio(h, new_folio);
 
 		/*
-		 * Pages have been replaced, we can safely free the old one.
+		 * Folio has been replaced, we can safely free the old one.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
 		update_and_free_hugetlb_folio(h, old_folio, false);
@@ -2830,7 +2830,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	/* Page has a zero ref count, but needs a ref to be freed */
+	/* Folio has a zero ref count, but needs a ref to be freed */
 	folio_ref_unfreeze(new_folio, 1);
 	update_and_free_hugetlb_folio(h, new_folio, false);
 
-- 
2.38.1

