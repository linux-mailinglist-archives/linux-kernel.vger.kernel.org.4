Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4016D6C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjDDSge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjDDSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:36:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295A59C5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:34:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Du5SR028469;
        Tue, 4 Apr 2023 18:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=f/KPkq9r1TmrQbIqfdfF2Q+0uwBh1IEf7id5rMfFjt0=;
 b=EhEPamJgap7W001ItLpKKgDpFP59XEJIpErzyU6YJrBUNs3dkOE2/VI4CBUESGxT9oko
 CVScWF7+SBOGwZxAzgGTMK5E2apX5iY1I1iAoQVCUu5jV9MpOj7WcLv4frA2yrCDjzZl
 ii3fyICyiQlSsWCCu6HGRCDDwaB6xBQyVHrgy/A6Xcv5cRWMtQQov3VdyTtjD3XiNqyU
 dCMh4fxeOwMi9Sd+VlyI270YO0nWSVK1xVSfy+2rz30thJb/jL6xYJAr8nXq07fRpQEI
 L21J0H1BmHFOa05GEBJLYJ2SgRCkF4ByrGIU98ENgBj0YzJnKu0okP7yLeWDRlnk7t1D Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5uek9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:33:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334HZGXN039573;
        Tue, 4 Apr 2023 18:33:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt26sttj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS3giTj+pmf99zN44owvVw6IP1lgsi6OA8ItFXdqTDR7Gm8KGMmrPmKfkWXk/Ah9jKSs/kjrPxVCKkAJHJXpu4WpJcumQif0DYwV+IQzxUtYiKsUpb3KC4XC7CFDzDLoJJwH3CPqLLXQG9pPQp6yfwPiJT654JXM8vZN0PylMXyzc81gsyjLe8JADfbfsvlEVZyie3QF0zFSA1YszzYYp8t8srPZL37evb2nMfgmT4j2AqDbtTHl7HG7j+tFhNRX3wyH431bVByC0OdHz3G5Rxtm1sOeeIWCXtbrHxEzfCaWwLDNUDn6mJpWb6f0XaevAoJ8vf/nR7NLg4hhL2LVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/KPkq9r1TmrQbIqfdfF2Q+0uwBh1IEf7id5rMfFjt0=;
 b=HQhLZheJW9j6IbrjhjlAeW8rCGhgDi9Codr2GSa/T43w0Yf7+oOekWTNK5h46KiMLGL7WbRZKItzJbJjK9ih/AGLDIxtdEKGRQlyM6SKrlmYZEYNEdNvpjziCCV7cTTieGiyqDFpBFOryp9Xr5thvfknTRwidKe6V/MuL0iKL0VVCAPVkFo4PRjdlLpth23nmnd58Ufxv28o6JzkBDAzmc54i1gZJaVj2+1g35gHjCagbN+gnKhh4ZzJ3hEOpcnTb5NjlRMp+d7NwHLxqKwbxM8gJMCI26cOdt/KWFvrIi2Cl732zlBhVPoJgiPfYr5OXAHywn/i+M3yiy5LXyMarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/KPkq9r1TmrQbIqfdfF2Q+0uwBh1IEf7id5rMfFjt0=;
 b=Y8GV4/J6Z72Jd8F+KL7cxHXrUoe1f33A2ULqHc1Wi38BM4iIA5PLH9/sfpEyadC/7J+X7s/1zqOBMrLS4nMATLtkjABqeV4dKDQTtTkxH8fqa5a0MZaxOpegSZtAZekPbTxlBfNEzX54afeXgIvyxwbgVX86iqWgskvSO4oba5A=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 18:33:47 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:33:47 +0000
