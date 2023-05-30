Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892AD716FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjE3Vlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjE3Vls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:41:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14057C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:41:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKO2Qt026737;
        Tue, 30 May 2023 21:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cv2+5KHkzbthorn1tiJVUrpDvaic2qMmfANLvlzKu+Y=;
 b=lQt8xPCqPaY6tauZm7Qo4uaxTiL6n3dyCCm2AIbNd3+70vTd6W3dmENvu5tSOAshKJha
 xBI0ZqTQ26Ey/usB+r3IPzHjHrZc5adKVye09vhxtxxJ5AkFfJmJZid37M3vWdJZ/T8n
 dHfoJZnOUlgp/vh3tWq65LeHIKFqs5ueJCWKUhZ/ZiJk1GzghUJNXUPL8dETo4E8QJp3
 /TVgY7iEdn8InLGcHfU/81Ba4QnbRUIsMpdSYo0m2apm/VhhyIBs7Y8lFWN9+Y5xYMOd
 /xllp6j5SNbjNotcpGSIEMo0JiosQDrY2OhQzZ7OMdVsIL5lfGnZktcidchj6JPlu3va 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmem0g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 21:41:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ULIVlu019789;
        Tue, 30 May 2023 21:41:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4rts6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 21:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx0qyhTEf+vY7yBLq/07VDJOrPPsJ73ABrLn+9fkKMikzbXXT6df6QDW1881/IqWh4LVnrorKX5KidXrexHtSLPDiKBDTmOYgQPRnu4dSljOEUAPWc39Oo6XEpq0QkK7utWuGTL6oCIIVOJ7eiP5XxzwI26QSWGUPcEYxIiz0wLA8lPqiNP5lXhRogt7ToZvk1WtgUdn8TtrSpFsgaD6K2BkxLVCsnxXn2/nRGoANoI6B4yzFVOMHpaDmWVtC6y2fAiCaZf384Gg7QTz+ukis808oECkLEcJ1PA9yN4oyafinG17ia8DI7/z7fAVhADDvakTNTUq1GKSXEqIYWW32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv2+5KHkzbthorn1tiJVUrpDvaic2qMmfANLvlzKu+Y=;
 b=T96hE9tb63WJA6kQD7IHidDDUnNPriRGypsEkQDNpkVfL/dOOCbsFxSFUKc5zQtnBzqrRxfkjWZmXj+sFppqTj6wnOUeQmJLW6qogm2lhRIGZvXiTJaBjlAGcoEL52GVzrtuKB0o9ykrHF7wPHRNKGHMv7z+vbs1ePoytshfOIHgByKRnGZuIUfc783sMqGVcbPFXE7gwpQarQP9bxPl5NtddPuUpOJcqG2YSW8y9DxUvmRDmZ3lVi58B//ctqYBuIpLgM53O4NH/XX0b0YZ0FgxPjyeR7voGQpVYLiU7QkE4DPqv0RhFYXkLDaHZF4l9FBXyiz1J7D8E4l2yJvgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv2+5KHkzbthorn1tiJVUrpDvaic2qMmfANLvlzKu+Y=;
 b=AEZAl0UmR7bfq+N4ufq34gk1D1syPQzz8AcCA0VTOUzJ29RT13i2GSvUugl/75bUfi9PVZqdEuzHg1b8Yaed6Q/L1lZaBEQuGFjlNAAMMKdBZ117qmbs0RAKajdGzYE8nk9sXlyXmzqmCx5Hcj3xexFp+/8xsyB/3nDKDqDvjSg=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:41:33 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 21:41:33 +0000
