Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE52639391
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKZDJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKZDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:09:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C84047A;
        Fri, 25 Nov 2022 19:09:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ1vdjE020171;
        Sat, 26 Nov 2022 03:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=EiBXQb1itwOKp8oPpoOHlR87knhQO+sXLbzwTj0iWpk=;
 b=R4jZzR3SXkH7J2y1lTeZiXULAQdUxXetobdBNefo2tqdCpspmV4Yeqno8uqxmItwaOZu
 D6aTnnHG7U1NzYAcREId6DMk88XDuDazAGQxhU8PpYcmVodkr4MDWBAF+eOPJyawjwU+
 xESnAfKaVlHSExdJUcDpxNq6fFACf3hrTswICEAvWgpluYaXVUUSBSzrV4G4wKNeJmHN
 axICY9BpCwXIpaHiqSWrY76N2vZwyX15AiowSuyOI5PLEpRuH1KjadHbpsV5TmiMsZwu
 b48EafKxrIBOtmnNoSumZ6uYyvNf2x9TIjzSfRRlqR45KtW10XNjxkg6MAVO4ZFcbv0Q Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2g1bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:08:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XDSu000588;
        Sat, 26 Nov 2022 03:08:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3981thv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KItYOrW1Y3p+xvkiFHx8kKAFN0VDDVbw6eVmWwrUXldj2plLNwCuzSR4+dz5qR/jBgBI1opJjnZQCy2435baUXP1N/7VhzdYncuMsODqrmjCHX3U/ibEtwgluj/b6TlZdNOKihTMhQ2HnadHPonbVnaDOod1gU7+JYXFqL33UknH6HCzq3z0jRqIkx/UrEn/iBCwknzUhW9ptA+kdLjRlD3OXMdXAIezMDKp1y0w071QnFqXAC7HS3/bTC0AdL+iPYbBciolN/SJPxE9AP4qXCx99fFVVZweXcRyRdD5HWAsovcoW5T3lGhun3nMyy4JW5eRjX4S7paXXOXQOp5WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiBXQb1itwOKp8oPpoOHlR87knhQO+sXLbzwTj0iWpk=;
 b=jBRa06EntELb9W47a1LJyKvWgr7Ml52sdXT//jKs/4xxIdoHAGPjMRPh+FIFyXh2BrlyXDyralISlykGRD3jMNkXlykV5YIiSZHHzg5TXF45bWKiqktrw4ud/py4Ci3s0IeCwb2xcGV6JLnW7EVd1hxJ1u7/+grhR/vX1FjGRR0YBJltH7h+MHPpuxrZg2zl6XKAu3od315QcfmL9b3kzfq+lLfvyrAy4YWUgNAC+i3I7CvpNEll0IoWkESUegcTQl+7ALK/rDlYzeqirCOYvCxp8MnCRJqeZEFgR3xxv93kpUq+tnOIZbPi3vjF/nzGelQ/GmusGQuf8UbdlorIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiBXQb1itwOKp8oPpoOHlR87knhQO+sXLbzwTj0iWpk=;
 b=Iz/S94EMpVmeSYgaBGzwacgPZemovT6FNo6UeRk8Wu8Ow3zyqr1PtKoljIrOzw/AuSwLTHmPD8f74Ld03PRPK2r/I9kn0f2XUAUhQFCIAt4Rs1PqCRExT5yDCmxfQ/rlnr6yAb9L3COlhCodcVedL5DFp/VYwdzgJmTYovoIbOk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 03:08:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 03:08:28 +0000
To:     Jie Zhan <zhanjie9@hisilicon.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <chenxiang66@hisilicon.com>, <john.g.garry@oracle.com>,
        <damien.lemoal@opensource.wdc.com>, <yanaijie@huawei.com>,
        <johannes.thumshirn@wdc.com>, <duoming@zju.edu.cn>,
        <liyihang9@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 0/5] scsi: hisi_sas/libsas: Fix SATA devices
 missing issue during hisi_sas_debug_I_T_nexus_reset()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17czimn0v.fsf@ca-mkp.ca.oracle.com>
