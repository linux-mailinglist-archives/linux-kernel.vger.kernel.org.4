Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210F68899D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBBWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:18:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4125084A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:18:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDrCh001865;
        Thu, 2 Feb 2023 22:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=h/8evIfF3vnmp0RKmVPDb6NdO1XETC6AlfK66NeJZxDks4t1aCOVeoyVZYHVt1Lvh1/k
 MnanI6rV6pVT2k0AbnOzoD6GO2lBkbdA8vanERK0mBYdl4ZpUoUWYlyF0T9Cxn9SUrR9
 eiX3+th/gatN5oPtULHLmBZJIr6NggO6YpB4UrKjEQZutW+4MHKtQa/1avFNOjm+OotF
 I01/f8WIVrxDysvjeUD9OGWXXzhAaimmIzh6ChbG1sFBPZX9xpX+HBQugBE+THttwNtb
 DplYdkQiMkqo4O6nDPjowABKlNxypqgAVTVGf+uz2KmrJ4hrxrvUa2X7ddbrAuSnZYyc vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64ck5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:18:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312L19mw002469;
        Thu, 2 Feb 2023 22:18:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5g9quu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 22:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERbykFKdlKVBqns3rfPc2cCkiuY7Qy5Nq5+MmHw0Fzabl6sivJyf/6Oka1e8fKEAplWzEc2R1pRb1UTEgEDJmUmoST4wlO51kKoXFO1vAUcYUTWAKNS+cdRkn8Q0gI+aCz1T5K2yDCw1cskdjdVVfcwmJVZnGNT424aLCqKP1cbgTZPQkdjWwDeCKOn+kHHibjeY2FCVvrplCLEKyCfm/qzY1udJGKIM4lT6byFOr2QSc/HG+FyR8hrxUzVwmMeDXBAxK2sJZdv+Zt25Cx9fp9fjO6Ot8fbJbL5srxrj1rqpTCeNUM6mRJ+ECza5E2hhRXlug/7VmbEfp/z4z2dZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=BRa3PkuvVry5BpnBDil+11JGmTKZ04MGkXM8F8hCVDX+39Rm/5x6jfhBf/qnJBqu3u+wPcAig/c9NgeyVDubSRbPFVQJXRjq4NhTnsvUxUnxzPNvFZ3DhRJ8Ia1kuxu6opiwy4MsFX1rTVia775NtOpIB36ERliWwAq8/z4Qvn1iv2XuyJMrBd9Clbpf3ht1zltvS/Pz1NFnix9o4F7RxkN/8DsY+4RUtQ4gKI5184o8dzfSGBEXa6cbWcdS3btuY/gy0fk9qVfPXC28LIjF9lNqYw3aL3/185crOli2Nc9SWEXFg4VqBmbEFx10L7QWRFaHb4e0xS2tH9M0WECXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=hrJ7sCx1ynLCAyw7hxesBQOYLtMpDySNs/DfF5xpiRKxA1GRf0bWk/v79MjSLYPG9DN6p1l+bLFvbRUPPlaHg5INJ0jCe0RfRPculpI/BdgALkdZQr7m9g2mq8FG06Uv9XfAhpvH/kTs7U5IeF1xCcRN+hdWdiZcwQBamMUIljo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 22:18:29 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 22:18:29 +0000
