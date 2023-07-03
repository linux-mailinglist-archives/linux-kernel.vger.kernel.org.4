Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58A74572B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGCIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:20:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C8E50;
        Mon,  3 Jul 2023 01:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XphMNy073VQwqBh4GTxk6mxecM0h72TBmL1B6m5t6Q1gUSBfH5cgQQOBNToWR1ZdZd18VGIcSBqHQl1WhpqHUV4viubHW8yPSRK0LyY6/YOb7+Qe1lGI/fpGXdVokQD8+tntZ/xWUa1lYwSzvvYs6zEhlxnaX4InmbHoL9BebI29RQJixr8bLEAQ7yboYeh+NIalKI3s7ffXqgTjjucVDiCfxvTapwlExGdDaS2U43ItbMCxwYVqZMlA/9GmTMSHCb/QEbwhOVOmQL0STWD7XF0SQkVrTanv2U/qWHNmTuKE0mS4Bis4Hdt0mD33Zh7cDkhlezbvW7/3z4u74fpdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKgkWO/CzMS1dRsC9nBLkaD5Lx1UJZ+tJWCh2zexfPQ=;
 b=INR2xiUu8mI6Zv8wah8Mrz7Cuzsz/LVf24Du1GMD9aPcIE9z6MHc0GwcTmojOBLX9tnf8i9lgQ9TweVK60NcAKeYhOZ5lriJQV9iQazrwi0zP3ZZ22OGm7sH5ohyUbLVUvJNJgZuvY3XUmnbsTkIwJQiDcYGds914kov+L8RpxJy5Eg5po061xFzgMRo7afwx8jDIO2hmJMfb6ZpTtY6dX3a7LXXeIrRtKMQOziHusp1hXkqi7xFxnByQiBsBlgQjSVlnBLS+NpCpNvrodE22YJUZKg41SV0MC+2N+tY0522qyMO9nvXvc9Y+Ie19KUBMWKaY2kJEuALC1I2EFeiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKgkWO/CzMS1dRsC9nBLkaD5Lx1UJZ+tJWCh2zexfPQ=;
 b=FbD/o/Axou6ZM4bKXw8XoXbHb/kJEqaQSNbT8D02FNg/HHwff4k5LMpd5Vl8HkhxrOrLynOSLeRUrl8ysVqxf9faMJvgMApWZd/A/dJM3841JNX0QdgJbMW479p79kz+Nm2AYW5nFwotJ1D4Utr6CRlPjUSM13JkoZc8m5mg0mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CO1PR03MB5732.namprd03.prod.outlook.com (2603:10b6:303:97::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:20:12 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:20:12 +0000
Message-ID: <483472c8-74fd-4208-343e-4a8bf79dc6e7@synaptics.com>
Date:   Mon, 3 Jul 2023 16:19:59 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <0f4fd31f-ef61-8dee-7a88-55263f266975@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CO1PR03MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0e73e3-e0f8-42aa-957d-08db7b9e5249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzIq1umtCAfxtZKW21IRwGFBxLzMxo7qTlnL8kcMnWGz1WV8okbZCkD6D8fW30P/iHqWV4ttEUXblRwL05IC5nkOorGA1suj2S+3L8HFx9oqiyfR0pHTFnv6fEHdfTecrWIVTxTFBqrPAiikUEkBJtVMTq6Pfp0geHJF6pZaMZXOOlgCNBbGpOQmKOVow7cAtRzn7v1+ul+muX/pZ9MVWYIbpsWhbscuEqBfJ2R5HUR0pjz5NcJj88HzQxAAJ9L3/G6ktojFJbwCOTjBqgdNVEu6qZteH1wgs6q/Gc42IH/DjkAuk0WKG2HXt2fQfknj97b4f3G0d+ZwhASooivkBkpTrL6La3XYtp6sH0L08bw7yu1qjbhwh4Inr/7OxwEDuKSsLYr1Q8925zE+sx5cruUyVkGj0pTOZTy3benC4FniQkwfPgew9GhOHxiqscSDXjND0wsPIeFCfXGpdr7K3VXyi8PBGN123PEtNzK7i7AoQdvDmGhOgHCPfLc5c0C+wecUxihG12XiKmEwN3ynuKj4FSNQGp4XUybJZJGT28WSvusBqPVNv/cGPaYL95IWyWpZ+gZYCZ56y36mADlyhqOH84TlJcDLico6loozFNOd7zhLeG94P3uP1ZTaIyrbL6lbBAbsynPNakSXXE+rIBN8mV0NXNvRO4JuPSxxVh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(30864003)(2906002)(41300700001)(66899021)(5660300002)(8936002)(8676002)(7416002)(36756003)(31696002)(86362001)(186003)(2616005)(31686004)(478600001)(26005)(6512007)(966005)(6506007)(6666004)(53546011)(6486002)(52116002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(38100700002)(38350700002)(66574015)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0Nib1JWTmFMb2FqbGJDQXNvVkhKNTBrSDNXL1p2eG1VclJWR1ZZcmtWZlky?=
 =?utf-8?B?UWRQN21zYkswbzcxR21MRVQ0MzR4aWFPREhxcXhYcHRvaWdJelptSUhtRjNN?=
 =?utf-8?B?anl5cGNxeDNYcThXaDlzUlYyZkQ0STA3R1EvS2I0bGNzd0c3elBsaDc2R2F6?=
 =?utf-8?B?Y2lDbW02YWVmbWptRHV5YXhsVkNSOHcrcW5ucXc0MHBLazR3cGtZZ3I1TDZT?=
 =?utf-8?B?MmptbzJDRmo3OG5FT3d5NDFZbjBSaW41azBSa3U4OFlDemhva281Z0w5WGZN?=
 =?utf-8?B?bUVaWXhQZ1hoQU1aT3FQSHZvSkJrcFR1a21zQWlVQzFzdmdHWW51U3NITzdW?=
 =?utf-8?B?Y2dJdzdyOEFlRDhYb3ZnM3M5cTM3YXY3S0NaRFQ0bWRaczgrZlhsTk1QNHFq?=
 =?utf-8?B?V3IwVXFnZ2J6NmxRb2dBZVZvekt1Zkl5VEkwVFNEUzFTSDZGeFJEWmE1ZjZ5?=
 =?utf-8?B?R3Z1dDE2ZkhBbks2b2xKZkNGajZDSkk0L05ya1NJemoySUlibUVaVlg0U1oz?=
 =?utf-8?B?T09CSlh2SEx4ODU1ZWhMb0UxSzQ0TGdHOGRRYi9aZmpLaDNGM25zSUUxSkov?=
 =?utf-8?B?MHo3eHNKaXNsL0t4Ym9Sb01vWGdUNDBWcy9YaTFsZkNHeWg2dWhUejBJOHFE?=
 =?utf-8?B?bnIzc0VCbUZkZS93TVpISUl4VG9DKzllTnlpWHlTOGs0UkpNcjVsWFNhU2l3?=
 =?utf-8?B?QkllTi9yZU1VcSt6ZkJiOVFmcXNqSXhuVFV1bUxnRHFLcnJGVDFXZGhBRlk1?=
 =?utf-8?B?MkVoM0JLdzFPalhZOWlERGE5RGppeWIyMFZDUTk5dG1IdTEwYzFqRWpVWFBO?=
 =?utf-8?B?Tk9FQlF5RTR4V2srNGhCbWUrTHg4Z0FrbC90M3NpSmExY2NDaHNXZ2VRd0hi?=
 =?utf-8?B?bUw2dkQrL1hBdG1UeC9LWjd4dEtFRXNSTzFERkoxczl6TDhRNitrS0cxN05l?=
 =?utf-8?B?cGlnYzNrWVY0UURIUUF0NzFqTUJLWWlmMlpva3pJWTJTbzJVVi9hc2R2MEN5?=
 =?utf-8?B?Qko1Q0RXZU9Ub1Q2WUd6VE85VjI2Y3BRUDZmNzNYTEVYRG9MQTZqeFh1aXlz?=
 =?utf-8?B?dmozOFIyanVodVN4ekxvdlpFdU5pSjgxUG1uV2kvRVNRRzQ5MTZEUFJzZDRo?=
 =?utf-8?B?SFY0cFZlY0RvcloxeW9JbklXbXFlbktHNnJSK2xiVVZHZzd1YmpnazZFaXNa?=
 =?utf-8?B?bDFKTm5ZcGpyN01WNlVWbVVnKy9KUHRtMThwR0x6U2VWeHdhYVVmYy9WN1FX?=
 =?utf-8?B?dzBDWjlYZ04rWkVTRTIxUHNHRTh2RFlPL1A4UGJIU1RLdWV3Z0crSzVCVmpw?=
 =?utf-8?B?QlBNbnVleXcvR0FRaWRBTzhwb2N2VVpoMldmTGlRUUVUcWEyNUtoeHMvUCtU?=
 =?utf-8?B?eU1MTDJ2SUVPQ2VzK2lNeWNNc1hsbVE3N09nVm1ka09RVDBtYnJGT0FSd1FI?=
 =?utf-8?B?Y1JoMnpiMVBnaE5HT0hWTHhPN1ZPbkp3a3ZhZlAyd3VTMXRObXI2UkJIeTBJ?=
 =?utf-8?B?Y1ZJelp5cnE2QXRPSXhtdGxIWGlFWFVuWVJiQWRmd243c0VlOVpsWEd5aUo5?=
 =?utf-8?B?SFZqTW9OdzFkaEpZQURDbUJxNGQ5Wno5MXVva0licWtHdmlDK3d3T1BzTzAv?=
 =?utf-8?B?U2xFZXRYN0xxcHBSWUhLdGhRd1htL3BQMjRDV2QyUjk1VSt0dmVSZEIzTWNN?=
 =?utf-8?B?ZmtEYmRFRHltNUZIbERhZ2ZFQ3JDZW9ndUxSK2Q0WUhOdkcyWHViM1F3M2o1?=
 =?utf-8?B?eHhoMkxCOUx5ckdxTCtFWTZwVkxqK2liNXNIUGJWM0lmdVdURHpYYi9aL0N6?=
 =?utf-8?B?VHo4ZFNWNklyVFkwWG90UDduUWRDckFPU3FIczZ1TlRNeUxQMzlJTXZWdXRy?=
 =?utf-8?B?b0pDNG9tR1loVUNWS1RqQ3ZxREhURlFxbWsyV0ZrbzduZXB2L0MvZHB2SUpt?=
 =?utf-8?B?RlVycDNZbjhHNHpPaDRYRW9TRXYvMmV3MkY3Ym1lcGtmell4K1k5TE1rdkF0?=
 =?utf-8?B?cVd1NEJBemM1STZOTHNFcWRsci9XV2ZkRGZtOW9Fbk52MHE1cVpkdmZCRy9x?=
 =?utf-8?B?NTdLSXN6dWZMbTlLQk84b1hQN0sySGNjOEErY0V6S1J4cmdtRFFDc1hrN1Rh?=
 =?utf-8?Q?ivYOYr8bwWK3O9E+kVjI/4pAQ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e73e3-e0f8-42aa-957d-08db7b9e5249
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:20:12.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hD1dbsJyit5qDoNOjwZwBl2AGxepEOLxSmM67GThvhXaTZFgCOWV0gF8OLodDTGLyn8evtsxxuygAcFo83yNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5732
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 16:12, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> Le 30/06/2023 à 11:43, Hsia-Jun Li a écrit :
>>
>> On 6/27/23 16:47, Hsia-Jun Li wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> On 6/27/23 16:43, Benjamin Gaignard wrote:
>>>> CAUTION: Email originated externally, do not click links or open
>>>> attachments unless you recognize the sender and know the content is
>>>> safe.
>>>>
>>>>
>>>> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>>>>
>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>> attachments unless you recognize the sender and know the content is
>>>>>> safe.
>>>>>>
>>>>>>
>>>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>>>>
>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> ---
>>>>>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>>>>   .../media/v4l/vidioc-delete-buf.rst           | 51
>>>>>> +++++++++++++++++++
>>>>>>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>>>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>>>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>>>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>>>>   include/media/v4l2-ioctl.h                    |  4 ++
>>>>>>   include/media/videobuf2-core.h                |  9 ++++
>>>>>>   include/media/videobuf2-v4l2.h                | 11 ++++
>>>>>>   include/uapi/linux/videodev2.h                |  2 +
>>>>>>   10 files changed, 128 insertions(+)
>>>>>>   create mode 100644
>>>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> @@ -17,6 +17,7 @@ Function Reference
>>>>>>       vidioc-dbg-g-chip-info
>>>>>>       vidioc-dbg-g-register
>>>>>>       vidioc-decoder-cmd
>>>>>> +    vidioc-delete-buf
>>>>>>       vidioc-dqevent
>>>>>>       vidioc-dv-timings-cap
>>>>>>       vidioc-encoder-cmd
>>>>>> diff --git
>>>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..0e7ce58f91bc
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> @@ -0,0 +1,51 @@
>>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>>>> +.. c:namespace:: V4L
>>>>>> +
>>>>>> +.. _VIDIOC_DELETE_BUF:
>>>>>> +
>>>>>> +************************
>>>>>> +ioctl VIDIOC_DELETE_BUF
>>>>>> +************************
>>>>>> +
>>>>>> +Name
>>>>>> +====
>>>>>> +
>>>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>>>>> +
>>>>>> +Synopsis
>>>>>> +========
>>>>>> +
>>>>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>>>>> +
>>>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>>>>>> +
>>>>>> +Arguments
>>>>>> +=========
>>>>>> +
>>>>>> +``fd``
>>>>>> +    File descriptor returned by :c:func:`open()`.
>>>>>> +
>>>>>> +``argp``
>>>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>>>>> +
>>>>>> +Description
>>>>>> +===========
>>>>>> +
>>>>>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF`
>>>>>> ioctl to
>>>>>> +delete a buffer from a queue.
>>>>>> +
>>>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>>>>> +:ref:`buffer`.
>>>>>> +
>>>>>> +Return Value
>>>>>> +============
>>>>>> +
>>>>>> +On success 0 is returned, on error -1 and the ``errno`` variable is
>>>>>> set
>>>>>> +appropriately. The generic error codes are described at the
>>>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>>>>> +
>>>>>> +EBUSY
>>>>>> +    File I/O is in progress.
>>>>>> +
>>>>>> +EINVAL
>>>>>> +    The buffer ``index`` doesn't exist in the queue.
>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> index 899783f67580..aa546c972c3d 100644
>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
>>>>>> unsigned int index, void *pb)
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>>>>
>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>>>>> +{
>>>>>> +       struct vb2_buffer *vb;
>>>>>> +
>>>>>> +       vb = vb2_get_buffer(q, index);
>>>>>> +       if (!vb) {
>>>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>>>>> +               dprintk(q, 1, "can't delete non dequeued buffer 
>>>>>> index
>>>>>> %d\n", index);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>> I know the driver could implement its own
>>>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>>>>> used by the hardware as a future reference frame.
>>>>> But I think we need a flag to let the user know which buffer is still
>>>>> used by the hardware.
>>>>> Alternative ref case is safe, we only know it's existing when it is
>>>>> dequeued in current V4L2 buffer mechanism.
>>>>> While the Golden reference frame, such long term reference frame 
>>>>> could
>>>>> last much longer.
>>>>
>>>> It is up to userland stack to know frames life time, it got the
>>>> information for that.
>>>
>>> That is true for the stateless codec driver.
>>>
>>> While application for stateful decoder could never do that. It also
>>> breaks what the document said:
>>>
>>> "The backing memory of |CAPTURE| buffers that are used as reference
>>> frames by the stream may be read by the hardware even after they are
>>> dequeued. Consequently, the client should avoid writing into this 
>>> memory
>>> while the |CAPTURE| queue is streaming. Failure to observe this may
>>> result in corruption of decoded frames."
>>>
>>>>
>>>>>> +       if (vb->planes[0].mem_priv)
>>>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>>>>> +
>>>>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>>>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>>>>> +               __vb2_buf_mem_free(vb);
>>
>> Here is another problem for the existing application, the mmap() from
>> the mmap offset or exportbuffer fd would not create a reference to
>> buffer in this step(while the exportbuffer would create one itself).
>>
>> When you delete a buffer, you may not release it from its virtual
>> memory space, leaving a corrupted virtual memory space. Also this
>> behavior is right, because mmap(2) says:
>>
>> "After  the  mmap()  call has returned, the file descriptor, fd, can
>> be closed immediately without invalidating the map‐ping."
>
> Existing applications do not call DELETE_BUF ioctl and when call it 
> they will be aware that the buffer is removed.
> I have done it in GStreamer:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.freedesktop.org_benjamin.gaignard1_gstreamer_-2D_commit_fca0fbc934f4440693ce0ff6c8dc8a2e5f5f17d9&d=DwIDaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=TGH9toTzGRfO5aBsfaMvGbcOw-28q6cPmpX6vScbHjpCtaLtb-RuvBvsJ0z9RvAB&s=Ufl1ccfRZf2EhnfCBvnQzRJV9CDhGxl5spe9WNECspU&e= 
>

I have read that.

There is not a VP8 parser in Gstreamer, while a parser would not work 
when deal with the secure video(userspace can't access the data context 
at all).

Besides, this adds extra work for the application for a stateful codec 
driver. The application need to parser the bitstream and track the dpb.

I don't mind if you could fix the nonfiction mechanism for those 
non-display frame and internal reference state.

That could be requirement for codec firmware that its driver could 
support this DELETE_BUF ioctl() feature.

>
> Regards,
> Benjamin
>
>>
>>>>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>>>>> +               __vb2_buf_dmabuf_put(vb);
>>>>>> +       else
>>>>>> +               __vb2_buf_userptr_put(vb);
>>>>>> +
>>>>>> +       vb2_queue_remove_buffer(q, vb);
>>>>>> +       kfree(vb);
>>>>>> +
>>>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>   /*
>>>>>>    * vb2_start_streaming() - Attempt to start streaming.
>>>>>>    * @q:         videobuf2 queue
>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> index 724135d41f7f..cea666c17b41 100644
>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
>>>>>> media_device *mdev,
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>>>>
>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>>>>> +{
>>>>>> +       return vb2_core_delete_buf(q, b->index);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>>>>> +
>>>>>>   int vb2_create_bufs(struct vb2_queue *q, struct 
>>>>>> v4l2_create_buffers
>>>>>> *create)
>>>>>>   {
>>>>>>          unsigned requested_planes = 1;
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> index f81279492682..80ace2e1e932 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>>>>> video_device *vdev)
>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>>>>> vidioc_prepare_buf);
>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
>>>>>> vidioc_streamon);
>>>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>>>>> vidioc_streamoff);
>>>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>>>>> vidioc_delete_buf);
>>>>>>          }
>>>>>>
>>>>>>          if (is_vid || is_vbi || is_meta) {
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> index a858acea6547..1c737279d3ef 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>>>>> v4l2_ioctl_ops *ops,
>>>>>>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>>>>   }
>>>>>>
>>>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>>>>> +                         struct file *file, void *fh, void *arg)
>>>>>> +{
>>>>>> +       struct v4l2_buffer *b = arg;
>>>>>> +       int ret = check_fmt(file, b->type);
>>>>>> +
>>>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>>>>> +}
>>>>>> +
>>>>>>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>>>>                                  struct file *file, void *fh, void
>>>>>> *arg)
>>>>>>   {
>>>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>>>>> v4l2_ioctls[] = {
>>>>>>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>>>>> v4l_print_freq_band, 0),
>>>>>>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>>>>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>>>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>>>>   };
>>>>>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>>>>
>>>>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>>>>> index edb733f21604..2f232ed884c7 100644
>>>>>> --- a/include/media/v4l2-ioctl.h
>>>>>> +++ b/include/media/v4l2-ioctl.h
>>>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>>>>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>>>>    * @vidioc_prepare_buf: pointer to the function that implements
>>>>>>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>>>>> + * @vidioc_delete_buf: pointer to the function that implements
>>>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>>>>    * @vidioc_overlay: pointer to the function that implements
>>>>>>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>>>>    * @vidioc_g_fbuf: pointer to the function that implements
>>>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>>>>                                    struct v4l2_create_buffers *b);
>>>>>>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>>>>                                    struct v4l2_buffer *b);
>>>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>>>>> +                                struct v4l2_buffer *b);
>>>>>>
>>>>>>          int (*vidioc_overlay)(struct file *file, void *fh, unsigned
>>>>>> int i);
>>>>>>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>> b/include/media/videobuf2-core.h
>>>>>> index 080b783d608d..0f9e68f76b77 100644
>>>>>> --- a/include/media/videobuf2-core.h
>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>>>>> enum vb2_memory memory,
>>>>>>    */
>>>>>>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
>>>>>> void *pb);
>>>>>>
>>>>>> +/**
>>>>>> + * vb2_core_delete_buf() -
>>>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>>>>> + * @index:     id number of the buffer.
>>>>>> + *
>>>>>> + *  Return: returns zero on success; an error code otherwise.
>>>>>> + */
>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>>>>> +
>>>>>>   /**
>>>>>>    * vb2_core_qbuf() - Queue a buffer from userspace
>>>>>>    *
>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>> index 88a7a565170e..3beeb4c735f0 100644
>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
>>>>>> v4l2_create_buffers *create);
>>>>>>    */
>>>>>>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device 
>>>>>> *mdev,
>>>>>>                      struct v4l2_buffer *b);
>>>>>> +/**
>>>>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>>>>> + *
>>>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>>>>> + * @b:         buffer structure passed from userspace to
>>>>>> + * &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>>>>> + *
>>>>>> + * The return values from this function are intended to be directly
>>>>>> returned
>>>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>>>>> + */
>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>>>>
>>>>>>   /**
>>>>>>    * vb2_qbuf() - Queue a buffer from userspace
>>>>>> diff --git a/include/uapi/linux/videodev2.h
>>>>>> b/include/uapi/linux/videodev2.h
>>>>>> index aee75eb9e686..31bba1915642 100644
>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>>>>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>>>>> v4l2_dbg_chip_info)
>>>>>>
>>>>>>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>>>>> v4l2_query_ext_ctrl)
>>>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>>>>>> +
>>>>>>
>>>>>>   /* Reminder: when adding new ioctls please add support for them to
>>>>>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>>>> -- 
>>>>>> 2.39.2
>>>>>>
>>> -- 
>>> Hsia-Jun(Randy) Li
>>>
-- 
Hsia-Jun(Randy) Li

