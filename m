Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5C66A5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjAMWbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjAMWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A16C06F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DMGtbf012571;
        Fri, 13 Jan 2023 22:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=r7lk61LMmO+WmINsuiJDCvMVY/twjIp+qnd/uT+Vau0=;
 b=Afos0QAaNP8g08ivVFcMbovu8tZmzRsXV4rTD+Qj7I95+EkX9w6zxnsgwhxu1E0tlS4e
 Bu4pv8PBDwwr/wFVAUYkcVs9r8EYfBiNf/oRW6hr6FS9Zq7GaqpENTIlLy0lu9V/ZIQj
 adgiudOQI1nRfP71o+4YIeXqQBgHRXlMBL26WEJ0xUeejWaC9kElAEyALbkL/hpPBLMm
 tC3hhX29QNIiQTRPlvyE3amB0MucT4Tijr/E5L/D9gS0cWZL7qyQyXK0wjwcmNVzfs9k
 T1tdx1EGehng6LQxK6dML2BAqrRgd1yJPDflUY1o//4b9mKWSbH+UXxWqiAb9ESS0qZd zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n362w9bfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DKhgtv022266;
        Fri, 13 Jan 2023 22:31:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3ekdu3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEyx2xi01qsSjqk6u1RnN1jBWngd2rqZCexESseMG9MCWEd7MQcWYbqY8kRmsUS+etwStebnEz6RyEuFA5D+w7bqbaIvw1c8RkMVwh4Fj2eNSS4SZg0y5wcsWniYOT3KKjHkhgb06ajn1LqFgdkYLquav3yq7UjaubSYfrGMlwNB1PMBvTCeag08G5FXmlmFS/w/nPjQkiFAP21j0YNvJ/OJKXrtiCgMqo5IjQX4TAmVYtT6o1MzzxO8HLRazN08gvu7Q3Xgp6deT+j0nXD/JtfDBOzVKO5M7EDdZMr32CjH3G/vi4bBcMeXg4NZJgUgwfhNVCzqFKeBoc7BXD85NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7lk61LMmO+WmINsuiJDCvMVY/twjIp+qnd/uT+Vau0=;
 b=TKMmmkjqGK+Y60TyCgYfG/10qyM2PJ6eHGZI7z+DQJT7tDqGSap+HBDedwx+VRobvXNNvf6X++mqkwGNRyoLapLMwttHYm87jBSEQQSylXUsnqg40pIJlGcOikpUy8lVPAkv/B9Tj5IVyqTQt11734Yumxk5dd6nF3Lr20vPX8K1IqdSkIADoeqJxd5G+q0gi7jsg2Iqsilwkq8HgZt7RglIP5x6wtMQ8d4UDOxT94o3n+4+9Rpeu38diapr1d4UCAn4cRD3cPdFp6pqlAD4meanc2xSFXAvy+8T1wRjvmxXcC4J7v3ukY7dMArbnU81PtT+UxGBONqmaoQ5skLcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7lk61LMmO+WmINsuiJDCvMVY/twjIp+qnd/uT+Vau0=;
 b=Gq1/dpmpUZEw6O2CEjVMsWcrKXv0pxUKtiTgqbsHrb3RpJ586RmnwD2C6kgdJpbJgeCkp9Elk9zXQsbnZzI29Sr8RC63Jp6Y9zpPu5kWILTeopIvHskvo65jq3HaoMheSSFhOLWmFxoMa3WIOIuMrtFTjqM7CtfX3dY3zpAGjNo=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:02 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:02 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 0/8] continue hugetlb folio conversion
