Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AD63A1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiK1HCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1HCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:02:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3AAB2;
        Sun, 27 Nov 2022 23:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va58jEOmunkBMrPpuX3pnQQw0ekd7emvgBb24YfZJb9F4K/sPh+NFRRHqlS2eQr2K5bVakOhaZ46g9++5t2iiPuuGO2ZGczsEkhKbCKUm8yZUGNf64hlQvcEhhIjsRUjEIHxHviLjkzQVO4n0MXhNA0nfzvkTqelZKkHV9nz32TTFHgcc2aXNFMujeMylxS0vAlhQep/19c4LOv2G0EeE1EdtRc0mH1GdhsQtCZ4vhpel2O14WLW/3Tcu31RIbYxDoc2GPqSiKQCjlVRALdWO+NU/s4Wy+wTAF/e2KXy3BGftaFXReCeoQwoZbU9gIlRDXbKAg+KTJVzFmhCakLSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA6hAusJMUYml3jUQ0OuRqO8yMa0Gz80ddR8cbHfOJM=;
 b=OQbXhHUXqYLqirVwE4eXH5NWyFkxqh/9Ny8ef0GToGnidYw6fCuFrlXtjslJ2sspEzPWPEIw53CG38vOl0ShlOXR60v36XYK85wwVluH36RHXceZ/pSmXh72rBL3ujbeAqd/TNr90EUqYQzBSuuigVOC20xI1mVV0OpDx2nRwloVuJm1ieEMvITeGeqTt7eSDUrOh24JKk+dtD4K1bwVCUdEDxksPnX+jpJFbzi+hiUfMKmtMW9FKG55JR1fNy4epPLfVXIayyRxDoa91haqyRohNuuyeHviJywzAV5royRwy8+g+kZbuOVj+LIuPbDeYSC6bb8dhviKWHu/0dmstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA6hAusJMUYml3jUQ0OuRqO8yMa0Gz80ddR8cbHfOJM=;
 b=ic4/OluMbIjtA27GCfphpqBHtxpOWWCM196yCSIeXEOzJ1HNt9M9h5eAup0MqsrweEdNRnC/6E5MdvmxoeGWrZlVFpGPQLfbKpfNv2lhQO7041ewz6PtESek+How5MtULrLm/jY30Wd4ps396q3NBqXwjGOdUeVg5LZ9lKjXlTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 07:02:07 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 07:02:07 +0000
