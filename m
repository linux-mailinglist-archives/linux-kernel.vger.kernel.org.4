Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1462679D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiKLHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:14:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5D17044;
        Fri, 11 Nov 2022 23:13:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AC7CXqJ013018;
        Sat, 12 Nov 2022 07:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wDPhttsBlUctjxm6MQxEM2wty46J44jAFx61AZvKAmg=;
 b=U4FnkfOGYHe3wmww5hdX9dNZfig95j9af9Qd2So99BXrKGMwsle0Y+12Q281DCAVs3D+
 4A4JcRrKMW1+ByMsUJ49Hsp0TJvNmk5PCGSuE5GRBZpILQWDIks1XqMGgVEA90sxAeqe
 j78QoV4wFpDCxsqUBR1KXCqr8POqcVu4kQLKbpcisgBl9jsfc8sUnnbTQZ3wveIya3MK
 DwnqZMIdKx61eFWeRoHVFFSx8NHFkYsvu6UBLL+76KfuL4FWTpaPsgqoWfGlS3SwCoEl
 UkTQhpnMpxfw1H8HC441PZVg24AVCyapNzZO/9OvhoVn+wzIGNiwOzoCQ92e5IB7EpmT TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kt6w000af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 07:13:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AC4S0ba015563;
        Sat, 12 Nov 2022 07:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x85ydy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Nov 2022 07:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i86uSbDJiVXdv4ZsSu5vSZMV5Hb7AmbTHU94Trl5mh2G1i1nIZp1+vKDsLsdAh5rPS3lQN/M8jqyvQNiTYMLztsQHbmxTNAKndyqzo3Wx574Fo+QY94fMxEn91WgM5SC2uCQCRScZKxtUM0WHxFF7KKKP8p1dbXnFeX2e+msSzA0QwmzWOuRd/mPG5zscNkWGG4lrU7PzEpzYU4kTLkXeAwF0M8wwHOOCYqKBtijzR2COv7/JV5KUczhen4la3C9PdeiMPr6ioPCQpdH7pSvJ0ujNjmzub6KXos0+fqiX9t77dE6FaFd3OzDoYY1n9sfCgtCnW+dj3pHuJwBECYWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDPhttsBlUctjxm6MQxEM2wty46J44jAFx61AZvKAmg=;
 b=S/WCUjA6pnigKA+rAdQCMlwR1GNxCTJe1bQUhA44jRzZ38bGOHKQjchLc9FPn+4CIDRwkEbViOCKE2nuNmIxPbfK7FlKI+usLcn/5AsmJcUYIwe6XOnFPbbyLF2Cp4O34SnNygGtor4y9LFVlr1M8AY38fYUwdq/YVJ31ZJd9QhGA8p1swpGzMOnN4Tl9axr4SpXMCQzlTEEANI6sr9CWzk2VoHpknCtBImthcDI/YoFEIo2xfIQxJVkD1u2Wg/F7TtMr7eAkqvo2KMQDAJnD6qiTElluQTRP5aDnF4tVarWpuyeTSn+gO/AO3ahRqp77MczmaKvWDNCZV0By8UuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDPhttsBlUctjxm6MQxEM2wty46J44jAFx61AZvKAmg=;
 b=Q8Dl1QOLu1OdDUc0iZ1TXmhR6wASh1ru1djFyx6Ws7CjQffI4zt69I5ZPgsm/sO+gRzSVuNMz+mSa9vKxA2lLJX9wkQIjfvXF7jtRqVru0zFXdTxGu5+ZT+CR6n9s3dSIFxylK7ZWehabJs9n74wbnP+z2dpzR044pZPv24oXto=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 07:13:54 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891%7]) with mapi id 15.20.5813.012; Sat, 12 Nov 2022
 07:13:54 +0000
