Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6456452A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLGDsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLGDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:48:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB14D5E2;
        Tue,  6 Dec 2022 19:48:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B72Pj3B003004;
        Wed, 7 Dec 2022 03:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=M4/gRUy3d92pp51SjZ7U1V0sbdyWCVuXJpuDkWCa7H4=;
 b=jvOVWiekojEWatujoY/gQncSvnODvqqcWRLk/5l4cAa1OJEt+v/6ka7YX5NlO0QL0lii
 P9zzv8xdOJEP2iaMuCfBzd/sPJm9WB2UU/FmC+MN6wWk/vLhdqsaj1qtKUUTS1rRIsBh
 RuGVL96ntxoVOXj5iioGjZl7n3vhU0QqjWesBMy2TdPRMiXZGiq+/Nr0XALFHGlgpQcv
 iC6bdq1UZz/FAdeQgC6erQgJxVw6dnebw8D5bLr15s6N+Cv9jLYHuhxMplCVQ0q8ghlW
 xQ8I16tyhEv6EC4WU5tg+H/M/33LpETWpKk7moh1ne6apcdF2YXrY+o1oiDHB/tBK/r9 uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjhv9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 03:48:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B71vwWm030823;
        Wed, 7 Dec 2022 03:48:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa685d96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 03:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLA04qz0U4VqAJIwzhH7jCxk+NA4RwH27j3cDcvj/9BczmgxvLu2yeM2Sf4UMZ+dlOVeq4uzZFoXlG2cRouPBmETuSN7cJiR41Vj7JzwM0x+uDG2AVtzT3ZA68yE4jz0W433Wb1U3qELuCEY8ePxYkpx2CXK2rpNcmYrn1jlnnov7zZpjGCrtYYtlmEw5SzexL8Kc0L+vVS8/dWgpA4pTD+3HWnu4pEVRINt5+jpGQHI+c5E0F3HG85uhhmCdRJ6FfZtBisvZc5Y9Lj6EsH6eks/rS8wiaTEcjLFJ0UP8Ua0Y9FuWm+cQA38CQe271CzctB8+XqwvF6mFId2u8N8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4/gRUy3d92pp51SjZ7U1V0sbdyWCVuXJpuDkWCa7H4=;
 b=CWPBPLSaOFDv3yotKYMSMKdxWtI+RZT2Q0/+mADnQA4nP/ECcKfnCDXmPW/EQ+108nuqVHBbADM8sGDEcD66YgBTsj9hRvuKrGxOVH/t8xRcRTPE1IFw4es5/4Krj60Oz8VIG7I9q9OBHYw9xH3eN3GE5SR3vPXJLtzkQsvb/r0LSLQgcE4N68r+5foImCXwzrAAzVgvAM6arSA/AL8SWQYJ3X7uQ0V0idiwA0WeaIthLaZ5Xm8ng0jCB+NkSrt5DPtEL4MXYn61uFaxtulsNlQ+hlMcUNJMwjHIGWy7JOaD5oBX3c7cSPwCwOUa8pPcOaRiltuxmHEic/kWCn27VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4/gRUy3d92pp51SjZ7U1V0sbdyWCVuXJpuDkWCa7H4=;
 b=R7IGQjHIoqtdQxaGOlFZzVLdIsAMr8cTNvTVxp+vYMYPJck5gi6EKS5xXlp5BXQn1lgSyAgXzQp+pn6WwGXRu5LHTPEFYhV+r2DuNX5ohzoNUU0Helwpo2ZbWqB9cBd/N+k2tX1fRyeeVFvyLVqOmjunXro9xCl1HqRm1DIdiBo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 03:48:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 03:48:25 +0000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] ufs: core: Always read the descriptors with max
 length
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn73hoa8.fsf@ca-mkp.ca.oracle.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
        <BY5PR04MB6327A3C457A16BDFC5C13ADAED199@BY5PR04MB6327.namprd04.prod.outlook.com>