Date:   Fri, 13 Jan 2023 16:30:49 -0600
Message-Id: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:610:38::41) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4644933e-1e78-4eb6-c1cc-08daf5b5d99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/lYOnolJt9it4KNLlEBgta9ZBcLTlRD4/j0TvoMbnRQo/ZakkXRNSHib3XMlm46IMSI8NaxQagAqCw//OoajSBPxW8xqeBeOxc3wQHJ5KA6QGiW9+Yh5MBXd1/acoNC3aPweucH6KubtkiyJe9QWmT6OZDvpYWFLm5KPPOWEy7fui1zStVJqT+q2a5DoW478EsAiHA1WrxwG4mIQedKaxYtM1/WLcPVQzO/s21AMEHEpHdsDOjDZReFDO/1JMGhtabV0JfyIMmJxuojVwMmWHVRoj8YdJFu99jFMCbLFZ/d6xME/kpfZAgfWFooXtoJCm6mVkqDb8r938+TzrPvsrPl4mlwrs2cv8Xy7pWd8JbAA3At6N0GrsAkHpZ4kxUhTiassDPlJzaT2afZlMyHYo1i8prjXx/kM1+UPJQclN73brTYJfG5/jJBV0NKgC/MaoYTQJnihbdHzTQcGmDJMbghmlyKT/f6Ff/4ny2FTB3uBHXq2yTdVS/4N1/isxPdv5RZ84FgXhcOAPm5TnQi03nb3m391vW7Odsdvn4kvPqK+otXmLMiw7YYfylOzXz3oCtsV76fVazN2CrNwexzDmk1O3IT3mDZdwZtjaMVSmXjS71bW0YFr4eM71kQjN+sexHmTc0cChFdkHkwNYVJ+/TfIHt8tLpXGZ6oUJxgWaVscqcZE9HrmmXyIvm9I3CJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003)(266184004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2J/jCR4C54WTSLQboAJgHm3coc+NErs4Vx0lWNtBQDtqka1qn53/U3z9hgJa?=
 =?us-ascii?Q?F++F7BSitYkeDinHElU2XVTwYL6rQHU3dJx8BRpKOBKKBD/Y4EV/rObaOOb5?=
 =?us-ascii?Q?JcHHdNXIIunt8+7SYK9OHnEZL77C66Zx3Jm54wMKjWvmgTnZQTS98RHkUcbu?=
 =?us-ascii?Q?aK1PjYPIafpD05L+98sUlz8KBfyT+l8rlkBvmF6qzHjEZbbhrxGJcoeP5WI9?=
 =?us-ascii?Q?f4OedaT19mTUjsX55j+RmEr2rqkaRW2xlArnSr70GQ+9ZJ5cqYcQ5PucaTN3?=
 =?us-ascii?Q?d58/1KD76eQlNTLZlrlvNHhvKry5hiTGYWC7aZEWVbNUpbB4Doq6S8JzbXhE?=
 =?us-ascii?Q?Pj81xmlx8LT5RYKP4wGPlgcC62moD5PBecv29NYoDIWLE3c81tDwfllYyGez?=
 =?us-ascii?Q?loqexH8Kz3o3hyfYurgsufrvSsKK3lByF+cHRTxFhj3RwtN19MyjiN7xTmoV?=
 =?us-ascii?Q?OULDIyfQamlVNx33NpktmEjDAW4eNe3QLWHpHjYwj0zxSsVmG66eSWqtCMNE?=
 =?us-ascii?Q?/1lYrA/Wu8w1FGgekUvgdxOlxz6FXu8TpEkfLYSfp0GfnwC42+ClYX6vZt/L?=
 =?us-ascii?Q?gpVlS5Qn/p6GP3drumgV03H0NDqtM712gXb4hcftKK5SZdlwLg2tZEF8bpvU?=
 =?us-ascii?Q?ZzWQ9iJzGGrh3bbBhMpGNgC35WZtEp2CqkcN2JOjzztQrHZen2zm/xkVKKZ9?=
 =?us-ascii?Q?jS97y0UOEzIodRqS4EtMAu4kfcr5mWjlHz1iYe6Sl1bQ16aOStvTOua31ItY?=
 =?us-ascii?Q?gaf9C7AmvAHm9/PLwFTNHEbzba77oaLfcinzdKJhAjPTdCx7dtzp5gud6EW4?=
 =?us-ascii?Q?ceMdDjLF4Aq3AD+giAJlFXn9k/BipgPb+/woFJywCB4hEy/Itb4MypXj/NWi?=
 =?us-ascii?Q?seC4OSu4pFZAaSxgULnFtiimEPinNZJ0gvvYSBE/3NAR2aJQQeaOFZu+D7GV?=
 =?us-ascii?Q?sGQvODRGXvpOzbI9krhyIZrlwwOebMiIebnnmd4GxMZpm724YzxjLP7rUPdF?=
 =?us-ascii?Q?9rcQnpc17+8xk0QDBHG1MJ3aNqiQ31tsw6KEZyDTm09cUmkf3JfXOIcyh6FM?=
 =?us-ascii?Q?380TNo1BbT8KArDcmbpNJ6JZPky/WysFNK76fuezBExiczberHw+JFS+w1dh?=
 =?us-ascii?Q?panv/3OuJnM71kx3ARQeEdkS1sa2XxjhtuGrDZS+lXKlgR/MzSKNlI/00+m6?=
 =?us-ascii?Q?1ebp37CultzCQflt2a9M3g9JLPfPxuRKYAx+xRMuFj84j0rPCf02TK/XZunZ?=
 =?us-ascii?Q?nt0lVaSuAslcxOnw8Ikf+3qdWh6iqBvw1FMxq7F1ivjkB2Wyw9VYwZoKH83B?=
 =?us-ascii?Q?Vc+0ig9mOM6MjSkMxjeDvHTa2S4ZJ8d8zhkAFZrZdzaovg/hPoHATeyacYk6?=
 =?us-ascii?Q?sWxS/mhBP/6cQJziYh0E9H9CVAo7BH5vqdnitkKwC3VRYc7cnBp8CCh4Rwxu?=
 =?us-ascii?Q?XgsUf6FgGCa40TgkhwNwLCcM2e0h52i9502CEO3K6HOFdvCgdZl0c4MbHMUe?=
 =?us-ascii?Q?9JIeBB+ShDcKCM6b6PBaCMNfrLy7+fvg7lo4LXKvlxhgwDmBpUzcQAVCku8C?=
 =?us-ascii?Q?dHmM9ZyOBI65QK6+hertriEIticgzrxiEb9lN5mS8J4SXoVksvWuCE8QD7/+?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n2iiZ0PieW+kolUokKRk1KQryQimAuRwtTVQxXShMwogn9wjuoT4nTgxxkdA?=
 =?us-ascii?Q?hhRfo4Pn/bT0ULbtkgBMN04xe5PMtANO1ofzbxit98T9gYF7JWL8MpomZyf5?=
 =?us-ascii?Q?oUvG4z20Bh2t81m1niPKOuRLv4JrPlzU4e3MH/lSQQ9aSNpl3xJ4U/LAbhFA?=
 =?us-ascii?Q?sLCWUiG7/YgGAotTMFQbfDqm8mDAvHzpiSBeT6DHVxymJGhR/Pn6wRrBonDu?=
 =?us-ascii?Q?2tL3w+6zNaTkAe+xG5TMkiKmFENH01EEQxiPkagGT+0zo9Kmg5h+VoFQmsVD?=
 =?us-ascii?Q?KYpMF1+uXgyaN51R9sfj0OokaYxfad0QWXXubLHZ+hgbo0C0O6rrQ7SsFffI?=
 =?us-ascii?Q?MD+bT2xGdCfFb8G1jW4mdcNjE4glpDHd7D6m0SFkRTpYwrAmZr4F4BL0t35U?=
 =?us-ascii?Q?JTjKlBRWNYH2scYqDkgzMH1GxoGhgZiiJjXd9CBy8j50nDA7blAPkYRS/IHR?=
 =?us-ascii?Q?SNSQ/HQWi6DySY+Y6OELlLJiyv/QB21+Kq218HUzrUbEYPL+1TKa6UcaMC5/?=
 =?us-ascii?Q?8mmXQYw6kYYoZXnn8hkPjyWYhNtNfAVRNq9+yC7AyT5XAFzIfXrIwTgn1ISV?=
 =?us-ascii?Q?hVwQw/Ti2PxkFTIJMsXzHZjAaYqxhPrxhsmIFlCJvOGu1Du+ohTaC82uOMjR?=
 =?us-ascii?Q?25J2rAXPIxX+3kmPJawnrnRxQBqS7aD1O7l1jJsRb1Wu9M/HRpjIup3yc9uT?=
 =?us-ascii?Q?Ml9Ot1c7wuAmDpUouv/UJ8aMTb29kjj5AW5odXfEOvfbP1SSxNO8CDBa/7Zi?=
 =?us-ascii?Q?MovSG09WNb+ey9oIIwrRyo7TNLqxnPJ6YZgIM3MMFHVom2RnIg16GvtjxQRI?=
 =?us-ascii?Q?oe5NhCt2kBYMaK1swKRPyPay3uXgdV3vXzIzinDI5XRQYBu1lg9GweKB6GVR?=
 =?us-ascii?Q?YdLh+SiK1VRi4kuAmtI29Cq0VGf5ggp1wUR9tH3525g3ane2G6Lf/6A945dR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4644933e-1e78-4eb6-c1cc-08daf5b5d99d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:02.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NyF9rGICySwxK2Lqk+NuS6NSdL4XWJBkgDRkqRXMn1lbk4LV/BtwNxfLd6TtKF6UX5uNMXPtT9pn+UejPFgdHXWirIvorA3d6mD432aC8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=548 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-GUID: KjauetbhQ4g7a8c-3ywqLAWlcpghkJWU
