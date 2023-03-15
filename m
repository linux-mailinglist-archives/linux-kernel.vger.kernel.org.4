Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E506BBDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjCOTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjCOTyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:54:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810713C1F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:54:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FJmwhK023127;
        Wed, 15 Mar 2023 19:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ttLo3qBWzYHyICASbyNGeo5X7hsuibItXtin+QCa7no=;
 b=PMB+a2n8/tLjlaYAR2x5C+NSE0HjoElNQYOq5wIeG5G6uEjNqpTNggPkTi1iqaQFkfYx
 W5kZliufGKTk62XJr1eyw+TlPmZypEswN8EeAvRlW6Wtdp84dpG8/uZy0BS1vi6Q1VTZ
 O9YWKnIXvnb2tNuNONB9VEKU1g6DOkT+aTMsIZeqDK3KWajVmNKY8s8wryQisMSbuubz
 qXLdqORzYFnaUrJXUstb/N+tKLMrjsJUKpX/nCLqo4aFpY6Ph/17K8UlcMq5VvPYmxHP
 DjgxAOvJGoDB9dLgGkJ8IYVNeRIo+hP81WYiDY3EsRq9VWlE2+KNlP7hIlxk4AvMW76F +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pb2btaakh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 19:53:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32FIqVGh036167;
        Wed, 15 Mar 2023 19:53:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pb2c0vby3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 19:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAvf8cOk+/5ZB5HhFKE40DYBpvUfGxnchkK4x7AXDcwrO6ZoM9zq8eCNMgWmJOw7u07W0s+PWVFEQRplryhQUBl7llcp9Y63XZMIxHZIegaKKlbW3TUVSuMqvvV9lDSoy59UoNGTY4QabFbDMcVJm8iYOMDsRlBbPQjFtd6OuTUatpNxmgYj+7LhbDDSM26ULqF9gRWTqV9Pi2wPq2c7TTOKQkd+29qEphSldqKMBGOhjs2E2k7JvRZrQXdcAKECsA++GXqiUN6go754VSE5gxEuR1coRpeDoMJCpxXZvskOOdA/mWDP/4SdDct5TdxT6dS6G5OOYOjDTcfnfzqBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttLo3qBWzYHyICASbyNGeo5X7hsuibItXtin+QCa7no=;
 b=X9oQtCIgfNoyUvGkjtC/oYd+vNC1EXQWejn+fltDDtbDYcupkRnxkFXRT1ZtH473Hc5NJ6Y9NfY2TEo8FI98pVRE5joltfjv4w+SZqoUqr838p2Q1VfKHkulTl9W+Yr3popH4qY8fK/efgqyVrWSMlIqx4T4xc7Rmc2HhtzHNuENPbfNqDdo/6z9KaPDBPphLdPfKjKDgwuvST26eapsz1dhQ11oD6ODb2EQN7GsRq8K+Q4nuHDi8uCBBc6drA6W3jBkEjT6qVOKm+i5R5pNH9fiQ4HWbUI8j7MArQTTAx3pNpsWllg7p1U5wzQyk5gUI8zQ7uZd96V2lv5fRAhDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttLo3qBWzYHyICASbyNGeo5X7hsuibItXtin+QCa7no=;
 b=SPHMIPRBTJFReb5vfaP57vYDtA4Kms3T6gBHG6qD3ux39CM6uoZ+sp/LEpFJwyiyK7qDEj2N9IunWaL3+ee+8D5CiIlaE0qurhr9p1EBolYQIN0F2kko58l2tdzzxZpZLWbn8/oKkvqNDCFOTZJ3Co/XVj4mAP7pVMYJMOUkO6s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 19:53:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 19:53:31 +0000
Date:   Wed, 15 Mar 2023 12:53:28 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        vishal.moola@gmail.com, sidhartha.kumar@oracle.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 2/3] userfaultfd: convert __mcopy_atomic_hugetlb() to
 use a folio
