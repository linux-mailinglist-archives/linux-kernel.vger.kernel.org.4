Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C466CEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjAPSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjAPSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:31:33 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056031A484;
        Mon, 16 Jan 2023 10:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEhGk8vPCpLeDRWmo4IqN/HWYfM4XgxeuWF3mCu/rqUHs0rR7/NXfd3ob+92Rk7X91qZUCNUvCOXVTE+NtfOnwq4X48vlLpoJMYMsJ4BeKOgiYy9/blQzhDQ3fn+RbO3hFqM6sKzsXrFaxF33rBpmJ651aYvNdwzBJVU+dGv4vTbNu9kBGhgj0DEIz7XG/Iwomv/Mq0V3sacxD6YvFr1/nId87SxSW9O0CjqSoEIuvVYuRx3Z7Cust5JKq5pH3MMP5d3Vp9olkYUrNkTqGcx6M1RjKCePPz69qEdrD1tFWdoQw1pKktyz0YyLSkh7PAdTksjVsIANWSyQG4nE1x5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAfzsRVznS77LQeGD6ZPfuvE0fDr86Etk8UIxtib83g=;
 b=VjH0VbmFFo3e4/Fk07XsGFMplLZL/4Tl4emVVYYR7qQzXuTntpYIUSMscrPdCZs4jh4Fhjllzx0nRxAIToSZckoxv4vxgKzIP9YFP6voSe3rYcAjs2GyH5AB4V8vyyITV1ZSDR9NgvkTim7iUtLrou/w9Qb2PXz0Cosgq2i1URIMKEx+Sr+HduFTkQ39HhNXXLJa3Ytb8RGjH/wfcQIUcOn1giaeW+nwPsnlmzV0w/b7RscDZwRTkAp3nd04JzaL5+FTfB7rNWdMI5hF64elnHhKrTnKEePvMmECQePlYOneM6D5RAUbgE8w8g5qkon7yBJdpnzEJe5W/mjNePvn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAfzsRVznS77LQeGD6ZPfuvE0fDr86Etk8UIxtib83g=;
 b=UgNDnsAf/cI23V48ydwM8MRP2NJ8AThBzALksviLJwkgLTNz8O3xELpS1fZ5sRcV0h1/IsLaMliOr8PXWFJBMo8w+7Uy5gKhfaAlJSCbD7jCGrib4OHqB1Ut1tR2VGCjMysjNe/vXO24VrYOTwoEaMCgEiE/j5cc6gjRNQRE+vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 18:17:45 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 18:17:45 +0000
