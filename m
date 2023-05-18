Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5F7076C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjERAKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjERAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546B40D9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGsfM002447;
        Thu, 18 May 2023 00:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NpiRsYk/WVyL1MAgfhcsMc2U/nG94wl1D/9QUkMWqH4=;
 b=ETF9CijihNG3XBPCfFnq4Do27eCNbmGPp1rBOAD0cQ68nE/D3kddsWrcAcl9wXB3Fbjw
 AoTrmjIBlp2c3uV05oCS6XdO2W8ES2/XFMO253aUDc+LmiNgfd5pk81KuosTQE+Wn+Um
 v41KTyV+1tI0dVM8uQmkr/JvD9l8T9bFGw5mODG8uwd3K5mnr2ggWDV0HsIu9GeD5rLc
 25nnXMZaOJGWo9t0G/hIhaGNXvC9MnM2vp2TtW6qmHfmA6wXiJ9Hnwp6CrrJQoprt0q2
 YJ5LyUf/SZj2mN0JKs61xA+tGB+XXY/KpH4IwIrdq4VDcJ1M1eeXmv/+8Is3tN0iX0w1 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1drk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HLYXOx036173;
        Thu, 18 May 2023 00:09:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm033xr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSO1fH/PTjL71bIML/xehe6BpZV8v1RY17nqSyDxpiGM6BNMCq2Kam4/HZ5E9CKHP3iwAtrOGRvm+OMAb5Ju7GUM8IVsMXLHjmvGLVomt8iveLkK0uy2/cXpibD1T3JnEQznFmilY1BtexXeq8HoXc11/fShydQCXR+MV9e4EUHuqMW3Ti7cahAMvtrY5RYDfBwX36Tf89jgb3MKw0Hz5UK/Am/Dh5j4A1QwKR6Qk+U6ljlfg5mXfzVnljVCldK/tRWl06cRhUjXUNRnLY3rvgZJ+xRya4PJxBzNQA7Iz2BszCHI7/yW2Q205RW+5njKURacfuUd7XyNMbgyFIv0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpiRsYk/WVyL1MAgfhcsMc2U/nG94wl1D/9QUkMWqH4=;
 b=nS9v3PbW/Iy7ArKjSgE6BBI9PgoZQjtHM1FinW6s8OAMd0q5n2WPyW7D8GG8uaf7LQBUNgdSPuNBUa6rTWZUZbS3HwPWFixTsTnxDBQmCzMN4qv7kqT9wWQQwK2C2VeVwfWu94UoQ5J7bHGr9sqmWmhOTSSgB1j5aC090ZJ5PAUSccbP+WlgV32sYyXibc0Y4/S85ky5WlQi+I3y5BrUxA+I/2G2GL4+/a8wcCy5RjhcjoWaSNwWMraS8NvLQSbS0Kf/2KeRQ9JKmD3pyCtZzpbdek5zP0MO4U5epfBEDLJz9ABNSODMnAua4mdl6RBEw3jFAi0/3hbkYkHMKZnbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpiRsYk/WVyL1MAgfhcsMc2U/nG94wl1D/9QUkMWqH4=;
 b=Cp0IGksb1BuZwJQzbbIJuogQjk6NEx/eutOPWnAzXH1kAPDA41edbdVC3NSFU2H8PhDWNmLGDM1WiV20k5qtYcwAkpdwMELqeOaY9F/6cjMFSRCBvtgfW7l6ITHjgM0bQsBBSWqRR8h/JqrSeP6/FzId9VEs0UGbE3CQsbnRl5Q=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:36 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:36 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 8/8] fork/vhost_task: remove no_files
