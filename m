Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3260C460
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJYG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiJYG5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:57:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6383EBF45;
        Mon, 24 Oct 2022 23:56:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P6KJ6E021673;
        Tue, 25 Oct 2022 06:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Q7/zkoADCekB1PVNjOZ2nfjJAGq/vAVuLuu2uNvgwZk=;
 b=Yc2XJqBxVw688Tsj4l7Q/qEO9oi8s6fEZjLoAvIjPvMM4h8ZvYE/nSaLoUi1mNVHLc3O
 H9dLwPhERv66pO92rOTrcPX9oasMPS7HxDuYlo34WOT5BXW8qjtPY2I/d/mY/Wk0t4YY
 MBL4YXR6nljTcM8twCdQ3PpY6eB92RcfE/saa9cg1gDXw5v/U81VoZwFTD3t851wFcro
 oXjYQi5LDP6FcKgnd7O9mQwae67tFE8ILqO4uGsyQ/dJnmATAT43nBVI1OHw5SGflAkt
 suFp80I3jJf0rX7YMqqUo+puVv/LKnxGvqzYVLiBXJGiefwWkaRGOZ0LI2kckyDqZVSQ 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9399j35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:56:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P4VD5g017332;
        Tue, 25 Oct 2022 06:56:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4kdr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsXFjf5rorWD9QQ5oyTlpioVqdQCD++qd/IjUjvYHd8CymZHyEJPZ0eqH9E1os3i7Ng3L7Q3gVmXmDBgWSIR5e6C5izT/oJces8Zb1HKsLpRvkTkXFJ4b+lzTUjqDFDfosVHzT2WHJ/w09yQZ/XOYsW6xMavRgLNTucSVXP3xsOTBkK4F1VnKSgcLNQXKr/C4zdnFEx9FDYAoAI6egmEjg7B9NT3n0aDK/MB0AtsdXYgPNIyy32yhyzOOBqb6FBQvkBqjpoQwm9LZxVVuL3GTVdgml7TKmbcl25dxLqagdGb8bbAM5Plb8kz4ofuNt7j7h12o4RGFgJogyNgmuPZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7/zkoADCekB1PVNjOZ2nfjJAGq/vAVuLuu2uNvgwZk=;
 b=EhSW+t01Xn33SSOVqe1USwzYXe0CetTaZhThmsNHn2U4+0p/6df/IFahhga/2Ibm/IdfrbFS8CoNGPUvi099qgCwizDWhlICT7zkmYzcWvjp9z/o7RaPhTfjhw56gsWJRWlW2TlVACPHklsd+1Zi76VPHHHOmY6sP0FGA+uL+o+Zgb09j0cjONh8FIXc0cBrKxziM00pLJZe/IIXeyPcWsWYgzSxsxZ99BBFZnA20zsL3GBGtgX0rIENnIZWR3KzOAntqdcHu415UWDoiIkITzW5uOrKdUSuYlFRJeybVAimzOYZ5JLcA6KYjzOgmFeRk3HKXjMFmTDkd1WJhsD6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7/zkoADCekB1PVNjOZ2nfjJAGq/vAVuLuu2uNvgwZk=;
 b=MmleG+23mXlYEEAB/E3AvqiQFO8MNrGCWEq+NpTXQhTvlJXZkTIs/h+2pRoJgCiJeIFsVOV+qJVsKPednLMzfBvp9KQuuJcxgs/Z6RNicOGdshfW8DbbKULV48fKqcvdo407sEGkCN1zO6YcMK3QHu+j73+ocWpZ3S1d0Tgf4RE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH8PR10MB6289.namprd10.prod.outlook.com
 (2603:10b6:510:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 06:56:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 06:56:10 +0000
Date:   Tue, 25 Oct 2022 09:55:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] media: cedrus: Format handling improvements and
 10-bit HEVC support
