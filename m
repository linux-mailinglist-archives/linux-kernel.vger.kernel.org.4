Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8D5E9D91
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiIZJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiIZJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:27:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3943639
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:25:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8lBv2020651;
        Mon, 26 Sep 2022 09:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mnv1WV5DcIyfqzyFMOLGidhCBr8Vy551iBa3jVn9ZS0=;
 b=cN+VeJpsw2xVSlS/z/DNjQjJZujg47k72k9O4sVLchgSUk7UKFHcI+M8tlxQpDy3K3xo
 XT4tVyhlnG5k/tGUPZ4GQY7KUmkySCLtZz82gJ22bixHhlRvVi5bs/QDeDMvRkyirjrw
 QacHsU7iIcenC2h3XrGmLaaFFgJmJjNubZtsXSW7z5yrNbERv0ih3VLynZ5mZKBJ6eEW
 OZR3jDyK7i32iQ+eNUFg+noq2JOAqPQjoR/tUaH+47GXroFgAz1a3Ry5FiF1OzpF6IeA
 WK2krR6K4ifF+9Zd9/dk7BuXdsnUO9oM2fNjQgxUZycqOMGyX3I1ydzKkHMZC2heCluc Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpk2jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:25:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q97Rn9001466;
        Mon, 26 Sep 2022 09:25:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuy9u25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF18bzx2Q/Ta7jI68PcXqOQuuGn6/LLgr0KyEkoWapfdGet23G2CnMvkhYib0jklxWu7pGFFsTEz86UXLAOV53jr2grGC/8xYhbLVNgo2ZXKNdDK4rRxydN6BScfOX8q8jQUJjd92PdxvqIOCMqxdz2LK1OEUG6YGgxs5EZH3UsfzrJNvQRMDddrkwMKX1uKynQ4ffbQRkamugY88kv6rWXElqdt5GCKNa4Pt9kofSXyk+qHdAkez6IYAMW/ONCMTJ3fObyQczbT+3UmnBxdQyoQejBSBvxHBJ/DOLKzTSLs0eF+OxBQbtB1RETwuodetK3Fs5XtKc9JxNP3+jBaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnv1WV5DcIyfqzyFMOLGidhCBr8Vy551iBa3jVn9ZS0=;
 b=LbLypS0FRpQXQRtvTgfZxrEHWUrtiYMsaO3WGr44V5JpbKp8gF0dnDohjJ+iQnkuA/v9Gl4DhazsxVuhiwufeyhDQASph+FwJGUsrYUi0xVvGQdNwy6RrQiBwe39VCi5unQsBBaB/9wU3/3Qu202u/4inAzYwdw0EpkNzX0Zla+VmTh/fZFD3qb2oBOVq1fpPI0X/SrPL8lXItp5jOrOFd1txmJvsuHFVEfVgykWxzp3WAqE+q+2fat3QiNimCzR44wKbkgLMTKWO9/iWR7vOGv33MpVnkzBZaOXZhRtMlqkv78brTkNA4WK03BbiMm0aemRV+1ohKyhUgcTjNHC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnv1WV5DcIyfqzyFMOLGidhCBr8Vy551iBa3jVn9ZS0=;
 b=JVKNfJPO1sixfaHW7vnSRjATtIJXiwkqh0LOrfNqE+f5/S95PXTLJOqeMk9c83J0TStKZjlH64c51Wiv//BOhijaJ9YNca0E2RXYdS/GB5HLVpzJlhkD46Xa5Q/dlsK/SbBPVjeCBMZaX6rmcSuAkhl4GkDUpWejEn6nH97Hs1A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5830.namprd10.prod.outlook.com
 (2603:10b6:510:127::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:25:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:25:09 +0000
Date:   Mon, 26 Sep 2022 12:24:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] staging: rtl8192e: Rename and remove variables in
 rtl819x_HTProc.c