References: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
Date:   Fri, 25 Nov 2022 22:08:26 -0500
In-Reply-To: <20221118083714.4034612-1-zhanjie9@hisilicon.com> (Jie Zhan's
        message of "Fri, 18 Nov 2022 16:37:09 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f789892-1c2d-47fb-cf95-08dacf5b7dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0xBAiRKVTXZ7AgTZSsFNf4wtsdRkFxexYE8JkZ/sq3ywiwXlqGKxpXHuIyD7hTLN0Crgryw3GbnpkBpDQjq/Jd6Xg7t7rBpH7vYYcTJbLvUJsV/GKEP/BF/Wfh7c84kRT3WHoltqN1iZmXmwU1cWa6jBr2W3rqLVW22jsG+ZM4yAGux69xnybwi+rUfU2ReMD1k/b5rrgkfyPAfSMysw0cBYYQOPNMdICGbWXxHCng8yXCm309s8Y7rcR3lT/7/hXvkGe8KE4YuCzTJ9IzfEQTWPJ8KSpx8trY6j3HqftQLrvQ9jiaU5qt/4u0VyDosIATkvTRpn55OOXtyX61J6nmwr1txhOtwcAwcWwQQ0BKtHZgjrtM3iXVhlHWOky+lsC0eCCUC1/yMpMbLrSw5KI9V2eoLsgCRTenhJNMqaEed7f7Zf2aiVX8WVxroKPzecqKuRYLCDXDCbQdeXfD/ppTjG8CLx+/l/4EfaUYuLnuJsVZa9vqWKfc8/AbZau5XAWhZfA5Phn+YqNJmhwcI6aXRgwZ+b4DalmlhlBhTx3QfbHW9yEykQMa/hrtnGhfRR9SiuymvstbAjhRytSITn20tpEnq0yzl5kRMSGfTLZA4n1nJ5l9LscFW8PqT74fJ2o+RXM+DXxrlfdPdGtcC4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(6512007)(6506007)(2906002)(41300700001)(26005)(7416002)(86362001)(558084003)(186003)(36916002)(5660300002)(8936002)(316002)(54906003)(6916009)(66476007)(66556008)(8676002)(66946007)(4326008)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vD7+Hr2QDJTljqi01Rm0dqcPHnih3g1DM8mPmqsAWxcFSqofAhqeiTgVqF96?=
 =?us-ascii?Q?F5AIFL2E1NlaWl+i520DuxXFczUg/hDkC1jMdWOou2m//xPosZPC2Y+5hhsM?=
 =?us-ascii?Q?CL+ayCh2S+SZTCI8IHeaEZDKQi4sjw2vh27UMhDm7BU3lKjW6oNSJNTqaCp9?=
 =?us-ascii?Q?ylhEsxqqtDw8MWLfE2NtytH+st/2O4oO+XG7WPd6AHWagtrQLs743c690xN2?=
 =?us-ascii?Q?hyjEjHwiWJvGdoBYHJ1mrTxhpkDwC6uuQx2hmUZCGC+0wXMi0D6J/Sq6dtCy?=
 =?us-ascii?Q?k/fzeP2LDui8v2CJ1vB5E9VNAyzbY5/pVyJLDDnxW/VSBh9McxUSxlYOj27A?=
 =?us-ascii?Q?CbJ9/CYjvHDY6IWl89396Lf+e07gIiaiKHMsuwLYgxdpz5vUkq7PZLNlKsX7?=
 =?us-ascii?Q?1j++xhZPWtycbnxdgvlv0ynq9aUZJGztdlEwyfjoHX9Jcty/lCZiaPSzDCvG?=
 =?us-ascii?Q?mI6F/1E8oyoERSE9d1W/OETyZ7uIAgdYIgVWqRuyQti7KHyhfSGaUKPs/epB?=
 =?us-ascii?Q?xRYoUwds7zWRDa3I3oQOypV9kTKPlYZpMKxtdDWT27LE69v9Te11jKr1qxJS?=
 =?us-ascii?Q?+HvgTg7AQ6OF0PS60OACgTvYQINs7Bkjq5S8Vp0Mb5zENUXtHSSaKZiDZIcf?=
 =?us-ascii?Q?A+i69iCl+Qgo2PEEr8ocMrq560MxZ31d3WwOh9k12lgErBJKOv8/AT41ZXx8?=
 =?us-ascii?Q?/8QxVczEG4yku9xrpVIzFwBhUgHomI+Gupr8dZNDmm5ZuLl5sEFbQSch2gHM?=
 =?us-ascii?Q?KNF0uMaP9cwxTuhjnizUbxW/6NkVeCXpIHnlNzpBDdyOJbJbkGENS2OpKx/S?=
 =?us-ascii?Q?kzB6HjaBrUpY3nEgOfwUzFvTDrrltTUYNW9BrMwA3h8ft8Ko9sY5zZLcDEID?=
 =?us-ascii?Q?XrX5vrG67k4gxtDV1Kq6KPA7cHCurJ3KjrQMSxVAM8hEjCKdpQVA1vmbKfco?=
 =?us-ascii?Q?xKip30bekmcfsp6DBAVOxSRvQ/i8ZAsBgwGHwsHnQME89QrJrU/4RuhQYMef?=
 =?us-ascii?Q?xtLNPPIS6VEwZBC30oG/M9JKxQZ+xmu+fwvZutyuQbYYPwD5iPKKIQa5zr2W?=
 =?us-ascii?Q?6TDfeyoqNMEj8PmJV6PYThXrmLU5HqVPTfj3RCitFVY8w/lDtTXOpAkL/D//?=
 =?us-ascii?Q?/ywmuT1pf3IF/20BAV36nZwWplKpT2C8QRg3Taqp/NEDRjSMwAbwP9oHWHSy?=
 =?us-ascii?Q?qo1fYh1FMaeHKnT9jeIPovLlbHgsAibXIclhXF0mVd+cK+5+6NwALbPZwWkd?=
 =?us-ascii?Q?M093cAB8fYy8Iq1Nge4VPuj34IMmdDWwiCuh75hPlpbX7V2kdlxRxa1amgdb?=
 =?us-ascii?Q?2rihUkxHphX47qrplLtMjllhDlnVTVjPw15DxvRz07uvwBmZhJNEYqSLRvSL?=
 =?us-ascii?Q?iL3/uzPuJrrSXEF2sW8q9gETBCYhcM1z6K63WSjoGCtUifenmEz4d2/tMdcN?=
 =?us-ascii?Q?rJPYnQ/8lIJpuhPNpTcUUh9S25xQ42YDc0PsYXVrIX8eSGP6PA+LTLVN4V+m?=
 =?us-ascii?Q?lWYGY6Fkb9phyoHZZO4Lb+bCrD/9ZfxwQFrlknhcevjJQhm/k27CglNmCz35?=
 =?us-ascii?Q?+lStsHo7KJzyPeIv23pgBNLWmF6lgB9FiZf6u+3Jmdp17zeS0Eg+WqCWgNzP?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dPFHtuSwiAg4E9IZ45Qv+OfAPB6cW1o9ypu9wxZ5Yxd3DdjnaVgvkhoVVkRR?=
 =?us-ascii?Q?/752zYn3iQRt1NhBjLcP82KNlQ85zL7ck2LzCIvuwjO1Lz/bnMXNSubhkM11?=
 =?us-ascii?Q?g7kN5iU/q3xG/P+LvPGs3wXtgor3d+w7tl3SA8dKuQC7MXH+hY8Y28hZCnzs?=
 =?us-ascii?Q?PnG0sWClk0Y15N1p1/iLgnqfPf9eE0W442EknKvA6oj14Vv9tujrlWGxIx77?=
 =?us-ascii?Q?ad1rMKDouNvA4IhnPbgXHO1er6jLK7jyJzO2EklsYtWAAYkXrVBCNGyDyrHp?=
 =?us-ascii?Q?1N+4mLMuZdP2SltYVapKYwZ5vsLoa1uurCg/kLnDWKsAC3ZOpSKkO7sczpbG?=
 =?us-ascii?Q?yNtpAmuKcQi+MFvo0MHqrnm0Rs3E/9NEwQIGXZPo2aFNRrSaTARsPW/sLH7f?=
 =?us-ascii?Q?g+SrhcXOS6bLDAXa+86TUAwso6FPrwcnzbiNHnP67DRNZaoaad9YCJh8nNWt?=
 =?us-ascii?Q?YZuddQsGOrtrjiDLk0xc8dzseDWAxDzVcHyL6hgB/NJZ6Z7wnJJWMMvHdftl?=
 =?us-ascii?Q?4mw7xK8Q/mXuqj84WpvFw+OxSb0DL4DDy6FqWQ+Q7M66RFzKLRnpjjR24A6D?=
 =?us-ascii?Q?wtT5gJbF40T6TB23rHpE1BSohkJIg4imehA3c6PjBZGV/l4JgfT04xsIso3L?=
 =?us-ascii?Q?1vdV8QZUWCfjx5ThtHERR5ztfttTPMYFwM9Ip9tNr1MGqV8IKMZ1a6BSSLg0?=
 =?us-ascii?Q?xHmvb5RuQeAwmdzj3upXYLZuNOp3loha3hjhDpjseLrEEyxh8+D1Pox4ROlj?=
 =?us-ascii?Q?Tym/If61PHB85WdSQB3xxlJUF5ctsPhkcLtfzaS2lrofyWMTMS465Pva7jW3?=
 =?us-ascii?Q?I4ho2Hj90myu3h4NZim9iB8d9+x+6lRgynRCZzJ/GOqggiXTB8Ma/hDFO9y0?=
 =?us-ascii?Q?tfJxOVafrFSEEhDTce7axgX58yEmTBPgneiijmH83nFwhqnDHC9XkfIlqk4R?=
 =?us-ascii?Q?lxoY2Kkze778dGyKlA4OYVJF08UdN8IJ7ZlMsQfDNscupb1BVe2HZXUKbSzJ?=
 =?us-ascii?Q?3ahyyVqDgYJ8+paMLBwfU1UhlGzHnTTHUlOYLIDdg1X3A48LurNh3MQ5DIXP?=
 =?us-ascii?Q?AivY/SomQEACVHA+8ro6JbDilStD3SD2iDJ12ZA+ECEZIqTNpJZuQaaivvjI?=
 =?us-ascii?Q?pU1PIBcHhXV6gvGwJ/pHAjhpq0T0q8L/ixlETs9zBA5rAb9Z//xoGas=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f789892-1c2d-47fb-cf95-08dacf5b7dc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 03:08:28.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX2pU5DpsjP2iJCV6Ud1yZ9qlivTBBPRp/8+539tw2wLCWKvcc6JJtS/2EftmdgCvsw6KYKw1XEhreQUjLehP8VsaRQ9sqxQZ16eZ79vcQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=892 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260022
X-Proofpoint-GUID: Y2hA44AiA9RDmh3IKTYi9Eu99ahOAAKF
X-Proofpoint-ORIG-GUID: Y2hA44AiA9RDmh3IKTYi9Eu99ahOAAKF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jie,

> SATA devices on an expander may be removed and not be found again
> when I_T nexus reset and revalidation are processed simultaneously,
> which is probable to happen in hisi_sas_clear_nexus_ha().

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