Message-ID: <Y1eIfbfSyONyM1zO@kadam>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH8PR10MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: d30070e0-0962-4c54-9de2-08dab655ff39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSRCSuacHpfZRxlJWWYDwu7agSPqbH4kBug0FCk+bIaJ8+trQGw9tIARqsOWJuOwP6KdRfKuv1oXRnvWEWbfTZORUabeMd7KIcGiEu1B4L2Kx57/r/FH6Z/IyFqO2a4ezB13gRbFQhgXMfEy/Y7K/blvysBg8MqLX/ND8ZoOBcsEFIBw7sFSdDdau397vkH0w30pwu1FAYQHiltxR3O7yFWkurvHCZ+f3MPim6oFZxf7RL+V24Vkd4K1QC/XpLAzWeNp3BpN64oPr4xxZbdXO/uF0od4QWThcjzlzXn79nLHwahynigiOWFPTGxkY0mHLjS25c3F3WLb1+7GGrEBlQYNzv+/xobDhYETS/BGJ2iT2fZvSJfs5KJYGtvFtC3NjTNSUGn8rGsrnzjeS3sq7vZp7brVTNv7k/yASyfLEQZ8rbzwakU3lCAgDdCB5krQhuO1V5rITRU4ltIAgDuauXdzkKwLMZ55pNghWNrZgq+ev8aYMYZKfxXaRJqn22RnioXumKvRCAG8JTLrJzPrc0lbBk3/4l4MZWxOfktQcvmqs9v7oll4YXjQfU/yo0iLD5b5Vba2lChODBttBxk64zy63bvSTfgNUeWVNy+q2P5V1E/ruJiF58Ysls173OA4v5TnaQrjPWLzTGO/V6xTiHeiPnNyQkIF8x4Mh2t2mGW4nD7X744o/snsz5Aejq0K5izICsQZYbJvfCD8h5pQgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(186003)(2906002)(83380400001)(558084003)(41300700001)(86362001)(26005)(9686003)(6512007)(6506007)(4326008)(8676002)(33716001)(6916009)(66946007)(316002)(38100700002)(7416002)(66556008)(5660300002)(66476007)(6486002)(44832011)(6666004)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fq3UwRHir7JfRzZvynjbVELkhnB8V/hp+lwBnEmdyIpJxqa24Lsc+anTuxwT?=
 =?us-ascii?Q?ok5urQfkgjpCCC6oHGt5oLUMdjI38hcaOQ/wWmZAva/hhUIDe5vNeJCZ5RmS?=
 =?us-ascii?Q?HN3PzrHMgFN7BFdeb1rO2Kzl8pK2AeiFadTnC4g+/bDNGhXX7YOsqMLpS/ZN?=
 =?us-ascii?Q?yB5hxOFuAhHEWtd2R0evSwzCEPeDxjmlEpbW/BZrbxaMm+XtrIFV3FbjO3wS?=
 =?us-ascii?Q?YnukdTrjOERiRaoWyHgFjbTJCy7i80XpWWjcuesn/iUSXS6tCpRXNbc7qPJ4?=
 =?us-ascii?Q?e8ZOuLforBozpUC4hDthZJUHwV7YHfPWj2yKdRgIvStyCYfyBrNP4v3hG5Q5?=
 =?us-ascii?Q?hxjof5C/8FzkI0cRrjFJvyDevYTMy/1GKK1uh1KH+RRemCIGAd5KN0IJYaHi?=
 =?us-ascii?Q?NTTfm484sYKJYyvFopUu8c7PJQb9nsXq9+FBK5nHTohfpyOGDgR1hv0iihxC?=
 =?us-ascii?Q?YPGf/GhzrKVZpBYzWX8E784ZXCx8RzCUFVj9VF1C4w2AHue3da+PJ+ZCRVFn?=
 =?us-ascii?Q?j9rtd2WSlxgnPdKmpy2DVkrjgz3DdPcMi6ho1IHbgHMcOP6Ik/cQIQMme6mi?=
 =?us-ascii?Q?A+8srhHIexL15vcD1wkvIzZJb/GHCh00RQG1rd5z2AUsxlgLtktAIQDKzKg1?=
 =?us-ascii?Q?mLwi1hE3mAeMFfkxkaT6r0Tkujle5mWWoJEXYWoKu3JqAtr0GSC31j5q2XbY?=
 =?us-ascii?Q?I//xrlUI3HeL+7nCpxGApE7n3rwUIK0WONfV78ym1OOhBFAMm0mlndiVME/h?=
 =?us-ascii?Q?pE8npevDKIDzK2Etx8/IvCrGNQfblf34KOwPWqfJNv63Uj1CMtcAYFvQJI6u?=
 =?us-ascii?Q?in6nzQZTapIwJ4Wopxs7q4KKv43Tw/8IqgT1ImGrcnrC+nbdBjSzv2qEKAoN?=
 =?us-ascii?Q?RIVsufIaSUHfy0RyvDy0IMVAL+rjKv+QMlp3Rj29ZK5uCx5sFd4vLD70AguT?=
 =?us-ascii?Q?PTTEHdo3Dh9YDLyYmPFqMZ1QWwlE+ciPsDVNa9yyanG4jaPbQVJOxoy/dmKf?=
 =?us-ascii?Q?+6iOHOtoifVVyVdYiSanIv8rlYBL8Sd1XXxlklPP2OEnq6RSDOke2HbHCAAQ?=
 =?us-ascii?Q?aGCjIJ1n9z/LuwBjvWvdd19S6m8/8b4AVyzz1Sp8A2sEpVktthwt+STTxRVd?=
 =?us-ascii?Q?9cWhwhhwMdhMMzAmJc4ur7JAEOVOPDvh+ajFgh8Gw2ya7AV598tpyfuNp4Vr?=
 =?us-ascii?Q?clJg4ttjiMVThsW2QdWsvEG78JvPzuGv/RAa9ijHNRYMX0zQThtEoSTCRG1g?=
 =?us-ascii?Q?POGc9O7RJl+j76S632McJX8bSFd3q79LReyAgNAYgZDou+lNnGOZA66vuJcI?=
 =?us-ascii?Q?cy8ZBSrqu2IH2TJt9xpISkjPIUm/krSFu3qDyT1mftlhkCI2wnHEFQRrcmUF?=
 =?us-ascii?Q?2OlnQbAT6sXGT/siQ9VSzWFEqloXsDwI1/DY0fb47HHAg4Cm0GtAO3Z4Zswz?=
 =?us-ascii?Q?V5TiZaivDGJWq790tzPZ34DMf6IELLgcbkGyfRC8v5JC+6IT/01IEcqmU1k8?=
 =?us-ascii?Q?pcLPuXXIUUK1ssLaRGAogKGnafobAAl9GuVY8fGZqrmwqvBXMyC4TUTzyCrh?=
 =?us-ascii?Q?raSLJKb/pPJyko3KhGwZyOxrzUE/9bGVmXsmfUzanQ7QVRFnboDUGmdzc9po?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30070e0-0962-4c54-9de2-08dab655ff39
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:56:09.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efz1asuDjv/VF/hiUqPgX8QtCaJzuB4sB0M2PCA2my7L2kigfnirwJenZ6HsjDlnqglnGXI1a1fdS0nuG+XLc9Re3F5Bb1VUjAOnWGCMDF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250039
X-Proofpoint-GUID: BrjhuwQBZ8-oJRh63bQsB_8HFAsyLB5h
X-Proofpoint-ORIG-GUID: BrjhuwQBZ8-oJRh63bQsB_8HFAsyLB5h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset has some nice changes and I like how the commit messages
really answered the review questions I had.

regards,
dan carpenter

