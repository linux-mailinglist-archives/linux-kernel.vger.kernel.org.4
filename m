Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03357727EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjFHLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjFHLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:35:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3C2D4A;
        Thu,  8 Jun 2023 04:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRY6fhFA2gIEZxsP1/9MvzYYS+Mykw7zBBqwppf5e3e6LdygPwK5Jes+yMbn+naHhGREZgQ4QJZoncepb09qtOFozJsfNQpEHZ/PHR1t66AmrCDkbFZn2+eMuCGbQu4VMlvzvXSGEd2iTnKP5kBEkgEIiA1iVsgEmqo0M3DFIHawWb9H8NPWsakzKTyRkkcPBEOgGerL952EH8YiW9pgKlI0XxatC4S3UMCNAC15qGr7imgCpklD8MVVqTgK3+JETAWdps6KzEq3tAUhQtRABoOyqpeK36pgAoB8gcot8bcBcCeGDRxHBG3NNSblGIIEkI8+gdOZ4vKq/Gq3GRCt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPqN9N6LAvARIY2/4sqS/09F6Izd9w00yG+2Hni0ZvA=;
 b=gVglbd2Y0IO+iJ082gbGZoiXlSQm5RDKubT/1qgrfyf0q2YRMv5Uu244Aj0bvO2+hwcBzyeGqHqiVciCP+DHE/zLggbTCEgi4gA8VHOSoPhbHK0kqioKB++flk0OYkWbz+l2pOwp51p/lnKWgOTuECXQ5+7nOJ0AH3I/CYYuHfxD1y0qnC4dYh9omfqQaf+TaqcWj0BubKTmPTAAJNgX19+y2jWPLCJAcXobjExs3G7B4OPad0GLNYMCQBRxztWvxQAtBV/WKUTdpB/59gHwHlo/N3PPO20vqnEmaQSOTmlT7N0ebVuIPLFL9zus0y0NaES/7P+n5yRBvRpJACmyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPqN9N6LAvARIY2/4sqS/09F6Izd9w00yG+2Hni0ZvA=;
 b=YbCAi05aWCp2J6bKIWIYi0CimFH2r6Q2uQrUWoW3LMb3QfAP3D6iF3lv5ZGvCEqyO+yV+ijyQSMdI3HRr347d4GVtGnwRSLxEPXREArJJRvjlP5uUfzb8OMAJ/2ljIq7WjeX1adgr2rC3PODJ4v4wqJonqM2dv3aDI7hwVB6Om8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 11:35:00 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 11:34:59 +0000