Message-ID: <7843ed86-4cce-0621-55ce-1a996f8d3222@oracle.com>
Date:   Tue, 4 Apr 2023 14:33:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20230330150757.547423-1-chris.hyser@oracle.com>
 <ZCxDICwfUojWTGr5@chenyu5-mobl1>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <ZCxDICwfUojWTGr5@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9d668a-c561-46cc-c739-08db353b20c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TY+Uo8O4lCCjVRNHD52WY2hayB4cqwZpUvrXYMuFi6fy4CJhsuGprWIGebNKwGU15CFDmDd4rBZY7Zf5hdgRqNuGFk35OJpSgzYLLj8TF+3hnenAIksuFGWHx5NZMIDSuttqUFIxajHJ2ojs6vG3UZhBDvrk0UKd+Ju76i3yoOCDPMRlIWJ0caCYrnXD+zb2C00mUwDZP4WDVs2bLsrWAd5UakbfOCsGIEg5ndUsDpJQD9hs/kkRgx0xqLmDsqQZTz2z/v20jT2oKNQXS+HMHB7eh8Qfg0gqHczAWfobC1sw4ZozroY5nC/dEJyZvZny0nV9riqxf3ESiluIIQ/eyF7Qlf/yAHjpi1OHa/894VA3SyZ4xXrFiYeNtxpne1G6pUorESrp67JrSMuZMxSbhdBNoBnk0DZIZxGwqDoDrsDG7emKbLjEHHV+5jTiHEvTQKgAGZ1WjJ9dr+1YiJlgF8lZlPygNQkZ+pMI4bF6PV7fnsTfeeZsstuoTlAbkvuKtDXkpsgpmGKV/60L/y024ZMC0R53FkSX6RhIGqWBE1htW4inp4zCfFpwgbaCS64Se1LE5mQ0tMGqqFb8ZP3XxQswsTv8E9naVe9txm7Oy4951qMT365DxybvGkzNLu79MUM8uWryx1waAOpruWEq2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(6916009)(66556008)(36756003)(86362001)(31696002)(2906002)(4326008)(66476007)(2616005)(6666004)(31686004)(6486002)(186003)(53546011)(26005)(66946007)(6506007)(6512007)(83380400001)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlorc3pwN0JZQStHM0FOTE9zb1NyajBYM0NwNVhsdVF1TEttdXFKQlNIZWpC?=
 =?utf-8?B?bVg3OHNwUzVadko5MStXTUkrS1h0ZTJxZG5SMHhyM1RNNDRtLzBGZUx6MmM2?=
 =?utf-8?B?T3E5ajRZbklpelZpbTdNWkpPbE9SM0Y2QmZyck0wQThaMTRmNlhvTlNkWVM4?=
 =?utf-8?B?VTh5SHBXVXpTUnIxaVAvWGdQTDh3TFJONWp5Rk81djREbVpET05JVStYZmVl?=
 =?utf-8?B?cVo3ZmJoZHEwbUoxMzBYS3g4VzFxSlVrSkREYjg5eXpMVmx6dnEwSkFJVVJw?=
 =?utf-8?B?RGdJbW1HYWM2Q2RZY0FVc3RONVovUmVRRkN3S3MyWHFWN3V3MlFVakxmQ1Jq?=
 =?utf-8?B?QkE4R1hwNS9sNlZ1S29EclZKUGRYaWFpMzdiWmNBcUZ1YTN5c0JCckVoL1Ra?=
 =?utf-8?B?anZoa2laVHhoeUVSc3NXUVN6MCtDTitHeFh2T3dDdDFoMjZZK2VCNmRGdEpv?=
 =?utf-8?B?cmdLNUlnRzZ1eHRRR1ZlWXhOOW1sNHB1VVNOMytMa0d1cVNDeUFyeFdvOXNM?=
 =?utf-8?B?cFZVNmxOR2dJZndNNVNFUnhmbVNlVmtzNHVRdlpjdUdES09aTGYyaEovcHBq?=
 =?utf-8?B?cDBLWXR3L1oyenNjb3JWdWN4RUg0eVNReWFkVmJmOWovL1RMRUhmM1FFQkV3?=
 =?utf-8?B?Y3RMNmdiVXNlV0xobFcxWHFkNzRENGl4cUlGOGJ4dlpIQjNOOWpvY3hXSDhY?=
 =?utf-8?B?b29oa3FrSkxlMG5UaE9aV3JwYzhQL3BmbWR1MjdCQWFGUDVvL0Rudm5EYWRo?=
 =?utf-8?B?R2l6ckZiQnpybjk4RVdNTlUzemlSRmc2V2VwdVJLK0pMVHkxeG92b2Z1SmMy?=
 =?utf-8?B?UVBwM0hjdjBRTFNpY2R6UUpiZlZ0cVNjV1REK3FKWHhTQnFzUHRET3RvOGV5?=
 =?utf-8?B?Y3lFK2c1RXY1SE0yYlhHUDIxYlFLUzNLNWhlSU9CRnV4SHcyd0xQN2dGci9I?=
 =?utf-8?B?ZW04elh3TFNrS09RM2Q2OFlyeUROSjlhMGVZY0dXbTFJVTBycldNb0RXMDhY?=
 =?utf-8?B?aCt0M1ZFcFhVbU9PdldVZ20yS1QyUTN2dzQ1dUpCRnBxVVU3ZzB0VEJqeDhM?=
 =?utf-8?B?SVB0SkNFbTA5OERONDJyYWhsVGp2M1RLd0lqUWppaFNDRmw5WTBXbDlWUVNI?=
 =?utf-8?B?d0trYTRzNFZyQVhjTG93L2Y3VjZUcjF4OTJtOFNrdCtRUGNoMWxBSUxIUVpB?=
 =?utf-8?B?REZqN1FjNklMMTlkZFVvbXpnZjd1REtOL1VBRGZSSVdYSjJxNEZaVWtVTEs4?=
 =?utf-8?B?YVV5NlVjZE9aRTV5N29jbGVhdGlMblRNTUg5NEpmbFVxc0dmMzdKSDU2SDdN?=
 =?utf-8?B?MkR6Ri9La3VlUUx5MUJNeVYwTUMzME9SYndkeWNPNU5nUmJHa2E3YytQQldP?=
 =?utf-8?B?WVdXOFpFb0Y4aTNqZWUyTFR1QXNGNVZ4SHZGbW4zL2doNUVwRWJTYzR2a0Z3?=
 =?utf-8?B?ZjhObjJtcndCbHo5bEp6a0hsTVZ3dEJYSC9vWUs4YVNrZGFZN2J6NkdrLzhC?=
 =?utf-8?B?dmNzYjVmc0NtblZJYWNINFN1czJlVjhLVmx1c1kyOVMyMXQzWFdtVHNSZkNR?=
 =?utf-8?B?Smw0TnFhcXdYS1AwQTMvaExRcGRUTmp0eGpGZFF5VXROVStXODdmWDYreFR6?=
 =?utf-8?B?czd0Y2hMb2FwS0hmUmpScWtHaGRpQ08yZ3ZoWkpNbmRmS3pTV1Q4MUtTQ2Z1?=
 =?utf-8?B?WFVJZ0xtMC9SekpnZXJ1WmVrWitWejhpTkNDUFlJQ0hyakFPWTdqTFRLbUJu?=
 =?utf-8?B?TldrRUszYk5qcnRSTVVpcVFTRW42endoRnA2bGxKZWY1dHB0ZVJTa0RsYUNK?=
 =?utf-8?B?NmFUOHhnWlNNRTNVWFpyRjBSaEN0YVhnbGhWMDNFb2pMYmkyanZjQ0xPdXVT?=
 =?utf-8?B?eUNhVEJ4VHlVOUkzSDNZNjhVcmI0WFB5Y1N2eUpvV0RTTzBNdUEwb1JHaWpM?=
 =?utf-8?B?VWFkNEc1NnA5RGg4b0lBYXIvcWJWeFYyZy85OVZsY3RVMlVQR09Vd2VaT0E1?=
 =?utf-8?B?cCtmRGlRNTl4RWc0WGZwdnArc015ZVA5K1hJaEphUHphV0Y0QjFjR21aVUZw?=
 =?utf-8?B?K3UwazRVbFU2QlBpZElma093N3VlTmRnV1J4bkxFcHU0bjgrZGEwMzc1bHla?=
 =?utf-8?B?d0o5TUVzWk9tRzJBNDNUWDFXcklHcHltNk1IVWtYQkRIMk1VejJhZUZwRjZ3?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1dzlvtLynfcy16VJRcquvk73vPEDtCBwwLGSrOBboeKL1IBUlehFKzOOnL628u0QCXDNaOyiY3ZglSZq8dms04GYCZ1/J6ZDp4oE1w4oLcu+Sy4jHFL8y4uwRynUhFj5KJVR++kXCntG0+UNveiBQD35j0W+IX9e5GoXnAIAe9LipXgWEdO96ChISJKBTaVKEojm9KiHyBgSAAw8FmPKwz6zOB+XfHySy/MyUJZKYjw4v3Rekiy0t54+86yNRAbgXCtXEqJZ5qDO8HdX5Gf33e+FX7kFCkxnKQFcmz/SpaKRFe9qSbMX2K9kO26cbv2mhgwXz/rvIXZuh7fGUm/1zTVo9flF5PenqO1ZJBdn5pMXDN1EC2roOdwgYdW5OMqo908PjmhPCH/mX7KG6B2qa4DLQVcg+rFwVvlyl2K1d9QhfJwcPq9Ehz6ma+geZwvWPTEPcGnfd/SzyouPuMnB6cPfJ6viPNsKhMmc8gIblPV89HB7C8eCnVkD7UVlBkhzldp4rmL2SqitQjlifa0QdesYoddgpIRZ6C/H1QdEQOIHHyKPbVkieHSTf5V+f/XElot65bRJWRv02TMvuxZYVo2sSe3LeDXCiyRFDVKT7sh6gdRrj9iJcouayzdiAtBA692yEV6ymwP0V7gL7FkKrI+l442n+3sZR7R7zOs1CZwFsv1zZRP0q9cx1hzA2nnu4xMYnp5wdgqjDtXPoQhNi3EL4xX1N/5zSGVwZ/4JLIcgU68vc3rqh81pYCVWEzpHQhjQqp9VzUkObeHueJzW7YS6EynkiVPTx0zZ0c44BOh+jz8XKjx9C2qfJKxATj/euiHxXq0Vsw2Dm9HUnvPQ/sEmx+fOksEwi5TsD/F+i3TzjHHRn/iWYNRcBZP/VcuL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9d668a-c561-46cc-c739-08db353b20c7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:33:47.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5uEmFhRYkjs1RCkMUEFPJ8jchsLNqEnLlsKd27XfPf4YS3h9O1DDH3SF2EvWXFxXBXDNuxDcZ5RvFGDIuuU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040168
