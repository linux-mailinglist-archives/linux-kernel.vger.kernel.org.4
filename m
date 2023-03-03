Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC256A90A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCCF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCCFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:55:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61C27983;
        Thu,  2 Mar 2023 21:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffcGP5PeINcJuBJxG46Hn5ZwXnZ3TFLJuNCWSHhQN/f7Vdt/TesAS6rnU9h0vxX58JdCjmBWAhAerrXj3b73olEEqOi9wM9itRBZTKYaC6THi6/mQpGyWWR2/fL/GIPn2A0J3RvoBbk/46x779WPrsYOmIDt5NaNhLFf9kRjL4FGU/jFpyJXO+GFuScLAAQo4/aE1UzpfQpZMikykZAk7ScCuysHUfr7kXfh57WUqFfxd5xWA8BZ4NlH7BIvFVI0Cmd4BuzxpKy3ETLGj9mh16MSDe+p095yiIF7irUX+VPkcMLKgnKET+zJAvLmNIy5oKx2raDtQBuuTSG0odgitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKt/ExPhVdLKYayMxMTMzK+y/ULdyl++afPRZe6MXS0=;
 b=BfsWYLnl/LBWOL1mWAKesQFTq+g4faPfU5E441PZH3Yjc12x86X2AL/ObJo6apXklOACg+EDTIXMweId+BBkwxwncYqGAa7bu6k6nG/OGUj7Rwbz7PJCOFOwUmL3WlI476owQ6970tcxTqsQOku1++GPTwe/YHz9kmsADcRX52z9BhPk/eUQEvcIJnc7KItSfvbeqCFX1+t7d+KzkfK+ZB8ODr7fW09V4iX5/NmdElYT/4xaHbCgr0O+WllCYgt2d/SOSc01nwaFBLRbBXLzRHTrWXh22NpjbXlm3OhmAo/RK6TvQnREvH8wZCSpCgJe8zOzqgsEjWCnG2GPoRSZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKt/ExPhVdLKYayMxMTMzK+y/ULdyl++afPRZe6MXS0=;
 b=rxQFgOK1PAX+/AGVUO+AR3FCJM759hcmlyVYpSc2EKlYwT70dR0b5wIXUAHCcHz0YaoutfhuuIW9Sf6n7hyjDN4Sw5ewjfsD91W7cLGXAToYSSvR++INp8Uk5LDdv8zaTQRVHkSAYacytE7AepOP7N7G3gQUVwPC8YdBBf2Ot/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 05:55:27 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%8]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 05:55:27 +0000
