Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE261016B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiJ0TR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiJ0TRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:17:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA2733CD;
        Thu, 27 Oct 2022 12:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf7TR8s16teNaBtBpKjdYeVXOsCL4+yk47UUyzvp/aCiHDbF9w8OVSb6pnRInOjv4+nfvhZTkVLjSTGTINBczcUfbMemYMdwPtEMrV3hDRVcMHIZ/QirwXLsvya4cEsJ4EWiDCFLBrEVT/WuIp8/Zyet454McAFB3rAj44gnT9N/gZOTR1IeZ4EiWxmrmQBxgDBQ46ctYm4OME9IxdEKXwuiXt2aYH2R4NLEBVtoQybIhiRn001FSQ/B/TptXzTDLD5hvWG8PrhEmbYsv/2ddmI2AGEhhywDQOWNpJs3bglaEZQ1N4/JJZZ/osJEziJoKzH85SF8eZCmUr3JF2J1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24EMnR2nTF+QOV63wnbws2Z/L2iQktmWyirmKZh2eYw=;
 b=LeehNVLvmBYLh229inmqyn1iY+u/8wSCx5xxLusL0B6YTo4QNHYnNp/OKgJkRHQBs1OOdbk7vbgxmM1lLZRUAO8VjJVx5ysKs/+VhAKXXM9hZDMSkrJwOAtZ8huy21+F8LfPAf1SvXderdcp1giScWwIpVp2FPFMJMZ4rap7tGeeB0iwaOE4Jrwh1SHtmUz7XmYqSacAjJW7r8EgGy3jpQgxfDTnRsFzoKr2P+xRBCSpuVd5K0IdBSPu9jFJ+0Q+UgQ+38n/doX4KBAvVvpKpSojK/b9tv5QZXioy493+a+ZI9O3jj9wBwlRhI4UdOl3+fnK1UnnNppw8H8NGSWnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24EMnR2nTF+QOV63wnbws2Z/L2iQktmWyirmKZh2eYw=;
 b=EmI5n0StVZdBcIuv3LadrQTOGeoRO/mqMLV/DLeQ6OKlez3Pjs672jj1+qI+CoIXa7XuVyniAqb9NYrj3LT/7RY3OcPLubmXksduAdkiRFsVmeGG0wgmglXqcmuNMH0AsMrW8nRSfpNFS2nKOH+XIqdeSE8Am2d13ZOGsCpuL14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 19:17:21 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8bb9:f98:468a:c7a]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8bb9:f98:468a:c7a%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:17:21 +0000