Message-ID: <c4576404-46ef-2991-8b68-2b0775da56cf@oracle.com>
Date:   Thu, 2 Feb 2023 14:18:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
 <bad92641-e10e-cb06-179d-2f4bc11c721d@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bad92641-e10e-cb06-179d-2f4bc11c721d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2ba19a-c01b-4a06-5d54-08db056b6959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoNK4UeYNb281yPo3zYDsOqAOtnu8jvoP1jb1YFz7tpJTDY0JB0/wtiKoTMxlV4zDQGdeX68dAHz4KSdPmcaoQ74Ak/srOSE5Vj7qkpI2se5jFs7i/nN0jW61TvmedYNXns0GQ/wpDs+DRYYIjN2zCPsIOWy1f2NDsrh5H3gA5Ss5Zatr3K8E/F3PY8npRyf4ljQodNpGaHAXgFGDh+xZo8Lad5KJTDriyKQpG+8WX3qPxl1az50mktDRp3laBXiXdFDOEdkuIzq4PAQ6aoaS0XPiQPSJGNqEEIvgW6EMBKEaYwkQH74fA6fs7/gFMfgJm4OZOOLVsWr0/8XX6XtSnV7C6uvi8ne+6imvBpCCUnwYtcOl60GdqvV6+h2MZtlHcQV4jcHDqamMgXAs/1f1OIAeQZ0TXAJXNydcBTcZf/b6Mgo14VNSNReDg+jh+wMTfv4PDD2f11xaA8hA9Greeag6ff15adVt6OpAOiU0FhNlqNswKbq5PoK2IUdiVNycWsuChYT+zG3vnfOevs7UVa27JW7+Z+2SoulFTZzpziUmPnkOIuXn815vuWrWOsjoqpkcWnZGeo/glBCuFZ7xPvakmkjqjBKuIYL4WsutQ+CXXmNaI8G+mL00wG1AbiKJkPZlD8qp0JAa3J3NhPSPDImEWEIlSSKWPmqNmmx2XT29ioY2b/wDsbhwxYdF55h18Bz7uKQef8hin7MwrEnmbiCEqsR6MzF1XJmEF0LaG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(2616005)(36916002)(6666004)(316002)(4326008)(41300700001)(8936002)(66946007)(66476007)(8676002)(186003)(86362001)(6512007)(6486002)(83380400001)(478600001)(66556008)(53546011)(6506007)(26005)(31696002)(36756003)(2906002)(5660300002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdpTlZnUUQ5MklhTnpZNDVwd3ErQTZPOFBQM1BXYVZkRFdSU0FkU2pJaHp4?=
 =?utf-8?B?MEdoVFV1blBvL2Nma01kTFNodHVXUTF5d2I4UHEzZWlWUUJjeVYydTBjUmtK?=
 =?utf-8?B?NktUZFpxNWxDQmFEdmpDZkIzUDU3Nmx2T2RJbGpTVUpUTm5naXhIaG9XK0dE?=
 =?utf-8?B?d0pzZ1BsT1cvTTVRVVJVZFhsNFVoLzFyUHJrOWpUREJibENKaG5oWnZsT0hI?=
 =?utf-8?B?aFlzWTlnWWdGSTBQVEZ3MWZFMEdaV044RDNQRkprZ0ExNkdQb25nc1NVSENP?=
 =?utf-8?B?VmN4VlVDbHZTN3BzRTI2cFEyM0x3ZW0rTXpzQXJxUkVCU3orRjlteFBuMi9r?=
 =?utf-8?B?RzVLUXFrakJZWlRFRldvR0ZOOGhlZUFPRDJjbGJ0M09iMHdGQ2w1RU00Ry9n?=
 =?utf-8?B?TDVVRVBJc20yUUdkT2FTamM3MU90aG9uYm4wd1Z3eGVJUUJ1THlETkJ2Y2dC?=
 =?utf-8?B?WWE1c0NiNnZ1ZmVDT281TjRJNGxMS3ZKUU56bnppdVhRN2RCR0k5em8zYm9M?=
 =?utf-8?B?ekVQVVpNRVNKejhLYnlGdjluSWhya041RXVLNUo5ejBBRWJvUWE5TlZwRXJ0?=
 =?utf-8?B?c3ZFSWVrekQ4QlZycWZlNHFMNVNUMWdhSGpaRDhEeHAvVVFUVTRkSEdxUmtz?=
 =?utf-8?B?dW51U3hHaWQvZkJFSzFiNE9KMnZUQUNnWjNOSzJOMXlmL1VvL2RwZXdxOVdt?=
 =?utf-8?B?VDc0VTA1eUNGQ29iaG41Z3ErVHlwZ1FmRkdNZHREcnM4dXFyOFFCbm9yVWpD?=
 =?utf-8?B?ZjdHTmc0V2ljSXZBWjJPZGg1ckVhOVN4NDc3L1VIbG5iVVM3V3Vma2oyM2U1?=
 =?utf-8?B?UkswRGVZVklRVnl4V2dDdjNRclYzRGdIQjVZQ2hsY3Q4MmNrTktLY0N3TklW?=
 =?utf-8?B?TXpQZlVTT1lpZUduUGpicjBmZDdZNU1CdU14SVJsbHV2NnJKMWNqVTREaEN4?=
 =?utf-8?B?VDI0dUliRUVDeGlBTFFWcG9zaURpTlhlbEFZdVFpOXZFSU9mREFZd09tc0RU?=
 =?utf-8?B?S0E2bVE5cElCYWJUTUJNdlVUeGhYenNKYkJld3lEY2FXQi82YUE5OHNmbHlO?=
 =?utf-8?B?SmMzdGNxYXBmVmxHNnk3d2creDk4c0E5WjBRd2laaGZIQ3IzY3A3VGNCM09B?=
 =?utf-8?B?a2ZqSzQ5MlBzdzc2dDBzTHJXaDF1NE1WYWdEUTRQMVFPclpCYmFpTXRHZDlJ?=
 =?utf-8?B?VXltaGVIRFlFTEtwRTJyWEM4b0xXTDNSK3dDbm9vQ09DbGJxUzlhdDBncURw?=
 =?utf-8?B?VUdIMUVxQWJsVXNWaFhjbWJHVU14ZnhRSlI1bEZISzMraWxJMlFqRXlCUHhi?=
 =?utf-8?B?Vzh4ZzdMcHUxcWUrN2IxZU1hWCtNUlNjdFJVZDJQRUtiTnNEdTVlbW9UaFRw?=
 =?utf-8?B?cGF4VTE0azNDbVBGOEExclpoY25zMzhyOWN3Rk1HRWY1ZlZ2SHlFV0taS1Rx?=
 =?utf-8?B?WFRKVmNnOEdFUWJUYytEcnFkSUhtWnFJekpjZ0NwSjcreFIxVmhOT3l1eUlN?=
 =?utf-8?B?aTByelFMeWx6VlRtVGlTNi9SNk1TTzdJSTJ0QnplVStjSmJLaFhUMDgySjFn?=
 =?utf-8?B?YklKQTBNN0JJamh1L1h6ckpzeHBNS0xTQTluaCtJbGNUMmhzTEpzc1Q3SEtk?=
 =?utf-8?B?UDlWcUQ2U3NXS2Y0ZVpQNUswZXlpVkZ5VFpBTUNmaDJDVm9SSmlVbUlXLzZ2?=
 =?utf-8?B?YngwVWkrbTJhajh4TXZ2K2hpQnpxRHZ5bHFReHlUQzdtMlNRYk5rMHE2bzIx?=
 =?utf-8?B?OUUxYTNSd04ybHVoWjl0aXBIUVJGQnhzVWE3YTBrdDhyUkpJcGN5NEdDbEV0?=
 =?utf-8?B?Mm05K3RFV0NyalBjbng0YjF6cFFFaWtEY1RzZlY5dDBNSGpwS1ZaTDROZmlq?=
 =?utf-8?B?SHhxSmNzRmdsT1IwanN5VnloSEhldWhydWluZXZUbUg5UlQvRDFKSlo5U0Vn?=
 =?utf-8?B?aVlOblA3YjZDdG81NnorS3dMWTNSMVFaM3pwb3lsVk9OSnRIQkNsOXN2eW9T?=
 =?utf-8?B?RS9OdW9ubGFFeG5LdWFrRWd1K1daYmJ2cTJ3T1VjeGdGeGdtM1F1NzZtTERZ?=
 =?utf-8?B?T0JCdWlPL3ZGYk9reTc2WTVDUGtLZ05weTJSaDVMRzltMVhLSnJMV2FyNEND?=
 =?utf-8?Q?cd5OFg1DUDb2tKlil69bTootT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oThNqxWzWOoSzA+UmMQMD6PaCgidX0BX6V1tou1aeYPBhGyOWfWqLoMF4Xlz0zvbjftRavP7U91prSmQ7rKPU5NOCg/PC2MSA7BYLFFETo7yKmeT1dA+RDcuk7lTHvVdHHW0aS10Ht2BuD2ogom0HHEvKWqRaN4HgkpLRVEWhuYw0us2nm4WKdIghnRyPAgqEUXzOheg14iu/E8du3ggoCIokr+AtxR6R2cY0TWwbNJCdSP4HeKe7vcLa8KhCNmwdAI0fkZjJxVuaQHI3uPhKQlmXh9p7ZrNrui/Yx8fwZKeImik0JQUwxUiBzkLiJ7aIhMurOczHFIhgHaRvzUuVTvZB+K/zAua8OsWvcxKlYZ8uRzChP09tziPrf7cKGEEgTtdbUhUvl5z0TPXJVqZcz1JpnOK6JtuevCwPmxkRO3afxUhs13zuVoIoP/LasowTU2XguuDspwICj1PoOPt6iLggfudqM44dXE9wNfaRtY/19eUyzSC9Xwvf1gyVtl0Nd0VBOUfOqUL8E/iKRDeu4XkTuJJ+Ns1bpDNdDlFS4g7jxKx27KNvHZAX9J0W2DNOneeX+5brNnoHFu+Az344JB3peZ+BSb1igrLg5qZD/sMl/UBHNoS83CKy7+e+//uJ/aNA6wZo0rCLaEL+dZbKywlJGWQDPMfjJ+Sor5OrnJLXIO1CHUHu4jKLNB6LBpLdtJv1kOT0uJ3RXLhn1+jbM5VsxDXR38oJzbCRftmE5AKqM9yhTYOuc4PEvJCEN6bd1/QafcY3Qs3wHFecbaQ+GouU+OR3HSa+niFZrIIv/ds7LOkqOqghY+jiUeOfDQARRFeEr+RGA+k1wIBdWp48Lx4SkoEilhwdYrjookuY22lwdQM26THAYy13pi0mRtpJZPHZaFjhGjJ0B4JNSs65w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2ba19a-c01b-4a06-5d54-08db056b6959
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 22:18:29.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/lPqIdOxqiP/+RLh1hUzTaPyix3NMr7RYLY0nMdT8yNDj0naDLnLwlTOv6n7X5rv/N+aw463ShWJyRxZuEkrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020198
X-Proofpoint-ORIG-GUID: jdJ3a2NZMDDvs9gAM6Z-2NMDjwiVrQm2
X-Proofpoint-GUID: jdJ3a2NZMDDvs9gAM6Z-2NMDjwiVrQm2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 5:31 AM, Eli Cohen wrote:
>
> On 01/02/2023 1:22, Si-Wei Liu wrote:
>> The spec says:
>>      mtu only exists if VIRTIO_NET_F_MTU is set
>>      status only exists if VIRTIO_NET_F_STATUS is set
>>
>> We should only show MTU and STATUS conditionally depending on
>> the feature bits.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..3d49eae 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block 
>> *nb, unsigned long event, void *p
>>       struct mlx5_vdpa_wq_ent *wqent;
>>         if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
>> +        if (!(ndev->mvdev.actual_features & 
>> BIT_ULL(VIRTIO_NET_F_STATUS)))
>> +            return NOTIFY_DONE;
>>           switch (eqe->sub_type) {
>>           case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>>           case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
>> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>               goto err_alloc;
>>       }
>>   -    err = query_mtu(mdev, &mtu);
>> -    if (err)
>> -        goto err_alloc;
>> +    if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>> +        err = query_mtu(mdev, &mtu);
>> +        if (err)
>> +            goto err_alloc;
> device_features is not defined as a local variable. It is defined in 
> the next patch.
Good catch! Will revise and post a v3.

Thanks!
-Siwei

>>   -    ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +        ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +    }
>>   -    if (get_link_state(mvdev))
>> -        ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> -    else
>> -        ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>> +        if (get_link_state(mvdev))
>> +            ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> +        else
>> +            ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    }
>>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>           memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);

