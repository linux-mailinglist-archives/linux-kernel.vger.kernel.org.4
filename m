Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AC617BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiKCLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:45:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35026150;
        Thu,  3 Nov 2022 04:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhucxOHQgFAfj0p5WWLyq8OPoz+YxOeHEZgSfMEhm3YyhstHLhXGGS1t3nHBY1n+rOXY+J5i9RJdXvzLoqnF+J5/LZ9ElDkU9fJcuj/J5b5+UAKxXQgC/Pvx9EGV+WBl02Z1kMTXd2W9xAXDSvDkpVi/RtsL+irINLELcwRhBcbS1tp4YUlMUP575vy8l0GdgOhMVvuYTqF5pEHQMuNIC5G2XQ3DfWyNgHbMn1g48f7Rgt4b4xmZC4MHxQT7JlovXUwIiBQVXeq/lEoGLQysnHQmpw04no+hca2aV73NqTzoSJnWGCnz5pOidKFsLvd5s6q/A/fKANTviR7wzLQ6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fq3e/XSasghooDcUDmKNMqb/CYo7qlDDcX+UMO4Qzs=;
 b=gl1M1KhQhjTiXgGjoV+j9k/vZ2k7jsSfm8tvhxx4tjRAP3oeY22eG8KGZuXAsUQm/vg2e5OnpOXq+k2nCowBfpgm7YxzRsz2MYZF7BNqIjk/pofKGgWVN8rX8NE54rkiE46u+QHNdbfqsIsa5kppLqmzVHeVweIzJ8U5/xExySxsGww9LcckOKUv9icw/DVXRCZ2Yx5AKxWJ6SyX9POQcvxViV95nkLzaOuVLPr0VptzR9wVmBFyyEGmiSDbRCbAYUp4Q0esDMsVK1Ojdg6KmHVB1ThP1Px3H7xF3Bs5bk8rc6N6YuS61t9l2QNdCKktxTlkJTscPKTTvnhyj7hg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fq3e/XSasghooDcUDmKNMqb/CYo7qlDDcX+UMO4Qzs=;
 b=JPTSivVAgi+dyUvm+EoLTJwRGsnlYsjqsstXpA4MEQ4i6Zl/BqhJ1g4/D6Jn2QcEj2u3Lot5CYtERj9QPMr4/zL21otFsBLqY2ORH3wT1MwKAATlURNCLfEwCYOVPkFt/RHYY2m3RLhVw9MGc9rPQxKNt0VbAnEZMjsQokjagF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 11:45:45 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::f397:c6b1:a8a5:55f5%6]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 11:45:45 +0000
