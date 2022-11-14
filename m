Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C73762752A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiKNEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiKNEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:06:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1425F1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:06:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE2poOl023228;
        Mon, 14 Nov 2022 04:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QJd8Znxp4Kj+oS6KChK3E5r/UvVvKmGR8rlXd68uhMc=;
 b=IxcqoBOVOXx7F+Lou+YttZeCHbdWpBSnNzKXGurxfws3352Re1jzHT+8vxs7BqnFUznE
 yr7FHpKLRelkWDiW6rYqa8/w7nF+2MO/IKVw2OgVpwI5RhRAci/HzfADRb0KhlQMwbTy
 muZUIZS+yYprZlSxVA2ajTlrYUuuX/GwoW0d7TChwaYko8d4u2qgTff6a221oDBxzqAt
 NtTggZTeuO6pDhgqNNBpi2ar+S+Flmt1QYyCnJ4U8LV3+zC24Wxmo178rtmLlTmk1Vf6
 pHN1UGDFLljy9jD+YHvLtkfZ8LUDPiBtRxCpzun+A937fFPLJyZRebCMdKuUyXhbW2zQ 1g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1t3gp67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 04:06:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AE11o0K020950;
        Mon, 14 Nov 2022 04:06:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9uwgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 04:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILBSRrzX2bixc3Y7NBvw0pp48Ije80vk99WV5bhH1bRFwNIsjwZ1xjHZPS0JdSVL+iyObZg6IcVvUw4TyNvbP22fK89tYt5lUEsRZhMxk9h2NpsWh8/mGdOyW2F5CHshUHanPbG7dxgoIoyQVE9Z1CJ7auIOa68zYh2FS8T44qn3T3eDyFm/W0dtyrVzWklvqIF8WTo0c47wyF1dGcU5CAH7hrjFlrU1x3sIM3xGYaTA7ajxmD7Rp8IAK9tw7B4+wkD72i9LwunDrtxJax6kfj0cVRkHp3rmd9Rn9xqjLO3xjf8cP8CCJVShTx7Dgaa4UJWJBmJ+N61dBG7boiz58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJd8Znxp4Kj+oS6KChK3E5r/UvVvKmGR8rlXd68uhMc=;
 b=a3uDo/Waav6JYterK74O/9OdMRsmZhw6TT9mZUx1FhZhm7JTMpS8jZ+GDvbev4hXrK0c7KwTk9LRDRzAqCeGQIv2oJ1M8jtjavl4SdfYM9XTyjUcOmHNaR9JkNRQ98QcqtKTQSJHiV6mPpbT7JyrmzpCsrQTaxd/orxIoE/j/HLLI4lmoIMAesCO7PGnA+eBe5a0fd0w1I1WgdiXVbx3tRVYsT2DemVK2qSdBorNtSTno02Paa6wDSZG+/sZuAgS/zAf36C9slSUAiWJcl3EElz7WkO9YmLQvz9gVdz1z/d79ZiV6FhKwoZ/bPPAJ0pwNU8SZsEf0f65c/muBMrh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJd8Znxp4Kj+oS6KChK3E5r/UvVvKmGR8rlXd68uhMc=;
 b=Un+iiesWBnK/yStfZgShvhoEheDMz+5J6r3iub9jyFqWOljPTqL5EY8TzJRRk5gjx6kt1IaLZdIiJDoaESeioNU+iqAhcVQfUqPf3LGihrK3mMU8EjiQjh67endjD6etB9aLXgRNQf30d6sab7s2Khqqe9a5LSpkWkqyz7TjChw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 04:06:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 04:06:22 +0000
