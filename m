Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4B2642CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiLEQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiLEQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543DDF5F;
        Mon,  5 Dec 2022 08:33:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fc1f8007848;
        Mon, 5 Dec 2022 16:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=l32MOUudC0t6Nqjg2Gti/mWtMRe+Rd58udSjs02jLB0=;
 b=FnjTjrhw6ZZVS7wunFu7sq9/RJjlylzmC6tFRO04sFIDdIC4LHHmO906ft/+58fUZF1U
 TvCBY5EnPkBd1edSe+F78Y/FDpw7BtFZIOITc8sxSXD9GEzncjy6Vx/tzJV6elvBe14z
 s/VAi2oCNVuthP04LKVG8qF1fzWzZsrEk80KQuvlk0884xqITM1WvmTAxrYgJLiRJ+tC
 Q0+pHF47q41Nq63MpN2MMnAXJbPRWkQrLilViJvhkY+XRMmTOkdElVsSq/DASLnNnM/F
 wvExj5HsZ3QZJq3bPPwMQ0Bmuxm+RvuDNndtupq36JspM0Kzx2N8nTszjUCIiavoWJTE GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgmbgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQwoR012906;
        Mon, 5 Dec 2022 16:33:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u925434-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2j1FZShRWvajJQKP6XQqo1yXBm+c/WCymlu5IpChuEMV0BYap8truf3e+jzkLKLUHeu1phRnm2PV/iY9s3yukLMXnjbxMrt0fMh7+FaNocJMHciCqao/BCbX2M/3vtzuAy7tioPvqjGbmx9/dAT2FNUOqQwIi3u6thSqzpXEZ2xbX5zxtLLvUKsGwlu9HNmWBH1cZpsG7VEf/eoVEAh8Til8eAfdd2weDt2cMm7fkV0XHbPNxskhJX1DHYyP6RTNFVXlSgu05zkhOez27UjYymnWwClb0AYweQFG2OSiQOJynGqW0+yQi2nOYqDmbVriqjDdX0kjg3nXNQ5PRPGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l32MOUudC0t6Nqjg2Gti/mWtMRe+Rd58udSjs02jLB0=;
 b=MhLhZEbU/kOuAejsGAM+Apd/bse7s+OkCok+iGb7R5kZmhZrcJdzKv7KYzME9JzD0YOWy84mQf0B7uLKAsWybsZAhLY9YFCD6Uh9uvPBfcp+aYA29/TYDQFZEro5UjsumWbtSFLN2DhbhNL6wRT14sOJaYQvkn01PotV3oDMFp6Zuz2exs+zaxx4UUqJZlEXS0lxWRDWpnzawN0ItawIOZAAEPJgFzJzzETM7LvYigoJKzi316uAh5pHOrNqy2872WP5TZQLMY2OuOinHtdGXAtMzvc1tB9ZMtzIA6OJqrOFEKJbpySOwCED38IiFXu7wQ2vEeScKntk8BFQpgb52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l32MOUudC0t6Nqjg2Gti/mWtMRe+Rd58udSjs02jLB0=;
 b=WRM8/aTcaAqmV4ps9VYsD6lCemay6DYxpmbeD+N+CPslK9RhpRIzOyVI+XlM4Kd/F0hlaLihLrFaXbgnaMLqo8fnSpO0/0uPAPd5xOaS1UbNa5BJzOXmRpkAgjn7nlYynB1MAlFS6AP07usRS4/XvuTlzPELWXKhNgymSi4AtaM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:47 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 08/13] kbuild: make address ranges map work with IBT
