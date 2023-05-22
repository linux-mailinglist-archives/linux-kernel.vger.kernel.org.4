Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9E70C219
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjEVPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjEVPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:13:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE7110
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:13:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MCweKs030542;
        Mon, 22 May 2023 15:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iArJwn/ATckCj0hFlx8AozIf6mmmqkPWkTtof9WrhcQ=;
 b=EBNUiR85MKo7v54olsvCxRWMnyzippntdmm/QsaxCn1X9rn5BcAkeFYSpGhgPzIwwNpJ
 yHOCU57MeVRWpMvZ7Bx74Xq+wPyzlrkF0u9qc4rdU3lT1LNyzImmVwevnqS78JoVF1wk
 BlApsVhxPtdEepRn4H8Lk1MmfSL+TVx6NhXAPtNAN+vVTkXhY5QptH3NobmrYocIqQCO
 9mSGew7px+WwqmF8T3xjBTYtZ9W1w+e+9h5EfzNbWHJa4UanhQbhCWtm72je4xzTIW7z
 HoyONEb8OC1qopVg2BJ/bJrGgEWIpJE6puxGhUcDq34/LaKP09EHVNw0oErYaR4gx/GF 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cb14j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:12:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MEYkfs012990;
        Mon, 22 May 2023 15:12:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7dk5vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQxMtlTPGj+evkeGlIuNKkMyMx2VrP90MRl9sHse73clytN96k5WJJNVrGEh5lGldGeM1gcWu0hnAAksOwOjDV6P/ABODB2DfRAnmGOX9KEUCdGsvpbDKgQMEeDisq8yaYzx12NjL/Tvj1pjlAZka6Scs9NZpdm/osnqyaGwCnrxh+SCb/eipY/NHA1AzhcnsYNgl03kSC8E3Y5uuVG8b+mrdh1OHcA6lBwSjkFFJLN51yI6jIY+BIgVKfnpcSKbtZtPOO/6j2x65QztAOVcsEKNCKtqhRHq61OUZBBQ4esKW6sZGYkgac0H4VATYoXGrxEMeftQva4yATHOMsMZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iArJwn/ATckCj0hFlx8AozIf6mmmqkPWkTtof9WrhcQ=;
 b=Wy1S40kl4AAsxbOB6xcWp3L0YTSqZRsEd2xdUnII/K1Wd1LJ2lghZ7leJ1/x97izUZWYqL4dPror0e1D/gJGVWRZuEjf5enLGvDVq+XVnicPHcv9fJVGFE2d1twQw1KRWGRHbCXsd5YdTTzNifGieTzUoCipC+XxnSOe+vGCaF75HJsuBfGx8ThXTam8cddZ9ATh219PJQ7TyuhsSqvopHxR/n1CbzDQqqcFG3N2n7R613kQbnB9H2Uvsm7Qj2tZ45egTLaxEjQ8AaWKxuQTFP8uU/yUhq4buvfddbt8RjgcWV4Qwjjzltu26WKOaIpDUCkjpjruGGlpmE4Ho1yZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iArJwn/ATckCj0hFlx8AozIf6mmmqkPWkTtof9WrhcQ=;
 b=UHK3BrsImpUjxjIori9GYGDqp6npNamfWzTwy2BSqcgcLCC4la1F0vrRiVmF3sIR9qs6/zzTNnk9L52+eS/5pzEuqG0kNVaJ8vYshBKEWBP8ApO5wtXqIGRnXzVN+V3b0n4v1vFgxqos6EKNPMP8I0oum8oApD6yCNFc4YEZsCA=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:12:40 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:12:40 +0000
