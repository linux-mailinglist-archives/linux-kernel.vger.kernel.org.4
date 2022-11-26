Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387A63929F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKZAUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKZAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:20:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB850D68;
        Fri, 25 Nov 2022 16:19:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APNQ4Af018651;
        Sat, 26 Nov 2022 00:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=z5ttwk1wisOY10KJikGBNVv4lsMuD+ArfTyL6HuyQfw=;
 b=2IjM9hJQI7k8kJBLi2nQIbpd6GPcuv8fE9MkQqzRWY5YAzPAHtw20cQ6LeArU7I3rwcd
 iHOv7HfInBgD9i6gyzgENMw1cjdY6ohUj9GSuHXeTTrm4b0mIo2JjfjeepI1ZJoIU8uC
 FmyKWbkL09fEAqPfnC+o5inQiPdh0ReW44cKqKRMvy7PkPynvtagOdYPrKck5BcAzbDP
 oExuIyx62OhIcraWnCxKPpu8zpK5to3AMz/y2Jx/p8oTRGKtLw62fem67OWBgOFdi1pn
 wX/XpZ4BZXdRwqAPAV7+NlFAm05Xo/BIGgS6zyF6KX0/9B8AJpfJqEBrht9n70KsE294 rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd8dgw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APL0Qo6028062;
        Sat, 26 Nov 2022 00:19:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkfx3qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9H/gfQbNcsPwrdJS4lFl7yqAGINSlEZca9jmehpm1tCEjLzMT+8jxl+B8i6DeXSyZ6d8+W+cVBlq7K94KweOo5Q4HAhngX6JtrSmOsDWEurmYMVSahf2VFcD9z9FHFnLd4F9m6UZ1FYQSwTyqyyqzXrjKDdlDb1ufdBPnnH5GgsGyPf/nKcu9bTBjTTyLAsbn2FrhhVWyzh6p4QIqrcpl6Sbv3Xh9wvstDUxSTyWgMSsb/xS7nGfbKyEwBRhLovhXWBWNuhqaqj2wORttu7NN4MYokwFiwHyiXf3vORx3GgAYl9FkrDjNML1qcmmK8Gol+D/IYA3mZ85L0ub3fiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5ttwk1wisOY10KJikGBNVv4lsMuD+ArfTyL6HuyQfw=;
 b=a+o8HpORqs2H9k/1hwUsq02vKcD+0A4oH95UHLSw1nk5T6TQ6gARDFhqWBOtGXkLokohqnAIlbSQe4z4mXyh2i5E6qenVfFcD7E2XSpCyzK9P0Cmuxus5BgEmwqNjBkg0HWLcUZ2Q4HGlLqjQyLFRC7rP4+mzr86StNUCemqzL6HwqYSfpS1uHHGtCg2kDuMB1j6Bo6Rn1CFngpsA46FkYShrsDK8vxFURAn9YxztVyTG5sS4+EICknES96k7ZpfAnQt4jpZ4R3CFEDGqWOD4QkWx6RReyk19WJatVeH8UNTzNThtMoVdxnPP/iG+VrGYwHKc10W8hGzk3/+CDq/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ttwk1wisOY10KJikGBNVv4lsMuD+ArfTyL6HuyQfw=;
 b=Tun/EmlecJjlthSG05zWu2sRGnulO/qKVrlcQQb0s9LxOEAF0xCLm/2Qg+UqwQm1Uturjpo7D4O8aKb+5JkxWCW+LPv36mHZ73ydYUerP6J/sJg3sKNWGAsk08fVtZB++vFv/Q6EuznS5t+s2mh6mLrft3wta3RrDlnOejS8y+s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 00:19:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:19:48 +0000
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <james.smart@broadcom.com>,
        <ram.vegesna@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <christophe.jaillet@wanadoo.fr>,
        <hare@suse.de>, <dwagner@suse.de>