Date:   Mon,  5 Dec 2022 16:31:52 +0000
Message-Id: <20221205163157.269335-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcffff0-422e-4ff2-9438-08dad6de57e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiGrfpBp+9hmdKnmwg+GWVbkEAz7NjEeqK75kNfgxuXLGjyzKoOUcY1RzCaI9Ud70aUL8cHcrYVMpUHT0lIgplALqp52vxIgqm8sswZ6xsVx5JiLt+uRgiYeR9cdh2hHZgk3XdnRbMLhiNOWQUvxyjEHEYDq5WxL1pEnIwReR9QJCnpA37XBVu8vmBrZ6d2QudJmbkFEtahTLUpFfh5vRDj6zjhZSEptCw+tN1X9GjAWznd2IdP2j4bkKYqG8BU6SxdylZwYHL/ZzEN4itUk0gF/9qQmKFE8jJBOMBxYsZYioMmzlMi6BI7QgPmBDh8I02x8DIqMXIkCLLlGyDcHdD1WLO1jPn3z1bEycw1H9f73iedu/aIdSgX732W9T5EEUTN23oCqgn8RnPztA4IM2MCHc6a/LY7MysHgCbiPOd6+DgjvVJI2btpA35VKIQos8fvJ2+T5zCVD3QwDvB8SAbe4OSbQRpr3W4EgtEz5UWSjRFR4OZ/yxEWev/glenu9U0u0GIhWaOH5KtIAfbw8CH+uIr4j5D1oYWUM1WTQ8Sh5D3TSMvHrmKLLrRscKGL8Eq5XsuyHm2XFrM9UlQtPpQ7jXMDhClEgxcAIj6m26sQaTVRtpjCPVPDmocySX1450AcqV0iTFAUaenpD6JYtoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0ZbPkUzWPFSxT9bUKsNwHWDlFP7WDegH/640c/xWeSK9smdMAUYjl+Nt/DP?=
 =?us-ascii?Q?05yTSQ0Aua1uaJTcN0i5pR75vkeyWm1sIUdzBhNNZmIv3YpjcW39qtOwl29A?=
 =?us-ascii?Q?BLWTpr+2pznkdNIjJXM1oQHBfOTpmiumdGHVhjmeKNreTpmCoV6kTUv2EOW8?=
 =?us-ascii?Q?gEL1sv6m8CDsD5t1wqzqGtcIIAu3ddtL6Qi7cbOLIRj1HCBKFvxWGY4ZSllG?=
 =?us-ascii?Q?yrQxXNPD6hdvcvD4I9r447Xr1gsk1qM7x5lzC2D3koNkOPyosh9ODD8AaDfr?=
 =?us-ascii?Q?okQpoefl8rHBOAGmXAoSDeypAw0hZQrv90MB2Kzabuzd6IvQylxLFF8dLo7A?=
 =?us-ascii?Q?7eiPPopBssjulTOqYY6bcmVKWvzIeKgoxS+FbBxcGgb6cAtaCw/pF9cmO3Pe?=
 =?us-ascii?Q?8RULe1dvVc8n8zGfEJV9ubFma3+10ONEniS7L/NhAy0sYZSe6DgU8B8tFRw6?=
 =?us-ascii?Q?aAc+fj1vQw4VKIprrPasqSdZrPq3/MspIDB59aYnnq0ShrG7DH3i3PZ0I6UN?=
 =?us-ascii?Q?OVydkxJ5PdeexmXMBvGLhYxGo/GaF+fTkCly1IHk6Xac8RgLgX3hcu770mlK?=
 =?us-ascii?Q?dYgZgNUXXuVxyrGHVDdZNFMFrYc7m80pNVOYTz0yGbnfESyA8tdAg27jbc95?=
 =?us-ascii?Q?lhdqW0oRV8YE15pw/QJZeowurJGGZNwOHM36qBo1ak1erFjhXfWDfbLS0cjL?=
 =?us-ascii?Q?z3+kIaoVh1NQ4S0QrLjfWmVQFwaQezOI1nHAk1Fiqg1+2uZIeYWmUa7hJd0k?=
 =?us-ascii?Q?y9fofYsWqn6GsxqPAzfts0x5AUFeX1wt1s3i2IcPKtHMoR4dhQPm87WfS7L6?=
 =?us-ascii?Q?pIW/7Ut2vNy1c4drI7Z7k8Kd1lNvina7aXjycIGA+xGH7tNbvpdz5fjfbHSq?=
 =?us-ascii?Q?vP8/6VEhkI3tGpDGGcNH+rYfijCiytRwdlLA0e3O3Wf2sQvjwGW3ar0RIpCg?=
 =?us-ascii?Q?+Tu1P7sLTWBD4EDeX1upbqEUrJrzVwzgjKmLCLxh3eYPtAUq3cW4jZlvtt02?=
 =?us-ascii?Q?+LY7OwR686xO97jzLnSTOsm1xq0UF8VCs1b5PqONfDv5MT0zo7YvwuhtP2Hw?=
 =?us-ascii?Q?ToZybU6lRW7zgQ88KIYZgk5yADntylQXfFf2Zxnbf26JQSRzfVbTiHcgRK03?=
 =?us-ascii?Q?gV4SZfeRCdRTLpDhwjOhoMUbqjNbxbzMifxaLpTJ5d42TSWX/tXDsEDWFpyQ?=
 =?us-ascii?Q?fKHVR7PiSX0PI0Uvcjgp42P1opTN2pvZT4UiLWWKRwgBNs76n6YR3IIm4dWo?=
 =?us-ascii?Q?KcwJGh903hPlbdlOl3xpjedVo9pOmhgrPyODkasLV+B+eCYZBmOe2FsGFJYH?=
 =?us-ascii?Q?pewleMaUkWPmnn8PaJmDFmrAzUn68L0IwEMpy+WE7N5qRptMKXwydVXieJYX?=
 =?us-ascii?Q?QkseFMZuS+PrLga7+9Eb0SGM5r4GSjO6+Rqw8EG771nmNDq/+VkHBmeb0j81?=
 =?us-ascii?Q?G5ZtfiT9ph/8PS7HgFjJipjEZNCGObZUWDwC8lfMbCsKX+wp7D3b0HImLAQH?=
 =?us-ascii?Q?WQRHEqQVDor6Qf0GijvMLptp5oULX37ouTMgPgXNoP4oqntV/Xr3+7/aJB/3?=
 =?us-ascii?Q?mGQznUEWykGaj53Z2ruiiZLFCOEADgXVnvim+APwJ2W4y0ddWwCruFUVZTpe?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YlueLCXaVtvidwBjRfCgqNmylUCmDK9n02wIZWZKhdjUR3Jiqs1rdJLtOJwi?=
 =?us-ascii?Q?hO7Qrniow/5IykLU+c0l5dtclgm+E1FlEAnkII2fNBVxfRbI6u1JYQkvR3FH?=
 =?us-ascii?Q?frkEZdN9EsPkiYyqCkW0h23ORBciruoa+RpP992Xl8A26eP0Hng5XYVg8gJA?=
 =?us-ascii?Q?KM/fGIqvQIRm680cTdF9TR8kW0vjeWFMyUeOPmGEj6GZhWovwtcojh3iFQPG?=
 =?us-ascii?Q?nwbY4r/xxuxo5eoiMkgCxkn1f0qH8xhbZbxuqE0HgFgxNE0+w3iFu+JKJpuj?=
 =?us-ascii?Q?wtr8SU328/hC9zIOnu+uzqW67ouoc/F5vAyu2EDINefZRSP0qQP3ZJ8LPP9k?=
 =?us-ascii?Q?KATV5JN1cDSOW3KPXXHBMjBpj4tVq09xsW4IvG+GMfdYX/geSu/4qb5rOFeM?=
 =?us-ascii?Q?ubLRhefytDgytDLrSE4EhYeQOJKwdg3HDaLphLqHsZTtTXxb0TQOTx9rBq9R?=
 =?us-ascii?Q?6PF0UaD3QDO2yZtbi+ZwJ/spHxVJNFCTdC6+5Uu8iNgJZf1Hp1bwiq6gF7pF?=
 =?us-ascii?Q?dGUFkNEXk0950fDiqsphQfkxDSDgemQjKeGBEFUYWJQMT5c5+hZ6eQFaKjUE?=
 =?us-ascii?Q?vuir0mnciUVdiYS0eczw8J4pdHqDLPcsr5DHW0yUaq3kQhFppxcX9HvW/6kb?=
 =?us-ascii?Q?gfzC/waypLvZSHZzZ8o6jinXQYExF79K7XEdSTJBt1YnX0pJ94Oz64pilfZ4?=
 =?us-ascii?Q?5J9AZLnsd6zlqWXSrr5IFznPwSXbE2MDEoxKjCfF0w4DqMtN5PutEVesJm7g?=
 =?us-ascii?Q?PTQUEKlCsb3WXDKJsL+OX9vXhaljxCRbbwrvGXCi2Rr8HyLjgwDKJjQK2X8v?=
 =?us-ascii?Q?h/+UuKlW/+cg0NRiiKSEbh+LQlvCUHmSz43NTt3LnVbfUHK85dbvQeA6R5dk?=
 =?us-ascii?Q?aM1YiciLBv8Eh8Sp6q2G1hGuhFQzOWTvx4uzmP/BKt389qBnx7mIVauNU4H9?=
 =?us-ascii?Q?pVbQ5jr+nPPtGRozsx59CDwCPj7tZiz5vpT88G4391g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcffff0-422e-4ff2-9438-08dad6de57e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:47.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLymWR2t2NS95oTOeRFI4D3Y7c6hEDcB2jCst36RQHs35WYEXu1G5p30ZjbdhC7Q3ytBWGxKNrzjADCac9pv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: sdWb27LiDak7CaaLZk5OpDM3BDmeRPYe
