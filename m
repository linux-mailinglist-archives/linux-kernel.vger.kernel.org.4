Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB16058E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJTHnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJTHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:42:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89354B0C1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:42:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5p1qM016853;
        Thu, 20 Oct 2022 07:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=j5XCoob5nb7tWh2KiyH8n3T/BudQR1XKefObXpR5dew=;
 b=rM6pGzWhdSBjrLby77E8cHH7zZO1VbZ2zK37ZlGeZYatv9acc29nhEHxlZ9nkUpM0Ur7
 exSyB2TOD2GgvuAWr0oB29RQkAG0saLqN777f50lhrMy1nkNLSgdGrVjc4KhjJxaHqFE
 FhweLhEtAqXfKwj+dTGBSaFE6KSQKO0NNgZupfGrGQLPPS9krY1nlBQ1Q7242pwYk671
 yjksUyeUZCSO5BztSUEq+QNd40RvHPLREC5df9/Aq4v4v/lVME9YeWvbgy18I/9Vbi2F
 ITuolNLGea/HgOQG8+VGmB477L0qR0NCc2Rh7EL8fZT+L3Ksd/u+O45U16MAzMHZqK3S Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sqkyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:41:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K4pYkH003893;
        Thu, 20 Oct 2022 07:41:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0sqkkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBb/76nS6OfEnsFUCRswm1dQeITx3bJ8fGhuaglgTgARYChVY8LtWeFLR4ZkPFzeMSQzXT3/sYdyRGXaIVtIHdN0zgnn08EPxMUAD/K9IPcYp/lz29hWJk9Kw+6qmFFEieeldJpLR3zW8qOlQgQO4iYJA0k51KT0LncRhCE42+80gtGUaicYgCXETIYq6HJISYWReTKZ5MIPDqnP2aWNGtt3sdNtLomKs6ezfq10H4BV71O1NxdH+0rSLvNFObRV2EiBt3KVQJ22egSibGqraezya+qwz9be7EevbGdWgB0TgOtAm91VIOOnygnuBsoEJrhsvHae803eqIq6vM0pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5XCoob5nb7tWh2KiyH8n3T/BudQR1XKefObXpR5dew=;
 b=fV1DigwSRtFDaSxgXP99i2mnDnLRhKz5JXRJbF7u1k8r9xjOtHPwaVY3m0thclfQ3mbs0cgFrPwBFoZd1ZTjYVA2W6mBtOiw7nzXYkIhKZNwu4iOZ0+uR9HLLHWoRLWsL2+CmCjcoX1IMHevA8fUqhJm7FEDo+u+2VNJO3/RH0sB431QVc8Iw9gTgScMuwR+6GKezDTAS2KXt+Jn7UWyPa63gsDal+ai11zpwOqHumF80DDNng7JITfUiz5y7VPk8JdGFv1S/m6BIZa9/ksSKvz6WO0PWc8w41GJ+b6bpYXQ20Woea1TKD58QW5QtDRBtFXS81I1MKjfQTbD7iC1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5XCoob5nb7tWh2KiyH8n3T/BudQR1XKefObXpR5dew=;
 b=Vy+7jzhh0bSCu/IEDZ4mjIPO6YSR++huewJf+GhzB+l2mm9ptvNNi64c25mG4Y3abBOF8ZvMykOuUAcPf6TgGWUSGZ6eZI+dXXwWBdQVYjMThNGpESvmCcQ5kSdAUQJFMO+IZz2aB3VoP+z5+xfYY64RPWHvo3xT2537vi4WJ3c=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5103.namprd10.prod.outlook.com
 (2603:10b6:5:3a8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 07:41:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Thu, 20 Oct 2022
 07:41:20 +0000
Date:   Thu, 20 Oct 2022 10:41:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mikko Perttunen <mperttunen@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/host1x/context.c:77 host1x_memory_context_list_init()
 warn: missing error code 'err'
Message-ID: <202210201547.ejolabSg-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: fa389952-fe03-4664-fb18-08dab26e7aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EH0tJxPw9s0UNbJZx+KSPUMJICUPb8ppxkrJ2D4BkAuRY++3VNOncN64SAtKD4cMDm4m3Du+iozvg8x6Px9zPxGCddfRTza+slNnjMKewZ1Ti0hpPTf9IHKK1SoiJZbGrMla2NPZ9TgfJaBoQTO0kMT7koDGX1YksbU9qLYCiSOnimpLI9Pc6uTaoOuW+TkK4kSWl0RBGwwFPfJBFDv7v3/1oiCdHmiaF5QUnzWOkDQqhmZmKi0QMr3PeA+37ZkKDu+dAsohvzv8/n35XM3snlK9IsHNdQXNAZVwVw2jJAFtTyE+lb/MJaxe84MlsQZPlANzO1dDY50TtlEcwtUOhzgQvxccOGzVgb/EFlUVZ+GIyB2ltNobKlkflZ36Mk4V4z8U2iP9QEXKfzNIZ2OHqi3s2UrE4GAvwe63aKfmfLDNSi5MxyGBmUVFbRuYw2WoCnWys3pUXpFv2+15WXtDr2Vo4OSPapOoAHoKaBv+G5k3qMVRTlQHWf88R/kzH/myKLvm6Cq3FC9U/5GVm/6K6lEg3OVJtqUFKXT5axutPLgckBS7TJcPU15aZZBz7hYjuVcaTvrnSSEq5jG7Rl2m3vLxWdxnCVlfun3C3EJAUdWn4+3KVSesKCNyi4GslJORGULjCicpzX/OE9v/xtMgqd7MV+KEc8ISIJTXGoclwS4aob9CrHD8bOJNQFb1wwppT60BME8GpB4+hyqi33mTG9BQzQsNc/jmIAMBavLAYZI7XFxQcbNewn0qJotnahpk8jzA46QagNCHgNq3bwGvP6Y6DDu85U/jFmNPKi70G5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36756003)(5660300002)(44832011)(2906002)(8936002)(66946007)(66476007)(8676002)(4326008)(6486002)(316002)(6916009)(966005)(41300700001)(86362001)(478600001)(66556008)(9686003)(6512007)(1076003)(186003)(6506007)(83380400001)(26005)(6666004)(38100700002)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHoOQUyLZDqa23E1Uzhjrqq36e25WYhB9yCSV75EsbZRzq5KGnxZcVM03+te?=
 =?us-ascii?Q?2jrV7VZa74FhT5J5QThq5QJoURH8Jq7G5Z8o6UvLArSbe+JfJOUCebUkjdiP?=
 =?us-ascii?Q?ppmkaTje8tQB9HkrfMgVvQyBi76BDvy2qLs2DujeO2HhPZWnMvUKCF8NGCKO?=
 =?us-ascii?Q?YiZHRm7ONl41GLWf+dGuhMf1kpHdEOS+qMGrtU+MCppgXAMIZQ8W1anlj0EK?=
 =?us-ascii?Q?VQkAal5zubu2Fk+7nEr14ly9MXJ3GJWnhXqbVjzcjw466hRMGsDN6O2ALjX+?=
 =?us-ascii?Q?/RaP/zEy0G0nV/8mFVbB9iYiuzLXMNywjLCKhEaNDFXZPSVShIifj28JaoYs?=
 =?us-ascii?Q?IxuHCW9JWoluVcB5qzvqvHVChNZDni9XCgm7+qrhgLdiO9ffyRsyddZuL3xN?=
 =?us-ascii?Q?/4Lb9hZYWPAxi7NOuuuFTPFVK/Sp0LsTBTw7nLUCEPq40BPPrXZyKFaXkvn0?=
 =?us-ascii?Q?LvJDZF+H2movbpivjiqH3h8uce6/tmpYHrT7yLDmmh3/D4R+I3RgQTaM1Kao?=
 =?us-ascii?Q?3VcIfQTYYpMBn62WDIc2q00QuNQ3Hg+5D+/YuaU6QotivkkgDJz7MwHrSoup?=
 =?us-ascii?Q?jxuNmadfNR6+C3p4YjrdpYY1iBhyw4fHxe9a9huYKH0naqBlaKT57Hpv3iLU?=
 =?us-ascii?Q?9IswfJJdbxg8DS3kv7wa2jmxekaKT7R1KTCNpOA/uSfEdiWVTMoLslJNy6Ay?=
 =?us-ascii?Q?fQzUn2BYMzXiBaQlnlpmGG1xQHGRnP31j6h3UZYeOmZ2QETHkKRAZc+9AwHx?=
 =?us-ascii?Q?RCYHCMdLwSMmjLWWCx2DE7ufQUWHlD9/XFj652c4+hdl3x+wDUO7WgbEDuhP?=
 =?us-ascii?Q?JFAAVI54fiIbwaPuf5pVfJVjDICIPJhr3gxD3WmTZQp+epmwDQ1Ue7AOx7KE?=
 =?us-ascii?Q?kmnKQK3dvJ8HfyUSh1LVgo4ii9idD0XE2UQIZOKKV1+RYDL1NPHrPYYvvEbF?=
 =?us-ascii?Q?VVV0tBrO50g6IYeoHTMhagWKlBAzrR0w5Vxis9Ytq5DM/9M0fr5mggAwKeEf?=
 =?us-ascii?Q?Dhd7z4onfn8UDTYuG+BREPNZ20Vicx7B2cthnFZRN57A26X4xCzoX+sNmgJ6?=
 =?us-ascii?Q?gBwqD8Nz1Ec095cJsvKYynw8Le4WGLSALbudxnvQADBEWAMO/CYQzxlriE5G?=
 =?us-ascii?Q?eoOSn2iZknwApvnTMtcpLCV2p0msigCDnPr6ZUDIWW6Ae5y7uQfVdMULEPwd?=
 =?us-ascii?Q?VkxZK7fS1Pr6J84/nk3JZgL4YvmA9mBmVO7Uy9e9A7tJhPrfdfMRVxLEwO3p?=
 =?us-ascii?Q?6fNmCAukiADFk8/DyPfx1kdnAD0nAdMLHy/tQZ2+fetjnuZiFU1rsDDeLCAE?=
 =?us-ascii?Q?A8UUgirPwXZE1i/F4fUq3doeDsnRV2X/uYeJxa4dZP+5toa0m5tH1KkXw7MM?=
 =?us-ascii?Q?4FRMrgPYxIcALjbSHFAmnnN5aL9F5/tIzDs2FGOajZhS9ujRZDVHu9NAm6O1?=
 =?us-ascii?Q?mWKOE+l6M0CLgVvrpqzf2GpTwYwvQGokCliNtKVEs8B7yfbqKhkEQ1H8nToz?=
 =?us-ascii?Q?To5ML47DU1T49J4eKR8TnABxSB/gmYEAnAQHyy1HgSw5UF9k3gkLb9oQ9tgS?=
 =?us-ascii?Q?OttFG+bKXern8IaJmPawemmfzRdlDzglHCOeLaeBORuYx82wU0Fr3Kca2zHX?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa389952-fe03-4664-fb18-08dab26e7aea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 07:41:20.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjkK4E+i4oW2ZizlGEu2g9vQ3STUrfOLJgZsEtNalyi8jCpUqza+WEVOOTMTsI+J6Qk8nXUaPwFptniOar5LZqXGzTASfDPY2KSV3ReCgOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200044