Message-ID: <dda39c0a-0857-e650-b5ba-5fcff2414179@amd.com>
Date:   Mon, 28 Nov 2022 12:31:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf test: Add event group test
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221125032018.962-1-ravi.bangoria@amd.com>
 <CAP-5=fVtFLuFzYY8x72ib1=G8n-aFYjqRmttxsu7t-oFGnCWEw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fVtFLuFzYY8x72ib1=G8n-aFYjqRmttxsu7t-oFGnCWEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 83100df4-7333-4784-2867-08dad10e7659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teoOcxb96vHVORWr7N1s4+vjFilIvs7dQcPS2RWQxgJksTaFV71ttOInmV7jCtlxHEq08M6I5reVufg5Ki4tJbGi+KVc91JNHglKwAvcjZmEwXTBNJXer+LFTUA4IHVgnSZFVk1C0Wh1xnMIANoSmtxe6ofIzFD918+uElPWOEsdlxr02PCQOl37bQyiosHVaz1/rNA5xiUmCRJWN68IqJaGib6VEXwOKQ+6DlKL1cKNvx3G998HaQyCMfy6XagtRHIHZ/IYRoVSpxouzMnVac3czSb7naUXXF9pmyoEM+lUg+Ley56w1PdXyULy69wcGuxG344snKLZW35dNG4GmwRaYpIkrvsze6CvYH3twrWLLwseADobTQB+dFI0R/NoM2+n+vhbyB7vCO9WDvPjuyV4kKl6FX1L7z3zXfVQLPoJsMQe7DIPR/igQp0/ksp8ElYvnaTD6teqrF+cYbeZVeerVzPGJMjjAAk5CXalIXfgBJPjIbj5uNgYGtOXkAi+hvvv367WEdxV8fLz4c2RJMXeahkjjecTm3hCrqRiq0iafvZBZXej1c6HBEn0IpiRi8yl+YodVRkOypbrYOKY+vaR3E3xMR2IYMO11+qYdEZUQUmpAFwEvFybVv7WCYcyXwpLwrnTI/4ulG7WeKwhPpPh0sC394I3SmgcyTmuYaYtb7ruwP+8/FyuUPSHk224mXoDsM3CrVpSGRZvV2ngt9SwzhS6JiEfnvwm65CHXmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(53546011)(2906002)(186003)(6486002)(36756003)(478600001)(26005)(6666004)(6506007)(38100700002)(31696002)(86362001)(83380400001)(2616005)(6512007)(41300700001)(31686004)(66556008)(44832011)(66476007)(8676002)(66946007)(5660300002)(4326008)(7416002)(8936002)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FFWHNFQm42QXhlTjJtdFJrakgxd1gxUVg1Y2xYTy90Znh4SC9pSFVSTS9j?=
 =?utf-8?B?TUFsbXRSSDd2eWVhVW02VUNNTHFnMTBzb0g2Yjl1ZGVDeDQ5ek91VHpocjdI?=
 =?utf-8?B?YllmUkRuUFVBSHgyOHkzcXBYekEzQVpPTEMyNTNZbFBlN0hGUUl4MXE5ejNt?=
 =?utf-8?B?QThldGNEVmRxSGhzNHg0U2JWMHJiWjdTZzdBMmNqTkJUVkc5WjNVNDNVb1I5?=
 =?utf-8?B?NHVoUnFMSUg2OUtadktQYXY3Vk54N0E4cVA2NXdKTUJ1Wm1veFVDcVdZbU5Q?=
 =?utf-8?B?dmw0bDhic3dKWjRGS0gxZmJZQ0h0bmtoOStscVU2UDJhMWZvUEpSc1JRSmRJ?=
 =?utf-8?B?eFpMTnRjamhkalRSU21lM0VZaXN4eW9SanE0a0dGZkIxcTI2eVZodWR0ZHg2?=
 =?utf-8?B?N0xsQWxYMmNCRWVJR0RZN1pHMGVhd05rM1QrQXNCWGkzdkdkdFkzeWE2UEYw?=
 =?utf-8?B?M3h5S1I1Wmt2ZVBrZ0lvNEZtUE9iTkgwWkJhRmhOUG9XNE5GRnhmdVBZeVRn?=
 =?utf-8?B?TDhOTWZlT1dmQmNCaE96UDY4Qkl3S1lYTUlPNk9xS1lTcEZEbGpNMU4wWG5O?=
 =?utf-8?B?Q3dta3JKRU0zMGtPTkUzcHZGcEptbjJnczlSeTdWSGJpbHlLWnhOU0NqSSs1?=
 =?utf-8?B?cmJpSjVkUkQ0NXdtQ3RmL1J1eDVIYThwaTJWSURmcFJMaWEyZmJGSEtTZm1a?=
 =?utf-8?B?cmwrck5GMTdUWGhDaVd5eFNnanpQVURWdmg4ZDJzSkdoTGZTN0JBUVk5WERl?=
 =?utf-8?B?OFU2dnlDdVh6UE0wb053QTI0bktkOGljSzNwOGhjR3VKRzVNRTR4WkplTk4z?=
 =?utf-8?B?Y3BWNDQ3UnUwK0ZvYlFsTTVzMFpXSXdEalpVc2ZueER1bnZtd2d4M09BTkFL?=
 =?utf-8?B?VjU2TjJjSEMxZ29oODJQZEFoSVBFL3o5NG1iRXNDblVaYjFGaTBVOWdjZkdz?=
 =?utf-8?B?cGFjeVZ2K1psVUF0ODJjeGZOUGFDYk94WnJvWG1OOG5FSXdKTmtTNUFsOEJ3?=
 =?utf-8?B?WWk5endnYUxVSXNjUG5QUE80R2VzQ0YyNG1KWFZ4dWF2NXR2Y0h1Mk14Qm1L?=
 =?utf-8?B?eXpVRnNOL2trMzIrcDFPcG1nUCtzUlhKdWJnUzVHM2VtbGd1SkJCdmJJb2Fy?=
 =?utf-8?B?V1FQVzNZZjlIbVprSFVEVmpGZnZoWVlBTnI1Ly9BTVA3UFdBVnVaNkhTMVVZ?=
 =?utf-8?B?YU5HR3ByYkZvZlBNOVg2WHh5OXFjTXpaUkdaeXJhRitOSW0xTEVLR2k1WXBC?=
 =?utf-8?B?TFg3aEpYZXNKMHpPNzRmbytVTXNxQ2hrSWxDeHhyNWxHOEZvZHYxSkEzZDlZ?=
 =?utf-8?B?U1JBakJPZmsvY3A1cW41OG9rN0VJMWZ0VUk1ZHVCVGc2Q1ZWZUtqSndOaDNm?=
 =?utf-8?B?VkFvVy8xWHRaNVNMSEZnaGNDV2xOSFp4MnMxdE83Q0ZZUFVmOXo4ajJJdVhi?=
 =?utf-8?B?eHBVR1V5ZGppV0hFc0txd3liWDZuZHZTRUdGNk5OSUVkdUtpbUM4R2N2NkZS?=
 =?utf-8?B?N3QzbitxMUc3cTdyLzBRM3ovRXF0WW5qSDVaSVR5ci9tQm44TVJwV1g1bW8w?=
 =?utf-8?B?L3lDVXVWRDM4eWxZNHhQVmd0WGtSaEZadzlxMEgzQVJSWEpDeFBaOFhKSTlP?=
 =?utf-8?B?WmRtcWozOFl0NkgxSDhsSFoya1NXNlU3K3cwZExoMExiSFN1MFA2U3hFK0wv?=
 =?utf-8?B?U0JVQzFFUnRqdi9pNXpEZkZyQVFWT3Vvci85UU00MzRKOHpoMVQvSzJOWTZJ?=
 =?utf-8?B?ZFcwSGRYSEY5N29EV1NkQTJRYXBOTXZDa2xEcmR5bDRMbWtScXV3c2NJTmZP?=
 =?utf-8?B?S2NTcUUvVmZtTm9QUlh1bUVacEdqcGNUallERWkxQTBzM3JRdXlIWTh2aHZN?=
 =?utf-8?B?aVNvZm1SNkpmRXYxM1dDNWJYK1l6Qjd3ZXpRTVh2d0pVa3B6MDRyMHdDQmt4?=
 =?utf-8?B?TDZSdWlpb1N6dnhIeG5rZml2YnFoMDVQN0pQR0hDZVh0OE5jOWRKTE1meDNP?=
 =?utf-8?B?ampEeDBjZGxqc0R5c2c4VnFDNVczQnlCb0JHSTJLb2RoR2dpbVg0SVdxcEht?=
 =?utf-8?B?OWQ5QlBBRHdiRzVSUk00b2FJa0ViSmhrOU9Ocy9INmVWK0xSSjg3WDl2dEpt?=
 =?utf-8?Q?p2Hio1SyPLeOA4G7RGgnVFAue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83100df4-7333-4784-2867-08dad10e7659
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 07:02:07.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGaCrF+E1BEYegFHHW8hQhKJTilivsDQq6/y9D1klIZAyB/t5InlIpx6vZiHPJN3r3NOpSyNUP3Q4HfEdipLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-Nov-22 8:58 AM, Ian Rogers wrote:
> On Thu, Nov 24, 2022 at 7:21 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Multiple events in a group can belong to one or more pmus, however
>> there are some limitations to it. Basically, perf doesn't allow
>> creating a group of events from different hw pmus. Write a simple
>> test to create various combinations of hw, sw and uncore pmu events
>> and verify group creation succeeds or fails as expected.
> 
> Awesome, thanks! Some comments below.