Message-ID: <b1c80077-7509-883d-cfd1-fb3c0b0449d6@amd.com>
Date:   Thu, 8 Jun 2023 13:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-2-piyush.mehta@amd.com>
 <168612336438.2153757.6000360498539992409.robh@kernel.org>
 <MN2PR12MB4333E0628E2E67652E80067A8850A@MN2PR12MB4333.namprd12.prod.outlook.com>
 <55b59833-d070-f576-9d85-047175d9722c@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <55b59833-d070-f576-9d85-047175d9722c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW3PR12MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a91e22b-098e-4986-e0a9-08db68146465
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUuicjVK2voevSBnw5qts1RbofwZFF7ViGzwT4FtWRpCaeBj7KE4M45Pc6Meo9YfxOL3FOqj5wzRtyosqbFihUHixOcNsfjfifyjFgmHmPRUQ1e96YGpBRuZldjOjOROQdCt5CTeDgwGmVSkEiQFwQjT79vks8T9sw2tIcwaO9GgRG5VfZ4yNtjzL86XpGsPvCJE054Cj/UATaeO6yJYBOaruMjFgkGx4J4Te3f5CVsdHokiOVN4VA0PG21/ml9BEZ1HwaDpF+tFVLC2O0WwecKiTu6T4nM22dsdDkGoR5v2eQ2OKEDCd5QXKu0lTYtiIcY1Ujvcd8WJtW0CVk796uppRZmngch5ffgt0IYzBAa7Zrxvwfgz6KYgHtpuSJe3LqFKyEzkCRlLYNeiPSiWRmr5OX7/wSReiDYhlPSDVmoYCIQ/rwmNmAks2zq+NHl6L4Kh0ymdkBWHvUsbm5nFlvfRE9oI5GWRUcpOtf5nSvZP/iC4C6FmN0JYrUzo2SfstqWP4CBqwhsXlnDofOb6HGy2LftSDPHOW8KDsnJKMFi1H9mAUUnQxf+qZJJG9G1liLGf7lrOwzkt/IT2LNgMyXdFFY8Jyp0IOZQusak/5MPY4vWjyjs1EL5wATZ+U4sOZujspw3xvCl7RAzxDAemDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(6512007)(53546011)(2616005)(6506007)(26005)(41300700001)(38100700002)(83380400001)(31686004)(6486002)(6666004)(186003)(966005)(478600001)(110136005)(66556008)(66946007)(54906003)(66476007)(4326008)(316002)(8936002)(7416002)(44832011)(5660300002)(86362001)(8676002)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9wb0NkdDlHaDZibnZjZGN0cGtVWGZ4M2tQSUxJdERuVkdPMTNsNk1XWEla?=
 =?utf-8?B?L2tjZmxvQzJmN0RPV0d4Rm1FVEhrL0I5elJ5QzEvRXZaTjc0ZTZ4UmFjRTB1?=
 =?utf-8?B?R2RIYmlSMStFbnFKODEybkFTdy8wSEdHU3Z4VlBjU0V5d3EwMWd6UFNQNW90?=
 =?utf-8?B?a1l6N2ozMWc4OHJjQm9jdnFTM0krQmdDK3FVRDU1RzlUT21UaE1oZFM5U25q?=
 =?utf-8?B?VXMrQ3hoeWlBMzZRTzdka3g4RlZUT0tNVHNWcDFuZkc1blBXejFEb3F0TjlI?=
 =?utf-8?B?Q1NYM21peWMxYlRMTVdRZTdlWUt4czF5UzhlNStKaHRidlNId3pxdUljSzQ0?=
 =?utf-8?B?ZkZWVjJrVFJBRFNoc3JEd2E5eWN4N2xpN3VSVVN0U0hjakFjM3BRdmZGdGcr?=
 =?utf-8?B?NDJUNTZ6YmtRaGp2WWVQcWdXSFVCa0tHZUhmSVpuOUk0NWRWbUVzZXFIbVJU?=
 =?utf-8?B?ZWI1Wmw5UWgwYjBBMUpMWXlFT1ZmTmRTeGlHNWpUekEvbXp3emZDODBubXhR?=
 =?utf-8?B?ZmIwUExTS1Z5eWRZc2EvWkx5Ymg5TmFZalF3bzI3aC9ram80Rmcxbk43Njk3?=
 =?utf-8?B?cTRCc2tRZjVidjIvRzBVSlhSc0Z0QlE5V0JkMGJyL2ZraFhNNmJkaTVXTmZK?=
 =?utf-8?B?dUljNjBCMHJQb0VMcE9Cd1FUWU9qUFZxZHRGNlhON0szb3k4VzNuT1g0cE0w?=
 =?utf-8?B?NEpWQnVyNDBkMDZYbWJlOGJxOVB1dlRpVFB3eDV4YjhhNldYak8vNzVEOUdx?=
 =?utf-8?B?MXBTR0JXR2FBRmlaV3MxOS8yN05hZnc4QWlLbkNHSmpGNHpxM2N4Wk13UFJ2?=
 =?utf-8?B?aWhEWE45aGJBd3ZLQVVNRWdrVjFJVGJxelhwK3NHVm1KTFFTSGFWcWF2TVR0?=
 =?utf-8?B?VlBUTVlCRmpJbnkxT1RjcUUycUkybmdqdlhNNm9xQVJNZTB2dHhKR2x4MVpu?=
 =?utf-8?B?K3c0ci9Kaml4dkk1dXhqdVBCVFdobHQvMHF4QkJQTElLYmR3d1EyVzNUMmZY?=
 =?utf-8?B?dFpYQXFmcjNoU3ZUZHlWa2J0eFk1aVZ1aHdUTkZlN2JXTmlVUzgvbHBOcTJK?=
 =?utf-8?B?RFppZjNRQjM5OVVHczYrREQ3Uk5mNU9iYW1rUzljKzNRTkEvT0xKdlVWa2I3?=
 =?utf-8?B?ZE1tNWkvc1AxbkpQN05SdDNqeWE4c3RtK0YvN0tuY01NWW55ZlVCbzluT3hp?=
 =?utf-8?B?RUYvMWRudlh0OVJUUm5EZWswZEttRG0vZ1IxQVZGanZORElaR0JIeWtSZm5n?=
 =?utf-8?B?STNiZFB4ZWNiYVZPRXp5S3dQdE5taGlHMEpMSWJ5ck5lSE1pNk9iUldkUXhH?=
 =?utf-8?B?OVkzNmlyMDU3Q0QwMWI3N0RwVlZ1dlBEYm9SZXB2Sk1Lc3lCMWRMTFBZUHlF?=
 =?utf-8?B?ai9kT1Fpd2M5MmNGUjdjdTJWWnR5QWp1dmplTW41RzJoTTBQa09DN29ENFlx?=
 =?utf-8?B?eGErc1UwVXNaeEx2cEI4NUp5bGFMdDlBUklTNkVORWt5SzhVeVNCSTgvZmVS?=
 =?utf-8?B?VWxKSnB2OWgvbDJJc1pIcDNwODBmRUJVeVFOcUZsMWVRNXRSZXlKaklLSy9C?=
 =?utf-8?B?NkMwSVA0blQ4eEVkNmJmQVFMUFg0QVZ3M3lSV3pmUk1TaC9HQlZGM2xjaGNR?=
 =?utf-8?B?S1hmeUd3ZXNLOEFlWFVRd3ErdlZwL0g4NGVvbmN6cHV3aW1ydHFLV0pOdVZG?=
 =?utf-8?B?MXU2YmpxR1VkTXZvem1QZmgvRncvallSMlVEL3Ivb1ZtN21zaVRHMkZYWk9F?=
 =?utf-8?B?Yk9NMnU5TC9MbUtyV2dOZjZMaVo2T3BoazhQSi9pTXdIQnptbkVNazFKWmdG?=
 =?utf-8?B?K2ZyL010Zlh5NVlFeUxTYnA3aUcvOXFQRWNQYzE2cm5xOERGWkt0c0JOL1dq?=
 =?utf-8?B?NDdiYkFRSHVrZlF6ZGVCY3M2QjN2K0NvS01jNVhWOWtvT0VFbmdSY2plNWV0?=
 =?utf-8?B?MnJQQWRxRG9sTElRLzlLby84U1p3a1hrdS8wUUJQdlpXdmtLSTk5cXJBK0Jw?=
 =?utf-8?B?a0ZDdDJLdkRpQzB4T3JpU25QMUVkRVM4a2kxa2tyM2ptWTlTbHdrYWlKcmdM?=
 =?utf-8?B?SDJnSGIwYXRkdnJNdjRWMUpCdWQwcUJQM2N4bVJ6SC9WbnRqWHpZY29ZekRJ?=
 =?utf-8?Q?pdOAbdzD7UbV4LI1m+ZtGgL2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a91e22b-098e-4986-e0a9-08db68146465
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 11:34:59.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZu1/z5JZqlzryCgT2lMoE5jNnCdMAkrtTuEjbfxDfVAoQUcZMnOVUCbjjafpRdo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/23 13:29, Krzysztof Kozlowski wrote:
> On 08/06/2023 12:55, Mehta, Piyush wrote:
>> Hello,
>>
>>> -----Original Message-----
>>> From: Rob Herring <robh@kernel.org>
>>> Sent: Wednesday, June 7, 2023 1:06 PM
>>> To: Mehta, Piyush <piyush.mehta@amd.com>
>>> Cc: p.zabel@pengutronix.de; Paladugu, Siva Durga Prasad
>>> <siva.durga.prasad.paladugu@amd.com>; michal.simek@xilinx.com;
>>> nava.manne@xilinx.com; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-usb@vger.kernel.org; conor+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org; robh+dt@kernel.org; Simek, Michal
>>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>
>>> Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
>>> to yaml
>>>
>>>
>>> On Wed, 07 Jun 2023 12:21:20 +0530, Piyush Mehta wrote:
>>>> Convert the binding to DT schema format. It also updates the
>>>> reset-controller description.
>>>>
>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>> ---
>>>> Note:
>>>> The 1/2 patch introduced a warning related to the dt binding check,
>>>> which was subsequently fixed in the 2/2 patch. This warning is a
>>>> conversion warning due to a dependency on firmware dt binding.
>>>>
>>>> Warning:
>>>>    DTC_CHK
>>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
>>>>
>>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xln
>>> x,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not
>>> match any of the regexes: 'pinctrl-[0-9]+'
>>>> 	From schema:
>>>> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firm
>>>> ware/xilinx/xlnx,zynqmp-firmware.yaml
>>>>
>>>> Please suggest to me, if it's fine to make a single patch instead of
>>>> the separate patch 1/2 and 2/2.
>>>> ---
>>>>   .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
>>>>   .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
>>>>   2 files changed, 67 insertions(+), 55 deletions(-)  delete mode
>>>> 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-
>>> ci/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-
>>> reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of
>>> the regexes: 'pinctrl-[0-9]+'
>>> 	From schema: /builds/robherring/dt-review-
>>> ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
>>> firmware.yaml
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/project/devicetree-
>>> bindings/patch/20230607065121.2265076-2-piyush.mehta@amd.com
>>>
>>> The base for the series is generally the latest rc1. A different dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above error(s),
>>> then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>> your schema. However, it must be unset to test all examples with your schema.
>>
>> This dt_binding warning is known to us and is captured in commit description notes and to resolve it, we need to apply 2/2.
> 
> So your patchset has broken bisectability. You need to fix it. If the
> warning was known, then I am surprised that you sent broken patchset.

The first patch is conversion from txt yaml without any additional changes 
because in past we heart that we shouldn't really do other things in it. That's 
why 2 patches where made. No really issue to squashed them together.

Thanks,
Michal