Message-ID: <fa578a51-5bae-21be-df5b-a72f5f79c662@oracle.com>
Date:   Sat, 12 Nov 2022 12:43:40 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_write_scat()
To:     dgilbert@interlog.com
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
 <ffef9612-00da-43d2-caad-4f71a7ef7e44@interlog.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ffef9612-00da-43d2-caad-4f71a7ef7e44@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bf9fcf-5db9-4721-268f-08dac47d7514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8t1T7cLXmQd2RfiJP2xnMf683jd962yXXQPgnFcO8lRr5q7Nbi79DlGA6kBr7PZncu8pQDS1VHF2aT/iobgKwltc818jeRdSvyvScrLIpoGcharMitIFtq55rp4Bi8W817liWqOT/wuYhht8DXeCA2zYHCMUW3k9G7q793yXYTjy1vMZ6KwepYuW16PCwCLTnWUL2DdPEWI7wduNKoYp+ooMqK9w+tsLmC6AqSKwfww+cF729JphkvkapRB+CrfXslreGCVSc1xaGbdL82jJ7bPX1G1TVGn14thpviXNWYHkN56Zu4c/UpPlu80xrr7+fqfRWu7ZtBA88GC/fO7TLBnpQzvEzgPkK1PCXXRhwUKmNkjHuDlXG8jk8EYQKD6HNvPk0klwohMJKjFWPs3tB/fE8EqVrjTBj4vVFddq8VUzDDTz/cwSVM7rYgjKFKn+rlW3evC7IYZy/0QymxcLRtJfjzck9De4EOOBvbfUR5tb4p5TFUnaakvtRIGz1qgfNx0JIDxUHjaFszRy1RPzQifgANvZzFTuPCeLn+rktTyhnGJ9MTevfnQ1WVHMjMdVLtWODwmCnIqd+c6q/bLat/ywZHdP/uCMWXR5J0gH07fv7IZCNYbFbyfFcQhyYpFOiYRVR9HtaLT8G41RGF6Ff16NSsGcqvDBvr+eh3DVbRWioH3gKpuWWJseoShuFpSYMNxV218P5FecASh+X9rfTZ5w9BRFseuvpLGsi0qEz0/vBYHpRtdDxY29YMppjHAf8qTRRDDDfY4xrt5u4DFIt9Rh0fDTic4Osi9FFogZJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(6486002)(4326008)(36756003)(66556008)(66476007)(41300700001)(66946007)(8936002)(8676002)(5660300002)(54906003)(6916009)(316002)(83380400001)(38100700002)(86362001)(6666004)(31696002)(53546011)(6506007)(478600001)(186003)(26005)(2616005)(6512007)(4001150100001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFpmZitVcTArVEIzY0FPTnc0R1MveGw2amg5cUVFUnRJWnlESzBQclVZY1ps?=
 =?utf-8?B?Sk5kSHRsQ0FZZTgzYlBVRkp5SFgwdmZld3V5ZVc3YU1jWTNCWDFxd0FOalpk?=
 =?utf-8?B?Q21FYndjR1ZVVm9TUE9TRkxNNGxZR3kxR2NEMHZpZVljWktMbkVsamhNRkFG?=
 =?utf-8?B?WWFMQ1ZBa3BaQy92OFJmam5TZlZHbzRwTVM3TVpzY3Y0Y1BiN2RwV0FacUNk?=
 =?utf-8?B?SXVaNnRWWURsd3M0U2Q1TlkxRUxhekxGN1lLa1dVZ25VdTRNRVJuTzBNWU9o?=
 =?utf-8?B?dEYxWFhpZ0JYZFVJcUltS2xHM2RhalpiSk91dHlQWkhSbXU2c0ZDTnphaktu?=
 =?utf-8?B?T0wyS012SFhFV2wreXBXMHRlaXJRYmVRaDRhSjBJZW1CbXNBOFZpVGFHeWJT?=
 =?utf-8?B?M3NiZUVFZlhQTk82NVpVZHlMWnlta2NpU0cxeWFrdnNpdFlVeDJzdFpvZ1VE?=
 =?utf-8?B?WGJ3REtGVEg5TjA3SjRmdWplODN0NlhyYmMrSWtha0UrTGc1aG1meHpGYmc1?=
 =?utf-8?B?NVhzQk1KMTgrV3NZQXh4b202U1FlQnJ4bFUxdU5jWHl1anprdVpQNlM1b0F1?=
 =?utf-8?B?cy9ZanRqME9qcUgwMy9xaldLbEhxWUJGdU0xSzVaTm1KV0RFYmU1TURVVzhJ?=
 =?utf-8?B?L1ZxV2VGK082MTh3NmJjVkhXYTB3T3FPR2RKdmtlSnlTMngraHJtbXkvVy9n?=
 =?utf-8?B?UnNCZmFYZHgxTFl1b1lEVjZUN3hVUkJhZFY2b3EyT3prZUlzdW1PZGxTMjM4?=
 =?utf-8?B?eWlmTkltZ2ZJMTR6eWhSNlFsTXFpY0ZtY05NSGRmWWRUNE40clZ3WnBDWkRs?=
 =?utf-8?B?aXp5c3JJb3IwK2xtbzFQMUxyLzBLYzlLNUdlc3RKcnFXWFhnQVVhZXhOK0Va?=
 =?utf-8?B?MlZWeFJuMnpnWGtBYlluNzVhN1BCOFJ6cW9LYlBTQmR1eCt4WHJKSHVyVXQy?=
 =?utf-8?B?K1J4Vnh4OUs1c1NLTzhsYmRWRDc0K1czWVVqMklZRzd5dk42T1JwVzQ5NFNo?=
 =?utf-8?B?ZVBFTEh1RVVORnd0bzEyT0QxZEZpUWJXUWRpYW1KTm9LYXFJcnpDYjR0WllS?=
 =?utf-8?B?UGpKVVFoZnoxdlJBRVkvWGRFbjdmZFVCK3Nqb0s4azlPeFZ0WmdHR0JzRDZF?=
 =?utf-8?B?SEpDV3BuZG9uRVhxd3pVaHdUS2ZXZUtHdHV4cGowMWVxc09OUUJGMVk4SWpY?=
 =?utf-8?B?eEpTaXRZTmkwQ1Y4Z2VmYXpmQ3QrWHFTK29vOGl6WmoxbjV1cUZySS9zb0ln?=
 =?utf-8?B?VmFHTDhnZUpOMWorUHBxeGFIcWR2aTlIdnMwNkVzZHRXK3FCYjN5cjZXamoy?=
 =?utf-8?B?WmYwdndzODI5SHhldmR4c0xzS3NYcWdjc0k4OTVrendEQWlIc09kSVR1Wmhy?=
 =?utf-8?B?ek1aVTY4bDR6YkFtaWtqUlNFQXFvQUF4UU9mOHdRdHhQREd0akJBSW1UajYw?=
 =?utf-8?B?MlpIa0cySUJVV2xveFExeUFwYU5JZ2Q1WnhTVTcvYWR1dTNEM2xzZ3orU21K?=
 =?utf-8?B?MEVwUlNyWGVKZUcvN1p4YU5CZnFNb0gyY1k0cSt5MUxER2h5RUZwdlpnQi9C?=
 =?utf-8?B?dnAvdWxPQUs5c2IycjNmaE16MklWbXdPZ3l3SklrcFRkQ0t4WGRPNUg4akdq?=
 =?utf-8?B?enZSUmNKM3ZtZ0gwcEVBL1N4N0lxQytqV3VKSWpVYXRkTUg3VmZ1T0xDQ1NZ?=
 =?utf-8?B?aW94RjExdCtDQ3YxaXNHR1h4M0ZxU0FUUDhhaXJ5Z2dzSGtkOERqbG4rY1RR?=
 =?utf-8?B?dE1wSE4vU0dCVHlxOWJTTmdGdmVUang2WllpR21Yank4a0Fia2cwdjMzOERW?=
 =?utf-8?B?Wk1KRC8yWWdoYW5Gd04zd2d1Tm1DbVFLRnJodlRLV3orbUJBbTBYT2g4SDRa?=
 =?utf-8?B?VFBvUmd4UzFlNmcwQ2RxRWJ3cXFFU25zRkIzYjk3V1RDMmt1WW9uMVBMdWdQ?=
 =?utf-8?B?NTRxb2lqOUFQNEVwU3hqMVJOTUJ4U2VDWjVQR3pTNHB2dUdLV1c4Z1RZdUli?=
 =?utf-8?B?T3Y3U0x4aHpxYnJvNUF3TnB0d3BZRDc1eWlQaWlSRHdNRWtxeUVBYjB0Tjg3?=
 =?utf-8?B?M3B0MFYvOEdaUDNSUmxXS0FTMXRDYThKbllXSk5FRW5yamE2aDVPT2crdW9U?=
 =?utf-8?B?Vkx3Uy9zTlhlSzNVVFZiTG9VN0tGMXVQT2lvK3pZaWx6ZlVUU29MeWM2ZVl0?=
 =?utf-8?Q?0F+03sBAHDQUocIlDKKXdfg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VGJpMHhZUFgwbmRTL1NXK2lpWjF2am1nWEhwaGdQZjcvNHlwb0JqK1FqUjFv?=
 =?utf-8?B?dTZ1K3p4K251NC9iRzd2VjdOM1lad3lTK3F1VFM2VUdud1Vub0ZtalUzZjBK?=
 =?utf-8?B?a2UxL25oSGR1clZKTUprN2J3ZWorNVRwZE5DMlpQWTVVN0hWV0FEMGhLRnJu?=
 =?utf-8?B?dGdMdFJabG45b3QxYnR0ejVGTFBjNEhGQmNqa0QxTWgwYXpqRmYwZHJZbDdN?=
 =?utf-8?B?L2tPU214N0JaRzBaSkxlMXphWTFzVzlkQUpTa1N6MHpreWNWc0p5Tmd4Tmlz?=
 =?utf-8?B?bTFVSDE1VzNWdnRsbTJUcEFsZExoM1V2Sjh0WVhUZEJ6RUE4aGtBQlNRV3hY?=
 =?utf-8?B?aUFDUk5ucVVGNkVwOU5nYVdVNmpMQlZJSC9sbHh2d1lTS2Y4U1ZJdENWTXJR?=
 =?utf-8?B?eDJIbk1pOVNxbDFOdyt5MGRBQ2NNWm9Wbm5yR2pYRmp1TzlZcTBQM0kySTNC?=
 =?utf-8?B?RWRwSW9tMDZtL2J6SElaWUlGZlJNem1BK013UHVld1dDTEZja0hUTEMwb3Nl?=
 =?utf-8?B?TXJGR3BPMTA0K05CR3RDb2hRWGhaU3YwVkwvdTFLR3M5UVkvSUpkZjZiSFVI?=
 =?utf-8?B?NkVyekJyL1FudnVOWnVBUFFKcDduVkdLbXhmcjZQd3hZZHBJNmV2YTJJenlt?=
 =?utf-8?B?U2ZMWGRVLzkwNTMrdTFWZDhyRGJwdUpIUU4wdFJ4M3duOFZFYlB6cmhXckpJ?=
 =?utf-8?B?U0JSQTlHbGNBL1ArNVFCNkZ0QW1JdkZFUkR5dThQOTlEekVXQVI3NDFIRVVt?=
 =?utf-8?B?V2lvcjRLaDBOSUEvUHlGdVFRc09HYkdjb0VmQThvY3JHWXh3MzJhYVFxRlYz?=
 =?utf-8?B?cXJkK3pVVW1taUh2YldiRzFuc2lHMEZtZHhOUTlVRERCU0N2Vk9NYVV2aFYr?=
 =?utf-8?B?SDZqZEd4ZTM4MFpXakl5QnZna2I0aUxaVFZQYVhyaU1ybUplenhUYlNzVkhh?=
 =?utf-8?B?aHJwTE5xWTNKYk9vd3A1ekkzcmVIY3hlKzFncnNhZzNXb2pKYXJsQ1o0WG50?=
 =?utf-8?B?UzBJR09SbTltWGVYOXNBRzdMNkpRZGlVOGFtM2l3S3lqQis5eFB1YWlqczJO?=
 =?utf-8?B?K2x0SWw2aWxQTjBBNGhlZzhjYlgvcitaTTJvWC95NzQvMkRHcUFncnVBTk1i?=
 =?utf-8?B?UGtVd05jUUx0WVlQZTFmRW9rRnZwQWJTdUJZUkRpMTRKOGNmN3E0U2dHTFVB?=
 =?utf-8?B?ejlzczBWbmsvMlJTdGhORmpaR0p2czZoNW1ISkFqTTVPdTlKUDRBZDQwVm9Q?=
 =?utf-8?Q?G8d0ql67hYJXm8I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bf9fcf-5db9-4721-268f-08dac47d7514
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 07:13:54.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny9K/ib/etQWtYs8aAsg9uS47mhgsGtp438FQf9tGpLDpMZ8CJCVCPcx/yl5xvxe8bXLbSfa8pX5ylOyC2Yy1cCtC2SccxiQb/LY+f26x6KcHFtT1SPa3oldU4lh+KJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-12_04,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211120053
X-Proofpoint-ORIG-GUID: jTNNXomfmzp7kLO6rkCX_IRjCVYEkah6
X-Proofpoint-GUID: jTNNXomfmzp7kLO6rkCX_IRjCVYEkah6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 11/11/22 10:53 pm, Douglas Gilbert wrote:
> On 2022-11-11 05:05, Harshit Mogalapalli wrote:
>> As 'lbdof_blen' is coming from user, if the size in kzalloc()
>> is >= MAX_ORDER then we hit a warning.
>>
>> Call trace:
>>
>> sg_ioctl
>>   sg_ioctl_common
>>     scsi_ioctl
>>      sg_scsi_ioctl
>>       blk_execute_rq
>>        blk_mq_sched_insert_request
>>         blk_mq_run_hw_queue
>>          __blk_mq_delay_run_hw_queue
>>           __blk_mq_run_hw_queue
>>            blk_mq_sched_dispatch_requests
>>             __blk_mq_sched_dispatch_requests
>>              blk_mq_dispatch_rq_list
>>               scsi_queue_rq
>>                scsi_dispatch_cmd
>>                 scsi_debug_queuecommand
>>                  schedule_resp
>>                   resp_write_scat
>>
>> If you try to allocate a memory larger than(>=) MAX_ORDER, then kmalloc()
>> will definitely fail.  It creates a stack trace and messes up dmesg.
>> The user controls the size here so if they specify a too large size it
>> will fail.
>>
>> Add __GFP_NOWARN in order to avoid too large allocation warning.
>> This is detected by static analysis using smatch.
>>
>> Fixes: 481b5e5c7949 ("scsi: scsi_debug: add resp_write_scat function")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Acked-by: Douglas Gilbert <dgilbert@interlog.com>
> 

Thank you very much for checking the patch.

We have two more similar cases in the scsi_debug.c file in resp_verify() 
and resp_report_zones() functions. These are also detected using static 
analysis with smatch.

I have sent out patches for those.

Thanks,
Harshit

> Thanks.
> 
>> ---
>>   drivers/scsi/scsi_debug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>> index 697fc57bc711..273224d29ce9 100644
>> --- a/drivers/scsi/scsi_debug.c
>> +++ b/drivers/scsi/scsi_debug.c
>> @@ -3778,7 +3778,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
>>           mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
>>           return illegal_condition_result;
>>       }
>> -    lrdp = kzalloc(lbdof_blen, GFP_ATOMIC);
>> +    lrdp = kzalloc(lbdof_blen, GFP_ATOMIC | __GFP_NOWARN);
>>       if (lrdp == NULL)
>>           return SCSI_MLQUEUE_HOST_BUSY;
>>       if (sdebug_verbose)
> 