Thanks Ian!

>> +static int event_open(int type, unsigned long config, int g_fd)
>> +{
>> +       struct perf_event_attr attr;
>> +
>> +       memset(&attr, 0, sizeof(struct perf_event_attr));
>> +       attr.type = type;
>> +       attr.size = sizeof(struct perf_event_attr);
>> +       attr.config = config;
> 
> Could you add a comment for the line below?

Although this test exercises perf_event_open() and never enables any event,
I'm following standard practices. Snippet from man perf_event_open:

   disabled
       The disabled bit specifies whether the counter starts  out  dis‐
       abled  or  enabled.  If disabled, the event can later be enabled
       by ioctl(2), prctl(2), or enable_on_exec.

       When creating an event group, typically the group leader is ini‐
       tialized  with  disabled  set to 1 and any child events are ini‐
       tialized with disabled set to 0.  Despite disabled being 0,  the
       child events will not start until the group leader is enabled.

So it's well documented. I can probably put the same as comment.

> 
>> +       attr.disabled = g_fd == -1 ? 1 : 0;
>> +
>> +       return sys_perf_event_open(&attr, -1, 0, g_fd, 0);
>> +}
>> +
>> +/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
> 
> static?

+1

> 
>> +int type[] = {0, 1, -1};
>> +unsigned long config[] = {0, 3, -1};
>> +
>> +static int setup_uncore_event(void)
>> +{
>> +       char pmu_name[25] = {0};
>> +       struct perf_pmu *pmu;
>> +
> 
> I think the below finding of an uncore PMU is clunky.

Agree.

> On my tigerlake
> Intel laptop, for example, I don't have an uncore_imc_0 but do have
> uncore_imc_free_running_0. I think the real fix here is that we should
> start a new "pmus.h" and "pmus.c", moving the pmus static variable
> from pmu.c to pmus.c. In pmus.h we should have an every PMU iterator,
> like we do with perf_pmu__for_each_hybrid_pmu.

I see only one variable that can be moved from pmu.c to pmus.c:
  LIST_HEAD(pmus)
So introducing new file pmus.c with just one list variable and a macro to
iterate over it seems overkill. Or are you suggesting to also migrate all
pmu.c functions which iterates over pmus list?

> I'd like to go further
> with a pmus.h, as the computation of the perf_pmu struct should be
> done a lot more lazily than it is now. But for now you can just
> iterate the pmus looking for one saying beginning with "uncore_" as a
> name.

Ok. I can probably introduce perf_pmu__starts_with(const char *name).

>> +static int run_test(int i, int j, int k)
>> +{
>> +       int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
>> +       int fd1, fd2, fd3;
>> +
>> +       fd1 = event_open(type[i], config[i], -1);
> 
> nit: a name like "event_group_leader_fd" would be more intention
> revealing than fd1.

hmm, but that's too long :). Are you ok with:
  s/fd1/group_fd/
  s/fd2/sibling_fd1/
  s/fd3/sibling_fd2/

Thanks,
Ravi