X-Proofpoint-ORIG-GUID: 5YGJzQE84cji9gL2fkwdqfgvbkWzPnrF
X-Proofpoint-GUID: 5YGJzQE84cji9gL2fkwdqfgvbkWzPnrF
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 11:32, Chen Yu wrote:
> On 2023-03-30 at 11:07:57 -0400, chris hyser wrote:
>> Commit 6419265899d9 ("sched/fair: Fix division by zero
>> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
>> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
>> value of zero. When moved from a sysctl to a debugfs file, this checking
>> was lost.
>>
>> This patch puts zero checking back in place.
>>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>> ---
>>   kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 1637b65ba07a..b5fc7e250128 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -278,6 +278,56 @@ static const struct file_operations sched_dynamic_fops = {
>>   
>>   #endif /* CONFIG_PREEMPT_DYNAMIC */
>>   
>> +#ifdef CONFIG_NUMA_BALANCING
>> +
>> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
>> +				     size_t cnt, loff_t *ppos)
>> +{
>> +	int err;
>> +	char buf[16];
>> +	unsigned int scan_size;
>> +
>> +	if (cnt > 15)
>> +		cnt = 15;
>> +
>> +	if (copy_from_user(&buf, ubuf, cnt))
>> +		return -EFAULT;
>> +	buf[cnt] = '\0';
>> +
>> +	err = kstrtouint(buf, 10, &scan_size);
> While testing the code, it is found that there is a
> kstrtouint_from_user() could do the above. Not sure
> if it is worthy to use that?

Yes, putting this in results in cleaner code. Thanks.

I just sent a v3 with this change.

-chrish

> 
> thanks,
> Chenyu

