Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D206FAB5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEHLM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjEHLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:12:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDF1E988;
        Mon,  8 May 2023 04:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj1i0Ngu8mJtgoQtXEhVAWXlPbCfeRVKO/2/QkGz15bNhpLW9G2iAoIBFsgtItGA6dAW3v9Tm6jagYttdza2BgLTPxfdA3zf7quzIcMwyJRgV4CDpqdzXswAUXUEJTeQgE0hTFi3g4e7LBgndIOhzw7HfRIkeiW5YQtgyhNilFbImET42f+ZlfaBhNxO021milvqr47MENJTzs1a5qP/z20B2j3/8AK6huGc+ucFl3j3S/3MLe1VL+zaerme/lST46oYQPpfOGOgauFuXga31tCd9y6iy2oSBWRTX2/HIb3joKkJu+47Ym2m8pO2Q95M+3hyecXEeUB9zbwSusJoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R4XJGajEbMpeZrvNsGENsapiH4kntdJzyvouTQpIoo=;
 b=JSMM8U5OZTP2IQ6Y33a41SK2eXTtt2nkNQrxK3PMNQqOuKX1EySov2RHZ+KuZdSZ2AI2rAQCtf74hTQH6257yEeDHXfrXGjD3HM6g4WAvtJIfw6z6eQ644m+qpauJITrxbPntecgk2tKyJLtak/qPHasfgESRujfttwOYJCGIAAfGnTggNZPV6Nryf7fCNk1X4TvD+z9lxsxTnzhohuiOBVkuaLjczJ/m2TZbmn0fX2wdmkAXHe745MyC2VT0pRBvLE9O+pn9tWaEfH1+6qC4zAhRgJJ81daPmL2EKg077qmv4gRbFp7KQJpuBDb1RtMqhViTfeH6tRrnJGZbi59Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R4XJGajEbMpeZrvNsGENsapiH4kntdJzyvouTQpIoo=;
 b=m+BqXUCvI2mu8tKrIhlHZISb64C2gmPolDKpRjRy1L2Sf5I8+Tub3gfChvHj+IZtkVHXhDL2cJ34KUFYeIOS6WqlwThesMgHojkqWF32lz19LilWZnRn4tJSIoAVAo7MhbYZm6iXCoRNqM/New+7zzCiU3xf2w9C+rqY+YfVIJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:12:17 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::f9ed:3271:cc0a:9db3]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::f9ed:3271:cc0a:9db3%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:12:17 +0000
Message-ID: <b43b203d-5759-0c33-8587-4e84025552d7@amd.com>
Date:   Mon, 8 May 2023 16:42:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] tee: amdtee: Add return_origin to 'struct
 tee_cmd_load_ta'
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Dabros <jsd@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        stable@vger.kernel.org, Sourabh Das <sourabh.das@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>
References: <6a25613e87158947b4d102be4859f406edcb3f0b.1683008188.git.Rijo-john.Thomas@amd.com>
 <CAHUa44Gm5jmm=mEfowcmabaoWFFbCLiDd5NdPSArCPHsjcpOBw@mail.gmail.com>
