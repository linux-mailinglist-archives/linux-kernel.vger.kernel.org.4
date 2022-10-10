Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A65FA006
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJJOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:16:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33C71720
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:16:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AC45Al030737;
        Mon, 10 Oct 2022 14:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=PG/tBP13yW5RS14KiCAHZimwZNm5kdgYJ+tn4ylyALY=;
 b=IcPNkPlGQrwF1BrBRsMN2QMCHBZdS6HqyktPAcx7+NlbG7pFVBxgafe1eJvR/bS5UXaT
 DMBlKEmvDhYSx0OhrAHf9UITBJCbz7832HJfqQ6o5s9SnJkrCoW2ZoFzWO9sSRy7FUxU
 Ax3/aGr+XU9xdSjJ454UqE5+U0Txbibkdfj365aYj4Y4YRJ7Trq9s4qs3Teo9r/P4Wt8
 4oOkrkI2XcIU+duA1AYMg0nRl3t1//h7NNxub4iRWThIP0SvNdPeBJ9/w3DZbGQOfbWa
 6wh9O2o+0xoZBPByG1HJ84IVZYCRMr5v+pik71aIx4bUcnAqUh1e6QhNz8lO36rCBf+K zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3139uq3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 14:16:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ADcj8g021836;
        Mon, 10 Oct 2022 14:15:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn35t8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 14:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7dadADoaoom9lJe0g4hVWjxcrVe+Thq86g1Z/FnsBmVniT8hmO7PYgeJa9UMx5MhGj33GAnNcYIJ9IZ49ofFtTsM+blWtFRk6G5E0njqFSHb6zwrYIMAHNvWdD4EQlivM8wVG5DgVM7IgKxBo9TQ/2Q5h3LF1UYTXMcLRhn/A2jcCk5+PrR0gizNLpFH3BdmN1xDyapd4j1AiAjwPQc+aq/m2iQbuZO7KxuqO1BcaXibT7nRH/viveJuN0aWvtabi80kGeyqrLqsQ9QFVA/UYSMr6Q6yripJ7o9GhnmkBqONlp6Ph6HP1ivr/7VjA5l4q7Ku59iZsY90OViKhh1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG/tBP13yW5RS14KiCAHZimwZNm5kdgYJ+tn4ylyALY=;
 b=eqKRcZh3/PRgWq86nd83w7DfzMhpnT4JwXIykTLrla4Iy5UKxpdQjKkttIP3CUDGlgy7xkFfFDpZiDkkI01FnGHcyz95j2qKndleJL54rb5AFtQBepjlSapyNnnysSyBgl2us5xEQIuSGvH206JlhajK55xUcC1UMnN2v1LD5Hgwfynry5vngQs1zbwlkMsH+l1hyClf8PsHGK12BFzED8LYgnOnRSYytA+lQ49ggCMIGdbzGfxUrKSwHgaArbsWAn/PtAE2ghiIfGdb7U5HCrdirfiH0C7gpHhkvf/SzoWtiY0EXgVlKNno89oEwm+T93KEVpeQ6jkNmXF0LQCpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG/tBP13yW5RS14KiCAHZimwZNm5kdgYJ+tn4ylyALY=;
 b=F4Uew0ubDjH8G/Z3DU4zrmgSPTPmNpqDtoy7q2nlS3HTj4vRtb3WgYfDocsoP9//ftlLz8NMs0tN3rQqIvyq9aMpJkbKs6cr/uctSteKKdbZa5BBrmHPqhiPcerFWZbwMC01acYqqMmXu1BMzw7eppMa6zcJvzVh9oY2pcu2scM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5368.namprd10.prod.outlook.com
 (2603:10b6:408:12f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 14:15:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 14:15:57 +0000
Date:   Mon, 10 Oct 2022 17:15:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Oliver Upton <oupton@google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [kbuild] arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn: check
 for integer overflow 'offset'
Message-ID: <202210102159.8nYEC0Hl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MRXP264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d1e26f-617d-470c-a389-08daaac9f321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KP4ThcuKHoblDQxkflxPSBV8PFbLVlxMA7qr69+d/sSI1qipOJER+fQWIWnllVKs0SKkldY0cVWi3Ln9fGMP6vY3ubgnDOmyiMW1uAl27t5nfrhOT0If1URTFDEXWxcosfalRAiciNUnUw6O+IVImRFCdl17BPTD293Ll78iQDC0krpW9kp+m1dTulH3+r5/1YyonkdMJj0OMuWteQBPVJVryosMf3bfGJrCnItTLOgGIRe4Kpfpjcgi8LCDibH2o9Hc+pFH+KKTG5uBNfPKmNLRiYA1CgRezBtWryGUXCTrD49adOlUI3rSDL1roHAjKd1dJo3tJzKuq4BoZddXiWeIJloi08YmsznEI6lJK7nRaEJe4loff7opjqlwXxxixOp3/w7hPgXDXdWwnDLwPv4npPwEOPK0cGEMnvCrPaEJXEgL21+zbDfKM93qfe9jv0h4vGSfOO+cWiT0Tv+mctF3u2Yg+ShV3Ln3NxiVYnYMYZ3exB/lJIClU7lK6axsqMlzs88I0tF/n1U72P5921KLaxbAmxLz6YTIDv6A7DLwBAwRAnhalqbKHRU5ibnO32oj70eS76tANYvNejH3GV6ww8yemXnMd/wsiWt13Zj6m/Z8crFX1vbs+HFr+4/p+EtxGaNDq44w7+mFi8G6HgqAsXnad3BoXqtFI1rPWbGcv8GbF6zSpZg5K68pyJGxrCBNUyzlKQSdOb6LFE64IH7xEYtrQ2cicMgO54+0wE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(26005)(186003)(9686003)(6512007)(44832011)(2906002)(86362001)(478600001)(5660300002)(6506007)(6666004)(8936002)(966005)(6486002)(36756003)(83380400001)(1076003)(6916009)(316002)(4326008)(41300700001)(66556008)(8676002)(66476007)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFFTWqDEqhg6FF5bnQnI2rJYFZMQGUp0GY0a+dhJJcfHxQY24PZct5CqNN1Z?=
 =?us-ascii?Q?5O8G9sn3K9lLeJnxUQ8XqEzikPDRj8vqXPWUp6f/PqlqsNzVeneEHsh/HiPW?=
 =?us-ascii?Q?2y1eaOiL1EtKvnEr+P0ZiO3ZGQ5nATgh+KXKP/1+UCzBh4NMdThOAHXc8odS?=
 =?us-ascii?Q?ThgciP8nQdnzIRaaNt2IpighsZxZ4kaaICgtI4iCkCWdzSyxxQGyeov3SKQw?=
 =?us-ascii?Q?i5Uf7+zmqVqKKw1Wn2oWpAwGzvcUebvQ1w3bqE3Ietcshnj8QeWL//rLS7bI?=
 =?us-ascii?Q?gXdmOKJYjVoNhZ9iat+GshgDpkgKplDgAEqaksQBisl5Da4eqgNC5Kj/0QG5?=
 =?us-ascii?Q?M/xnSZbqJitjx11F14OYvParqEfRW8a5GldaW1tK4M3iP6whLYUrAvucxT+Q?=
 =?us-ascii?Q?sT0jFuGycqdIoHnaRZgvqexs545v8dJrygwDb3xjoaCuWUdzHspzaLlgTPPY?=
 =?us-ascii?Q?Ip2+wEq4BTuiHJhESrPtdOR5zXC3mPWqBA353niGmNC8OBzFK5dGqTF3IHKP?=
 =?us-ascii?Q?sQOveowB4zLm3gXtNMWovd6k1Y26e+3b0xIsDIx7Ee88r6v9z1Mz0pouwnv5?=
 =?us-ascii?Q?e3GvFBDjv7xEHkyoIX/PdPyXNn2uquOd2hFKVGSsRNT10MEFcHc+pqjACDec?=
 =?us-ascii?Q?aGNVbbw7E59Hmp+cnrNCifF1GJjAgmciizO4JTDONXl/mQiPIdfmbf7NQJGD?=
 =?us-ascii?Q?a4RQ2eILOTlKMXDR753IZLEZIBKezAM6J3HV+uorE+RUwmhiPqzm/lRRQoQa?=
 =?us-ascii?Q?0UNbS5LzesDsWGsFjVGjiUX4ZWjclb4sk/Zot7mRUPcF7mg3a3BQA8AcQ6Dx?=
 =?us-ascii?Q?QFHmARvJbY+3Ls+lIRbQtMmiCPCZLWB3XpfToAfZidvwxE7mLXBgXEa7Tct0?=
 =?us-ascii?Q?kq47WOIhBYqnpCHICglwr+/GMoSRwcJyFtCM9mnD4Mkgbszp7PiaA8mPPQsv?=
 =?us-ascii?Q?ryWsibfzfD/7edjo9BZSSFNlOpEPe+V7sx7MmFtJcMTk6VfXeuu1X8yQmSNw?=
 =?us-ascii?Q?r2BSXPKbLvzBwRNFsKPTAsv4ZKpYdWDOWAmR6JSDAKFNYYowfwJTWU7HY+3T?=
 =?us-ascii?Q?iFWiqyBYQjwm2r4S4QT8cFtSC3S3K74prLChxv+e2nNqPHoXfPeyxEpvmMVH?=
 =?us-ascii?Q?0XWYgDrdldk67sM6Rlr47pTV1kLN9Is43Khg0h8YkXzcX4NcZRmeAo1rc58P?=
 =?us-ascii?Q?zpcHtB5PZEuUTuVF+fIXIZRY2quNS5CFRMFKqF4NKFYrKqKIeUCo5gjNuMCP?=
 =?us-ascii?Q?Nd+QN0sWPjkaJYNPs9F5XMA7cujQUL2QU0vFoP++Cr2ruYXGcj2PyISMkJ4n?=
 =?us-ascii?Q?ZXzZEdB1H2s9OWvKZID7i9Z59gkW96Ws8207uGGnI80tqWMYSfIUXa+qwt71?=
 =?us-ascii?Q?bVy6udysqzN6+PPsKBvHxqv7rdHeWWimhc70e5y81Fn/ja6SrCruUFgFr5eZ?=
 =?us-ascii?Q?v5D4lAEn9DvE5s3RHbJroiEMNt6rLiwnM/Z1dJPzzztpG0DxFMQOT82gbWq1?=
 =?us-ascii?Q?ZtxCUJvFG32TdJ3oDw4bsglCNM8w3dAwRw0NbpJL5oj+Y7syYKutmYW1lFRu?=
 =?us-ascii?Q?jhUqQFeI5FD+q5i/A4J3rqErXY3CvtJHKqYDWDIeCuY0bHtgIynz6nHp7aI6?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d1e26f-617d-470c-a389-08daaac9f321
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:15:57.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJht3GgNwIonNxZk5ECLIFigYhIWuwoh+BzVS2Z/nRkyP7tR0Z7DCUdz2P5zRVKXreIWtTpYZX7IKqYdjOJzgOGe3GCh4ua4yMllFe13LmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_08,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100085
X-Proofpoint-GUID: U_74ggNmrJAujclveGO0FJU06TL8MeAk
X-Proofpoint-ORIG-GUID: U_74ggNmrJAujclveGO0FJU06TL8MeAk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
head:   493ffd6605b2d3d4dc7008ab927dba319f36671f
commit: 828ca89628bfcb1b8f27535025f69dd00eb55207 KVM: x86: Expose TSC offset controls to userspace
config: x86_64-randconfig-m001-20221010
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn: check for integer overflow 'offset'

vim +/offset +4988 arch/x86/kvm/x86.c

828ca89628bfcb Oliver Upton 2021-09-16  4962  static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
828ca89628bfcb Oliver Upton 2021-09-16  4963  				 struct kvm_device_attr *attr)
828ca89628bfcb Oliver Upton 2021-09-16  4964  {
828ca89628bfcb Oliver Upton 2021-09-16  4965  	u64 __user *uaddr = (u64 __user *)(unsigned long)attr->addr;
828ca89628bfcb Oliver Upton 2021-09-16  4966  	struct kvm *kvm = vcpu->kvm;
828ca89628bfcb Oliver Upton 2021-09-16  4967  	int r;
828ca89628bfcb Oliver Upton 2021-09-16  4968  
828ca89628bfcb Oliver Upton 2021-09-16  4969  	if ((u64)(unsigned long)uaddr != attr->addr)
828ca89628bfcb Oliver Upton 2021-09-16  4970  		return -EFAULT;
828ca89628bfcb Oliver Upton 2021-09-16  4971  
828ca89628bfcb Oliver Upton 2021-09-16  4972  	switch (attr->attr) {
828ca89628bfcb Oliver Upton 2021-09-16  4973  	case KVM_VCPU_TSC_OFFSET: {
828ca89628bfcb Oliver Upton 2021-09-16  4974  		u64 offset, tsc, ns;
828ca89628bfcb Oliver Upton 2021-09-16  4975  		unsigned long flags;
828ca89628bfcb Oliver Upton 2021-09-16  4976  		bool matched;
828ca89628bfcb Oliver Upton 2021-09-16  4977  
828ca89628bfcb Oliver Upton 2021-09-16  4978  		r = -EFAULT;
828ca89628bfcb Oliver Upton 2021-09-16  4979  		if (get_user(offset, uaddr))
828ca89628bfcb Oliver Upton 2021-09-16  4980  			break;
828ca89628bfcb Oliver Upton 2021-09-16  4981  
828ca89628bfcb Oliver Upton 2021-09-16  4982  		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
828ca89628bfcb Oliver Upton 2021-09-16  4983  
828ca89628bfcb Oliver Upton 2021-09-16  4984  		matched = (vcpu->arch.virtual_tsc_khz &&
828ca89628bfcb Oliver Upton 2021-09-16  4985  			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
828ca89628bfcb Oliver Upton 2021-09-16  4986  			   kvm->arch.last_tsc_offset == offset);
828ca89628bfcb Oliver Upton 2021-09-16  4987  
828ca89628bfcb Oliver Upton 2021-09-16 @4988  		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;

Smatch hates obvious user triggerable integer overflows...  No checking
on offset.

828ca89628bfcb Oliver Upton 2021-09-16  4989  		ns = get_kvmclock_base_ns();
828ca89628bfcb Oliver Upton 2021-09-16  4990  
828ca89628bfcb Oliver Upton 2021-09-16  4991  		__kvm_synchronize_tsc(vcpu, offset, tsc, ns, matched);
828ca89628bfcb Oliver Upton 2021-09-16  4992  		raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
828ca89628bfcb Oliver Upton 2021-09-16  4993  
828ca89628bfcb Oliver Upton 2021-09-16  4994  		r = 0;
828ca89628bfcb Oliver Upton 2021-09-16  4995  		break;
828ca89628bfcb Oliver Upton 2021-09-16  4996  	}
828ca89628bfcb Oliver Upton 2021-09-16  4997  	default:
828ca89628bfcb Oliver Upton 2021-09-16  4998  		r = -ENXIO;
828ca89628bfcb Oliver Upton 2021-09-16  4999  	}
828ca89628bfcb Oliver Upton 2021-09-16  5000  
828ca89628bfcb Oliver Upton 2021-09-16  5001  	return r;
828ca89628bfcb Oliver Upton 2021-09-16  5002  }

