Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11771672A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjARVgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjARVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5D62D13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKnG7X008508;
        Wed, 18 Jan 2023 21:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9/bVpuk+uMb1Bj437tZwCfjxm5pp41gQevBuBX5gnVU=;
 b=tFjtHm4Fh4ToI7ZKgMsKsMndeittouwmQpDu/Ks2Jd/BlSQ36xczYr67gnmGrcVgozv1
 6waEqUz47ndBSbZBxVyNWi1I+3aGwrDsRAMPwVFZ1KBmE+2GUn+mQ20mOuG/V7YP2Kpc
 mi7lEM/AANpmVAF45jwdhSsLxbAdwcOcC9P9tY8EP+62cJC7mII2UeJ12jMzO/gCDsWs
 P+KaG8liovY1kECVxR78Wmie7rpQeVU3CxclxHfwtI56qM3dRyLFZP8a75pOLWANNOC3
 XsBMh9bJjsiu44uBWYOmO5MNvsQ3mcMuFw2PKVdoaUHqsQ8RO0QYjakgPROuvu7vY+bY 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt8r31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:35:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKSq4Z028461;
        Wed, 18 Jan 2023 21:35:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quftm68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP5AkssXGR5Hw8qQ2IxUyJHmlAqRipHI+ohbCGRCt8gTU/4+/9ZUkeW8faJ7XZXUVoz0hs5Hvgn33UTfAgfxHtA5hbhkrEfhJzXNzC26gAN0ywuhyfAnQ+FsMPrbMZBhNwoy8Zub0O50SXnN3gIRvOyTpaLE8iHG/BATKNLzMSvOu/XsjeHwejP7YjnntCDaHjMGiKZQNm1UF02DYg36bIAVpkumtHPt8/JER/5FrTnyNrUUgwogndtRp48Eu+3TkNYqu0nKABJ3+lKbJbXj7lU9NzbBQ9aINOmDtRe+M+ZvvH/+ZMmlmBhuiVmwnboqqoGZ+OhyQ1IUMTO+0yowyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/bVpuk+uMb1Bj437tZwCfjxm5pp41gQevBuBX5gnVU=;
 b=PNySnz0UTdY/LWqGhSx4QRtS/OZG/+7gWD82hNR2Oo36SR+kmr4VwWM9VRJXf7GMoVXx9faS8+pQ+2K8SQM+mtZjb/IwSWM9ny3sNqglNRgrM9hG+5AwUTp/XZEMMrkHSD77avdpoI8DIBMzAPc67OefCDm7/BkBfF+wkOIHCmTQZIYY66jgqrOJGxHvJYAPgu7C44KrmbHnWRsf1bLlFjK75taGzbgMdYErlJoz8yp516mtMzfIPjlmb5jh6L2l9G9bB74+GazLT9u12ItCuCbYGMerg3GjC7IPh7pQNJzrefIaXHlQtq9mIlLN3L3QtCE2xorcSnm67eIy4DEKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/bVpuk+uMb1Bj437tZwCfjxm5pp41gQevBuBX5gnVU=;
 b=ZfEYPzOuqKWvYg1V/IEGlHoeOeSN/VxiqgMhZJtkFcYZxEOPNN5QD7nCfq14c276gWkk1N9W3TWRo/ZyylHlVFBMFHkjRl97+tNZO4BpHFRIYxjCrODiTJMTsscOVqgpwPvXrZibkDlFjApDLV9njp2Q/BT1U44Mp4UWRCS0jlU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB5710.namprd10.prod.outlook.com (2603:10b6:806:231::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Wed, 18 Jan
 2023 21:35:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:35:55 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v17 1/6] crash: move a few code bits to setup support of crash hotplug