Date:   Tue, 06 Dec 2022 22:48:22 -0500
In-Reply-To: <BY5PR04MB6327A3C457A16BDFC5C13ADAED199@BY5PR04MB6327.namprd04.prod.outlook.com>
        (Arthur Simchaev's message of "Sun, 4 Dec 2022 13:22:43 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: b52c4cac-c4de-407f-4269-08dad805e50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swMS5HjTnxH/maKkBiqz1YmtdghrxRZe12o86ZXPFdxMbgU5Mi+ehaHjtksX9zR2kecKRTuRgR19Vm+jVmP7vwhFNESCFjxskvMJK8t6o1mMYLAXZwmL+uD09YnlAbFF5OGPEdLKG9squQFBuTJFkpLe5Y+0A9YKHu+SrkdbEGGWwg9DbQu3Kk+1mxnvQsa9rw3LF3EnGdtorV2HV3/b03unLdXKDFEme/DxRMB1lnX685mmVb22RcUMlsh0TkLZFZeSkV/CsajZye4TjgQd0wqiwaaxnvpn7VF0QnIw1YAurX7rjC38UYMWcTBbaS9d0ZDdJ7ZcA8BfLLBCXiY4avDsgXfhBCU1gtPUfNHeIzq9Pa1jRqML4wtD3893fwkhO7ZQhjS5AisXn2yeBiugiwj2TTj1whtqg4OupWfpaXrHDXQLaXcHvIZ/iawz8G3NoHp+SnvmvLc8ucdtysMGP4HdDoSe2uNvCkpLtJ58QQzroR03E1+luzCeW55QuVEuhpIdPmT0K4281fSD2kH4TzS2uqcC7anRtp3vHR1rkeAjMp20A6eLEI+0NT1mOBpL8cbYoRuC5BVGrH0shb4ei2psL/SnEzm4Um4QFb8Ngq31pvun7BKhf9LzZv2h4I4aPSmVQNoitJIF0BOjKwH9MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(83380400001)(5660300002)(41300700001)(26005)(6512007)(8676002)(8936002)(186003)(4326008)(2906002)(316002)(86362001)(66946007)(66556008)(66476007)(6916009)(38100700002)(558084003)(54906003)(478600001)(36916002)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSd49x6P9gUWRZjrWre7l4/rXTY4ZJNKzas/4go7iKAZBoA/4v4WfhJ0s44w?=
 =?us-ascii?Q?6NHaU4VA67xspgflVkpkfUBJzjxPVQV1phTmfthcxJ1i4WmOhOLzj0zXmJwy?=
 =?us-ascii?Q?41cpIF1Io7ILTw8xiMTj0eZnZmiKuZxFX/sIH+1niyV9c4TIITCYUJmKIp1R?=
 =?us-ascii?Q?Iw0V+Q+L2OcPl90PYrJGueT1IZdVUsPRMZRymWIIXQJqmlqXKUnL4E/iBqax?=
 =?us-ascii?Q?CVzRuor4MFN09JH8d6grNKPDdmej8aqYwg1rJLlUBHupVZBC7Oup13JITHz1?=
 =?us-ascii?Q?8XeCbTmFP/wwJwB497JE/BSucqeuq67yd9C0gEfL3WnUIKXLScpRhmjoLIk2?=
 =?us-ascii?Q?wNE9i5bnNGUON2Uu/70hxnmiVqV2z8nA6nspU7qFqn0/q/ipO5pWU/cLVlDY?=
 =?us-ascii?Q?H6lJ+SBQGsOEW8ycqGDvhX+Q5JdGaZt/AUUSlx8/DRziiAK//V0mBeHqWuw3?=
 =?us-ascii?Q?SajDctBLGKSbP0Lf5J8UZueZgXshOCS+JC73nDKPzHPO/sMF0Yx6eoE+PbDq?=
 =?us-ascii?Q?h4KJ2ukUsKH9+OAcQTfpoWxle+BISgN+u4kwkCv7kNEWbFiIM/OjiCWmn+V2?=
 =?us-ascii?Q?L4D8WxCTj6Q2lX+pjj7GRVDOUVNOj968hRL0EX3eeyNCdGYkl+hVElPCUK6V?=
 =?us-ascii?Q?UO4jQR75AQd4xGxqwpwnda7KOVOO1cgZclXl/M7uKEEXfXH9ItG42AgcnMLL?=
 =?us-ascii?Q?bUQkKTXfF29SKsJrmOHlKiLchrmafWGhsASjsOMj66Gtgon59Swa2DI4CgFl?=
 =?us-ascii?Q?YIZhHqXcXSp/Hz+KmUhAnuFTdhgcVVc84e3lO631sRI2QUXnw2svrOQiwnDx?=
 =?us-ascii?Q?M24sAc5gw9TOMDb15S1GRoxj/chyk8sn1r+k7ZT16dZK1++72zTyr/Vv6wGE?=
 =?us-ascii?Q?4Xpvs+IxrAW4mAjw370fBTcMp4XBnOsD5Dud/bXRtqHZL26Q1sQQbdnB23xz?=
 =?us-ascii?Q?AyrbPn5VSeJTSUmEW1F2J2fcAd0Lly6+vaC+p+z7BZ65yo/rP3I+yGwWoEEV?=
 =?us-ascii?Q?S2eNBrt97kkHiy22x/afLA1X4n0pHJ/h85VHgMADtRbL6gwZAXqqSfaqyXpp?=
 =?us-ascii?Q?VUnXYoVv07vDWdVK4hXDfHD3v7UT4Xo+3Uk5TBQ095PZdjoIvQdoOZypLIe/?=
 =?us-ascii?Q?Uro4CgsiQsMXshxY1mfenUzipWZyNeaXhfhVCLXDIYUjcOIA87n9yuRStKHT?=
 =?us-ascii?Q?jQIr/jNn9b7tixsWTqU59CiG1xLQMhaUKUtcL93+F5ozFrDO3e3/iMMTRs4b?=
 =?us-ascii?Q?DZeFnu8Zb1ZDlqX6AbD8cj3iDRlV+w6olS/1K/jfmLieGrVN0vlLstfH3r32?=
 =?us-ascii?Q?Mo+FekLZHwvPAjdimHsh8ukqahqhqaWEc4mj8b+HVhbwebW1xbbFPqLNmE85?=
 =?us-ascii?Q?/8O/Gky3TjAQBrsNgn6DDlgkVoeRQLvHtTigo/jaUrcrrhPYFIlS3QF35cW1?=
 =?us-ascii?Q?Z3a5y0uV+S8QLjkBYkEV4Y0iJQHTEUrL4hhKOE2mqMh+uQRH4CuE1jLhhLsW?=
 =?us-ascii?Q?L7tSLQPzT/heobez3G12WYL5GyrvgVxyIC7v7gpuIKL5qJsN9q+ipS2ZH5Rs?=
 =?us-ascii?Q?vY1ooEjmQiGn0g04rCQ+cr7xSPTwfzpbjOga+UL1mAIuXnTNANVR1Kj91RlK?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MALBS85HcBn79kAigQMJt5CTzuvlsrO3mbTyE+omBQg8xKLMyGWFx7gKNQhoRYvzX2UfOHYNSXwwYcCpMDFZ8UfwbNCeRbGhqMB9TBGeYv9hQdI8MUQFTsWuZBCJ/+Ng/4tYlsZieD745tIWBOcNcA++wqzatw4s0M8RlkiVbz5laft40+c+Bk5cbVtC0zJy1U0m1gXPXE1lc9Ul8OqJlR8tibZ4ExGFxRWSsgl64t8oMoW4WLzxu+S6J5HBs06uT+1xHWUktdK/79W9rHF9n72IR3W/GL6EsHbvzl4KoxGOGGXZBmTZJYioSx8ZxRIqPNx3uz2XT8hewNHrA/JbeznoM6fzjE/OTzAaW1irJ4UAq7BlX1e5BSxBm+LOk+3ybWueUlznu6C+z7irIbXA9SCUVcX7PP0cUbPuyF3bOQvZ0f+jpPcJUYPyyJS1fBlp4ylwsIm2T+vtIOC2K3pjfOBQbcoiv6gkfcjaH9vj8iVbFoqFA4p7ngXXp1MKlK5f2W1CAQHGE8FZu+7KFi7lg8WVDcfdZFWBYy8JVBiZX5gKXqVSB9X0mfkXB7pdkXaMUbk99rL2lWUW4E7qmtGu8gh9UZBd/2BJbLo8mTmPgM175i5/cQf6r3DfG5hqgLgt2PIX6arfYsev62/bkXdwtuXgCVhx57k2az3aooWa2c9cUIQSro/B+PvPyzRJ1g5W+B5n6+bBp1ul71nnTUJPPNbgvzxCfTTsV44B31hFrrBZGwsco3YAZaxxGheWZtu/MWZqD84m2Bk3VTkNfFFw2dlG3gus3zIZmzdv2CkLB1E+FSFHrclVAH6Pd2lkL51jZwdlJC0XxcQ7wIyZ+Z9D+C+XFNSRk5jj6Q/qtW8+zqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52c4cac-c4de-407f-4269-08dad805e50a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 03:48:25.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHnBq30AXLxUPotlbB7tavtqgHq/4LOfQ1wHvNyIaPlt7bc7hF2SICYtK1p3nG6DFSK3sZXV033UxWLMfd0z6oh1iw0yQ4aWFLVKN+T2qpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=810 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070026
X-Proofpoint-ORIG-GUID: IAe2hB8NKox20X-bzHIEzOQq81mfgBJ8
X-Proofpoint-GUID: IAe2hB8NKox20X-bzHIEzOQq81mfgBJ8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arthur!

> Gentle reminder

We're just a few days away from release, not adding new code this late
in the cycle. I would also like to see an additional review given that
this is a core change.

-- 
Martin K. Petersen	Oracle Linux Engineering