Message-ID: <5ba66714-b4a9-4fd3-1149-4d67b26c370a@oracle.com>
Date:   Mon, 22 May 2023 09:12:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
To:     "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        steven.sistare@oracle.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
 <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
 <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5f43a17c-94a0-4bff-b451-e5014de36ed9@redhat.com>
 <875y8k3o60.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <875y8k3o60.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:5:177::47) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0967e1-b278-433a-62c5-08db5ad6fc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5LFg/+V7wn0AlI8SsYI/u0oaCQfK69bHBmJ8WBkzbaAV+RCUBJ+GLZ63/pLLO3MrJpNaFECyctRVG5LuNCWL6hb6o5++qOl4qDcvRC3MHDF48NP/MT1+5gRpbKNf0r9jv7fSccSMF2MIf5vfROnxTS3OK7Ugq8SOsHgEoju45SbGcNQk4vxUBqoEeOHe/gK2ZX0uQrUfS3Kftwp/mQag+QzPAoP/Osxn6qEFba0JgQ523dRWDQPMNykRKYMPcuGy2Dd+imoe7hMSH+qdS6wtkKAG4RDF6/WIrKdrvuudpG/LwTnGLlMFZs/xrYsiA8tNBDJzF4J9zuFycXBt6uzvjLH8CB+UG6BzeOHBGZStYn0Sim2wZAGA0PY/66Zt5ItHhouPunRAXFir/D0mIIHhdyeP6udgIIShM4YL0L64lZkgcGVP8H300bLglz4I/1Z6AOCdQNqOUiFJpzMqbRUghU/cqBGtq7/2iy+tYUzXOQ8tNWpQ7JeHwdd4hv92owCvuwMmxBPXwj7iapIy+MPWpgbaRkJoxTIL/Cply4tJGroQGpNCTL9AUQUCxlfBtwrgxxGsdaF9oB200//A5vPMErFHOxdfsK2pbgQT8oprbq1C3/lbnKpmLQw/kI+ZHCIQn9WTxmzX+rHBqzbG1C4mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(2906002)(38100700002)(2616005)(53546011)(8676002)(6506007)(26005)(83380400001)(186003)(6512007)(8936002)(36756003)(316002)(86362001)(4326008)(41300700001)(5660300002)(44832011)(6486002)(66946007)(66556008)(66476007)(478600001)(31696002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZLZ3JDczVjeDViNXZuRXJqeDAzMElNa2FtdjFCZktqMXN2MlNMRlpRMWFx?=
 =?utf-8?B?U0ltUDkxVTVCeUJ6NEdqZ3RDSVlOZXlQVm1rRGZncXJiSG5LUUNXKzl1czg5?=
 =?utf-8?B?bHVRcHJJRWdFWFF4S2JKeXgvMU1Ua2hoRTIzb2RYQ2J4eUVoUElxVGdsSnBs?=
 =?utf-8?B?ckZkODB0QUV0amYxZDRlNmxtWjRBZDVkLzVYR05kOS91MGF0bUhnQy9ZTC9l?=
 =?utf-8?B?aXhVWFE1QSsrNWIxV1cyQjlzblpkemxkSXhqYTBkRWQvYU1OeC90MHZESmNt?=
 =?utf-8?B?Q0pLZkRsSjNKallpTVluTUVHYjluUmd2eWZ0S2poLzZic0RNRHpSWFhkNUF3?=
 =?utf-8?B?c0FIT0h6eFV0dmRuejFLa1ZBbFY2KzJWOWdvaFVPQi9rSHJIYnE2UXNNSEpj?=
 =?utf-8?B?UkZqZDZtVFY5ci9HUTRNMkpHYVJtU1Y2K0tzbFJ4T1dMVmZLdkpaS2k1V2gx?=
 =?utf-8?B?ZmsrZE05Ry82emZEczlBb2x3UGs5bHNUNjAzbFdZeGtobllnaUJxbWwzR2tE?=
 =?utf-8?B?dHd4aG1FczFrTk9ZNC84ZFBmdlBHbkw2YWZQT0lpU3pzVUFOK3FIZ2xLZENj?=
 =?utf-8?B?N0dHNUVYQzJUbG9MNmd5RGEyblJONUtBZkdPWUUzVmRiOUViU1pvTy80UEUr?=
 =?utf-8?B?RnVWaDBZVDBXdlZpcGNKMjhVS0dtdnpNeE9kL1l3R3h2V0kwTCtzN0JWN05y?=
 =?utf-8?B?Q3E4cmtockNiUFpQWXhIYWtGWjdRLzJRTHp5Z2twWG1lanVEYVJTUDhhVHB0?=
 =?utf-8?B?K3ZQaXZpWkhtR3FXTVlLNnAzVU5SNCs2RnZCQlFxaW00OVRac2pZaFdvZkhx?=
 =?utf-8?B?R2RDVHJCb1prYnFvVjdrYitTbGtsa2dGdlZUVHNwUnRFZDFEZG1GdHJxVStt?=
 =?utf-8?B?NXIwUnh0Zk5xSE5ibS82V2tHek9iZ3dQeDVTVUhjcWladHlzRHFYb3ZzNHU4?=
 =?utf-8?B?cTdnNGtnVTVUZWR4VTVUS3AxWWtoNXdkd1d4aTJrOWIwdmpNbzE0RlNWV0JI?=
 =?utf-8?B?VzFjanRyZGNtL1dzaGNGQStIRklxNFRRWWFCTzQzWVl6cXR1c3lNL2NEY2oy?=
 =?utf-8?B?bjlGNjJrSFZtSUVkSlc1MGdWME45NVR1RGJUUG13TzFYOS9BU21HcHFxQmp5?=
 =?utf-8?B?MVhyOWV3WnZWK3VqcmdDdDExbFlZeVNaS2I5VEp4QjZvY2Q5R1JzUlBFSEJU?=
 =?utf-8?B?dlNRd0hVLy9qK3RES2dwQTdIbVZGa0d3YlhXTi9EbjNUS1dMYVlzenkyS1dO?=
 =?utf-8?B?THJsMUpMK3VoMjFNdTV4ZThLMnV2bzIvbE54NVFWa1FzWGpHa3VSYXkySkR4?=
 =?utf-8?B?RDF4OG15dkRYc3BiNHdLRzlvbEFDR2o3SXM1WVJZSnJlUEFxZ2RKN25QaW5B?=
 =?utf-8?B?aGxmZFh6ZHpwUW5uMU9xR3VwUU1LSWxYQ2NEczZLck5Oem9IUW5lRzZsbWZy?=
 =?utf-8?B?YkhJeG1jWVUvTkkvMi9tZW5PVjZ6QzhSNk9nQVZUNXQ5eU93RjVhOWZvbHRJ?=
 =?utf-8?B?U2MrYmVsaHh1U2JvVzZlVFZsUUs0UzBUcU9vMUxLUXpGMG96WlZmckxQbzFu?=
 =?utf-8?B?VVk3NGpzallBSVoreFRzNFpSWDAzNU9CWjcyR1kxYVBVcFhzWFBHRnJCZmdv?=
 =?utf-8?B?ckNaY0hHNnlHTXBpbjlrY3RDYkVmR1BTYjVxa0tUWTNWMjY4Vnp6R2o2UndS?=
 =?utf-8?B?Q2Z0V21NZFUrQ1A3aWNqYXBlc1lXOFdjMU1YSjZ3SUxWNkdya0NOSHcxbENz?=
 =?utf-8?B?YUQwSmI5VDVJOG5nWE92UFRVck5nbXVjQVU5NEtBTWFoY25Rdm45Z0M3eDZm?=
 =?utf-8?B?eEtGYkkxVHYzZmpCMmZGTkJCQys2ZkhrNU1pTDZ1ZERtR1dvc3hhZkNhT0xa?=
 =?utf-8?B?U3pHRjUzeE50Yzg3azVldHExeWNPeGEzRkVpQVgvbS9CRVNXdEZDTit6MzVG?=
 =?utf-8?B?TitXdStsSlY0OG5KbVJtNWlwQkZkU2FWMlYyZndrUGEvTjI5dFlXdFJadk5J?=
 =?utf-8?B?c2s0SzFEV2R1SlpLU2lPZXlvMkhPL2N0QjdoN2NkZHdKQlZDUmZnTVlURkEv?=
 =?utf-8?B?K1k1NEJEQ01PV1NqZS8zVUdNM0JaYm0vQ2lweU41ZEZYT0xRdEIxNTJMTUVw?=
 =?utf-8?Q?mV8pSqDcc/CUziw7BUmk7rxa0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b0FzZWJkSXJyRExyZFBWMzExVVBpVkROU2ZWWStPcWU3MWJnZzkra3g0OXF5?=
 =?utf-8?B?eHVNWElvR1ZQSmpYRXNlaFhDa1dvS3Q0ZGV3QlMxRVVJMGpaQUFYUUhobWRJ?=
 =?utf-8?B?M1hBOXNXb2R2aVZGcFNaZzM5bTJHdXRncUdyK1YydERYMHhDS3IrUUZ1eWdD?=
 =?utf-8?B?QU4yMHRUd2sxd2gvd2drTGlKekVZK3hFOWg2UE1WWjFINmFLUUtSTmNKUFJU?=
 =?utf-8?B?ZkI1UW5Nc0JjdTZZNUF2Mk1Bd0xGRTZMNFNBNHN2RE1zYWR4TXRGQzIvbHQv?=
 =?utf-8?B?VmRiYXRzeis4WHAwdWJzSTNza1NpOUVXRjZRcGtaYXlQUHc2MmoxRDFubkxL?=
 =?utf-8?B?SDROV0hvcmpQUUUxSm5QL2FlSGxvMW5BTVdKbVEvUTA3amNYT2tjaXp6Nzc2?=
 =?utf-8?B?Z1FFUVJnMnB5cEh3aVZMV216QTZhN3hDNjFkNWp0Q1RwZS9PWWFlTGNySE4x?=
 =?utf-8?B?L2NsWjVCNG9EUWNGejdPN012NTFPNzB2WnpidjRnUDNVZ1JtRmNRU1pmZkR5?=
 =?utf-8?B?a1VFUy9KdG9kRTNaNHdWVmdxVkhmcS9IZkNNMDZsbHNLQVBoMzFXd1RmT1hE?=
 =?utf-8?B?SzNwZjY4bFJuUFE1ZWdOQVJKQ0JqRi9CMldzRTJvUXVvWnJPa0h2c2JVaUZj?=
 =?utf-8?B?QmR6Rm9sR1IwamJwaFZhZkNhekE4ck5wS0J5c2pleGhMeUhVLzNnUnNDRFNS?=
 =?utf-8?B?dkpTOVUxaVRBTGJSVVlIMWViR0FpeGVMKzdtcStVN0hMUi82VE9peVhUczho?=
 =?utf-8?B?bFVmQzZrSHVWQVd6N3l3bXJBZFg5dkJ1SFNPNUlsb1BMTWYrUi9KM2FZSVNr?=
 =?utf-8?B?MHFGQ0hURFVrcXpqNW45N0htbkhsc3ZyajNjNEs0b1VzZlBSOEpQQzdnQkZL?=
 =?utf-8?B?M0xtZHE2QUV4RUxFUVEwNDVZQ3UxbGlCZnUzU3lMYTdMbzZESUdFTlVVZmh0?=
 =?utf-8?B?bXZrMWJQTVIwVTFtaVR4NlVoaHFPaVlpWGRmamNkVUlqeUEzTytDL2tXelR5?=
 =?utf-8?B?a24xUlpWd1dZclJDWm5uMUZDMGI4cGt5ZERzZmxURmcrczlVTkZUcHg2VDVV?=
 =?utf-8?B?Mm53WCtKaVpHdW1vSDZwRGRWdFYxc3pCa3hLUFE1NkdzZWlPd2hzb2I2bmVt?=
 =?utf-8?B?dC9PSmNMa0xjVThNZCtuQzVIdUN0MFVyMVRzNmtGWVZhNGR2TFB0KzZGVDZZ?=
 =?utf-8?B?SWhac0JZVStyd3BGN1VCMy8za0xudUsvZGQ4c01ZMlg1VXg1bDYwbHdwSnQ0?=
 =?utf-8?B?QVo2NG9xelJoREhNenJYMFczSmFmcG4rYk1DOWxoSFhMTFhXeFFzTkUzYnBT?=
 =?utf-8?B?Z2plRkNUMDY0MG0rdGRkMnlSYlNHVEdXNnJHTTdXSi82YVdkQ0c4K2tLb0Yy?=
 =?utf-8?B?RDFmQzFtWTRmR1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0967e1-b278-433a-62c5-08db5ad6fc3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:12:40.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbDgoR9Ep3Lm34km0ICNYAEws+fpznymjJSWk2MLoMjoJRABp3N07bA5GRhMMRqs3zUJc7st1H/+qVhWWt3e5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220126