Message-ID: <c115afc4-8ed6-6188-af94-18b8a9da00e1@amd.com>
Date:   Thu, 27 Oct 2022 14:17:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604557098.5345.506719195181543985.stgit@bmoger-ubuntu>
 <1f30019f-51ac-0d73-3024-03a7b33544e4@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1f30019f-51ac-0d73-3024-03a7b33544e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:610:b3::35) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 35205ace-469c-4b65-db78-08dab84fdf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GeDw6WEIrAgNtD2sfgNim85S2G1DVZJif4GlFIZNC0jyTz0aMepkLPCebFZazMc65ssqFUxxDH8xnz/TR7cUmGKQheiAcbuHY6vCEXViXIHCvgKkx9X5A3GQhx+sXP60/3229G1m/afUhw+nXl1lNweHnmnzsYAj0FdMgdpInUfCCZ8NgDKb/kJtB4Dg1dDU23FpmQYZEVKf1D7WXGv70b272cIgnIbCj30flzIjP2QK1r/39jk5R5OUwD2TWc7zDj5+t/MbOBoYXfhqYIe2i5XeiGlbOWmiC6gfxj1B/S4zKItKLolTp77OzWwrkZ8qKnEaPomB229UKG0GNXuxTWtuTZHakR3VdyfBR0O8h92eHZN1wNrVHFdRMD1kvKrisv7DXjBwOvDGTQQIR4OJageK/d13a5E3PHYJ2bD4DL4VvN+8B9NUZEdXM86gH8SFfad0sirIakt4HH/roCg86f4AyZ0dwiA78tivZPz865/6UhrX9RRYv3l0sIlL+k+pfmEm9VFccldLrXxF50owMIgXTaOejPpY7LFaK+2jxfKXfrqlUymX+UWyHBaJzNo0g+zgZg7a5oYh7g7LwYDCoHhmnADtQLtlYfhfTqaKwYvN3UlwOs4gU6gznJDSAIbTrCHcPwfd9TDxtAPAnI20UkFvfZksDlnq5PvVWKSSELlWQ5HSWrJExGvntbn11GiojpAYMcRz2fEDHQINLuUHBdlAs7MN9azu8cv3YHkVizgXYhGy/2H+eOMc6c67ReL4gR38ZRDh7JsCpyjt9t9tnXVxD/sZqOLySZyK9NsFx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(6506007)(6666004)(36756003)(53546011)(4326008)(2906002)(66476007)(66556008)(66946007)(316002)(8676002)(83380400001)(2616005)(3450700001)(186003)(86362001)(31696002)(26005)(6512007)(4744005)(5660300002)(41300700001)(8936002)(7416002)(478600001)(6486002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVBL2JKWVNjWktLMXphUzZNdDVoTFYyNTVYa3B2azc3Q0VXTlFwSzRUQitp?=
 =?utf-8?B?a1R3WElLM1RFeHNhdEpqQWdKeldUdnk4LzFnWUJLMEE0WGk2dHBrSjZoeXpG?=
 =?utf-8?B?SmRrTmRWNWV5RklKQzdPT3VUV2U3TFl3d0hVL3JHcmx4Y0hTbGFKOVFVRndC?=
 =?utf-8?B?UDA2d1hmSmFrVTlGUWNtWFpVdUNLa0I1Y0VQU0VHY1NLUW9tVXZBSDdZODdz?=
 =?utf-8?B?K2hjenQwbzNCOVVyS1pUdzlLOStDWk1kZlo2SEFVWlpWVkp1OGc3R0daUzFW?=
 =?utf-8?B?K3lJQmVGQ1pkdm5ZMVJ0RVpDSFhZaVdlY3NwNUpCM0gwbjEwbWFrRnYyd1lH?=
 =?utf-8?B?RUF6R2VTOGprL3BnRkpNSzJnMzBnQXRHRnF6TlgwR0xCMkg2T0hrMTRJckxY?=
 =?utf-8?B?ZjhodHBKVEszSG5sQTVQb1FzY25wenc3cnpuR2o4RmF3MURZaU9Wc3JZZEs2?=
 =?utf-8?B?cmU0a2NNb0h0a2ZWWFd1dFhLcFlZbEN1dEpON1dmZXdObSs0Y0h0NWRjWGxH?=
 =?utf-8?B?NTZ4TzhYMFNuTHYzOHVqcDgwMWJlcnkzanVvN2NRdUFoK2tSNkhSN09RNFdQ?=
 =?utf-8?B?NU50aGtQMUdSZ1RyUTFNU3hCQVo0WjlHNjNEWnFVWXZOVE1QOCtycDZ6aER2?=
 =?utf-8?B?SmJ1bUZIRHVLSDlpQXlsSW9GWWR6MXovSld0L0Nub2hvOFdnK1o2VFRLRUFP?=
 =?utf-8?B?TWpvWFVaek1LTTczb0RoMDBqdTkySnV4ZG81VU51QXlXamV6SVJyYmRtQmE4?=
 =?utf-8?B?VllBQXQ1YTZ1bXhkN3BtTnk1U2hMS2xKRkRUclZzYjExejl3TjVtVjJTZG9G?=
 =?utf-8?B?Tk1OQmMzci9tU3EwN1hSbk5IK3FOZGI2WHBDSE0wS2RLeWV1TnJVQWhIb1JC?=
 =?utf-8?B?STAyMmJKeGU4QkNZb1pnTkZKV2JOUXFuNC9CNlZheE52K1RmdnBvcC9IOHp5?=
 =?utf-8?B?L3FkQ2pYc090bmtIQ0twNkhtdjJPcXlXYkc3ZktXVGdQUjE2WFpPeVE2c2NH?=
 =?utf-8?B?VHhtQTlVbFdOWWVwaFNFb3Evcit1c2R2Rnk2anBMVklTQlAzSFk4Y3V1Nnk0?=
 =?utf-8?B?c0I0RXQ4ak4vMmM3eklEQzBXUjJiNVlCNFZGTlVPeHg4QWhHK2NHQmlvRjRp?=
 =?utf-8?B?UnBsM2R4NEpGU2k5bmNhVVBnNGN4Q2R4V05LbXh0b2FWc2FEMG5GcjNEbXVV?=
 =?utf-8?B?UVRScDYzbG10UUI0d3RJOW5LUWNrTGRielllVVJlZDJNQS95SE9RdXNpdGdn?=
 =?utf-8?B?N0MxYUVrWkRvbnBzWjdMa05uNGpZcmwrMHVMM1ExMU96d2pmeE1QN0phOTc3?=
 =?utf-8?B?RCs0NFp3UWNMU2JpUDRwNW1CSEtLSzVvR0YwM0ZYSTdWUE1WYzJFdXIwUTBC?=
 =?utf-8?B?YXh5NGJ1Slc5dUgrZFk0cnIrSzZjd1N1Tk1pRHlCeWVMbVkyU1J3T014bEFB?=
 =?utf-8?B?RkpCa0JCa3NHNVYyUWdrWG5VdVB6cDZrVzRkWm54Z0JPcWk4Tk9lblBLcDZa?=
 =?utf-8?B?M3lqZktGUVdVc2FtdS9LMGZGeGJXQlZVTkozUE4wNVZlYW0rNkVQV2h6M1dX?=
 =?utf-8?B?ZDQyREx4WWhIYjljQWVqdDczdzlkaUhwM2dtU3pZTjU0eG9tV3ZQdkVtMzFF?=
 =?utf-8?B?aEZjWjlZeGsxVk96eDFmUEoxS0U5ZWFGb01rc05WT3VlRmFiNVRRQVV1QXJt?=
 =?utf-8?B?dDlrUno0M1ZDeWdYRzJpK2ZmYWxkWHYrL09hZ2dqdFh6S2I3TTRsUU5FeERx?=
 =?utf-8?B?c1pqWU1YUkhPd28rTTBWRVJFUkVmV1RBRVRwYnRXOVJWZ1ZXMTliSXdtWU1o?=
 =?utf-8?B?Z2h0RXhmTVM4Sis0SEppTW8wRWJHeHBzYVphMTV2VkZFWm55dTg4NFJNd3Q3?=
 =?utf-8?B?ZkQ4WG9rVVZyaGt6c2NDa1FDRjFvMUovb1JGN2VLb0hDNm5KeHBLUUVGOUZU?=
 =?utf-8?B?RzRRcUJRMHNiTVc4WE4yMlFUWkZyZXdwZFFPOHU2amdIK0JLeTRsZU4ydGJt?=
 =?utf-8?B?UWNDRjhSdndBYmdidzh5YjVvT0JzV3A3SEVha1J4amNOVTJsSFZQRUJoSDdn?=
 =?utf-8?B?R1JWaUFLVGlXSGJHaTRsZktkd3F6VFFNT0RjSmNDT3dSVS9jcGZRT2FTbVJq?=
 =?utf-8?Q?QkNhzJgmgANRdoec+2R3CLnAP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35205ace-469c-4b65-db78-08dab84fdf14
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:17:21.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjHaXqxWsLg/iFbtTlmWEIRoaKYhDN1IgPtFEgHzwTYLLmSfN2190W34Z+frdYUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/27/22 13:49, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/17/2022 3:26 PM, Babu Moger wrote:
>> ---
>>  arch/x86/include/asm/cpufeatures.h |    1 +
>>  arch/x86/kernel/cpu/scattered.c    |    1 +
>>  2 files changed, 2 insertions(+)
>>
> I see arch/x86/include/asm/cpufeatures.h patches that also include
> a change to tools/arch/x86/include/asm/cpufeatures.h in support
> of perf. I do not know the customs here but I see others
> change both in the same patch and if it is not done together a separate
> patch to tools/arch/x86/include/asm/cpufeatures.h would be required
> anyway to address the inevitable perf build warning.

Lately, I see that these two files are synced after the feature bits are
committed. I can send the separate once these changes are committed.

Thanks

Babu