Content-Language: en-US
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <CAHUa44Gm5jmm=mEfowcmabaoWFFbCLiDd5NdPSArCPHsjcpOBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::16) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ce441a-0aa4-4fb3-bc7a-08db4fb515a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgM0FoiUTCgTXPjDIHZWT1IaPDxK1c1Z2ZNjU+V0vA6SAy/tJ0GT6Mdw3liJgYxn3vS6tNnsn8X39fu7Exq02OHWqswMDqvdb+4Oy9a1qAPazYvk9u5tPvsakvJZ4Z6ASAgoKj2HBPw1F33422cUVfE+C4XBHiNtxx/4aNeUlVz5Ruk7mXwDOEJxVWhSmgFUP1Rf9o46ROKu9rCdgU6aBzL5t886RoG+ZnY4+pdL3Bvrf6am9L6FgpJzFHrmxB+KZNZudBay/bH5kVe5J94X0nu5b0eV99ineSqHrbOCmHqg9/LOn8GYVb74WMcB+Gzc0tj7J95T3mrWjCpbJBov6jY3u52mOdy8fxl02mSKgr+6CK4NW4K9jvnK76HaDsSgdxJRj6jyTUToU/2HOD/tQK9khOLqIWR7qcL/cLscZNX56O26TbWWcybBAgsucQPmkDLzA1UmmDPBMILcJL9L28KFw2sBSo+yNHA4BMdBgRMhNTKaUb7+Md2pJqEDIRjDVjvRoxr+IEemUexzet2FSLSw/FxiW7DRpfE05Zv//fny6zlyN/pu87JNpnX92yF+N+W1Qd2StdmB+d9YRXyLo/FUX5VAgRv4frNoZMlogPrJHdN4JMSsxb2We3JZVtdE4ztNenHp+/CMoiANzsP46Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(86362001)(36756003)(31696002)(6666004)(316002)(54906003)(66556008)(66476007)(6916009)(4326008)(6486002)(66946007)(478600001)(5660300002)(8676002)(2906002)(8936002)(41300700001)(38100700002)(186003)(53546011)(6506007)(6512007)(26005)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVJSS96TGJ1QXVBY3lEd2ttSEdWQlBYYmExUkdTd2lwa3dESklBNW5zSHdC?=
 =?utf-8?B?UUdneWNMVzllSE1FdWQ5Mms3N2JweVBlS1RBWFhoYWxnWkFBVFdGTGM4L2ln?=
 =?utf-8?B?bit3emJCNHdGSXhPYUtPcnFiNHY3VWl6VzF5Qmp5MEVMSm42dVBiNm5Sa1B4?=
 =?utf-8?B?a3U5T0N1aDBGamFJbjJMSm10dURySHNXLzJac1dQM1dIYXAxbnhhVjE0WElO?=
 =?utf-8?B?Y0FrTkZDWk5RbHdRV1VBMFJlYUdXNDM0S0plTUlROTlEa2xrdVJMSnYySkFi?=
 =?utf-8?B?aTBtT0lRU0U4TkMzdUtUSWlBVkliSS8yL3BtdGJNbHM5djZCMTk5NzNTK3ZG?=
 =?utf-8?B?QVZCQnovMjd3QlpuVWJhNVJLaG5YNFVGOXZpRC80UkovRkxyWEdlbWRlL1Iz?=
 =?utf-8?B?bXFaVVFlRDRCaUpMdTdVSHlzVTRlb3JZa2lOY0FhK1FiYldtRm1jREg5MzVy?=
 =?utf-8?B?MzJNc0E2ei83MkFkQXQzenhleDVkWi9RVE1odVowaU5uVEplaTZnOHhCZll5?=
 =?utf-8?B?T2NYQ3UwRDJoUExtMlQyc1lHampUb1VOYXNERHFrUDFGWEhpU21VMW1aK04z?=
 =?utf-8?B?SWFWS2V2WUpsYy9XN0V1ZW02dDlneENuQnZQRG9XSnQydWwxUUcrSzV6T0tE?=
 =?utf-8?B?b2xjTS9KV1o5SUxXOERQbEUvMHVyZnk2cFF3blpZNHdBZWZxZDU5NTdEZURF?=
 =?utf-8?B?VWMvUlorVEdqNjRMS0xEMGFUc1JmTWw2YnpNejRzSk5PUGtFcTJsNmJjaVpj?=
 =?utf-8?B?QWJMMnRwUVFLejllK3h2TzN3NDByZE05Y1BwVml6OURyNGZQQzg1Tkk3UFNJ?=
 =?utf-8?B?dGpCelAxU1NRdDhYVzJFSjQ2MFlEL0JlK3IvOWZaNFZ3dEk1em44eXkrMFh4?=
 =?utf-8?B?bEtMN1AwVUpIVnJNOWxmMFRINys2UFVIRVVPSjVtR2E5Y2NCU2REMVllTUVD?=
 =?utf-8?B?OGp1akZZVDhOYy9UT1NGeFA0OVEvQ2sxb1lyUFliOGFITmtKa3Z3bE9Zczhh?=
 =?utf-8?B?T05EVEFqSWhvbzh0V3N4eDRkYjU0YUpYTkcySk1VR0hoeXRYamxBUHRUc1Ix?=
 =?utf-8?B?RXNOOERFOUF3M3RHYk1oK2xGdkdEUU4xZU1ZSGpIeUp4V3hjeUFER1JOa1E1?=
 =?utf-8?B?amhtcmh5YXpXNk5ZeGdZWkVLQnVwWmQ2THh5Q0lSUW00RnFKRXNtd2J1Yll0?=
 =?utf-8?B?NmhEekRvZjRPMlpCSjRzaHhHVlNGaEdxOWtFQWNZWG5xVHhWKys5ZDU5b3Zp?=
 =?utf-8?B?NTEvSlg5anpHMldTWDVWQTVYeHUzT1o0dHRyRjlJeVlZZm9VQVBWb3lWQTdj?=
 =?utf-8?B?OW5tSi8yNE5OOHJDMVhWdTdneEUzL1U2UHBxMTI4bWk1MzMxMXZvcjUrZ2FQ?=
 =?utf-8?B?TnF3bjJMcVJzSEsvREtpVE5sRHBIVjhtc2x0cXlXcVhxMFJaN05xV2hmNEpB?=
 =?utf-8?B?NzVYc2hWWGxYMXFNQmZsQzk2alhFenZvQ1IyQm5INEhTUnBoMFk0djdSQmZv?=
 =?utf-8?B?azYzcENDc3pZZytMM1FNUUZtTjZXRC9Hek5zczNRSW1uWERhZHRJcy9LdUQr?=
 =?utf-8?B?dVdhWEJyenN0UnNtUXVRMFpZSE9MT2pNZGl1ZHlLMlhISzM5cTlRem93TElO?=
 =?utf-8?B?dU1PbnJwaXR5VXhXaG0zWStmQm9FK1ZjRzh6Tk5RVyt5WFNuQ1MwZzlMQmZB?=
 =?utf-8?B?WkhnS0RmbGl2a3VSY3FvNmFGTU0xcHJCSXB1a3ZSMmI2THdTYWhiYlh4cFBj?=
 =?utf-8?B?aWptZWlQWTcyRUtIbzM2S3Q3WnpXZXBpSHJ6Sy9EMWQvM0IxbnJHOVRrczFh?=
 =?utf-8?B?QzdJZnh2bE9OdmZuZHpieEFqUEcrc0RVUkIyY0k4NU8rVXJaZmNYeTJXZlZy?=
 =?utf-8?B?c3pKRDl3alBFUjVlZFJyOHNwY2tDdU5aMUVwWDJNenFDbjkwa0pOU1l4OXVt?=
 =?utf-8?B?TnQzVlhobUZBT29hWVZpcENJVngvcXU5RHRqZlFrZFMrdjBDYzN5eTV3RUN4?=
 =?utf-8?B?Tm90SzNDR0hNL3ZraWE0VnNqYm9rdkhTaVFpUGpHbmxRVjNrKzNFNjV0OFYv?=
 =?utf-8?B?clZVNW4zTUxPeWtNbW5TSGpPRlJGckZ1SWpDZlNjSE52bytsbDN1U1RqWXN2?=
 =?utf-8?Q?H7hLaHuXjg/Tm6RVX22zwy2u3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ce441a-0aa4-4fb3-bc7a-08db4fb515a0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:12:17.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sazGAcbESenxZu7t8A8/p1tD27bveCpVLNtqsDvEdeAxDxzr/Wm87zRoD8u7eL8rriXeWywsuCjz33OdMfskHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2023 1:00 PM, Jens Wiklander wrote:
