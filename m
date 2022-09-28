Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873345ED56B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiI1Gw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiI1Gw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:52:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CE48E96;
        Tue, 27 Sep 2022 23:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZIEt1B2M0izQMxGgXy5HviycwVe5RIdcMOFvNW0HhbB7dKm2ULNOrx6LKVzEuu/av3XmTRnWECAPOmsUFF1k9RH0o+BF8yMDOqTn22+9PXiLufkMZFYgwFkf8hLooJUY6muCYxNqbmXSkHLko2zyoP8tntKYg0zPYkz1LPROMtkYKI/+92nVrPUYcdGIzW58Z1tmlGJkDoIrP6eEnN2zxYI9MjiABtkf44dGTcqlNUbeeLwFZ0FfpUL0FwoaZavWXegtSJdmd0yBftPtuM5GYkeqyAeuusFJGZFvSBupzCwX0QQ7utaAiYcTgZA+SN6DQhxx3p02gaJROcYKWmoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzCGSg7WHskMIZWexZjRHkHNDGnM8fdzryLyFcL0mtQ=;
 b=RGImwpghj01mFv1bOGOFCFGMgTXT3fzHn6UCDgdAG/WWicbU2GUnaNUrG64WMtI47+OXrEZVfpv98iFMQTMQXY07Q8NWFe89QZbsmv80wlpj46UzW0KQlv3swNqSGPO5Umz9wbjBzne3iw8fWho7pceyXTI9n3t5iLiqBtH5O5WbjXp0eZ/SrFbKISAj2P5DVZ8PxpV8PyDhjH3OFzgJL4LwUsVDzGkeSi/4mV/E5j9nLVLErDggObbOdTXULzk1/Pp4W56AOo8uW6DuGS/LbLVOTAmU4Ni+2oi3wiZ2R1667l+joo9MeXLw+DNnOt5o59+KZAPGhesl8BMqbxEjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzCGSg7WHskMIZWexZjRHkHNDGnM8fdzryLyFcL0mtQ=;
 b=Q5e3jjHESiWYPDDMNMcrOgw0P/XcqvZYZQHOKciaPyx/woWjrsAoOQ+Y86UwQNiZHESM8rdO+mdBCdH+1xyriW5L8VHir8RzKUdaysxmpx8Wcq1N+j6JPXWdpZF0z+Bh/YQrCvEjqo9hWVzFYHdTuSGSdJXL+ygBCNiBJCL0LhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8927.eurprd04.prod.outlook.com (2603:10a6:102:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:49:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 06:49:54 +0000
Message-ID: <c61c5eae-105b-2a79-c1c0-57cd5bfea4f9@oss.nxp.com>
Date:   Wed, 28 Sep 2022 14:49:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <20220705011527.2849057-3-peng.fan@oss.nxp.com>
 <20220926220610.GA2817947@p14s>
 <DU0PR04MB941767AEDD07DBA7E7FF9B6E88559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <6aae3d16-0570-793d-4bf8-0a0fddb00be9@foss.st.com>
 <20220927174438.GA2883698@p14s>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220927174438.GA2883698@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 874701cd-1814-4890-9147-08daa11da633
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoHaJYNUd4qJJI5BxwiH0ilJE/NQsiXGbi2vOkVoNng73ahYc+X/ORH3dvM9KhbIozg2U0mlUbHNkG0SVunxP1AoaT+66CtNyDC2yiceuUlPftZ1NbVwbZXCbANTUY3468ujVUDgIWL5VMUL60cg4RWF3D/0trjAlZ+XKY1MJvqBsal1tzO+z74R9EXoaxhaEu9ZYuqDR1jAP1INQfOmyYcZM1OaIxrEo47NN60OYu7ELbLedPl5cOOw+rs28t3QSqjX4VXixaST/dc1s/txav4tpYjKVSh/+HXAUCcc8uht54bzPsgu5lXYIrH7rnC9O5Y7SfQGDsLOLgYYf9hj65jAexwG72JaFEi2DStqsLJkhD0MIrits7GQJNb0e6Onb3saNsMAQzI2zTG0TCq/scG7eHPiPyohVc8WbFacNcx5dbmQ87+toLybySUF1JSL1ttVe7/siKz29jNknaM/hnJy5WTUL+0jAkFjSmt77ZyLtoQ3UXjm6ox1gilyGeDaSl2G8KhMFhJLuiUpNp+G9Huo5900AXt1lEecOtKxvZko4/6sDvL3V91IVwQF+vCt1APYAolu0hzQFisZIv1S4ZMCFmvrNPIpzOImGO0nwHPhfKQ3H2fjynoN40nGMqrxvNgqRMhkYe4uxBQ3I22R7cMLVujrf4wo0VysZB3AJQsBiiuSH/BJzm/8Q16m8umqhM9WB6Q9E85Mh8u0QgxhV2muufuyDAVhyjbiKN1K6BWaNMwWLh6ulhFke87pMGWRj41ItYH0JvS5K7YSmPebkM5lXk5FdcDZfyZ3vqwH0E4OVg6xg+HN/UeHwwn1Bv0a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(478600001)(41300700001)(52116002)(53546011)(4326008)(8676002)(66556008)(66476007)(66946007)(83380400001)(6666004)(6506007)(38100700002)(38350700002)(8936002)(5660300002)(54906003)(110136005)(6486002)(2906002)(31696002)(44832011)(316002)(86362001)(186003)(31686004)(66899015)(2616005)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck43dzNNTlhJY2R2ZjA0NWE2R2l5bWJzaHZHNmN0QUZKeGd1UGhTNnF4ZmdU?=
 =?utf-8?B?VzkycmQxZGhia1hGQW83U05TWnp3N1A2TnV0eTBJVWZHM3VVMXVtRElXQjNU?=
 =?utf-8?B?RVNsaWpxOEFHR3hKdTdMWWFuQmdlVkpSR3dSM05aM0FVRnpCL2Q3NGYrazJL?=
 =?utf-8?B?M0NNQkQ4NmlXVUpGNitQSEc1QUxzL3hQc0xqcXhqRkw0dkszUzgvWU5zZ1JS?=
 =?utf-8?B?YnFGZU42eFZPQ1RyZjRJcVUxdnhTbXJYeEFNc3RQNDM5SnVRbkFXNFk0UWJK?=
 =?utf-8?B?blB6V1JCbHViM2dNOFNrblF2bHo5L1g4RU0vcEwyV2F3WUZDTUN2d0M0ME5i?=
 =?utf-8?B?TVJFY09OUmZLVTd0SGtSOFFTd3h5TWJUdkY1TlN5YmU0TGFQck1QYlRoT1ZD?=
 =?utf-8?B?WDBTb2VIdUI0ckpDN0FMUURlMk56bXdaOTV3S3FsZlpBK09xRGUrMmlXUW9U?=
 =?utf-8?B?MlUrVGQwdE1HRVROSjFZZFdycW1nNG9icmk5MU5uRmRLQjhrVjhBK2VSbXln?=
 =?utf-8?B?S3hrRTBXMERBSURuTCs5TVlYNFZoSFpEYWlVNkR4WGlkdVNzakJidFNoZ2oy?=
 =?utf-8?B?TXA5ejFQM05ubDI3STZDSnZRVVE1Q25VZ2FWZ1pBREUvbUtsTDNmQ0RhazJo?=
 =?utf-8?B?T2xHL0M5RGFHblBoMTBwWmJrbnNHazE0YVJtNDFwRHV0TXRVSGFZTlpSV2pt?=
 =?utf-8?B?a1JKS3lPcUp4NENiZ0ZxN3RJS0hWTHc3U0NVNmNMVW15Y2FPTFRBbFdOM0tB?=
 =?utf-8?B?ZGF3cFpUUFkxcStBM2VXaXViYm1aS2ZPakpHOWt3a2NBZHhFS2ZkVGdnVDJI?=
 =?utf-8?B?SnpSTGFhQ0lFQnRoU0ZkZ1FDRlNQeHVxM0JycFdoSFRUSWZOcFJxQWpLaW1H?=
 =?utf-8?B?R1hrTEp1YVFMQ08zYlZzcEE4SzcxNko2U2twdkYydll1ZzJUdWxCdEJ5ZTlk?=
 =?utf-8?B?S21EUFVJQW5XYU1VYitrZEpuSm1NcE1CZmdqR1luZkl0MGFnck1OdkJpb2FS?=
 =?utf-8?B?WkNDakdRN3ZqWnJ6OHBKRGRPRFpJcmV6N0tMbTdVRGx0ODhvTFYvQnZWWVpn?=
 =?utf-8?B?Q21LbzJybjhBY0xUeTNUQlRicVNlU2VvdldjUU5vZmFqNDNzS2VnK3QrZEpL?=
 =?utf-8?B?M2t3QklUZ3ZCSkZXTlJtc0lZK3UvZmhqems1cVhiTSt1NVJLSThJRTdHRDNn?=
 =?utf-8?B?TDZrTjVETzc5T1EzK1hhUDJ5RndDTnhqRVR4NThNQnozYWVZbHVrQTZMRDRJ?=
 =?utf-8?B?NU8vRmJmRkE1dkxjOTJ2SDczWm5ySU1CdjYxS2Iyd3YvR000MG0yVFJzb0kz?=
 =?utf-8?B?ajlyaDJPWFFDUC9HS3FEMng1SERvVTIzYzFCLzZLUy9MZUxnU3dFMy9Xd1BD?=
 =?utf-8?B?ajZ3NjJIeXJKRnZCSVJRS2REeHgzY2lOL3Y3R01kZzFXY29CbHcxWktIZ2FQ?=
 =?utf-8?B?cnpJcVk1VXNNUHdUSExmR2NWREFuaXVMc0FLQ2RQNTJwbElQNjlNNHR0L2k4?=
 =?utf-8?B?bC9tVUZrRHNjRU5hQjVmMlJCL1VkU2gvN0haekxHellON09xMG9sTXIwQTF5?=
 =?utf-8?B?NE9JMk9FeTIrLzFaa3UwU2xQb3dFN3ZQN3RoaWV3aW82WHhkZEFwRXdRcHNm?=
 =?utf-8?B?N1BqU3EwRHpEOGJRalJGN0U2WHVDODZEbEhYRGpXNWdlK0FXOUVEQkNNZ1Ja?=
 =?utf-8?B?c1FldWh3RmVHcUFhQldLZWZOTHZxRXlXV2ZNOGhBNUJyVStmZjhLMVR2VERQ?=
 =?utf-8?B?NlFxV1UrTW5LQWlPL1JMSGxrekNsU0w3cGtMc25qcndTK3BLb3RFMVdnQVQv?=
 =?utf-8?B?TVIyamVQeUFQVjR6L3doTHJ5T0tTLzJLYU1FZmdJL3h1UWlGZkdjYkJjaFoy?=
 =?utf-8?B?Z3ZGN2thMWdVN2h2NFpmU0lsazlHelV0a1Q0UEpWNW5Za2FoZDVYckU4Nngv?=
 =?utf-8?B?Q0tFbjk1dGFLVGtVck8reFZWZ2pRak9xMHYxRDNKQWFOdTlFUHZ5dm5MVzU5?=
 =?utf-8?B?SGQ5cEdPalNhL2I3NVEyZDNXU3ZHQ3NzdnRoWTZod2srNjhUZDMxSDZDeEEr?=
 =?utf-8?B?WklYUndJU1Z5MmZKUkhZNTNhN1lubnB6Q0krZCtxbnlVRERvMCtJeXpTVzJH?=
 =?utf-8?Q?F+Na9duXrHpqHqWyLZlkAuwA2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874701cd-1814-4890-9147-08daa11da633
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:49:54.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VytRUVYnV9DiUuMC34ZYKqX5e3eEpRJQqTo//jv0j2+4BWtYjNt4BFDI+IbPCr0as0E9DlNKWV9Ic6rOhXQXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8927
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 1:44 AM, Mathieu Poirier wrote:
> On Tue, Sep 27, 2022 at 10:10:31AM +0200, Arnaud POULIQUEN wrote:
>> Hi,
>>
>> On 9/27/22 05:03, Peng Fan wrote:
>>> Hi Mathieu,
>>>
>>>> Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
>>>> crash
>>>>
>>>> On Tue, Jul 05, 2022 at 09:15:27AM +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Current logic only support main processor to stop/start the remote
>>>>> processor after crash. However to SoC, such as i.MX8QM/QXP, the remote
>>>>> processor could do attach recovery after crash and trigger watchdog to
>>>>> reboot itself. It does not need main processor to load image, or
>>>>> stop/start remote processor.
>>>>>
>>>>> Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
>>>>> for the two cases. Boot recovery is as before, let main processor to
>>>>> help recovery, while attach recovery is to recover itself without help.
>>>>> To attach recovery, we only do detach and attach.
>>>>>
>>>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>   drivers/remoteproc/remoteproc_core.c | 62
>>>>> +++++++++++++++++++---------
>>>>>   1 file changed, 43 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>> index ed374c8bf14a..ef5b9310bc83 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
>>>>>   	return 0;
>>>>>   }
>>>>>
>>>>> +static int rproc_attach_recovery(struct rproc *rproc) {
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = __rproc_detach(rproc);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>
>>>> I thought there was a specific reason to _not_ call rproc->ops->coredump()
>>>> for processors that have been attached to but looking at the STM32 and
>>>> IMX_DSP now, it would seem logical to do so.  Am I missing something?
>>>
>>> ATTACH RECOVERY is to support recovery without help from Linux,
>>>
>>> STM32 and IMX_DSP, both require linux to load image and start remote
>>> core. So the two cases should not enable feature:
>>> RPROC_FEAT_ATTACH_ON_RECOVERY
>>>
>>> Also considering the recovery is out of linux control, actually when linux
>>> start dump, remote core may already recovered.
>>
>> I asked myself the same question. Indeed how to manage a core dump if the
>> remote processor restarts autonomously.
>> The answer doesn't seem obvious because it seems to be platform specific.
>>
>> For time being on STM32 we consider that the remoteproc memory can be corrupted
>> so we don't plan to enable the feature by default even if the hardware allows it.
>>
>> If we implement it, I would see 2 use cases:
>> - no core dump, the remote processor restart autonomously (need to manage the
>> VIRTIO_CONFIG_S_NEEDS_RESET in resource table vdev for resynchronization)
>> - core dump and the Linux stm32 driver handle the reset of the remote
>> processor core to be able to perform the core dump (no firmware loading)
>>
>> What about dealing with the coredump in a separate thread, based on a concrete
>> use case/need?
> 
> Definitely, we can deal with that later.
> 
> Peng - please send me a rebase as quickly as possible.

Mathieu,

Just send out V8 rebased on linux-next/master tag: next-20220927

Thanks,
Peng.
> 
>>
>> Regards,
>> Arnaud
>>   
>>>
>>>>
>>>> And this set will need a rebase.
>>>
>>> I'll do the rebase and send V8 if the upper explanation could eliminate
>>> your concern.
>>>
>>> Thanks,
>>> Peng.
>>>
>>>>
>>>> Thanks,
>>>> Mathieu
>>>>
>>>>> +
>>>>> +	return __rproc_attach(rproc);
>>>>> +}
>>>>> +
>>>>> +static int rproc_boot_recovery(struct rproc *rproc) {
>>>>> +	const struct firmware *firmware_p;
>>>>> +	struct device *dev = &rproc->dev;
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = rproc_stop(rproc, true);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	/* generate coredump */
>>>>> +	rproc->ops->coredump(rproc);
>>>>> +
>>>>> +	/* load firmware */
>>>>> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(dev, "request_firmware failed: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	/* boot the remote processor up again */
>>>>> +	ret = rproc_start(rproc, firmware_p);
>>>>> +
>>>>> +	release_firmware(firmware_p);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * rproc_trigger_recovery() - recover a remoteproc
>>>>>    * @rproc: the remote processor
>>>>> @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
>>>>>    */
>>>>>   int rproc_trigger_recovery(struct rproc *rproc)  {
>>>>> -	const struct firmware *firmware_p;
>>>>>   	struct device *dev = &rproc->dev;
>>>>>   	int ret;
>>>>>
>>>>> @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc
>>>>> *rproc)
>>>>>
>>>>>   	dev_err(dev, "recovering %s\n", rproc->name);
>>>>>
>>>>> -	ret = rproc_stop(rproc, true);
>>>>> -	if (ret)
>>>>> -		goto unlock_mutex;
>>>>> -
>>>>> -	/* generate coredump */
>>>>> -	rproc->ops->coredump(rproc);
>>>>> -
>>>>> -	/* load firmware */
>>>>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>>>> -	if (ret < 0) {
>>>>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
>>>>> -		goto unlock_mutex;
>>>>> -	}
>>>>> -
>>>>> -	/* boot the remote processor up again */
>>>>> -	ret = rproc_start(rproc, firmware_p);
>>>>> -
>>>>> -	release_firmware(firmware_p);
>>>>> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
>>>>> +		ret = rproc_attach_recovery(rproc);
>>>>> +	else
>>>>> +		ret = rproc_boot_recovery(rproc);
>>>>>
>>>>>   unlock_mutex:
>>>>>   	mutex_unlock(&rproc->lock);
>>>>> --
>>>>> 2.25.1
>>>>>
