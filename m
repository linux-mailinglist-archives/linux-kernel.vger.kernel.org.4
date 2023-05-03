Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D96F6167
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECWn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D893F8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Homsu017456;
        Wed, 3 May 2023 22:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=pYQ9YTHJttRtfWQfKeEO9ztZhwycCF8FJtcgSwpwf/4=;
 b=rbZuznYNwRsfG8K+5SRZMD5hEWrPbAifXQaVjPW9NjbjZhYdjTN+Pag6ITAmT7lihNbJ
 AbN6h7jo2JpstQ11tZepU8/US0I7UARqsY2jaU3PsDDN2CW1gggnzeRjlrt90K+6jrzl
 IlSDY3mwilp8N5+ApLKvuFQtp48ygYam0dJ6RH+LDoJOcv7MxQMitejKiuEgdB1QT70Y
 C1sPch9RN7kEg1aGTSymgZh7/IWK4eLmEdfiw/ssoUlo7pGrIEVhwesL74YCAsli/yss
 si4eczR2KTI9iH/Vgls2j2DHEU20NfsYCoCf1mxuUjD7I9vMPpogA9CoYLDMme0M7zRW Lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ardve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343Ln8XT020789;
        Wed, 3 May 2023 22:42:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7qt2h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia8dsgWUCmryAKJQrMg605Ce1v4h57k0AkqeFOOFRp0ROzVVFDcKvaK6Ulh+lOTT88FWP+unSa9VnLdkHT1Y1zzKv60lZE+2rT0ZTR0jjDqcEUcAEpPrbSut5W5r9GFna4s5dND/ruDPTxI1X/0rTyZnhMLUCT+V/Ibi1CXl87QouGjNbe6VwlI9CEJ6rAMiqRqdsM7ETgVlwYr4H8vvLzkogivut4GkHVgOJmhZQINJ6ywAdlk2zTa4+yTvv5K0ot2RYIJBhjrBPtKrwOk0imxFnexqp+bJNBiSvtooOX79vYMEafPLXRz6M85CW7086Ogs77udZcYMa5nlmEg4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYQ9YTHJttRtfWQfKeEO9ztZhwycCF8FJtcgSwpwf/4=;
 b=U4uT+dHKQYvGARjPMhMRQeDvZtRvResSDt6aTuZh1U6w/TFZ+OViSjtVENs3gfBkrAN1hFuM9SKLsfsmGx8TZwWAY4nnMzXMY3sPsndujawY4oU2rO8KVSOn7mO6o0q5OklwahlA24owggni6kqE/DHlFCqbI775wscrkFloHCdo7ZpYLfRfS19bmVDebjiRdmqa8cux/TGOvZhnFDp+EJ/t02kZPDn90K5dPxR1mHf1qlyXcpNSdu6+s70LDcK7pNL+Jy9S5ZrcqmLFbE6SmLxU0FibIhWHdM2VMhcfIVv+xrOIcNQkZYt3VM528+FwzaM1EyWeITJ8Jd9YAGx4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYQ9YTHJttRtfWQfKeEO9ztZhwycCF8FJtcgSwpwf/4=;
 b=vVDqubV+yklDRu5meC2HAiaA4/6mlwLrwTIzTjZ7g6Vf47GKhmxZkrqyoiYJrcLgTj6w/wpoTcJ8+yPJSPXTGGCj6Rg6AULAxKva7I7Ns7Ieq3KoeyMfq8cRaxo9WBHlPDycA9+HDR1WiGKS1IUR4q5/9ThN7Z4tY9T4d3ffaEM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:42:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:11 +0000
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
Subject: [PATCH v22 7/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Wed,  3 May 2023 18:41:44 -0400
Message-Id: <20230503224145.7405-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad639ce-f78e-47a1-9396-08db4c27a239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3QhJiUuF+/xAFa5CSnKc/Bf+/BrZmMwD89QoKZUj69GtYXraSavDCt/MIKtTKM1GtV1jUVk4QtvuU6bo75AFOXYXgWDd4jqma4PS9JgMQetApd5TfH3a/aqODebJHtBLf9Oz/lrEzL52245ofdl3IlIim2BcKaZ5mxCkLH2GC+xcLYJqejIRPQtCBbGG57ptuBAgcRkHnfalGaDiD8vyhq4wZTcK6N5pwzhqXcpKHZIYG3v1eCyxY74c9kO00WLb4S8fLGn98NoET793LqwTRRLPzMLf5LuSRmvQy8ord1jD+W/da8L986iH5A1A5GI0fhwi3LqP0HJfvWpiea3fo38qiOgxnMn0JC6WWK9vgSC5j6d54GAKc+yGdtdyym1ZxUfgbv0pt9L18sz8l/AlNXtpaQUGRkkZ2Y2cy/KJ/GKgErOLCX9liV0byNKY8Soi0dMJAUyFZtteZjpqDc7GHqhphP1D+d6tu+3Z0rrasIUtrYKafKAItigup+fQkhoCJVnbxQ7M8JVH4RMy3+X6816S80Q6V2rtG0xY9PSz3s1m9bzXpQKzsyzd474zGns
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(1076003)(6512007)(316002)(6506007)(26005)(186003)(4326008)(66556008)(66476007)(66946007)(86362001)(5660300002)(478600001)(7416002)(107886003)(36756003)(6486002)(6666004)(38100700002)(8936002)(8676002)(83380400001)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/f5L4uY0L4eFlGgohPKtkIgsruHS+k/nuMvrxS8m/bJzA7JW9VABFyQB7jEM?=
 =?us-ascii?Q?Qgmgq0k+x+Tn5NR/ixeUAk4uugu2rkTa/uQXG+JET32cv3r23GPLu7dCWiFx?=
 =?us-ascii?Q?US7aaakLKvl14MZJVMctiUoQnGQ6t31ZCUvp8+NMUzbNR8M5Gal0uJ3Qb75J?=
 =?us-ascii?Q?HlkMsiiXXsjSCSJOvRo7AUrAQUnKRim3smjgPfHTfDyw6Oiv5FnbeiRPbMcv?=
 =?us-ascii?Q?wYWOy34qzu1MdY/NUk4qk+ArOyM4BpyvwQB1gxjGKpyGR1A0XsM/8jKjoIU/?=
 =?us-ascii?Q?gH7CDYlz7Q14SXpB1dPZFBTf3pHNinfQTvJF9U4hEXins7NXto9TZ2bOCrVs?=
 =?us-ascii?Q?9JvE1YZsQ2wcMeyJUQSOxpxsgjl6XtB6iu4MG6e/TJmcnIdiefJRB5hl3Fq4?=
 =?us-ascii?Q?CKOr3RH3jRbcaC40gBL7kUMllAZAdPip66I1GME5Gh0GSh4O/Kh2Wlcw82Jk?=
 =?us-ascii?Q?HeRlO4jennRg7UwuDaTes7DfbpDtSrY8C17ZOu0VvdLt4tC80x8V/e/KZdH3?=
 =?us-ascii?Q?T1nLlQxxwY1rPwikTyqzN5qG01gF0gskN/u13sPsPvBmeo3YLR43HKWL2NRK?=
 =?us-ascii?Q?ef7un0Weoht0E255DfIEaE1B9kwsB8dCRK0mF+8jL00dN39+Hr0xzgwjfzXQ?=
 =?us-ascii?Q?WcIe+k1xjL58BLBqbLMoQmumQVcC2DFR9qCwaaLlM6YGAwSaBbrBUt42yYR4?=
 =?us-ascii?Q?m0cMlHAvvKKR5JjNvyNaAAdMSPtCkSZdLn2UZwCgiQmBJ9szt6A3yOPEb4fk?=
 =?us-ascii?Q?hpDXHFeXw5btPydoOISRDbC+VRf2PuGMQsIaDlSDjamRaoSF5g3OM3kb5+V9?=
 =?us-ascii?Q?1gJQIVgf06S6n2NjBk7/Oy2QezfmlyqwbA7Li2Tugnwf4M1NFfk/T0PcTesR?=
 =?us-ascii?Q?m+dlbU/bZdQNDuOO7lHH5MddogfRCLeoQdeExyguIiaX1yp9CbkBKG4HX0Ix?=
 =?us-ascii?Q?+oHa2J311dd4SZGd9b5ofIV4YlEay2ale5PB+LO9f23xbPUi8bQdD+081M9w?=
 =?us-ascii?Q?wB+7rjZunvGiXYHdPQnlHnOYUHB35+Lw1taZQmKIY5ewxkrlaSk/pwS6UYdC?=
 =?us-ascii?Q?8KZZ43/Rx2ZgRtqFgIIlMykn/64gl7KU0KsKtR1gro4Z7TNwSp/SnF1Sq09J?=
 =?us-ascii?Q?j6t4PB8QASw9ILMkyXjFNIKQI8Wd+oQtoME0BLmO/fn+1ZR6/FQU8c4xOUNN?=
 =?us-ascii?Q?LOHfsHe+NvkIzu07M5vca29KTGmYJC4loviN9Nsvm5SpjTw4vRqKswFc+gq4?=
 =?us-ascii?Q?v5k+EjdaqvvfgiEu9ua///tAMamLWwDLsU1gk8zPwwWf+MEGm2lzG94tCCBP?=
 =?us-ascii?Q?ECezEhNQj24O9q9SU+6Q3WyPz/OdVGy3bcSKSchenVHWe5VIV+vcGCIxOIZ5?=
 =?us-ascii?Q?CKxYPseMe2p4AHa68Poko+7fMw2PVBxACaX+auAfCCLouSQY/8+mFpjMBOA9?=
 =?us-ascii?Q?Btl9Aj4F7rj9aUAP63eN3gR1x0kEEJzObr8Q7Fjtc/38K36q3rkqZEtH2VKW?=
 =?us-ascii?Q?ioqefkH6jDPJwf5RXNJfbbLrLDnpkHXw3upvTHPhCCMHVCIDQe42Hu3Eqson?=
 =?us-ascii?Q?pn1JIYMED0l/jKRQWlRO+h06Tu8FcbGpVsWH/OEI4gaUVwXO52JQi3U/Fonw?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WL5iPOhBnuMo1lwmoE7bIKsws03wQ31B8K1/pNSJoSsmebMQkgH/3h/i/xEt?=
 =?us-ascii?Q?A3iKEOR7YiQz+aId7LhmdQlJVDMlxFxYKNWcMXgdg7yi9Iwq/JHvwltyI3SP?=
 =?us-ascii?Q?P10tWFjdaw7D8KEe3aXe/enpddVT6eEMJtB+Xfytsn28Sbz962N60dA711eZ?=
 =?us-ascii?Q?lAKRKy8MC03/oB1L7wt27H8CJ8fFzV0UftT+6eSED/6tdVV/9IJLMuH4zSIl?=
 =?us-ascii?Q?wUiMEblCNwxOxkEVfmqgDJfPBj9I79K9DmI4L5TmSQkgwEkZIh01CnWPgX0K?=
 =?us-ascii?Q?bdVSY+ooM3H3eNXff6xRppa7Tejk8hgayC58L72fkwPuUOf49JWQ7S+dOSon?=
 =?us-ascii?Q?n8T+aM3QNVOPUj06mj3snDtNGe/qftq+1O0kua2tyyXmD4sq663gZf+lJiBZ?=
 =?us-ascii?Q?SThMCus8cZikypFdfAzeeXZEDO4Jua7fTU6eUDQdtmPdt1Q7qTToT60p0JRG?=
 =?us-ascii?Q?vxu9oHt01/tVOZT9VO3RVZigyWl5CKMUqjcrG+JDvroKhtdySNQt09r9R3v/?=
 =?us-ascii?Q?7p/obLj1EMa+Q705R5XGMHKSQ217m2WHTCRF4Pv74hFwqlADDWVxn6TGw99E?=
 =?us-ascii?Q?zONMCwWazLJFNyrmKVJ5OX4pYBvVItLKwSGYvNYpWWhWroQxPANImnXc5qvZ?=
 =?us-ascii?Q?vOPBSoKVHCFpgNdEOY7kpLoEO5JqSGnLkK+Kmfk53qdd3O0kYpUqW1r8ZM65?=
 =?us-ascii?Q?o0cYSi2UfTYbyUAKBRiL0AWOWSxYaFGAvMOtXUH72yV+1A38pjdlfkU5gd4v?=
 =?us-ascii?Q?TpIcqTnBbAcr5HyuUnE70ZspiC6L6zGxCR1xeoApfiWeRaYyHF+bruORP0H5?=
 =?us-ascii?Q?HXyEB9g5zJcpdrFuNWjqF9i6Ejqqu9oxANQtHUlYMcxMgfcBpLEOamnn/9bm?=
 =?us-ascii?Q?XN7D1RMl2KaZlEmIVyXv8SRNE0BOnie9WrIY3j2X+OyLD2rlz3GOnqBujWMi?=
 =?us-ascii?Q?ZzvKQpJ/C70monFJtl4XCbtPB9rmpqs0u8OEkF4n3IjoNaM9VbSrJq6HXgKu?=
 =?us-ascii?Q?jHT3FYTCWvVzFi5imq91k4bToVAnSNdmuFkUroW0pCqcLjqKO0LZf4lm8/4r?=
 =?us-ascii?Q?BmLxU2blfFd2WBhCDLa6EkD0c4MPa2l/riGSrR7miwQb5dEvU/AxI2/VllxB?=
 =?us-ascii?Q?9Zw1UMqCHoZzsHxKAM7DUSyNLd/7ipCBn31yMhVNdNPdSskHblKL/Qw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad639ce-f78e-47a1-9396-08db4c27a239
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:11.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+eF1mha4pg1QHeVWhkx2QzuXwLhOhrzipiJ3wYX5kO2bK458cl9j/CVVuXZxcswldnSOkcQqQpOx01iFsSH2KshjFylwQZQW5QF6af1G7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030195
X-Proofpoint-GUID: U40JdNNQj_bwDfUISGu1TIH_kTnqdBqQ
X-Proofpoint-ORIG-GUID: U40JdNNQj_bwDfUISGu1TIH_kTnqdBqQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the change to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This change results in the benefit of having all CPUs described in
the elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs in the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index e05bfdb7eaed..26262789baf6 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

