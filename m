Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8173763A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFTUmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjFTUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:42:18 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57710FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:42:16 -0700 (PDT)
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KJ3sq9006440;
        Tue, 20 Jun 2023 15:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=XyHjZV91kuAyL0bRA1YlJoT00jbscj+TNvHAvJQJQIo=;
 b=hCygszg5wGGgmYe4SN10jsw2myhS+mr1d8d8/m8CGTNm76mVJDfyGcDAVKEf9IskODWJ
 z/aOXdVC635BNPIWBsBAXWTBNn40vfiViUXsGOQEU/Ss3umbJoq45+0P42ADez5QFsTV
 KnRf5g+jvWlbDhEXhHYI8vaV7kx6S2H+tcJT0764u8L1sHyvedhwG4ewlFKDpVVUeh4y
 jHXi4IUclZMW28IeFMlNsBPkRRq/AwEjbXojwA9LbEkIrNnERlOHwhjp/k2mJF54mLUD
 Wi62C39Bohkqc1AYPDPlhXrKl3NH7XaG74JMun6zPdrPT+jHrcpxolRu8gqIteav9iJ5 iw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r99sy4xcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 15:42:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQDAqsgC2zi+dWBdBxMTTFEKuiFawQra0rad0O2enKu+Jr+M31gbxw3p//mDczropE+UAzkVxpovF0ziZwXvSraKO2rMT5ij8iQ0U3H8neTSslnKsCczQgqX33PruhABq7jjeb/lI1bc8f4HtHflSc1Qt+4O2/9UhUpmSNUFpBcna2C12w0px5WrxubnCqLzrHnuVtXNEDhjOaFO7P+iDRt7A3FkOfHphceeJoD6job2zCs9Tr6XM/u013GQnC7cykzewZ1wQnosv5vLEdDb14i05ypd7SxESPgWpuE9WDOziscqyLqXh9MkTtxQ9xuSAFCWdjVavE/bUvAiLR55+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyHjZV91kuAyL0bRA1YlJoT00jbscj+TNvHAvJQJQIo=;
 b=BHMc6/RKB9Dsov8L72YCl7GYy9561Zd4NuEe6Cg/gjgk2OBxkZurmpePBcpGQWPSVk7vyom7Ryh/lV5rffXzOv21li63ktIlAkLUv0umRaPDsBQLs++e6Xgi8JjB5AxlS8ebzL1UhD06MAvvTucQZGZFxiut5+z51BE2L7eyKp9/u1BBl77p1nDDJQJa2tMe5P3WkoIABjF1h3h61n+dsFOnvidDaN+GDXoGY/UnQXsAk0MVoxVAU7nFMnvBt/hmd1aOyLFFKGxWRw0LI2qLqbhetVXUYt/k0/Y1PfsdObZR29U2BlGY4hOKkXjCDqEntABXp4fhEVaK14XR3alHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyHjZV91kuAyL0bRA1YlJoT00jbscj+TNvHAvJQJQIo=;
 b=UAi5OmiSNlNRZ0crdHV9V/y/JxaHBOHpMxoUeUhZQyr2K6t0bdDqqjV5yxn7/eFI8LmR0xavhTBREKiGbh9TWcGACOB53MOezcX+dTxmD2VuW9jMZYmhV9HacW79x6SgVGUBP5ZywsouYoKBvn5Pb4SxE2sRdrxp7WMTYPWycik=
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by BY5PR04MB6437.namprd04.prod.outlook.com (2603:10b6:a03:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:42:09 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:42:09 +0000
Message-ID: <41affdf0-edba-6202-4e76-fd969da6497b@ni.com>
Date:   Tue, 20 Jun 2023 15:42:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
 <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
 <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
 <5aff32cf-74ea-b632-9d4d-a01ca0d31821@enneenne.com>
Content-Language: en-US
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <5aff32cf-74ea-b632-9d4d-a01ca0d31821@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::40) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|BY5PR04MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0736e6-6541-4e80-2369-08db71ced17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KWpX5WkfGKdzBqwbl9Eoc6Grusku/NYLiE26kBcVLLduIUBpeVfBlT9sW2Bf0BQBz9Q7R+c8ddqgdLRuOKRr0TRYbEZbFQaZRlvmz+Cg15VeSWvWwMTX+m3gmDWvnh/shhLrKZRyeykv3G9R1LNZ0RybD2NlkjIeMsFIyUYowl84pLVOdDc9Q5207hvG/enQles/7F0rlPHTZcwdH7VLDry0sa6YgDzidMsdXWyTDjYu27ow0OukifgvtSClUOcq3YvzQtw9yCfxo5dTXhXtQhrqNQPSez2yW7kQxTd70auBzHsXG2x/cI5av5wyyNVf5Y7fu43Sj7ulRj0a6pqhMUIHuantD0vM2tdFqJduZIW4aWJGe8SK87BEjXp/VPhX6kioeoGC0VK9dQ4+psyDHHwYVQhTxPesSBLXGnJHStJDUuTCmaaqGzc4RqUsSyVt8FYGhN0GVfXWZ2xYV+7ZCyjbWf8VCdT9hWWolCpCaA9NItkvgBNgaJMWJc45BdHKJrDz8NKWcrnbRNcatdc2kxYV6qWTdeqbblmGE4+Dubyr9XQBL0Eoao6uK4Ds7c39rJlxtByxuL5okxvLQNRhaazKuebEZ/tQdw7pGeKllvoF7JN/JPZGOebz6ve2RoGdN/WXVZEJoG0mSAWtYAf9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(451199021)(478600001)(2906002)(6486002)(38100700002)(316002)(31696002)(83380400001)(31686004)(5660300002)(41300700001)(6916009)(66946007)(66556008)(44832011)(53546011)(6506007)(6512007)(26005)(86362001)(36756003)(2616005)(8676002)(8936002)(186003)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVZxRnE0M2l5NkhlY0F4MlVXR2ZZSW9paXBydGsrNzdtdElCYXorMFBCQTlZ?=
 =?utf-8?B?TThKNVZCcVd6RTBEQytkNUNXeEdTeVFzRVVzTkdVcHJ4ZG1wZ1UvZmFtaDcw?=
 =?utf-8?B?U3NTVXJPcU80THYwbWJ4MmdmTHY5Ukk4WG1DS2ttSkVpUFo4MjZUMlh6aXFh?=
 =?utf-8?B?YzVVZE1oSVFmZU4vakxST2RpKy84TlM0SmtHWDFxeUFrb3h5akZGbSsxRit4?=
 =?utf-8?B?ZWUycmdISlpaby9BQWZ5VllEOUJOYnJ2OENGR0tMelRSWnVrWE5OdEgwa1pq?=
 =?utf-8?B?RVBsdTVnUU44aEk5aUh1K2NucFdScm5oeXV3YW92NjJpbEVHSjVtcVRyeGtv?=
 =?utf-8?B?QVE4UVR6ak9QWkJDUXdHcllYbjVxTGgrM1lzbXNvY1Jxd0ZOZUx5WU1UZmZl?=
 =?utf-8?B?R0FBa2dPaEpaYUdwZDVEM3RKMVhjblNhMFBTMnI4UEVvSjBicmxuWjJpNFdw?=
 =?utf-8?B?bkJJNFNsdndtYktwNHpUdU9sNFlTZnZsUlhYZ1NlVHB1YVBKZEw4bURuNis3?=
 =?utf-8?B?OWYzWWpwZUVsWkZxM3AxZ2V0YUcyQmNHb3hRV0k4anVmankzb0hGSU1aZ1hL?=
 =?utf-8?B?cGZVbDRQa0lyeGpKQXMwbUl6VlMyclpWVjFnSzVlY1crMjF0dkNTR0pvcUs1?=
 =?utf-8?B?NlJmUHY0UUE2bE5zVGtWc2U2WDFjbFZRRW5GR2ZVUExreE9PckwzZGhCdEpU?=
 =?utf-8?B?WENORCtHVDVSSEVOQ3dTb3JLdWpkekRhcmJ2U3gzMlQyT3c3czFzcXREbTE1?=
 =?utf-8?B?MW4wT3l2UERpOEhmZWxDUFZoNUZYTGh0RHpCUTk2a3BaZE1yYjlneFhPamYw?=
 =?utf-8?B?Z0xMQ25td0VGek1vWDdKcEhBeGo2K3Via3JXVG9oZjBIR2Z1QmZrZTFXeUs1?=
 =?utf-8?B?aDh3Q0xGZ3lrMXFwZGhMdHl0R1pySnBzYStzc012NVVITVdXNjdtbkt6V0Ev?=
 =?utf-8?B?NkRTZy9WSGd3YjJZc285VE1Rck0yNFlXR1lkNElRT2lvRjh1cjZ4ek5pMW0z?=
 =?utf-8?B?MGx5YjhHRnhyNXRRbEFDM2ZBMFBtdysyZVBZQmlGRzVSbVdvdGd1dGV2TDZ5?=
 =?utf-8?B?Rk53US9od3EvQUtNZ3dtZ3E3KzBoenVSeDMvd0lraDRZNWFlOGZzY3JOeG9x?=
 =?utf-8?B?QkhPMDJlR1kxb3JNZjNxaE5HWVUzZTJVTWwwbWlFa2lWMEw4MUIzNlNoQXNR?=
 =?utf-8?B?bzFrMkhjUStMUWJhU2FjUHhRcDU3ZzZMZHhlejBVT2NrQVVrY2lRMkNKejZy?=
 =?utf-8?B?OW4zaFFSbGZiVUJSZTlONDhVakNBSjV1Y1pmVWdLSVk0WXVtL21mWk5qQkM1?=
 =?utf-8?B?dU5ycm5YeEhNZTdTcTRiTmhIbDFhcEM0OG5DQitSYm1POEFHSHVVTzUwTll3?=
 =?utf-8?B?S2FMQlk3aGlPMFoyTWNWZ0JJd1lYNjVlL29HL1Z0L3dXYy9JT0lJb3BhM0o2?=
 =?utf-8?B?Y1hBdDk1OXpzcWJTWXorS1AwdXJKc1g2dmprV2EyaWV0RWFVTmVjcFdYSUtl?=
 =?utf-8?B?QUhWZG1iVUdzR0ozUTdNbGFqbTlsbHB3RWU4SDN3dThrenVKS2gwdExqTW5W?=
 =?utf-8?B?dmdlOVZiaFhMakZCR1VEeG1YMkVhT0I4SWI4enl4U3VremlJem55MU15WEVX?=
 =?utf-8?B?dnp5eUZmcUdYb1NXbnFwOFViNGI3ZnhLYkNiQlZjcjY1ektIOGtCQWVUcFlt?=
 =?utf-8?B?NjJxbmpkSE9nbEs2SnZEdmY0MFJOeDY4WFNqNUR1ZjJuSmpCN0FodHB2R1NF?=
 =?utf-8?B?TGZIVWlZcUkxbVFnbEFOM1VOL2FNbTZFTUZwZTJUR3RVbkxOaUpDMUZ4OThh?=
 =?utf-8?B?MFFEQytYREtWdEhIM3pDQUI2WmJrMXVFSDNhRnVmS0krS25NOWVTVDUrZXVr?=
 =?utf-8?B?d3J5cmpGZXV3NjRCUHdRb0hCOUNXbHAwanczTHFGN05sQmpyazVyNjNrYXVn?=
 =?utf-8?B?ZlVJWTdHN2poQksyeWgyc1RLZzBLdkMxTEd0R2FaTzR6ZEtRNDdJcGxaU0Jq?=
 =?utf-8?B?S0MrZm5iNkM1MStsYXI2ckUrbTlhZXFMVkE5OFdHeHNnOFdCZ1dBS0xvZVB2?=
 =?utf-8?B?a1RGblh0dGxoYmtjcm9zUExnU2FxT2ZBcCttdHR1NW4wQ09DM2dnYVRCa2ZI?=
 =?utf-8?B?QnYvYnBkblZNSzFjSGIxRGpGQndKREZHc2IrSG1uY0dYeFgxQjFtRDBZWkd1?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0736e6-6541-4e80-2369-08db71ced17a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:42:09.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMgbXyoiuPyF8dXzF9Bk9Udltbes8bF/ghmrEXqjs9e8u55aUIz3On7lSYUP+Dxr+Gey5EwpWobvaVhzF09LlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6437
