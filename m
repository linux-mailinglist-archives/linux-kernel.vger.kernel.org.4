Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192060CEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiJYOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiJYOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:22:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6101F615D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:22:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PCqvmZ005861;
        Tue, 25 Oct 2022 14:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=pZq8h2G3EQKm5L9miCBEHCeWj4JbmOk5ukUO1E2Bhl0=;
 b=B76odUz9Pf1VRCKjpzLUjOCplhcLshzjTAqVlWgLd2W6UFEUzw0m0JmXMUUSjEt7Fw2A
 zAChLx1eYwzFWl9FYqyi400pKCWSp5OJPWXXKn7Q9ru/arzKMksW98FnS2LibIlDlC4G
 OxEMJ5V45F4+HOYLlR0bhnWYHcU6qG6QIxI3htHjlMstfn3mIaOqO8Rc9tTlthPURcBd
 ywwNwHVgkyF75Pb50q7vQC2BMwYHwzoiGaaWEh3nixxFt10AwPxqbG0P3kd1wn2Qs3Fv
 4udyprlgVYTh+v1JljiOuzJuxDBqgaxVuNsqRYzcp0MucH3Q06KSLNbsypnA1tibJX2a sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741v3cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 14:21:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PEH5OS039736;
        Tue, 25 Oct 2022 14:21:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yaq3qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 14:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBHmPwM8iFqsvD6H2THc2+ujf69T90UM0b0x0J8SkW4efrqLha5tNhG5fKpOCYtWI7ioQ69vfCqThIGWjqFXEB/yuneTB7qk4JDwg/GB3P4SCfiAVA8G6GOBjtcztvwF5ybe4nPo6pWiEVvnk3mlUJWraFqPqS2nK1M5PzhYf/LQXwOMFkGP4leUEb8SlBQAKZItCsqRxiakCvNJ7BbUbJqkDKIiBTcebvVKq8ol249VADP+PsJPIeQlM7EUl+69lSrmjD5hMxo0EhZz+IjHQZ35re/DDLzvrugS6Ca5jKORMpqbnM6MeoOJMNpcZeA275GDkEg2H+JMv8ZqpfFhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZq8h2G3EQKm5L9miCBEHCeWj4JbmOk5ukUO1E2Bhl0=;
 b=OLkdhg6mZtNxO/cByOdZa22Mzca/Ceyb9+9cYOOVK8wg5zw/4p9aBZKzf4v9UF705Vyl++D85deF5sBIEibx+/ItWw3o3uxZcWnBfhyUJmprkG6JgvWfofnz59V2rybis7sDUQIdNmEaXsDm5yTFj+dTX2vIye438MhNFAqjjyktMhcXJAVJNPQiRYGBPifp2VrAc6cEZAZRzY7LRRfsGn6ValapUIunjcwDi8H6xf3LgWd/0lFCaMLZxA52yiX6JbPSyM82AoJGx38evIYKGIV56jSeMQpk14flUc4lGrebuOfKbNHW4auyX3sK9q4B4ErydEC/iUbtJ6BI/82SMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZq8h2G3EQKm5L9miCBEHCeWj4JbmOk5ukUO1E2Bhl0=;
 b=bKEx54aIIiViAzxQbEpsK6Sj7z4OnL5WUhOIPdJGZos0OySM37u2MGxb80oGuqkAlFXRyfo/lKcuIhCN0T6qtr7ErGf/6UcnLwngDA+YAPcbJsFqCNj4Yz28yWtIFrfSC8qWBpmni/fgeYAWbOhTHZ/4yre/XFQNZXoLvDwU1lM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB6346.namprd10.prod.outlook.com
 (2603:10b6:303:1ec::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 14:21:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 14:21:47 +0000
Date:   Tue, 25 Oct 2022 17:21:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jason Gunthorpe <jgg@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_iommufd 9/11] drivers/vfio/vfio_main.c:1690
 vfio_file_enforced_coherent() warn: assigning (-95) to unsigned variable
 'ret'
