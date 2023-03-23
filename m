Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EFE6C6D17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjCWQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjCWQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:13:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9E34F75;
        Thu, 23 Mar 2023 09:12:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCxAGe009914;
        Thu, 23 Mar 2023 16:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QIxcIvJCpHjIVcqXxM6Uo/enqzHKJ9n8PwW+qDXbqxQ=;
 b=sW2u1KyzoJEGqYuHwLwAk9achFNwCvAbAy6q8I9e5HQqPqD54FtD2QVzBTEXNpS1A8/g
 M1gI3KfDdb/RMwR+uxepya4JIbPJktsajrelruYwYrA54q7xhMDyly5+fz95Ry2kKMzY
 mMow3sFQn25/ICkCGau2AwJZ4i0iZyrrn8HMu5m4ny2O3pErN6bw9giJTR3KXD57/o9G
 yQW4m0fLSA9l4qveaAhFpHJsD1Hl4YOEXqcwVDLGAnGYzgxt7qElzqu9tSD0LTqoj05h
 wp993LEDlWodnIoZkCL9huIKpsObt0tEOan1JULqb4Oq8PGnQqhQBQ+vvR7/2nNsSCF8 cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b44tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:12:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NG9nfx008196;
        Thu, 23 Mar 2023 16:12:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgt2084k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwa8PY0m3DD2bngniBJYv8KbLYgr9Q7+cFjzRse8UlHsUyvp+rpWcgUekbi5KUKhysVwYaV8MPTOm1D8wmXhxobv0OW3Pykuj3pjOvmZ7ImCA37Q2CDLnj3m8Jdyb5xhk67wq2wKPD+2fnNrRzo/NoHtZIj/aqDNDIJGm4bHH/LMOdBn8hnWh99PwyhTEnlylQ+JvCQRS+ScTlawhEFezY+/hlRDbLipK8VceFHPbFP3V3J4+3Ot41A6vMnyLcuYr/BMmgN6Lo5CS+ctniGjXn1iCV8Q/ao6Y+S9Z0qdAt5W7lurIcQVCzHAgqH18DrccMyFiUy1qzTiyJqR9xj3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIxcIvJCpHjIVcqXxM6Uo/enqzHKJ9n8PwW+qDXbqxQ=;
 b=NSzeJUT+HBo/7qsZzA48R0XEbdp5gg116re9a+4suazIt2FuG8tqXr3tsTbzyXgLAgF3+YtKsmGW+7qLyHGqrbF4X4l1qqiMC9uUwxmq2vPzaTgEDNgbSZTqRYpbykleyO/wqV9+mjWTMktmPvy+L9aIjKgYLgPn1xY02omGqB9/tEs0ft03evOrhLmAzsuDEd3iOXBh22W9a4BZCastxrbkEwZYspoPrSJt+ALr3uGqjk4gJblBs0Ub2vckUbxDZj0RbH4A2evsvzKUZQnH/qnv5eAKg+dpEaqk2xDcDiRwQeooqqZMHOcVsTd3hBW66/CBMCexUo/amIpDmCY8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIxcIvJCpHjIVcqXxM6Uo/enqzHKJ9n8PwW+qDXbqxQ=;
 b=PDg0c+erd30THaKIFgXI0/YM2WXeOnjmUMqeP4NdgG1HFE1TAP+YHbt34H0oW4m4bRfXQmJWjXwcP993yDp5h4GrJaa/12pDawovAUZYAU3qgE8jCxbsEPWytAxe+hoivaHpotZjt6vIUtWVUSkRwbOegZjS4gExCFyitt9ZZM4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA1PR10MB6639.namprd10.prod.outlook.com (2603:10b6:806:2b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 16:12:35 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 16:12:35 +0000
Message-ID: <1df01cd0-e56e-b615-9418-e3fd69819798@oracle.com>
Date:   Thu, 23 Mar 2023 11:12:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
To:     "yebin (H)" <yebin10@huawei.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ye Bin <yebin@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
 <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
 <641A58D0.1020205@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <641A58D0.1020205@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:5:335::24) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SA1PR10MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a24e3c-e026-4f25-3d9b-08db2bb96a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKktqB+/QLfR0AiQItB/cxasmP1YOYfukYmMjbqFy3zhYRgc96mFnY6YN2O7FGYx2f/UDSgHcbcIywqR7ojVPfEQ7PFOK7uuK0+nuyLwqz3fLTkVVmGAi9f5PQtAPJlc2HcalDqduO0gjqIvwnKMLpJGlGSlAnfhb85rRR6qBNP/3wDlLM8O5GuA3uweNBq2uubl56N2v3/sZYaf1Xw4WPMgNuEzm9kJGMkjhtCHyeHZPEjRQXQisePvfHtlJLIt/2hTThhWAIT91JCmQrkk8ybuh2cyMSqAXunByaiVBEdXQiwhuGg0rcYSUHSMRc91YZG5WZQgNrebXh+NLSBoWn6WzGv0U4m2osLeL5Rl8KRD1UcGE9Sg9B+18DgXETI04mKyV+x9voS4ZLyhBs8ZC0pwh6dx3JRokZ66uUn4MIJE5Xj49IPEDsOOQqiN992Lg4t34fP+ScTtH73Iey+7SEvk7m3HeAzvGCJqXSX/pnVEqUiXf5NsrkcRi4GR5tM00MX4fftWOOPsrg3AWZkMfLrfp2RLMbHroSbIxQiX+/6KG75KdWSowhcbxPpmJpgp8vC3FG3TKyIWuTSiW1CD4G6kZNJAYceUoziwk0Hb73FnZEvCXgS+xHWkq0upR7HPrMLwXsKEe2FjtgoHkWwwFI/d72hYTdAWk7B92OW31RbD4z9ydIjguolLJMRRT+roYhOV5QQYUxd2zJTT0gVBGOI0xDDCtyK6QchqLQVlmfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(8936002)(5660300002)(31686004)(316002)(86362001)(66476007)(66556008)(66946007)(4326008)(8676002)(41300700001)(110136005)(478600001)(4744005)(31696002)(2906002)(6486002)(53546011)(6512007)(6506007)(26005)(38100700002)(186003)(2616005)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tZL1llZVgyWjR6V3ZsNXJsbVcvSjErU050WHozTnNycXgwTkp5K2RlYXM1?=
 =?utf-8?B?Q2pPc2FXMVlXZWJESTRjOHNkTTBrYWhZMkhqRmtreml2RTdDTnBhQ21JMU9k?=
 =?utf-8?B?K2ViUW5Hdmd5YXlKbnU2UzZVTmRVd0o3MlJNeXVYc1ZWalpHMzMza2xDekpH?=
 =?utf-8?B?dTZDWlBPZU4xc1RrYmh5ejlZTUpyWXF1UDFLVHB5Z202ZHdYbE1XWkNsMzFQ?=
 =?utf-8?B?cmM4L1lDcFBXclcvTXBENVc5RUczR2EyUDM3VlNuNVV2M0hCK1hZd0RUVEJZ?=
 =?utf-8?B?S0U0N1NqTUFrbDNqRGlCNXNiZDB5UGdRZFFUdEtGTEZCYUI2Q3VvZGp3RTdU?=
 =?utf-8?B?ZUl5amNTd2pLWTV2RXBUMkdUd3pOY2hJSjJVM3lDRXkrdTVONnQ1bVdyaUoy?=
 =?utf-8?B?Uldhc1p6SXZYWW1PNklRUXFldmVkU04zYWJSeFpocFdyN2VPZWdOS015b1ly?=
 =?utf-8?B?bVhhRUpYM1dnN3c5RWFuUlRxc3gyZ2hCaVJ3TzJzQTJzbm9WekNsZVpwd0sv?=
 =?utf-8?B?bElCc0hWUUhRaDdtM1pHU2xwYTFVdTJLRUZaU254NEZRNnQyTzh0MG4zbGR1?=
 =?utf-8?B?Q25PS1RRWS9wZ2kwbjV3eVNjSVM4dXFkSCtGZ2FNWkpyVTZHTGhtOStPeVBh?=
 =?utf-8?B?bVd6TFR3YjZqWDJOOU5uZzF1QTU0UG9LWEM0VkJ3eW9CRGdESGZTZml4UlQy?=
 =?utf-8?B?WUd6QkpWa1NzUG1Wb2xxV3NpOFJWTE9ZMloydHd1YTMrTy9sQ3g4eTQ5S2wv?=
 =?utf-8?B?V1lHM3NrTGVod09BVUsyOEJZN3grWXdkbVZmb1J5eXRnQ3kybnhFa2FXZUZj?=
 =?utf-8?B?eVhYNlFmUHBmQ0UvSUZEKytJTkRTL1c2YjlXZ3NzcEZsN0lsaGdFU3B2aXNn?=
 =?utf-8?B?OWE1ZjVYSEdHelpTM3lab3NIY1FXeG4rMklkT21xeU5YL1JObUxRbjBmTW9Z?=
 =?utf-8?B?NWdDdDhjZEFhckl0d3VjcDVMUTRJUDRTcGJWUzc3bklpOHZBaThiSkk5U1Mr?=
 =?utf-8?B?T1I2NXRhVFJTV0hXZ21jb2UxbjBTQndnNDRTUVBuRURUd0xaT2RDdFVJenRE?=
 =?utf-8?B?SWNaalFlTElUeW5XYUVFQVpSa2RNSFhaSDUxanh2WGROcnNYRjdDMmVFRVlK?=
 =?utf-8?B?aTdJSCsrcmxyK3JleXp1cXZvTXE3RVFKcVY5ZDBwa05GcTV3OUk1MFFzbjMy?=
 =?utf-8?B?T3V4V2JlUmdJZzkrR093TXNuSmI1QUQ3S0J0RzB3WDBReWxlakx0M0NmSHdR?=
 =?utf-8?B?ZWZOS09hKzAxU21qbGw2cE9MRmo0SThBbHZpUGYrTHlPakNQY1NnWDQzelFm?=
 =?utf-8?B?WEtzRWRHUTc4S3R0NlpncjNpN1JBSVdmZE1pdEg3ZU9CVXBEb002V2RhREZM?=
 =?utf-8?B?bFhDM2FsTlZmK1U5ZFZ6dW1rNmJ0OHd3K21vQnF2cTN4RkpZRVlYWGprT1Zl?=
 =?utf-8?B?NHNrWmM5SEU4cHVJQlpXMUVySVFQcXdLbEI0SitoVEVyRmEyNGJWNjJvRDZT?=
 =?utf-8?B?VWFxSml4MnJYWTRZL05rSzMvQ2EwMGxpZVpkNktGUkkyaXBmcWdDUjhUZ0Fa?=
 =?utf-8?B?MVc2WXllMXVwRWdaMGF6RUc5VjZlYkdadTVwZWVtaGttUXNHWTd6ZStZTVlx?=
 =?utf-8?B?ZWZ4MDFIRXJodGVoZ3RXaDJnR3h3cjVkSTVidVRWYm1YWFVFcWNtQTMxMXkr?=
 =?utf-8?B?UTBncy9WS0d2VWh3OHc4N1ZiRGxleW1tWXdXVVBRczV2dC9zdHlkTjdIMHBy?=
 =?utf-8?B?dXV5NVN3L2lvY3gvbGlXTVI1enNuM2VTa0s2R1BFZm4yWlRTd2lyVGtwQmtl?=
 =?utf-8?B?Sm84VjRkQnRNbHlyeGRacnZOT2N0OVp0Zzl3Qy9HalB4SkNqNk1sdzZjcVV1?=
 =?utf-8?B?cU5zMlI1Y2tqMkJEY2pBcDlJaFdCb0VQWFhjSjVTVk80bkpucW1Sa2k5VVI3?=
 =?utf-8?B?VGc5VldDRlNTekcwNG5mOVlCNkhPOXVLK21JSlYvRnU0SjlyY000Qm5FdUFi?=
 =?utf-8?B?aWxxcGJjcitBSDB5dUFkUFlMSDNySFVLT0tJeXBOVW1LdGhLejBBMGs4L1F1?=
 =?utf-8?B?REpIcmNYM0lzYUdRSUlZMnlyYzJtL3NSUU8xbmkwVVROa0VUNjZ5bkMvRnNC?=
 =?utf-8?B?V0ptYVd4WW84T0E3QURUMWsvejdYVmNUM1oyVFpuNUtyeW9NSHR1bnBza2lC?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v+AqCfmVjeGqupGPxTfBAAfICqhFogdwOMwYzxHD8GydrrPrUqSo9c0g6hyx/+wNn2lxQV75WQ4G1OeQusbMDifv9ar4x49yZ640sx34rwZBa4DgFwiyZuRoHRat6IEoy4xN8vBCmkBAqtJx/sO2qEUU5bz6hTFpsNxdKnETZ5IYZwHcfMUKauG/BqOJ7YE8FYrn1loGpPxpWtUMyArJ23W1ldSz+1nokVr5Ffbx2YZtjFLlu92WVNVWDT3wKzfowBpBUy3QZgj7lZKbQwpuwyzHfVz0DIGwXhP8gtKJ22mCMEAv7VAQH8hJdiKw25DeosukQCcRoNw2rBnGhWxN7jOUyhVxbZJmJnKxOnuNe1U92085Kl4hb/natRv4YhacXRtlQ+3Lh5i++t5RrN6pO/Lv1vKnoR4VYVIwT7x7iRQqDt2CufcWDRJlJudYV413dz05ZPEJHgHo6B6xDW8xg9k6syT5ryedAJ+A5METhsAnKL0BRje3Gs+Z37XJ4T+0vyPd4Api9Gwd0YZqCPhJtmQGiWtSx2fGqnSVHiVUmJm+wmEOhhl+MtYqxm3JqpAXlpTuEZJI9zJl0ogQwUhZk7yL/KUtJx0PlDyRr3PAtEwga98e4RISEg+JzJz64gSiJu28sKiRyaaThBEKGuyFAxSxKGHxsfIWS2+AWMtjUJ9szvc+MLMdfjF49XzrMG9ATbXfaGz2Wn9hlbi4sgeroiTzJKC18cmXwOUwkwt9izeKIPGUtpmeA15gMCd+Fg9hMUMeJ3F+skUB8tTEI3F9Ze7m4pfkaN7VW+mLNnfOyCqZDcbhqzpKJT7156eFSaRuC7+h5SLT5FPXoYzEnAMrrUDF36EWQHxBniQizDQGO4RWDO+xxRQmtDymWhXyjNse
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a24e3c-e026-4f25-3d9b-08db2bb96a11
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:12:35.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xat8lD5XgyZJU72gzDtmSa4lf3QR7wLjcO8jzO5VlfohCRDH9lDg7/Yay/0+9IiaCDf11WqRbjC4HMPPiJjCNvjLQ+vhsheFdOvthvy2JTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=769 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230118
X-Proofpoint-ORIG-GUID: BGf6ayHPq1WEDzLvuIOu0vQ-5d0uAQOt
X-Proofpoint-GUID: BGf6ayHPq1WEDzLvuIOu0vQ-5d0uAQOt
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 8:24 PM, yebin (H) wrote:
> 
> 
> On 2023/3/21 22:22, Benjamin Block wrote:
>> On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> When do follow test:
>>> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
>> Hmm, that make me wonder, what potential use-case this is for? Just
>> testing?
> Thank you for your reply.
> Actually, I'm looking for a way to temporarily stop sending IO to the driver.

Is this just for testing something or does a user/app need this
functionality for something?

We used to be able to block specific devices but we removed that.
It was useful for people like us where we need to do some low kernel
testing like testing for how upper layers handle IO hangs, but I
think it was not useful for other users so it was removed.