Message-ID: <cb40c209-9c4c-f645-8454-bcd74cb72405@amd.com>
Date:   Thu, 3 Nov 2022 17:15:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Sandipan Das <sandipan.das@amd.com>
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
 <4429582f-155a-04d2-d139-a834bb325612@amd.com>
 <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
 <5bec4620-2e2b-abe0-1e82-528c084d4d16@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <5bec4620-2e2b-abe0-1e82-528c084d4d16@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 11859f14-e31d-4c00-0d02-08dabd90f138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYmNNt3/FrrY0Vv8uvPYwiXbxfK8u7JU+iOTMJU8kum7N0m2Bl/qgd8q0PIPt2TpJrHBv1+RsrLUDt0ZaNVjg1h3tS/lhQcQQB6HthIrO6b61sACMsVNvU89fC0YFAJLJjXBMFYWVAZGxyy5CM0V4AgDc2w0OVk1MKzDyTPrcmpF6Vk9GKM60IO/0Qkjwy6lu3Ziqi/DLkfxBzC3Bbis3Vb7Xl03074XV8SRbzS+pJytEn3orv77XZAouRLMamEo64N+VSY79Dsd5DGv2ENrNAyOLYGAlnxoWrF8Mbmr4hU8TvRhSmUXBEI7rKjAF27BY6asxCBiByoepxWuANZViHS7AtSamh3cNPfEAMOkLLO7MOq1pFgWjXHJ0ZJOdQS7b8lifN+Wr4nZUkev1dMQ4TGray6SKYyPrT7b7G5oilE+LJrPo1a0/Iye9VCHOpsZ7hZKJ8hiV9CjO8kpkTgKlpkDPy5FaMyKM2loePTyiY8o7UpsK6DTqi8cPkac4vezhevO1DRExuiUIYKqxhUz9lohSgsbsixT7RrRFDTNwPHCzWDwPmINIwgmP0gTNkaJiGxcza53S7iG+VHs5vZ8L8SMFYPrGBEnAlrG3f0muxycF/sSCmgzRmptgMdwSOs/rM6yAo2wbaQgdhHwrWPq7dlWvcD86rtvBswdApFj+z7FSmTdQHQ2hISwDVQonn6ZBaO1CEqgeACpyK3B7laTMWWVqelOtpa8iQppP5XVDTcOpK0dEY7QRTjMotM9z19c4/9uizwaxKGAFXXqy0eoyb5Ruh9ULc+FjPB6CTovGkoCSXqvbZBjh4Cdc4KKvVph8WBiQIXPd+2NibfmWIs6WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(53546011)(44832011)(6506007)(2906002)(36756003)(83380400001)(38100700002)(2616005)(26005)(86362001)(6512007)(31696002)(54906003)(5660300002)(8676002)(478600001)(186003)(4326008)(966005)(66946007)(66476007)(66556008)(6916009)(316002)(31686004)(6486002)(6666004)(41300700001)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkc0NEUyWVpHUldDMkxRN29USkJhUEgvM3NJbFZMRTAxd1c0YnV0TGRtdnVD?=
 =?utf-8?B?eDJiSXdBRkxPWjF1bG5ubytaY25MZVE3WWRhbFVnNUJJUENiK3ZYUm5IZStV?=
 =?utf-8?B?Y0s5V1NjcWtkZTI4ckxNOXh5WDhPaDVYSGpublpXVWhyc3dOcjYzQXZwR25O?=
 =?utf-8?B?bUo2Wm9URmlvdXNJYjFZRnp2T21ETmVNS2dVVzhJc1ZJOXdPdE52bi9ua3Bm?=
 =?utf-8?B?aXl6cVRNQlpLSVlSSjM0dnd6Q0JSQlhVSUhobzczY0lCTEpaU2IwNmpycmoy?=
 =?utf-8?B?eGlEL242bUIxNVZFclBDZlNkTUswVlhDbWNCN3V1NVlXM0NPWnlqOE9DRmVw?=
 =?utf-8?B?RHV6cUVpalRZK0RycjBhWUpLVHVIYVdkRW82TWVRRzFkN2hTSHdsSHU2VVZ5?=
 =?utf-8?B?RHdLM1V2dXo0cWZlMU5VUHdTN2pKNGZoTXVHclRXL1BrZFNqTDBhWDBEY3lm?=
 =?utf-8?B?Z01zcGFBOUxWb0JrYlg2Yk4vcTlPUjJqL1NzVWNZeVEyd3pVSytnYk9pL3NK?=
 =?utf-8?B?VHdXVUlocVBYOXU0bmo0SDR6N2V1cktGVFVzRHYvd2hpc1lUUkNuNzQ3UTY3?=
 =?utf-8?B?Z0xGMytPelNJUkpxTit0ZWNhZ3F6NlFNY2FDaWdnVEJacU1LTFNETjRaWlh5?=
 =?utf-8?B?ZHFZVElXT3BIenVma2hNYUY3U1pScGlBakx2SDVNY21oVFUwRXVkdDZMUEs0?=
 =?utf-8?B?NGlmNUVjK1NsanN5MDFIb2VPbWdNb0NwZER0eDFKQUdPRmN2SStCOWNxRDRW?=
 =?utf-8?B?VWpJd09oSEZ0SWtBaUZzWjlRMDN1T3ZuMEh5Vk9Ta2FDcFR6RGw3RXhzbnlO?=
 =?utf-8?B?ZGxPU2xvVVRIM3VuQWdEcUxSWHBpYjhvV2FVcXdQVENHMC9pV0xYM01nbGkv?=
 =?utf-8?B?Q2hsRXBHMnBKejdRbFVIQytpUWE3QStMajlBM0xqVUxkUUR1dW5DaHBCY2Ru?=
 =?utf-8?B?YkNLaGlDQzQ4TEY2SmZOMmFWUEtsZ2hiZ1NXR25oNVpVODBMK2ttQUNRM1BG?=
 =?utf-8?B?ektGOFNxZHI3Ky9nWDR3OUVMT0FNWWJQVEhqMlFRbjZyOUtTTmVnTDdMTFIv?=
 =?utf-8?B?OHhtenZiUkNmUXFCTFRlTzJOVnZlcUI5ZFNCU3lsaVhFbEpYbmo4OXdsbTh3?=
 =?utf-8?B?MnFxOEp0YlNnazhSUHg3UkxOTTRDRmZYcFlCd3FXN0plM29EWitOYUhiUDhx?=
 =?utf-8?B?TXIwakV3cHk4bHVrOTVyMmdsdnE5MEVLZ3F1M0xQdnhlYnhxaG9vUjA2Wk05?=
 =?utf-8?B?NERaZmdFWlRXSzB1M3JjZEtOaFpKSG1DLzFGMWdVUFg4UkpXckFWTXJZRkp3?=
 =?utf-8?B?TjgyRXJrbnpwdmg2VVFqTDhJVFRnQmM4N25oR3piSTErR1JhcmJ2RTF3TTV0?=
 =?utf-8?B?dVduejY2MCsrbkg4NTZrdGtiQ0R5VGdqYkZPQnpSaElaN1JGTHBaOUpWc29i?=
 =?utf-8?B?UWxBZzhselpUbjZLQitWa1FLZmsxLzVQS3lrMUxhY3hXd2RGTE9KMGd3bW9B?=
 =?utf-8?B?dFJzVnpTUTlncEkxeDlCaE12ZEQyU21LWm0rMnRYYW9sY2Urd2pqOFhRa1V4?=
 =?utf-8?B?My9XZ3pxK0ZtYzZ0TXFzQ0hrUGkzQmhVVUF4RE4zOG0xZmYwU0x0SEVoQzQ1?=
 =?utf-8?B?WmtIZ2FBYzljNnc3ZXF4T0hZVXd2V0Nxd3lJNUFYOTA4b2pLMU8vUVJzMHR3?=
 =?utf-8?B?K0ZSL29XR2d3ZHZLU0VqMndIeVY3WklJSThZSUl3MmhObW5VYVMrZHFnakJ5?=
 =?utf-8?B?bGlqMm10d0lsazlQc0NSUXlNL2EvMExjYWJiNis3TmJCM21vS01GekJkOFJN?=
 =?utf-8?B?MktYS1ZJcnIyWFBIckZUYk1wL1dGajJuUXlLdmVVQ2JvZ0V4TUtCL1RCdFVD?=
 =?utf-8?B?TWdpT053QzVCaE9KZU5zLzhnRVhWeWpobXY2anl0NjJSamxSVFl0blg1VlVx?=
 =?utf-8?B?VkxVVGxXekxHdjVkeXhROUNzZ1RyVmthd1dLYlgwQmNzVHJuY2VKZ0NzbGY3?=
 =?utf-8?B?RHk1bkFQaEVwSlRURmN1azBtdVM2VGhITTNGeEkxRG0wanFjbzd5ajlkNnFF?=
 =?utf-8?B?QklUd2ZQZlIxU0M1VTc1bng5aHNhMytuSnczcFJoblJUS2RpUVpaTDFFQVdQ?=
 =?utf-8?Q?QoPyRLEXFos1IhVwX5qSSjN55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11859f14-e31d-4c00-0d02-08dabd90f138
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 11:45:44.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMeKpuB+/If9Dh70JvZBYWCiIhzN/1tPHhOW+C4jBNV7++zWtLh2nvqa8OtgxLWWDt1ZUV5giPxXarT9F7eq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Oct-22 3:35 PM, Ravi Bangoria wrote:
> On 25-Oct-22 6:36 PM, Ravi Bangoria wrote:
>> On 25-Oct-22 9:59 AM, Ravi Bangoria wrote:
>>> On 20-Oct-22 12:24 PM, Naresh Kamboju wrote:
>>>> Following kernel BUG noticed while running perf testing on qemu-x86-64.
>>>
>>> Thanks Naresh. I'm aware of the crash[1] but haven't got a chance to
>>> root cause it. Let me try to spend some time on it.
>>
>> I tried to mimic https://lkft.validation.linaro.org/scheduler/job/5708609.
>> However, I don't see a way to download lava-guest.qcow2. So I just used
>> rootfs and kernel:
>>
>>   /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic,model=virtio,macaddr=DE:AD:BE:EF:66:20 -net user -m 1024 -monitor none -kernel bzImage --append "root=/dev/sda  rootwait console=ttyS0,115200" -hda lkft-console-image-intel-corei7-64-20221019172733.rootfs.ext4 -m 4096 -smp 4 -nographic
>>
>> And I ran perf test inside the guest, which ran fine.
> 
> Running perf test in a loop reproduced the issue after some iterations.

Sorry was distracted a bit. So, this seems to be happening because of
race between amd_pmu_enable_all() and perf event NMI. Something like:

  amd_pmu_enable_all()
  {
      if (!test_bit(idx, cpuc->active_mask))

  --->/* perf NMI entry */
      ...
      x86_pmu_stop() {
          __clear_bit(hwc->idx, cpuc->active_mask);
          cpuc->events[hwc->idx] = NULL;
      }
      ...
  <---/* perf NMI exit */

      amd_pmu_enable_event(cpuc->events[idx]);
  }

Thanks,
Ravi
