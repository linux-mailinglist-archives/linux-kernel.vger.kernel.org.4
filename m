Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0773F7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjF0IsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0IsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:48:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB53B8;
        Tue, 27 Jun 2023 01:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+587KSQ4qr1OU5Mm1VlQi3RPs/muqfYyH4JNPD20HELIDI1A9LMM+ck8jJ50ysJAbEETgcQqt4k7A4mjKrYThLQMT/c/9/pBr5PTmXIU2JS8ZoxfvyLAH6rOvsBugw9lH0qE/yT8ju9ggPt9C0RYT3SdM/mTizhaKSLVAPxHg74F9XrUb6OGpzJQPTeiLBbZg1YoDJhxQHjW21wcc1HhFDiBl5LTpA7KRf/eJiDDcXn6DcryzDhWkX1RQ9mVoEUqze802GD6GreER8ANmmMGkrl/HU3+CnUmskqRDIn/2vNU2yYjBFBjVqoLCVlYKtlF9BWtz1+xkYdr1QyS1X3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmzM2lgvd4aD6PrEewGvIeQpsCrxd1nd7nUenOJ2SoE=;
 b=NoBnhpbzySvuJnLkFCmGSwohyTdOA7TC24GhH/yaaBPZha39gKKO/t+CCoXw83/1V+a/OMnsizJDwW1JVFaHuRZ71V0/rLayQQIeYlIAvCCJK0NhzYgB0/F+pKWpqeYf/sEIklLU/K/Jn6cO+MRMY9DpP8+A5gANgyd0/BZoRznadixqZcu1Dv7J2XYtSprvqQACVrPKvzAtlrfgrEUMM44NMzb01lck9Gu5oH+6/r57SrKCnMCZHjJRauAQlRUJwopMxAwqjG5HqvXM8UXmS/fpAp3ko0VsGxmZyFohcU6izgeu4yZYgjBPmuYs5JukNUJtgKeu+ik0PcvJUDex3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmzM2lgvd4aD6PrEewGvIeQpsCrxd1nd7nUenOJ2SoE=;
 b=i8BpMiioWaLIl0HYSA39RyxT6MaX+89Z7IoIAF3GCN7o3XJr1x0kr32TaSKoH/NuCpAE8NmhJ7RtqdaSk5pASZBFcboFZyUCyIqo+F88CO/z9zIwzcJSB5QPWy1HFQhjwQCPsVeZHVbnB1r6hPG66cvtVPtT4BBPmmFq4hD9flE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ2PR03MB7111.namprd03.prod.outlook.com (2603:10b6:a03:4f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 08:48:09 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 08:48:08 +0000
Message-ID: <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com>
Date:   Tue, 27 Jun 2023 16:47:44 +0800
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
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
 <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ2PR03MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2108a130-5418-4b49-619c-08db76eb3b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cormfmfg78i2mzOUxHOn4bWT8JtYLUUB0tpyPCdmCMh5qSI51TK4i+D/+A3USN5xxcs3p3W2M6edaXFzkODEB5Yr+qGUwCaQHvWJLqnRyLMIkzSOPf46GvyWuCSjXn1DeKyAjt0UvgdCnfr/oX067pAb96Y2dynObWTaXjUDXYjI9K4CZ2FEE98pNnN3vuZCd+ab/mOwioa7gLzzEVHcQCdHSt/JIRiou5Z5XaTGejVM6kgoU9NxMjYAc5+yRBZ5EChZMgbenSr99twskZuMAqgLGlTn/yHBqdKezCxVB9tKAHSvjtDIzj08A3Y2DruNXKDTCa7QMNXeTkGWAKweaxUe/sHClMXgz/LFGF6BEz8Bl928hzUCoZU/hfVbLHCMIKrzNqanPjuVKYeuxYsMZgOI903NjPo1I0A83TSCi92UZQ2o0SwrPlmp5Gu4DaPVgu77qkblfzuzQRyOWMyHXNeRq0aP1UsMoFwVXWsnYeOyiOdC17py52rWbPbTiJUS03PCqg4h5KPDe0lWfud4KMObhh0taxIjIODQQGzkh+3w/H98DdiJkRJ7ocIJDMOBBUwXWTmsfmCekFaNEPAp6b5Soa/Wm+/gE1L1wyTZouEeuGABk4ky0cX0ar1Umuyf+3wu2uPwwlPBp8nPZ9OyexM+pX4XyM0/QZ5KwJ5uQFC40wkaSmQBAyxXF3qgvOT1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(6506007)(36756003)(66574015)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(53546011)(26005)(6512007)(186003)(30864003)(5660300002)(316002)(86362001)(7416002)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(6916009)(8676002)(66556008)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFyQkd0RkJCZ1lHVTBlWml2WWtFVitvNzl3WDByaWNHdDhBVGtXd1lZUFJZ?=
 =?utf-8?B?OS8zMDQ5Y1ZZMFhvMnhYRXppUWEwb3REblRyWk9PdEl0MVFMZFVua0wxRU8x?=
 =?utf-8?B?SEhXK3dGQW5hd1pmV0RZV05lNE1uaUxlamcwUCtoK091aVp4QTdBSU5KN0pp?=
 =?utf-8?B?VTN4endtSFBaTUhzRXV6RnRQSE1Ja21YOHEyKzNRa0tENWdoV2V0UjNuejZq?=
 =?utf-8?B?Wnk2V2w1UnE0SFJicG1DelUrUHdjZVd2RG9vbjlrVXB2R2dTTXJUcXR6Q09B?=
 =?utf-8?B?b0RTN01XbVZWZHFocStSdEdjRkhzWjVOZ09HbVdpaFZJQmFacDRYS3NBL3ZO?=
 =?utf-8?B?NGwrZ1lReW5vb2UrM2UyTnhBa2tQQmxBMU12OC9DTzJjbHpweW5OUG1EVFhJ?=
 =?utf-8?B?Ri9XUWZ1MDN4NEE4N0VHWjhMbnVuTEFHdG9xYUFDMktIQ2RRQlVtNGVRVUV5?=
 =?utf-8?B?S3ZJTnJuWFF1ZXd5MWI1QnhZSkNrTGhsR3I4cEMzTDAyZHM5K21OU2djdngz?=
 =?utf-8?B?UHFGMUx5VFNJNVJPZWFtblovVExja1BTZGl6dm9JOWZ6cGpKOTRyYmRPL3Zu?=
 =?utf-8?B?Rk1jWnRjNjFMY25RTlplT1VaUWgzUFc2dDdjY2E4dnF3eldRanp1MG8ydDJO?=
 =?utf-8?B?WkJDdk9rQmFXN0wzL1hmT1A1TFVmallOOHUrM2tBd3RzbG9FVHc1VUF2YzNq?=
 =?utf-8?B?bS9Nc29HUyt3WElvRUJ4cTQ1TTFQQXdQS2NzTnVFMzNjaVVTRlFnWm5pZWF3?=
 =?utf-8?B?QVNUMTVCTEZ0Sm1xdTNJc1owZTlSRDNPYjVxdkhQU0tJRHcvMWxKekxKcVho?=
 =?utf-8?B?VERZMEVqc1lWc3FXYjVWVHorbVBPbnpFY1FwNkhoUzRRMHNPTXBJYzM3N3Bt?=
 =?utf-8?B?UHZVVE9EOXN4MG13aEc5MDhwV3FNTlY0SnI5bXdCbjVZV2krRUd3dUtlbGxm?=
 =?utf-8?B?cGd6QkVnOXVWMTFjbUs3YXYxc1hiR1ArRmszSVdQY3kxdTErQjc2OUVEakRz?=
 =?utf-8?B?TVMwZ1hyd1FPM2o3dFpCYlZIT2RBSkZqb2hLcjFEVnZteVdYdVo5YWFjc1hi?=
 =?utf-8?B?Mk1zYTEvcmZKcWY4K2gzZDVnVWRmZ2tFMUViOTZLRlNhQTNQYzVleW9lOXpD?=
 =?utf-8?B?Q1pDcVZUZnFsaUtRZjZvOEw5UXo1T2FRck9zSk5WTWdoZUk5ZlFVQXZ6bFlH?=
 =?utf-8?B?ZVk1dWhxbUF5T0laTzAzTW9iNlE3NU9EU1hTMmhVYmQ0eVhTWGVGTU1DV0Ru?=
 =?utf-8?B?SEZLTEZqc21acXRWQldlcUNXT1JiWXo1S0FBOEpJdEdqa1BNTURKZnVYS2dp?=
 =?utf-8?B?K3hwV2hacUtEOU85Y0dTSkxaa0VXRDBrWVlGVnlRRG9xZE96emdyZWVUeDRE?=
 =?utf-8?B?L0ozSU5JbVRvZjk0UlFzTnVPQlNYSzliaVNzdkJidTNKM2NOT2hTQ0E3d3Vu?=
 =?utf-8?B?SmFiYzFBZnI1dldSdE9aalo2M3NkaSszUllZcVEvaTErZWc3WmxtUGw5bWpP?=
 =?utf-8?B?MGt5RGNSbElOMjRyRUYrdzBNQUF3MTYyYVFhUTdzU1lxNW0ybVRFeStCVmVo?=
 =?utf-8?B?L0tmM1Jxd0NRcUZ1dkYyQW1acGd6OXBWWTZ2dGpycGovYVBESTY0YUlMY09y?=
 =?utf-8?B?czVVZHBMdEcyUVJ1QUpyTXB1M2NiZXdXTXRuTGZXbXhvNitvblhLTlpEdGhS?=
 =?utf-8?B?Yjcwa0VVUzVNTTF6ckR6dm52N1BnSnJkQzFWeE1hWC9VSWppS0EyNDdCM2E0?=
 =?utf-8?B?UlJrbTV6NDFDV3VZS2FRamdqZ3VqcFk0VWs0b3d2NEpleWdLc1VNWFJLLzhS?=
 =?utf-8?B?RmFjbHZ1V3BNRlBPZ2xram5ZMG4vSll0b25UZk5JV3hrVG1ZeXdpRGt1OGI2?=
 =?utf-8?B?MTJvTldBVEx5VSs0OHBSM1VOSmJSZUhUN3g0ekoxMThxeXN0elNCR0kydnNC?=
 =?utf-8?B?SW1ua2swOTJsaVNtR0hkY2FBekJhM0hBblg1TkQ3M0lFTnBhQ1Fwak1WMEUz?=
 =?utf-8?B?Tlo0Nk0rMUJ1SC9aTzlHelZEMnNsTXZ4Y1JEZjlSTFVlUm4yZUdKT3kyNHpu?=
 =?utf-8?B?UW1pUmY3TWFGU0xwL1hDeDNkdGlJZ2NUV0dzY2c5ZUdwQUdKZWF0Snlqb09q?=
 =?utf-8?Q?mhDQDK1ewp7SmJupPLbiVZYA2?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2108a130-5418-4b49-619c-08db76eb3b30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:48:08.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUfq7ERZuGy3ETDi5dc93pHsMZEs3q7P/8IWvUNymh0WJqyZYrOwcnJ0UU2gCvfG6axrWEeiUHUSXSXsOECgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/23 16:43, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>
>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>   .../media/v4l/vidioc-delete-buf.rst           | 51 
>>> +++++++++++++++++++
>>>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>   include/media/v4l2-ioctl.h                    |  4 ++
>>>   include/media/videobuf2-core.h                |  9 ++++
>>>   include/media/videobuf2-v4l2.h                | 11 ++++
>>>   include/uapi/linux/videodev2.h                |  2 +
>>>   10 files changed, 128 insertions(+)
>>>   create mode 100644
>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>> @@ -17,6 +17,7 @@ Function Reference
>>>       vidioc-dbg-g-chip-info
>>>       vidioc-dbg-g-register
>>>       vidioc-decoder-cmd
>>> +    vidioc-delete-buf
>>>       vidioc-dqevent
>>>       vidioc-dv-timings-cap
>>>       vidioc-encoder-cmd
>>> diff --git
>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>> new file mode 100644
>>> index 000000000000..0e7ce58f91bc
>>> --- /dev/null
>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>> @@ -0,0 +1,51 @@
>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>> +.. c:namespace:: V4L
>>> +
>>> +.. _VIDIOC_DELETE_BUF:
>>> +
>>> +************************
>>> +ioctl VIDIOC_DELETE_BUF
>>> +************************
>>> +
>>> +Name
>>> +====
>>> +
>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>> +
>>> +Synopsis
>>> +========
>>> +
>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>> +
>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>>> +
>>> +Arguments
>>> +=========
>>> +
>>> +``fd``
>>> +    File descriptor returned by :c:func:`open()`.
>>> +
>>> +``argp``
>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>> +
>>> +Description
>>> +===========
>>> +
>>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF` ioctl to
>>> +delete a buffer from a queue.
>>> +
>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>> +:ref:`buffer`.
>>> +
>>> +Return Value
>>> +============
>>> +
>>> +On success 0 is returned, on error -1 and the ``errno`` variable is 
>>> set
>>> +appropriately. The generic error codes are described at the
>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>> +
>>> +EBUSY
>>> +    File I/O is in progress.
>>> +
>>> +EINVAL
>>> +    The buffer ``index`` doesn't exist in the queue.
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>> index 899783f67580..aa546c972c3d 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
>>> unsigned int index, void *pb)
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>
>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>> +{
>>> +       struct vb2_buffer *vb;
>>> +
>>> +       vb = vb2_get_buffer(q, index);
>>> +       if (!vb) {
>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>> +               dprintk(q, 1, "can't delete non dequeued buffer index
>>> %d\n", index);
>>> +               return -EINVAL;
>>> +       }
>>> +
>> I know the driver could implement its own
>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>> used by the hardware as a future reference frame.
>> But I think we need a flag to let the user know which buffer is still
>> used by the hardware.
>> Alternative ref case is safe, we only know it's existing when it is
>> dequeued in current V4L2 buffer mechanism.
>> While the Golden reference frame, such long term reference frame could
>> last much longer.
>
> It is up to userland stack to know frames life time, it got the 
> information for that.

That is true for the stateless codec driver.

While application for stateful decoder could never do that. It also 
breaks what the document said:

"The backing memory of |CAPTURE| buffers that are used as reference 
frames by the stream may be read by the hardware even after they are 
dequeued. Consequently, the client should avoid writing into this memory 
while the |CAPTURE| queue is streaming. Failure to observe this may 
result in corruption of decoded frames."

>
>>> +       if (vb->planes[0].mem_priv)
>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>> +
>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>> +               __vb2_buf_mem_free(vb);
>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>> +               __vb2_buf_dmabuf_put(vb);
>>> +       else
>>> +               __vb2_buf_userptr_put(vb);
>>> +
>>> +       vb2_queue_remove_buffer(q, vb);
>>> +       kfree(vb);
>>> +
>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>> +       return 0;
>>> +}
>>> +
>>>   /*
>>>    * vb2_start_streaming() - Attempt to start streaming.
>>>    * @q:         videobuf2 queue
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> index 724135d41f7f..cea666c17b41 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
>>> media_device *mdev,
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>
>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>> +{
>>> +       return vb2_core_delete_buf(q, b->index);
>>> +}
>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>> +
>>>   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers
>>> *create)
>>>   {
>>>          unsigned requested_planes = 1;
>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>> index f81279492682..80ace2e1e932 100644
>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>> video_device *vdev)
>>>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>> vidioc_prepare_buf);
>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON, 
>>> vidioc_streamon);
>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>> vidioc_streamoff);
>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>> vidioc_delete_buf);
>>>          }
>>>
>>>          if (is_vid || is_vbi || is_meta) {
>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> index a858acea6547..1c737279d3ef 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>> v4l2_ioctl_ops *ops,
>>>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>   }
>>>
>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>> +                         struct file *file, void *fh, void *arg)
>>> +{
>>> +       struct v4l2_buffer *b = arg;
>>> +       int ret = check_fmt(file, b->type);
>>> +
>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>> +}
>>> +
>>>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>                                  struct file *file, void *fh, void 
>>> *arg)
>>>   {
>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>> v4l2_ioctls[] = {
>>>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>> v4l_print_freq_band, 0),
>>>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>   };
>>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>
>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>> index edb733f21604..2f232ed884c7 100644
>>> --- a/include/media/v4l2-ioctl.h
>>> +++ b/include/media/v4l2-ioctl.h
>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>    * @vidioc_prepare_buf: pointer to the function that implements
>>>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>> + * @vidioc_delete_buf: pointer to the function that implements
>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>    * @vidioc_overlay: pointer to the function that implements
>>>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>    * @vidioc_g_fbuf: pointer to the function that implements
>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>                                    struct v4l2_create_buffers *b);
>>>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>                                    struct v4l2_buffer *b);
>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>> +                                struct v4l2_buffer *b);
>>>
>>>          int (*vidioc_overlay)(struct file *file, void *fh, unsigned
>>> int i);
>>>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>> diff --git a/include/media/videobuf2-core.h
>>> b/include/media/videobuf2-core.h
>>> index 080b783d608d..0f9e68f76b77 100644
>>> --- a/include/media/videobuf2-core.h
>>> +++ b/include/media/videobuf2-core.h
>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>> enum vb2_memory memory,
>>>    */
>>>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
>>> void *pb);
>>>
>>> +/**
>>> + * vb2_core_delete_buf() -
>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>> + * @index:     id number of the buffer.
>>> + *
>>> + *  Return: returns zero on success; an error code otherwise.
>>> + */
>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>> +
>>>   /**
>>>    * vb2_core_qbuf() - Queue a buffer from userspace
>>>    *
>>> diff --git a/include/media/videobuf2-v4l2.h
>>> b/include/media/videobuf2-v4l2.h
>>> index 88a7a565170e..3beeb4c735f0 100644
>>> --- a/include/media/videobuf2-v4l2.h
>>> +++ b/include/media/videobuf2-v4l2.h
>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
>>> v4l2_create_buffers *create);
>>>    */
>>>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>>                      struct v4l2_buffer *b);
>>> +/**
>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>> + *
>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>> + * @b:         buffer structure passed from userspace to
>>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>> + *
>>> + * The return values from this function are intended to be directly
>>> returned
>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>> + */
>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>
>>>   /**
>>>    * vb2_qbuf() - Queue a buffer from userspace
>>> diff --git a/include/uapi/linux/videodev2.h
>>> b/include/uapi/linux/videodev2.h
>>> index aee75eb9e686..31bba1915642 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>> v4l2_dbg_chip_info)
>>>
>>>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>> v4l2_query_ext_ctrl)
>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>>> +
>>>
>>>   /* Reminder: when adding new ioctls please add support for them to
>>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>> -- 
>>> 2.39.2
>>>
-- 
Hsia-Jun(Randy) Li

