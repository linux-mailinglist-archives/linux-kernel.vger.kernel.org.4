Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12974583F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGCJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGCJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:20:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125D12C;
        Mon,  3 Jul 2023 02:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0pjm7GRIvg82ulINMK+qiOmTQ8M4MJtM3Tjm+26BA/fk3h8SBj1rQzTcalR3R5QK29nUgx7B2zUBmlAYcoFOZ5Mm/+U1sp1EUo/cyUhZqO6VV6a62CUYM5A7qzyC39m5ScqjKbwhaLdvrbht2zIxyLswFqUgW4iAA1WxzaQ5Mw2WkVQzIKo2ynoNct+Gl1S7fjYOghhl4bbU99zyYSaP+wDQOHTOHG3hTzX2u2ZpthTEF7yWV4FE+mAk93fXJKKgsGL1bILNuwBHPaenfCuwr2zNOkDC7nsAwv3TzB/uFXBI89EMfG9uihx4zc4JbpiG0hMkghmQSlSFIeA/lm73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aApbBm8wS8iJFAm9xYTB3+zBorwBUycXP3OusLpf+Rk=;
 b=mypQ9aH/Lj/VTzdzI+5oe+dNLJlFdjIe0n+VwFI9FUT5wyAR83yhMwmJGqZWd49/YfyG+ZjXkUpKwKrrwRbkTmKA1rRPUQ4Gunm8+8KEKrzohnLcckBgTc0z4+Tv8v4N8PCdpml7jszm9v9wZcXWuthEb2wMsZTQDGwtsFaYnk636BxDKhcPUN06wcZRn++zxC/o/lFTvuKSljGR6ussxEuugaDCxa8AWNzHy4EOXb8tiYEwWdxySHzTKwsEmp/QhVSknmyYz+vhpr9Xd01iaQ0apOk8B2hAsSljZ7y+TLquoP20HxoB1m883e/TSTfRHHMgj0M5o8u6QpqfyZQxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aApbBm8wS8iJFAm9xYTB3+zBorwBUycXP3OusLpf+Rk=;
 b=lBcOysmaZM4tfkZsha/HTXtR+YOrWv5YMunivFc4vCx8hidCJ10AzfgsnQqn4jy9V0uT6rfIAijxT4zMYoO1YomTNWBhRo9Tg1fYVHcfRtB0O01b3qZRziIoAE3reUV98JFfLvdmeOvZxqISc56xikyyKN9BwKvEn0jB08oNHnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SN7PR03MB7231.namprd03.prod.outlook.com (2603:10b6:806:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Mon, 3 Jul
 2023 09:20:27 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:20:27 +0000
Message-ID: <16feefaa-e4d9-ad5a-71c5-cee8ce8be5e4@synaptics.com>
Date:   Mon, 3 Jul 2023 17:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Content-Language: en-GB
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, ming.qian@nxp.com,
        hverkuil-cisco@xs4all.nl, gregkh@linuxfoundation.org,
        ezequiel@vanguardiasur.com.ar,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas.dufresne@collabora.com,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ayaka <ayaka@soulik.info>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
 <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
 <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com>
 <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
 <0f4fd31f-ef61-8dee-7a88-55263f266975@collabora.com>
 <483472c8-74fd-4208-343e-4a8bf79dc6e7@synaptics.com>
 <2b64b605-61cc-248e-a67a-85266434c7a6@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <2b64b605-61cc-248e-a67a-85266434c7a6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::14) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SN7PR03MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b989c4-355d-42d6-473b-08db7ba6bcf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ps7+vmVrtubC4dvfrDay36aIhFt1k0JqQDfFZKKPeY/lmpbMB7ISWjvG7JQRMq0Gxkjzetr5qsBRTvSMWZ7D+YF9RskoX6Bg6yEXM8LOnecxFOuoeLSvD1QW1JWFE2hsMXDDWg9MRsiwr/zKOnqZaxRCUISSBw8YhwQtZj660M6E41fhLxPq2y1+8FhcGBjwv7F/VHeKrCsXtmbUOKbDF00V/4487KB/jcaKWaYfdJzWtVgq39WXTeRXNWZ4dPFAm06zwWcaC67GVKOdPTEcyGr7XvGi2U2KmSaLXi1VkpfUWDpA3B5yqXQpHp931tCnQtpLAHVJybncEw3os0Hk8m040VzlqCfn4jmkvcbEIlkrKjx3LRhx3edAftxsWZTkZhVtWn9kMRhHroIA5vBNAq2KUk1lWpqiXaBCLMU87GaNC5+vwGE5tzI751fynbMijcYeZfSSvYDg+upLeVGZPo4/c6vv628hXvlvus4tFgfMdPM4MAPtCnTPag6fbTC/To/aVaK6UIHy0eLx3nKRblGKfGlHEeRkPssNCPvXEfbB7Ixcyg9JKevro4bLUwh9jisLWMHepRTQCRKqLsz4wCxzB1QO6q1GZehZuffv3qaMSd8alh3zCcXd7+/+CZ+kywx+rB/FeoYFCVJt5pIh2FxcH5I+CyO1lCApTSBfZms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(31686004)(66899021)(66556008)(66476007)(36756003)(38350700002)(6916009)(316002)(38100700002)(41300700001)(30864003)(8936002)(66946007)(7416002)(31696002)(8676002)(86362001)(4326008)(5660300002)(966005)(66574015)(2906002)(26005)(186003)(83380400001)(6506007)(6486002)(478600001)(6666004)(53546011)(2616005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVlOWxLbTcvVnYwQnY0K0pHcE1tOTFzREtUUTVmdmdXNWlqQk00aXNGYnNm?=
 =?utf-8?B?YStjSjZkK3dJdTI2V2RmSy96dUlVNlJ0NU5qRHBaMTNBWE5tcXg4amh1VURt?=
 =?utf-8?B?MFY5RWpwcEQzZHBoZXpZbzVVL0VJTS9xb2hOeDRJbTJEQ0VWaGg4V3UrbjV3?=
 =?utf-8?B?ZWI4UThsdFF1bDU1MjkraHladVRPY0NkeWhZZWJCd3EyS3ZnemxtR0dOaHZw?=
 =?utf-8?B?SHBVcFRFaU1XWDVvM1Q2NjN4c1BaRjkyK1JSbHpIZFpGTzRDS01IZ284WXdy?=
 =?utf-8?B?Qld4UkRFUFB3Y2RwdTcyUXoxL1ZXZ3IvUWNNbGRuNmtNWVk0VHQxZDFRM1gw?=
 =?utf-8?B?bnVIbXBLUXJHdzB4QmlCNnBlZU9sQ3dVUEFLemhZYktrUFZ2RGJYYlJTR3pF?=
 =?utf-8?B?QnhSV1J3MVhyS1lwOVh3V0RxZVYwSU5XWkp3ZXRuOHJHQjA1UnNYSlJkc3NJ?=
 =?utf-8?B?UjZ3aUNQdXZqTU04cUNadXFYeHFoZXdoUEJ0bHhkczY3aElSQzFlQkkycGxl?=
 =?utf-8?B?SmZIRmxHbjFGTEdXQ3pEZnBoa1JZbWhzV0NZUXdNSkxSZ1BXZ25MUlNldll0?=
 =?utf-8?B?czJSMk5RbFRWM0x3N0NHQWlCby82WWJKYjgweVVDUXVnK1piem8ycEJMNE1N?=
 =?utf-8?B?ZnhVRFM1RTh4ellTeDRmcTRUOGtrWmJrQWZNSllHOUNaSE9lczFnczNXNHIw?=
 =?utf-8?B?V2E4My85Z3ZKR1hJSkF0QWkzQ1JLMlRtM0h3cXNVSklPTWlFWW85RUVRQ01l?=
 =?utf-8?B?cWVIOS9hOFRSdGFEMFovREN0MUdRVkpKM2dNbkgyZ0tzSGZXL0NxN0haZzlK?=
 =?utf-8?B?UytrMWdEaXNCQnQ4VEFhaS9ueERyMndnYlcvVFdrR2FYdGl1alFMQ1dSZVJp?=
 =?utf-8?B?K2tTRi80NjBGbUZCRFAva1hhYysxVnV4Vm40d1UyNmtJRFk1OFVWZlYwUS81?=
 =?utf-8?B?NitHY2xHWUpKM1JSU0paLzRNek1nOVptcDVSL3ozZUg3RUliblRPci9WbGta?=
 =?utf-8?B?L0VtWkJsZ29QMFZMOHNyZ1FWbC9lMEJaYnU2akVic0NkWHlCZTMwaW9UT3M0?=
 =?utf-8?B?eEd2WW5KcW51UFo0MVdqNHp1R1pQYXFBV3QvQVJia0tpd0hsRjNVUGlQeDIx?=
 =?utf-8?B?ZDEvRXBidU1KZEs0enZLZlpKdG0yMXpvVEFNMllVMjM0aks5TTZkZThneEZ3?=
 =?utf-8?B?YUVUbTNCZm1vaDQ1cU83UldvbFBoajZudCtqOHF4LzE4TlM1NUpEZnJsMDN3?=
 =?utf-8?B?eFpjdW5VU3QzMEU0QWV3dW13MUlZOUVrUlZoQm1WUzllMjdhNUo2cENUM3dK?=
 =?utf-8?B?eURtUE5JRGQycENQcEE5MVVObjBFNVFXQ0JLUDdwWm9wTU80eTlESlNZUG9i?=
 =?utf-8?B?WlhJNVJnTWdzR055bHNxMFdLNFpSZ0FMaUhpRUdJT0dFOVBWSnhuaXZxSjI3?=
 =?utf-8?B?QVZsTEUzbDNwSFFXLzlsL3pPMnJjYmh3VnBEaWdJRGdJR3BRM2p3RldEbWN5?=
 =?utf-8?B?WllHUUJBMGszaCtyamJidFArN2pncFl0Rit5c2cxUkxGYjZ5UllmQmwxRVNX?=
 =?utf-8?B?OVZIeDE1QTNXWDlJd3lFMk1WWnhHeVVxdmpMMGJXR3lVM2puTE80dnNBY2hY?=
 =?utf-8?B?cWdGWFNDQUwvdURTb3hRcTNGMlNuRll6SDRKQ1BGQVFTaGtGdS9PcnpHUGJW?=
 =?utf-8?B?VFdKVW9hM1dndkk5WW8ydVBzWitQcG92SGZwT2xiNytPWmtrdTdsNmd4WWFV?=
 =?utf-8?B?OVBvNkpIRUtvcXJrQWlSc2tFMmRTTk14SFhWeXVMV1h0NHhyclVSRzZNcVVs?=
 =?utf-8?B?aFJ6WE51Z2loS3VVaEo3UlFMQ1hVMlhTdEREQ2ZGRW9HSmJzbSs3eFhoU0lu?=
 =?utf-8?B?SE9jc3YwSXZsL3NVL2dyOHZZc1ppRmVtSnFxaGFqL2xrcVRLdU1kTFNLWGYw?=
 =?utf-8?B?TzJiMURPWDAxdlFQSnpObURzUWd6akR2THZwSkRkRkhjdWlBa3V2QldCWlg0?=
 =?utf-8?B?a01scVpieWxaMGhoZklnZGswQVVIdHllbmd2OW9xV2FRVGpkT0NEdFc0RGoy?=
 =?utf-8?B?UmdEK284ZFF4UFZ3VENwYXFxUDkvNUE4UG1qamR0WDRuRkdac1RWdmZ3S05u?=
 =?utf-8?Q?xqmIJsUpvsbAQ/KdBXlvKeL2j?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b989c4-355d-42d6-473b-08db7ba6bcf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:20:26.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAHhhLG/vhg6FKXlqKCXL7dbSesGBBYTGN/JcnR0UaXlT/hvMgAg+dHyCLQ3dAd3UQdySZdDGIfiGAlMoBe5XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7231
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 16:52, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> Le 03/07/2023 à 10:19, Hsia-Jun Li a écrit :
>>
>> On 7/3/23 16:12, Benjamin Gaignard wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> Le 30/06/2023 à 11:43, Hsia-Jun Li a écrit :
>>>>
>>>> On 6/27/23 16:47, Hsia-Jun Li wrote:
>>>>> CAUTION: Email originated externally, do not click links or open
>>>>> attachments unless you recognize the sender and know the content is
>>>>> safe.
>>>>>
>>>>>
>>>>> On 6/27/23 16:43, Benjamin Gaignard wrote:
>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>> attachments unless you recognize the sender and know the content is
>>>>>> safe.
>>>>>>
>>>>>>
>>>>>> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>>>>>>
>>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>>> attachments unless you recognize the sender and know the 
>>>>>>>> content is
>>>>>>>> safe.
>>>>>>>>
>>>>>>>>
>>>>>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>>>>>>
>>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>>>> ---
>>>>>>>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>>>>>>   .../media/v4l/vidioc-delete-buf.rst           | 51
>>>>>>>> +++++++++++++++++++
>>>>>>>>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>>>>>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>>>>>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>>>>>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>>>>>>   include/media/v4l2-ioctl.h                    |  4 ++
>>>>>>>>   include/media/videobuf2-core.h                |  9 ++++
>>>>>>>>   include/media/videobuf2-v4l2.h                | 11 ++++
>>>>>>>>   include/uapi/linux/videodev2.h                |  2 +
>>>>>>>>   10 files changed, 128 insertions(+)
>>>>>>>>   create mode 100644
>>>>>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>>
>>>>>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>>>>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> @@ -17,6 +17,7 @@ Function Reference
>>>>>>>>       vidioc-dbg-g-chip-info
>>>>>>>>       vidioc-dbg-g-register
>>>>>>>>       vidioc-decoder-cmd
>>>>>>>> +    vidioc-delete-buf
>>>>>>>>       vidioc-dqevent
>>>>>>>>       vidioc-dv-timings-cap
>>>>>>>>       vidioc-encoder-cmd
>>>>>>>> diff --git
>>>>>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..0e7ce58f91bc
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> @@ -0,0 +1,51 @@
>>>>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>>>>>> +.. c:namespace:: V4L
>>>>>>>> +
>>>>>>>> +.. _VIDIOC_DELETE_BUF:
>>>>>>>> +
>>>>>>>> +************************
>>>>>>>> +ioctl VIDIOC_DELETE_BUF
>>>>>>>> +************************
>>>>>>>> +
>>>>>>>> +Name
>>>>>>>> +====
>>>>>>>> +
>>>>>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>>>>>>> +
>>>>>>>> +Synopsis
>>>>>>>> +========
>>>>>>>> +
>>>>>>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>>>>>>> +
>>>>>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer 
>>>>>>>> *argp)``
>>>>>>>> +
>>>>>>>> +Arguments
>>>>>>>> +=========
>>>>>>>> +
>>>>>>>> +``fd``
>>>>>>>> +    File descriptor returned by :c:func:`open()`.
>>>>>>>> +
>>>>>>>> +``argp``
>>>>>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>>>>>>> +
>>>>>>>> +Description
>>>>>>>> +===========
>>>>>>>> +
>>>>>>>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF`
>>>>>>>> ioctl to
>>>>>>>> +delete a buffer from a queue.
>>>>>>>> +
>>>>>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>>>>>>> +:ref:`buffer`.
>>>>>>>> +
>>>>>>>> +Return Value
>>>>>>>> +============
>>>>>>>> +
>>>>>>>> +On success 0 is returned, on error -1 and the ``errno``
>>>>>>>> variable is
>>>>>>>> set
>>>>>>>> +appropriately. The generic error codes are described at the
>>>>>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>>>>>>> +
>>>>>>>> +EBUSY
>>>>>>>> +    File I/O is in progress.
>>>>>>>> +
>>>>>>>> +EINVAL
>>>>>>>> +    The buffer ``index`` doesn't exist in the queue.
>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> index 899783f67580..aa546c972c3d 100644
>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue
>>>>>>>> *q,
>>>>>>>> unsigned int index, void *pb)
>>>>>>>>   }
>>>>>>>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>>>>>>
>>>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>>>>>>> +{
>>>>>>>> +       struct vb2_buffer *vb;
>>>>>>>> +
>>>>>>>> +       vb = vb2_get_buffer(q, index);
>>>>>>>> +       if (!vb) {
>>>>>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>>>>>>> +               return -EINVAL;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>>>>>>> +               dprintk(q, 1, "can't delete non dequeued buffer
>>>>>>>> index
>>>>>>>> %d\n", index);
>>>>>>>> +               return -EINVAL;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>> I know the driver could implement its own
>>>>>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>>>>>>> used by the hardware as a future reference frame.
>>>>>>> But I think we need a flag to let the user know which buffer is
>>>>>>> still
>>>>>>> used by the hardware.
>>>>>>> Alternative ref case is safe, we only know it's existing when it is
>>>>>>> dequeued in current V4L2 buffer mechanism.
>>>>>>> While the Golden reference frame, such long term reference frame
>>>>>>> could
>>>>>>> last much longer.
>>>>>>
>>>>>> It is up to userland stack to know frames life time, it got the
>>>>>> information for that.
>>>>>
>>>>> That is true for the stateless codec driver.
>>>>>
>>>>> While application for stateful decoder could never do that. It also
>>>>> breaks what the document said:
>>>>>
>>>>> "The backing memory of |CAPTURE| buffers that are used as reference
>>>>> frames by the stream may be read by the hardware even after they are
>>>>> dequeued. Consequently, the client should avoid writing into this
>>>>> memory
>>>>> while the |CAPTURE| queue is streaming. Failure to observe this may
>>>>> result in corruption of decoded frames."
>>>>>
>>>>>>
>>>>>>>> +       if (vb->planes[0].mem_priv)
>>>>>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>>>>>>> +
>>>>>>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>>>>>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>>>>>>> +               __vb2_buf_mem_free(vb);
>>>>
>>>> Here is another problem for the existing application, the mmap() from
>>>> the mmap offset or exportbuffer fd would not create a reference to
>>>> buffer in this step(while the exportbuffer would create one itself).
>>>>
>>>> When you delete a buffer, you may not release it from its virtual
>>>> memory space, leaving a corrupted virtual memory space. Also this
>>>> behavior is right, because mmap(2) says:
>>>>
>>>> "After  the  mmap()  call has returned, the file descriptor, fd, can
>>>> be closed immediately without invalidating the map‐ping."
>>>
>>> Existing applications do not call DELETE_BUF ioctl and when call it
>>> they will be aware that the buffer is removed.
>>> I have done it in GStreamer:
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.freedesktop.org_benjamin.gaignard1_gstreamer_-2D_commit_fca0fbc934f4440693ce0ff6c8dc8a2e5f5f17d9&d=DwIDaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=TGH9toTzGRfO5aBsfaMvGbcOw-28q6cPmpX6vScbHjpCtaLtb-RuvBvsJ0z9RvAB&s=Ufl1ccfRZf2EhnfCBvnQzRJV9CDhGxl5spe9WNECspU&e= 
>>>
>>>
>>
>> I have read that.
>>
>> There is not a VP8 parser in Gstreamer, while a parser would not work
>> when deal with the secure video(userspace can't access the data
>> context at all).
>>
>> Besides, this adds extra work for the application for a stateful codec
>> driver. The application need to parser the bitstream and track the dpb.
>>
>> I don't mind if you could fix the nonfiction mechanism for those
>> non-display frame and internal reference state.
>>
>> That could be requirement for codec firmware that its driver could
>> support this DELETE_BUF ioctl() feature.
>
> Sorry I don't see the link with my patches here...
> I have work on non-secure VP9 on stateless codec.
> DELETE_BUF ioctl is optional and the main goal is to offer a way to 
> applications
> to save memory if they know when they could delete buffers without risk.

I try to explain why I think this design in not "complete". One problem 
resolved, more problems would occur.


For non-secure video, those applications have worked:

- It would break what stateful means here, application need to 
acquire(parse) the information that driver should offer.

   Or it would break the decoding model.

- Your Gstreamer sample code or this design won't work for AV1.

For all the future possible secure video:

- This feature could never be used from the current design.


>
>>
>>>
>>> Regards,
>>> Benjamin
>>>
>>>>
>>>>>>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>>>>>>> +               __vb2_buf_dmabuf_put(vb);
>>>>>>>> +       else
>>>>>>>> +               __vb2_buf_userptr_put(vb);
>>>>>>>> +
>>>>>>>> +       vb2_queue_remove_buffer(q, vb);
>>>>>>>> +       kfree(vb);
>>>>>>>> +
>>>>>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   /*
>>>>>>>>    * vb2_start_streaming() - Attempt to start streaming.
>>>>>>>>    * @q:         videobuf2 queue
>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> index 724135d41f7f..cea666c17b41 100644
>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q,
>>>>>>>> struct
>>>>>>>> media_device *mdev,
>>>>>>>>   }
>>>>>>>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>>>>>>
>>>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>>>>>>> +{
>>>>>>>> +       return vb2_core_delete_buf(q, b->index);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>>>>>>> +
>>>>>>>>   int vb2_create_bufs(struct vb2_queue *q, struct
>>>>>>>> v4l2_create_buffers
>>>>>>>> *create)
>>>>>>>>   {
>>>>>>>>          unsigned requested_planes = 1;
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> index f81279492682..80ace2e1e932 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>>>>>>> video_device *vdev)
>>>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>>>>>>> vidioc_prepare_buf);
>>>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
>>>>>>>> vidioc_streamon);
>>>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>>>>>>> vidioc_streamoff);
>>>>>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>>>>>>> vidioc_delete_buf);
>>>>>>>>          }
>>>>>>>>
>>>>>>>>          if (is_vid || is_vbi || is_meta) {
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> index a858acea6547..1c737279d3ef 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>>>>>>> v4l2_ioctl_ops *ops,
>>>>>>>>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>>>>>>> +                         struct file *file, void *fh, void *arg)
>>>>>>>> +{
>>>>>>>> +       struct v4l2_buffer *b = arg;
>>>>>>>> +       int ret = check_fmt(file, b->type);
>>>>>>>> +
>>>>>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>>>>>>                                  struct file *file, void *fh, void
>>>>>>>> *arg)
>>>>>>>>   {
>>>>>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>>>>>>> v4l2_ioctls[] = {
>>>>>>>>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>>>>>>> v4l_print_freq_band, 0),
>>>>>>>>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>>>>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, 
>>>>>>>> match)),
>>>>>>>>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>>>>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>>>>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>>>>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>>>>>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>>>>>>   };
>>>>>>>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>>>>>>
>>>>>>>> diff --git a/include/media/v4l2-ioctl.h
>>>>>>>> b/include/media/v4l2-ioctl.h
>>>>>>>> index edb733f21604..2f232ed884c7 100644
>>>>>>>> --- a/include/media/v4l2-ioctl.h
>>>>>>>> +++ b/include/media/v4l2-ioctl.h
>>>>>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>>>>>>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>>>>>>    * @vidioc_prepare_buf: pointer to the function that implements
>>>>>>>>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>>>>>>> + * @vidioc_delete_buf: pointer to the function that implements
>>>>>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>>>>>>    * @vidioc_overlay: pointer to the function that implements
>>>>>>>>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>>>>>>    * @vidioc_g_fbuf: pointer to the function that implements
>>>>>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>>>>>>                                    struct v4l2_create_buffers *b);
>>>>>>>>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>>>>>>                                    struct v4l2_buffer *b);
>>>>>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>>>>>>> +                                struct v4l2_buffer *b);
>>>>>>>>
>>>>>>>>          int (*vidioc_overlay)(struct file *file, void *fh,
>>>>>>>> unsigned
>>>>>>>> int i);
>>>>>>>>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>>>> b/include/media/videobuf2-core.h
>>>>>>>> index 080b783d608d..0f9e68f76b77 100644
>>>>>>>> --- a/include/media/videobuf2-core.h
>>>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>>>>>>> enum vb2_memory memory,
>>>>>>>>    */
>>>>>>>>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int 
>>>>>>>> index,
>>>>>>>> void *pb);
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * vb2_core_delete_buf() -
>>>>>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>>>>>>> + * @index:     id number of the buffer.
>>>>>>>> + *
>>>>>>>> + *  Return: returns zero on success; an error code otherwise.
>>>>>>>> + */
>>>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>>>>>>> +
>>>>>>>>   /**
>>>>>>>>    * vb2_core_qbuf() - Queue a buffer from userspace
>>>>>>>>    *
>>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>>>> index 88a7a565170e..3beeb4c735f0 100644
>>>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q,
>>>>>>>> struct
>>>>>>>> v4l2_create_buffers *create);
>>>>>>>>    */
>>>>>>>>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device
>>>>>>>> *mdev,
>>>>>>>>                      struct v4l2_buffer *b);
>>>>>>>> +/**
>>>>>>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>>>>>>> + *
>>>>>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>>>>>>> + * @b:         buffer structure passed from userspace to
>>>>>>>> + * &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>>>>>>> + *
>>>>>>>> + * The return values from this function are intended to be
>>>>>>>> directly
>>>>>>>> returned
>>>>>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>>>>>>> + */
>>>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>>>>>>
>>>>>>>>   /**
>>>>>>>>    * vb2_qbuf() - Queue a buffer from userspace
>>>>>>>> diff --git a/include/uapi/linux/videodev2.h
>>>>>>>> b/include/uapi/linux/videodev2.h
>>>>>>>> index aee75eb9e686..31bba1915642 100644
>>>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>>>>>>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>>>>>>> v4l2_dbg_chip_info)
>>>>>>>>
>>>>>>>>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>>>>>>> v4l2_query_ext_ctrl)
>>>>>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct 
>>>>>>>> v4l2_buffer)
>>>>>>>> +
>>>>>>>>
>>>>>>>>   /* Reminder: when adding new ioctls please add support for
>>>>>>>> them to
>>>>>>>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>>>>>> -- 
>>>>>>>> 2.39.2
>>>>>>>>
>>>>> -- 
>>>>> Hsia-Jun(Randy) Li
>>>>>
-- 
Hsia-Jun(Randy) Li