Date:   Wed, 18 Jan 2023 16:35:39 -0500
Message-Id: <20230118213544.2128-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: e15d2aad-a547-4fcc-2fb5-08daf99bfacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T9ac6n8SG585o9dQmv81DWAuG4Z9ES1PJekU74m7NTrbquF8B+J9JKzJTLuqz3X/tBRdtfw7lAzP2XYCFArjUqR3L4UWxAPTBE4k05l7k5jizVrn1bbcxjNphdD0LcnE07NIFyaDEGGgTvPYfjdD63SI25JYyT1Chcaye2oqbvapFeDK0mPXXMfpYQQELwUJJTWPe8SC/De1ZG8KfBzFAUqp0MOKVxgjiqymkN/EaA+/FKkH3u6Qid4v9X3V94RQiIMebTcZzf0vwh8MStwIkJuxaPkV7Sw1dlsdwnMaoD4PFlFm0tqElDGfDaPqZ6OJ6arJUJFIcAHyjIBithx9Fv0NOVBBkZAYtR00CJd6L+zTWMxd4U9CmM0PStnFrIwi41h0kfgDkgc4B8gU8JUrLLXE/weYA4VC12iob6/sBH0G1aNhdYY6TOwyPlA4n/OEtx0bgUTpHDNnTrDKF0db86vYaJYfwl7VfcnDiN2HQDGC91FodWqK/L4rrxSw0avr77vwSMuZGoZvNDWGbrxBf8qH8rbKt1P0oPUfSXRpsqxk2Dc8ehcY/RQZciFF8sxXRXfGpMpReOetkmUJqQgYt0NtxgcXjn00DK8Ly3cXP7JMKXhNUXkByd75YpBpKvaALYEWrpd/QQesSEo/FKdrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(36756003)(86362001)(316002)(66946007)(4326008)(66556008)(66476007)(8676002)(6486002)(41300700001)(7416002)(8936002)(5660300002)(478600001)(30864003)(2906002)(83380400001)(38100700002)(186003)(26005)(6506007)(6512007)(6666004)(107886003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xr0H6H+ovbcyh0SdiwDEMS7B0Eu8oqqW8QemvE6ls+eYeYxfVQy0uNbk4Zv4?=
 =?us-ascii?Q?J2JZlX9k4Lc7cEznkohVhuNDMmpWmK6/ebzAnmhZgRFsDrD7choxPZmYRwqo?=
 =?us-ascii?Q?BQripHB3LlHqWnxLdqclfodOE2iA6Ku4KCGhCSLvtwLckkZG5YDvW7zbwo/9?=
 =?us-ascii?Q?w0aqrtSyxLAvymBl5y3gLceXYNVP0fch3rfHr+1jOUyW9QLWUQe3k92FvIH8?=
 =?us-ascii?Q?9etVy+Al50dJ4Hjl7OZVNixFzOEz/75Cfn9EssDKajCzUvjkb7yby1IEfFS1?=
 =?us-ascii?Q?FAYPgTSMT+HHCfrZyHlyfrwkkbZ9CgfybF2vkHZDuwikxL37Rnz+cZ5Jrhsp?=
 =?us-ascii?Q?UmagdenACW9RuI+OHkXO4xw75uberTIWi6BI9pLqd6z5odpHoy6/K5RTz2ra?=
 =?us-ascii?Q?8cqmLtHHmI2iMFgUkANyapMNGdtHWU80Km09/9LLFJ4TBmS4uLYQ824ThHcE?=
 =?us-ascii?Q?gnuya+Pkcvc/t0Q1JVi6rfc5oSWy986ODKPz4rDJmIjuTvkrVquoTaAIK1JC?=
 =?us-ascii?Q?QUogxqICimcV6kkI6HLf+PCFc35jbAyYTmIGRl4/4Aez93aGtePOjdTgvz9U?=
 =?us-ascii?Q?bCjGhrQvb8Rf+uuqRoFejTJrrF6F8nfKdJdThznrtTciee7lT1U2rneqHDqV?=
 =?us-ascii?Q?NuZ1zI+Cekr3eBdQvVGba71oxnSWHlArftqVTIwce8DqIJIiRfVHmW/xPyo8?=
 =?us-ascii?Q?Ew6k0HCqAiHaOcfJqjz78tCnkoA2VRdfRqgQsNLPIe0beV8ulwubqXI/kyDr?=
 =?us-ascii?Q?ywuxd+VpwKdYguSVmOQhCJLPFAQsTxeOFa3KnODLvxj08ECCVBPpppFji0NR?=
 =?us-ascii?Q?ZCh/qV7YGI9KwkOpANXMKb3UGnQor4b/UKttbeTB0NCfJ0YMpyZ558R+Nsx3?=
 =?us-ascii?Q?TwhGBHC4mBtOJc6VmWOdvlYACZR7K67udgrlkO8rIIYK/ka3ivrzeYY7JGW+?=
 =?us-ascii?Q?db8Vrak0RifNONeyrYRekf2bZYvHt+XtjZTDin+pUCvv7DcKc/15aBFHNRWX?=
 =?us-ascii?Q?r8XGRPy/+bbHLMcPclme7KROOL1QTH7U0Ll7OiK5jFJ8RpUYTGuhX43llbyE?=
 =?us-ascii?Q?LDo7jHF+rVmWUmgWUlGSYZX4J0E7Ia5/IKxppFzbjtHwYkV2GxehVZP7Qnn+?=
 =?us-ascii?Q?Mn18wdLR/wyMBWcpjYEOy4d60GwAsSi2fI0uZCBZW8KTDdStTtYA75mv8GTv?=
 =?us-ascii?Q?EGmgkGJr/b+ahxxq46y/ZVGi2Q5kOVKmLeQyHj4fUCHoKr3FI8sDRv1bdz+Q?=
 =?us-ascii?Q?325zPa0rlJuw8i1jVIAalySNKjHjtuQetww6FPukodkuLqYsgoJ5rYKlrfvE?=
 =?us-ascii?Q?KE+K5TwGR/mVGooq4C9+BLtpSPnT0EsV6PqkCmQ0Ssf7NBe42QAGBsSym+DO?=
 =?us-ascii?Q?6FwsQCm3fzz2eS9h76QlU1WTZyXJ7QpMlQAUVrCpbP3WaVhbqT4GRI74RtPu?=
 =?us-ascii?Q?Q7n2EvKv9K7nQ5lCS0fsUyYbx+oiB9WA82s0mGMvujuL9kTpgRBufTtSVYxL?=
 =?us-ascii?Q?7rXYtodljULTwpHV+lw/kIDbov3Pt33lCouHS9bYCIWu0u74z16LkWNI/p2H?=
 =?us-ascii?Q?Vxnib8C6/1hUtbc1XmWvPu3rgiVOuNzmWIEbJeS6KJtkx7/W0G6LSvCbZk0y?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xirXBkNd7UpbD7593Q1GIrhFaALXvotAOexIEylmYs10lOFkfmMnxapFLBi/?=
 =?us-ascii?Q?pAMQt9U6iSsAAF8k5f3YTlr6sCNFgmA9sFO/MSIqVKcmxx0d3a3A8RfSwAhv?=
 =?us-ascii?Q?FgHZoABw/GfljmivZISL9ubb5pSKmw1+csKWwA6Jf94fPgMyUdK20b3b1GFt?=
 =?us-ascii?Q?JtP9ZM/D8Wn0DpauMgIE5mHethgQRd6fQsIH9Rljr+cop1u5VKGtowkaW/du?=
 =?us-ascii?Q?lr2hmS3ucnFLa8WXCBrg9UiMCY3Cgo6+YXy92GoU3pWxH1XJb7PBPjc5V3jp?=
 =?us-ascii?Q?zPlJvAK1XeIEhjWoOvxLPav3YvOUGPpWAj5qTXp5YawKTqc3JYfjSuklQbZ7?=
 =?us-ascii?Q?0UET7QBOVEdhA63SewJDgDOeRlWPDPEW7+SkKa0EET8tKGgYpiHfc8OcXyQu?=
 =?us-ascii?Q?+th8Oy/aTMqXFq7vxDl+RvNt+0U6TZEHvUhVU65uE0V/J8MovxAYb8XYMKZe?=
 =?us-ascii?Q?Iry91M0ZqMBgW9DZx1Yy1aMka3ss52tn05DHTXcR5dz7NlSt/VCM4ngkvvl4?=
 =?us-ascii?Q?EAMzCr30bobCDzh6cx44hMtaJFGkqObHeJDwSRuq7CjMA1UlIgByeCfgkzay?=
 =?us-ascii?Q?vwt7nMXn5WuddBJkZQp2YaK3qLW4Ow7ecyZAnbXEvC31aE0BuyXUvWNEA6dq?=
 =?us-ascii?Q?7V5wyWa1A/gIzVgKAk0wGTTCGW729HbyAljlTAaKuy0G6m+smG4BmphYkl1v?=
 =?us-ascii?Q?vKXE79NRnWKDiD62VnUo3+vsmEs98JMe7s35Fw8hh+cHV/uK1crFcIIZ69Ni?=
 =?us-ascii?Q?w6fhE04xHNNoYSd43LmsMGwtU8T+BZxXoMwxkD93gQy1R4CXaUD117XYTUqB?=
 =?us-ascii?Q?eNPwYT3T9W7VQw3D5cP+dQ1wz5QCsgnrc4LAQHAHQpvUucqrFGy8CpImmiOs?=
 =?us-ascii?Q?O05/V+emfRfo5cr1XUCtUXYyKTG9WtqMTVA0S0Mc/2ZzyAvRgnbOA03tiGkd?=
 =?us-ascii?Q?MXIPJJHWr6v21HFO7Q5Wn1ywuoWVXaJv011dYyukERGsaD8drTpP9zUP/j6M?=
 =?us-ascii?Q?/auHAQj+PGfM6GbHYY8YceLDGg8vHVeJY0608n13PuO8d7tlTBeK7w6MG23m?=
 =?us-ascii?Q?VtY5mz1Ff82UClh7A+HMM0S2e3jzYMfuKqROfVmD2wIK0OtnxFngGflOiY0D?=
 =?us-ascii?Q?yK9ifKETJn5InFbJJIVpyVn2ZLNDs72RIC7o65LDd9m3ZGYC81khShE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15d2aad-a547-4fcc-2fb5-08daf99bfacc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:35:55.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GzIDmFz9xkc5RqHd3ZHqCYGZMnb61edbIqLcyM8m2Uy4ntR65nuJmvx7Bf/yqcI0JlIwEdbTi7MyZ45CNqYZubpjGKnsH91VN5GFx8MwSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180180
X-Proofpoint-GUID: mt64nRicdjY4YcNgftTJHCo4b5LDXYkt
X-Proofpoint-ORIG-GUID: mt64nRicdjY4YcNgftTJHCo4b5LDXYkt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To support crash hotplug for the kexec_load() syscall, a few
bits of code need to be move outside of CONFIG_KEXEC_FILE.

The crash_prepare_elf64_headers() and crash_exclude_mem_range()
functions, as well as the struct crash_mem are needed for support
of crash hotplug on the kexec_load() path, as well as kexec_file_load().
As such, need to move these bits out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..582ea213467a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -238,21 +253,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 87ef6096823f..8a439b6d723b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..ead3443e7f9d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1135,184 +1135,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

