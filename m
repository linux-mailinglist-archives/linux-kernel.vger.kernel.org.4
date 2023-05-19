Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA945709C02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjESQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:06:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57406C2;
        Fri, 19 May 2023 09:06:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JFxQWn017508;
        Fri, 19 May 2023 16:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9o1Rl+R0+BLLs701dgjwBH3aOPkU7Me8N74m/L3R/HU=;
 b=GdDwLZ8K6pTtrxKCQY3S0ErnhkavRRNjBPzkM1cv2SGUZcWbTAYnY928SDlHR/OTxQum
 RNHuHZt2s7RGcA83toONtXfgQsiw0DkXTBVsAPF/EYf9vBx+l4MWGNgwM5Fe5cGxCkO5
 cemHS7dQe3PbYcmyQMzR0bOLW0BIQ8i+AmWpo4+Q8TaXzH/fjXuuRCw40Yxy12K3SZZE
 xmRxA4a/P8N4Wz0a0R5HkPNuioEWMhDk78RlN2833dOdNdJcrwP5AQlNgKB9Rk81bW6p
 ZrqACJPoOBYrZt8ABGNy07N9wZU6WtggqtsybGjaGae324hN9O8b2kiEAzOuXY2NRSgF dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v2jtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 16:06:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JEPaib039993;
        Fri, 19 May 2023 16:06:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1080t79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 16:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS+QNG8WMVfBKMblTx5ZCX2nIglHdSo+ARthHfaDQuHkESM0jgbsgzoMyTXiwhlnjji6nbkHHleELmfRUWpd3xas+uSO+LUDGaPlgo36IF+x+Vx/+isdUr3TuFV20xD995Mu7NyVCPFF3NeCpB05D4llB19GepQglYe+nA0hzLAgPbmL+Bn/rS645gMNrsp8dRpQ9s77g6R5WsBO/PwP4mDIC+7Gje+xfFZbz+ieEmtF2AeaqSy5qdtw1HPA/F1DF+8S/CXB6Yw884FHY5qE7YyDaXb4w/Jsefq8gm2J6pAuF7L6qFyTmPouzTBTFLpTBUiDLUvDTg5DvEirgZOpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o1Rl+R0+BLLs701dgjwBH3aOPkU7Me8N74m/L3R/HU=;
 b=ALL2fMRNYBxkyL+5/SsjRh7QCXZxboqUQgushvoKzPzLvQupockDL/T6ADdJwCTX+Aug5Cm8DMuK6f3obfN42gxgkL2aCfRU4bVJ6wvrk8Dm34Eyg6loRY+V+3P5iB0u0z5hlBKoI/lgqkCICD1SczY0sWc+uU68zUDl6j48EXc5grgRoOeDbyntmsakbvq/IeP886v6rxppKtFn0jgmleuQ+CRDQzMOEBNOmI7DkbIusuo/usOKnC/rKum+Vw7QCc1g/eHmYWguT/mXXiUBFIKHbro1s+TGywihakhn28vVTdLio0IPdTwueN2ocHGk6i3F6oQV7De0TH10XepObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o1Rl+R0+BLLs701dgjwBH3aOPkU7Me8N74m/L3R/HU=;
 b=iPDJECjY6wNCzZHoBeNfEfvA+WAO6Q9MQsIeBJjc3cU11Scyf7+j9uhq36ZdIg2bDFAz/mA/1JgPx8COzFtKOmOVXlMkkBsXPkQosZROszDgBI5sayp4Ypo6CtccUsPG0dwLLtohYIFSKAMU0KrDvZAT8BGPOh7QELj3pzxo8ho=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5642.namprd10.prod.outlook.com (2603:10b6:510:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:06:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:06:08 +0000
Message-ID: <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
Date:   Fri, 19 May 2023 17:06:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Bart Van Assche <bvanassche@acm.org>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d75bbde-7843-4290-a271-08db5882f4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pm4VzWet83V+q5DqAYYu1gPHpFf7sD7m79oB/lCioqx/XJxmDl9VcDtiOxqCvhDBI2shpQb62fkJtO7BvcksjsrxulQsBjmKHvasTSzI/1AKGC9067iR7+sD07sX+fcJ2yW3gIPxESCsKdbZ0VfyKj9n8fPvzdaxXLk3KYbIUkhNOQZiun+xSBlXPhdKX2hTiscTHO1Fmcd8kjHshODas9z8gOJD1OBcZvDJYU9UpWyHgaG6RVtgWi383UFzv3tnswa2EzaZQYh938yWLHtjYECuvl0/YQTtLwmwAGeMm6360It3L1E1HSPmZtTA1xlQbtm9U+xZkul5cLJzjzYuILJan9xJqOqj3ioDO+JgPZviUv0O9pfx3lE4JZnZ5VNZb/Li5i6vmf6YMLsZBUFT+6uyudIomHWCFCYaXhrdtMXGXlQgrnUmnRldTiT37rW6TvzXwYZwvwjIsaX3yeJSsWgCkw8aGs/gw+jgv/aZoY5xpm88Tp3dLe25cbp+SOAk2swfwZ5FGpy+K9g4HjRRNdyJSPtcEeAl7sDV6/jAXeLi2WgSDdGeEKhD7s+R8bEun1s6MkZ/2X2t8eu9/gBjJuay7EjYzV8/ulQsvyQzxTCDOveYY3TVDfoZdis8chxJ9wXUDpSFYoNgQz5unwTo8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(31686004)(66899021)(4326008)(6636002)(66476007)(478600001)(36916002)(66556008)(66946007)(316002)(110136005)(31696002)(36756003)(86362001)(26005)(186003)(6506007)(6512007)(53546011)(2616005)(5660300002)(8676002)(4744005)(8936002)(2906002)(6666004)(6486002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW92Z1NtWkYzV1MvZDdGbXQxeDAxY3lZdzJBVnZ4Y0x2UGhlL09YeGFiYmYv?=
 =?utf-8?B?aFY3YitmQXFrS0RDNFdGRXFoWmNDTEIrcHh3V1NKVzJZb3E5NUFrM25wNExK?=
 =?utf-8?B?REVIaUpKOEFENnlyUW1BT3Bpd2NreTR6TWJFTGR3U0kxQmZmV2g2UTNReGNF?=
 =?utf-8?B?Q2R0bG5QRDZ5cnNSN0RqaWRiVjRLL0hFaUJkaFBXL2IzUnlpSWJ6UTd3OEIz?=
 =?utf-8?B?SU85SkcwM0t2Z2QzV3ZFRTNiT2dITjRZWVV4QmYxcXJXeHpoc2lsbjNaUjRp?=
 =?utf-8?B?SEx1emdGcWsrajVvUGxnWnVnTTJSOFV3MEw1djZNd1l6eVk3MENoUWlyYmVS?=
 =?utf-8?B?cmxtRHN5T0psVXZBb0dDTXVidlpsOGlPbzZoQ0hLZk8wK1BwY2xTRXRTaldI?=
 =?utf-8?B?Ykx6R092VTVQTWI3VGRFQW9yTStadXdyVVVqY3NqSzNwWXF4ZkUva3FTNXJh?=
 =?utf-8?B?MFNodXA4Z0pkbGhpeUFUbWRwdDZZSXUzNXdNcDRKeHB2em90ck5tOS9SSmts?=
 =?utf-8?B?M2FyN2VqN0lCTEMrbzgrK09tcVVselFhZlhyOGUrSEY3a1ZDanVIdlJaSEx3?=
 =?utf-8?B?TCtXK0NaVlM0aVhMbVZzTFN6cmc2NVBDckszMzVZd1NFWWNrVlI1dk85M0x3?=
 =?utf-8?B?U0FzL1FRUU5mN2dFV2ltUFhScVY5QTFSNG90RngxZlBNSWloTkNLdHlENDJS?=
 =?utf-8?B?VkdHOGdoVjZhUHFjZ0JlMWFZTEZiL1VhQWtHWGVLTkNFRnI1TDEzSkMxS1Ni?=
 =?utf-8?B?eG9sYVExaitBWVE4L3FTY2dzMGtKOFRYdWlwK0lqbkQwYzF0QjMxdkgvbGhJ?=
 =?utf-8?B?RXFDMmQzTlIveTljWkJHbktXZDgrMnJadm4rVTBUdVhOZHpkVTZUZFRxczVC?=
 =?utf-8?B?TjVHRXlnV3BmaTB0TytOL2VReHA2L3VzMGYzRytCK29ZU29FbEpsMHdxSDM0?=
 =?utf-8?B?RVlUZmx5VEJMeHJ5ZjdaRGN1REpIUzVUb3RWMmEwUldJZXEzMjQrMjM5SEZP?=
 =?utf-8?B?ZG1pY0V2VmZSVkFDbjZUd1ZoeHVndmZnSGtsTFpncEs0M3hBV2xHbEhNWS9w?=
 =?utf-8?B?Vy9Sd2hlYmRVeEhsMjd3dnRudUJDWU04c3M0TmVFVGtHT01pb2ptU0t2MTlF?=
 =?utf-8?B?OGR0ZjViaDJCaC96cWQwOEJTVm9nVC95dTVGanRLNWtXalo4dDIwVkdQb0JT?=
 =?utf-8?B?eVlyeXFWRUlxK0h5QVNDTUdsZDdZeUdHTXk3cmFlbFVOUjdZUkFXejJXU1dh?=
 =?utf-8?B?cEowYjVVaUZIWDBQNlMrWEZLWXR0UnZaTzFOeDd5WEliWmYwbmpVRFNHdFVK?=
 =?utf-8?B?R0VWUFJYKy9JeFpRMzIrK1FPY2lOOHYzNHYwWUs1WXArRENRN1BpTTVQQmVv?=
 =?utf-8?B?eTg0R0o4OVNta0VCYjNwNmJSTmh1cExYQW1qRFQrQXg4aXhmVkg4OTVmd1cv?=
 =?utf-8?B?bXRIVitpZ3JMYWFrS1BKV0xjU25EVWM2NnZJa0czOUtmR0ttMzlJVWRvV1hk?=
 =?utf-8?B?Ly9XazUvZnZxQ01OUG8zWjM4ODdGN3poYm1FdWxjZlBiZ09NR2FDSkk1V3JT?=
 =?utf-8?B?RERWS1NJcG1RaTVkTHMzYm1xNk81Q0xmMmcyVEhESmVkZU5URGpFaVVKZGI1?=
 =?utf-8?B?NTI1ck5HbiswT1h4cEFvQ1lOa0NzVmhKbDdLdDVIZk9XLzg0NkF2RnRHRG43?=
 =?utf-8?B?YitCTVRoUHFCRGJjOGl5K2Zxd3FRcVhKdUFIQThZWEk1UEY2elZ0Q2MzbXFr?=
 =?utf-8?B?OHhqTDRDQVBIWFRCdFduRDc4Y0R5NlhsUFJZMllPemVkeWVXNjdudjJyUFVB?=
 =?utf-8?B?T1BVcUhVTnZ0YnpqeUFwRHBXZzIvRGhmMDZCZEJvY3FyVHl6QThmSThUZ2Fl?=
 =?utf-8?B?NXFzcnZ4WC90SnJEWXdLQitQZmZNOFZGYmlDYk41SldyT1pUN2VVbHlVb1c0?=
 =?utf-8?B?dzNvRkhrRTNjMXBsZHMxajhIQmorWmdzVlBlZWdaRzVSakJVWlpuQlV2RFNM?=
 =?utf-8?B?VkJyVVdTOFRlMkxXbXgrUnFZeERkSDBDN1d5YUQxVmZGYWNvd2w0aFNoRVJT?=
 =?utf-8?B?ZUhmaVd6dUFwNWhSVC9IU0lkOGRLWVB1K3lNUWQwMmdGUGt1QjJTMXJMMEdW?=
 =?utf-8?Q?Qb+DoHKyHf+2/iehVqDri1tQX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X6q/bqbbSNTrQrZHCH77kIDwrWpbI5tXtK+SPqjfb/yPUY9qn0HU0uj9JxNd3SYVDt/CiPQPW8XgWWpPgKYd+EZi/4vJ6zg87EAeVTK0Yo2Trl8Oc6f70mShy40sHPJn+tsY6vFUyxi8XB9dPhyhCwBp3zqoXJnFdVw97bxu4ZEeow8QDMITH4w52Cn3Jmlq24a7nDLaL+4AMNnuQOf2CeI0EVFhCrSlasGBG9vDxhgt/bbkz8zyW3bEFExlxuh14OWcIcF/FgV50uTCKxOte7IwXGEJUqE3l9EZOPkIzFszW5Rrfl2TBE45ZU6l4kSMsqIdhvqK7Hod++0HhdbdcuIabJTaCuaiOdBQOzpL7q1xXTOdvIgfkhkj6JaeJZwAO9IGzoB2ctvtIv4xf1tW+f2Yg8rpy9qm/9Z8O2R6MnfltE9xdoT+7KtR+Rp+KxFP5sPrQ0TtdyVBqCR5j3/AtzT/GR9PzStLFhnRreA+HughHBg3ZmIAIz+5c3sUEpsmCn2w4+7j2UuRIt4qXF0PZUefdu3vAksxkOYhFBWAVDzwLgNGuxlnRnUwmZ2i+T4MNmYrmtIEWFXcR11Ww0MX5oFSK4tDakHPFzyvbn+/qm0hMBljDuaTZvop1Ibm/VGAjAP6x2zpb2A83tw4nO4f5sE//MvSqAUfU1OUUSiUUqIes8FFQ9J67ZSZtToGk3Xsx8C3KWliXeI4LBYiAXiXjMnFTLIh0Wb5cKfbgASNIU7PRRIkjwuyVX9qeIyFTINoWyAFBNIJvOSN/jbvzCNzL1XuJL4KP9cEptbTx1V1C3q+C4l9xesGWAo+thh68dKF4tkEBzu+2YItMGGz93D9NA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d75bbde-7843-4290-a271-08db5882f4d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:06:08.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36EMGQ2h04D6uLkDQudhKowpiB1Vdy2kgklz02KQ5gMcS1gV5ta1/R+9vGglndokSZrv1zT5b9VlCGiSNOxkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190137
X-Proofpoint-GUID: 3P83intpm1Y_yROOjAaqeM9lFkywRMMe
X-Proofpoint-ORIG-GUID: 3P83intpm1Y_yROOjAaqeM9lFkywRMMe
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 20:54, Bart Van Assche wrote:
> 
>> Further to that, I dislike how we pass a pointer to this local sshdr 
>> structure. I would prefer if scsi_execute_cmd() could kmalloc() the 
>> mem for these buffers and the callers could handle free'ing them - I 
>> can put together a patch for that, to see what people think.
> 
> sizeof(struct scsi_sense_hdr) = 8. Using kmalloc() to allocate an eight 
> byte data structure sounds like overkill to me. Additionally, making 
> scsi_execute_cmd() allocate struct scsi_sense_hdr and letting the 
> callers free that data structure will make it harder to review whether 
> or not any memory leaks are triggered. No such review is necessary if 
> the scsi_execute_cmd() caller allocates that data structure on the stack.

Sure, what I describe is ideal, but I still just dislike passing both 
sensebuf and hdr into scsi_execute_cmd(). The semantics of how 
scsi_execute_cmd() treats them is vague.

Thanks,
John
