Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66773609D62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiJXJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJXJCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:02:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D358501
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:01:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O6rrn2026838;
        Mon, 24 Oct 2022 09:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=xt5CDE+Nsr7BAKJaFOhVyeqOXm8qpiJ6G7EW9ejg0EQ=;
 b=BoJTOWP0c9AedXipiBv4JO0MxWmEIJIM2fcq+fwkBIPvfDOHuJnygMJn6Iun7XylIANv
 +cYPAk5z1airUxxPYzhlo69aIImRJ/X1KscgPOBxlzxIH9IaTJrVTLrSSmzbymC3vLhk
 2RZix/73fR18Yws/IX2GopTcvoSywybYFyjJ1iMqZ96JgnaqCs71cZoP5Q9B+sKMgKuq
 aLHgi98L0YPBJ622J7AVnr7W/0GcuRLk7N2BQWRdMSAr0ix+bP/+gh68q9LVsvW9JErE
 1cvCZI98IQlKAy+ErO9dWaz7sBC1a/V+cSdeo1oqTgM1tCTv0lCT5BYET9xvRN3fpx6o 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84su4ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:01:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29O7k3RD015810;
        Mon, 24 Oct 2022 09:01:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9r5n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZGqdttacIdodUptcyGRuIqmlRMWNSMtp55pIyoU718/H4vPHJavJ7QDZnhkT6PaL4UOgrLUqmxCkVcz5syBHfNnFAcknX6D6BJnA8IuTTyUNaIXgExeEUXMSTxbC3cMHjS2K/xBqjvDfg4uLI3UOyzTtakK+Fe6SNnYkHwdo10Oc2rdsHoh0uT7JU4cDo2eFnprmaFp4yim2MXhn5/hqUrrbrgO+Nud/XFwJWlwlHc+GSUVzup7IoLQjry5zcnQV1BWzcToidksAj1sGpFJb0G20UtPvXDWMbYbWQOJeZJ1o4G3TZl048Gqcb/jPu1uxBh4M2dK2eIplMCZzbx6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt5CDE+Nsr7BAKJaFOhVyeqOXm8qpiJ6G7EW9ejg0EQ=;
 b=g+2D1Nk7+exgsVYiXiGFt8PAI2Ho5+qIdm5hMIlnb3qvtw4Kzo2k5I78PGdDLxGSaP+MYie2qeWIqz7CV9LUuu8y+0saVEsIGNgkhJhnCh0Yw62m2A6fZZiRYRYKZKLSWiavD6HhWtxpbe6t81TosvP6WAUrKtftO2Fz3p0nm45Fu0jrYFXAqFOK4KQocylLq4nW/cpaHW9uIK2A/lU65uEr1nsvPlQ0XHG0Q+/yzifFKtvAcROs7zg59hqOPEmT3R/74z2jS/pD90RK+TLHA47CuN172oMoaUffvHEjJ2VRRL6kskDSlHd4k4VfCBCOKOCvsvQLLaUfDFc1lHIuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt5CDE+Nsr7BAKJaFOhVyeqOXm8qpiJ6G7EW9ejg0EQ=;
 b=z+3nUDwHuV0ELF9onnl6pUjJVr3jK+eplZNjQGC44D9G1GudTGIuh82MHammF1467cxd/C1U3nvqeLb+zzGZ7RRZmJvkTdaNIcBzKtLSAueCusNt/7P5zP0DQl+4N9XCgC7JRSkyw/PcL7VaHAXJ1q9tIM+uJR//UkiztY9a11A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5853.namprd10.prod.outlook.com
 (2603:10b6:510:126::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 09:01:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 24 Oct 2022
 09:01:31 +0000
Date:   Mon, 24 Oct 2022 12:01:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3047
 commit_planes_for_stream() error: we previously assumed
 'top_pipe_to_program' could be null (see line 2870)
Message-ID: <202210220251.nb7E3lyi-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 687f4159-c53f-496c-340e-08dab59e57de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74Se72c9BpaxTOfnb0799WTLBm64etjRkxzPwBkPxXNsgdJ6GNqrrwpy1CTqPhsMQrpD5RdriNqHNSnpApOOymE4i1p2v0OPzOchBZW9I7ZyA4NoS7jJ3PeNSw4ehzsWm3HIrwn8Cj7iTecHXgbQHe21QyRmw4WUpS/V99rBumWBXEg0sU2BOGt9m0cm1POoR5rK2VRimh9+hM6quMZTS6KW5yBaPAPIWdXGBMK3mE8qg/PeCw5C24EGZGuHtLRAnZBGxECmbB7rn3ZGmA1jTVSH33AG4gwwxQMStXShC6PpacKo37bcCbIsgYfpCjghEEVp/yiKFlHcqVPEOfyAI1U8UOlDhoRpI35l/uy4YUxNFZWrUHPQl3DvPcR9EvH7xCZWTeSkpqiMRxE4XShqmfhsAMac/P6uMfr+TWOpvSM+bNuQ3jhTVsvwQkWGvPjyYj2g+oEt8eXAy4qyUF/L0mlY6eOSUvpNbrlEtXqyPgtn2sQu7IYU3aN1Ck9DOzyMUOqT5bb2S+gqq4j6fyh1NSBbCYTV6FGij4F08gp6oMFnyWtfBPuuUwaNCSVdjHH33jDfAPSfsAJ2bsa2ALVWwvyc2vMVsTmta0Xiw1Ozhm0n6YWrM3Tk0H5oBhqa/uOa1kt6V8+vKTsWMl8ol3cwmiXA2yyW9+QeIZsd79mUBgaaMZwfiHHLFrdDRXNVfOMJdLUwgBV2cfJgwzZi4JLwSe/Kmm1ZDDDAol2k3A1dPTLenZ07291mHCXAcW0vQcSUzS92es8DY0lcs2lWvqipiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(66556008)(8936002)(316002)(41300700001)(66946007)(6512007)(66476007)(36756003)(5660300002)(30864003)(38100700002)(4326008)(478600001)(6486002)(1076003)(966005)(86362001)(9686003)(26005)(6666004)(186003)(6916009)(83380400001)(4001150100001)(8676002)(6506007)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OMExIrJtOBiBytNd8hg7JUINrcNw9zzhrbo02dQM07QaGKlETF4Uypf61lA/?=
 =?us-ascii?Q?VF/Ls7NZ3HdtCBd9HPYH0XRh89c6ZouV7JCweoKMybdSrARw0ic67a63m1oR?=
 =?us-ascii?Q?81dU9MsY1oLJDYDQPao3BdDQ/X93QpnPN+I0e3k+Jrc68F3KmH/fscD+soRk?=
 =?us-ascii?Q?cRzTSTjoJu0/knl4W4iH9xLLGsD32x7lPiwHFSvg1vRGW0+puHbpZLt9gyVM?=
 =?us-ascii?Q?m/U0Js4KMh4u+JFWZyum8myyw34gfDOPM9jrCmG7hOgD4hH7Xi4ftYMiK6U3?=
 =?us-ascii?Q?g2lrIk6gTIUkRJeNbFqMRaLscvY40jNAZedqX4GgWw6YF/plpmRuzR0cEird?=
 =?us-ascii?Q?rbXsmE3Wf7hBb8xFIyWg8IWj46BmedCF5qIOWIlIjxHURKw6mltaLrxsNMWx?=
 =?us-ascii?Q?/36J7GFDbdFXsll/BiE9zZUF65gUxKOIbOG4oqAXi4Vghy2lBEPm32jTMgJd?=
 =?us-ascii?Q?c2wdeEmI3j4TTw8WUtf3v9KzJUZsgLgmCr3pP5KCvknCEGwNizUIDU/6EKA/?=
 =?us-ascii?Q?RvaKP0T2EUxjarDts0yvnfsXwFIruFiqkvqZH391nniq8jkGFDjWJGJrJ2mz?=
 =?us-ascii?Q?UjlB6NRxJ0EOaVT4h14IbEiKBgJOf2mcTWKgrlwcovbPhl+Es+HViYXvy8Aw?=
 =?us-ascii?Q?ljUznsWgYygvjwZSN73K5La8B3EW2ai1RuoJG6H+5mylOXEcvMkMHJgsRtjS?=
 =?us-ascii?Q?eGN4dugoZs5oVVzmyBa4D1GoCU0UZfOmv+eVLTVxgztABzSQ5PujhhjKMFLZ?=
 =?us-ascii?Q?LAOuukbc8BbiFhRgQrOPGoRbyIUSznCC3RGlAnwnSQzV1tIqSJYmZCUVn9yQ?=
 =?us-ascii?Q?yPqJ6FS7CI1mC2kYrzhIN9g7qA1tG36XkcfZEqdyTB/v9fM1MEcrV/c/Eqp0?=
 =?us-ascii?Q?54jNgZDAtRonpO26IW5cgYpGMXOpZkwN/Lj5NIsj+woxcorUIke7aZ2+Jivn?=
 =?us-ascii?Q?P9olHrf2uh7V8wGt9DnwiPxfcoNknKuch9Mwr+nqVyygUtKEh9Xi+LDHqqxC?=
 =?us-ascii?Q?G+q4U7wDEkaWCqXI5ZIZ9gB81EcJiuJ95KNuCm7K8xyGihoMhoFh1YQETkYH?=
 =?us-ascii?Q?PtHpiHCJnXTC/+CvnY0FYNb6tglmO6w3j7CJSKa5M25G6N8C7kLaK20zd4Lr?=
 =?us-ascii?Q?5R21hawfyCagfkkSifklTnYMUenX6jU8kqxcwiG9HuyveurT+Ev6/wWMGnY1?=
 =?us-ascii?Q?56DpgmS+lwkr++ULwaYdaM2mPQBiZBwE/Tfi+Oyob95f1rdvvNi8JG9n/jTo?=
 =?us-ascii?Q?LZiGVYxt5n1n3oWtM3ZOOGBQd4Q+MFP4q6Qzp6qKn13/tcZeMt6CJie2vqqW?=
 =?us-ascii?Q?oMdSXe/AdO5Fmj01KvPkv5RlMUI2FgcHDnhKfukbi6BJafW2IpSXeerzJnrC?=
 =?us-ascii?Q?BEjLFDxMulzVQgxKPoa5iv15Iy4h0Nh9UHLdduS8g3GKausIOaAzvgefeFA1?=
 =?us-ascii?Q?r+oJK1WOK0og3z2ASAb2oOMQLftscG8D+JaZAcx6CkQAN388dyEnwJWfdaLx?=
 =?us-ascii?Q?RTp49Rra/xYAg7X715Op9kT+U/Ey9di7Ke4gHHKzdv8IfZVjOQRBN8LJINAa?=
 =?us-ascii?Q?5eUDZV4vKz48i9osHgFHKxkl1rjUESSV0+CaRDix9HpqtBOScjfL+ADZ193a?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687f4159-c53f-496c-340e-08dab59e57de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:01:31.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tG2Y6QGaHh34J2LMERiSGOZ24mvPeel5xAdUjy7yJB/CKfwTUT/YoWiEbHoia+EicftQWCV8T58dwTVXVG0CqpRCw1ABVqmz6RvZ/ji7qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240056
X-Proofpoint-ORIG-GUID: RJXGBPG8YD2XMrS5uwkRvdBhE7gJr9v1
X-Proofpoint-GUID: RJXGBPG8YD2XMrS5uwkRvdBhE7gJr9v1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e35184f321518acadb681928a016da21a9a20c13
commit: a689e8d1f80012f90384ebac9dcfac4201f9f77e drm/amd/display: check top_pipe_to_program pointer
config: mips-randconfig-m031-20221018
compiler: mips64el-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3047 commit_planes_for_stream() error: we previously assumed 'top_pipe_to_program' could be null (see line 2870)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:883 dc_construct_ctx() warn: possible memory leak of 'dc_ctx'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2285 det_surface_update() warn: variable dereferenced before check 'u->surface' (see line 2252)
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3058 commit_planes_for_stream() warn: variable dereferenced before check 'stream' (see line 2869)

vim +/top_pipe_to_program +3047 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c

482812d56698ef Wesley Chalmers       2021-03-12  2868  
71b81f1275e0b5 Wenjing Liu           2020-01-22  2869  	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
a689e8d1f80012 Yang Li               2021-11-15 @2870  		if (top_pipe_to_program &&
a689e8d1f80012 Yang Li               2021-11-15  2871  			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {

Check for NULL

cfafe238b58596 Dan Carpenter         2020-07-14  2872  			if (should_use_dmub_lock(stream->link)) {
dc6e2448558d68 Wyatt Wood            2020-05-27  2873  				union dmub_hw_lock_flags hw_locks = { 0 };
dc6e2448558d68 Wyatt Wood            2020-05-27  2874  				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
dc6e2448558d68 Wyatt Wood            2020-05-27  2875  
dc6e2448558d68 Wyatt Wood            2020-05-27  2876  				hw_locks.bits.lock_dig = 1;
dc6e2448558d68 Wyatt Wood            2020-05-27  2877  				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
dc6e2448558d68 Wyatt Wood            2020-05-27  2878  
dc6e2448558d68 Wyatt Wood            2020-05-27  2879  				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
dc6e2448558d68 Wyatt Wood            2020-05-27  2880  							true,
dc6e2448558d68 Wyatt Wood            2020-05-27  2881  							&hw_locks,
dc6e2448558d68 Wyatt Wood            2020-05-27  2882  							&inst_flags);
dc6e2448558d68 Wyatt Wood            2020-05-27  2883  			} else
71b81f1275e0b5 Wenjing Liu           2020-01-22  2884  				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
71b81f1275e0b5 Wenjing Liu           2020-01-22  2885  						top_pipe_to_program->stream_res.tg);
dc6e2448558d68 Wyatt Wood            2020-05-27  2886  		}
71b81f1275e0b5 Wenjing Liu           2020-01-22  2887  
f9ccaf6da03134 Roy Chan              2021-07-21  2888  	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
009114f6df8415 Anthony Koo           2020-01-14  2889  		dc->hwss.interdependent_update_lock(dc, context, true);
009114f6df8415 Anthony Koo           2020-01-14  2890  	else
009114f6df8415 Anthony Koo           2020-01-14  2891  		/* Lock the top pipe while updating plane addrs, since freesync requires
009114f6df8415 Anthony Koo           2020-01-14  2892  		 *  plane addr update event triggers to be synchronized.
009114f6df8415 Anthony Koo           2020-01-14  2893  		 *  top_pipe_to_program is expected to never be NULL
009114f6df8415 Anthony Koo           2020-01-14  2894  		 */
009114f6df8415 Anthony Koo           2020-01-14  2895  		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
009114f6df8415 Anthony Koo           2020-01-14  2896  
1e7e86c43f38d2 Samson Tam            2018-05-01  2897  	// Stream updates
1e7e86c43f38d2 Samson Tam            2018-05-01  2898  	if (stream_update)
1e7e86c43f38d2 Samson Tam            2018-05-01  2899  		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
1e7e86c43f38d2 Samson Tam            2018-05-01  2900  
671a6246e0d365 Yongqiang Sun         2017-09-22  2901  	if (surface_count == 0) {
671a6246e0d365 Yongqiang Sun         2017-09-22  2902  		/*
671a6246e0d365 Yongqiang Sun         2017-09-22  2903  		 * In case of turning off screen, no need to program front end a second time.
1e7e86c43f38d2 Samson Tam            2018-05-01  2904  		 * just return after program blank.
671a6246e0d365 Yongqiang Sun         2017-09-22  2905  		 */
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2906  		if (dc->hwss.apply_ctx_for_surface)
1e7e86c43f38d2 Samson Tam            2018-05-01  2907  			dc->hwss.apply_ctx_for_surface(dc, stream, 0, context);
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2908  		if (dc->hwss.program_front_end_for_ctx)
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2909  			dc->hwss.program_front_end_for_ctx(dc, context);
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2910  
f9ccaf6da03134 Roy Chan              2021-07-21  2911  		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
009114f6df8415 Anthony Koo           2020-01-14  2912  			dc->hwss.interdependent_update_lock(dc, context, false);
009114f6df8415 Anthony Koo           2020-01-14  2913  		else
009114f6df8415 Anthony Koo           2020-01-14  2914  			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
bbf5f6c3f83bed Anthony Koo           2020-01-14  2915  		dc->hwss.post_unlock_program_front_end(dc, context);
671a6246e0d365 Yongqiang Sun         2017-09-22  2916  		return;
671a6246e0d365 Yongqiang Sun         2017-09-22  2917  	}
4562236b3bc0a2 Harry Wentland        2017-09-12  2918  
6fbefb84a98ecc Harry Wentland        2019-02-22  2919  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2920  		for (i = 0; i < surface_count; i++) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2921  			struct dc_plane_state *plane_state = srf_updates[i].surface;
6fbefb84a98ecc Harry Wentland        2019-02-22  2922  			/*set logical flag for lock/unlock use*/
6fbefb84a98ecc Harry Wentland        2019-02-22  2923  			for (j = 0; j < dc->res_pool->pipe_count; j++) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2924  				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
6fbefb84a98ecc Harry Wentland        2019-02-22  2925  				if (!pipe_ctx->plane_state)
6fbefb84a98ecc Harry Wentland        2019-02-22  2926  					continue;
f9ccaf6da03134 Roy Chan              2021-07-21  2927  				if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
6fbefb84a98ecc Harry Wentland        2019-02-22  2928  					continue;
f9ccaf6da03134 Roy Chan              2021-07-21  2929  				pipe_ctx->plane_state->triplebuffer_flips = false;
6fbefb84a98ecc Harry Wentland        2019-02-22  2930  				if (update_type == UPDATE_TYPE_FAST &&
6fbefb84a98ecc Harry Wentland        2019-02-22  2931  					dc->hwss.program_triplebuffer != NULL &&
f9ccaf6da03134 Roy Chan              2021-07-21  2932  					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2933  						/*triple buffer for VUpdate  only*/
f9ccaf6da03134 Roy Chan              2021-07-21  2934  						pipe_ctx->plane_state->triplebuffer_flips = true;
6fbefb84a98ecc Harry Wentland        2019-02-22  2935  				}
6fbefb84a98ecc Harry Wentland        2019-02-22  2936  			}
56d63782af9bbd Anthony Wang          2021-03-31  2937  			if (update_type == UPDATE_TYPE_FULL) {
56d63782af9bbd Anthony Wang          2021-03-31  2938  				/* force vsync flip when reconfiguring pipes to prevent underflow */
56d63782af9bbd Anthony Wang          2021-03-31  2939  				plane_state->flip_immediate = false;
56d63782af9bbd Anthony Wang          2021-03-31  2940  			}
6fbefb84a98ecc Harry Wentland        2019-02-22  2941  		}
6fbefb84a98ecc Harry Wentland        2019-02-22  2942  	}
6fbefb84a98ecc Harry Wentland        2019-02-22  2943  
1e7e86c43f38d2 Samson Tam            2018-05-01  2944  	// Update Type FULL, Surface updates
156590454259a1 Bhawanpreet Lakha     2017-08-23  2945  	for (j = 0; j < dc->res_pool->pipe_count; j++) {
f19d5f3520d67c Dmytro Laktyushkin    2017-06-13  2946  		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
3e9ad6164b98f8 Eric Yang             2017-08-03  2947  
e6c258cb4e6fbc Yongqiang Sun         2017-10-30  2948  		if (!pipe_ctx->top_pipe &&
285e30049708c4 Dmytro Laktyushkin    2019-08-06  2949  			!pipe_ctx->prev_odm_pipe &&
f9ccaf6da03134 Roy Chan              2021-07-21  2950  			should_update_pipe_for_stream(context, pipe_ctx, stream)) {
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  2951  			struct dc_stream_status *stream_status = NULL;
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  2952  
98e6436d3af5fe Anthony Koo           2018-08-21  2953  			if (!pipe_ctx->plane_state)
98e6436d3af5fe Anthony Koo           2018-08-21  2954  				continue;
98e6436d3af5fe Anthony Koo           2018-08-21  2955  
98e6436d3af5fe Anthony Koo           2018-08-21  2956  			/* Full fe update*/
98e6436d3af5fe Anthony Koo           2018-08-21  2957  			if (update_type == UPDATE_TYPE_FAST)
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  2958  				continue;
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  2959  
6fbefb84a98ecc Harry Wentland        2019-02-22  2960  			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
6fbefb84a98ecc Harry Wentland        2019-02-22  2961  
091018a51c16ec Aric Cyr              2020-08-21  2962  			if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2963  				/*turn off triple buffer for full update*/
6fbefb84a98ecc Harry Wentland        2019-02-22  2964  				dc->hwss.program_triplebuffer(
6fbefb84a98ecc Harry Wentland        2019-02-22  2965  					dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
6fbefb84a98ecc Harry Wentland        2019-02-22  2966  			}
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  2967  			stream_status =
e6c258cb4e6fbc Yongqiang Sun         2017-10-30  2968  				stream_get_status(context, pipe_ctx->stream);
3e9ad6164b98f8 Eric Yang             2017-08-03  2969  
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2970  			if (dc->hwss.apply_ctx_for_surface)
156590454259a1 Bhawanpreet Lakha     2017-08-23  2971  				dc->hwss.apply_ctx_for_surface(
156590454259a1 Bhawanpreet Lakha     2017-08-23  2972  					dc, pipe_ctx->stream, stream_status->plane_count, context);
3e9ad6164b98f8 Eric Yang             2017-08-03  2973  		}
f19d5f3520d67c Dmytro Laktyushkin    2017-06-13  2974  	}
b9fe5151052f9d Jaehyun Chung         2019-10-31  2975  	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
b6e881c947417e Dmytro Laktyushkin    2019-09-13  2976  		dc->hwss.program_front_end_for_ctx(dc, context);
a4cea11655fbc5 Jaehyun Chung         2019-11-07  2977  #ifdef CONFIG_DRM_AMD_DC_DCN
b9fe5151052f9d Jaehyun Chung         2019-10-31  2978  		if (dc->debug.validate_dml_output) {
b9fe5151052f9d Jaehyun Chung         2019-10-31  2979  			for (i = 0; i < dc->res_pool->pipe_count; i++) {
b9fe5151052f9d Jaehyun Chung         2019-10-31  2980  				struct pipe_ctx cur_pipe = context->res_ctx.pipe_ctx[i];
b9fe5151052f9d Jaehyun Chung         2019-10-31  2981  				if (cur_pipe.stream == NULL)
b9fe5151052f9d Jaehyun Chung         2019-10-31  2982  					continue;
b9fe5151052f9d Jaehyun Chung         2019-10-31  2983  
b9fe5151052f9d Jaehyun Chung         2019-10-31  2984  				cur_pipe.plane_res.hubp->funcs->validate_dml_output(
b9fe5151052f9d Jaehyun Chung         2019-10-31  2985  						cur_pipe.plane_res.hubp, dc->ctx,
b9fe5151052f9d Jaehyun Chung         2019-10-31  2986  						&context->res_ctx.pipe_ctx[i].rq_regs,
b9fe5151052f9d Jaehyun Chung         2019-10-31  2987  						&context->res_ctx.pipe_ctx[i].dlg_regs,
b9fe5151052f9d Jaehyun Chung         2019-10-31  2988  						&context->res_ctx.pipe_ctx[i].ttu_regs);
b9fe5151052f9d Jaehyun Chung         2019-10-31  2989  			}
b9fe5151052f9d Jaehyun Chung         2019-10-31  2990  		}
b9fe5151052f9d Jaehyun Chung         2019-10-31  2991  #endif
b9fe5151052f9d Jaehyun Chung         2019-10-31  2992  	}
f19d5f3520d67c Dmytro Laktyushkin    2017-06-13  2993  
1e7e86c43f38d2 Samson Tam            2018-05-01  2994  	// Update Type FAST, Surface updates
1e7e86c43f38d2 Samson Tam            2018-05-01  2995  	if (update_type == UPDATE_TYPE_FAST) {
6fbefb84a98ecc Harry Wentland        2019-02-22  2996  		if (dc->hwss.set_flip_control_gsl)
00f02019990d90 Leon Elazar           2017-03-17  2997  			for (i = 0; i < surface_count; i++) {
3be5262e353b8a Harry Wentland        2017-07-27  2998  				struct dc_plane_state *plane_state = srf_updates[i].surface;
00f02019990d90 Leon Elazar           2017-03-17  2999  
156590454259a1 Bhawanpreet Lakha     2017-08-23  3000  				for (j = 0; j < dc->res_pool->pipe_count; j++) {
00f02019990d90 Leon Elazar           2017-03-17  3001  					struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
00f02019990d90 Leon Elazar           2017-03-17  3002  
f9ccaf6da03134 Roy Chan              2021-07-21  3003  					if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
b8fce2c9d773e1 Yongqiang Sun         2017-11-07  3004  						continue;
b8fce2c9d773e1 Yongqiang Sun         2017-11-07  3005  
f9ccaf6da03134 Roy Chan              2021-07-21  3006  					if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
00f02019990d90 Leon Elazar           2017-03-17  3007  						continue;
e72f0acd369d3d Tony Cheng            2017-01-19  3008  
6fbefb84a98ecc Harry Wentland        2019-02-22  3009  					// GSL has to be used for flip immediate
6fbefb84a98ecc Harry Wentland        2019-02-22  3010  					dc->hwss.set_flip_control_gsl(pipe_ctx,
f9ccaf6da03134 Roy Chan              2021-07-21  3011  							pipe_ctx->plane_state->flip_immediate);
6fbefb84a98ecc Harry Wentland        2019-02-22  3012  				}
6fbefb84a98ecc Harry Wentland        2019-02-22  3013  			}
980d6042c1dc0d Wyatt Wood            2021-01-19  3014  
6fbefb84a98ecc Harry Wentland        2019-02-22  3015  		/* Perform requested Updates */
6fbefb84a98ecc Harry Wentland        2019-02-22  3016  		for (i = 0; i < surface_count; i++) {
6fbefb84a98ecc Harry Wentland        2019-02-22  3017  			struct dc_plane_state *plane_state = srf_updates[i].surface;
6fbefb84a98ecc Harry Wentland        2019-02-22  3018  
6fbefb84a98ecc Harry Wentland        2019-02-22  3019  			for (j = 0; j < dc->res_pool->pipe_count; j++) {
6fbefb84a98ecc Harry Wentland        2019-02-22  3020  				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
6fbefb84a98ecc Harry Wentland        2019-02-22  3021  
f9ccaf6da03134 Roy Chan              2021-07-21  3022  				if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
6fbefb84a98ecc Harry Wentland        2019-02-22  3023  					continue;
6fbefb84a98ecc Harry Wentland        2019-02-22  3024  
f9ccaf6da03134 Roy Chan              2021-07-21  3025  				if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
6fbefb84a98ecc Harry Wentland        2019-02-22  3026  					continue;
f9ccaf6da03134 Roy Chan              2021-07-21  3027  
6fbefb84a98ecc Harry Wentland        2019-02-22  3028  				/*program triple buffer after lock based on flip type*/
091018a51c16ec Aric Cyr              2020-08-21  3029  				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
6fbefb84a98ecc Harry Wentland        2019-02-22  3030  					/*only enable triplebuffer for  fast_update*/
6fbefb84a98ecc Harry Wentland        2019-02-22  3031  					dc->hwss.program_triplebuffer(
f9ccaf6da03134 Roy Chan              2021-07-21  3032  						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
6fbefb84a98ecc Harry Wentland        2019-02-22  3033  				}
f9ccaf6da03134 Roy Chan              2021-07-21  3034  				if (pipe_ctx->plane_state->update_flags.bits.addr_update)
156590454259a1 Bhawanpreet Lakha     2017-08-23  3035  					dc->hwss.update_plane_addr(dc, pipe_ctx);
56ef6ed9faf35b Anthony Koo           2017-10-23  3036  			}
56ef6ed9faf35b Anthony Koo           2017-10-23  3037  		}
980d6042c1dc0d Wyatt Wood            2021-01-19  3038  
009114f6df8415 Anthony Koo           2020-01-14  3039  	}
56ef6ed9faf35b Anthony Koo           2017-10-23  3040  
f9ccaf6da03134 Roy Chan              2021-07-21  3041  	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
009114f6df8415 Anthony Koo           2020-01-14  3042  		dc->hwss.interdependent_update_lock(dc, context, false);
009114f6df8415 Anthony Koo           2020-01-14  3043  	else
05133ac856d078 SivapiriyanKumarasamy 2018-01-04  3044  		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
e63e2491ad9203 Eryk Brol             2019-04-23  3045  
71b81f1275e0b5 Wenjing Liu           2020-01-22  3046  	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
71b81f1275e0b5 Wenjing Liu           2020-01-22 @3047  		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {

Unchecked dereference

71b81f1275e0b5 Wenjing Liu           2020-01-22  3048  			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
71b81f1275e0b5 Wenjing Liu           2020-01-22  3049  					top_pipe_to_program->stream_res.tg,
71b81f1275e0b5 Wenjing Liu           2020-01-22  3050  					CRTC_STATE_VACTIVE);
71b81f1275e0b5 Wenjing Liu           2020-01-22  3051  			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
71b81f1275e0b5 Wenjing Liu           2020-01-22  3052  					top_pipe_to_program->stream_res.tg,
71b81f1275e0b5 Wenjing Liu           2020-01-22  3053  					CRTC_STATE_VBLANK);
71b81f1275e0b5 Wenjing Liu           2020-01-22  3054  			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
71b81f1275e0b5 Wenjing Liu           2020-01-22  3055  					top_pipe_to_program->stream_res.tg,
71b81f1275e0b5 Wenjing Liu           2020-01-22  3056  					CRTC_STATE_VACTIVE);
dc6e2448558d68 Wyatt Wood            2020-05-27  3057  
dc6e2448558d68 Wyatt Wood            2020-05-27  3058  			if (stream && should_use_dmub_lock(stream->link)) {
dc6e2448558d68 Wyatt Wood            2020-05-27  3059  				union dmub_hw_lock_flags hw_locks = { 0 };
dc6e2448558d68 Wyatt Wood            2020-05-27  3060  				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
dc6e2448558d68 Wyatt Wood            2020-05-27  3061  
dc6e2448558d68 Wyatt Wood            2020-05-27  3062  				hw_locks.bits.lock_dig = 1;
dc6e2448558d68 Wyatt Wood            2020-05-27  3063  				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
dc6e2448558d68 Wyatt Wood            2020-05-27  3064  
dc6e2448558d68 Wyatt Wood            2020-05-27  3065  				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
dc6e2448558d68 Wyatt Wood            2020-05-27  3066  							false,
dc6e2448558d68 Wyatt Wood            2020-05-27  3067  							&hw_locks,
dc6e2448558d68 Wyatt Wood            2020-05-27  3068  							&inst_flags);
dc6e2448558d68 Wyatt Wood            2020-05-27  3069  			} else
71b81f1275e0b5 Wenjing Liu           2020-01-22  3070  				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
71b81f1275e0b5 Wenjing Liu           2020-01-22  3071  					top_pipe_to_program->stream_res.tg);
71b81f1275e0b5 Wenjing Liu           2020-01-22  3072  		}
71b81f1275e0b5 Wenjing Liu           2020-01-22  3073  
bbf5f6c3f83bed Anthony Koo           2020-01-14  3074  	if (update_type != UPDATE_TYPE_FAST)
bbf5f6c3f83bed Anthony Koo           2020-01-14  3075  		dc->hwss.post_unlock_program_front_end(dc, context);
bbf5f6c3f83bed Anthony Koo           2020-01-14  3076  
4fd334122399a1 Aric Cyr              2019-05-16  3077  	// Fire manual trigger only when bottom plane is flipped
4fd334122399a1 Aric Cyr              2019-05-16  3078  	for (j = 0; j < dc->res_pool->pipe_count; j++) {
4fd334122399a1 Aric Cyr              2019-05-16  3079  		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
e63e2491ad9203 Eryk Brol             2019-04-23  3080  
148493a81e3b60 Robin Singh           2021-03-09  3081  		if (!pipe_ctx->plane_state)
148493a81e3b60 Robin Singh           2021-03-09  3082  			continue;
148493a81e3b60 Robin Singh           2021-03-09  3083  
35a4644c935ee8 Aric Cyr              2020-10-08  3084  		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
f9ccaf6da03134 Roy Chan              2021-07-21  3085  				!pipe_ctx->stream || !should_update_pipe_for_stream(context, pipe_ctx, stream) ||
41ef8fbbef8e21 Aric Cyr              2021-03-17  3086  				!pipe_ctx->plane_state->update_flags.bits.addr_update ||
41ef8fbbef8e21 Aric Cyr              2021-03-17  3087  				pipe_ctx->plane_state->skip_manual_trigger)
e63e2491ad9203 Eryk Brol             2019-04-23  3088  			continue;
e63e2491ad9203 Eryk Brol             2019-04-23  3089  
e63e2491ad9203 Eryk Brol             2019-04-23  3090  		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
e63e2491ad9203 Eryk Brol             2019-04-23  3091  			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
e63e2491ad9203 Eryk Brol             2019-04-23  3092  	}
4562236b3bc0a2 Harry Wentland        2017-09-12  3093  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

