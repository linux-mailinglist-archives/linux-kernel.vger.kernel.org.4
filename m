Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3E706D09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEQPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEQPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:39:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1653524C;
        Wed, 17 May 2023 08:39:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4CuV032034;
        Wed, 17 May 2023 15:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QrWOk8gnNzKOC3RhBvRu5NqShM0QvrjyLwU//eOHkmc=;
 b=BgEM9b/lbUemJ1HVMikmz++CcrA3F9xu939b2nOoe6GhfV7LpAbeLyn+wyXgoi3zpSKY
 nC3MstOQgGGKs0V6997HKqaLXKaucHAK0yMfnoUepf1IhCNaBU4xxak3yM6upFtc67Vx
 J5sGUeUv2zbpOV00aPIy1oca+blaXrzRNGquWNyKKytEut/9E5gCOBY6zsmP0uDZY8fZ
 GvcXg40wtdsKlS/BZxrBXkfEMVn5N/cRr3dnBtExcGZchpKQpdq9z9fvZrTfhEIbRlbv
 qwsxjGobibj3yni/ZW/mWe2Xutlomw6Ao1PD8B/JQEFlTwFBCN+8/POf+8rPxJPlYCJ/ ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdp54q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 15:05:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HDohBv025033;
        Wed, 17 May 2023 15:05:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105j0q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 15:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czp7zn++jX6trkLECaZ8hBpnJuugL6Q/1PmIiOH3nQf+8gFRmjyujNNkQmW6nuuDd9Tko48lHQ393RMP6TKelbhBkjG0Yi0X1xttptSMtRrOQihXzlGSdXEN2OLC1hu0Uhgk57YvGXg/XD4ZzjNUywlqgVqUXWzTNxL4AQQxNBzS8rJTAJQlnOYTSj7oElE4ysGOJyCG/1/DBjTDPLJha8rFMSAKZpXRXdIsSW7JOZ2+EK/tWsoMYVhziTjMXDvbRqz17S72y1WVK+3UjBYtOFNZdp6tjhjhwiQvSbZTiDualxfTp5wk1A2lPet/BRocfiQvxFAHzQuF60U70ITHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrWOk8gnNzKOC3RhBvRu5NqShM0QvrjyLwU//eOHkmc=;
 b=ORi5AJhJJBlO9jwbtc7t+wlR0y2kbQxG1XRg4+uMOsvWX68PAhMdSaQ+LYSIdwBOV8FgLr5EmEp5aMLdX64rrOiLIITt6qJfuWeFXsoomy7w3Wo7GOQp+N11hn+w+0X22uAvKj7UR8JihaK1L+CNsbGisNmaiPoEqoJMsclUMedD8c2NkUYY4SX8UT7d+6g1HsC7CGGrL3wWxp5e+jH107F5ructR2a232xrgHkUr7KSFmDKD99etqFxl66BDNJTfoUBzeI17P2sNC6leXRxn5wuVYtmIC3DG6HLrNANIyuKDciqHVyXFL5ZON4HkBpQKw309Cl0JTZ9m9P7YRpMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrWOk8gnNzKOC3RhBvRu5NqShM0QvrjyLwU//eOHkmc=;
 b=RCzt/WAX8Qya9dX+k5XLOKyhAXJW42MLvWqg6MCdNerMDRn/eUzfqX/bpmpO+L7p7GpRbCJfUa/kTBuoU04A/Xf9rQuriCIY2UlZbb0H+qxxf1p1X3Sz5/GyBbN47FH8y0908bIc7Eka5Bd9cj5v7Ren5baJ4DPL7sj6tywlkJQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4663.namprd10.prod.outlook.com (2603:10b6:510:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:05:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 15:05:42 +0000
Message-ID: <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
Date:   Wed, 17 May 2023 16:05:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0691.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: c681f9da-23e6-4504-e74a-08db56e82f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmHwYxXBv9iBF3IY9nld/ZpESAkR0WtYG3BtJBkmcwnbV2h9Dhu0WDK+lVW5zQeWRXfF03PRyYHwkBeBORJCJBxT+i3AXnEvzCloBg/2nv7TZtq8zBMnYf59ufXI6lMjBjeSpEVg50gH5XmIStPPMOid5Gee+diFE/zt3n5vFa0rP+Q10GG7QY+96z3eMdCkAZZCtVGLGQ+sfGXXF73txLA4Snhljxzey8LIWoV+j0xf2XqYu1ouFdwKYeCh8MI9FwGjKOePIO/hXVkxCg3UQq1T1YzqefC9kIL4ZZ2w8+nELXcTnrO4TJ/fgCqPj1jc+025inyYagiX0sF3R6Q6rfgc9bCPfGlFX4MCXG5xOEYjDwwGIrxya4Ko3OIqwR/TFxopEbpyp1MNJ6skCf01fU3EI6fb9rP0EUtgxDIn+hl9fPlGmX2+vkggkOF8uWARYC9fAbUY+72YcZRtgBXmwkI4KhjWqqcke1a9rUHoKLU3WNFeYlFYwIE1h8vw0XfKUApY2AtJjGC6qRjHLv5n+Tz9HBiSRkECeUueGFg5a9kjHDw5ED5kbhBvTSE1Ns79c6rS3yrzjY+UpTRKIehglnNcIgfU8G6gBymDjYsx/L/f0upF8Sj7UDBL2UijoZW7SmefDEi10/gsLZuv8vCvDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(6636002)(36756003)(4744005)(2906002)(31686004)(4326008)(5660300002)(8936002)(8676002)(86362001)(41300700001)(316002)(66476007)(66556008)(66946007)(6666004)(478600001)(36916002)(6486002)(110136005)(186003)(26005)(53546011)(31696002)(6506007)(2616005)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTd6MHR2cEtlejhOTU44U2Eyay93b1pRb2ZWSDBoRCtQM2JLc0RqQSsyRU0w?=
 =?utf-8?B?R055cWdTOURmbi9MbEdCTUpveXp0aTdQT3JGanhLMGNkWkdwOTduUFRacnZk?=
 =?utf-8?B?bkhTQm5xY3Z5ZnFxWkRKY0VFU1M5ejYrbXUzcU4xVW5NRUcvWFEvQ0EydzMw?=
 =?utf-8?B?cFg3Q1ZJYnYrQ0grS2dTR3ZhTHJkblFzZmwrNmR1MnJuVlUwcVRkbVVEQWoz?=
 =?utf-8?B?OGt6UkpqNm5xQmFEbU5Mek4vNmpNVU1vM2lWUlhNT3ZtQ0NRRWlMakk2Uk5j?=
 =?utf-8?B?ckRkbXgvbWlOdFRiMmV6bHpZRWpMVTdJZzl4UDVhV3pyMTZLSW5LMFZhMUFU?=
 =?utf-8?B?eWZLSGh0d2dHaHBYN2c5eFI0SGFOQUVpUStLc2MvVm5OYnRSVVhWV2VWem1r?=
 =?utf-8?B?dVpWNUkyRVAwSWFXcUU5NVBEaUhSYm51NFc5d1VkZFFaYkE3Qjg0NTFMb0JQ?=
 =?utf-8?B?eE5hemVwdlNQVDUzU2R5TXNrc3RPTHVxckI2elFvVVdES09YRlZRUlZNN0VJ?=
 =?utf-8?B?SGlXbk42Q0wwV1d2SXJwc0ZOSjhzajRSRWU4NGNiajhTa3UvZ09laHJJV3Qv?=
 =?utf-8?B?cHFDQmpYOUtsVkZjZEd5WGVlSzk0ejczSy91L0xQUTNiY3RXMmRCWWV3Z0dV?=
 =?utf-8?B?L3JOZHMvcnJHMldUczZYOHNadGV3T1lWSmZpc3hRNXpsS3dYR3VZR3lFQmFn?=
 =?utf-8?B?dUY4YjJrZXpqZngwdnZXMXRRSVFodkFJZDBJV2dGUzA3NkpHc3lQV3QyN2VB?=
 =?utf-8?B?MjZLaXVnWUpDU3p2UnBRblRwSU1tdWgzRUJpM0VTSDhPaVBJK0ltV2I2UXJ0?=
 =?utf-8?B?MVkveGpRYWlGaG5XVUpDaEtvV0dIc245Yk1MUWdhdkg5enczNFpBVTdDYVBR?=
 =?utf-8?B?NDlTc3BHT2FSeHVoL3dnZ3NtUi9XbXVzTjRhdUVnc1RXUFY5ZUdmc29WL0Rr?=
 =?utf-8?B?ZVVxNHd6S3laWnB3K01NNVZVYVE1aExUV2c4WWZpUWtjVjEvODNQeWx2dm5y?=
 =?utf-8?B?cmV4Ukx6cG1HS096eFV0eGRrZDZRaVNvQ24rQkhzWERRSWRrWXNMbDBONXp1?=
 =?utf-8?B?eHZXa1BmeFo2eVJMcnpWUEhKOVFkdXl2TVNhL2FHRFRDWHRIUDkwRm04dzVP?=
 =?utf-8?B?a3NqZTgyTFVUQnpJWDNidFZGUXlXaE9SM3IyQnhocnpBTEloVlhHcngwVGFZ?=
 =?utf-8?B?b3NCNnVOajh1MjFrcVdpQVFya29SZ0pzejNFRHhLR1BoOTR3R3EwMWJjMTJa?=
 =?utf-8?B?QjZ2VlZmUHZldmtPQWVmZUg1RklOWHhFN1NOclNZZmU0SnI3MHk0K3VndFEw?=
 =?utf-8?B?OTh5dU9TdWtkQ09KSWRjY2ZaM3h3RnNLWUxDNmZNMjZvTFhrcWpRM2VtZ0Np?=
 =?utf-8?B?VWgrblJzY0lPWS9hZTFoV2JUMjc5QTk5c2d5V0FkL04reFRLVW54SUorNS9D?=
 =?utf-8?B?bWRHZXVncGV3Wi91aDJUOUgyNWdxaGV2bWpsU01MMGdTUlNWYUpJdmFyTmVQ?=
 =?utf-8?B?cXhFeWJ3WVE0OTBtMFdudmVKNzcwUUYydDQ2NUUzMk9QazRmZUliTjZlbTdI?=
 =?utf-8?B?OVJac0k4TVV3OGRBQTlZL1Z5eGVtNHgvWXRSWlNiOTUxc24xVFFKY3dPZzA1?=
 =?utf-8?B?Z0J1TzA5M2pSemY5UXg2TlZqUnZLNFFKT0Rzb2tIaEdTWGtDb0l6NGYweHlZ?=
 =?utf-8?B?U0xOT1NUMXRwSFdKOGxKb3dVMnh2SklSR2tydi9KdzRwWkZCRXNLR1Zrb0Zp?=
 =?utf-8?B?MzNQMXdNb2ZsYmZVMnlkbEYrVWl6MFQwMmNTQmJPcFdXUWdpT0V4a2djazdN?=
 =?utf-8?B?TFBycjlkTkx4QXI4VlNrSXZHVTNsc1d5SVN5US96SVEwUGZtTEszaUVzOE1D?=
 =?utf-8?B?alBlT3ppT2h0b0h0K0pEcEFRWkgvMmljeHI4M29DR3BRa1lQb0xUUU9VcFl3?=
 =?utf-8?B?ay9BQjdOaUJmbXV3ekdCeSt6ZmtYUnQ4cE96TGxxZTloTEVhb3NUditib0do?=
 =?utf-8?B?SmFMMzNlRkdWb2ZJTnJSNk1DUTB2ZG1mS0VVdGU1SDJKYUtlNi9aZzRxUzJE?=
 =?utf-8?B?R2FGVG5VKzZGcE9KOHpWUkpwYjMxY3REaWh0WThPUTlLV0V3QkY4ZlV0SG9R?=
 =?utf-8?B?bDZFcERSbzRuRURyNmMreDZaOU9qbDFQN0lJVWh5S1VCREdyRDZqd1lGbVlQ?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5oxUBPOkEwVTjXv6BKj+YgZ21OypOMMnaF+SfY1P1utvhYx+bEq42h5eLjk0AdSxsxyedCsYuPgRVvAF0s83JObNXD3HIrhNV46uof5lds/eHDzAaVdgS07U2PfBfjqQJ0vCcO1VEutjOVA7FxHutXZ1FADgGY4tAb1ntQPpb1zRVL7SuetrZw5e1nad2STs9lxfkdYNjGHYjzgpefY2r5fWvLXSY9x3MIdGQEL08kRIQqjz6qRH7VPCzoUqDEITeR6gvRIDfcyp6s1lz56oxyGkLhMqa44RWsUelLHOKfYnQ1ZvRWrwbBN0XWepbt4LVm6EtwY7tEs7+f54O7S0t2JkADpNMRuWw68bUCvHj2ixaQZpIL3q+mCSoK3Ol5cX5KCcXsY7ThCC3dEHXZ4/KoTMvmvwrvGgppEMiuFtpiihIX3KpHUpCivfqVvvh/eDFfvKDey+A07Ds5fP9OFBpFxbMen7UFtcV5zw85ajZehmerp2ddcZfKKka05CGgSNRtPSCHkEos8heLQxZ6ClbsPQ3NKZtnQwNl97D1TUmv66vgKWCf0NDi9PQFv8abdE9PpLrpitEjiT9Bd0aJzVW7HeTvdLeU71GLG71kjTTXL8j2N69/YRNlfYbsuibqIdpjw6j1jsdx5bjkx5uhH4E8fBNJOJJBSNS1qgBfV8A0tXmNlVCJyrya4AQAuspxs9J9RhQ6+nQnh3+i0NdUw6zqnwzjhZFPoot1PqAWRr/6mJKWt7DA1GmAR6d744w8RED+h85KlxePPjAdp35BKi+ocipMN/BTSS7HoF7pbKkm/YO0CRxLvufblLf2g2Kbre
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c681f9da-23e6-4504-e74a-08db56e82f02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:05:42.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNRh1AMdZjpzPttCUyh5pCRxyo6dTrolsx6/9vNOSkDl5g2VumA94RStw9Aw/LysXQa1rIYHZRgydOqJtwhZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170121
X-Proofpoint-GUID: ZVznW2E36ppi1L9eVVcAEMjAIwUJt74s
X-Proofpoint-ORIG-GUID: ZVznW2E36ppi1L9eVVcAEMjAIwUJt74s
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 05:54, Juergen Gross wrote:
> On 17.05.23 04:06, Martin K. Petersen wrote:
>>
>> Juergen,
>>
>>> Some callers of scsi_execute_cmd() (like e.g. sd_spinup_disk()) are
>>> passing an uninitialized struct sshdr and don't look at the return
>>> value of scsi_execute_cmd() before looking at the contents of that
>>> struct.
>>
>> Which callers? sd_spinup_disk() appears to do the right thing...
>>
> 
> Not really. It is calling media_not_present() directly after the call of
> scsi_execute_cmd() without checking the result. 

Is there a reason that callers of scsi_execute_cmd() are not always 
checking the result for a negative error code (before examining the buffer)?

> media_not_present() is 
> looking
> at sshdr, which is uninitialized in case of an early error in
> scsi_execute_cmd(). The same applies to read_capacity_1[06]().
> 
> scsi_test_unit_ready() and scsi_report_lun_scan() have the problem, too.
> 
> Do I need to find other examples?

Thanks,
John