> Hi,
> 
> On Tue, May 2, 2023 at 8:25 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>> After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
>> value in 'return_origin' argument passed by open_session() call. To do
>> so, add 'return_origin' field to the structure tee_cmd_load_ta. The
>> Trusted OS shall update return_origin as part of TEE processing.
>>
>> This change to 'struct tee_cmd_load_ta' interface requires a similar update
>> in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.
> 
> This is an ABI change, but it's not clear if it's an incompatible ABI
> change or not. What happens if the AMD-TEE Trusted OS isn't updated?
> 

If AMD-TEE Trusted OS isn't updated, load_cmd.return_origin value will be 0.

load_cmd.return_origin will have non-zero value only if AMD-TEE Trusted OS on
the platform has the necessary ABI change.

At present, without this patch, arg->ret_origin is 0 and even with this patch
it will be 0 unless AMD-TEE Trusted OS on the platform has the ABI update. So,
this is not an incompatible ABI change.

>>
>> This patch has been verified on Phoenix Birman setup. On older APUs,
>> return_origin value will be 0.
> 
> Why, because MD-TEE Trusted OS will not be updated on the older APUs?
> 

Yes, that's correct - older APUs will not have updated AMD-TEE Trusted OS.

>>
>> Cc: stable@vger.kernel.org
> 
> Which stable kernels are you targeting? A Fixes tag might answer that.
> 