X-Proofpoint-ORIG-GUID: KjauetbhQ4g7a8c-3ywqLAWlcpghkJWU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
This series continues the conversion of core hugetlb functions to use
folios. This series converts many helper funtions in the hugetlb fault
path. This is in preperation for another series to convert the hugetlb
fault code paths to operate on folios.

============== TESTING ===========================
LTP:
	Ran 10 back to back rounds of the LTP hugetlb test suite.

Gigantic Huge Pages:
	Test allocation and freeing via hugeadm commands:
		hugeadm --pool-pages-min 1GB:10
		hugeadm --pool-pages-min 1GB:0

Demote:
	Demote 1 1GB hugepages to 512 2MB hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
		cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
			# 512
		cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
			# 0

Rebased on 1/13/2023 mm-unstable

v2 -> v3:
- grab folio directly from hugepage_freelists in patch 8 per
  Matthew

v1 -> v2:
- remove reduntant get_folio_unless_zero() and use existing
  folio_try_get() in patch 1 per Matthew
- grab folio directly from hugepage_freelists in patch 3 per
  Matthew
- add r-b to patches 1-2, 4-7
- change variabale 'subfolio' to inner_folio in patch 8 per
  John Hubbard


Sidhartha Kumar (8):
  mm/hugetlb: convert isolate_hugetlb to folios
  mm/hugetlb: convert __update_and_free_page() to folios
  mm/hugetlb: convert dequeue_hugetlb_page functions to folios
  mm/hugetlb: convert alloc_surplus_huge_page() to folios
  mm/hugetlb: increase use of folios in alloc_huge_page()
  mm/hugetlb: convert alloc_migrate_huge_page to folios
  mm/hugetlb: convert restore_reserve_on_error() to folios
  mm/hugetlb: convert demote_free_huge_page to folios

 include/linux/hugetlb.h        |  10 +-
 include/linux/hugetlb_cgroup.h |   8 +-
 mm/gup.c                       |   2 +-
 mm/hugetlb.c                   | 218 +++++++++++++++++----------------
 mm/hugetlb_cgroup.c            |   8 +-
 mm/memory-failure.c            |   2 +-
 mm/memory_hotplug.c            |   2 +-
 mm/mempolicy.c                 |   2 +-
 mm/migrate.c                   |   7 +-
 9 files changed, 131 insertions(+), 128 deletions(-)

-- 
2.39.0