Date:   Sun, 13 Nov 2022 20:06:18 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] general protection fault in shm_close
Message-ID: <Y3G+usbwwX4DyaOW@monkey>
References: <000000000000c4bef605ed65992d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c4bef605ed65992d@google.com>
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaaca48-9c60-4e7f-b5aa-08dac5f5966d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0L/701XGoUcz0WVwcoCgzqBXzoccI+bpzj3rQZNoCkPrSqBxBmmWZX9WkgJOgSPgj8rjsCNrbypiIFPpkhgPOUq1o/3J8pxCA78sBi9E0uqduCoRIFAPGIsx0rCxTQnzGmUtFfwuKAkN7e7vlfd9qkCIavDNJQW/k5ls1YDUoM+Wrm424TNlbaw4tuV+HKNr9ore0GLG28sXmhgGTFwdD4pzTXi1L5KJH8ze/o0Ssh0dfjzeSrg51qq68yTpyttrsdN8YWLz2ESGU3GGifkw9km+qdkZKO9l1obwF/0Lh7sn/MwohTqUE4xRLqSxFlWXnFlOwkcytIzuEqRSPfJ5qchlXcf0Cibcr64E8arQ+BUxAtpcPZ3bP8WMFQS/dT9IMg/JdwZIDQVwx3MywD9qVRUFjJdlGoHbRFY1NIFWd4L1ISimHXvyKUrREOulijauJ9TKPFRhY1td1G/4OCApYCvGHDY8sTxCfqKH480vIDhTAYtQD9U0U4KVtRJA7uh0pqi7gW2QbneDNFcNNe/LF5TakBy75Ii/0FDrIMktxAaBewytRoVUlwJqI5Cqm/xY6YJyW5nPVLNF3TSYSbNbJb4zqY+8FXrQv9Y9ULPy3bN+QHxkQ6EugOO0OGb/Q0183Lgc76NrYyKVTM/fF8OPtzLzmaCO7pOLNd1Fq9YFwJA2M1Sljzh1ZRbruGb/nBxP0SZqSh5rrFYgAOS3oIoBe2M50wvmmzsmPhSBmkdBAuayQY8q9yNpQAAnOTB8UIjGMcatW7O3xo/Zqni6xcvpiq5gIWD1PLWxCdpXe9cQ7mKrxvsUun8m0Yf4og9g975wNKDiQbNesG4mSXw6eCR5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(83380400001)(33716001)(86362001)(38100700002)(478600001)(8936002)(966005)(5660300002)(6486002)(6666004)(8676002)(41300700001)(66946007)(66556008)(66476007)(4326008)(316002)(186003)(45080400002)(2906002)(9686003)(6506007)(6512007)(53546011)(44832011)(26005)(99710200001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3o5z0FESgRL2iF4N/yWI4mOfNp2nVlEF7gvipxcwMiIX0asIGpFzywnywG3?=
 =?us-ascii?Q?+yYdrQswh6cZQs9RM9A6iQteKCD3z1/aI2ikq+prPll1xGXvkmETnx2s6mvZ?=
 =?us-ascii?Q?BgVpCHwWctxRslYki0gsPjgJnAu8f6iJdAFKh5pDgi2jVCpTv8HRtt7oyYFC?=
 =?us-ascii?Q?F5ml2fh4bD3hIpCHLq0Pw/ZQoBC2nkiEr0US0vX5T1k4v5HhBZgsyT4Xl9kh?=
 =?us-ascii?Q?oR7v9Z05Ga0W0qg64puGr7X7OE+/DM+TmCMOC5VMiHFmvTj3HaiRip8gZmc8?=
 =?us-ascii?Q?UI6JcYiLJbz6klIIvC4PkPXYIKCNxoF6xG2+Tg9Y+fid3HewJ9mYeFkRg+1E?=
 =?us-ascii?Q?Lf8xUCdxnelJz6DxbCW/ZhJXfbaF9GqAfnVfxqosRvbG52l49wl62IuvDfOU?=
 =?us-ascii?Q?1GY6srmj3VVGECoP7ZqPeOZ5wLbcuDl7AK5rYcSNWKqyvRL8wmPdSd6NkHHZ?=
 =?us-ascii?Q?sSI/LjMXiJqbm64b4Ig1i6xAstAwA0hBgl9L6BZ36eEPFxiq0rYNzbGD2lIj?=
 =?us-ascii?Q?no7X18n1z2Dl30f/z64ThzSSrfJeN/2v/ZHahV9fPW3HbK0Ai5P8zcn4sGX6?=
 =?us-ascii?Q?y6TGAAk6yZhRSpSG4b5Bo+zNDPLs71kHRcmZUQ1uaEDQJeP7TnBZsSwSCoRK?=
 =?us-ascii?Q?b1cCS1sqT+dfZF35/d8EYfxwnrFJlAuwivZoo+JQdg5ro2vW2TeHbYO1x863?=
 =?us-ascii?Q?EqgHKMTASCrnn8BacCsMyNo51vB7uMcnbO7Zghya+EC6dr/mJKcs6FND/VRG?=
 =?us-ascii?Q?AqfHIe9HrGRi6XYeNPpjXG6OG5IwpWkvpCUm78tBtkvHqbFfOlDDPdcFoI4W?=
 =?us-ascii?Q?4FPleQTU5Dtn/BzS+aGJrKEJ32Vr76Sx7IpSLmvkp+5lPb/Qelgiw98aSTbs?=
 =?us-ascii?Q?OzXqKLYmj6sliHgWtYTk3mSw6ROFaJLebkW6Jm7rQZdPikH9/yfepXPysjah?=
 =?us-ascii?Q?x64Vjtqgz8RCkKyHEzaG1olvLb+NNrvnfgRyF0FqRM7SrvHfgM+SfmwvKU3q?=
 =?us-ascii?Q?2Oeb/V64qykKoae5NO+ihfS+Htw8l6QaFlSaNgK6mROuI02x915G8MgkAheS?=
 =?us-ascii?Q?2kkgMXGSTeL9W0ZVUxDMWtQApI2Fr+xa7hECsPx3OgoB4eU1eXDISAcl4P3g?=
 =?us-ascii?Q?zD/fFfnbHxPGQbHLQaB7Uf4GfvHk3AGLHTEW9LP4tl2nnyP6eZKw88IZ6g1w?=
 =?us-ascii?Q?0axehX9RXS6D0rwhp8kp9QoJYMEQzzM/r5LtPOE5taLCtEP9SCJn9+iJ9Ol9?=
 =?us-ascii?Q?NadFs4MoVqUYwRtjmihmB4BdqDojlMzU1duNSwTNIabhxzuGQdOUwL6h8JdP?=
 =?us-ascii?Q?Chg/kV7IkOp/VZZq4+HZedriB55Q9R+7DDotvRVtRzmPNYYw2RjR+rGT4nr4?=
 =?us-ascii?Q?RYDmXrmoXDy4tUiAZQ7Z2MnJf5LZicmhHUW0mxeBr22KmleyCd9h+WVfOrIB?=
 =?us-ascii?Q?EHrfDf5ZbV9k1AqmKeqV2Bgs9xSudpIA2MvkolAi3Xeww+NYr0SCi4R1Lwlt?=
 =?us-ascii?Q?u9bDHL3Ru67nHTsphmBfe55EkH89moMlJPNyHfXgcBX5Y//CUKPKWLgXbM0K?=
 =?us-ascii?Q?NPeUIG8T6in6wbDqrgVjtgEmiP4IhXgIDEINAcWfMOozHOtXVzB+4XcDuCLY?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?F4gSexK3fbIMDigTR7zOElGnj9ei7GUKd5xjNCORpWh0L0huuGp1lRWj4pg6?=
 =?us-ascii?Q?3B/kl/c7pVMckW0Acc24znNp70FoAWdwli1yx08dS5zIofjjjAM20LunyKXs?=
 =?us-ascii?Q?sRI36DJTwkiZSMhzDvbh5bLNrGL44s+ROtPKz04NaCXXCurXS6XPOvoB9M8t?=
 =?us-ascii?Q?65R5C9n4O9I9YjRJvotcNqgD1Dm1ZWsx+7hJ/O4tXWmGzMwJFszdEcay494z?=
 =?us-ascii?Q?iPW8zo3PrUpMmqbusI1/DU3e63XnzAcEw157jm2oTUxKjj+iQmNiUOJ8OPAS?=
 =?us-ascii?Q?345va+rPqV4zIa7acoQ7Udm16bTVFo/HNDwEd2GB7wvSnTgw4dnxn7zxj6r3?=
 =?us-ascii?Q?4+safRd+8XT/OKlz4Lo46Ui+JpleDHG5a69HKEPNP9P7vWqC8HV7SXCvH6D6?=
 =?us-ascii?Q?Pq3kylvxIwbHTRUQUXLUikaduu1VFiS/W+60e57d2+X6bDR9rkcgJrqXnvHr?=
 =?us-ascii?Q?hc+6ymbi0W08BYeaZ62SUmoRPzT0Dvba79ecq9kA8JACFosKkbfRmvqZIGLg?=
 =?us-ascii?Q?++WXu1v0TsRCcJX9Q6VFgmkWF0zSeCuVXu5k1issg+1cOciubJuwveOaSquQ?=
 =?us-ascii?Q?khOxPtNpFFjw5nwot1KlKOhFql+yBkswgCF9ym+mtEMAnlSIUvl44ih2Eri4?=
 =?us-ascii?Q?wJ/2yBqSH8j0TQotCERa+3BJOHHTfa/VSWiW/+KEKV+3bdJxXopn9jXgGy52?=
 =?us-ascii?Q?2NIJ1qaDbK99EIB5eYMiUFPAK0CUKyYuIfDdLzz0TtfUwOTu9DnnhFbCo5FB?=
 =?us-ascii?Q?ULKchCipotj4VJt6ynwvihhZFc1Vkt8vdPvsmMmvlmkoHkASx0l7Vqxyxf52?=
 =?us-ascii?Q?bh8zjXmsqyvG8Q+rNnVjJI4SnA2QW06pTCgGwF8xN1l5l5XVhzKya61vbogx?=
 =?us-ascii?Q?wPLK5cqZ3yLg9S1bA4P0a4wR96dWoS/v93NuIexy02pyfU5T3HmNXE6uSASi?=
 =?us-ascii?Q?RU/0JaoRf4qjZwB5nCbUQHhx9rp+6l22yjks5n3lWohQh2XQWLznuSex4bvx?=
 =?us-ascii?Q?S3YmLahUpTqC5IMS7D4/yGS2jcXkZUnXyF4Mhsh9U4RfOck=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaaca48-9c60-4e7f-b5aa-08dac5f5966d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 04:06:22.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NGn6BN82isor06wwhImw4GfGe7XQw1GKh7hYV/jmPDY/xk6XqoZMUvBieP1oDjLLwXNlnxE3bI7Mdd5vk4EHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_03,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140028
X-Proofpoint-ORIG-GUID: Dczj-txplkXZt9rcbsAz6ZZSj7csGk5P
X-Proofpoint-GUID: Dczj-txplkXZt9rcbsAz6ZZSj7csGk5P
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 19:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f8f60f322f06 Add linux-next specific files for 20221111
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15599bd5880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
> dashboard link: https://syzkaller.appspot.com/bug?extid=83b4134621b7c326d950
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a05e71880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11de4db9880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6008df424195/disk-f8f60f32.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/394340525f66/vmlinux-f8f60f32.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b13604a3343a/bzImage-f8f60f32.xz
> 
> The issue was bisected to:
> 
> commit 6a892ddb84e542931554f4ee9a528190003b23a0
> Author: Mike Kravetz <mike.kravetz@oracle.com>
> Date:   Thu Nov 10 00:21:50 2022 +0000
> 
>     ipc/shm: call underlying open/close vm_ops
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a0f199880000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a0f199880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a0f199880000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com
> Fixes: 6a892ddb84e5 ("ipc/shm: call underlying open/close vm_ops")
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 5247 Comm: syz-executor310 Not tainted 6.1.0-rc4-next-20221111-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:shm_close+0xbf/0x740 ipc/shm.c:378
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 18 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 05 00 00 48 8b 5b 08 48 85 db 74 0a e8 99 7c
> RSP: 0018:ffffc90003e0fba0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff83bf5016 RDI: 0000000000000008
> RBP: ffff8880296a2d40 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000000000000 R12: ffff8880263fb1c0
> R13: ffffffff8c7a97a0 R14: 0000000000000008 R15: ffffc90003e0fca0
> FS:  0000555555992300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fde9cc15348 CR3: 0000000025865000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  shm_mmap+0x1c2/0x230 ipc/shm.c:604

shm_mmap has this code block:

	ret = __shm_open(vma);
	if (ret)
		return ret;

	ret = call_mmap(sfd->file, vma);
	if (ret) {
		shm_close(vma);
		return ret;
	}
	sfd->vm_ops = vma->vm_ops;

In the case of call_mmap error, it calls shm_close BEFORE setting up
sfd->vm_ops.  So, shm_close is going to have problems when doing:

	if (sfd->vm_ops->close)
		sfd->vm_ops->close(vma);

I will put together a fix tomorrow and take a closer look at all the
error paths.
-- 
Mike Kravetz

>  call_mmap include/linux/fs.h:2164 [inline]
>  mmap_region+0x6bf/0x1dc0 mm/mmap.c:2625
>  do_mmap+0x825/0xf50 mm/mmap.c:1412
>  do_shmat+0xe33/0x10c0 ipc/shm.c:1661
>  __do_sys_shmat ipc/shm.c:1697 [inline]
>  __se_sys_shmat ipc/shm.c:1692 [inline]
>  __x64_sys_shmat+0xcc/0x160 ipc/shm.c:1692
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fde9cba2cf9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff3ed491f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001e
> RAX: ffffffffffffffda RBX: 000000000000cfd6 RCX: 00007fde9cba2cf9
> RDX: ffffffffffffcfff RSI: 0000000020000000 RDI: 0000000000000008
> RBP: 0000000000000000 R08: 00007fff3ed49398 R09: 00007fff3ed49398
> R10: 00007fff3ed48c70 R11: 0000000000000246 R12: 00007fff3ed4920c
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:shm_close+0xbf/0x740 ipc/shm.c:378
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 18 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 05 00 00 48 8b 5b 08 48 85 db 74 0a e8 99 7c
> RSP: 0018:ffffc90003e0fba0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff83bf5016 RDI: 0000000000000008
> RBP: ffff8880296a2d40 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000000000000 R12: ffff8880263fb1c0
> R13: ffffffff8c7a97a0 R14: 0000000000000008 R15: ffffc90003e0fca0
> FS:  0000555555992300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff3ed491d8 CR3: 0000000025865000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	48 89 fa             	mov    %rdi,%rdx
>    3:	48 c1 ea 03          	shr    $0x3,%rdx
>    7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    b:	0f 85 1c 06 00 00    	jne    0x62d
>   11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   18:	fc ff df
>   1b:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
>   1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:	0f 85 db 05 00 00    	jne    0x60f
>   34:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
>   38:	48 85 db             	test   %rbx,%rbx
>   3b:	74 0a                	je     0x47
>   3d:	e8                   	.byte 0xe8
>   3e:	99                   	cltd
>   3f:	7c                   	.byte 0x7c
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
