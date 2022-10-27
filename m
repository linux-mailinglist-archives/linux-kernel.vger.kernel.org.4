Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF560F133
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiJ0Hga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiJ0Hg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:36:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4FC76A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:36:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R2QrQ7031701;
        Thu, 27 Oct 2022 07:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=iA34CPVfm9tXXrFJxDIPwSFe3qo7gf8EcTTer/nlaTQ=;
 b=tnuuquAOa7RXTGR6SKRgQfg5VdwOh4e87/XmHzNl6J9mL/27+tAeJr7G6aNUkwaDyWpR
 kSt4iQpoxvlHCllikYxJ7ocPUAA8N0S4M/eBEncaGMmClOGOJM7JAPbK44mKy0iJ4eXC
 cyEiGTv65IvpZsb8Ux3Lei6mFJdw0Z/M8sfZOfcZ1+zNevtp5OMIy0HIxcJIrfj3iFGQ
 vQc1+rjFNAyWWOUNPEG019kyWUmeDPQkjp9uJiyCiycn/3f8cQsdaSxA2v7CZitU9vjZ
 AKb4f7MFER90uMy2GaQFidzq4UOmjWA3eQq/ZHg9ullRVgq9xl80CVLgPG7F1/0fyHdm RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv18kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:36:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R6FiMB011595;
        Thu, 27 Oct 2022 07:36:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqpw1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S75joto9Ua33G13KFPVbgzj8L3owWJ7fNcLP8OjkPqUj9JiERuy7at1Oex13/DS84Gg3Wdxoj0uKsPEZJv1keWK5y32b/+dOyARDRAVZ1eqyt+XB7QmZ8jqpXPyGSryvij7c4PuyFDvmU91GKURLdR8/Hmm8No/Kam2AzHnhdsYgjyFIp+Y/uPREIHRs3uU4zzlbyAItCTi5FevGu+JLOnT/24LLbTylVyyfZGxbE78qR9bJfaKr0+S6bsMJ8XXA4lAFzJlPJz9Ntpiz4sTsFwFbsH7f45orQlLJDSoGV6kD268T7SmkosnRtPEYjZD9xOO4upBfsFXj7dgHEJkeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA34CPVfm9tXXrFJxDIPwSFe3qo7gf8EcTTer/nlaTQ=;
 b=XvSnmUTOmm8CCjOM5j5pu8+ApI7HNqiZwWbLjTY0JWoC0PIj9sAQlO4XyF5LE5yKdMnHkIviKx/seWEF7gFoogy0vmQEFkKqLy4iK3eN2vZ+IK4pgeP4zWPo7G0LD7+VO9qBHObMvk/BDNsstYU8WtonHAbVMUtpiM3sHS5f9guNYgAl7rop3pjtaJ5RnwKvBrltbCadBd8XXW7yLS5M5lqn9KWjXJOJ7OYhElle4lk7PURhuWiJiX7RIvBFC0FuiTiGTTHnJOd/8X9SrHdjzHAyFQeY77keYFELxr+dtXwaYmEhrM0ayk/KJBn0nQrLi+A5E1lHwjOiN+JheIVPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA34CPVfm9tXXrFJxDIPwSFe3qo7gf8EcTTer/nlaTQ=;
 b=CZyZdxCVQBl4z4IbaRKKoD6LbW9MtdJOVV9fXgJlNRu6tCGSLumIu4TPLozLYww361icC5qP38VL5jMOv2BNF4eYmGW3pMeUHK1SqW27OUZ/PE7iydYmkJ2879scQR9LDTJ0/oQlXfjmypcQN61giuk5MvIEf2AYzsTd2js7vfg=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by IA1PR10MB6686.namprd10.prod.outlook.com
 (2603:10b6:208:41a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 27 Oct
 2022 07:36:16 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:36:16 +0000
Date:   Thu, 27 Oct 2022 10:36:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alvin Lee <Alvin.Lee2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Samson Tam <Samson.Tam@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:395
 dc_stream_set_cursor_position() warn: variable dereferenced before check
 'stream' (see line 392)
Message-ID: <202210260950.kMcetJwT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|IA1PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: a20642cf-926a-492c-9425-08dab7edee7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJjw8ESVTMRVDp+B4LFarMLP4I13idin9CZgUMsByB9SQZvC1pxEMGT5Jd0yEiOVX/pVlRCZCEWWqIFTf4ypTlm7c51g/VRrZNgise73JTatkfG1crvK61ZVoMHl0ro2mXTsEr5EHqpaA9w8SE8rEMRDVDQn7zusI6G6gKiwvurmRAOxWa5VOM7Tb+eddx1sA5IjT9+CCIs9ZS2gI8j+qLRhg/ucnQ+7O3qC4ZRRmZl598ngiqeRKqVQItheoRrjmGEG6TebZZdJflRRVFTXDxXXnU1Beua3+M7CKow0eiI8CK7W5/PiZ+aGSA2CxqExd+3nWnzv1pGEs0cGbA6V+BJMMKn+NTIMC8m57HcXflYxrz3kM1cTZ6wF5YlyiUd6sMc3ROsn/8RRMxV947YXyN0PpFhaiCGv/T9lh7cj42waVkCTB5yC+LVzMdm9wrfF3/z6Un8dBDTN9Z2SDtrNVQnqHrc9U6Dm6fj3Rp40SJoQYtnlmRVK0czilNpoz/A3tz4VrUY/XNqthycNkaHz6lGkMeJinXdK1kV3u1soQRvmhURcndzIA+VGmJm4v8uN8kBcKO8mHTXDCVJ4P7efKnRuvpyytm7V7sR8dlil0HKvWl2cKqG7uDD/Wc84rpOlEjyQIwpcGzlNd9xGx0B/TJO0LKJr3VWEbpz1VC47pn6aC8LcXkPK7M+LULICvSUY4V8w5XWCt6VatEkmhfZUO8Ozmmrj9JtvVyV7vuHdZIDxj5blvIrOT8epw4O597zdlg/hxoFQe8JpJ3tNwhEyjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(66946007)(41300700001)(6916009)(8676002)(54906003)(66476007)(38100700002)(4326008)(4001150100001)(6666004)(6506007)(5660300002)(316002)(9686003)(478600001)(6486002)(1076003)(26005)(66556008)(6512007)(83380400001)(44832011)(186003)(8936002)(86362001)(966005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63tdbpyZ7COyCc7K6T6BnlKML/W0TbRdnTh9bFZSNNrP7Qmo2whoGbdNCFgN?=
 =?us-ascii?Q?zH8fY+dJ5D4IKnwDbWL0V6Q7iQixgnteo7S5tIi4SE1DU5qj2lQn1H5Q1keD?=
 =?us-ascii?Q?JfIz1ukfl8d5Hh+2Xym+vcwdSTT6o8ezHCIHwRy/QiqbV1RkJr+V1AmvKphv?=
 =?us-ascii?Q?iQy7SiLRgjSRrsD0Ii9LDQkSV306pyRfJhuU8G6799HXdfQWWlI+SmK34F7Y?=
 =?us-ascii?Q?5WXOA8/JUuy/BaXNIxVkfkdAiYv/BA7rLfb3UWeDmuPTjPRr4Xt/2O6qzdPy?=
 =?us-ascii?Q?ww1vPobshVVolpVPfU5SfWw1zIVwtYQ1jX8Q5u8T4utu86b/lRfVGKe/1kzJ?=
 =?us-ascii?Q?C/0xO1fklrROM1P8og4s/LOyAkbGgZDognuM5bEUekE7cGQ+yBy3CajUQYJh?=
 =?us-ascii?Q?Z2y6vVS1zfE5uhbFtbrBad71kMkIy9VLRcFGaxNHWy86Z8uHvUhZOCTR5uQa?=
 =?us-ascii?Q?SAteJyhIyrZdLpH1VWUolncsDNkl0D1+qcs4GKcVKEqCJXrQ6kpWJGfJ3Y3z?=
 =?us-ascii?Q?aSI8EUUxtQQBbRgVK56+CBS1csrO4nySl2GwYUGjBukhy/xSSck8rdKiQD8Z?=
 =?us-ascii?Q?C02QQRrDiCy6/iB4SwiZk+A0DoceNJAwqe8rjTkvprb8oBNXWsYtzK9DCqec?=
 =?us-ascii?Q?+iBgYS11ekNghUimmC6+YVjsQN4kd9TIhAbtq6SPi8tbkZgs0qTS40JnJGTS?=
 =?us-ascii?Q?f55P+T6JTJXinhKulfZMkk8Y/79mbTFPddTVhwE87uVGvszkXrnRbI/5aScP?=
 =?us-ascii?Q?s7Fpjp3pPjqDYf9aEYaSO0W5nDmoSyraCj4/oeRxsCan/dg18mtnjo223BeG?=
 =?us-ascii?Q?6PNjM/qHM+22cAZTe7+b9Hb2pOZXPuTzS2UWj3+KXzcR3V/Pfdhe+xTFA9G2?=
 =?us-ascii?Q?O3qotxRZgd9TVibbkjq0+robVIrkFt5dNE+I3hgR4wwXEGU7e5xLU4OGB2zq?=
 =?us-ascii?Q?gMchQg3B+3gznWvdOJQk7YKW9GLJ2KuaupTc0qp2Jp+bh9bMQH0ydQZ+5mKs?=
 =?us-ascii?Q?ZMxh+cN6TCJ7MJkfjmEG47z90sWWnuZIlOVBN8eqz6LDNDK0fu+UbOJ9cgC1?=
 =?us-ascii?Q?UAJNxq4vgLtIV9wh5oIR/uFLtavXEi29EYTnkDAXvLLBSQBZ/guV4GGpWzKP?=
 =?us-ascii?Q?zKPugFSYe5qVrnaE8taWEqRVO3yFzv9YvjaNy21mBkBBPMBbM35+glzAKqQN?=
 =?us-ascii?Q?Se2HpXGOr26mwkw+iMNRFERc0xK5ut6PZpcdjkVZc5MTohnPuFST5CgCpGuE?=
 =?us-ascii?Q?AOhRMxfFb0Ae3me4RrqwmTzzf8KqQ5wGbsbqJOitCklXFZ94hHrmrRgdYuWm?=
 =?us-ascii?Q?JSpTcUa1z5GbJDszMpiM2lD2uw6JWcCdYW3ZVQI8dBZaLHlv1/+UTZTDyQW9?=
 =?us-ascii?Q?r9aAqpiFTE1kv2567SUjMXdO1YlmZCf0PuTclQfkcp3sx+BArr878zOwLeh6?=
 =?us-ascii?Q?15cEetUha19N2gwW7D+euszgCNyfCvvMbpSIVwYDv8W0NQIZcq6Z+TUrhM9A?=
 =?us-ascii?Q?nxrcLdNJO4yY6t0oB8Xs+kceLU7ec8QjL4KJtVntnzN5cl9yuJm61mBLKCsh?=
 =?us-ascii?Q?jAx4jYg8lxE+ljBnycGXDJekkLEGmS+Oez/QWWVafJUk/5ueUUbLxJR2qhcS?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20642cf-926a-492c-9425-08dab7edee7f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:36:16.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyHHyV5FRCVIUhB3H7aK+zQiJRZ3Z4mZSqCNa/CoWyV7oYcI8jGKIwdwY/cKDfuHyjTBruzFxkQ6kPxsOgOCw7IGBWbrrX3FUSyzwEg09L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270042
X-Proofpoint-ORIG-GUID: R2lG_-p1vrUuNJV3HQ-p3z8XhLylobW4
X-Proofpoint-GUID: R2lG_-p1vrUuNJV3HQ-p3z8XhLylobW4
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
head:   4dc12f37a8e98e1dca5521c14625c869537b50b6
commit: a141d2083b462505727e14d98db5fc3cd43d59c6 drm/amd/display: Add debug option for exiting idle optimizations on cursor updates
config: mips-randconfig-m031-20221018
compiler: mips64el-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:395 dc_stream_set_cursor_position() warn: variable dereferenced before check 'stream' (see line 392)

vim +/stream +395 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c

ab2541b6739508 Aric Cyr            2016-12-29  388  bool dc_stream_set_cursor_position(
0971c40e180696 Harry Wentland      2017-07-27  389  	struct dc_stream_state *stream,
beb16b6a0f921f Dmytro Laktyushkin  2017-04-21  390  	const struct dc_cursor_position *position)
ab2541b6739508 Aric Cyr            2016-12-29  391  {
a141d2083b4625 Alvin Lee           2022-06-03 @392  	struct dc  *dc = stream->ctx->dc;
                                                                         ^^^^^^^^^^^^^^^^
New unchecked dereference

4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  393  	bool reset_idle_optimizations = false;
ab2541b6739508 Aric Cyr            2016-12-29  394  
4fa086b9b66408 Leo (Sunpeng  Li    2017-07-25 @395) 	if (NULL == stream) {
                                                            ^^^^^^^^^^^^^^
Old Yoda code check for NULL

ab2541b6739508 Aric Cyr            2016-12-29  396  		dm_error("DC: dc_stream is NULL!\n");
ab2541b6739508 Aric Cyr            2016-12-29  397  		return false;
ab2541b6739508 Aric Cyr            2016-12-29  398  	}
ab2541b6739508 Aric Cyr            2016-12-29  399  
ab2541b6739508 Aric Cyr            2016-12-29  400  	if (NULL == position) {
ab2541b6739508 Aric Cyr            2016-12-29  401  		dm_error("DC: cursor position is NULL!\n");
ab2541b6739508 Aric Cyr            2016-12-29  402  		return false;
ab2541b6739508 Aric Cyr            2016-12-29  403  	}
ab2541b6739508 Aric Cyr            2016-12-29  404  
2b77dcc5e5aa38 Anthony Koo         2019-11-05  405  	dc = stream->ctx->dc;
bae1f0b8a5b189 Nicholas Kazlauskas 2021-05-19  406  	dc_z10_restore(dc);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  407  
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  408  	/* disable idle optimizations if enabling cursor */
a141d2083b4625 Alvin Lee           2022-06-03  409  	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
a141d2083b4625 Alvin Lee           2022-06-03  410  			&& position->enable) {
4b675aad969507 Joshua Aberback     2020-08-31  411  		dc_allow_idle_optimizations(dc, false);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  412  		reset_idle_optimizations = true;
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  413  	}
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  414  
33fd17d9125c00 Eric Yang           2018-01-18  415  	stream->cursor_position = *position;
ab2541b6739508 Aric Cyr            2016-12-29  416  
4fd771ea441ed9 Roy Chan            2021-07-19  417  	program_cursor_position(dc, stream, position);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  418  	/* re-enable idle optimizations if necessary */
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  419  	if (reset_idle_optimizations)
4b675aad969507 Joshua Aberback     2020-08-31  420  		dc_allow_idle_optimizations(dc, true);
4d55b0dd1cdd85 Bhawanpreet Lakha   2020-05-21  421  
beb16b6a0f921f Dmytro Laktyushkin  2017-04-21  422  	return true;
ab2541b6739508 Aric Cyr            2016-12-29  423  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