Okay, I will add a Fixes tag and post v2 patch.

Thanks,
Rijo

> Thanks,
> Jens
> 
>> Tested-by: Sourabh Das <sourabh.das@amd.com>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
>>  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
>>  2 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
>> index ff48c3e47375..e2014e21530a 100644
>> --- a/drivers/tee/amdtee/amdtee_if.h
>> +++ b/drivers/tee/amdtee/amdtee_if.h
>> @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
>>
>>  /**
>>   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
>> - * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
>> - * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
>> - * @size:        [in] size of TA binary in bytes
>> - * @ta_handle:   [out] return handle of the loaded TA
>> + * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
>> + * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
>> + * @size:           [in] size of TA binary in bytes
>> + * @ta_handle:      [out] return handle of the loaded TA
>> + * @return_origin:  [out] origin of return code after TEE processing
>>   */
>>  struct tee_cmd_load_ta {
>>         u32 low_addr;
>>         u32 hi_addr;
>>         u32 size;
>>         u32 ta_handle;
>> +       u32 return_origin;
>>  };
>>
>>  /**
>> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
>> index e8cd9aaa3467..e9b63dcb3194 100644
>> --- a/drivers/tee/amdtee/call.c
>> +++ b/drivers/tee/amdtee/call.c
>> @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>>         if (ret) {
>>                 arg->ret_origin = TEEC_ORIGIN_COMMS;
>>                 arg->ret = TEEC_ERROR_COMMUNICATION;
>> -       } else if (arg->ret == TEEC_SUCCESS) {
>> -               ret = get_ta_refcount(load_cmd.ta_handle);
>> -               if (!ret) {
>> -                       arg->ret_origin = TEEC_ORIGIN_COMMS;
>> -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
>> -
>> -                       /* Unload the TA on error */
>> -                       unload_cmd.ta_handle = load_cmd.ta_handle;
>> -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
>> -                                           (void *)&unload_cmd,
>> -                                           sizeof(unload_cmd), &ret);
>> -               } else {
>> -                       set_session_id(load_cmd.ta_handle, 0, &arg->session);
>> +       } else {
>> +               arg->ret_origin = load_cmd.return_origin;
>> +
>> +               if (arg->ret == TEEC_SUCCESS) {
>> +                       ret = get_ta_refcount(load_cmd.ta_handle);
>> +                       if (!ret) {
>> +                               arg->ret_origin = TEEC_ORIGIN_COMMS;
>> +                               arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
>> +
>> +                               /* Unload the TA on error */
>> +                               unload_cmd.ta_handle = load_cmd.ta_handle;
>> +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
>> +                                                   (void *)&unload_cmd,
>> +                                                   sizeof(unload_cmd), &ret);
>> +                       } else {
>> +                               set_session_id(load_cmd.ta_handle, 0, &arg->session);
>> +                       }
>>                 }
>>         }
>>         mutex_unlock(&ta_refcount_mutex);
>> --
>> 2.25.1
>>
