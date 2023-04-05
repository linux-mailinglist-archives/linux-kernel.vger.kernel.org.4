Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0686D73BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjDEF3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjDEF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:29:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D63C0A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:29:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KonRL023404;
        Wed, 5 Apr 2023 05:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NV5cXk8RvPlA4g2AYczFd1XAy6aUnAGjHGSoDcJ4jEU=;
 b=Mo0lpGSWctSvdO++EuVhVivzuDZN8+T4ng5KP8XBu7d/F5UzL/KUKUXrDjUScgHoVzrt
 K81vNgXLtp6Euo2NbPHdT4zduPvAFNVVfsOZDxVXvHIzeH3L7Y1oVAG5Sd0N8Mv2yq4E
 vUSXFqZ+CL1udu6rKeeZ+x64BxbhJea1g4+fMJ2QflhpLlqJm6zcH62SQlOYwezF+4iV
 T3vfHfaL3yGha5c9byKRK9lSHiiRX30aa2hVpma7MYoBrUq/WTxdc5H5FEF7bPYH9QGa
 GT2Z05c83TG6U85mK4ccsgblKr98vLqvZXJQZ0jE2/9TPyKRy5qZFJ92c80TdShEnejH ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dqek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 05:29:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3353ulns028063;
        Wed, 5 Apr 2023 05:29:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptuqtun9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 05:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocu1Y4PPhKgFTTrTpBX+k4BYc4DefFsRLRjTP4lOcTI0JURyI4u2Co4GvQoLFp4MB9Gynhm7MDgJf4Msc05RpUSd6AaRPuLQp+S/jGEKHb6aEi6rlpSUPf/e1WdB5XuSyCVbUa/CIn//gvebklQUA8PorH/w1aGPQVDYOvl2jjG9SlWp8st5WW6SKd2AUiDkpofuMYPruZMzuGcHQgs8RaGRtiQiGuiMWIOT8z2X+ui3DCt4HfZTQ6Nay0bjgflrmg6/cqLnHh+bk8fpTsg2UqKAvLg04GkU+PVtFexprRy3jnrbwjCUXpUs5bCYjrrlDxOIp5FEgiFAa3uasM7WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV5cXk8RvPlA4g2AYczFd1XAy6aUnAGjHGSoDcJ4jEU=;
 b=aGXgei/GXf1fidfHBah0aEwRVTJM4LGyyvJ1uJ7Ovvj1xS4ScbNlfY/gWz06081KdkSiiep2P7AYXT3JEhGWezQC0brwEjijtqT5fxvOmcCp6L+JYvz7R84uspKk3kHweIv1DLOsg128VLCbpi/5XiWNG3/5gqSaC3XPCLazjAIV6TOu1rO+a7xEQd6J8w5JCbxI09XWzUr5VHsmiWbEgJxJMAeOTFfM5SvgrJCcSiej8DXPZ+bHT7cuA71pr4uihGVN0EnVisGjajNn3UqdVKHe6VYiD7z73K+HDwcXOR2TkwNpuzcQ457c1nXtwtsD/R60bvzedN06yhG4dQ53ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV5cXk8RvPlA4g2AYczFd1XAy6aUnAGjHGSoDcJ4jEU=;
 b=oTMWJdOtadqOv77Tql6G0ggEIFlaTaY/JOeljcZi50juTujMHoJ3xG61okiajBUj8ljxo8FZzsPVd8oqKc5/wGEwV7mbj9AK/q5ebj8gGpH6aa/no+qAOEGpJcFhHbdWNcNjIRZwt3evZBlM5jXvsWQfB7fCkowxn4mRsuveoq4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 05:29:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 05:29:05 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com> <87pm8kq96d.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ankur.a.arora@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
