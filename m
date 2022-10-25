Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D960C4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiJYHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJYHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:06:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D407E836
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:06:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P1M4cj010282;
        Tue, 25 Oct 2022 07:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=lTTP+A/sd07NbRXubpOpVBmXTMfkKe+ALIQO8ashYK0=;
 b=v1mNJDcjexxm1hOcQF+IlNta4yLMvo0tvxrqKjx4SvCipgOLKxW1Xr12lWsL5UzI/Lac
 dwoUP/Tl/QWOYNq+VHOD/1Qb5XMyLUiIM2lHi7MeDM+LWrEGzHj6VbLZDqRSsbUp3KoY
 xYfqfynBgx6DBy8lmEvdqOVMiS8UMr05PI3EpWa9irGtjmt0tdONMPrHi4kmloPbgyAp
 C4ojXgNttjEESPRM2dxug0Gwv5G8HxEH3lupOSjez/R2HAFRNkaMA3M992PXKfWJDNM4
 +Cd59BMPpm3Er0+GZYfQm9gWeXnE1Bs1m2EjmpXL3cMOeG+2gcC4gbwmaFc4RGtYOZNi Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a314e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 07:06:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P4pb4A012751;
        Tue, 25 Oct 2022 07:06:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4bvh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 07:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fekVvKiM/0hnXbHggLgnMk+rfwGvetG0oIwCRT7reKBr+RzG3cusAYwkqaUK/WsKvd+Kageb80/Zr4F7DFuUsl4k1U0O6yz2K07sUwSaLdk5o37UrZwgV65/uokjKZ60FNE1xx+D0GdzGPzAonfi9MT++hpztPm35vZkjdlTdS0/A/u3OJWQUNPLXGxO+VJSUWXh6Crvj3RIabaPRbaq4Eh1OeBEwOczt2+RnNP/NKr04wDQpRglkiJZfGsP6eV5ZTdi2TnAH2moSe10v95pqD0T6DYxPzXR5SNqaE1n1WkXNEvyHEYsoGzd+24EcUjRvkaOt7AsoMt3qvze2Hu6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34ZyedlqDeyANVXa/MIsUNnjdWR27pQYxW3vJr3HFWE=;
 b=K0/tJxqumqNTMEkPsak3+knY7XUupn7JNuLiaN0zhSNoQFaOI+yIuzDFkpZK4Mc7nWxQPFVWXFrCAUmAQg+SZBD+4uPtaNpcDyBOlI3Af7MAz4MkA27UoFNrAJwm+mIOoW0dfnSxcvvu+Z/5T4xKth+tcRB9eh0e/h9YlbhkqPVjZe+K61e2SyuusD37p0p/G58pfaw1evKoASZg7P20Hedpik9Ndqb1sCe63WmdieRwCWuHeNs2kGv8+k7neLRbBe8o3iYtdv3iDmvkatBaIwpO0RG8WJ4F6L7pf5j0TNsUYu+pJYEFODGtMtuXl1jKpeh97347NIy/yhbS8WiV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34ZyedlqDeyANVXa/MIsUNnjdWR27pQYxW3vJr3HFWE=;
 b=cKQCOF5Rt9pr3ZgN9LnAoj6loXdCHn6qN8XrdEzi+UbWeYmMzvkEw4bI7pXuQ2e8bxwgonI/QmaqNyOBvjzBfBCvu3y/kqNXpbo6xg7CTZQ6b5AktXctSf4pxa0VfDvJehwIiWAoVP4uoQvSwZ9iqt4OSurcKcbpLDuvytLyX5Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5855.namprd10.prod.outlook.com
 (2603:10b6:510:13f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 07:06:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 07:06:02 +0000
Date:   Tue, 25 Oct 2022 10:05:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Roman Li <Roman.Li@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2730
 dm_resume() error: we previously assumed 'aconnector->dc_link' could be null
 (see line 2717)
Message-ID: <202210250926.2aGq89g8-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c97f32e-6a4a-4942-6aee-08dab6576000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC598wLG2a397xev2i+PC8ma2Ecp/zt5ygvg1MU0tRPQoJ9ExocDvkwcyeL+QvbZI3AsPw1w8h6n6Xc7acOQPYaBYdvdjk2Hu07WctUShATvARoZ7M/iVwU816+fSc+ldglz9tl4HBv91vU5PQfAzD66X43NbmDu+UkbRz88dnMu3w33VgjI5kw2J0PosQ8kdktqNCkkQH2nkjDyfzma4hZ2zJsGXq3rPL4WKLN4H+cOGvNriQXHr8WxB2JstcyfCkSLGzbd5h1wvcYGf9q7Jrq0hOSVZRRGGT9zyakgLoVqZqN43ZSvJZaluOICqRDcFwrwWzgourFbI0cKFb1wa1GbAB9tULB+rcHFvSButR2LEjq42XGvh/Khq+tBQqNU0fIYFc3KPdGanZdfI9xWb0HiCj57gabz0Lv5xz2uH1SeTKs8Rhy8DgdMajzvlpRGXm4wcSbvHhdVo6OiXLvuVVRc+7EkWO72k3BEYYQPGgK+cOP2tt0yIIS5s44wbB5pJOtnwjEUivyiK7lP0KomZ4L4OLFnYsIHZMEDQJsKuUyNZ5jbl5RC2NzmpEoyXWv4rHcAADfYBAJhjqlHsGBbtsixCzjsu7iPOxe+pfcaXAhdNt2AK/JuETNP0FbzoZw+g14FuHaBaH6fiw9KqDPJJ2+jNGApQak9944+CFd4hUeNyvy5mIK5Mrq/kn8/eX5C0zEEG7TCRTYiDbi3Tuu4jy70TXNf6n/FsPOYWLy01YfqKZcNz8SeOJb5Y2LGSDV8LuMUz38fLNiCiH2RQrR4tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(44832011)(30864003)(38100700002)(83380400001)(6512007)(1076003)(5660300002)(316002)(66946007)(66476007)(6486002)(66556008)(66574015)(26005)(478600001)(966005)(8936002)(9686003)(36756003)(54906003)(8676002)(86362001)(6506007)(6916009)(41300700001)(2906002)(4001150100001)(4326008)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/Wh7AWIZqC832LKS/6qi3hBT94R+NazGbUhBrHbZlPHqVRyS8GT93D0cNd?=
 =?iso-8859-1?Q?pULwMPDArKfrmhPSfOlKCjrC3gaJ2/ttN09Z9oD2ULqAi5bg7SJVcMZeMK?=
 =?iso-8859-1?Q?xbcX5QLrQr6yFKhSkWtem3sAjPwIVWqJ4mXyMC4dHjvH/rIeGecY8jnIiZ?=
 =?iso-8859-1?Q?5g2BLTDbAfJuJIkLLFMVEvV3JFZMxB7fElPZs6ezrd7Blu8KHhN3Ux6lnD?=
 =?iso-8859-1?Q?dpN3a43hUVsTiBhKyWXRMVZQIPzo2wUFmW/4asuy4gL0P0INjgdiQA61+D?=
 =?iso-8859-1?Q?HWm9VublmQV3itIWBcW8npl/dS5MdJJaxb8nIqzaUq6r54bFVZXRxsTVyr?=
 =?iso-8859-1?Q?2NREyPDTcpr0gxI69DeCCIdk9FeSNS+4Uva3hLKKKFs32aPHmqFDf2WW29?=
 =?iso-8859-1?Q?Gg1cUGWe0rbAC69dpR2ofX9ybxm44J1uGW3dsejio4DFmw/ZFjkEy3aZtx?=
 =?iso-8859-1?Q?e1qICdY/yT1xQfMRLcuuWSAH0zCMq/4xMAEfFOcQIdC0hke9ND5ia3qA1t?=
 =?iso-8859-1?Q?JHo2zKKH8YPsNXqyv78ZRd2Uyx2JQHzhU9vbcB3mzGhlYxRlEVWQ4tZFs5?=
 =?iso-8859-1?Q?zMQNnWSoig++69pfkMIPbWZeXsa3hVkTkhdo2APBF2yznK/v2eNl/rvkC3?=
 =?iso-8859-1?Q?UAPUFPpl3wZPjEMn4FmzD/V+QpIgE2hn3xZb9U02g5WfsYqdQWyQEI6LVu?=
 =?iso-8859-1?Q?UPtycpqyAsvSvCbiGc6FKL+bRwyyivjiGRAKCsp3jaKNJVnvCwtUO9INHI?=
 =?iso-8859-1?Q?16fvvZIMynnRkmlpGRGKandotVGu5ZwmBH/uu9FE9EJm5fbzB+Qld7QNpy?=
 =?iso-8859-1?Q?mtzZaopXxrhIqN1szbL/kQ350U9BL0Ud8ANkJEl8gJgcT4lkv3gPV1wsmu?=
 =?iso-8859-1?Q?4PQq08ffQpyY4tSW/RSWboaZc2e/kOplc7pb8MGvEJySr4A+dgCCwE87Yu?=
 =?iso-8859-1?Q?iVDEUOddOjKjGPVKhjmco354NRZ+nyLWv63EKAQv8C5bUwA2dkHBBO7t6O?=
 =?iso-8859-1?Q?VCL067RvfcCTsrtgLotZC9n9EULRAsS1I9dJaCO65beGJqltY6D99jhjBo?=
 =?iso-8859-1?Q?Yb7s2+XXLbB2p5uxFsjOJ/HgmCSszaLo2oaDfs7XNcuHT58SPQSN9rb29F?=
 =?iso-8859-1?Q?AeJu9Itm0TbOHXNGMuBs2TlHOX7tGjfHpL0qVs3+6WMO9y1fcEP3soClv0?=
 =?iso-8859-1?Q?Ytmt/hp3w1jcaALdiTTzS+h4cBK+iyLSL2fWUZxe9Asab+DH18c4jiVdr9?=
 =?iso-8859-1?Q?UB2lg4dkVGyQm8faXQwmcVYxLrcVDrEnMRgJw5EWkaoMut68Tef++PYPWU?=
 =?iso-8859-1?Q?iEDs/Pp6C3eW7zNj7rHRoScatTAhaXphY4Fdc6X2Z8joE9+PGSDYC5kDmV?=
 =?iso-8859-1?Q?seECLeA3blc30qRhfdXodx7a8qq9NHi+XwEqVBwQjz4NRL8DtQHdVah/6d?=
 =?iso-8859-1?Q?B/n1xT7oxahhZQlQ8YvDB0dg2WHsnk/oJdf3x1PA2E8aykeAahhwcf/uSG?=
 =?iso-8859-1?Q?C/OjALww37BnVLU2ZTM/YeHTePbrGX6Kwaqzle+779YN3ZRYoV2R7Kd/Gs?=
 =?iso-8859-1?Q?LCk90yRx2xFL9DPxWDHo9cT7ZaHa1ghlov75EEROoMSVOamxWfR4JsgDk8?=
 =?iso-8859-1?Q?8aV3Jyfxb/NAwVMG//2nU1ZCAEa079fpnY7lpyZM/JTDqswLbW+zaQ2Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c97f32e-6a4a-4942-6aee-08dab6576000
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:06:02.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mslx3p1ubuijC4+e/fsHzkKH0NUXZnAXyiWr1arWuvpUgu4PFBv4Fp2LE42gXgodMRNSLxU4oO1jPDeoFFuW1XmNvnMdwqoMa3s8IUuSsKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250040
X-Proofpoint-GUID: B8-UwvuwH9y9ZJtmfmnzUNFqz3DX6jly
X-Proofpoint-ORIG-GUID: B8-UwvuwH9y9ZJtmfmnzUNFqz3DX6jly
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   337a0a0b63f1c30195733eaacf39e4310a592a68
commit: f4346fb3edf7720db3f7f5e1cab1f667cd024280 drm/amd/display: Fix allocate_mst_payload assert on resume
config: mips-randconfig-m031-20221018
compiler: mips64el-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2730 dm_resume() error: we previously assumed 'aconnector->dc_link' could be null (see line 2717)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1747 amdgpu_dm_fini() warn: variable dereferenced before check 'adev->dm.dc' (see line 1720)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4019 amdgpu_dm_backlight_update_status() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4061 amdgpu_dm_backlight_get_brightness() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6530 create_stream_for_sink() error: we previously assumed 'aconnector->dc_sink' could be null (see line 6429)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8918 handle_cursor_update() error: we previously assumed 'afb' could be null (see line 8877)

vim +2730 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

4562236b3bc0a2 Harry Wentland      2017-09-12  2606  static int dm_resume(void *handle)
4562236b3bc0a2 Harry Wentland      2017-09-12  2607  {
4562236b3bc0a2 Harry Wentland      2017-09-12  2608  	struct amdgpu_device *adev = handle;
4a580877bdcb83 Luben Tuikov        2020-08-24  2609  	struct drm_device *ddev = adev_to_drm(adev);
4562236b3bc0a2 Harry Wentland      2017-09-12  2610  	struct amdgpu_display_manager *dm = &adev->dm;
c84dec2fe8837f Harry Wentland      2017-09-05  2611  	struct amdgpu_dm_connector *aconnector;
4562236b3bc0a2 Harry Wentland      2017-09-12  2612  	struct drm_connector *connector;
f8d2d39eb40694 Lyude Paul          2019-09-03  2613  	struct drm_connector_list_iter iter;
4562236b3bc0a2 Harry Wentland      2017-09-12  2614  	struct drm_crtc *crtc;
c2cea7063b85fc Leo (Sunpeng  Li    2017-10-12  2615) 	struct drm_crtc_state *new_crtc_state;
fcb4019e090b95 Leo (Sunpeng  Li    2017-11-01  2616) 	struct dm_crtc_state *dm_new_crtc_state;
fcb4019e090b95 Leo (Sunpeng  Li    2017-11-01  2617) 	struct drm_plane *plane;
fcb4019e090b95 Leo (Sunpeng  Li    2017-11-01  2618) 	struct drm_plane_state *new_plane_state;
fcb4019e090b95 Leo (Sunpeng  Li    2017-11-01  2619) 	struct dm_plane_state *dm_new_plane_state;
113b7a01087211 Leo Li              2019-03-19  2620  	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2621  	enum dc_connection_type new_connection_type = dc_connection_none;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2622  	struct dc_state *dc_state;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2623  	int i, r, j;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2624  
53b3f8f40e6cff Dennis Li           2020-08-19  2625  	if (amdgpu_in_reset(adev)) {
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2626  		dc_state = dm->cached_dc_state;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2627  
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2628  		/*
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2629  		 * The dc->current_state is backed up into dm->cached_dc_state
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2630  		 * before we commit 0 streams.
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2631  		 *
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2632  		 * DC will clear link encoder assignments on the real state
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2633  		 * but the changes won't propagate over to the copy we made
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2634  		 * before the 0 streams commit.
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2635  		 *
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2636  		 * DC expects that link encoder assignments are *not* valid
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2637  		 * when committing a state, so as a workaround we can copy
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2638  		 * off of the current state.
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2639  		 *
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2640  		 * We lose the previous assignments, but we had already
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2641  		 * commit 0 streams anyway.
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2642  		 */
32685b32d825ca Nicholas Kazlauskas 2022-02-28  2643  		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
6d63fcc2a334f7 Nicholas Kazlauskas 2021-11-09  2644  
af6902ec415655 Nicholas Kazlauskas 2021-11-23  2645  		if (dc_enable_dmub_notifications(adev->dm.dc))
524a0ba6fab955 Nicholas Kazlauskas 2021-11-08  2646  			amdgpu_dm_outbox_init(adev);
524a0ba6fab955 Nicholas Kazlauskas 2021-11-08  2647  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2648  		r = dm_dmub_hw_init(adev);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2649  		if (r)
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2650  			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2651  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2652  		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2653  		dc_resume(dm->dc);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2654  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2655  		amdgpu_dm_irq_resume_early(adev);
4562236b3bc0a2 Harry Wentland      2017-09-12  2656  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2657  		for (i = 0; i < dc_state->stream_count; i++) {
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2658  			dc_state->streams[i]->mode_changed = true;
6984fa418b8efd Nicholas Kazlauskas 2021-11-09  2659  			for (j = 0; j < dc_state->stream_status[i].plane_count; j++) {
6984fa418b8efd Nicholas Kazlauskas 2021-11-09  2660  				dc_state->stream_status[i].plane_states[j]->update_flags.raw
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2661  					= 0xffffffff;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2662  			}
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2663  		}
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2664  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2665  		WARN_ON(!dc_commit_state(dm->dc, dc_state));
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2666  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2667  		dm_gpureset_commit_state(dm->cached_dc_state, dm);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2668  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2669  		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2670  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2671  		dc_release_state(dm->cached_dc_state);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2672  		dm->cached_dc_state = NULL;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2673  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2674  		amdgpu_dm_irq_resume_late(adev);
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2675  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2676  		mutex_unlock(&dm->dc_lock);
4562236b3bc0a2 Harry Wentland      2017-09-12  2677  
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2678  		return 0;
cdaae8371aa9d4 Bhawanpreet Lakha   2020-05-11  2679  	}
113b7a01087211 Leo Li              2019-03-19  2680  	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
113b7a01087211 Leo Li              2019-03-19  2681  	dc_release_state(dm_state->context);
113b7a01087211 Leo Li              2019-03-19  2682  	dm_state->context = dc_create_state(dm->dc);
113b7a01087211 Leo Li              2019-03-19  2683  	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
113b7a01087211 Leo Li              2019-03-19  2684  	dc_resource_state_construct(dm->dc, dm_state->context);
113b7a01087211 Leo Li              2019-03-19  2685  
af6902ec415655 Nicholas Kazlauskas 2021-11-23  2686  	/* Re-enable outbox interrupts for DPIA. */
af6902ec415655 Nicholas Kazlauskas 2021-11-23  2687  	if (dc_enable_dmub_notifications(adev->dm.dc))
af6902ec415655 Nicholas Kazlauskas 2021-11-23  2688  		amdgpu_dm_outbox_init(adev);
af6902ec415655 Nicholas Kazlauskas 2021-11-23  2689  
8c7aea404d55da Nicholas Kazlauskas 2019-11-25  2690  	/* Before powering on DC we need to re-initialize DMUB. */
79d6b9351f086e Nicholas Kazlauskas 2021-12-15  2691  	dm_dmub_hw_resume(adev);
8c7aea404d55da Nicholas Kazlauskas 2019-11-25  2692  
a80aa93de1a0e6 Mikita Lipski       2018-02-03  2693  	/* power on hardware */
a80aa93de1a0e6 Mikita Lipski       2018-02-03  2694  	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
a80aa93de1a0e6 Mikita Lipski       2018-02-03  2695  
4562236b3bc0a2 Harry Wentland      2017-09-12  2696  	/* program HPD filter */
4562236b3bc0a2 Harry Wentland      2017-09-12  2697  	dc_resume(dm->dc);
4562236b3bc0a2 Harry Wentland      2017-09-12  2698  
4562236b3bc0a2 Harry Wentland      2017-09-12  2699  	/*
4562236b3bc0a2 Harry Wentland      2017-09-12  2700  	 * early enable HPD Rx IRQ, should be done before set mode as short
4562236b3bc0a2 Harry Wentland      2017-09-12  2701  	 * pulse interrupts are used for MST
4562236b3bc0a2 Harry Wentland      2017-09-12  2702  	 */
4562236b3bc0a2 Harry Wentland      2017-09-12  2703  	amdgpu_dm_irq_resume_early(adev);
4562236b3bc0a2 Harry Wentland      2017-09-12  2704  
684cd480fd4e6d Lyude Paul          2019-09-25  2705  	/* On resume we need to rewrite the MSTM control bits to enable MST*/
684cd480fd4e6d Lyude Paul          2019-09-25  2706  	s3_handle_mst(ddev, false);
684cd480fd4e6d Lyude Paul          2019-09-25  2707  
4562236b3bc0a2 Harry Wentland      2017-09-12  2708  	/* Do detection*/
f8d2d39eb40694 Lyude Paul          2019-09-03  2709  	drm_connector_list_iter_begin(ddev, &iter);
f8d2d39eb40694 Lyude Paul          2019-09-03  2710  	drm_for_each_connector_iter(connector, &iter) {
c84dec2fe8837f Harry Wentland      2017-09-05  2711  		aconnector = to_amdgpu_dm_connector(connector);
4562236b3bc0a2 Harry Wentland      2017-09-12  2712  
4562236b3bc0a2 Harry Wentland      2017-09-12  2713  		/*
4562236b3bc0a2 Harry Wentland      2017-09-12  2714  		 * this is the case when traversing through already created
4562236b3bc0a2 Harry Wentland      2017-09-12  2715  		 * MST connectors, should be skipped
4562236b3bc0a2 Harry Wentland      2017-09-12  2716  		 */
f4346fb3edf772 Roman Li            2022-03-17 @2717  		if (aconnector->dc_link &&
                                                                    ^^^^^^^^^^^^^^^^^^^
Probably this check can be deleted...

f4346fb3edf772 Roman Li            2022-03-17  2718  		    aconnector->dc_link->type == dc_connection_mst_branch)
4562236b3bc0a2 Harry Wentland      2017-09-12  2719  			continue;
4562236b3bc0a2 Harry Wentland      2017-09-12  2720  
03ea364c8e156b Arindam Nath        2017-04-26  2721  		mutex_lock(&aconnector->hpd_lock);
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2722  		if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2723  			DRM_ERROR("KMS: Failed to detect connector\n");
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2724  
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2725  		if (aconnector->base.force && new_connection_type == dc_connection_none)
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2726  			emulated_link_detect(aconnector->dc_link);
fbbdadf2faf17c Bhawanpreet Lakha   2018-09-26  2727  		else
8f38b66c826188 Hersen Wu           2017-09-11  2728  			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
3eb4eba42263cc Roman Li            2017-10-20  2729  
3eb4eba42263cc Roman Li            2017-10-20 @2730  		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
                                                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The other code does not bother to check.

3eb4eba42263cc Roman Li            2017-10-20  2731  			aconnector->fake_enable = false;
3eb4eba42263cc Roman Li            2017-10-20  2732  
dcd5fb82ffb484 Mathias Fröhlich    2019-02-10  2733  		if (aconnector->dc_sink)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