X-Proofpoint-GUID: JLjrg-HfagR0h8n-pCtmtc40fTksNNtG
X-Proofpoint-ORIG-GUID: JLjrg-HfagR0h8n-pCtmtc40fTksNNtG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aae703b02f92bde9264366c545e87cec451de471
commit: 8aa5bcb61612060429223d1fbb7a1c30a579fc1f gpu: host1x: Add context device management code
config: arm-randconfig-m031-20221019
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/host1x/context.c:77 host1x_memory_context_list_init() warn: missing error code 'err'

vim +/err +77 drivers/gpu/host1x/context.c

8aa5bcb6161206 Mikko Perttunen 2022-06-27  16  int host1x_memory_context_list_init(struct host1x *host1x)
8aa5bcb6161206 Mikko Perttunen 2022-06-27  17  {
8aa5bcb6161206 Mikko Perttunen 2022-06-27  18  	struct host1x_memory_context_list *cdl = &host1x->context_list;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  19  	struct device_node *node = host1x->dev->of_node;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  20  	struct host1x_memory_context *ctx;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  21  	unsigned int i;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  22  	int err;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  23  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  24  	cdl->devs = NULL;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  25  	cdl->len = 0;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  26  	mutex_init(&cdl->lock);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  27  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  28  	err = of_property_count_u32_elems(node, "iommu-map");
8aa5bcb6161206 Mikko Perttunen 2022-06-27  29  	if (err < 0)
8aa5bcb6161206 Mikko Perttunen 2022-06-27  30  		return 0;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  31  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  32  	cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  33  	if (!cdl->devs)
8aa5bcb6161206 Mikko Perttunen 2022-06-27  34  		return -ENOMEM;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  35  	cdl->len = err / 4;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  36  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  37  	for (i = 0; i < cdl->len; i++) {
8aa5bcb6161206 Mikko Perttunen 2022-06-27  38  		struct iommu_fwspec *fwspec;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  39  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  40  		ctx = &cdl->devs[i];
8aa5bcb6161206 Mikko Perttunen 2022-06-27  41  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  42  		ctx->host = host1x;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  43  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  44  		device_initialize(&ctx->dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  45  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  46  		/*
8aa5bcb6161206 Mikko Perttunen 2022-06-27  47  		 * Due to an issue with T194 NVENC, only 38 bits can be used.
8aa5bcb6161206 Mikko Perttunen 2022-06-27  48  		 * Anyway, 256GiB of IOVA ought to be enough for anyone.
8aa5bcb6161206 Mikko Perttunen 2022-06-27  49  		 */
8aa5bcb6161206 Mikko Perttunen 2022-06-27  50  		ctx->dma_mask = DMA_BIT_MASK(38);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  51  		ctx->dev.dma_mask = &ctx->dma_mask;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  52  		ctx->dev.coherent_dma_mask = ctx->dma_mask;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  53  		dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  54  		ctx->dev.bus = &host1x_context_device_bus_type;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  55  		ctx->dev.parent = host1x->dev;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  56  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  57  		dma_set_max_seg_size(&ctx->dev, UINT_MAX);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  58  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  59  		err = device_add(&ctx->dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  60  		if (err) {
8aa5bcb6161206 Mikko Perttunen 2022-06-27  61  			dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  62  			goto del_devices;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  63  		}
8aa5bcb6161206 Mikko Perttunen 2022-06-27  64  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  65  		err = of_dma_configure_id(&ctx->dev, node, true, &i);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  66  		if (err) {
8aa5bcb6161206 Mikko Perttunen 2022-06-27  67  			dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
8aa5bcb6161206 Mikko Perttunen 2022-06-27  68  				i, err);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  69  			device_del(&ctx->dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  70  			goto del_devices;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  71  		}
8aa5bcb6161206 Mikko Perttunen 2022-06-27  72  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  73  		fwspec = dev_iommu_fwspec_get(&ctx->dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  74  		if (!fwspec || !device_iommu_mapped(&ctx->dev)) {
8aa5bcb6161206 Mikko Perttunen 2022-06-27  75  			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  76  			device_del(&ctx->dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27 @77  			goto del_devices;

Set error code here?

8aa5bcb6161206 Mikko Perttunen 2022-06-27  78  		}
8aa5bcb6161206 Mikko Perttunen 2022-06-27  79  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  80  		ctx->stream_id = fwspec->ids[0] & 0xffff;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  81  	}
8aa5bcb6161206 Mikko Perttunen 2022-06-27  82  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  83  	return 0;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  84  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  85  del_devices:
8aa5bcb6161206 Mikko Perttunen 2022-06-27  86  	while (i--)
8aa5bcb6161206 Mikko Perttunen 2022-06-27  87  		device_del(&cdl->devs[i].dev);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  88  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  89  	kfree(cdl->devs);
8aa5bcb6161206 Mikko Perttunen 2022-06-27  90  	cdl->len = 0;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  91  
8aa5bcb6161206 Mikko Perttunen 2022-06-27  92  	return err;
8aa5bcb6161206 Mikko Perttunen 2022-06-27  93  }

