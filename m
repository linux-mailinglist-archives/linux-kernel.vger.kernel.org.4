Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFF5B6A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiIMJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiIMJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:12:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C15C363;
        Tue, 13 Sep 2022 02:12:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D98sTV032502;
        Tue, 13 Sep 2022 09:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=N89DKLwcsDYzeYCkkWO1HTFI/8UIcb4b8axPPMd5y0g=;
 b=OutJSJ4gh9VkoQaYXvNKT3T7T/tgRkWpG9pm7tfxy4DasuUg6OyD/6AMCQQroq8EO07D
 ixaRFSuJ8mG3c9raOP2QQ2/7uPj1Bv1oz58dFH7MvZxrzKoDknHcu2AL4m7wuIvVZjUy
 5AV14wrEWKRUGb2s7YBASa9G87kQjc4JKnzkGV6t7gai4EAWOqp+jJF3WXjHGZzti6Zn
 NHvG9WABu8MgGHnpOVwIGS8w5q9ciNtPzmmT3ncSrxkwRfmrVQBvf2qT4j61vf2w39dg
 p2uzAk1eVZiSr+rmfzZ0ya8tqvVWuQAsV6Y1kyoYxcYP9NLMGsP6phE17ARvuKkePJS+ kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2p7hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:12:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8TUUO034882;
        Tue, 13 Sep 2022 09:12:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh138cvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Orvi02YkE/9kDrh0wWal5kQpJDYNJhVdhaDIvguwSe67vWB3a72PCYqKfoRMNjQJhqT/YpN2NRj/sX5+/E3lQi8rmpdhuARQi7tK6bu1DveG2vx8jt7ZLZhpC4FeGkQK20V4X8LV3EHd3+Zrl0ePU99D9EWigS7NEIIsE4XNq0Fdkv4B/l+1KdHSc6TeO/GrYyHMlyu0VNjfM8FWa3212oB9reJ0MZ/XtcAZmO50odKkp9XVdOVtm1GsPeWSstor/HEnx5BlAkmbvxCPWtlygTr/yXAhCln9fcgHQUpEWG9Bx+gNkGZxyzBCLEpXTFyAwpfWzf36PA0pMvtAPj3zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N89DKLwcsDYzeYCkkWO1HTFI/8UIcb4b8axPPMd5y0g=;
 b=axEzzWgFUSPus9IMcbrVrHHUe3XPIIO1bPR/O19t4vNtrcMGp8ZkrHfRy6WpbXvN8NmaOzuW5x0a400g3ujmp70JfwvuI1VWC+yfBLmBsYlElijYeo5fGTAf+i3D0ykyxMx3NH9Unph0j4tzDDcbkLxAq4ZzIQsu3g7a3trW23AyKjT+TkeEBymga8Z07oePMFrb4LB6BLGqmcQ1E/pHwVXBKt3ybz29xd+4qHGQAsC7FssF3o25qjHfg3Ukvvc7kuulBosctpvO3Fqv5XetkaifWsrc391fJVhl+6sJtFWpr7xWZDrRg7j9OONBVBH8dqKCvt/U50000ZHhAZ5vHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N89DKLwcsDYzeYCkkWO1HTFI/8UIcb4b8axPPMd5y0g=;
 b=mIm495igR4JdM60qyuR3+1ume9FoXGZRmrIJdhT6eYhg2CPHMBxLWSK17farPtCDjTTdEAhWqdf+wxyuHwl1qBMOAtGhGpqdlGqtd4x0XEirTg5lV2sjDAXlStwzjr0XkRWOJsWFl0yddFHgW+GvQrsvoqf46jABa1y3FuQhifU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5370.namprd10.prod.outlook.com
 (2603:10b6:610:db::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 09:12:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:12:10 +0000
Date:   Tue, 13 Sep 2022 12:11:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Li Zhong <floridsleeves@gmail.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, song@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/md/md-bitmap: check the return value of
 md_bitmap_get_counter()
Message-ID: <202209111048.YGgWVmUV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909040936.2610780-1-floridsleeves@gmail.com>
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: f05a9f6a-d9a6-464d-061e-08da956809c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkD/y4reuHkdDwUErpmVbZpBFPWDvDMSj8nSy6A0cPtZc2mTYbPtdpdhfm/mwNWCo1D0UMqjF9gql5UGndUJLf/1FewJfXW2iK5kOc4FoyzsSHpX7rhBs9/5I2x+8ml4kOAe5qcgLV1nDVhdMRFMlFiJY8jdYxwpUcFNdDQwj8otLZsYbno95EPhJMyknWEjK6C/609uc4eO5daKWJDai9tt6uc+5RLYnT6SIytAl77aPJiUyN7HUzGdESZXpQt3tVy+I9KZU1odyfwwtKPe+nHz08gKQoaFjKbRGvYo7soUl4tTAc2jqnmbeonFBgFp/dp4nwUesAf29Z22W90CFI9Ux+DQeFG8OmFes567sf9UcZ2cbZM0NDL/aFBEZD7BGbqxPp1n4lZSVb0SF748Uo16a3pwHEPzu3XCna7PfTxiKYx10/v7Uy92AZ1cYZEVzq73hRJYLMtvgvELeKYz2Db+G3v/HSGO6u7VvK3ZY4VXu3m+br2SvjUV+xg9XTwZ6FmoSTVPggCQzw8TmtiNeATexzVg4He9jH7zeOKvBpDoLDs7zyeTaaGn7FVqakARGJtpgiB3rKxxhR+VFR7NtUPi8y+Jh8x4P0ytsNrIV3yqUyWlqmpbrJRx2+rQGo+PYdUzX1N2r2dBINo4aCK6ckFymwzrN1LLafQVkm8yi0N7Bgc1VcPTAqvLFVp5FKJPR7XYCfNz36wdFqrd/TGi41RUR3BTd+kkZDafecvbzGGFkjI7iNTgaowAUT0DWHveCM9h5NRK8R/bw17H1AqxSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(86362001)(4326008)(6512007)(8676002)(26005)(66556008)(38100700002)(478600001)(6506007)(1076003)(9686003)(2906002)(6486002)(41300700001)(44832011)(5660300002)(316002)(6666004)(966005)(83380400001)(66946007)(36756003)(66476007)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/SzHOF3oI4xMysNacn6mD48oQ+Bokeeg7WSzh2VYQDw1qD1aU7WnuUHnovHW?=
 =?us-ascii?Q?dNhCJOBq4j/SOGFRf+f7rtIGKpLTnCmMc+iLc7P/LJx17PDBDqvfkKs8UNUR?=
 =?us-ascii?Q?wctL8BC/lPtryva+GeOqxhLuJl7SlT4kiFtgdpnZgpbT7BsntxK+hyJAB6os?=
 =?us-ascii?Q?cU7DsxP0sF/X+bZeB8Ws5rgU+hXy9d6ZuO2gQxHXAW94Apa6arujBhsz6TFm?=
 =?us-ascii?Q?UmpZ/a4gQmvrL9r8gSc9D2v50tWPBrcTO5glBjDQLtGCa7FTd1JqLZH0VnQq?=
 =?us-ascii?Q?GOTts1X+qr2SEyRIJh1+GuNDsY7nGue+KXVRw6vuRhBrM0cRtpE/ttfi1UE+?=
 =?us-ascii?Q?wUQQrHqL36lu2Fgzi/cb6YNqtTa1zxCOpL9PLgq25jEkaao1t5ID+gPrtJIB?=
 =?us-ascii?Q?255ccFmQgbW5awdbadqy4M+/Bi7fX5rw+qUCEwqOyZqM5mOskuPOxBn6Hi7k?=
 =?us-ascii?Q?yH5bUw8xHeGwfVB7wT2Lo7YxCFL/WaR9bWXFME/AhnDpX9NoyVcNlxWlFqgM?=
 =?us-ascii?Q?cv7+Ml7VZ59oWz8wf1lUkQP9CchZRVVGyqYvwN2sy7V2Fw82edYSTaEucMTc?=
 =?us-ascii?Q?NbSCwb25ta3LNo2YsfQCA60Dq+P2qYjbNytQrAHA92wg2ekob2XGcXbESgQQ?=
 =?us-ascii?Q?+9AoLCb61oPMWCDWdS5Hesy8epxbLkjCZE4SQDxcV/hKqYpca8nftHHEqd+J?=
 =?us-ascii?Q?Bc1FN1ANx7bKF6Dsg9y/mt6+QHSyVWQI+k/tFadwJbuTVEEUPKLPf7jiDM+J?=
 =?us-ascii?Q?3pX+tert3RLE2oepUGr2AH41+OB8LBDCwKjPljL1DUHjehYATaFnOUGRoV8M?=
 =?us-ascii?Q?1Qcm8LldlwCT5yC+L6A5dRuFhXWnxp5rnGm/hDRCkpcU+aOwxHFnIapFG95g?=
 =?us-ascii?Q?g7IJmTDaYxEa37x3IwkjRcuNyxmQ9rbaCz465D0HgrI9DpzwVAkfGWSg9a2K?=
 =?us-ascii?Q?1VFX6TDekPA0lvylijP4Wsy+KzsszmvJNlopScwu6Pyy/WLfjad0PEqyqwUu?=
 =?us-ascii?Q?yTgbl4wVSoUhzdDOPo/0HcCDkomih89s01PxGHeEc1m8g/y/hJJj4Fbw6egl?=
 =?us-ascii?Q?GONO43XBAJQUMe3dzLp/r+n4hDm921dFH0oh9PHL9bQoiPf89XklvMlxYfIR?=
 =?us-ascii?Q?ycMrZ2xbO0rhtjCmLHQw7IPBX/GittW+Ydn1OKERzKfygvNcpsrs6+1CxHV3?=
 =?us-ascii?Q?1LHwq8CAfF439WF4HjIUNS6WRXcQDM5It5NPte0VEd7rUnQlkQ3xZkrZCfff?=
 =?us-ascii?Q?kmgJs66jBTVoOyV07t7c6kTOg+FygZYDimSMqL4m5jSWn1nc17bvOsl8IBVe?=
 =?us-ascii?Q?N2/qxaQSfJ70N0yVHnTYoieFIX2aoI9j+cp7zhtAGFOxeeh5YieVzHhqUv7X?=
 =?us-ascii?Q?5CoACgxOzb6CbpyrxbcTHq8sXmSzOBreiUMBET9Eyka0KKdXZAC37Z4RvXPb?=
 =?us-ascii?Q?Y4O+/XpNv+vWM0G4mMiZ0GXqXszwgSFF1F0crAs3XZqysBeOi/4UCfLhzZNc?=
 =?us-ascii?Q?syAem2jAwY+61eq4KJnEUmPeLJi4571GWnReXIxNUAmSVg6wpglUq6wIS55b?=
 =?us-ascii?Q?fGujSODVvNQVltGlFLSg4YypHV0QPFi5gwNmut+aWVcVbS4rE2PAEPzhqR6+?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05a9f6a-d9a6-464d-061e-08da956809c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:12:10.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HmFIEkt8w2EL/ciKRr3Khp2GU0aR3zEtnKPXrhCxqh40hKEo3S+Jztxn6K06rrghv+2+IyUxTPumTAXBTZ1y9umdG0gy7u4cm9XDxDqzQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130040
X-Proofpoint-ORIG-GUID: jl_Ju-Lh9yyb7YElQGU1ms9BlRXD8J2K
X-Proofpoint-GUID: jl_Ju-Lh9yyb7YElQGU1ms9BlRXD8J2K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/drivers-md-md-bitmap-check-the-return-value-of-md_bitmap_get_counter/20220909-121143
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
config: m68k-randconfig-m031-20220909
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/md/md-bitmap.c:2211 md_bitmap_resize() error: we previously assumed 'bmc_new' could be null (see line 2198)

vim +/bmc_new +2211 drivers/md/md-bitmap.c

c9d65032282943 drivers/md/bitmap.c    Guoqing Jiang     2016-05-02  2184  			} else
c9d65032282943 drivers/md/bitmap.c    Guoqing Jiang     2016-05-02  2185  				bitmap->counts.bp[page].count += 1;
c9d65032282943 drivers/md/bitmap.c    Guoqing Jiang     2016-05-02  2186  		}
c9d65032282943 drivers/md/bitmap.c    Guoqing Jiang     2016-05-02  2187  	}
c9d65032282943 drivers/md/bitmap.c    Guoqing Jiang     2016-05-02  2188  
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2189  	for (block = 0; block < blocks; ) {
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2190  		bitmap_counter_t *bmc_old, *bmc_new;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2191  		int set;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2192  
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  2193  		bmc_old = md_bitmap_get_counter(&old_counts, block, &old_blocks, 0);
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2194  		set = bmc_old && NEEDED(*bmc_old);
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2195  
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2196  		if (set) {
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  2197  			bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
a0b3a521efba6a drivers/md/md-bitmap.c Li Zhong          2022-09-08 @2198  			if (bmc_new && *bmc_new == 0) {
                                                                                                    ^^^^^^^
New check for NULL

d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2199  				/* need to set on-disk bits too. */
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2200  				sector_t end = block + new_blocks;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2201  				sector_t start = block >> chunkshift;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2202  				start <<= chunkshift;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2203  				while (start < end) {
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  2204  					md_bitmap_file_set_bit(bitmap, block);
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2205  					start += 1 << chunkshift;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2206  				}
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2207  				*bmc_new = 2;
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  2208  				md_bitmap_count_page(&bitmap->counts, block, 1);
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  2209  				md_bitmap_set_pending(&bitmap->counts, block);
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2210  			}
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22 @2211  			*bmc_new |= NEEDED_MASK;
                                                                                                ^^^^^^^^
Unchecked dereference

d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2212  			if (new_blocks < old_blocks)
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2213  				old_blocks = new_blocks;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2214  		}
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2215  		block += old_blocks;
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2216  	}
d60b479d177a57 drivers/md/bitmap.c    NeilBrown         2012-05-22  2217  
0868b99c214a3d drivers/md/md-bitmap.c Zdenek Kabelac    2017-11-08  2218  	if (bitmap->counts.bp != old_counts.bp) {

