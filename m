Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A103772714D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFGWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFGWHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:07:48 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871119AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:07:46 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357KuJYB018849;
        Wed, 7 Jun 2023 17:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=GCF7/QGYSl22nMaQc8FilgCiPrFU1/kkJjnMaLu5Sg0=;
 b=Qmdr75Po/BKrSjco74n4pwf88vvfFQNeJVv7GBusQkFt59aASfN60NmPMh4ai0fFjSzp
 Zh57PdmRI6mUUIUFZ/SC701BSOtW0KLC22vOBWVL7uDYwrtT6POUKFxV2RLXmfeWCshc
 NSa6R7itSvuo2a0PogjgYVDN46lCHElod48G03/W1saCziJWYzicNr91Fhasj3ykC4DN
 21CsP+pApzQRWFdJPg6AbTcmts03Un1Fo42K2s3O3JZyR8NQ5PGJyvvsfg01a5lxBMVt
 COJ81ND/xABQd3/+dDcAy0q6v6Qkke0srhSOIKoyFEiIj+dOxi2ei0eiS2CxA8p62HCO pw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r2adfjenv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 17:07:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONG0gleoFaS22gtf1yMGwm9SyHMNN0Exgcd1aj2nGHpsX/VcKT3N0V7w1CBPobF9qx7OnBpQ0Mawz5igbrkZMzff8DrATPmQct3hKhDEWY7fDWcP4SBdN1v9qAOTku4urI6K8alX1lkU8dpPnlk6agG2y2KnYvnbseHspaRkFlYz7k+bam492MGWfEWxvnFVtiq5VMd/rrIhMfg632ooRXyZFBRE1z99X07Mle4DRfZRouApWOE0C19JmCQAjHHE/5psZ6lhpscXedPp2ejnpKi3FO4dGniNyt61fCe6S0zOsfx0NmU5KtGkwCfanfZZFfoTn9j/GLafD5J6WpTjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCF7/QGYSl22nMaQc8FilgCiPrFU1/kkJjnMaLu5Sg0=;
 b=bLPEQVgisgUXzCwKK9P2/UuXBIm//owbAacGPFgPNlu/QjCpVAAGNCFvbTMZEP0Qb0kNOptk+Sp5nt6DUpTcUJVVdEF0qmwt0PpybiACnjBELFLXzJSHTn8mi00U1l8o9gmGTB7+AQOoevGEO5VPzgKmRmrC4JM7JdO4avHv0NUridvAm5luY1/6ipfjNxz5EwoCkJSSiDk16rdWr4NLq42dXURG9BjyQ9ibSITKtq/l8qrgBAJWpvzLxqeThzwJETg/wAW0plNLuRkJOpBQo/h0+/ab808E1hykzZ4bQvYcd+iTlI61bPhG874JvrecgDqVF8bQeo0uclrJwzUJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCF7/QGYSl22nMaQc8FilgCiPrFU1/kkJjnMaLu5Sg0=;
 b=jjNNxhUx7vw5vEngG9GyDri1E9/Jx9R0wF7c46k+uoLCYjjQ5j0dSOK8exES/ktgV+G/8+OJmrhf7kB+ukQvjMzuSrijdSUg+GISmtsPFvFKQfe5uflY9FjcvU2QdokvbZCmk3rw3itJ3mM7lE/kk2qfCWhv67whrSEaxz/54kw=
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by MN2PR04MB6928.namprd04.prod.outlook.com (2603:10b6:208:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:07:41 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 22:07:41 +0000
Message-ID: <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
Date:   Wed, 7 Jun 2023 17:07:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Content-Language: en-US
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|MN2PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: b5148391-a9f0-4a1a-4894-08db67a39c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT8mBljVK6XXPBNkYr95Tbt1bdDzZxRhHAPSde/FWFrDruf8GOO8BLuiLTXdzu2ww2V20c4wX5+jj4eGGnqrH1PfSu/yk8bACydT9ixpTihd58R2rdsyd5dZgxsl2XBhUWfMspqFt7CPGWJrVp4V2/B+GR75FhGqTh7pcNcRxwguK718qTh4Ys02Egq+GStnRUHzr4ial0MiqAcI5/NaLDMx1uhdSEAwEX+DUkX4fw0pkgsUq7Z5OhzTSSBcR29poSIfvX/7+tZbluNP7YUb4VKZCHNnwbvuWf5+0Xq3MPdRtRXjtg1fX98whzzD8EXutrbQXySosO401CiSGGRFwbVPlDB6QUeDycJKc/XZax7t72aVBF04pgZVEBqGZut/cRLKgA5DvruGE1AXpraBjWKJDmoluTGeanXRyEs9CB059TkT9c3zEQMI40lP3dOQ8XsJXq3jgqZ+6OawcSX8cICnhyw324KrX8qnovTdur3rSH/MjgEIlOvJwQaovL/s9IwQZ4jlA8Lv51ss6eHGx1lMF1dpIrtBPgITbvgiQF7dSb/V7hXJ7lAoGeFmm/wkJKWvCXWveu4AHUqk3f6Jtbb6SXLddwtZ6LFfRqCjFBiN2em6uLGqjbNjp32FL+tMYnMEGHnlvtcnyqto7U/i+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(6486002)(36756003)(66556008)(66476007)(66946007)(4326008)(2906002)(44832011)(5660300002)(86362001)(38100700002)(41300700001)(8676002)(31696002)(6916009)(316002)(8936002)(478600001)(83380400001)(186003)(2616005)(31686004)(6512007)(6506007)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BRUmtIckk3WDlyZituSzZxb1dwMzdYYWdkMVl4QXJlOFh2ZVloWjRJLzVz?=
 =?utf-8?B?RTFnRTBONG5mMmp3d2kyVTgydHNNcS9ZeER5MXdrNmNHcHNFU2k3ZE9qeWF3?=
 =?utf-8?B?SUNPbXNvYkE4S2Z2RGdydVlvNS95UE9RWkdIN2lLOW56VlAwWXRoRE10OGIx?=
 =?utf-8?B?V09qSm1BVkRpWE81SEFVMFcwd0w2VGY0dlF2VFBpaEhPeVZtTHBJMkx0TkF3?=
 =?utf-8?B?N25XL0c2T0Y1c3o1N01palJaRDVMMVFyUFlHUnpRTHFkblE2dGJpQ1JOVk1y?=
 =?utf-8?B?aWhlT1A3c2hHVWZZUUl6S0MvcDdIcVJ6aWVrWk1hTVc2MU9ZZ0ZiNnYxMWNK?=
 =?utf-8?B?SEVJaFpjUEVvL0w1U3NpRE1CdUZCcW0wQnlYaFdoeHdZRU56OUJCcjhrK1JM?=
 =?utf-8?B?elNiNmNzUWhzU2VzMVEyOEpEaUFRaTZvTzVnWGRCUjhxYkZSeXZRb0JjMXV0?=
 =?utf-8?B?TktwRjdMTXJVdERhRFNUSGkyVlNRZGx1SHBPakJ4bmxEYlU3ZTg2WWxCYk1z?=
 =?utf-8?B?YktNUHU4cDlpUGZ2ZDdBWkNmZnZmb1hVTFVHNURtRjBOcWFNaVNYM1h2c0Rx?=
 =?utf-8?B?TUEwY0ZiRFVpSFVaSHZZK1VsMUNBb3pVZmMrS01oZk9MUnlkUVhMaHBrMUd1?=
 =?utf-8?B?RzNnNjU4S2prMTlOT0xvVzJLamY5Y3gzQ1VmU2txYXFLMkFod1JmUUNBZVRS?=
 =?utf-8?B?aDdhS2lmSGNhVm5XZFBDWEF1cWV6aWJmK2x5Qm5LdFltYjFUTTdvTm1hdXBU?=
 =?utf-8?B?YVFXOUdTT0hHV3k4dktmK1ZpOGhLQ3FUcW13VFF2U05INzlGZEdFamsySE5U?=
 =?utf-8?B?RUJlU0lYbXRodnNMZDNoblFZeGNIQTFSY0pvYmxMZGhPY3o2WjVnNjdCS2FV?=
 =?utf-8?B?eCtJV1EwN3lHMGZ5N2ViRWR2QXhBaUFodnlnZUVUNmkramFCaW9Wd1V4UWRj?=
 =?utf-8?B?ZmhBODdrVHkvd3YxMndmV2VzWHdmTWp5RGNyUDQ4QmZNSWRmVTFqQ3BkT0Z0?=
 =?utf-8?B?U3Z6Ni9qemdiNndxVTBxZXFtT1ZVOGNVajNyS29SbDVUbmpEY1YyZ0dJS1ZW?=
 =?utf-8?B?WGFoSFNraU1sTTVhTUFyYkFMeWlVanVQMVp1OXczTjJ4WWdRbWVlSEJLMitV?=
 =?utf-8?B?T0xSV2NXSit6ak5rSkF6YmxNSlVKeGYrOERqQkFpWklZZUpHRmtvQ1IyeWN2?=
 =?utf-8?B?S1hVWEhFRkZpSGxGTkZuS2NrT1pqckFneUtZTUpNYmZScjdYR2ZSR2tuaE9z?=
 =?utf-8?B?dW5HeWEwaGF5MkoyTDVQV3pyZEQreks5bnBFWEZtcTliTXN4N0YrY0JCVmFs?=
 =?utf-8?B?WktUZzJZUk9qTkpoMHhxWGJqRThPVWhMcjBXR1NNcHF6K1NMbllHYTBkc1BM?=
 =?utf-8?B?VGh5bGZBK1NqMzB3ZzVuUW5GTklZMGM5YStaR1Juc2wveDIyVDhsVzc0RW1q?=
 =?utf-8?B?QXQ0eUwxa01rbkJDOGEveGtoMllmTzZKWi94QXlIeWJndVUxU0FxeGxJbzNx?=
 =?utf-8?B?QUlwb1lia09YalJhdGYwd1hMWG1zYXZBYVlnY0s0NTkwR1ptYVpZclZSNTVF?=
 =?utf-8?B?cGlPWEFLZkM3ajBCSEo4L09wbThZYUNzUlN1d2tacGhQdVVieDZFa20zeE9v?=
 =?utf-8?B?OElKd0V0RWN6T29DejZuM1Y3bjFyaDErbFlrVURSWDVVNUxTeUdsOVBxSTNo?=
 =?utf-8?B?M3lNeUtCeDlMbmEweXJ2MGJacDlPZmdtQTN2cXJ3aHdNbENZREZsQUNzMThT?=
 =?utf-8?B?d3FsbHU4QnN6bWtOU3FjSWpWOTV4K1dZT1FZWjBDZWNtaVZ5UURLRGd6ajF1?=
 =?utf-8?B?MjVWU1FoOXhPelorQmRvd3dhRzZ4VE8vK1ByQ3JTSVVyV0RDV1JRdUkyM1dt?=
 =?utf-8?B?SXdZaXlkUlBXTG1tRW44TC9MN3I5VSs3bVZ4VUlJbjIyWHZId3ppSXc5b0VS?=
 =?utf-8?B?dzJmd1VvZXNoSjJkcWp5enV2N2ZIcTFYcGQrSmRUMHA0QzU3VGN4RCtCWTlw?=
 =?utf-8?B?VitmRjFwMy9NQnpLWDdFU3pnOUVmdHJTckhLcE1oeU9pb2JHOHRtWmNnSUFl?=
 =?utf-8?B?TVhkS3JBQXJ2UllLOEllMHVuTkR5WHpXdjZSTVZBd3RpYTJNNDc5cldNR2JM?=
 =?utf-8?B?MVJtR09IRzBaUndoSCtBVXNJTnExemxCTkpJalNZazI4WHppaDEwZCtOZUJ0?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5148391-a9f0-4a1a-4894-08db67a39c97
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:07:40.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz6z+awCawEII8U0bDHxeuBBOURI52A6mGBOKZOSJfg56FCMapl+0+3OdRWX7mNDtB+ulJAhaY3UNXkFjKnRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6928
X-Proofpoint-GUID: NPF67gRx2tnFXjNa2L7K7O4qiP9sfyCq
X-Proofpoint-ORIG-GUID: NPF67gRx2tnFXjNa2L7K7O4qiP9sfyCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=921
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070193
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 02:33, Rodolfo Giometti wrote:
> On 05/06/23 22:31, Charlie Johnston wrote:
>> For consistency with what ptp uses for minors, this
>> change sets PPS_MAX_SOURCES to MINORMASK + 1.
>>
>> The PPS_MAX_SOURCES value is currently set to 16. In
>> some cases this was not sufficient for a system. For
>> example, a system with multiple (4+) PCIe cards each
>> with 4 PTP-capable ethernet interfaces could run out
>> of the available PPS major:minors if each interface
>> registers a PPS source.
>>
>> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
>> ---
>>   include/uapi/linux/pps.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>> index 009ebcd8ced5..85f472330da8 100644
>> --- a/include/uapi/linux/pps.h
>> +++ b/include/uapi/linux/pps.h
>> @@ -26,7 +26,7 @@
>>   #include <linux/types.h>
>>     #define PPS_VERSION        "5.3.6"
>> -#define PPS_MAX_SOURCES        16        /* should be enough... */
>> +#define PPS_MAX_SOURCES        (MINORMASK + 1)
>>     /* Implementation note: the logical states ``assert'' and ``clear''
>>    * are implemented in terms of the chip register, i.e. ``assert''
> 
> I have just one question: are you sure that it's safe to call idr_alloc(..., 0, (MINORMASK + 1), ...)?
> 
> Ciao,
> 
> Rodolfo
> 

Thanks for taking a look!

My understanding is that idr_alloc(..., start, end, ...) can take any end value up to INT_MAX. It also handles any values <= 0 by treating them as equal to INT_MAX + 1 since the end value is non-inclusive. I can't think of any reason using MINORMASK + 1 here would be an issue since it's much less than the maximum value idr_alloc() allows.

A number of drivers (e.g. ptp) just explicitly use a start and end value of 0, but I don't think that change would fit here.

Regards,
Charlie