X-Proofpoint-ORIG-GUID: 5p0QwL2p6sW5gX4xyxTiyTBhNrzUTX7r
X-Proofpoint-GUID: 5p0QwL2p6sW5gX4xyxTiyTBhNrzUTX7r
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/23 23:55, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 18.05.23 03:09, Huang, Ying wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 17.05.23 18:15, Khalid Aziz wrote:
>>>>> Pages pinned in memory through extra refcounts can not be migrated.
>>>>> Currently as isolate_migratepages_block() scans pages for
>>>>> compaction, it skips any pinned anonymous pages. All non-migratable
>>>>> pages should be skipped and not just the anonymous pinned pages.
>>>>> This patch adds a check for extra refcounts on a page to determine
>>>>> if the page can be migrated.  This was seen as a real issue on a
>>>>> customer workload where a large number of pages were pinned by vfio
>>>>> on the host and any attempts to allocate hugepages resulted in
>>>>> significant amount of cpu time spent in either direct compaction or
>>>>> in kcompactd scanning vfio pinned pages over and over again that can
>>>>> not be migrated.
>>>>
>>>> How will this change affect alloc_contig_range(), such as used for CMA
>>>> allocations or virtio-mem? alloc_contig_range() ends up calling
>>>> isolate_migratepages_range() -> isolate_migratepages_block().
>>> IIUC, cc->alloc_contig can be used to distinguish contiguous
>>> allocation
>>> and compaction.  And, from the original commit which introduced
>>> anonymous pages skipping (commit 119d6d59dcc0 ("mm, compaction: avoid
>>> isolating pinned pages ")) and this patch, large number of migration
>>> failure during compaction causes real issue too.  So, I suggest to use
>>> cc->alloc_contig here.
>>
>> Agreed. I further wonder if we want to special-case the !alloc_contig
>> case also for MIGRATE_CMA and ZONE_MOVABLE, where we cannot have
>> longterm page pinnings (e.g., vfio pinned pages).
> 
> This makes sense.  The skipping is more accurate in this way.
> 


Something like this?

diff --git a/mm/compaction.c b/mm/compaction.c
index f04c00981172..014e21d3d7e9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1025,7 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
                  * lru_lock and isolating it unnecessarily
                  */
                 mapping = page_mapping(page);
-               if (page_has_extra_refs(page))
+               if (!cc->alloc_contig && page_has_extra_refs(page))
                         goto isolate_fail_put;

                 /*


Thanks,
Khalid