Message-ID: <202210252103.10UKM7Mu-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW4PR10MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 61011d49-adce-4388-480a-08dab6944037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4d6blyN45a7L+jWUA22LwRxXMIl4tToXZO9KWmvGwRWpXAcDGoLqXuSnAqAZNUFy9LJukG3ngia/hDxXn34aP/hyTDemvP/awoPTBWhPBWL+WgLf8DUxSq6l7mkI4FUPekPWT0kiDw+l4TrRb1GvVWIeUZLxuCEWIFI7Y845NeQ/LxgpfXGJ2a1chGAGkNbFYEuWT0ZOmotOpwm2jJG2Q+dJfLKoU79Bf1mtKx/N9HP2iRrhjszNWyEyWMSQRt56SeJPXz3vZm1P8JjlrT/7n0+ZSoswySLVSEG0l+dPH+gPhxZAk+Scmp8g5gtzz0pPdAppznFVtAa+jAwg+zYlr+W7eEDCZnk2m15SJIT7SKO8iA+c+cyaemNIExsIY9z1QD23Enl5t59l5SkVdoDBRlJi+F9HAenUckR+oxbzy+ut87qlyIYEH/X0ws93tjADJ0KnKf3bbckfSbKwyXhYcyEEXxQoFAeHhh3/kJLYcH4g2T5zv+Wa1fGv78KOyqb3i29nyi9MR0xn3g4+De4q4QvUuRrGjBZ/9ZjR+QzUzMGpUTWbQ4rOd/0T4X/mLMm6PY3i4ZiMnt9lcVVNgOkVE/kDxR18AyWlD2zPVqZL4fwTuRp1A27cPCECDFoYLf7JuPy7p7RJ+4ZhSls4PVlJx3rtjOn1rACM/iwrThV8XR2spcEKiDHlssN+vwC6IXLGxeCw0eyDHFfBWkn4lMqiR/b+SqGrsoRdgitjoI56bcfhjn5pilQy9IU28fvjOOV8ZwK/dsdrdRm8S77UfKGXSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(6486002)(966005)(83380400001)(5660300002)(8936002)(316002)(6916009)(44832011)(36756003)(478600001)(8676002)(41300700001)(66556008)(66946007)(4326008)(66476007)(2906002)(1076003)(186003)(38100700002)(6506007)(26005)(6666004)(86362001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T7N1WTOAg7ErvhiZAvNDD+KWan3w8gbl9VNvlzdGf9i13b4lGRIkhUeoucS2?=
 =?us-ascii?Q?TEQdbXHREXeobGRVMYxDbuZERvggQWq06teGXXVHXGoDVZNIy/zPFB5SaLyv?=
 =?us-ascii?Q?lL3f6mNpbW9sAKJlbV9+kQ778Jbq9x06asdGY+eg/B1YKJKXmLC/fAayXta7?=
 =?us-ascii?Q?2i20UxjUPRCUO13iA/UZb1UhRhYSTBe3BbvTncE06wyBdIn1IF7apHjiEYGH?=
 =?us-ascii?Q?l5lzbODEfCOiAnAazbUR/F/98nuKt1TJiD/Lhbh5XA0LacFZFwOE4MHpLpmX?=
 =?us-ascii?Q?+uj9U6sXt+pG+35/KmgxBmmjbJ4pOAsCzzIMFtQoFSJ4Jm/H4d+z+SyPFTEP?=
 =?us-ascii?Q?L1fdApas+TPJv8yfwTlvZDlK2geBkZsv5Qf8UeF50xgAYlDQxFD3JvmzrqR5?=
 =?us-ascii?Q?eAgtpJBqiqHT+yDKRNuf8lGGylWmcxRkD++8hAj2kta5f8lM21RMmJJHokMh?=
 =?us-ascii?Q?6YyToOxovhTqytoKQV6evNzxDiKSKu3EJteCkuHcPsTk2ro3IntaKzP6TwUM?=
 =?us-ascii?Q?XRQGbfye5fX2ZguBWiwj1H8XULECHc48NtanBv/3/Uivu16pThSmYKEnfBpt?=
 =?us-ascii?Q?TTA/7k+3G2btqIoeA7BPZ0AC0i5XWtbtQ9GTUzL0dmTqt0KhkXYPUIHBRf9v?=
 =?us-ascii?Q?XwzHLsKrmxrX1IgLNh1bDKEFQ4Qpirf/TKBFLxku5gJsaP1HFb0WRn81BNrt?=
 =?us-ascii?Q?Fq0O0de51std19iJT3qVVfp2fdZwCDu8+gmfj7mh6Dty4M4iJkWbCSqchd+W?=
 =?us-ascii?Q?Ib2pxDN7emMxPejIJ1jsi0a/tjbLHo0xG8k6xl/ztG8d/RBW+WADsHnav21A?=
 =?us-ascii?Q?80JTKK/HoE1cqPPq/3dmL7Jq61kJipLAFiS/71P66EM76TlTqKxRL1ftd96o?=
 =?us-ascii?Q?utDDG7PWmIYhDl3kTlXiJWKmbsDsrqaOCPxCvGSrUJwR4F26lfEMiGyGWRqU?=
 =?us-ascii?Q?sgYvB1nsLuuVk/QX0mxK9CZvQER4hh1nja6lfDVD0QzLKNYYE8kEXZf6HHjt?=
 =?us-ascii?Q?o/nQSB2UpdsZVsdk5rabj4/vF23ecVZj7m5m24ctROBWXLsfRFKEKIv4Qn4N?=
 =?us-ascii?Q?pYQCmoDQh4NgjX8NsimZyn3UTr057c0wznHY08fsgfHHaMWOCnAklqidl0QE?=
 =?us-ascii?Q?dKlAl7gWfWldlv28bIjXUKnQ1EtworCeh7ETGNLoVvmZPAXyPirSnPaqxCyU?=
 =?us-ascii?Q?vEIn1EJN8TBLyI2yTMXemwjDmVB5KhgbdIVg3MxnjDHNjS8Ys/R+jdYfPxlW?=
 =?us-ascii?Q?40RJ8uJFG1/nsbl0lBuS+YBDPDtWYHqK/jK/s9xZjG8yXQq/Et7JMuK4TInZ?=
 =?us-ascii?Q?R6GOehTZ6/OX1AjZf+ggYiRmfbP88yIIV9FEZA403gSfU1rCkit6UcMUV3SK?=
 =?us-ascii?Q?ZQpbgjE14L4KnlqThkJZxN5ZaKfrYisYW5vYlS8YJJkPONfErDXihhxZcKU1?=
 =?us-ascii?Q?KiggiQFpKbnJhX1i9yxOkLvvmzIzwTA+ArT4mU8vgJPpYZHvNtCajmz18t0d?=
 =?us-ascii?Q?j4/JVfrHacwM8wpLPgVi7WnKiZawlVG6ZqmxmOz0YmGEayzVhcDvHrzFuHcB?=
 =?us-ascii?Q?WT6Ip+J9H0M6FpLgauoPsjdhkYXlYZvvSRkGkGJJ89W/RmgQT7zIDR2OmALh?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61011d49-adce-4388-480a-08dab6944037
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:21:47.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD6SA/DyF8sDa3T632ZtnqCxmPuFyb8zfndadeLLb43zBzyM1h0qVcdl4QJz/Zm8raoGbQzvEe0U8ZnL6DgwWFawUvJDBCFKNsNx2QlBKvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_06,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250082
X-Proofpoint-GUID: d4kcFTmCkvVe58y0A5MdWzJ76HcDOdIn
X-Proofpoint-ORIG-GUID: d4kcFTmCkvVe58y0A5MdWzJ76HcDOdIn
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_iommufd
head:   a249441ba6fd9d658f4a1b568453e3a742d12686
commit: e44299750e287f3d64d207a5af7abb021634a31b [9/11] vfio: Make vfio_container optionally compiled
config: openrisc-randconfig-m041-20221024
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/vfio/vfio_main.c:1690 vfio_file_enforced_coherent() warn: assigning (-95) to unsigned variable 'ret'

Old smatch warnings:
drivers/vfio/vfio_main.c:1907 vfio_pin_pages() warn: impossible condition '(iova > (~0)) => (0-u32max > u32max)'
drivers/vfio/vfio_main.c:1974 vfio_dma_rw() warn: impossible condition '(iova > (~0)) => (0-u32max > u32max)'

vim +/ret +1690 drivers/vfio/vfio_main.c

a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1671  /**
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1672   * vfio_file_enforced_coherent - True if the DMA associated with the VFIO file
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1673   *        is always CPU cache coherent

This comment sort of feels like returning false on error is the correct
thing but in the rest of the code it seems like returning true on error
is correct.

a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1674   * @file: VFIO group file
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1675   *
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1676   * Enforced coherency means that the IOMMU ignores things like the PCIe no-snoop
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1677   * bit in DMA transactions. A return of false indicates that the user has
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1678   * rights to access additional instructions such as wbinvd on x86.
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1679   */
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1680  bool vfio_file_enforced_coherent(struct file *file)
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1681  {
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1682  	struct vfio_group *group = file->private_data;
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1683  	bool ret;
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1684  
b1b8132a651cf6 drivers/vfio/vfio_main.c Alex Williamson 2022-10-07  1685  	if (!vfio_file_is_group(file))
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1686  		return true;
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1687  
c82e81ab256955 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-09-29  1688  	mutex_lock(&group->group_lock);
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1689  	if (group->container) {
1408640d578887 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-09-22 @1690  		ret = vfio_container_ioctl_check_extension(group->container,
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1691  							   VFIO_DMA_CC_IOMMU);

But this returns true if vfio_container_ioctl_check_extension() returns
a negative error code.  (I haven't looked at the git branch and I
suspect it's different from linux-next)

14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1692  	} else if (group->iommufd) {
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1693  		struct vfio_device *device;
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1694  
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1695  		/*
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1696  		 * FIXME this is in the wrong order for KVM, the KVM will be set
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1697  		 * after the group is opened and container set, but before the
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1698  		 * device fds are created, so it will not see the iommufd bind
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1699  		 * at this point.
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1700  		 */
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1701  		mutex_lock(&group->device_lock);
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1702  		ret = true;
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1703  		list_for_each_entry(device, &group->device_list, group_next) {
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1704  			if (!vfio_device_try_get_registration(device))
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1705  				continue;
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1706  			ret &= vfio_iommufd_enforced_coherent(device);
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1707  			vfio_device_put_registration(device);
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1708  		}
14b6d451b4bcfb drivers/vfio/vfio_main.c Jason Gunthorpe 2022-08-08  1709  		mutex_unlock(&group->device_lock);
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1710  	} else {
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1711  		/*
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1712  		 * Since the coherency state is determined only once a container
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1713  		 * is attached the user must do so before they can prove they
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1714  		 * have permission.
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1715  		 */
e0e29bdb594adf drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-16  1716  		ret = true;
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1717  	}
c82e81ab256955 drivers/vfio/vfio_main.c Jason Gunthorpe 2022-09-29  1718  	mutex_unlock(&group->group_lock);
a905ad043f32bb drivers/vfio/vfio.c      Jason Gunthorpe 2022-05-04  1719  	return ret;
c0560f51cf7747 drivers/vfio/vfio.c      Yan Zhao        2020-03-24  1720  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