In-reply-to: <87pm8kq96d.ffs@tglx>
Date:   Tue, 04 Apr 2023 22:29:15 -0700
Message-ID: <87v8iakic4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: a62eae0b-7130-4727-3f5d-08db3596ac25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa3Odt/nMv23IRtz8tV0FJqZXtPVRXjHKiKRMSdctbtXLSBBFSRTbDcfW6wLKYunufLVVOnL0Y7lEQy7lIDY7ZlRZfiKp+yxIyIk2SCYmMZvx0bvAzrEm3uGQtWYY+VmIT2EPXB5PCOu8E/6W10QYmVngV+L4qVppDDB0DVQZcnjvKrXzvXMPkfgDN4duTEI1B60uaO8Qt/U2Y7DkiKqeEJr2WubR5C3hIpMNZW3ZaltPPPebVXACzcX+l36UbqmGG01Y+84pxL3ZKYjWIib7GYTMOxtfKbCEQgAIxEcJPuo1RLlku70QqLum3IrChXZF+Q+bA66YcJF7E0vrlYT5kHiqs7NdtsCzz57DWfzDD4KPZ8OQ5zftpynI2eoFLv+Va6BKU2V0UWxw7uLCIBLaPDT0U3vUIdf0Zjb7wplluYOgzPZL2YMLdRNcynowpO4GpTKTNY8FTXBT2naMjiyzJcn6GLZQZNPV8D6pB/16G5bf0SE8U5rraqkuH+Srj/eEID8sJuuyPMl2K3WRcZ2Vx0s3RQHp8jiupB6ZELq8E+r+9DUeEjKlXuBbFx9EXIw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(6486002)(6512007)(2616005)(38100700002)(6506007)(6666004)(107886003)(186003)(8936002)(26005)(7416002)(2906002)(5660300002)(4326008)(36756003)(478600001)(66556008)(66476007)(66946007)(41300700001)(6916009)(8676002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJQxZ662w/J7QQHtyGaR0dpVIE7qrqcq8htEnC39UyLb00hyefnNQGfax5OP?=
 =?us-ascii?Q?Z2U1WNVTMJ+upbRGTlGlPzJOZ+LK7ZU/47HS7RPxJhaIQqRUMO+F1NMmtYLp?=
 =?us-ascii?Q?01F1olKg2cBaoYbAX1Ydlms10BwY0bWMiw+ve5Z26xaCSVgwkq/pTudXO8hW?=
 =?us-ascii?Q?UEL7q9nGaNin21b4ouH5XUGnUm1itJibITINLksoiJZMZ4dEE5xykLXd7dqI?=
 =?us-ascii?Q?6LNL0A92KeyyLHVjdNyQsSKY1ig4wMIN0MDb1mzhbnnBqoWKnCOPSwhrzSSt?=
 =?us-ascii?Q?LW+mPWzfQ/rpX7oUSmtbrmrI5OoyEUKg5qu4j06L1ej259tksET1bUgKabvU?=
 =?us-ascii?Q?qcvojFgdWSWo6EGof274i0BTwphA94Drd5BfpTnUxF6DKhY79NpwzT8fdmeJ?=
 =?us-ascii?Q?2lXQe23Asg+pNbA45SRYQrvsmUGE11RH4DsTrh0V1At4QD1KVJajZys0e4Q+?=
 =?us-ascii?Q?aHxvm99f2dOUEOWCecYO2EtGbOrKwOHt2EB9CMxWorldvJAfw+pvyxYXqT9k?=
 =?us-ascii?Q?4IZzX8g05lblx73EZ17J5ewrjihuTGaaKia92FxffgVfm1GiPNmz4uOPC2Ka?=
 =?us-ascii?Q?3lTzGRqYby2grFBqq5OXNEXWY3C74ZK/Z82zjnHc7s/Gt97a5F2Duq4bfXMU?=
 =?us-ascii?Q?Mgb1BLs8M+a6+jSFG4znvCW+E+SWkytTVG74PadxDdDGv3LT4x6G2Yi9T6b5?=
 =?us-ascii?Q?rVjvyztGPCMjIc7wSWGWchol5iPXfRNEmhpXlo5Es0n74BKvbGvqqim+JelU?=
 =?us-ascii?Q?A4wDyTDrdLOhG0IqtVmbnDwaT/NvhrI1peB5cVoILqcNsCsmXVga3U78yalW?=
 =?us-ascii?Q?JkmcgCq+UsYPiMJxrvhgAtgLmsCJdiV8igolL2gtdGhq1J2MgO1n/I0cuBl4?=
 =?us-ascii?Q?5w2fc9mq867Yq6jC3T6R0W52ifQ80WZmNw5fqBtYbR5lOPNvVqLnKnLmQ54F?=
 =?us-ascii?Q?kwiOZhR45JFWyMI+r5uaJr/KKHqjGkp+m+4mvC0nXlJJGgLK5O8vNp8z5PEu?=
 =?us-ascii?Q?ebIwmARDyQQfE5A5gbP5JMZ5Vjegitu2Qb+AKn30nTkdd0xAY6GmzNf2l4yv?=
 =?us-ascii?Q?BjvQ1qKexK9zWgK/G9zLlwrsSkSJKMRoAuNNVfiv2DNSRSQXQxRgzBxzjEgg?=
 =?us-ascii?Q?1BG4HWuWzwkVMK4VSa+8YEnATrOK0Gm2xT2Vmu7SBLbYLBxe0dJn8tc4trLC?=
 =?us-ascii?Q?c0BYlWfTcOhW/uvoSfCPfUPvmBo9LaIvb61wu0Y+4aYVzpAyB9FLXer5kkk3?=
 =?us-ascii?Q?o+GwHqIa2duu5vz1WAH1VSkJEcyrLQhlbVxLXvunPHhjQA4QMnmMq2FT1cx/?=
 =?us-ascii?Q?qhahJu95nyyL+XaisHyWePJa6cn2/hvw15XFWP1bSL7SLJvk61u0Ov9Y8Y1Z?=
 =?us-ascii?Q?ujW79RMapo9nLZHv82uF+N1DtKmuAW1RBNoFHUIvPY2RULXtbEcxsxH1nqpN?=
 =?us-ascii?Q?0Vy22D9vKGdPfPZW4aHegJUo285/AF8loMt7r684xMCCMkpDvaRGyoo72KAb?=
 =?us-ascii?Q?MdJ6LDk15YkxTtJmZXxl6kEukz7SuA+SM9SSeNdMkykewKenNyBjjoU76MfA?=
 =?us-ascii?Q?ML2b2FiCj9u7yXWXPk2CEr9IK3rqHGiUhAACASk+V2iCdS5WWBP78KCqdgIQ?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mgXBmZHoH3RyuIBqyP5GLdHLxQQWqtQGiZNUjhw4fLqm1HjGk7H5WWkJguqJ?=
 =?us-ascii?Q?YOlfJY5mqs3SK27BqLhq1C29gBB426x0Bq2RaJKjOSzcUyeiMZ8wg4DUUf0c?=
 =?us-ascii?Q?2BuOXigmpKzNAiefhKJSiYeN/DUMcuB/5rncHMYXnuiNxPWjPlvSrHuSISi1?=
 =?us-ascii?Q?Jw9GtBmuB7U5Mj4ylFQ9PSz6XnbHzUpKqOQZncs0TxnLbXsQbLFyDOnbFJ2L?=
 =?us-ascii?Q?S/WsiBYcpVwRMeZzjmLlEj9V4RAPiTSfHmArurKLju9anCySZfwn4KvSSOvs?=
 =?us-ascii?Q?CpfBa6zaC8pBMhcFWV6rwa64TNVvHi4GcU23R1y632it+cE9PQV+vpRRxh3b?=
 =?us-ascii?Q?F+yHN8ZrylfnQeG5OareHczt05RnzZmJoLM4NDDTZLUXMh4x4sn839SrBB4C?=
 =?us-ascii?Q?5/wT6eZ17AHuATVIhg1ZEPHu5aidaHbSoI4SiYdRV2W/c4HcBQjQO1dNW4SV?=
 =?us-ascii?Q?yDzqEqqwJvO0rU3Gy+bS1DFjh3j2f3y9YQJ5vzmq6O87TmWEEhPMlUZnkbcj?=
 =?us-ascii?Q?0OgQr21+SYh74oRhRZX+PdQodplV6UwjtuKLn00Z9Ud53VmM41F/NkhGaMKf?=
 =?us-ascii?Q?D7ip70qtVQ0eaLTIq7ForscdpbifQhnIAVIYWxROIZUSttCl7Eo1CXXXv8Zm?=
 =?us-ascii?Q?BcDO+thoCXRZ1XjvbxSlLQVtTFaDQd6NwD+ZJp1+JX2gjcJFvDRI2ErHwjc0?=
 =?us-ascii?Q?VYZzGYhsZiqixzaVbHqaT5zah650M/BNlsCWUXNOBD7FB0GhhNTeKN9nVU0R?=
 =?us-ascii?Q?6gw2YHj1YgeXLFqYwpg2BZ0dywNubSb/JakgSGLNkjYJat2m/7FKYXzeWoyS?=
 =?us-ascii?Q?AS1wMisYOn72SiuCGOx5lO683Z8AxxEsozMRh85GJRfcY/msOiunpTgS9iqg?=
 =?us-ascii?Q?l/LKHXNIsu8D9QCnrGCVTcG7aPsofXH/T0dzHETFwxg7ZZxnOf43vzOvzLfM?=
 =?us-ascii?Q?VYf6b/Yr/alzfPyU/E6zEfe/CTDGJ+6vTxP1NlRYrsSAPhZ8rJx0Ak2voQt4?=
 =?us-ascii?Q?rktv1uDoON9xiDkYps6DgfJttDRQznoSkeBWTfQEk1ltvVEpuS9MapC3Mpgq?=
 =?us-ascii?Q?OxhxMR0qwKRjlG8hCP9zsxYREd7BnaePFjTPRXchw5ZZXsN3akNkf5SmQTn8?=
 =?us-ascii?Q?yCg5LxYAnYc7n4IyvYbuZ2kP2Bxa0muDf22laMF1mRojMs1rcc6XV40=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62eae0b-7130-4727-3f5d-08db3596ac25
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:29:05.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRwJ9oUpzekyMPQBnUPYQc+NrjHVe/GtT6wRFgKDIeM7h2m3+8RBzJN1LKhoJyMwZ+NBmX7Q42QQ2REQQV+BhGY4nOmwzOUdJG6vpH6yIQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050050
X-Proofpoint-GUID: UyasIRkzKwehl8YjLJMlOWvvGj1BsXGy
X-Proofpoint-ORIG-GUID: UyasIRkzKwehl8YjLJMlOWvvGj1BsXGy
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Sun, Apr 02 2023 at 22:22, Ankur Arora wrote:
>> Allow threads marked TIF_ALLOW_RESCHED to be rescheduled in irqexit.
>>
>> This is only necessary under !preempt_model_preemptible() for which
>> we reuse the same logic as irqentry_exit_code_resched().
>
> This tells what this patch is doing but completely fails to explain why
> this is necessary and useful.

Thanks. Yeah, it does seem to miss that completely.

Needs some massaging, but does something like this clarify it's purpose?

On kernels with PREEMPTION_NONE/_VOLUNTARY, rescheduling of kernel
tasks happens when they allow it -- for instance by synchronously
calling cond_resched() in a long running task.

There are cases where it is not convenient to periodically call
cond_resched() -- for instance when executing a potentially
long running instruction (such as REP STOSB on x86).

To handle kernel code sections which can be safely preempted, but
cannot explicitly call cond_resched(), allow them to mark themselves
TIF_ALLOW_RESCHED.

Contexts marked such (via allow_resched()) can be rescheduled in the
irqexit path. This is, of course only needed with
!preempt_model_preemptible() and the rescheduling logic is functionally
same as irqentry_exit_code_resched().

--
ankur