Message-ID: <2075986d-2344-80ff-d494-8bdc97b627d5@amd.com>
Date:   Fri, 3 Mar 2023 11:25:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] perf test: Add selftest to test IBS invocation via
 core pmu events
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230302092109.367-1-ravi.bangoria@amd.com>
 <20230302092109.367-3-ravi.bangoria@amd.com>
 <CAM9d7chQA27aD_mPe=3-9jZLWP_a64ztihuK=upgNL++kMFSNw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chQA27aD_mPe=3-9jZLWP_a64ztihuK=upgNL++kMFSNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3f6850-d39e-415a-0d33-08db1babe328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwRW8jxjEdakZhvMWJmzfTN2W/T5B6bycqVL70AiwoWo3rc9c+hokHu2VmC1MITgG8A3R7wf/hkvpGuebu1uVv+xbWCZTEYiBjNuX46o29YWcPhKOepF0bi/y4DNBEQ1ILadmyXOoHhlIPZfYelrGS9g/ud6RuUWTVpTDs9wQ+PiNwb57Y0bisK6imCBrHNzKouHhIVZLAfjl/b6yb2dW8/K4y1SPpUfNoasfRhQzxUDD/T+pfq1RrQI6/aXZH69ZiyY/U9Ivn/QrTgE8bmq1hrVywqGKl4iliXkFNVpVA9FpO8auhVWQg7XGYP9hfU7fIZxc14R7PrZZ1pcd3qhGOGJ/oh9ZHWGeTNsyiN26qRcaUXAIaaH2l/VlpnwJ13Y9vdryZDljY0LExzK75pC0kqmQSL8Gxfdsy6fIVCbaXBfCs5iYzgDVXuTIVrln2jYOX/RSnM19/IrLcSdK6td37MH54qSLaZcnDqsmgkbMVwdcs9lUd88rQpE88i/1Nz8GtoxgIiayby0vf6Hm/ECBuSsTHZL6WB0chl9rUSUIACFpEa3v6AD+nCmFUljlL08Ohy+X4nRBYIqM4QP51hUmGj1dhyAzplil17fs1pxLT3S/o4/WimwxRIBAn1ZWzAktFHUR+9xOAQJT8OglTx95zT5gcA43UHFybEztjEn0DiIgLS4Zs2P847f8/zjuXw6E8nTwUErq75g86h3jaXFREhtq9ZPy96xBHWsxP2XFro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(7416002)(5660300002)(4744005)(8936002)(36756003)(44832011)(86362001)(31696002)(6666004)(83380400001)(6486002)(2616005)(478600001)(6512007)(6506007)(6916009)(8676002)(66476007)(4326008)(38100700002)(41300700001)(316002)(66946007)(186003)(66556008)(26005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZCS1JnNDdFcWFnbk0xTTk4dnRlNjVuWnBsa0pWNXNTTU9lR2FUajlDdE1Z?=
 =?utf-8?B?bUpoclNTenJDcERySlVSS3VaOGgzVUVCZ3N3TzFPbkZsYUhuVzhVVktzb0Iz?=
 =?utf-8?B?eHBSK0JmNURCSkVxcWc2T21RV1gzZWhOaDBna2VGVU1JdVJtOWl5dmYxRUlX?=
 =?utf-8?B?dG1hL0wvb3BvVDFqS0J4MkQrYUQvYWNrNEdtWjdpdUpzRUVvRThzVTJOVWYw?=
 =?utf-8?B?UWQweHd5Y1ZMQmpIazdhcmhEbE1KcTN5YUM4bnlFYXAzQWZIdTBmNmQ2ZE4z?=
 =?utf-8?B?U1dEUDBjNi9LdW9mbXJyL0cyVGVyZ1EvaUNwNVM5d0xDSldnWElPam1MNjEw?=
 =?utf-8?B?d28zKzI2Ty9wTGNicW5NR1NMOU9wSVU1V0FOODFPLzZjdC94Wk1Zd2JhVkVs?=
 =?utf-8?B?aGVaNUZEM2dLRU1CR3l0MmE1b3BhaFZLVkZJWjUrZldSNS85V3lFVGJ3Z3R6?=
 =?utf-8?B?MTRJT2dFK3crT2crQWYxd1dWUnIwdXdaOHNOSUFBaUNVRzE0YTJ1MlFDQS92?=
 =?utf-8?B?ajZMdnFHUGFveWFCZFpKc3piQkhna0w1clZra0FZRWk1UXY0YnM1TTJSclJ2?=
 =?utf-8?B?ckl1ZmI0MWlaSGFsNFdFd09YeVM4YUJYYXFmTGJhUUVPbHNKaGhzYzlHVzZq?=
 =?utf-8?B?eW1LbHo4bGY5VUxWckludFloZDh0cDVVNUt2RGhEaHM0RjZ1SVFQdEtMdmRr?=
 =?utf-8?B?VHk5eDdrS1BTSjE1cEZHOEx2VjhJL2VqWk85MGlzWXNyeGVrU1IxR3RWdXND?=
 =?utf-8?B?bDJpSnhCUFBIVFJaMDdwZU9mZTdHVDh4QktESXY2Qk5wcWplMVAvWmwrZElL?=
 =?utf-8?B?YXV4Tmhjd2U2MWpFbXczM2gyeDlHUXdRU2pBYnFvcStmTDh5YnNmYmRwT1c4?=
 =?utf-8?B?SUhGbk5ZYjhMeVowRHRGZHgwYlNydVQwdWF5VmJpZU9vQ1pmSDVKa3lWTjMy?=
 =?utf-8?B?UmREQ3NGU2kvM2l1TEZ2Q3QrREwrYVh1NzNpenJKQWlXbFNOOGdoTXZ1YjFy?=
 =?utf-8?B?UnJKKzRqRG0zdkY1NE96b2NXMjU3N2I3QTVQa3lPb3ZnTjZxNTlaN2ZxT0Qx?=
 =?utf-8?B?ZkxmaCtnUldhMFpibEh4d3c1RDdGa1phbVhSWHFzMHFhdm9BT2tQZzAxVW5o?=
 =?utf-8?B?bnd3TWpoaWhLbWpDSDV5aDNBdHFSZk1JV0xRQ0lWRlJkQ0h6eXVadkROTmtY?=
 =?utf-8?B?djdhZjErc3JibndzdEU3V0ZhdU1XR2FIem9XRnpIYllZRVpNc0lPeTdGdkRW?=
 =?utf-8?B?cTVrT3E1SjJGamdFSHJ1R0M2bHlCd2hjVXl0WG9UOERBYXBlaEhkWSs2eDV5?=
 =?utf-8?B?K0l0N0p4ditDY0xOZ1dpekN6R2FpSjkxWFU0TkM1S2tvVVZjUzUyY0pENGlw?=
 =?utf-8?B?WkduYi9XSW82TVgzWGdsaGlsZkVZVUZ2NHlVa09iTHdmeEorRGtRRk9mcnpS?=
 =?utf-8?B?L252Nm5FWUJ2K1FZOFZkQmJTR0hKYUZDQzYzR2VvaVBKdXVucG1oRDdNOWtV?=
 =?utf-8?B?ZXVnZUZnektOdDlyZU9TUWQ4eUI3NWE3N3NOQTJDQUsvRGNZdFg2b2p1VjhE?=
 =?utf-8?B?MnRqQnE2QXQ1cEc1Q28vRWhlSVR4UnhOdm9MNks1RTZDU0ZYK2hua0t3TFoz?=
 =?utf-8?B?dFluUW9LTzZoc2tXT2ZFSVdVaEZWMk1ON0JwQzJ4TS9jYm9wQWVob2ZndVIr?=
 =?utf-8?B?WHZSRzh6Y0NPVG1XSVZGRW5seHBTVVNNOTVRTUY2M1ZlbHZrOHpDVXZxNStP?=
 =?utf-8?B?Zit5U1FCR25URHc3ZXhxSEp4Y0xtajc2QmhVRGM2OFc4ZHRTbWdIdGp0dXNq?=
 =?utf-8?B?Y0ZlemNEeldMc0MxTitDSFgzM3BpMUFaMmZMdCtkMUsybkoxZXkvVmNMb2lQ?=
 =?utf-8?B?OEx6Mzk0ZHpDN2RrSnpKS09DK1lwVnFWQzFmZ2tnV0pYU1NGTFFOSktvSWZH?=
 =?utf-8?B?NzQwUFFxbTZESWJOSzZQYnJ6OElCeGtSV3UzOEp6MW54TzFXblBrcHBVTSt5?=
 =?utf-8?B?SWlteHVLUmtQMWpxY0xoQ2dZZGpTMmdTaElESjVWTkdwVFJYOUtDYmQxYzFL?=
 =?utf-8?B?NVNFWnd2dElMV296c2FIaDNHcHRBb21wVXZWM0c4OGlyYkRNalhwY25FRGo3?=
 =?utf-8?Q?JHjJSk0gAnt+oVugbrc2KkGpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3f6850-d39e-415a-0d33-08db1babe328
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 05:55:27.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JE+mz3SXaNGE+quFi6FoVpxrKzSNagsYKFMGzE74HG1hXg/Ian5oNYN/lnqm3GVa5KHINrzYvGcZHokWZVnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

>> +static int test__ibs_via_core_pmu(struct test_suite *text __maybe_unused,
>> +                                 int subtest __maybe_unused)
>> +{
>> +       struct perf_pmu *ibs_pmu;
>> +       int ret = TEST_OK;
>> +       int fd, i;
>> +
>> +       if (list_empty(&pmus))
>> +               perf_pmu__scan(NULL);
>> +
>> +       ibs_pmu = perf_pmu__find("ibs_op");
>> +       if (!ibs_pmu)
>> +               return TEST_SKIP;
>> +
>> +       for (i = 0; i < NR_SUB_TESTS; i++) {
>> +               fd = event_open(sub_tests[i].type, sub_tests[i].config);
>> +               pr_debug("type: 0x%x, config: 0x%lx, fd: %d  -  ", sub_tests[i].type,
>> +                        sub_tests[i].config, fd);
>> +               if ((sub_tests[i].valid && fd == -1) ||
>> +                   (!sub_tests[i].valid && fd > 0)) {
>> +                       pr_debug("Fail\n");
>> +                       ret = TEST_FAIL;
> 
> You need to close(fd) when it's succeeded for invalid one.

Yup. Will fix it.

Thanks,
Ravi
