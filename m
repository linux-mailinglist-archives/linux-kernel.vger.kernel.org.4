Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCE5BC49E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiISIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:48:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329D17E00
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:48:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6kTEn009869;
        Mon, 19 Sep 2022 08:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=b2IFBuGJAdYls0vnzeAKVmaSHNpo1V9qgDdYM0kGO3E=;
 b=1T19XJwEdfDxW9DnwspqxG6qkdKpYa1wuL1qsH+HtsWGF6iAjb7eSStq6bz5ei0O7inE
 qg+tGSsKd61bZDoQ+bNDjxzD2hLdV4P7n76fyYq4kaRh5A070SdKhY2eigHK2pLxXpKI
 77U4zcE4MwzfU0Mky1RqMUKGD/JzPfuOhZdmtJ1hk656dYa+7UPVfKZHlg5bFlrAieMh
 RfcrBWmvIfg0PFiqRiXDayje0lx8/qaX7Qj2wjqIr4rk93vsFO9Ydiri6uJcgAFrXf1P
 whv+d2Jehu782YWQRAgC4IP2uGI7RxDwray+ireWWQ+w9a+YMgcnD6fvPhymxoCEAKhn Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kk4ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:48:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6bxHu035896;
        Mon, 19 Sep 2022 08:48:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39hjmnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga06QUAYsDjiAxQ/0C8vmy1wsI4KeMlDvsmMlPnkMlcZWVoA6r7uHKrnUuK1ulPxgfgZzruGOfMjiXXHeGF/YO9KtCWx74c0Z63UScr2pu9zEBxszKtiGT2QkZMm6Pinz8C6ANau91itVwkhCeVPgTZEKKpDeHbZQnYVYCu0hEMa5+2T8r+vByy0IkKAoIAZk86m+rKfZ2vpi0lmi0mdg/lPjsJwQJUcmOca4DOrbm0BVc0pPa5tU6J8TJxRd1Ds58gEaXxFyhVGLH2yS4pjJ/QgNbqL7cALJXQizyms+7hKd5dxgpWlJblLFftW5J3mMEHf9TBcJPOaOI4Vf8owLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2IFBuGJAdYls0vnzeAKVmaSHNpo1V9qgDdYM0kGO3E=;
 b=jO4yCDgOINVEmYqDGNBDgh5ldxzReercXDZVkgFw9eODuWyuoy4nupi6kwob/Y0++IjvtYaVGErmLvc4OXykZN58ShfeKP4w96VLEERhslvCmZGtNbdUDDeqXfkrvtFvrJbqgybL9X9TiSF998sV+uaqyyRAl9KavQQqJtREfhiQ0FJadaUCTJUNznFwBztvoFQYT5cM7Dx69GJeJk+3lAk+Wb4mM3vWm7wuGeK0emZBeHgOOD9Q70Arr3RNSSOamCUpAbtr5wA5xLH4D/AC9RMiqTVvi3N0hC+r9sE0yjrbCd/wCgOeUkjEafGPnJjwD9aFZAdgk4+IvnMfXyDUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2IFBuGJAdYls0vnzeAKVmaSHNpo1V9qgDdYM0kGO3E=;
 b=Y0pH0riTDEyOuyP7veqYhh3Ixhxa/27Tz/c6Q0jNtApC7YDgiAHMAist6K4uQiOLQGtWtXh0x+Q2nEM//zVaRAZHwnEyEMqbjxpIh0OjdAKYznWhZxeajg26aU5RrC1yJSzRX0H6u3fklvcZJuYiNSd29ziW3xB8e347QE7FqP0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4989.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 08:48:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 08:48:00 +0000
Date:   Mon, 19 Sep 2022 11:47:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 18/22]
 drivers/soc/apple/rtkit-helper.c:46 apple_rtkit_helper_shmem_setup() warn:
 variable dereferenced before check 'helper->sram' (see line 35)