X-Proofpoint-GUID: sdWb27LiDak7CaaLZk5OpDM3BDmeRPYe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit emits .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up; this
is used by kallmodsyms to let us associate symbols with object file
names and kernel module names at address-range granularity (i.e.,
space-efficiently).

But the previous commit only works if the final linker runs directly on
the input .o files from the kernel build: if an intermediate ld -r is
done, the final link emits a mapfile containing only the name of the
intermediate ld -r (vmlinux.o), which messes up .tmp_vmlinux.ranges and
makes kallmodsyms attribute all symbols to {vmlinux.o} which isn't much
use for disambiguation. vmlinux.o has the object file names we need, but
the addresses are all wrong so we can't use that either.

This commit fixes that by extracting the addresses from the final
vmlinux mapfile (or one of the intermediate kallsyms mapfiles) and using
them to adjust the address/objfile name pairs extracted from the
vmlinux.o mapfile, giving us a ranges map with the right addresses and
the right names.  It's a bit painful because the addresses are often
large numbers, and awk is... not good at handling them (GNU awk can use
large integers, but the feature is at risk of removal).  So we emit a
slightly different file format with a pair of hex values (the address in
vmlinux.o and section address from the final mapfile), then pipe it
through a tiny new C filter (scripts/addaddrs) whose only purpose is to
add those two numbers together!