Subject: Re: [PATCH] scsi: efct: Fix possible memleak in efct_device_init()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmdar2hx.fsf@ca-mkp.ca.oracle.com>
References: <20221111074046.57061-1-chenzhongjin@huawei.com>
Date:   Fri, 25 Nov 2022 19:19:46 -0500
In-Reply-To: <20221111074046.57061-1-chenzhongjin@huawei.com> (Chen Zhongjin's
        message of "Fri, 11 Nov 2022 15:40:46 +0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 809805e6-0e64-4fb0-19bd-08dacf43edbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS1gy9e/JWRVqNY8R3SZ+aRnZOSEeNsLBBTe4tYKY3THzTbz4LwkWq2rPcAJIn/zOyyEx739Y5zuMwNPuiqNS4qlbSMa6gzX+AGrjBtF97Z7tgz9KNI91Jz1w8UTFqdYG29u59V+9noBhetOeRzR2OeqWfjbxIGr3/9y5bR8llTiHlQOpZgArV65dEIYrCbnu+ws1K//CM24jBSGS4gSm6+Iz0FjGnzSyt5CN+mEnENZRO9ibVHhdnJ2nfAM1ysa/zM55fRl5NfEMK+v8AmaFrVJh9hwMm7gCUZzTepcv2YKUw4+h4LifM6DUE9QjYOwoUY78gx0qQxCKnLmue8/Q9E3DzGqoyc0Zee9rFeLEARWdCZCr2nXuu/G0Nq4VBVPdYtzVOulRHjf1M8N2yM62+o4j8usweh6r11DXkGFh8QlzfNbwrPyhGyPjodwAyUbTQVMFjDkc38CsxaQm68Ech/tSQf+D57dNm+9qDYt7X1pS1K27E1RZmrFXRPoN3W0SH4vOUJu3Vz1QNf51rU4FcKomhukn4TM9Gy35C+fPapJWAsfKkJvnMvkyFLrAJPwi3VrMdrxrmGDAt+CG+wEsvwpP4fDtkpU3IQluW7Jkb8qOvXkhQQJ7GtZoRlr6HYmfHRqZCVVFieCjsdAfKFjLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(8676002)(4326008)(66476007)(66946007)(66556008)(36916002)(38100700002)(41300700001)(6486002)(86362001)(558084003)(6506007)(316002)(6916009)(26005)(54906003)(6512007)(2906002)(186003)(7416002)(5660300002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1yqtx/tStQSo3sFlESSBk54K6IhMpY49DJA5ZZC1IhQ7aOKnHVQgv012mWJ?=
 =?us-ascii?Q?6B9E76P6/KQXhbg7ir8G5YiMWEI3LgQsij9Jz19KCw2blK7VFQwX5NUPqFvw?=
 =?us-ascii?Q?hewd3fIxsbvrDZXu0cFuOrmqtSrZeLvdtiYYW3nZhceRvDy1GpV8llUBhXjM?=
 =?us-ascii?Q?Xtg5835/3tQizS7GIre1LXv7J1DszTt9MnFrG/YxE1Yqv8BfLzmtxM2yUJTY?=
 =?us-ascii?Q?SX/M0SlkJIGAQ3lUfXjUwPuYvNKYqwjdIANQK9ULm3SMuTzBkL5+G5fJEMzz?=
 =?us-ascii?Q?06cEPLPXPRqjYo3lsEpaHdNb9Q3K0/aeSYRirKXQKWA7MO8M+0FlOHtW+8nL?=
 =?us-ascii?Q?OdwLlnwgwe6HyxeDDsGilBHbeDYaN5d0pz3mz7EcE9O5brX3rhk91trKf830?=
 =?us-ascii?Q?1gKYVZg3b3eCh2NFNWUtJbvE5Hv8UNCjNlTZzkBliQaPKVeq8YcRZHleieev?=
 =?us-ascii?Q?8jqBj9DabPih5dX+30U351/SxUPjP/njw5Q2U+/WbG2SnqTiznR3oDzTuhCE?=
 =?us-ascii?Q?VKdFyq+YxLEa0TQOv06BDDG4Mp2stCOSdHuLtgImHG53GFPOYnvB/dgJBheV?=
 =?us-ascii?Q?3QXEDTveJZb+JwugtmOrxvwWNojUqzPuNk8jPPY5p+Arui6dppyc4oqUPjkE?=
 =?us-ascii?Q?c/2GnSmL2dRCKwDwSs344sYIOKGk+WtAqjYpolJu8xqVvsBYK9e8/26Eqz8h?=
 =?us-ascii?Q?CM4GANQzeBeKXzMFxlN+3qdgzxC5fJ6VAk9++ZGypD3fcZWyO2XO1I6wydCV?=
 =?us-ascii?Q?h52pMPNN/gJxc1z8uJBGJuMtr/JqBluFwo+G75UVW+QNtNZ0VwH8tykfwP90?=
 =?us-ascii?Q?KX6Dzxxy6HzsRjbJDUhq+E1/aQT7afzlnO15YeHUbcmgNc5rWCLUDYK9cyL4?=
 =?us-ascii?Q?PauDa8n/EqzcPsBG0Br4WW7IkvgTNHw96dXBy6OVFRoUOVw1P6+TOD1uBkg8?=
 =?us-ascii?Q?+VvHSAGvf+uedEWQMhbnROXObsTKFB2puniXbXvW9nm0/ThzPPF5fWXXZeYd?=
 =?us-ascii?Q?tvVDm/6dUjZjWshcuyIiIjx18NU3n0CzqVEJSt6JiPOmi7S8L62/LF3I8VYq?=
 =?us-ascii?Q?fjsIn/ZDy1OVCX1ErPG7xMnEFjlrE3uRg8k3CE2T8WimxR4KPvIbVOr1uGfQ?=
 =?us-ascii?Q?yL+UxnIGcYBBoslYPk1ljQ2i5YPSOW75Tu0tXmaqM2emF2amLh4pLRG1KTkp?=
 =?us-ascii?Q?uwItIs5YvEw4DLZs1j/3WMGSUVM+PUsyqCuH3SXaAtAmLdT+PfSjWI7uAk+e?=
 =?us-ascii?Q?48DNwmGhE3kVa+Ke442Xtf5xeliPk3MMc6ko3CPfgv14Soj5VQYKJCMMsXn9?=
 =?us-ascii?Q?on3M4zMZw8B8QaIU+L3409Yr2o06foG52kNO7qSd9zrmICV0c+kh/ZYmcEd5?=
 =?us-ascii?Q?n2xpqNbzqY/B/YK+xFh6f25wM/afqb0EoMJtxXM9rwF83uWR9KSVndApdn8B?=
 =?us-ascii?Q?UrWaJ0HlkcnBJrrxFzUFO07/+wtg9+jLm8j4P3T439bd9AKatTWm9yAKIaFR?=
 =?us-ascii?Q?YlAnWxslZ2SdZlC/ybGCzqB4xhIPXI2d3FnSIAKq5kJtXK/rQva6FgiJ7d/T?=
 =?us-ascii?Q?0sYK7N23MSuUYZHgOc78t8D05rkMLpoEXuifgMCgPmf+rOFwi6+h8MQix3xu?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HkM7E/kc0e0v9mu2pl7xqfxkd2l0k93pcH8wkPauTf7ENilW+7waGu9bKFoh?=
 =?us-ascii?Q?9Y0jJbO7KjtmaZhurgB16GoXa4KBSUvZQZNXZZ49VTB5ybsQ912obBkgFzw+?=
 =?us-ascii?Q?DwmFuU9U8gLhhvZsy+7ttKqHkwG3YzhDefrUYFITDc204gxwlcC4PnRrTfUK?=
 =?us-ascii?Q?a45k0eW9oN21SEvJi5+9MRqloVItnHyUYZcoDyBq8YMRPpP3jHHvgCyH3TEW?=
 =?us-ascii?Q?n5Hwp0VSISV0lF4pXMicPyaJGN/iyplzpXSOyYwUF4RwWwlUGGsIYI4y/BWJ?=
 =?us-ascii?Q?zgtsLAifUsyC4hTY7UcGG+RWrNo3XdXVudDdYrhsNJC/Dd/T8vr1py3su515?=
 =?us-ascii?Q?x1nEC9srLnM7DVXD25t04fuQrGTXywPYT26mWSseJDU+PoFVH25HF+SVD7MI?=
 =?us-ascii?Q?ELRsu58mY1SI7vhiO3hwk84KvubjV/WrWHM2prbGfrNYuQRIi8qbyM2kPDz6?=
 =?us-ascii?Q?GRKq4/axDgXa/f7JVrCDsKoSNRqoqW9tgcBzJKFwbByQiMpOgba+0IJ6R97Z?=
 =?us-ascii?Q?iehXlmNgRDAX7mqUMZ/WiENUaok/S7tUK2YRpujBaZaldPtL9m0mTR70dEA7?=
 =?us-ascii?Q?DZbmfok132nIH3ZcYbhhAVypink4Ki/ALXY/WCQAE8TB2BfkJDJIASkT8Xpg?=
 =?us-ascii?Q?X84dNZT+CMXuW0fWB9i3W/IXqtbUYDbcL6ys75AcomXKNaFKqtqkDcTIjT60?=
 =?us-ascii?Q?l10SB/0rRiLlXIuIegubh9DN5zTcJhxAHkAvxnfZRwOS/9hIg7wv3bHcG/7d?=
 =?us-ascii?Q?T+Z8RDScT+iUs2n7DrjYYEodtSdbahg9agkKayVAd+sqIMsj2F1GMBvkYTds?=
 =?us-ascii?Q?yhUipOuwKVJeilANz6kSHwLvlHA7R6fFJcDpCf8httQ8njuPZ9o4ZqDTQh8A?=
 =?us-ascii?Q?M3KdTqTVcK6qZYa/D7WZP0rYa3iM0J8iWy/+6eBH91t+u+HfwyO2w45ff5Py?=
 =?us-ascii?Q?qHWiQIBidFdaEOGZlBerOTkOXjZdFXjJGGDIQfW8sdjKeo7zs45cIF9mB5K/?=
 =?us-ascii?Q?ePma4du6mSSyc9kLhUjcynBQfzSW7YpQAp7t5QARzTsRk91F+vCGu4sWDI1W?=
 =?us-ascii?Q?kqbHZKJr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809805e6-0e64-4fb0-19bd-08dacf43edbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:19:48.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPXZjF51pbfsoCCH1xaQwB1od8SbdMTmhxepjgvwzrd7BsO1a9Sn+CAtM/LBi/qTk/vnrRpU6O4FSPxnWsPS5V8rBPD0GXXk3QVYxLOShb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-GUID: QAmQ-hh9v5OwZg83jqj4VRHnYBKtGw9N
X-Proofpoint-ORIG-GUID: QAmQ-hh9v5OwZg83jqj4VRHnYBKtGw9N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chen,

> In efct_device_init(), when efct_scsi_reg_fc_transport() fails,
> efct_scsi_tgt_driver_exit() is not called to release memory for
> efct_scsi_tgt_driver_init() and causes memleak:

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