Message-ID: <202209180216.pPTbUHZl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::26) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f729b5d-1ed6-4cb7-f239-08da9a1ba837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8u7IruDdtnd5uSBGEe21+XUc1Z6NxIwLihcyQpbPeKzAmfS5oC5SAkrZGCWxoN+DoOs8jSvknmWVgN5+cFyJTw+NhcdFibtfyJLpA5jJPOnvGt+TP6Vbirb7hzm0xNgncS9vn4KQeU2KCn/dKXgGNrVhpi1sADjlH04NAZOecBHnrt4p5T6wREWBnGkJLY3lPkEHfLblCcysu6egE5aQf5YcqvBwwPOaARyN99f1luVykJ9UrJfveIlFMVXBSyfy28SS3lCqlvn6X0U25U9bSkQ1lJPI9ENfnVl3M6xUx3s6PA7r8e1wSVHDUr+F1zyK7FA1Vv4bueYluHBczPWk8oxXIWGGRJISHnSy5qpkFGyKlmmAVhJ3X2yMAWx2U1BXJB5hXIn3OkJ4zrbHfmrG7RG+e2xo2ytesKU/gMOhAhVNZuEpT9op6BdWDnz6AIfc72MuZ3D5w9Vnj14l1Lf2GVnTNTFBShfF4xmAbPgcp5SCcRWJo30ZdFo+ZhnyDvlwi0h7j3oDTAPxzlwzYGGjQY+tk59STgjCqeKG8cEaDyRsk5M+qvvkLjuQ3OSfUE0qkVhiZFDnFq1WXK0Dnljlq1wVX6Pgwr4ooLmYFcqTpvHGO5GeqAhWznA1PIVWn0M7WEhRGnouQr0B7W4mxUrDSX4ReyTjkqZiHTcNqgePrRzXsfta/8nv5MWpF5BHQL5f4Kr6Gpwh3wUEuSBhjqGUEWR1a+bDayeT+7l8UrvqHOjsINTsMjE0leFIRxToO2lZQYE82eIqAImsTGXPHAcr16mtECJTv9sxTjRTA5cEB4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(47660400002)(451199015)(1076003)(38100700002)(8936002)(186003)(41300700001)(9686003)(6512007)(2906002)(26005)(478600001)(6486002)(316002)(6916009)(36756003)(66476007)(66946007)(6666004)(66556008)(4326008)(6506007)(8676002)(966005)(86362001)(44832011)(5660300002)(83380400001)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16bw3JURs4+FeDHTMeF9OaZAQrW/gSPLnA4c4UO+2bxJ1iFcFN6vE9q2kZzs?=
 =?us-ascii?Q?5QbfW+lVWDGkakFeRLSkPhiW7b6B7bOtU3fMwtDcYMsCXhvcqr6546a4LJqt?=
 =?us-ascii?Q?5Xnhn0/xAJnUeTLLP1Y89xqWMOz4FMtCN0r/xredHRBETbJYopfw2tgQ5XNv?=
 =?us-ascii?Q?OPOAyQOo8Vta1ZfsMZwI6gGPflf15YyZoOm2LhFai8WK1t0ozxWLZrFuyoSn?=
 =?us-ascii?Q?QAuNu5PmIKd4fYzRYITWXUhSC5P8DsMv/bNETjfrzA7zW/HDgZ1maxlWuU+U?=
 =?us-ascii?Q?bWJ/eAOPeFYuTzNxJ0P0B9LlQsSWfQM6Lssm0Frmn0YlQ+B0Ym7qIJ+azUut?=
 =?us-ascii?Q?O3NeBouNc1BO5e1L7Be42B+eJMyfqyFp1Zhhyk049aaee3s3/2hiVToZZl7X?=
 =?us-ascii?Q?89MO2WoABc9fBSv3FJl026CTOnvziFmCcuhnumjZrt2s7iTf35PZsmIzafbF?=
 =?us-ascii?Q?ChL2iIOhEN0VKbAx3wMHe7MkWQao11ZnLFkiKzeE4zjMcJSBy0wYw/gzXaLg?=
 =?us-ascii?Q?2oZd5Mk9lnBieNPGvJfiUXNSvjgE2PKHMtjw3kJ3pWjgqwGzCwVuZXN66KoR?=
 =?us-ascii?Q?WOI3tn/GGRZ1whuTy6DpobRpufNX+3BpFoxyW7XwfR3PwFkR3mtV6/YsYF2/?=
 =?us-ascii?Q?3DzO8QPhT6wV/wVXAoSU3vWQuPAgGybIdqwrINgoHLKy6hT2WHpxKqdWPPYi?=
 =?us-ascii?Q?5mlTqQngHUxwWEeCYXRnH+S/35cHlWiHkDzgNnSY5jy+50nsn/dAgcdZCL2N?=
 =?us-ascii?Q?u+ll15OoUzqm+mwIcBVsZX8OKB2UR6MINLk0+mnGWU0XJMDm0onOCw288Dbj?=
 =?us-ascii?Q?4nKd240nxttOsMc9t7GaodFkBZiuqC03YOWBr4yyjhmHsTIjA0d5nxh44dNv?=
 =?us-ascii?Q?6jnAzdQB/myABI2T9jOs7CPD37N+BCTti0tYljen1OtpDeMqifoLPul7bVoe?=
 =?us-ascii?Q?GsOviOFVD13JNr1WlHEvKYYYi3oHTMdyR6D2NrQ7vyu41dhg5RBdmTCLvdTs?=
 =?us-ascii?Q?4RM1tiWQXT5k7cjdZHysrVlOlh7FjLClQP8WLevA0ZDhT3Ef/FFhW7akCWPm?=
 =?us-ascii?Q?KnF+WqdlYqBU3QibRzO4XoYHBUycfT4ugBPuGLSAqCv8jvrWnu5bG0qR476l?=
 =?us-ascii?Q?WXM9TlsRmReXsYT7LIN3iEtj2d6U6fTuH7Y240P6VJ10XN5orCTBOtHxt8gX?=
 =?us-ascii?Q?/AeTNQxvVOG/Ij3KzPjKtPw+0UChse+f0yMsZjWBLrI73qr9EGFcFr4+kZMP?=
 =?us-ascii?Q?OmkrkOTz5p8M22XFelNkwgxk6Sk38UziiGh3MJ/XpoJmHheyAfc7IET57KMq?=
 =?us-ascii?Q?fub7T07uNYsLy1mik3P239lkuyS7HfDi0dFws13cNWH0kJgCzvt+7McN68SH?=
 =?us-ascii?Q?kNTzShvXajmWh4p2tTTSq1tHo4D63O4sLwO/vIrS/G2LOgUaCMIPmaTo+aGA?=
 =?us-ascii?Q?lZ3B1RwxmqWIUGr6mO9ml/3/MwM14N2L/4WW6fb+7l3txFWFdrgmeKEiB2wl?=
 =?us-ascii?Q?LpNY+4ILMs/PH0/hI54W8VdVbFzSZUiFEf3I+v0GQlJUysPNWEBEcFxbxv9f?=
 =?us-ascii?Q?vlp46tuzQeA+5ILLpIJ6bEgNvbs6qMhSNQ2IWRrW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f729b5d-1ed6-4cb7-f239-08da9a1ba837
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 08:48:00.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x1HcIHthl5YRl7oTjZh2WLvDSdK2jmhU7OxTTPC8P1PO/9FfJB8siZBz4i43hXkKaqgP6WjCLlQpXXbWte7hYAVKpbSKmlVCpndMi3wOLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190058
X-Proofpoint-ORIG-GUID: pt4xrfDwgLC5gOKicvzfzLNQgvViGZZz
X-Proofpoint-GUID: pt4xrfDwgLC5gOKicvzfzLNQgvViGZZz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   ecf1fb81499a2f1724cb90497ca3c1cec831c9b6
commit: 51f1f2b38adcb95f2e04665ae54fe99ba6bd7844 [18/22] soc: apple: Add RTKit helper driver
config: arm-randconfig-m041-20220918
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/soc/apple/rtkit-helper.c:46 apple_rtkit_helper_shmem_setup() warn: variable dereferenced before check 'helper->sram' (see line 35)

