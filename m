Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65107396E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFVFj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVFjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:39:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800881728;
        Wed, 21 Jun 2023 22:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjXrp0JW+2CWvuj6f5VWmID+lTPlIJpMqLhFiKpVYos59zzO6sA6XWwl0swnN7iIXegZu2Rxo9DA8miz2EZkMX9qnLNmY/umiLd8J3FXzmA/GuDIuvsuF56G2ehqB2DaeIi+ME2khNcP9OyADqITKYrXyUoFaNajOI2Kqv91ChP3M0AuM3L8Ag7a8CRhnA2Yyp4U60p02/Gp4oJxBQuP7EK2S037WsZoEoBUyGKrROal+dC0Cg0NyrkUO0QvR3VLIVjak0PomFEYR0k0uN2BxUyauIVAbmWBXP1KWb0CQePWrV98AaErVA8Q5CS7JCpLdZ+DFyQJ/JIIa+UranK92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9AnkBKjVrw5gDOcp3YN0LPxvKMji3oYLQKAdDekoxM=;
 b=i1nglRbprc9/6NoXbIi9Xei38qXkX456SzxxivsfKjAeTVw8XKdh4rUuFujzDt7Vx1DEtDPBsJkV0veU6C7Lud43MsqTyEJ+naB0Pa+4X4Qnx7TqdkJnnxfqLl5oiszCOMtAzJ4b8lnoJCFDho4H+hRM3OYAaRKtZgPV5ukXlvnSRhdJyScWis2IZuuis88g2bEN0wFSgeyeLbCDMROIHErswIo6pgbxMbZVkxgT1owC15qAKJmY0czYxhHVBB4haVS+y5lINjSv+F2/9dfMk/fuaC6ri0oodlArc07tavVh68E1cof51Qqcs6GfXFMdGM9LcmiGZs+xLGU+/BljyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9AnkBKjVrw5gDOcp3YN0LPxvKMji3oYLQKAdDekoxM=;
 b=20TPF4cvr2/U7584dbRQebBJQI97i/V7Mpi+ejYS9dwFW/lpH2u6XfnBMeZe3bz6hrTEZgpdDokc1KxPnWd9HZGD8RDI/xD9j6Y7zOQPvNLEk4M3z7diBu8tXHFiHFqkrWMeWjHqolt9K1mWEwJc1RZ9xaMT1B6io3bJQKsoUL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 05:39:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 05:39:19 +0000