Message-ID: <77ad1a2d-fead-359f-d63e-295ec5791bdd@oracle.com>
Date:   Tue, 30 May 2023 17:41:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/4] debugfs: Add simple min/max "files" to debugfs to
 fix sched debug code.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
 <2023053025-blinks-vexingly-60d3@gregkh>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <2023053025-blinks-vexingly-60d3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 73092a90-269e-45a9-dc77-08db6156a307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybWgkKcV9L4per+vNhkOymeUT2n0nZBzjIu+K37azad6qC/dTrhzx1unUxLEMddIyxWcV7NevfJwbbV2TzZf/dMqW5rzDFbRyJWRif/7CVdo1Hp7YnBy1F+DV/MBbMAUy+VcU852dAR+c1fXIprBZQ2MInIZ0Aw79upUTM44Kl/5skIFQ2rpHgQiSG73+HrA7LFAIUMLQR9PA2KP6UksrZHRpScDLsn0oiZb4MZD0zX5K7jmMsMLG8LFeQUNpMZkAvcuPwLCHT4WXJYfIGkj/GBAkonxitggPWCY7IdFlL5LcKXOwuhrT0S5Jva1MaE39eGJLaWKhx1Zog1CMVev8HrWDhfmsnEe9Kfy44yTSsUAjjbA6H1MzOOm9mqk5lJG+o2C+3OkvLVFHsdo6UIRijaN60Fif0twuJkh7ne5oZJJ8t42YzvGZHhKy2Yx8Mja/n018f2k5Mb02mWYbB0Z2QStqwAXjwouGohpCUeib9D0SH1llqQ4CCXf9RNqm51iKcCKxW6kpaXB3sgEn6Tu+mM2hY5VXCiV6U+97mBaSLX0oyH4FxLOMee5gwaUtTTQwm1fK8ZQ36N3e1batvsjhWbpnl4SrGgQOpBCRf5o4g1LzIk3skaCx4/Y+AQh6ZLY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(53546011)(26005)(6506007)(6486002)(6512007)(6666004)(478600001)(66556008)(6916009)(4326008)(66476007)(66946007)(316002)(5660300002)(8676002)(8936002)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGk1U2dqZmV5bzFKSjg5d3lDWHpIVWs2MXlta1hiemhxSzRuY0JuNWhFemNq?=
 =?utf-8?B?YmdTTlFRcTRFZk9EZVZ0L2x1bWdLbGNaSFFVbWtXdmxaL3VTUldJaWVSRThG?=
 =?utf-8?B?NmpQdEc0VkphbmJjbmpmNjRuN3RISHQ4TENhVTJ5SVVEOGttZUdSb1ZnYkww?=
 =?utf-8?B?YXRuUHNIczF2QW1uVExVR0VyTldMSHpxUjNwTTN4cHdxZkJSQWJ2MmgxRGZO?=
 =?utf-8?B?TDdRdkJBcEc2VlZrcXRGUm1OQndsU2F5OWZjR3V4SXdnemJFNHBLaFh6ZkV1?=
 =?utf-8?B?UEZSYkFQdDdPZWFSR01wdkwxOTVkOWlZUWtnVEpqM2NuUEVadkNuSm5ZblRO?=
 =?utf-8?B?R3h6TUVBYTlSaEhkeUZFSXVQMlBhY1I4azlDSWNWdUN0Wi82ZjBoL2pudng3?=
 =?utf-8?B?Uyt0NUF4aG1NVXVMUnNZSXFRR1BmMEJLdmRQVnpCYVRrbDZVekpFYUFnNlJ3?=
 =?utf-8?B?NTdEM1ZCZWMvM1ZFTmZMcnkrUVd2U3VhMm5kS1ArT2VYK1U2Zm1MaUY4VGRp?=
 =?utf-8?B?M2NDUXZIQ29NblVwc3Byby9SKytPKzlPZFIwWFpUd2FTQzExbnF2NmVoVENn?=
 =?utf-8?B?NmhVVGhLbEhGUXZEWlRSVFpmRDArcEp0Q05EL0dTTDZwMDM1TE11b0YxdXFl?=
 =?utf-8?B?djFZS0JWY0JEbmhyWk5TTTZmTzA1d2s0QWVrRFZ0c1hEaUF4Z0tqY3YyeE5E?=
 =?utf-8?B?d0ZPbE8yb3VUZ1JrSU1yeWdvNmF0U1dUTHQxTlRSdk1DQ0ZUWnhFenc0Ymgz?=
 =?utf-8?B?dTd5TFRJMUMwTzArbitKVExMVmpBY0RzQkFkOEQySG1XeVhlYzRhTUF1ZkxX?=
 =?utf-8?B?L0NISnIvZlVPNWlFVkNJaHkxdjRkVk9Pbk9yb3cxT3hRWTNOVmRIQ3JsTS9O?=
 =?utf-8?B?K1k2YVcvQTJURnBsbWFsSVBNRW42dGl1MG1RMGZkNkl3em15WnNuSWU2YnIw?=
 =?utf-8?B?RkpUTWV6akY2YkhNUGl1cHVRODNjbjI0YlRyVitTVDUxc1N2ajVaN0hZSDFy?=
 =?utf-8?B?dkZtYm9yKzAxSGhmTXBBWHJQai9RTlgyR1VpckVDdmJGcUI2MW5nbTNNdG9n?=
 =?utf-8?B?WUlhK0FWRHpCYUNOWXhBYUkxT0taY3B3OHd4WU5rQmNiMUd4QjZITnM1MSsz?=
 =?utf-8?B?bmFDd2IvWmlrdVJ6M0RKNmZYQUZHU0Q5Z3hmdmFLTXF6UEsrVkZZNnlSRW16?=
 =?utf-8?B?eUJlaVNvQlJyKzFVUWNSQS9GK0VkNFdrbFVkOHB2cjN4TUVsRFdlNUoxZjJh?=
 =?utf-8?B?VnZrdmtuUDZSdE83Z0lHMGdMWERiWEhzekU5Vk9ZVnFucVpPZVEveldTT2Mv?=
 =?utf-8?B?akxyVXJVeE12dXdVRkQ0cC8vOGJySmRTc1N3RWhPZXNTSlVVQVpaWU83bnly?=
 =?utf-8?B?aGdJWllIcGlMZkwvenRtNTB6YTU3Z1FpSnZESWtLT1Z6bW5TdEZuWWRzUDZ3?=
 =?utf-8?B?VGF4ZHhKT2hLVWpwNko0Y0JDR1dPMHBaSzk1Tk9vOW8yOStBd2xCRU9hL1hp?=
 =?utf-8?B?UHFKQzhzWG1IbXpBcVI4S29YT3pETUZwcGoxTDB2UFp3ZlU0ZTJ4TFdYckZL?=
 =?utf-8?B?bkJqUjRWMmNrSkoyRGxUM3U3UDJ2YUQ2QVdxb0Z1TStJeHdnMzhWdUJFaHpq?=
 =?utf-8?B?MkRubHJoYllnN1VOWmRzNnc3ejBjUVZLRkUzMVNzTkVTVUpBMjBQbmZobXRz?=
 =?utf-8?B?QUhOcHBVMEdBSmFla0g1YW9FcTZlbXdEcDRZcGRTeFlBWEloU3BHdUl6Nkcz?=
 =?utf-8?B?YWdCQTRHNUszTUI4elZUOFViYmpZL05UVG9DY2IwQzFTenNlZkZIR09QdHpX?=
 =?utf-8?B?cEMwUkE1TXU4TW9OL2VseE1zb21ZQ1hEVFh0cnVmdUVqajBzN3dPTHdDRDFV?=
 =?utf-8?B?Y3NPLzhHd1hXbWM4TWtvUmVxQ3dBOXV1WXlQaTJBejM2NWFvWWo5Q2N3RDlG?=
 =?utf-8?B?OW5aWTBWNmtDRkRQU2ZhK3BYZ29TcTczeHFrNGdNREF3RmswNnB5My8wSG5m?=
 =?utf-8?B?SGxBT1VDbE51T2MxL3VRSzlYSm1EbnNjK29WNnF3MEluOGhJelNhaC9nQTZr?=
 =?utf-8?B?Qk9vNVU5WFBBdU9TMlFCbFI5M0plekxYbGZyaWxvanF3RFFxbnI0LzF6NDIx?=
 =?utf-8?B?UGZVaW14b2ZnV2NEMGMyYWc5SHNWQ052SDZ2ZHZja3BkZnZGT2pSUmZOejE2?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OZlcy4xbfyTM0WF0Ky1UMUTEzWo2icOlBz3qbCHT5AsmsZCsJlgr7qieOOzeIXJZlJwM/k5hG6pGgl8PVjaOqGsdwsPP/ATbPSeZQf/qUsJ5wfWID1VWyU7HyhvPVll4If4bjq+MaMZtsc8mqx89ZOLKQ/CS/ZufBNpr3fqoD2j6vUy1dQXwbBQPwyJbX3/YIYen1zCmhThdwghSDd8udGvzlpOUUGmIsUG4LxqwFQRHPoYQBH7PlaBUOK16DAgFy5BninDXobN4qvbaeCPdfuFTKgV8oJ20PzNungbmoFbtc8zFE14ILT5PqTpn1RiWLodTLjiPNF/CPAgkxeppsDTPQkzudQ6GLX0HVRP/ZAqK0yhfXfW8a0rJssl7+BcQb4SJ5V3WBlkyMBNX82i4eYXzm25v19jgbI8vFsoZuBf9bh/r9lRjxe0cTOzzOGjOJgYfqwXBu3FClZli7heHp713hDVfOowHP7cwYw2AANPsBg60aZZjr2BwGRo6FeazmngdzGiTQrQopjs8Ah1L8Lt46wa4kKfCUTfWB9W3OFfKBjAw6ftOCv3NIL/2+WF6P86sXqVE7ZPPYwNfsCq6CS8Lt14oZFq+gyag4YYYp3zct5yvVhG6TN8BxxyhLu7qcU76rWDe3wqfvrcc4fZLrW9m+tX91h8fQLXzrAck/8cx2COI0ugSot8ybOF1j/TUVk3+Qi0xNPYcfLJ+fDqkyJ1p9cI8l/QGDOEAYqdT7WOCtKce1tHp0YaZ+VXbKRJ9DALzrPYpI1Fv9xIrPEaW5IrN4zoXhai3KmPVGD1adXw1AZHDJuDVoujmEP26Q3EMURhdz1dIac0qjGDRvARrH1r9dX8L31Fw+vC5L6VtcG1c78teoTYtodX0hY49JH9c
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73092a90-269e-45a9-dc77-08db6156a307
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:41:33.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83XQG82loCqdxQSv2edR7CSHL5wO7HVZU9CX5Ll4sx15KqZwNuaDCVRRrUY7ZnrEwhcIf9GnaPsE3DVkWtDTSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300176
X-Proofpoint-ORIG-GUID: wkVUXvHWC0GUaKT8VPIjSevo_GCpWNHB
X-Proofpoint-GUID: wkVUXvHWC0GUaKT8VPIjSevo_GCpWNHB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 16:18, Greg KH wrote:
> On Tue, May 30, 2023 at 03:40:08PM -0400, chris hyser wrote:
>> v2:
>> Apologies. I sent this the first time without including lkml.
>>
>> v1:
>> This originally started as an attempt to solve a divide by zero issue in sched
>> debug code that was introduced when a sysctl value with non-zero checking was
>> moved to a simple u32 debugfs file. In looking at ways to solve this, it was
>> mentioned I should look at providing general debugfs files with min/max
>> checking.
>>
>> One problem was that a check for greater than zero for say a u8 succeeds for a
>> number like 256 (but stores a zero anyway) as the upper bits that don't fit into
>> storage are silently dropped. Therefore values greater than the storage capacity
>> must also fail. Getting an error when what the user wrote is not what was
>> actually stored, seems like a useful requirement for the other simple files and
>> so I moved the check into there.
>>
>> To enable easy testing, a test module and test script are provided which can
>> validate the new functions as well as check the new limits on the older
>> functions. This was stuck under selftests, but it is not currently tied into the
>> testing infrastructure.
> 
> This is a lot of new infrastructure for a single debugfs file that you
> could just check for in the file write callback instead.
> 
> I'm all for cool new features, but wow, this seems like major overkill.
> Are you _SURE_ you need it all?

The current use case obviously does not require all of this. The idea 
was instead of a one off fix, it might be useful to provide a generic 
solution to a common class of problems.

So sending this out hopefully would help determine the perceived usefulness.

-chrish