vim +46 drivers/soc/apple/rtkit-helper.c

51f1f2b38adcb9 Hector Martin 2022-07-03  28  static int apple_rtkit_helper_shmem_setup(void *cookie, struct apple_rtkit_shmem *bfr)
51f1f2b38adcb9 Hector Martin 2022-07-03  29  {
51f1f2b38adcb9 Hector Martin 2022-07-03  30  	struct apple_rtkit_helper *helper = cookie;
51f1f2b38adcb9 Hector Martin 2022-07-03  31  	struct resource res = {
51f1f2b38adcb9 Hector Martin 2022-07-03  32  		.start = bfr->iova,
51f1f2b38adcb9 Hector Martin 2022-07-03  33  		.end = bfr->iova + bfr->size - 1,
51f1f2b38adcb9 Hector Martin 2022-07-03  34  		.name = "rtkit_map",
51f1f2b38adcb9 Hector Martin 2022-07-03 @35  		.flags = helper->sram->flags,
                                                                 ^^^^^^^^^^^^^
Dereference

51f1f2b38adcb9 Hector Martin 2022-07-03  36  	};
51f1f2b38adcb9 Hector Martin 2022-07-03  37  
51f1f2b38adcb9 Hector Martin 2022-07-03  38  	if (!bfr->iova) {
51f1f2b38adcb9 Hector Martin 2022-07-03  39  		bfr->buffer = dma_alloc_coherent(helper->dev, bfr->size,
51f1f2b38adcb9 Hector Martin 2022-07-03  40  						    &bfr->iova, GFP_KERNEL);
51f1f2b38adcb9 Hector Martin 2022-07-03  41  		if (!bfr->buffer)
51f1f2b38adcb9 Hector Martin 2022-07-03  42  			return -ENOMEM;
51f1f2b38adcb9 Hector Martin 2022-07-03  43  		return 0;
51f1f2b38adcb9 Hector Martin 2022-07-03  44  	}
51f1f2b38adcb9 Hector Martin 2022-07-03  45  
51f1f2b38adcb9 Hector Martin 2022-07-03 @46  	if (!helper->sram) {
                                                     ^^^^^^^^^^^^
Checked too late.

51f1f2b38adcb9 Hector Martin 2022-07-03  47  		dev_err(helper->dev,
51f1f2b38adcb9 Hector Martin 2022-07-03  48  			"RTKit buffer request with no SRAM region: %pR", &res);
51f1f2b38adcb9 Hector Martin 2022-07-03  49  		return -EFAULT;
51f1f2b38adcb9 Hector Martin 2022-07-03  50  	}
51f1f2b38adcb9 Hector Martin 2022-07-03  51  
51f1f2b38adcb9 Hector Martin 2022-07-03  52  	if (res.end < res.start || !resource_contains(helper->sram, &res)) {
51f1f2b38adcb9 Hector Martin 2022-07-03  53  		dev_err(helper->dev,
51f1f2b38adcb9 Hector Martin 2022-07-03  54  			"RTKit buffer request outside SRAM region: %pR", &res);
51f1f2b38adcb9 Hector Martin 2022-07-03  55  		return -EFAULT;
51f1f2b38adcb9 Hector Martin 2022-07-03  56  	}
51f1f2b38adcb9 Hector Martin 2022-07-03  57  
51f1f2b38adcb9 Hector Martin 2022-07-03  58  	bfr->iomem = helper->sram_base + (res.start - helper->sram->start);
51f1f2b38adcb9 Hector Martin 2022-07-03  59  	bfr->is_mapped = true;
51f1f2b38adcb9 Hector Martin 2022-07-03  60  
51f1f2b38adcb9 Hector Martin 2022-07-03  61  	return 0;
51f1f2b38adcb9 Hector Martin 2022-07-03  62  }