X-Proofpoint-ORIG-GUID: o2x_lICf6E3VfaHxvBvwUXzYNx4aqfxv
X-Proofpoint-GUID: o2x_lICf6E3VfaHxvBvwUXzYNx4aqfxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_15,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 clxscore=1015
 impostorscore=0 mlxlogscore=891 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200187
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 11:07, Rodolfo Giometti wrote:
> On 09/06/23 23:00, Charlie Johnston wrote:
>> On 6/9/23 02:30, Rodolfo Giometti wrote:
>>> On 08/06/23 00:07, Charlie Johnston wrote:
>>>> On 6/7/23 02:33, Rodolfo Giometti wrote:
>>>>> On 05/06/23 22:31, Charlie Johnston wrote:
>>>>>> For consistency with what ptp uses for minors, this
>>>>>> change sets PPS_MAX_SOURCES to MINORMASK + 1.
>>>>>>
>>>>>> The PPS_MAX_SOURCES value is currently set to 16. In
>>>>>> some cases this was not sufficient for a system. For
>>>>>> example, a system with multiple (4+) PCIe cards each
>>>>>> with 4 PTP-capable ethernet interfaces could run out
>>>>>> of the available PPS major:minors if each interface
>>>>>> registers a PPS source.
>>>>>>
>>>>>> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
>>>>>> ---
>>>>>>     include/uapi/linux/pps.h | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>>> index 009ebcd8ced5..85f472330da8 100644
>>>>>> --- a/include/uapi/linux/pps.h
>>>>>> +++ b/include/uapi/linux/pps.h
>>>>>> @@ -26,7 +26,7 @@
>>>>>>     #include <linux/types.h>
>>>>>>       #define PPS_VERSION        "5.3.6"
>>>>>> -#define PPS_MAX_SOURCES        16        /* should be enough... */
>>>>>> +#define PPS_MAX_SOURCES        (MINORMASK + 1)
>>>>>>       /* Implementation note: the logical states ``assert'' and ``clear''
>>>>>>      * are implemented in terms of the chip register, i.e. ``assert''
>>>>>
>>>>> I have just one question: are you sure that it's safe to call idr_alloc(..., 0, (MINORMASK + 1), ...)?
>>>>>
>>>>> Ciao,
>>>>>
>>>>> Rodolfo
>>>>>
>>>>
>>>> Thanks for taking a look!
>>>>
>>>> My understanding is that idr_alloc(..., start, end, ...) can take any end value up to INT_MAX. It also handles any values <= 0 by treating them as equal to INT_MAX + 1 since the end value is non-inclusive. I can't think of any reason using MINORMASK + 1 here would be an issue since it's much less than the maximum value idr_alloc() allows.
>>>>
>>>> A number of drivers (e.g. ptp) just explicitly use a start and end value of 0, but I don't think that change would fit here.
>>>
>>> I see and maybe I should replace the usage of idr_*() with ida_*() as PTP does...
>>>
>>> However the right-thing(TM) to do here should be dropping PPS_MAX_SOURCES at all!
>>>
>>> Let me go deeper in this issue. I'm going to produce a patch set in next days. Have you any chances to test it?
>>>
>>> Ciao,
>>>
>>> Rodolfo
>>>
>> MINORMASK
>> I'll have to check when the system we used for testing is available again (not easy to find a system with 20+ Ethernet ports) but I'd be happy to test a patch!
> 
> Great! Please, let me know.
> 
>> I know an increase to PPS_MAX_SOURCES was tested on that system.
> 
> I see and it seems that it's safer to set PPS_MAX_SOURCES to MINORMASK... so please reproduce your patch with this simple modification, then I'm going to produce a patch to drop the PPS_MAX_SOURCES define since it's not needed anymore.
> 
> After that you should test all these modifications in order to safely add them to Linux.
> 
> Ciao,
> 
> Rodolfo
> 

I've resubmitted the patch with just PPS_MAX_SOURCES = MINORMASK. The system which hits the limit and causes the problem is currently available for testing. 

Is there anything you'd like me to try running? Or just confirm the limit change works?

Thanks,
Charlie