Message-ID: <20230315195328.GA3092@monkey>
References: <20230314131350.924377-1-zhangpeng362@huawei.com>
 <20230314131350.924377-3-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314131350.924377-3-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW3PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:303:2a::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2fd2aa-777b-4a60-5a42-08db258ef39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuMTvVWtbI6wnO1hF6QrUhasKLTWn2bPRWA+Jf53JAhkTWSj+c21SuPrqpcYTHWaUfE6NiyWHgo4NJGfIBkJ/IT1oqor1zhWR2zzDtSPlEIQmXQUDXiMsM+oUnWKc5JyHNNgZy/nQwSGxbzw4zXIx3sxQ9NVLZepB1c8RlFAfG6LPcwGiBBflYd2v011kjda0H0PNy4Jp4udDeuY3whG56NEBN2kycXkflME3Qi/fke21pKkrI8DjUOFkSmq2fqhEysuGFvOgw0E85tyMyytm1M01jAr+ZHvDvRvNlwEcz3duovqGrUKn9cpAYJbE+KXSbUewCPYNjthLcOKDP86clDU+8MzuqQlxqbS77tOEviZRt3z3rMj6CiyYWiJ8VVfGylGlG0p/lHuTJVcSq58/2F3hEqaf1hcubWN9b2mGrnE5H013NtqMDryWqNw64WLPAxFqyh8rLCdNvwi5vJHCz/FDKcdTRzRyfVeMhwnNP6K30Um3lJa95R+Lp2+w/oDNy7JS9taObpeDt3/O/GjjjimrSBY7lWyuesOlTsC+sgPUY9Qw1W6NAmTacjqADq65g8uo97q6Zkk1FZyz6oKSTlq3iRCdjTIJCwaoeeCLDgcPHtNjZ9XNiuFzqYuRDjyj1H6tB0Z0aGBwxkx0uPQIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(33656002)(478600001)(6486002)(26005)(53546011)(1076003)(186003)(6666004)(316002)(6506007)(6512007)(9686003)(38100700002)(41300700001)(4744005)(5660300002)(86362001)(8936002)(44832011)(83380400001)(2906002)(33716001)(66476007)(66946007)(66556008)(4326008)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6utYhRx2gExjhlFcIvDMuUQb4zJKLhoqQVVD7ikSwk9hLy2wlaGz00YYI98?=
 =?us-ascii?Q?HYwiAQegDKmWSnEOqohANFa5CyHRY0WZNLpDM21eFzwNnALzizA/ALeH+E4n?=
 =?us-ascii?Q?lJGSgh7uq9W9fuKroWszOUjKJLbvJfzAmgkShrF/OeQFoccESPzE0J3MaST5?=
 =?us-ascii?Q?4OlP8ZyBjezvtqhPHlfCh8jOGmOlvra8U0dBejalXoRXvq++BEiyPAHhj4sG?=
 =?us-ascii?Q?YwODbg+VHqxoSi+hOtJrgMT/ZdQAYs4E7I10uL2W4ZKkiXvznmGVWZlfzSKY?=
 =?us-ascii?Q?MkpC4lxR21sUBn5R2SKu929ICeoXxZnKs+yAaVeujYnW7eVZhYBUC3IQhXVw?=
 =?us-ascii?Q?1usTYF/x7HNtzXgWoH2finAcdsfhk0Pe47Arh72X0hJeV5aA647oz7ymzicx?=
 =?us-ascii?Q?mCiMyS3CkFQ6f7FUfl5hsLDgzYerC7bHaEM3EGkz8guxyFekqMoaqPHINyuQ?=
 =?us-ascii?Q?6WeORruKnrBvUIm0OJcYztUrmlY6KEUPCExvjEKFm2dyNOxfRlKcI3JAw1ak?=
 =?us-ascii?Q?tRtIFIqeRGI/sH70mzqLom5TQ/D9W/TdFxcbQt498PXl29a2Pu/G3EDb44qh?=
 =?us-ascii?Q?LgeBOmT66Umm0RgWU0CtxaWXuk6/ZUBNitwAIEAyUigY2SYOms2Z/6Zr2o23?=
 =?us-ascii?Q?745qLhwh5+hlm6uUedBlrQy/cRa9kBjtScvLsOFHZ4ygI4ZNShvmCXS1PJk6?=
 =?us-ascii?Q?/RvSBVLQJPD8URCwy2NBdDq9KGc7ZgAnTGkqRWJSqe+rYw3OKeeMMxKkhi9w?=
 =?us-ascii?Q?5MkH3zcT4XwlLBJ5TVxCEY7lYoSeDAWj7UIWiZ9H0l+myda1R/nmKxwl0jy4?=
 =?us-ascii?Q?CVZO/nY638BejFvGXnOVqLF/f1KKbiL8BveABKugxYqGVICYnAxszIgkCAB/?=
 =?us-ascii?Q?nT4QnlQ5JJ0J6PgCA6KcKMEMMgXPi/pVgDsTp/dTnLgbxr7I+Es0KLlshOLf?=
 =?us-ascii?Q?lsBOBI62kJZyObhJ1ASEsDnSkCZ8U03RXWguJZ5qc9AwAeafXPSbw23MuN4a?=
 =?us-ascii?Q?yOzadGKc90Y/BKSl5j2EPYqbmojWQNpycDc/4SJTFsCxaz9KID/Nfpry3CqY?=
 =?us-ascii?Q?38ONSDOjzB3+AxueQYUivb9YtLsCC1KgfaghcaKGSWQ/aGA6sTLMv37qksy0?=
 =?us-ascii?Q?azPikSK19qo8gMTdbeJqWuFHf4Ok3l+MvLY6P/V8xQ4y+I7/kFeiCQ+ClLHT?=
 =?us-ascii?Q?Ib1kaNQSxdVaQrA2TX1VYZrTpWckE8mB2UhDnISlmKaBS8Pvbdq7RsExcuvv?=
 =?us-ascii?Q?wOe9CSt8a5drKNPBUX743spAg1lzLGJIAucEq9DO3TJySOhZ82haegm9OZqx?=
 =?us-ascii?Q?jvyq4yy7VbeQQcLrmjK0/FPP5TQfHtUvH+YEEROtCctMCPiEH2BGDO6+cXTk?=
 =?us-ascii?Q?NxeBVBcpoMPbRlVGIUs9CO+iNIbieAwSVy18vJE/WYuEoHdeyGTDzfeSIzr0?=
 =?us-ascii?Q?hPxL9viZ25TYNBHHGxmELCpNPhholeZRky4t+j6N6OYaSMaE71Z1bIXHfRtz?=
 =?us-ascii?Q?KUR/+mYLPgeMV3PyPgd3tNq1BoavwqkJ+qLHNQs9ndP94LbFaQ+66zQfhuk4?=
 =?us-ascii?Q?+GxguER+2TfNvWICa1IpXPRYHVSE44/owrV6IImpROYndcQP1IvznScDo2zW?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oLVLitMpjNceJLnbql4qlZqUc9+EBFQnFW1qXjn+vfbw0BLZBMqFHW4ZyjlY?=
 =?us-ascii?Q?gu4HsACWd+KeS32TpZJpTJ0fo75wqF99AWur/cKRuVnlknmPWgChIx6wNxaG?=
 =?us-ascii?Q?yQcM73vqzDR5W/GECBSP/F13dw7lewb4t1FQ84gziCvEJZPTwnCgEq9YxKEI?=
 =?us-ascii?Q?Cjoe6b9wDN0nUhdTvNTjra+w+cc8+RUp2oRJEyFvsEbOnSweYqJX1pJ5zQfw?=
 =?us-ascii?Q?mtU+PSto4mLbLHD4zy+CQYrpVaK2UFDCcOd52KnUw86Yl1vSGabHWQtEAVCB?=
 =?us-ascii?Q?C51fsia+rclAC4dX8rQKmhIYitQUOH1ta9t8obRRFtESX8uU7VcRsj0ScHQ7?=
 =?us-ascii?Q?wjrppbbSh79S3ol5dXaJJrREfka5UlMKb76k6FCZb8dpQAPauxNUXwZQNgot?=
 =?us-ascii?Q?pXtPVuCgf9i1VzL079UHwoptdsxkcyTcGJeNpZxSeGTky1X0Ukkd7t4AHcZs?=
 =?us-ascii?Q?yq3Ts/8YQLl6cHN3zOyisDIM43YZwr3a+KHaFIV9Dbx6w50PEyGGmxf8GtmT?=
 =?us-ascii?Q?oOFGOolcH4eQWiteYud0JimLYdBGK6Y1deeARMIRhYMem5KIDwsb6Sj2FIGr?=
 =?us-ascii?Q?3gfiuKkfjXTTzVYMY82k1z/qCu6mzZudew2w6m3KYnk69puGs3dLZd/+0ufl?=
 =?us-ascii?Q?gJo5sR5aLEx6TM2r/lJcKM8oE2ThlTwpTau9doiF2cWsU4fU+SbUBHqigZjd?=
 =?us-ascii?Q?NsGrmSO25w/yAy4t2+OwG/dwR+NRBLFqZFYp3mw05rtGUn3hUGrRuFjshnb6?=
 =?us-ascii?Q?fPy1/AsJswR62T6fhi/shPauUU+s3UoXFs0h19iPTTIC/jVeCATWiL2uwPde?=
 =?us-ascii?Q?5KMfyZ3lpZyO1I8ZWFOA5RiSn6v91trlumCV/WXaMV9tDtNUib4f7dKIDkh2?=
 =?us-ascii?Q?nmm8Ri5Ng5m0KvIpszOw+OiMWKVVcp6OMgDbX1rDuUSu9rHW4Fe5dtoWhdWf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2fd2aa-777b-4a60-5a42-08db258ef39f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 19:53:31.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANLpLS6AsGFrF0Wqe0uH/2nZp8lCihpmCRfJ7l4YsmK+WcXU2vNMVqayG1aFePu/Zn4jGbTTxz1/ZFTXpammNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=676 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150166
X-Proofpoint-ORIG-GUID: Ld2ojbms7Lq0c_W5qaz2Hg3XBogf6g6P
X-Proofpoint-GUID: Ld2ojbms7Lq0c_W5qaz2Hg3XBogf6g6P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/23 13:13, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Change copy_huge_page_from_user() to copy_folio_from_user().

Any reason why you did not change copy_user_huge_page to folios as
well?  All callers are passing &folio->page.

Just my opinion, but it might be better/easier to review if the copy
routines were done in a separate patch.  There is a little more than
folio conversion happening there.

-- 
Mike Kravetz

> Convert hugetlb_mcopy_atomic_pte() and __mcopy_atomic_hugetlb() to use a
> folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  include/linux/hugetlb.h |  4 ++--
>  include/linux/mm.h      |  3 +--
>  mm/hugetlb.c            | 25 ++++++++++++-------------
>  mm/memory.c             | 27 ++++++++++++---------------
>  mm/userfaultfd.c        | 20 +++++++++-----------
>  5 files changed, 36 insertions(+), 43 deletions(-)
