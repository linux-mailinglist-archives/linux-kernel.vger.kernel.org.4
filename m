Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190EF6E987C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDTPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDTPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:39:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309B1727;
        Thu, 20 Apr 2023 08:39:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDtcP8009257;
        Thu, 20 Apr 2023 15:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8FUV7GXmN4K2IpEUnOjpj17Q9q9cr6QGmvXyqr5vzqQ=;
 b=qbvUDhlwwq0VId4z43KqwQSCRCTNjzU5OYOVSuCz7oJaUSDgtzzfLj5kEfJc76OoCNT7
 cVir90B/5PkPT/KyDu4//ViBAAcfJHrtNKxH7EK34Yg4zB07D6IOHUnFLmdmJj1OcK7g
 nZW45CMWQDT2pK2X7bAKcohPcYAzu9pyZlt0jmr6A0pOj7MrgxrnJUFSPkAHTWkhZEFX
 Ac3/Vzm0rTuDaoi4ETZnsGJVXMVgumWY46FECyNRx3J1EfPB6mAqJkZBzkGCWbmVLAGk
 hlnem8rHg8ujmBVa+Bl9wC29wC83K2p2lERvm+q3FVYMoAEso828D/qoVutgdyt+eiBb xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1u8jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 15:39:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KE4dTv037865;
        Thu, 20 Apr 2023 15:38:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8e80g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 15:38:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSVpi80eGrOXU7e6UjkMdwPsjVjqJ4+2smxcXORZvFUcXvaN/MVWayDZpbC3XQ67Nr2m3wRi1MPvNkToHrr0dckwwRt8s2A0PC0z3R+Ww+MUiomkD65JV5BNlFMLV3qU7pGTd1EiT5eoHjzjX6PznfL+Mtt1LuGy9XTN1Vdlr+/lZBFCUf6SbR9ZNkREwbdGc2OdOpWcB2WQovfp38o8htj1zo1EW74ThTAATrT7cyS4sFlxHJPD/a/QUqy1FipsD0QABL3bvEAdwFOYdFGP+2fz3dNvfP0plK92BHPrBcKWpUx0sVWS3aP7p/LHdcVeftJ0XFUyHT6CC3t1n3Lf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FUV7GXmN4K2IpEUnOjpj17Q9q9cr6QGmvXyqr5vzqQ=;
 b=j1YTxYNuRQcIaM083QQKgjItTScJ0ucX8LtmpmMNA589lpa0bngvU8/lyp1kGXB7RBNxIeRrRDE+r6NygLBlnJwKxh6JLRuKV3f6vGO/RrxT4amK9Uat9zo2huNksQ7gqHsrBGO72+UREwbTaCmM3lYS1BEHmUrSemV9G7sQv+3SvXOOLVu6obPpZnlgJRJD1Y4jtAhPPzSGJyQakdHVkBb4SxDfNHj2Nro3BuhSvIh717xLFNU4DwMsMaIo0Wz5VADOWEPtw84JOCSYpigffTZMxyONVMcv6X+x10kzUbkO5xDKCMd4sSwxeeb0CaCUeF30reyUKs6lI0zfSWDR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FUV7GXmN4K2IpEUnOjpj17Q9q9cr6QGmvXyqr5vzqQ=;
 b=iv15ajcQ3dPjzc1S+LCjAk/0wn7XNIp3dzrmOA5J1DYWtLRF0tHMtl1aT7UVWkuS+LLMKKFglNoUi20+vs5hFiF1trvN5WETSu3ehWD4ZDPyjDNCMJZQ1wtr+77SMGEjM29hxBcXBakTFQZBLN0zHlBexOxZbZtMIcio1Wvj++o=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 15:38:28 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6319.022; Thu, 20 Apr
 2023 15:38:28 +0000
Message-ID: <6a13265d-634e-d52a-44d9-65d05ab28b1a@oracle.com>
Date:   Thu, 20 Apr 2023 10:38:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] scsi: qedi: Fix use after free bug in qedi_remove due
 to race condition
To:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230413033422.28003-1-zyytlz.wz@163.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230413033422.28003-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:610:50::16) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0be747-3c33-41f8-3bd5-08db41b5497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/XSQAKt+wJ35bml6F4fLeCENOt6n7QFl3IQLRB4FF98AqJVVfN0egBJpYYto3K3+Oikp1juuERluiNE9FuWYx+h03v06yQGAAF6/dhBibxKlHGWwcaaYsJPIuNFYie+8zlTKxoWfkAliFh5NRhOMwfZ8crrYDPTEuJiPQdBygdRxjXWEJNpMpB2nj60jDJfrPH3OBt+fRfKgc3aCLh93HisDAYj3XZxGbffyIVwkAwz1dWdqpUAnBAcHTkYiu6hMYXlOmgYxYwrVjp9PqSLDaWWaTrZGnhGhkChPHTAdLq2rWic0tvCqx69ZMfip2N0eAn1gt+6bGAzuE2QPbWjNrNoTjlIj0/ORDYjakNRshPbpilk5LsETAxfX/ZNQeh2c8EFGS7yhXs1SIImW7WdkJLynD+dSGvIp8uaJK8r5kLoWPY7Sz3kFy6nFDLIRorKKmojFci99iqbyd4ab8XQgLtaH9Sw2qBgES0Qo821mzXC6mjx2gOFTEE7qoIF99lHNagrbRr6bmt9gOeGhgTRZqNbi4ZoHEmO45GqPGp1LsGshuPAl3QD0di367JtR1Avyv1+TdKi1CSt7xkjIVt4tlSy+Ic4s5QXuxMlzcT+oqRGzrKGpq1jIlYFiZPkiNxYW287gAjUV882S30tO8rqyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(31686004)(4326008)(316002)(66556008)(66476007)(66946007)(36756003)(53546011)(6512007)(6506007)(26005)(38100700002)(2616005)(41300700001)(5660300002)(8676002)(8936002)(478600001)(6486002)(31696002)(86362001)(186003)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTV4SHg2ZVQ1WlBGSnBKMzV4dHNaUGhocDdtVG1JdHovUlQ0cStacmJyZmkx?=
 =?utf-8?B?ZEN4ZWxEYjZCR1VYd3gydTdoUm9JT1lob1JoTUx1RTNqTFVFb0Q3b3RJN21O?=
 =?utf-8?B?SDF0VndjTkFORVpDMkZGREVNZ2dBQXNheFBkcFVjWTJTaGR4L1U0ZURXOTFE?=
 =?utf-8?B?MlFsT1I5WHFGTmZQcjY5U016WVlxOXFuQWoyZmxRN296akFMSGEwRHNuRXY5?=
 =?utf-8?B?YmF6eTBpMmxjdTdXNVQxOXg0TDl6OWxuQmVWdFRoSGFBUUlmMjdoSlRrM294?=
 =?utf-8?B?YlcxelVVWHhienpyVE5qMXE4VlVtUlhDaUdyQXA2VlNCMUpBWTB5OTdvUUgz?=
 =?utf-8?B?WWMrSE04dUp1aEMxRFR4T2lHK05vMnltZ2VwTWxtd3Zxd05aZzB0dDVsYTBy?=
 =?utf-8?B?emNFclJ1THNLYmdsYTN5ekp4Qk9Ld1pvZE5wNDhreUdVbVJVc0grcHpIRUhT?=
 =?utf-8?B?MG1nNldqTDYrZ05JRUE3Q2R1c0FMemd2RnliT0IxM2VpaHFLdXU0ZnFvTUx6?=
 =?utf-8?B?dGhwK0J1V1I3TGFXQ242dmQvOU5tMmFZQlVBSFB5TlZEdkkrajdVQTErOThq?=
 =?utf-8?B?L1pZa3JrM1F2UndpWEtGTDExelBFeWhLTmJkV24zMGV2YVNCRjVjTG1wcjR4?=
 =?utf-8?B?L2VzeTVTdithSXM1ZnpDcDlFRTFVMGlhZE5CaDE2STBBemhvZkpKNW5ZbWor?=
 =?utf-8?B?bXpvbmxmdEk2V1pBWFQ3MXVuUG5EaUVnWk94aFVzelFtam1rdFVJSzFlc2xx?=
 =?utf-8?B?MTJnYmVVZzJja0Yyb0pPRXJOY0szS09FME10OUo5Q2U4OTBiYU1RcnR0VFhO?=
 =?utf-8?B?cW5haTFDRVRkbDNIM09CSUxCM05DK1E4cUNxVXhOWnhsa3hDcGV3RlJGNVJy?=
 =?utf-8?B?NndqY3V3RUtYSGt1eTdMd0pDcGF5RXJYb0lObFkwaTBXS0h0d295aC9CUEdY?=
 =?utf-8?B?RFRhV1FNeC9EUW9RblNiWkNMbHA1M0pKRmJ3bnlvYW45bHVheUJHdXA2bmRH?=
 =?utf-8?B?MmlzbS9aSnVzVFo2RnBwbkhrdi9aQnMwTDFIT3RITGNKSC9OUEJzTmZMbGxj?=
 =?utf-8?B?RzR4KzlnbGdmMW40aXduTTNtVDNQc3lRait1MThXUUhzTVdscmhqMjdhdG1t?=
 =?utf-8?B?aWxHdENCNXpLeC9Sd1NzOEJob0FFVFNXZjNTMWZWT0NLaW5GSEZOSURJMkx3?=
 =?utf-8?B?NWJHZ1JXbDJTN2J3Ym95S01EQWlDcENkY2Z0NjVvcnQwbUVZdGpKNVJzVmgy?=
 =?utf-8?B?cEttZ0xLdjRzMmRRaHZhM3pBeVpTWWJsdVZrZCtFU3lPUWpZZVpLSllQbDl5?=
 =?utf-8?B?QlNBQkxBRk52NWxiNnFFRVVPUVpSZlpnN1J6NnBIMGpTV01YcHplT2J1NmxT?=
 =?utf-8?B?ZFpwVVlpKzBVbEdRajkrMzZVOTdnY0x1dkJjWVJMV3ZoOWUwRHJvR3hUd3pM?=
 =?utf-8?B?dDlvcm9KbWZ6UkU2QUY1bmcwNDc5TUszTEp3aGNhNG5IcTkwY2NhNGlYV3VC?=
 =?utf-8?B?OVdyTkthL0dMc3hMcnYzY0JURTlraFBJOFFWWDY2VDR6eTZ1T01xTFlRUUI3?=
 =?utf-8?B?UDc3RVAyUWdib2VLSFMwN202bHNFeDRJQUs5aWljeUhsMlB0NE1yWFRIdVR6?=
 =?utf-8?B?WGFmdVlxN2UxMVMvTHNya3RtcThvTGF5UTJqTVlKMGxFN3RRaVhLQ21JQ0x6?=
 =?utf-8?B?aDYvMHFiRytqQWdJVVRhMVNEbHFEbXE2bElma1RxQS96eFN6T3Z1bjkxS1Jp?=
 =?utf-8?B?blVTMmJIVnB5S1NOcnZSeEF4eGFVaURVQVJOcmFBbU9BbXpGaHc0UFNnWEh3?=
 =?utf-8?B?anNNSUlzbDZuMHo5VlZRMGxOcnhpTVdFeERMbFYvZ2JkNzN6MmlrYnZFZXhW?=
 =?utf-8?B?V1lSMmN1bDltRHYyaDBsYUltZ3VNQ1ZpMW9kbnpySXVSZnZLNW5BaU8rcHRN?=
 =?utf-8?B?aUVnUU1KZjFMVXJmRG9MY1NzdThSM3ZISDFkTEFNQ1FtTmlzYlR3cC95SDFC?=
 =?utf-8?B?cEZkSkUvS094ZEZKNWhNT08rb3pmNFJweXpwQnFxeHlDNjJOU003ZGZ5bmtG?=
 =?utf-8?B?aVhQd0JhOGQwLzJXVDIybGtncGlNd3ZrVVVlVGZzNlR5LysvM3Fud3ZjbWhR?=
 =?utf-8?B?UXBNWE5GbVl6ZndUa0JYMUx5NHNnNWZjaWJXeDA0eDZoYTFlMVBGemM0SUFq?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wv7uJCyzwR0AApcr5aJ72TkZWcoQG/sTpjbWYUzEnymKboIMym9CJqzwuWWQIbRkY1wHCArB4dxqz5S/D8sqawyUxjarbVAGjmRyuoVeKUSYmB3mXxgTU5eNn/hsbSXaSDLhPItyzU6m4Gi1CsZydXklCQJTnOj/jWjodtXdc/i/MKnU73JPadZlxkM01U7fhJDgX7dI1OdiGfhMvWgGFJwNLbUMFxYwOLpv7gXPK8yQXe5nEUCCfMf3UxtjnlA02H52i8vtdTG2fa+FmxTVjxqgrIVZuCYi9iNQEi1Z8sfUPDzApKskeKHRrRAwtRJdHlPVZu9V31TrqmlN1cU8suew1qC9oErAlvxx/7SYNzlD2MjX2JsJnox17pveMKygTlHhJR1GFtGpog2Ci7I/tIswyfIxXUWFzzNkMe3CFWOpIrYXz7GIXgXChNuvooMjj5NPb38b7gWvq9Eat77J/uN2z41IEeWmNTA2HccVg8nkTRhmhEf5NMyODxphcOkeWQdNLyxDKB7gnK2rOQAoQA+4UW0ujOcifajRiSW4G4ey6chtW86owpvimA4P8YZwa89TnmaCWGeo9I5p7M8va/rXrLOGBII6qXBc8o6UbnSzmt22D6Y446nabfyYsMV0U3t9Jmnc9LkpJkWP4THP5tdgOChX8CdLtpL1xXo+VzHDZkOpKzIpIy6YjOC6O8CCUj+fYy2Tuw1M6ssXdBNqjTxtdSpKJiEa/FbWgnBi9uTiDIugnHMW0S7EnkjU5Dp+G8+UqQf3ayeNxDyQN0wuZOaTYo7FwHmjXrBbS/OdBxKnrZP+Iomc11rI2Uz9F8hie/GY7IFV/tpXEjEDA+jMyMw8Yr5m3FLbo8Ee9PcbUhfaCMl3Rd/ymXSYFLwUMDl6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0be747-3c33-41f8-3bd5-08db41b5497b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 15:38:28.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyGidGRhJMzaT8PlG5ESwkaNvoE+AlsYwdeUWTJP9T7+rxpa6N2a4dNtOBDKURY2rqI40Oy0hqcqgIvsradfro9Sn28ksNDPijBnj9/qkRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_11,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=832 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200129
X-Proofpoint-GUID: bf4iFg3Ba59LG99RyNOWH9MQPyhY-CDd
X-Proofpoint-ORIG-GUID: bf4iFg3Ba59LG99RyNOWH9MQPyhY-CDd
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 10:34 PM, Zheng Wang wrote:
> In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> with qedi_recovery_handler and bound &qedi->board_disable_work
> with qedi_board_disable_work.
> 
> When it calls qedi_schedule_recovery_handler, it will finally
> call schedule_delayed_work to start the work.
> 
> When we call qedi_remove to remove the driver, there
> may be a sequence as follows:
> 
> Fix it by finishing the work before cleanup in qedi_remove.
> 
> CPU0                  CPU1
> 
>                      |qedi_recovery_handler
> qedi_remove          |
>   __qedi_remove      |
> iscsi_host_free      |
> scsi_host_put        |
> //free shost         |
>                      |iscsi_host_for_each_session
>                      |//use qedi->shost
> 
> Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - remove unnecessary comment suggested by Mike Christie and cancel the work
> after qedi_ops->stop and qedi_ops->ll2->stop which ensure there is no more
> work suggested by Manish Rangankar

Look ok to me now. Thanks.

Reviewed-by: Mike Christie <michael.christie@oracle.com>