Date:   Wed, 17 May 2023 19:09:20 -0500
Message-Id: <20230518000920.191583-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:5:18f::25) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b697f35-e7d0-4a80-4b59-08db57342a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E7l6FNcG0xmMtJ+qP8cKWFYk0IUeHCNNDWXdjU75ZrCUBNUu74vgM3grvYUvk8RLMwUjF78wV7tg4U6oyPte7QFvES9ubU1KahJDB/xLHDetaxNhC6NJt+zsRO9IQP3F0ZFpRj2KI2I3MTvQqIpk4/B7iz0WJIstEwMnhyu69tXwGWSp6V26ZN+QUMvWouxK11x5FiCsbanGxCdi7NMoyKwyXOuAbwEyLXm38ZIUgnc4eYKZqlZwsljiQPS3yYVcER3yJKHTs1LIZZbjvIzGvBEhK1hn58lQWet4L2pzyHkn4IuXe62NZCBtLoIuZHiOAY4NVoZgA84qWmR+JnowiS1LteaiWsX7a/nQ/uO9DkrgDWqqHtOYZCRHyob7kEShwSPmhT1E4uVhKwX7iF3PA8aTiqBu5NDudkGZxpoZpWVLX8BhM/SochZ6rYdmQ2xoHS4VGBMG8KZMvm+Z8+hGsTZq5Jbpgn+OozKnRgsNnk+v6ZuxAqLWVp6SeoRxItRbqQrxoJa6E5i/wjzxDeslXB7XBsURS9lhlz4ERSVET6dOy4BgcgsK/G9mGWw1tP6g7sVq+VMSpXi1yZBlI8YeyY9renUMeGy3Fs9F6Rf/04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(921005)(8936002)(7416002)(38100700002)(5660300002)(86362001)(6512007)(26005)(1076003)(6506007)(186003)(6486002)(6666004)(107886003)(36756003)(316002)(2616005)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmM2Y/QXj9e9bghc/Yu+THCGteg7e0Mtw65Wira50GCpCR1vPSnv4V7/ixIK?=
 =?us-ascii?Q?rRmIUCeIQjXeLun7qIpOx+FN+WE5etossCT8iPdkPvMC1x8SiCp+IPBrXmdf?=
 =?us-ascii?Q?eKgz7Fbdq5KDJBTRbRNyUnVZSBNe0x4zu1l9ACov9bU/u516DF5+F1S2RxHc?=
 =?us-ascii?Q?ISp9m0PaRD/34NrRMxYfwxvZCXgMVJCEY0wsijjZofMnj31V0nQzao/tp/0U?=
 =?us-ascii?Q?IaNuC2GzY79ghKWfl/5PIjmOJ64YDCFd5tWccTpjBV6T1lScBchrX7+79Ugj?=
 =?us-ascii?Q?WTwjzmwbvxZET8iwS6lKeyfDj+S/ZgSt6uE/Ag3nvjjW4y6X0gP6k9PR8+fS?=
 =?us-ascii?Q?fPPFPXacn6cqtwyheSdh+moz5xP2AUrxEhqsqO5GZnRsyI1gyBPlI3DDNywS?=
 =?us-ascii?Q?7hHx681GZIsLfqVXhF96deD6U9kHMA8/6WgmEnti19sdCuznMpDgRrhUUd9R?=
 =?us-ascii?Q?vtZduJUXsQN4H23fu9nPh0MdCrthgW9Vwr4MJIWYadmMNqInWL1HmJ8OieMb?=
 =?us-ascii?Q?eBInxx7ALBGeHZ+mmu4aEPvbH5M5utetBsQead5R1KMJhnV94ylcIG2I44Qj?=
 =?us-ascii?Q?0bDGyEp8nOrR8U3bYxE7OKfvU1Ir1Hwk+wtXjXtZKlEw1QKHZM0/OoiE9/V0?=
 =?us-ascii?Q?E8Uyo2XkDFVfT0RArifinoQF2M6lMWXZQQVfgij1Tu+DTs4nQPoK5lz5crqu?=
 =?us-ascii?Q?VPd3QVPX7NjzmJbAVxaL+AV2VlIuRJftuMqNK/juUmOm8l9se0zzH24DBQW3?=
 =?us-ascii?Q?w6ArhiQXlJ3hE5dtq52knXirKPIm+tFlrd6yFlHFBE60td1Rxlc4K012wDB+?=
 =?us-ascii?Q?impqGplvrHZbXS2X6BK/iZv/1GBkpYBzGUK4KVBx9itu7pY+W2V3bluhRBkw?=
 =?us-ascii?Q?EwBsfwFbQeg0nbcdeprfTIOMZu5c9dlksQ+xEMRBRjEeW7625xSVLxL+A6Z1?=
 =?us-ascii?Q?BnSzAScD24xzkx2076Z3yMc/2GfuTG2v1c507Rp+qdGWgOKx4SwT7WAotCNA?=
 =?us-ascii?Q?8EDAPkjy4XNcLFqjQOPBhClCKrfXTZFaalUb3J3nbjJ2ds0ZXjn/vqrOOIJv?=
 =?us-ascii?Q?wo7jVzU0MDXCYMAWdaozIAPnWV4j0/QA2P3d1WnAQd5PCvQg5eUnZ+hmX8oc?=
 =?us-ascii?Q?afTRllMAYG5LxK86abXlktN9KEKiYGghtVuSZfToa+qwqhE9bDu05DCFuiVO?=
 =?us-ascii?Q?jXYsDCsJWVVUY5RrcFsCRiinzw5r3q86zx7hy87kOcOr8Xf10Ri+0rhBmvXU?=
 =?us-ascii?Q?I8naeXOTea/X4Ca9ZV8pt6NyrmH9wTilW3Xa2sZP0CKCJaXWFflfzMOzPHHT?=
 =?us-ascii?Q?5eVfema6IiiEhc8nb7rpXVyMxDbHfmtvEMeNTR6MkLhYo3Qes33jKIoPvbDi?=
 =?us-ascii?Q?vfKMmhunyGVKaB9Duoh/k4JN87IO202bzuxhftAjXjM2qXTb07Zy6Rf0ujFz?=
 =?us-ascii?Q?9DQ2FvmUX2ox2Cz49r7yyZcAMN6v8/qqq6e8PnqeuoXOOXjOh1Bn8nvkduwa?=
 =?us-ascii?Q?0kH8v3D2bk6qMnPq1VLgCEAO8SJON3eqGniBvtv7B4eH8Q6iHzhzADNle2IW?=
 =?us-ascii?Q?4Wr946SKPRLRylL8CyE1mm6ODGO7uuUao5kWOVwbUlXUVxGIL7BEsGqykDzR?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3kNWAg8FBrOYAQYEDVJBZg53dr3D0iX+PewAqjZ0PtsFLVUtnKcIWQ9qlQPv?=
 =?us-ascii?Q?nl/lDSig/H0DFMa98uLbtM02sXjGAxd12GT4xWCMlvZu6nCE5gSJEUHKOaTF?=
 =?us-ascii?Q?o9iOEwMeUvZ40zyKJqJqQhFbJkUjp7YgiELVI9+IB4o0Sa+oXOCkZcVSsQS2?=
 =?us-ascii?Q?MIH28HGcdMuIoMuOr6dv6GWxxIFlJceOk59kKGoN/JmRxS872iUay8MPFuYO?=
 =?us-ascii?Q?JSIymxPcDbGV7kWkd5t1bz+M6ThQR37OlaRo/O4wX7nl+onmw6ubQo6QoEhZ?=
 =?us-ascii?Q?LCctr0sOGeqZDX40u7ME3g7C9QjOm4WOTPG4XSY0QHKX5p4wc1upXd0vhjYv?=
 =?us-ascii?Q?CZZNLCVGvfz6AldcQThaZ/ltQuQkXgBYZE7jwE1k0yxzM96UCzbch+wXbVjO?=
 =?us-ascii?Q?NlA964CkqPJNToVrxW8fOOBkuJcf0/b0wc7bOXGO6t2hWT4ixOFpw1/tL1Ob?=
 =?us-ascii?Q?6LRQr0HR9r93H+Iy0FJpP2mWTXAC3L10R7jmUxXbraEz+qNkInd/GJgTeCyG?=
 =?us-ascii?Q?05rXq865J5AQ+j0cwXQV9lsP4xJQ64S5bi++FINAZNKw364mxR602RUMAIX3?=
 =?us-ascii?Q?/ekz66GsFzBfJQDn6L12UR+jOEAU9T0wBwERUzM4yZx98p6wif4KkEF+Lwcm?=
 =?us-ascii?Q?YhwmEY3aCJTxal4sstNjXU0y2Rgg9ncbc+o0bHIHQn+1xiLth7SPumsQNUwo?=
 =?us-ascii?Q?7wNINlLdgRSvhTZsPGyWKWAvxOL0kpaoN4FsvRL/cCClxWdtZsHeP4ioD8sR?=
 =?us-ascii?Q?IpuY5w0dUCtui/Bm0du1o2QydwwA37RiNikAXI97JXDtZNrVKCEiGsdVUj3/?=
 =?us-ascii?Q?EC+Onkh7wBpKGlAXQ8qowNXwLoGxU0XsvDYQaRoIfiffhwg/0k6ub3OlWbEm?=
 =?us-ascii?Q?541LJwA1JfeGdNtH+RbNiDNDvLvpB08uTwojb2Nzuu3JS1WMVUBzhLN4XlOO?=
 =?us-ascii?Q?3jsJwsapOFSkvUStqCAKclE5CKySdBUcuAhm9uPBZ+6nCIKtA0Rb38ThY3cK?=
 =?us-ascii?Q?316mTdxDHbTgZkAqGKncP+UXMu6SzaNlBbfLq8KorTTBoT/qU1lecaVOQ5il?=
 =?us-ascii?Q?ZCzQTox4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b697f35-e7d0-4a80-4b59-08db57342a18
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:36.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPZEh3Aah54fSzoAtP9Bmpekn8hEAO/S8fs/fYKyZw6GGU9o5AwImYD30B7eesCDQh2QlBXXlQRT/b/tobUHeMxIEABnGgsih+zk5ReEZrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=844
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: VmLvlcR2XvYGWU5zInzlM095AdcxLoyN
X-Proofpoint-ORIG-GUID: VmLvlcR2XvYGWU5zInzlM095AdcxLoyN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vhost_task can now support the worker being freed from under the
device when we get a SIGKILL or the process exits without closing
devices. We no longer need no_files so this removes it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 10 ++--------
 kernel/vhost_task.c        |  3 +--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 249a5ece9def..342fe297ffd4 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -28,7 +28,6 @@ struct kernel_clone_args {
 	u32 kthread:1;
 	u32 io_thread:1;
 	u32 user_worker:1;
-	u32 no_files:1;
 	u32 block_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9e04ab5c3946..f2c081c15efb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1769,8 +1769,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
-		      int no_files)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1782,11 +1781,6 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 	if (!oldf)
 		goto out;
 
-	if (no_files) {
-		tsk->files = NULL;
-		goto out;
-	}
-
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2488,7 +2482,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p, args->no_files);
+	retval = copy_files(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index a11f036290cc..642047765190 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -96,12 +96,11 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 {
 	struct kernel_clone_args args = {
 		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
-				  CLONE_THREAD | CLONE_SIGHAND,
+				  CLONE_THREAD | CLONE_FILES, CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
-		.no_files	= 1,
 		.block_signals	= 1,
 	};
 	struct vhost_task *vtsk;
-- 
2.25.1

