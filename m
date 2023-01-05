Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A365EFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjAEPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjAEPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2A5D404
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:09 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3nS0014083;
        Thu, 5 Jan 2023 15:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=kf2FxYLSwP0EI6eMVR2LyhMitN8ghGBJj4oacoLulxY=;
 b=YILeJt87bvdc05xqI3xePE5nl+AZmp1awiK1eQ990Hmgj1nwEb+IsmFjvmQqdQTo+DrD
 9dyN7++FTyZhFkAWWnZMTbbabYgWi/ik8l5hJhTu1G24End6kEpC6sdIpNS6/Qet9Djz
 YdWTQLu/fS96COdPSS7wJrYDs9xlo30KlnbIFplO3FZlWl/zA/NZHPCWVL45ny0nEiqY
 19sgvk7pDY3DF9+w5ZmSKt0RDDEuuj+FPYHP46fVIuCyFpuKDeVxya4onzW/MkB+cxVa
 SKE6S49EziR3Ve2ulagygWOHeDvjKl5/Mbnh7+nR4Lb/FLH/Qy5w2TuEgaBMrt1NH//X tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9542-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKX7033733;
        Thu, 5 Jan 2023 15:17:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkexke8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+T3uVj0dSw/lH2ZXES1iD5smtFDX6nZIoSBxQS92C2JVsQMaNm1njEEzMjS/9kWh1P39YvrE01QcDYOhuGsu9PA/Rr+AVlSXjMObP11AH05DhyHyAf/2XygbN4lSPfyCCbc1Kw+o1oLRbiI5YF7rfS/aWbOOJGG8JLHAcrTd8xaPmscZGTCXN1uJk1NJOt2yoCbJC2w2NQSg+MjSOL5uyzJME0IFKQ5Si1Vn1+m4j8WxRG1GSWq/q0QTKUodzdh9r8ewqw0hTJ8HEJ6QVros4kPTYeyUKrWA9ywVnH7qe8z35L9sHDxxmd9fNHQmYnhHHDiL86B08q8a0awUjoysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf2FxYLSwP0EI6eMVR2LyhMitN8ghGBJj4oacoLulxY=;
 b=P3caMEF5fPX4lnyypZrymGGQgLtq+eALpxiT5Zm0i2WpfIxaTdFx5WBA8lVJc7CqoSAtQnCAe9ehrNiJDjuFtQC16omjE8lSccz3vpP4N/Wf0psNtV92poB/L9gAqzoZhvnWezyrhK6dWoNqQNBg4iEE3Tb4E5XD21FlRagXk7zNh8cdiZBgYDXLUM4jLtcsBsZWNKqT1R79Y+929tguky9ijxLG1iHFkqY0+oClu04r5rdw1JfRiG5iWUyDT+ZUewHz7PqbdP3TtYsnvy5SYVn/dPhLS6ML52BjV7AZOlrkoUxQgIT2HRrGagyF4mTrSwwTG4UTnL+HN3e0mvbV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf2FxYLSwP0EI6eMVR2LyhMitN8ghGBJj4oacoLulxY=;
 b=gJ/dFnTV0cExaGP8btTv+tIuBeVKdAGDlpem+1+Lf5DX9F1BrCljnM6R+/Bv5t48BF8LBlzUa5D8byuM30guCA6S+QmOSoWRxKRhu+OnxTOR1Pc9FsDwruFvQA5rB/fy8lOW99Zcld3v6pKL0/nQvpFpE9+1atcD7getzxwgukQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:37 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:37 +0000
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
Subject: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
Date:   Thu,  5 Jan 2023 10:17:09 -0500
Message-Id: <20230105151709.1845-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d1bc42-988f-464d-12c6-08daef2ffa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zbhtawma5kTxwX5GQoNVSqGT9FHbyCNqNG5Y/MZJsrKxyobn0pWARcLyqts5xBMvJ27Lq2am6e/GUqom+ivyUZH3Mc6W0u1+xacoW563EO2e4Zqz/oSU5eAVXhSdN0/CvfqZD59TGrEz4n/+gqiNXmwxTOAxkKyyWPdroAtm10v0KBH2Zb+v7SNEzJ1ms/L/cNGRkaTlPK0nfykxAPX8NttcWE3YH7xnTIrmznyUEHkPCUYBb5d0bxBkbSL3XpdJOusd9mq8nuIDSiXUgX6G/tZXoGIGECUOvDavQ8fPzwzr1UAiA9QiuSBnM/v2NGmQ+XUsjpCwsJ9EAc9CZOwYKjcWA4GP9tx0NCfyhpH1M2QMEveQujp069W2TaZ/uIYQdkj/+xj6KyyZW0qQeN8KLl+geLyhx9YUYkm6ZzdwL8UV/0RQ491BaHswQaUvnlrRYDfMDfqo/6dyhixe03vExM/mKUzeL9p7UO3NkQM2dDW8JMdaLOnec0idvZ6lQk6kp6c9ivIGzkTkV3X50lmo9IwvDHwR06YuDcVQ+/Uz9BwhB4fAakxN7ltitoEyb1xHApznamGymutN9igLnRVApbNhZV7WY9TIMuENfBjXgygLgxys4ErgZH2h7qAFxE95eP1OPSgpDJxhoIDRbuSv6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(4326008)(8676002)(107886003)(5660300002)(66476007)(66556008)(6666004)(66946007)(8936002)(41300700001)(316002)(7416002)(6486002)(2906002)(478600001)(6506007)(38100700002)(26005)(186003)(2616005)(1076003)(6512007)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dypo+CJkBDSchHnanw9h9A4IqQnj8AnXhnnEPLivUt8Strzj9UGQ1OIfpHrq?=
 =?us-ascii?Q?m4iwTrpnX4XdjO3T40rFiFJwwn1qbuzg/JET6Ty1/we4fdcUPwOknLGbuiz7?=
 =?us-ascii?Q?2lfCYb0aofPzbB8uhIt5sG4tdKMCVWClqUwlgLKD228b/Y8N9B68GUGNoDxL?=
 =?us-ascii?Q?F3fLWP2QiYc4ooPv8i2Cf5g37ErIdwXpsR6bMB4VasQXl5CWVYJ1RmYmwDY2?=
 =?us-ascii?Q?LIND3GNgmgvMEpUByzZLUse+eIv25oTs9512c/8xc+trcIi+7YiD3firtEc9?=
 =?us-ascii?Q?umJkSvjNX70dCsq3dpT3lFTqjbeTR62pCoHK60zFvLWdcncZDDBqmsYW6RaM?=
 =?us-ascii?Q?Gp+pMuZQ9Dpg9BSeLdOw2GosU2YmL1j8Dgw2bWnMzTDw3jiA0n50u/uNJJvQ?=
 =?us-ascii?Q?orbpY6GbIumTZVkSoq4z4Wuj27AVKkWGwJV0+lSFu5maEpi54c7RDNba0QiX?=
 =?us-ascii?Q?XhUHPUesBD4wxLMsfB9otlJ3SjJUWZ7y31lyqImkGxlRoEQikgP//P8T1ova?=
 =?us-ascii?Q?E1bnGRF0z541JE61VA80NXuiqm4MDpEx1vCR4C3smv9GxVxN1uhyrCHyopJt?=
 =?us-ascii?Q?RC6eWnJstFj3Mn/wBJvz+GUPRE+CBHnQEpuN+J8yiwSxJ4ugcGGmNWu75sXv?=
 =?us-ascii?Q?Le/Lfe1QfJxDRBeKGLVAPkeYWQzWNk2I+GktxZX3ia6b2Jz9PRYQy+BXaano?=
 =?us-ascii?Q?OxlWWX7KBOe/BIPd3WUnmGanuxlJsdCInWDOvZtDY2pPnVjMXw5HdJtBgRzt?=
 =?us-ascii?Q?dRuVqAZcYH4CYLpRfOKLHIzgn1c4JXfxwmT+EYw3f8CQtOAbDmiNfrswPQdh?=
 =?us-ascii?Q?WBmv7twThMRJPX8I8rOiZkv94zPedxD2utXOz32kUDur/EzPuAHkPbrSk+CP?=
 =?us-ascii?Q?/1p/AhnD/FkZKJJx6d4RiALbinhsB5XKS41yug0MpfhTiHCr0kQvGc3mUstB?=
 =?us-ascii?Q?lN+uJsLIWDTvXze/628qTDsminryktnK2HRu3SaEKaT7Vpvd0jhhShLvNQhy?=
 =?us-ascii?Q?TZMeorEqOEsUX/BRuNn2vD9/LsO53dspSGlKXWTKxZwi4CS2G7HX+k5bTuF+?=
 =?us-ascii?Q?Qkpnxafa7wZ6/D20aJ5PLv/Q9/PcS3OONZrtlOOMhfV7izyyZ+7bSWn4qxH5?=
 =?us-ascii?Q?lJ+/A9bzYZjwI0smKgNv1W+qvD+o8/6QCLvt3ZyNP4d1BddV36c4XyLy48dv?=
 =?us-ascii?Q?j4/dCqYK0L2E6iQXBbMqnqbC7fmq4mMr8iO76JiyOHkUker18SlNNcJf7ROr?=
 =?us-ascii?Q?uNGRf2cjtEXLlAkKfy2vFsbWD1uaWw6SJBfj9Hyvimu5vH62pRIDOea8rRp+?=
 =?us-ascii?Q?zzZGETrGF/AN5Yg6GrjPe0dtA/dNqUMJ3sSzdi678/wzQBnN5F9Nbq9T56TI?=
 =?us-ascii?Q?wpUtwBFSlvPtBRkyqP0HWiuYSa/WWyDYsRSxPb2iHFbNbyraEVt0LITLkFGh?=
 =?us-ascii?Q?X9HPqkDKgl6Yg3xoLVm26X7pLmKrO4/yHQ84fkdkl7tNFaR9RFEDzi0l0hy7?=
 =?us-ascii?Q?36Tx3kZ2MXQKkTDV1RwmzhIauhvUKzi7c5rLAz/nVlGKg9aSab5zAZ+DjYn3?=
 =?us-ascii?Q?dSbnr2EEEo7MT9UDyg1ivugW/dDimO4NVTxHs9G9p2AE7iuqpaQ3voQFYJzi?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yk+R2o/hbRa1NFF704HJRo4Su6x+YYgZYKAhbtBrUDB8KfJM0IDJOwgImpAt?=
 =?us-ascii?Q?TrzwATuRZRuby7hUcGd/SpI0spwnEsW3KbYWTeTG+q6c15j2g583ewN8sJL7?=
 =?us-ascii?Q?V/gEl2zSXfj97pUR39UryLUqxCfVQuT2BSTnRVvV46IE6GjpSHp4IsLP9Se7?=
 =?us-ascii?Q?ixgtmVJnguWvJk8FmWaJGbdSZDYuWkzd2RrRBAc8Q1mcjeRZUMqD5mC0grVf?=
 =?us-ascii?Q?hw3E/2JLXVoPoBqjerJzuE6dIgYx1km8Whj4eV+dOdYpv8681GN28VvGmqVe?=
 =?us-ascii?Q?ak0ZTWuwUHKiXFGCkQ1AirbhPwwWhY5m8qHm6CC3Zx5JOcnQ73YDt26VJnfu?=
 =?us-ascii?Q?XXcOdNPbXkvb8lybfYmq/5xUkLQStqRUylhxKfkE0JzcmEHOwOFhKLs6Y7AC?=
 =?us-ascii?Q?iCNTCUKJaPlRyNXgz6LO1DXMP7AcRAaVRLihF3Tnke/Jn0iMzttvGOkspnJM?=
 =?us-ascii?Q?H5z+EIzIV6Si2ylbCJpNBlxrpAQToTEUOgpgVoOLoRPc/c9fdR38NIvjZf46?=
 =?us-ascii?Q?aupxlyj2+ZmBDjlcvSnukkrjx5sMbq9r5nZ+PgS04ZX/LVZn4M1/2wUSzh+E?=
 =?us-ascii?Q?VCremHoXzff98c+y31Aa2bPeYDaaWZGq6+7UukSCzAcYBW5OZRqGOxrxOVx+?=
 =?us-ascii?Q?uwbux1gHm+vT6DcWZ4gr8EfDGAT85Evf+GAZMUaWufYxc7Awlbs5UzZnvlhn?=
 =?us-ascii?Q?Vwdmkm1/CLL79RSWeCMqfK2ikP5cEbrzRwqdqyhqhaOtLhzYV2GAhQKnuvW0?=
 =?us-ascii?Q?GB6Qbv+Q3bo1JAhy/9KeeoHSFxfDNiBEPZlhXHHdoWlmZkSj7GxBNuXYckV7?=
 =?us-ascii?Q?I48DzQH05ma7APXAPogEPJLbGJZUMzVyvUWSpSBy+dQ4A1QQQX0Oy4Exg6WY?=
 =?us-ascii?Q?mUtBYTygn2XJdRteJhH0/LgOBNxG2+OZFTsDFpVkdhxDSes4TWRveebKYYX5?=
 =?us-ascii?Q?f0/9by9cjmL2TnaFRZrjikKowEoYegUvzqZSig4oCnYrUDkDHce8kS8PphY3?=
 =?us-ascii?Q?xR6AfFmZyFvtm9GcRO9k4RGA4rfwZHO3oT69fX8RVb1MotfXqnl30nJIPQak?=
 =?us-ascii?Q?i2GHU1SSYkCo/0dUD0vfq6w7XObBQt7Q5NzPADbj0aXd/NWGWRg5w3hr8RbF?=
 =?us-ascii?Q?DvpA/qXN5WB7yWd0VSJE8gRlO8Q1rMaMg0BYhPcN4S1fRsLm3BYhrXXjXqi7?=
 =?us-ascii?Q?16hrX/EGo5DTN8SNV3b7CMM4Bc0wl475MtWVP3vEiYMxY6zfWBC9mgcg0qCc?=
 =?us-ascii?Q?oj7l004kMFNw6CCs1+uYI/v7hDio73tHRC6GTqibU23Lnc1tbqe6Pi0RwMaz?=
 =?us-ascii?Q?kpqL3fqTCvgqjxmxxz1nBTVqAUgw8xGqcTqRqfNOyTuokA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d1bc42-988f-464d-12c6-08daef2ffa8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:37.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIhnECzn5M80pFPy7v5LkEKIur1qby30HJhaKRTuPgFpV2lGlbLBUMVsHUSywLHxwBRCwVa5QPOCF7A7ckfMApzHAGMLhVmjk5XnjAvLb70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050119
X-Proofpoint-GUID: HUeNc3H9Ley_o-CKcIfugSH7jkQUR6jl
X-Proofpoint-ORIG-GUID: HUeNc3H9Ley_o-CKcIfugSH7jkQUR6jl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, the crash elfcorehdr, which
describes the CPUs and memory in the system, must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
into a buffer, and then installed over the top of the existing
elfcorehdr. The segment containing the elfcorehdr is identified
at run time in crash_core:handle_hotplug_event(), which works for
both the kexec_load() and kexec_file_load() syscalls.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |  12 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 112 ++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..09e9b7a091ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,18 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug of CPUs or memory. This is a much
+	  more advanced approach than userspace attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..76e2431dec63 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -42,6 +42,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		/*
+		 * Ensure the elfcorehdr segment large enough for hotplug changes.
+		 * Start with VMCOREINFO and kernel_map.
+		 */
+		unsigned long pnum = 2;
+
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+			pnum += CONFIG_NR_CPUS_DEFAULT;
+
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+	}
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +454,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