Message-ID: <42c34b1a-3ea6-350a-86fe-89f93f32e893@amd.com>
Date:   Mon, 16 Jan 2023 10:17:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
 <e675a037-3c07-a8bb-19d4-781ab881c920@amd.com>
 <39b55b55-b0fd-95fc-5f68-e00cd20f076d@linaro.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <39b55b55-b0fd-95fc-5f68-e00cd20f076d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH0PR12MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f5808c-028f-4740-04f7-08daf7edf701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLmLYJcDQpEQWGTHfu7VR0exnVSCi0PnviVgLAxpz2OrFrWpG7xzoCh/gf4xacwuPxTU3PhWdwOL9i9fyn4LiJmTnO28jR5s7ZfPeL+DAi1v2h51BK2VMX72motmNWE3wRaFO02XjhdelMtNf/vxRppiGTT01/a4VwOuToWoIQD2plpcDFPDr1AgFygGiFhXNzDg2pZJ0HUXHLmDie+J3v4wO7/9/wgzHPyzVoCjSDIu7i2YI4O5ptKsPUeCgyQ91b/605SPL7CSWWKbIXcPdeg/M8A2CQCna5MzKcWCif6B6h8CQaC+eHOCAZCoYHDwg+aCCoc6zpTsuFy9QP946JdrLy1Zihs4vV/OAba2gNlJVhQR10QrZPXljmXB5FC+MjZ4tOfwHhk/KcOWoyEyzuUxLJXE4/5ubLQVqYEYeQpO5ZEvdmkVMAh4WFsUnY7RXAE6XodlpWfs/ZjUUvty2z5DNy8TDFhhBzj0vZCa4jVNdJ6JXwxS0obKdOZmYZduRXpepjHGFKJgjoY6EjqbTKnDp9Uv76QQpXEPOJ7SdDo/GENzBo5k8W4cSgFhRUV5uqHPhLoEGHSdEjPqhv2yLrMKuEuR3KDYfNXV7ZANvtH8jjMQdvtD5yqEIEmUZwXaqJa5hAJlAvXirQ+dxK/du4Ikq0Kc7ufX2Vu0Rrj1aZnetg2VSUOKEhIINqsKXLtzZUcn4tcmZNSklKxtDepn20pUDl9dd+r5iAH4n43NkSlp2D54mN5Hfts3fHVfOhpxYZXYldS4Hhbye2YcKLrERHqnP8YchjqcDRZn0oHAtgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(6506007)(36756003)(53546011)(6512007)(6666004)(186003)(966005)(6486002)(38100700002)(478600001)(31696002)(83380400001)(2616005)(66899015)(5660300002)(8936002)(31686004)(66946007)(66556008)(4326008)(2906002)(66476007)(316002)(8676002)(110136005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGp5YjBNMWpPM0xxZzFValhuMC9vc1RyQjNFam14THdlNEhvUnBERzlRb1p6?=
 =?utf-8?B?UXh4cUdjVXZ3NHhaSzQ2VkVaNVJEN08zaUJBOVlxRnIvQ1dWVXRSaTRsMWo1?=
 =?utf-8?B?WnkxbHlVRmlSK1BvTWVDOE5zSURtWjBuMHRkc28wdzdvZW4wNzJXWVplaU1K?=
 =?utf-8?B?MGxQMVRBZm1kandONDFYTG9ZTGlVMTArZldkNUphT2thaFdhNXViM01HdDhU?=
 =?utf-8?B?ZzJ1a2RXMmVPaUEzdHZrTlBGRGZoMWd4RXlPN1h4bllWSkZDbUJLVC9vS2pX?=
 =?utf-8?B?OFZqRU5zOWFmSm5rZElrWGNtblIvSjliaG9oMHZSeCtQTGZGMVVicHg2cHFU?=
 =?utf-8?B?Yk9RRHdQeFZhK0hYSW5ycTBoRExwSS9aRHhVeGpSWU9DU2pKUkdJTy9xZFEy?=
 =?utf-8?B?alkweGhoblBlZFZYZjhHYjBBQ3NTQzdwc2Vud2VxT09vTGVMZ3FqSzlZTmdN?=
 =?utf-8?B?Ukd2d3RoUEdVOEJDKzNGRGJXa0dWK3N0SnlHeHF2ZjBHVmpmYkdWWGpuZDVq?=
 =?utf-8?B?bDg1cDcxTmdxdktqQU96eDRIVFl2MGc1cjUwUXkxeDZIRE03WVVZQStWUmNr?=
 =?utf-8?B?SUhCNy9zUnZFdnc2MXA1dmJxQS9PckFpYjZlVnBZN3MvNTA4c2hFcVQvdTd0?=
 =?utf-8?B?SFVxUE1yY2VubENIRU82ZzlIcmxiUmRIQjc4S0NhVDd3VWJETk8vNjBkaXVF?=
 =?utf-8?B?K2JQR0RHcjdKTko3TmtzcUxBSlVEY05rRldsRUpGNGtKUFAwZWxuc2lVeXQw?=
 =?utf-8?B?cmh5RFd5a3ZGcjlVeWlITjNWSmJPdll1Q1lMaXZtKzNHSWFtYWxHZVA3Rmh3?=
 =?utf-8?B?blJzV25JbFZUczRZRTk5ZFJ6S2JZU3JoOVdBODRXUTRYUUNoakI1Ym1Kazc0?=
 =?utf-8?B?S0dhc3hZUXJEQlBTRXN4dHhhQXFUOS9YRlNwYnpya1VObEJZckNNTk9qeGpq?=
 =?utf-8?B?aGNwcE1yaGw3aHJBelNObEJpcVlJb3grTERiMjR3SEYzV2JtVDR4RUc2ckVs?=
 =?utf-8?B?L0gzWFd5ZG1ybHNiSjNJZGkxdG1adExRVEVycXlTMXlaeW5ROE5mMUhwRnFI?=
 =?utf-8?B?OUMyOGtUaWNPSDV2SVhpVXlwYVNPVFlhby9Ga2JveXNTWWliNS90QWJYc0xI?=
 =?utf-8?B?MHpYQXBSazhaT2FSU2V0QlRZc2s4anFXdkwwSVc0YU9IOVpMVlNZbWlCRXJS?=
 =?utf-8?B?RmhWT2E3ZVhzTCs1QW9RTitvVG5rdEg3K3JkTTZ3eFBKb2Q3ZkdWeHdyWm9V?=
 =?utf-8?B?d1JraVFBcUUyVytRSXZQTTcweFhiQXhETFFJL3NIQlZUN2Z3UG5OWE9qV3lz?=
 =?utf-8?B?Ui9taFgrY3FGS0kxSzBDTldBN05MRFM3TW0vcG96UTl3djI2eHJ4amFvbkVH?=
 =?utf-8?B?RE1ONS9jbFE2VVFUUGpzZ3JNQUkrQmhmK1ZjV3B2SVJPaXlRbXFyZkNYZ2hT?=
 =?utf-8?B?S21xTHFaRjg0ZjBPUVErclpJZGhHQU41YjlWZ2RkMzQwZ3JWOU5XUnRlWGhp?=
 =?utf-8?B?dWFsN21Vdmc4NjgwaEtkQjlRaXlFKzd2UVV1Mmx5anM5dURwMEZNR2FkYUEv?=
 =?utf-8?B?R3Y4UDh4M0tySG5EOFNVWG92OGNmQ2lFVnZFUXpQaktiRmo3S0NjNWxaZFFp?=
 =?utf-8?B?bjFQNGRYR1hxRnVCM3R1dGwzZ1IwMWV1a25yTG9OVFhYZmxtZE1LT3dhblp5?=
 =?utf-8?B?K0lncXlrSW45QTZhLytYRmxVTWRnc2cwaDZYOUtSZlFKendzcDRCM0czNC9G?=
 =?utf-8?B?eW1jcG5PRkFFNEtkdXFFMlV1RzVYR0ttSE8xbXpVb1pWUmIwNDNvZXVzNmM4?=
 =?utf-8?B?eVhTL3gvejlVcjNDb292TkJaeXJPMFZzVFpoNlFENW9jMmhJUTJEQjNQbmpV?=
 =?utf-8?B?UlBGMER3WGdsMUNPZ2tFODY3WFg1elRCMzVDUno3bWo5UUgwQlNvdWtRUGZM?=
 =?utf-8?B?azcwUHdyMGY1MUh0aE80dk0zRGVSOUY3TlVqNWlmd0VVc2tIMFBuQUxJK3Br?=
 =?utf-8?B?SG1OOERhVjk2UlFCb09jeTkyV0pNWWJpQ2RWaVcvQ1hFbW5pM1FTdXFrMVdR?=
 =?utf-8?B?KzI4REZNaTBGV2thTVlTc0o5eXJWNi9BTTNudUQzZk54V0NHYnhxSGRaeWJo?=
 =?utf-8?B?QjhjMkFCZFg0cmxOTGZFSGdXZ091d2Y2TkVxdUpqL1RRSzc1a00wdXdXWmNH?=
 =?utf-8?Q?pyqq0I7uSUd/axzkIZIht9JcnukLUpUPrB39kKoNM4ub?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f5808c-028f-4740-04f7-08daf7edf701
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:17:45.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+8gH1RCmqGjIHsSp4rnfGEJtMXU5hRCqht5lW08Tafuod6fhrjpwZENP+EttBtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kryzsztop Thanks for reviews. Please find my comments below.

On 1/15/23 6:45 AM, Krzysztof Kozlowski wrote:
> On 13/01/2023 19:04, Tanmay Shah wrote:
>> Hi Krzysztof Thanks for your reviews.
>>
>> Please find my comments below.
>>
>> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>>> driver. This bindings will help in defining TCM in device-tree and
>>>> make it's access platform agnostic and data-driven from the driver.
>>>>
>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>> ---
>>>>    .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>>>>    1 file changed, 137 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>> new file mode 100644
>>>> index 000000000000..02d17026fb1f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
>>>> @@ -0,0 +1,137 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Tightly Coupled Memory (TCM)
>>>> +
>>>> +maintainers:
>>>> +  - Tanmay Shah <tanmay.shah@amd.com>
>>>> +
>>>> +description: |
>>>> +  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
>>>> +  cortex remote processors to use. It is low-latency memory that provide
>>>> +  predictable instruction execution and predictable data load/store timing.
>>>> +  TCM can be configured in lockstep mode or split mode. In split mode
>>>> +  configuration each RPU core has its own set of ATCM and BTCM memories and in
>>>> +  lockstep mode redundant processor's TCM become available to lockstep
>>>> +  processor. So In lockstep mode ATCM and BTCM size is increased.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "sram-[0-9a-f]+$"
>>> Drop node name requirement.
>>> Why do you need sram node at all?
>>
>> I will remove sram- node. However, it device-tree I was planning to put
>>
>> all TCM nodes under single node for example:
>>
>> tcm {
>>
>>       tcm-lockstep {
>>
>>       };
>>
>>       tcm-core@0 {
> Mix of nodes with and without unit address is pointing to some design
> issues.


The design currently tries to accommodate physical relocation of the 
memory. May be there is another way to represent this.

Here is address space of TCM memory on zynqmp platform: 
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map

As per above address map, there are 4 TCM banks, each 64KB ( 0x10000 ) 
size at following addresses:

*In split mode*:

ATCM0: 0xFFE00000---|---> Assigned to RPU core0
BTCM0: 0xFFE20000---|

ATCM1: 0xFFE90000---|---> Assigned to RPU 1
BTCM1: 0xFFEB0000---|

However, In lockstep mode, ATCM1 and BTCM1 relocates to different 
addresses (i.e. 0xFFE10000 and 0xFFE30000 respectively)

and becomes available for RPU core 0:


*In lockstep mode Both used by RPU core 0*:

ATCM0: 0xFFE00000-----|
                                          |----> ATCM: 0xFFE00000 size: 
128KB
ATCM1: 0xFFE10000-----|

BTCM0: 0xFFE20000-----|
                                          |----> BTCM: 0xFFE20000 size: 
128KB
BTCM1: 0xFFE30000-----|


I am not sure how to represent this physical relocation of addresses in 
device-tree.

Ideally such sram nodes can be represented as following:

[1] Representation of TCM in split mode:

[ a|b ]tcm[ 0|1 ] {

    compatible = "xlnx,zynqmp-tcm";

     reg <>;

     ranges <>;

     power-domain: (only 1 power domain for current bank)

}

However, to represent TCM in lockstep mode as well, I might have to add 
platform specific optional reg and ranges property which optionally 
represent address space of lockstep mode for atcm and btcm.

For example, ATCM0 and BTCM0 will be represented as above [1] However, 
ATCM1 and BTCM1 will have following extra properties:

[a|b]tcm1 {

    compatible = "xlnx,zynqmp-tcm";

     reg <>;

     lockstep-reg <>; /* represent address space of this bank in 
lockstep mode */

     ranges <>;

     lockstep-ranges <>; /* represent address space ranges of this bank 
in lockstep mode */

     power-domain: (only 1 power domain for current bank)

};


Does above approach looks good? If some other standard way is already 
available to represent this could you please suggest?


Thanks,

Tanmay


>
>>       };
>>
>> };
>>
>> The top-most tcm node I assumed sram node. So I kept sram@xxxx
>>
>>>> +
>>>> +patternProperties:
>>>> +  "^tcm-[a-z]+@[0-9a-f]+$":
>>>> +    type: object
>>>> +    description: |
>>>> +      During the split mode, each RPU core has its own set of ATCM and BTCM memory
>>>> +
>>>> +      During the lock-step operation, the TCMs that are associated with the
>>>> +      redundant processor become available to the lock-step processor.
>>>> +      For example if each individual processor has 64KB ATCM, then in lockstep mode
>>>> +      The size of ATCM become 128KB. Same for BTCM. tcm-lockstep node represents
>>>> +      TCM address space in lockstep mode. tcm-core@x node specfies each core's
>>>> +      TCM address space in split mode.
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        oneOf:
>>> This is not oneOf.
>>>
>>>> +          - items:
>>> and you do not have more than one item.
>>>
>>>> +              - enum:
>>>> +                  - xlnx,tcm-lockstep
>>>> +                  - xlnx,tcm-split
>>> compatible describes hardware, not configuration. What you encode here
>>> does not fit compatible.
>>
>> I see. So, only xlnx,tcm is enough.
> No, it must be specific to SoC.


Ok. Then xlnx,zynqmp-tcm. I will change file name accordingly as well.


>
>>
>>>> +
>>>> +      "#address-cells":
>>> Use consistent quotes, either " or '
>>
>> Ack.
>>
>>
>>>> +        const: 1
>>>> +
>>>> +      "#size-cells":
>>>> +        const: 1
>>>> +
>>>> +      reg:
>>>> +        items:
>>>> +          - description: |
>>>> +              ATCM Memory address space. An ATCM typically holds interrupt or
>>>> +              exception code that must be accessed at high speed, without any
>>>> +              potential delay resulting from a cache miss.
>>>> +              RPU on AMD-Xilinx platform can also fetch data from ATCM
>>>> +          - description: |
>>>> +              BTCM Memory address space. A BTCM typically holds a block of data
>>>> +              for intensive processing, such as audio or video processing. RPU on
>>>> +              AMD-Xilinx Platforms can also fetch Code (Instructions) from BTCM
>>>> +
>>>> +      reg-names:
>>>> +        items:
>>>> +          - const: atcm
>>>> +          - const: btcm
>>>> +
>>>> +      ranges: true
>>>> +
>>>> +      power-domains:
>>>> +        maxItems: 8
>>>> +        items:
>>>> +          - description: list of ATCM Power domains
>>>> +          - description: list of BTCM Power domains
>>>> +        additionalItems: true
>>> And what are the rest?
>> As both items are list, we should be able to include more than one
>> power-domain I believe.
>>
>>
>> So first item I am trying to create list of ATCM power domains.
>>
>> In split mode, first item is ATCM power-domain and second item is BTCM
>> power domain.
>>
>> However, In lockstep mode, second core's TCM physically relocates and
>> two ATCM combines and
> Why power domains of a device depend on the mode? This does not look
> like binding describing hardware.
>
>> makes single region of ATCM. However, their power-domains remains same.
>>
>> So, In lockstep mode, first two banks are ATCM and so, first two items
>> are ATCM power-domains.
>>
>> I am not sure best way to represent this. But, first itmes is list.
>>
>> So, I am assuming list of all ATCM power-domains possible.
> List all items. Order is fixed, you cannot say BTCM is second item and
> then put here something else.
>
> Best regards,
> Krzysztof
>