Message-ID: <YzFv6/sbwTN03NEO@kadam>
References: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
X-ClientProxiedBy: MR1P264CA0179.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f63886b-beda-467e-0bbc-08da9fa10112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYA1Kgkk9mFSmuOqViHaj8U3d4J+3L5JlHzzEEVCvf615otGLtWxw+FP3vSKZzBPoYkHwzdktPomUW3JDtmGE0bMdZoEpK2feyCwsh4lLzGP6lU0yHPlE8fX8k5zCXQGCNmbmcdlIwIDl5o+nqu8PMyEGvIU0RMAaUALTK3c59iHa0vU5w0esOQEqULheR72tBlwPqyqVuYblh43sYKmVc7FLPLU02mPkWXTLmfiU9LX7D4cXTc8xv1944ZISIJmJaeGMoabcU+DHIgRy7YVhDFI9x/7crhcFbvFxwMFvAFH4s+UMXtA7a+rjQFEppQTOHJvU8ZEjzsAAOMs0eiuy5hvEFXIgDGCx0o/M1/njlJNWZ12A8cXtnuZQWt5zv/yHDznaMaickzkNfI1hypZMRzccCph+OCW009u3T4Vv4nRnTsAvOjmYOUbhnSunCaCqDBB7ptf43c5scxhRHWg9xm+A+WZxVJeSQa0ZULebtOQfIml3Ie1PljhUXF1/TyIbZlq472IIzjxTJOhsHIZQcuMSBZyFa6ricPOvT7dd6B+3M5ewGF7GAMAYcuSpZdshVwY4PXirAAKDAGKBotDpqrxLX5108PI2DKvcUwoulsmWOlOkVNWf66SfGMC8OePP7Q1q5KQ1AwGTTxeAQz7UAL2hvsuhexB4JLMUTZaB/xnzJCh7tTWRdrEQASlXZGHd6Qwl5oBBGwQ8O/zies4jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(33716001)(2906002)(4326008)(38100700002)(4744005)(86362001)(8936002)(44832011)(66476007)(66946007)(8676002)(66556008)(5660300002)(316002)(41300700001)(6916009)(186003)(26005)(478600001)(6512007)(9686003)(6486002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhkRZKnPvjoD3+QmVkTnt/72sNuD7+1rEj3dNQ5awMgjGvfjOySxjpmwXRg8?=
 =?us-ascii?Q?jsO1ule8X3m3j7KdIZR9+7oY9tFCVSN50+PoqKzBHkOsaXQg7VQay1KtLy59?=
 =?us-ascii?Q?MP5+VmcfTRHIrIzuE3fbEz4B6lja9Ft+/u5RFhNrgWoVJe0Hh+eYowSqLsH7?=
 =?us-ascii?Q?UYjt7l70pPb6wPA1Hn/L/JV8963uluLDWUp9lgMANFkMvjzzIv/wLatfahaa?=
 =?us-ascii?Q?lJoufDxv/xYP3ryfwhbvnCDIG6zJqbwgYGu016Ti23/63UXSMgkk6aHwDqrU?=
 =?us-ascii?Q?8Av+EntPuozy+lgeA7Z+QHdlLD8nDkxPZtyoNu+fc6N6jN4iIeTuqjm8kGH2?=
 =?us-ascii?Q?sWpn9Q9Id4eZbd+T4xwbqOOAj2uHvEZBJUzTYdayXNGqZCWfMU+OTQ1EmMK/?=
 =?us-ascii?Q?AvQ8kxykMLAueL7SMaoWZpkEAmuboKqKC4YGkonBcYnOcL1UWJKe6ETrjy9R?=
 =?us-ascii?Q?qDIdhZT9Waau3lMvl/664fmvbaIaAQ5PxAAjVxCdu4jNjjU+Ym4kVIgV+61t?=
 =?us-ascii?Q?JmYPY/kVlHyHcMoLOu1TYjrj8RO30BxD+cWuCdGdKD5ynRkgelHd3HXssM5x?=
 =?us-ascii?Q?BQYIYWeOOVR502audj8RXz/G10JaFcZRORpIVU4FAXszmm4i9E9m+tZ4rsxt?=
 =?us-ascii?Q?ULCqb+aOh+KEY/SOMCP1OnI070jQVEx37fyVsEDwrvKZMp4WZJD55zqag+uI?=
 =?us-ascii?Q?kHbcz2e5Or++U+Q58txpM9my0q8bT+QD+0phtU4lRZJfaPxTJKB25DvR3xvS?=
 =?us-ascii?Q?Z2QxjKv88TfCfITXfWOIADm0lutB+mNpByNHTildJOTnPzvJs/s15bFxUZQr?=
 =?us-ascii?Q?iQsLf9i8DZHLVkYQLSUSpBK7HkXGAozVbhN7NlXyhGmX5+mHPncEaK4e3GXs?=
 =?us-ascii?Q?drznb1/oo9fpMK4O4hMNBX/zEyiAwCHpf7K6H350W5zdpDxPuuBmKre6l5po?=
 =?us-ascii?Q?lCb1yE3p2eAa2wRaOUtRp5zhBEuGMCHtrR7anRELIF/ISDFAQK8CMLvglZ/c?=
 =?us-ascii?Q?C6wtCcuwAfppOHQb+FhZTcd4mGeWbZeQ4ua73ZsRjxgOofV/YUFTh5O0zbuT?=
 =?us-ascii?Q?CPpQNeDtwtcPTZTVyqW9RF012AoZI98wLqr0QiCCO0NwERvNJq6QgywsqgZO?=
 =?us-ascii?Q?HG6mcw2CUIXX6/J+1nx/2sdZSvCj9E8rAY4fA9yUTIk30lucjYJ6ZV8Ll4ZQ?=
 =?us-ascii?Q?PV6jA6a65Gt7UqB66g9mTjiINnVMnNjnu1XUyvPsOnSDi62OSPpQzVkgUtRF?=
 =?us-ascii?Q?q7Q2Xkxa461cJfnc5We/lvDGwzFqPJhUZz+/faE2cp2he1dwobMC26UdtDPc?=
 =?us-ascii?Q?ieSwVWOguU53XtajjVt3/0SeE+CmVZu84aoCYWhCE2RleD/9CTTkH1d1R5iy?=
 =?us-ascii?Q?CVTTkuTdda5AWBVYTti9bEO3QxaCFD5SYuSiy33/Ru3Vo5gHum25Xpv49HqX?=
 =?us-ascii?Q?AgrNJS+o9JzkjM8GqvjNA0IyvudRTWzho6M5lqVlPONHX9SDJcJnvjy1um/Z?=
 =?us-ascii?Q?f/mbtMqyeqgVOhrua28XtTAyuQXo9dwUK38d/a3yw+4hOomr89LQGLuJ20C6?=
 =?us-ascii?Q?lrCK0JRfgjjzjeH6Yq131zbarUMn7tiEg9FNv/OJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f63886b-beda-467e-0bbc-08da9fa10112
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:25:09.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPhV/+STE0Ur/iNf4FH4d/+W48kNL0jHNogHtDZrsSNSNb8zqykIvO/YUhsVsyX03fwwd27C2RUGDVEUnxF/yI8j3oApmHiDFI4aUwUsTuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260059
X-Proofpoint-ORIG-GUID: LSot0IwdRzp-LgL7kKl8cWGPtTxCIn2U
X-Proofpoint-GUID: LSot0IwdRzp-LgL7kKl8cWGPtTxCIn2U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 12:02:50AM +0200, Philipp Hortmann wrote:
> Rename and remove variables to avoid CamelCase which is not accepted by
> checkpatch.
> 
> Tested with rtl8192e
> Transferred this patch over wlan connection of rtl8192e
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