Message-ID: <515f3ad1-3e2e-7c59-5005-1ce6ad83364c@amd.com>
Date:   Thu, 22 Jun 2023 11:09:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230620091603.269-1-ravi.bangoria@amd.com>
 <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
 <CAP-5=fXfTDY9-uDq2BR2QmTP=-1=4RKRK=dvKmz5CF+oXgz+Eg@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXfTDY9-uDq2BR2QmTP=-1=4RKRK=dvKmz5CF+oXgz+Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: eecb58ab-00b1-4355-83df-08db72e305ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ1aBAvGhLg9CQCWyxghFWj/TVcWlY95TmycdGTEkOl73I2+ZszQN/kZ0vJPrvPTWQU9EQpymWjVUDzcO39v6MXF66nSAHSHXxdB26LOgcThwWFxyVjlPmvqTFAQ3Ix/p/xoWJehlgpRUMmtJa0Pf02uLQjNkeUl9WxPJJ+hYDV+Zi8pcH7vT+NFQnO01xNgv2ClIhBn3y2tNg8BUQ0sbjkYju8nBEc399xg+Yrx6qDOC+93wtMWZPGSg5pgxLVCPhCeuIxFx9WcrrnKuqFM4ZVsmVvCUEr5jdB/yfJSLhihwAy+WsEuVN6nRAFiuTXYUR2R87W40Xoj4yPxMWhkfCp8Tn8n6APVrfbfKwpcczpAP5karzPmXdGWO7DDN5/VUnOnBSCNhlX6gd0ukHxdwzkX9GnQreCRTxifKol2hxbs9jnEIDqjEN+gTDe+ewt2lV+WkbqVoJ8nI+s5tyK6BMmfiOGIWudmmqYXGinsUC7ii6B0BtMbVgLJUz9p/euUSns08i+e9k+aGRi5fl4ZG5sTXewLygZyoO2c0wXmT30quy74jVlrdWW58Vc4HVlT2JUt0p/Zc+PtZ2cP4DOBFiT7yWW7V/bnrRHpRtLRcAwvG7s4M0vMhUSTd4uqqjF8y7NqvfazY2/NZFOgfqWJeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(66476007)(66556008)(66946007)(6916009)(4326008)(2616005)(31696002)(38100700002)(186003)(86362001)(6506007)(6512007)(26005)(83380400001)(6486002)(966005)(478600001)(36756003)(6666004)(44832011)(31686004)(8936002)(8676002)(5660300002)(2906002)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NyMlN3ZS92a29mOHgrR1AwVE9WaFdzWE1vR1QyemlnYUxpVUhCYkp4eGI1?=
 =?utf-8?B?ZFZKQnkrNjlvak0yUXJUQmQ0TUFvT0lnaXBBZUxIV2N6VGdNd2NuUGFRL0Js?=
 =?utf-8?B?cnNsTmlMaU1pd2NaMkxzMXVIL2h3d3U0MXVORXo3S1Z3VFBIbU44a0ZoWTcw?=
 =?utf-8?B?R0Z3Rjl6K1JRS3ZJTDJQNk85TGdxTWU2ZzJ2QTE0OHFteklKWDl2eWc5Znls?=
 =?utf-8?B?QVI5ZmcwaStwUzRZWFRjdzFPK0pLeHVuNFp5eHd1TUJxc1NFU0VjalQyZmRV?=
 =?utf-8?B?citrVHRjRUNqU2xPWnJhelBjM2FucFVWUWF0cWowUE9teUgxb1VtV0w0TlN1?=
 =?utf-8?B?dnphSVAyZmZjZGl0QmNTUVpFN2JuMWlBa0ZEZTh3MFZRM3hiN09WQU40djhD?=
 =?utf-8?B?WmtBYmVRN2dFS2UvTGN0L0hmRUszM3hCWXkxdEhyTmNnL0RyQzIxZnFLdXlR?=
 =?utf-8?B?VmZ3ZExkSU9jQ3J0d1N5eXNaWEZidFBnUkZQRXJkZUlPUzlnQ0VBdDJQUmh6?=
 =?utf-8?B?V21WMDR2dUYxRk5kckNIWFVNcDMvZ05COXF3aEU1SUtrQzVjVktxa1A1a0tr?=
 =?utf-8?B?V1JMajErN2FyL2Q2NDZKWVRRLzZ3Unl3NzRRa2x4THdQRjN6THNwVUZpby9I?=
 =?utf-8?B?ZmRUUmpvVVZpZk9ZNThKWDNWT1dTdlBtZW5OOGJORnp6cm5mbFVWUkVPSVh5?=
 =?utf-8?B?WlFJTVZpbmdhS2JWVGU5ZTVLR0hUOXJJVTkrMlFhUlQyYkJvbU0rT3RjUzJ3?=
 =?utf-8?B?clFsNERDTGpKUHp5czRtL1pqNnFqeE9HRnI5YlpLenEyZm9CVndpaWY3OFQ2?=
 =?utf-8?B?ZnVlTS9MdFFOcThuQ045T0tMcm01Wk0rNXZEbTVLME9wZ05udEQzUnpjZ05C?=
 =?utf-8?B?NkcrU3Fja1NjdXk0QUwrcjAvNHlvRFI0TnprWkZqSzFPRGwwOHlUVlc2SDlq?=
 =?utf-8?B?SU1hcWlwdVJMNzBuZjlpZ2lGZlVxQy9WTkQxWVA1WGh6a1V6blR2NFJrc0lh?=
 =?utf-8?B?RmYwN1o0Rk1DSCtlck90dkpJUzFYVzVqMFlTYVAza3VuZlZOWHRwUkJnSTg3?=
 =?utf-8?B?YVBZbDdyaFhpUVd5Y2xoNS9CUzVuM25YSTdZLy9jdlRIaGQrUUdpZjlQTjhH?=
 =?utf-8?B?UTFFYTYxUXpYRUNuTXl4S3RwN3dPd3U3aUxxZE1sSWJtMytuZFFXZUZOZTN5?=
 =?utf-8?B?NUlUZ21jTmM0NVRSRzdDd3JoU28vK0dlVHVFaC92dHBiK3NtUlZOR05sc2h2?=
 =?utf-8?B?eDZFRzljY05XNEs0YTUvdjNFUmhzM0ZINzF4NWRud3NUeWJYY3hMYzljUzNn?=
 =?utf-8?B?akVBNi9JWEt6d2hoc2tSZy81T3RCQkoxaXdJbmtZNzlUclJVQVBNL08zTzhB?=
 =?utf-8?B?Vmx3T0ZReXAwNVFhcmxOZlZxMkNjMkFabnIyWktBUVhMRHY1YTB6K2xONElY?=
 =?utf-8?B?SFhSdUU4S2NocmlyOTZEc1BsSURuLzJaa2Q2VytQandHcFY3aEFOdlBUR3Bl?=
 =?utf-8?B?QTRadFdhbnpZSkxjT0U0OEpUUU9VQ2taSlNLYnM5RnFZVEh1cW5GR1JHV2k1?=
 =?utf-8?B?QnE1WlNldFZkNmI4TmlaVDk2bldEZ2JSYnNXS0ZDd0ZkRFBpLzQrZ0UvSWdR?=
 =?utf-8?B?VmNQV0p5cWRETTcxUVVuK2lXMGpVVDZ0Yzk2K0kxWEc0Sy9QTXlqWDVUYnFx?=
 =?utf-8?B?SS9pN3NXYUI0dldOOHNIc0dNZ3I5amN2WUpELzB0MGpEWnZaWUNHUDZxYnhE?=
 =?utf-8?B?cEtyUWtoaXZMR21DYUc5Yy9vRW5xbHJaclBrRG1aU25uSy9CZGhiclZaRU5x?=
 =?utf-8?B?YzVuZzlNTHNVZGFrdGQ0elBNbFM3ZGlNSXlpVnVlUzJrdEEzRkxMN1k0OUpy?=
 =?utf-8?B?QUU1TG8xS2NmR0MvQStEWmVQajdUUlBqR3NYb295Y005a0RKOHJPbkhvb3B0?=
 =?utf-8?B?OEtURU5rNUJwWW1BVVArNlJkS3RaVEM1R0QxWE42bC9BbmlqSC9aZmJ4L2Vu?=
 =?utf-8?B?bmNSL2ZVamhxczhqUy91Vk1OOFN0OHZGWnFVTWNZZmc1anpnVVNRWk94b1ds?=
 =?utf-8?B?UWRhVFUyeGxqZTFlQitJcGhZK2cxeHdSYUI3aG53WXU4b2htUmxkWXNxbXA0?=
 =?utf-8?Q?pkD/bvP5aRwA7gcqlyy0X7Wyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb58ab-00b1-4355-83df-08db72e305ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 05:39:19.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7SZ8ZN065vXAu1VVoy5X0oXBXX4cxmCka0RXR5/mDZShoHDH5lSPcLCkW1TJP96QCB48feyGuXCd2wbU2pwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

>> Before:
>>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>>   ^C[ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.540 MB perf.data (531 samples) ]
>>
>> After:
>>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>>   Error:
>>   AMD IBS may only be available in system-wide/per-cpu mode.
>>   Try using -a, or -C and workload affinity
>>
>> The error message is stale and misleading. I have a patch to fix it.
>> I'll post it separately.
> 
> Thanks Ravi, so this is a workaround for a PMU driver bug where the
> perf_event_open should have failed for the sibling event?

This is not a workaround. This kernel patch fixes PMU driver bug. With
the patch, perf_event_open() will fail for sibling IBS event if either
group leader or any other sibling is of the same IBS pmu. Or did I
misread your comment?

> 
> The behavior is somewhat reminiscent of arch_evsel__must_be_in_group:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/arch/x86/util/evsel.c?h=perf-tools-next#n41
> 
> Normally software events would be valid in the group, should the code
> ignore these?

Grouping of SW and IBS event will continue to work after this patch.

Thanks,
Ravi