One niggle is that .hot/.cold stuff is no longer correctly attributed to
its object file any more -- it seems to not appear in any of the
mapfiles at all (only in System.map), so I don't see any way to fix
this.

(This possibly makes it work with clang LTO too, but I haven't tested
it, and if the mapfile format differs it will fail until that's fixed.
But this definitely overcomes *one* of the roadblocks preventing clang
LTO from working with kallmodsyms.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v10: new.

 Documentation/dontdiff     |  1 +
 init/Kconfig               | 10 ++++++++++
 scripts/.gitignore         |  1 +
 scripts/Makefile           |  1 +
 scripts/Makefile.vmlinux_o |  6 +++++-
 scripts/addaddrs.c         | 28 ++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh    | 34 +++++++++++++++++++++++++---------
 7 files changed, 71 insertions(+), 10 deletions(-)
 create mode 100644 scripts/addaddrs.c

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 17686f59039c..72c089eea111 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -79,6 +79,7 @@ SCCS
 System.map*
 TAGS
 aconf
+addaddrs
 af_names.h
 aic7*reg.h*
 aic7*reg_print.c*
diff --git a/init/Kconfig b/init/Kconfig
index c45935cd2f1f..160ec1370594 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1570,6 +1570,16 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLMODSYMS
+	default y
+	bool "Enable support for /proc/kallmodsyms" if EXPERT
+	depends on KALLSYMS
+	select VMLINUX_MAP
+	help
+	  This option enables the /proc/kallmodsyms file, which unambiguously
+	  maps built-in kernel symbols and their associated object files and
+	  modules to addresses.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/.gitignore b/scripts/.gitignore
index b7aec8eb1bd4..d042f0e3d13f 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/addaddrs
 /asn1_compiler
 /bin2c
 /generate_rust_target
diff --git a/scripts/Makefile b/scripts/Makefile
index 1575af84d557..356cafcd313d 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -5,6 +5,7 @@
 
 hostprogs-always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
+hostprogs-always-$(CONFIG_KALLMODSYMS)			+= addaddrs
 hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 9b4ca83f0695..94c2ec366b91 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -27,6 +27,10 @@ ifdef CONFIG_LTO_CLANG
 initcalls-lds := .tmp_initcalls.lds
 endif
 
+ifneq ($(CONFIG_VMLINUX_MAP)$(CONFIG_KALLMODSYMS),)
+KBUILD_MAPFLAGS = -Map=$@.map
+endif
+
 # objtool for vmlinux.o
 # ---------------------------------------------------------------------------
 #
@@ -47,7 +51,7 @@ objtool-args = $(vmlinux-objtool-args-y) --link
 quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
 	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
-	$(addprefix -T , $(initcalls-lds)) \
+	$(KBUILD_MAPFLAGS) $(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
 	$(cmd_objtool)
diff --git a/scripts/addaddrs.c b/scripts/addaddrs.c
new file mode 100644
index 000000000000..d15cbbf8d262
--- /dev/null
+++ b/scripts/addaddrs.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Used only by link-vmlinux.sh */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+
+int main (void)
+{
+	int i = 0;
+	while (!feof(stdin)) {
+		uint64_t a, b;
+		int ret;
+		char *rest = NULL;
+
+		i++;
+		if ((ret = scanf("%" SCNx64 " %" SCNx64 " %m[^\n]\n", &a, &b, &rest)) < 3) {
+			fprintf(stderr,
+				"Syntax error: invalid line %i found in rangefile generation: at least three fields expected, %i converted\n", i, ret);
+			exit(1);
+		}
+
+		printf("0x%018" PRIx64 " %s\n", a+b, rest);
+		free(rest);
+	}
+	exit(0);
+}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a40d372b1289..3b3ea6214062 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -60,10 +60,7 @@ vmlinux_link()
 	# skip output file argument
 	shift
 
-	# kallmodsyms needs a linker mapfile that contains original object
-	# file names, so cannot use this optimization.
-	if { is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; } && \
-	   ! is_enabled CONFIG_KALLMODSYMS; then
+	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=
@@ -153,12 +150,31 @@ kallsyms()
 	#       - but sometimes there is a line break after the first field
 	#   - start reading at "Linker script and memory map"
 	#   - stop reading at ".brk"
+	# if there is a vmlinux.o.map and LTO_CLANG or KERNEL_IBT are
+	# turned on, we have used a vmlinux -r'ed .o for linking: use this
+	# as our primary information source, but acquire section addresses
+	# from the (later) linker map we were passed in.  This makes things
+	# a bit more complex, since we have to recognize and eliminate
+	# sections elided by the linker, and add together numbers larger
+	# than awk can portably handle.
 	if is_enabled CONFIG_KALLMODSYMS; then
-		${AWK} '
-		    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
-		    /^Linker script and memory map/ { start = 1 }
-		    /^\.brk/ { exit(0) }
-		' ${3} | sort > .tmp_vmlinux.ranges
+		if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
+			${AWK} 'BEGIN { addresses = 1 }
+			    /^Linker script and memory map/ { start = 1 }
+			    !start { next }
+			    { got_section = 0 }
+			    /^ \./ { section = $1; got_section = 1; if (NF == 1) { getline }}
+			    addresses && got_section && !(section in addrs) { addrs[section] = $2 }
+			    !addresses && got_section && section in addrs { print $(NF-2), addrs[section], $(NF-1), $NF }
+			    /^\.brk/ || /^\.bss\.\.brk/ { addresses = 0; start = 0; nextfile }
+			' ${3} vmlinux.o.map | scripts/addaddrs | sort > .tmp_vmlinux.ranges
+		else
+			${AWK} '
+			    start && /\.o$/ { print $(NF-2), $(NF-1), $NF }
+			    /^Linker script and memory map/ { start = 1 }
+			    /^\.brk/ { exit(0) }
+			' ${3} | sort > .tmp_vmlinux.ranges
+		fi
 	fi
 
 	# get kallsyms options
-- 
2.38.0.266.g481848f278

