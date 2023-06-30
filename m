Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9374388F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjF3JoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjF3JoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:44:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772B2122;
        Fri, 30 Jun 2023 02:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6UISPD85L4hI+Iq6UPMCIXnQ/U/BaQ48sLC6p1HmAZLflkk+xAE3V8Ei5xOD7CHJiuduhAykRDFm7JJsvYdl2FZnvUQ+npIW80p37yhLALAISEHSALo50V15iZDf/2lWktrK0V/7sQPM5hX4Xem0mw7CXMNQRG7B7p/yoMi2K0oU2EZezBUi6KIgJye92wMFcoTOKUiIk8lQxmFGTM78zt+7jAfMj8bskeh1PsmAmJRHMfAMLPs++jahJKF90H8b7BdAavpQtJQ80Y/u9r3Y+Kie5K1Tv9/D4Q1wPc9AuCwDFPH64wyTVERPXu4yTBzdMa0WjuuuF9uIEfgw6XDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7DkB/DmvYTnQLjlghxo72nuTlcCLT1Int1j/ApLVMo=;
 b=ZI1TPX4EZUsxWsIdXJjoujC9DaYPmRxMh4+8FKv4MKC+GXB+Yr+ump3Urv5P/WJsiaoIW1hw9YYElIuSjPqoxoO2ZSxthhYa697lUfk+D1U4YVLQtL3NNVqe1Pjl84FOW7IP+KjNC1j31TzDgzVh8lKLDsBlSoZTAtsnYfqdbz3kMf5FBjBz8wzzrTFPBvJFFIm0uwxo4uT+MZsyBxgZeUMqiIcGjv2TK0nX7A2l2DkrLkoVVO2dD933kVNwO+wBXGEz7aDwbUOYf1t4+o8mvBC9jjMkxQdUCHngA0YbBMJ7AsaR5RjocXOEDbJQEya/n4UsamkAzophjPpK7h/zTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7DkB/DmvYTnQLjlghxo72nuTlcCLT1Int1j/ApLVMo=;
 b=oXgAU3glnsO9g4V4zwGx6php3/MMLzxMU6pUpiQchto0vc9zRq5GXdsdfGwocUFx8e63Mx5vw+zYcqyslryeMVi4o8fV+qXma0+3jmk1HoolBBK380rGCsHmkOuRIg063HlmPVDSNjX1mwvKr/HnjIb+NsjeKYIbCM4aSQOAMUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SA2PR03MB5722.namprd03.prod.outlook.com (2603:10b6:806:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 09:44:01 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:44:01 +0000
Message-ID: <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
Date:   Fri, 30 Jun 2023 17:43:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Content-Language: en-GB
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
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
In-Reply-To: <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::24) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SA2PR03MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 39baca81-1323-449b-7275-08db794e888c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7FBEZEFnt7NJ6N/cIalxbp6aRNdqTFxWHyszGvUr8f7usXJqGJnJndrnRDP3mpN8fB4XtWUWg9mejFcXCz2oQZInsPISXthohG325O7HL7ELG4lt04q+AquRrWNC3BdyjZNMU3jQeuQ5yfVq+nCfOwBl2cEfnNESukmlj3M1KjPCiItXEc/gu+vnUisSFrf7nU9crqP4u4sNm7mAjR6Xfkfp6lblY0s+hRcLLSb3t9mNi8oXC4/UQi8OZkiPJJ+GGnjvjIoDqp3Ziq/3vK4J9vNRc1L4NIX/Ck1zHG1hgI4bHTMYhkD9FQVizoIcz1igQ4x4XlcSBzCjmohOdW24TbeXfCDrmuBhqPGDpp98ZITsPpt7VLXqPVhMjvg+muRe5f5/33ahE2yPHfHqfKYtDf9uBwu1BQZQQn5W6SxGab9hJPpL2qTJIXOFP4zmXSbjgyGxnups1/OReSiq8uAZkDBnXmkA04OtNommJSpr+P38FYqYJH1ZlyvmsOKzNkaQWV0oRKSP5PeHpvOPF04Ul1Pw4xeTYICpRRfS91RrpHSLRz/n9OP4f5Dw2wDhNtDbic30dkJ0VNLj7n6Rmvtd369D36dfmEiuXCUQ7LJ8jdRqA2vOe8Ed2YQmmbU+DaTPxNoIFW6/j/u599Grn5qQuRwFHZeStc7tmTU2N25RlPVOf9FQnt2u5HuquITaCER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39850400004)(451199021)(38100700002)(38350700002)(31696002)(86362001)(36756003)(31686004)(66946007)(6486002)(8676002)(41300700001)(478600001)(53546011)(8936002)(6506007)(5660300002)(6512007)(26005)(7416002)(2616005)(30864003)(186003)(66574015)(83380400001)(2906002)(52116002)(4326008)(6666004)(66476007)(66556008)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Z4WVJMUGdDSHVIdVE0NmFDYVZ3MDhCOGwxaXVFRDBFaFlSQ3RsU0t0Mk1X?=
 =?utf-8?B?SXZ2c0JMbUNOREUzbG5rQ0RzMmZMS1BjYXNFTzNFVXlEUlovUXlwVGNGMUxS?=
 =?utf-8?B?NUFoSmRvaXpQMFpPcmdQY0tvcWRsMEl4M1hCYmMweEdsem1TTHB3R2xhdW01?=
 =?utf-8?B?WitaWHVrbm5udGF6Q2VQWUNzMFZCWGNLYlJvVWhmLy9Ha1l5UjUxOXJLTG9X?=
 =?utf-8?B?UWdkRGZ4MnpYL3JhSG0rTDVoVkQ1VzNkN3ZYMXgwaC83blpVMGFJMTRtUUF5?=
 =?utf-8?B?QkNWdC91T09FL2tQYWZpYk5yQ0FzQ3dTS2ZIM1I5NmZvUisvRXJ3RTNGSnhZ?=
 =?utf-8?B?amt3UjF5eUVCL1Bhc0RSKzV2Y2RQRnk2REFmc2x4M04wMldGK3Z2SFBJQ3Zu?=
 =?utf-8?B?aEhubjZvbkNCZWxTRERiemplVkFIVnpIS2l6VDN4YzVGYVdraTFxUlNVS2NI?=
 =?utf-8?B?eUIrU1o2bGgrbVZEZm5UT2JBZGNzcFAyWEFESURKTzdEYytoQzlxVmJ3THU5?=
 =?utf-8?B?VEliZFFnNmk4WlI3OUxpblVKNG8xaG5XcFNrUG9vSXZUUmxOOURkQXhUKzBY?=
 =?utf-8?B?ZWNaOTk1K2ZWWkpEMlRRMXhBenVmT3R2UUx4cDRrOE9ldFRBYmZJRERUMDhj?=
 =?utf-8?B?ZllvMXR1Qk1hTlBkeVBqK0FMcHVVcHc0KytkTktGMGZLOFNvZDZLNSthRVll?=
 =?utf-8?B?Q0hWREhjYVplV3QySVBHc3Era3ptR0IrQkdzMEo2YXVrV2s1Q2hvZkJid0F5?=
 =?utf-8?B?MHNwckpOa1ZqMWU0UEFkRVlzNG5ab0hKVUZBTEUyTnNlb051d0tVdmVTVHFx?=
 =?utf-8?B?NWM3UkRQaUJBemREbUZVYlNTNkFjRzFTdGVDczQvT1c5Z0ZVcmp6UGV1ZGY3?=
 =?utf-8?B?V1IrL3BZbGUvZUp2MFJ1ZGQ4dFJwRmRPbXo1NU1hOTdtNHhZUldwK2JOWFkx?=
 =?utf-8?B?Mi9Vcy9ZMFNncjNUN0FLcTZPcWNhdDBoaUE2RS9QZ2tRaGZSN2V1OWdDUGFY?=
 =?utf-8?B?WlRMSXdzSVhMelRkUTJYSi8rRi9NN2pLa2QrN0c4Tzc1TDlPZm8yMGhZVHlt?=
 =?utf-8?B?bUtNaVZqS3lEZ3lySC9FalQ4L2F2TW9yZ3A5TVVLQlFXYlB5dDcrZlAzMloy?=
 =?utf-8?B?cU9hR2JsMGFmeEdkWW0waHA0UU1XaktvQW11YURRZ0t0VTI2SnNGL05GdzI3?=
 =?utf-8?B?N0grVmhZS0xUZVRxakhWMzVwd0E0dTNQR1o5VW1MMEVTdmowUUNONGRqU05H?=
 =?utf-8?B?WGpERndEWjJ5UkJwUE1INTNIVlpiUzBQcy9TUW9YOFBmRGNONmxpRTZEcW1S?=
 =?utf-8?B?a1ZESWFIbFBTc1RYc1dLMmV2UUc1RVVPNGluVHBYV2IxVHBtUk4yZjFxSis3?=
 =?utf-8?B?cWhNZFBmQWI5UUU3S3J4TFVEOWV2NHlRaVdTb1N5T2t1cE12OU4vaWxHUWEw?=
 =?utf-8?B?cDg1WG1oWGVVK3NqR3MrUjFCaDlwSnZGREF2aDcybUxPL25XelRQQ09rWGdO?=
 =?utf-8?B?R0hMaFdMUk0xUnRIQk1OQ3FsVk9Dc09IT2hHRXdmU0hkSG1NWW1UbmQ5MFhX?=
 =?utf-8?B?VGdxTnJBa1Q0eFR3M21MTjNWUExnbHhic2NlQWFLeFphSXBPc0ZFemFSTU56?=
 =?utf-8?B?N2gzTldBN2VtMWszNXpKL21ySEUyMFNCdjRPcmVkQ3dGTkVaMzg2Mkd3WG1Z?=
 =?utf-8?B?bDgwNWQ3aTV5L0c1VW5xWG9QaEcwUmt0YlRYd0R5L1NzRTFNNGtIMmMzWXNF?=
 =?utf-8?B?L3FyUmtEemVpNkFKMFhJbEljcmVyVlV2cUd5YXRpVU5kRmdnWGpPTVA3cXhr?=
 =?utf-8?B?WWZXbmExVlpZeU14OG91RnJxc1B3bFJQcU04SG1JZ0xtcEhibGFvVjlRZ3c0?=
 =?utf-8?B?NnlJR0xDdlJmSUxMSGlqYnZKOXFmVmRBU2FnNlZVd0FYK3hMZjd2Wlk4aFBT?=
 =?utf-8?B?MnNRTFJTSEpnU1FmNy9tNUlnNnhJZk0yY0c1VnRaQitteVFqQXQ1NWFEando?=
 =?utf-8?B?SlpBWkN4RVRJbjhscmtnQVNDdUxGUnpQeE0wcXlZRzh2eFB5SDVxS3c0Z2xM?=
 =?utf-8?B?NUNXSUVUSzJldmRlM28wQ0IrMCs3dnhHdTJwNitwSTg3aE9NaXFYdFkydVcw?=
 =?utf-8?Q?729SEZKKA6AHFTk5rToS7Mi65?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39baca81-1323-449b-7275-08db794e888c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:44:01.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnpMqRyz11mO7cBQYZOAD8e4PJR22rnHZ5o6aedqgEJFp1KIAFECAMkP92viXEcC+lzJovfl5BU7y3kKBfokhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5722
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/23 16:47, Hsia-Jun Li wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> On 6/27/23 16:43, Benjamin Gaignard wrote:
>> CAUTION: Email originated externally, do not click links or open
>> attachments unless you recognize the sender and know the content is 
>> safe.
>>
>>
>> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>>
>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>> CAUTION: Email originated externally, do not click links or open
>>>> attachments unless you recognize the sender and know the content is
>>>> safe.
>>>>
>>>>
>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>>   .../media/v4l/vidioc-delete-buf.rst           | 51
>>>> +++++++++++++++++++
>>>>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>>   include/media/v4l2-ioctl.h                    |  4 ++
>>>>   include/media/videobuf2-core.h                |  9 ++++
>>>>   include/media/videobuf2-v4l2.h                | 11 ++++
>>>>   include/uapi/linux/videodev2.h                |  2 +
>>>>   10 files changed, 128 insertions(+)
>>>>   create mode 100644
>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>>> @@ -17,6 +17,7 @@ Function Reference
>>>>       vidioc-dbg-g-chip-info
>>>>       vidioc-dbg-g-register
>>>>       vidioc-decoder-cmd
>>>> +    vidioc-delete-buf
>>>>       vidioc-dqevent
>>>>       vidioc-dv-timings-cap
>>>>       vidioc-encoder-cmd
>>>> diff --git
>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>> new file mode 100644
>>>> index 000000000000..0e7ce58f91bc
>>>> --- /dev/null
>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>> @@ -0,0 +1,51 @@
>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>> +.. c:namespace:: V4L
>>>> +
>>>> +.. _VIDIOC_DELETE_BUF:
>>>> +
>>>> +************************
>>>> +ioctl VIDIOC_DELETE_BUF
>>>> +************************
>>>> +
>>>> +Name
>>>> +====
>>>> +
>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>>> +
>>>> +Synopsis
>>>> +========
>>>> +
>>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>>> +
>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>>>> +
>>>> +Arguments
>>>> +=========
>>>> +
>>>> +``fd``
>>>> +    File descriptor returned by :c:func:`open()`.
>>>> +
>>>> +``argp``
>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>>> +
>>>> +Description
>>>> +===========
>>>> +
>>>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF` 
>>>> ioctl to
>>>> +delete a buffer from a queue.
>>>> +
>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>>> +:ref:`buffer`.
>>>> +
>>>> +Return Value
>>>> +============
>>>> +
>>>> +On success 0 is returned, on error -1 and the ``errno`` variable is
>>>> set
>>>> +appropriately. The generic error codes are described at the
>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>>> +
>>>> +EBUSY
>>>> +    File I/O is in progress.
>>>> +
>>>> +EINVAL
>>>> +    The buffer ``index`` doesn't exist in the queue.
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> index 899783f67580..aa546c972c3d 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
>>>> unsigned int index, void *pb)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>>
>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>>> +{
>>>> +       struct vb2_buffer *vb;
>>>> +
>>>> +       vb = vb2_get_buffer(q, index);
>>>> +       if (!vb) {
>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>>> +               dprintk(q, 1, "can't delete non dequeued buffer index
>>>> %d\n", index);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>> I know the driver could implement its own
>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>>> used by the hardware as a future reference frame.
>>> But I think we need a flag to let the user know which buffer is still
>>> used by the hardware.
>>> Alternative ref case is safe, we only know it's existing when it is
>>> dequeued in current V4L2 buffer mechanism.
>>> While the Golden reference frame, such long term reference frame could
>>> last much longer.
>>
>> It is up to userland stack to know frames life time, it got the
>> information for that.
>
> That is true for the stateless codec driver.
>
> While application for stateful decoder could never do that. It also
> breaks what the document said:
>
> "The backing memory of |CAPTURE| buffers that are used as reference
> frames by the stream may be read by the hardware even after they are
> dequeued. Consequently, the client should avoid writing into this memory
> while the |CAPTURE| queue is streaming. Failure to observe this may
> result in corruption of decoded frames."
>
>>
>>>> +       if (vb->planes[0].mem_priv)
>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>>> +
>>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>>> +               __vb2_buf_mem_free(vb);

Here is another problem for the existing application, the mmap() from 
the mmap offset or exportbuffer fd would not create a reference to 
buffer in this step(while the exportbuffer would create one itself).

When you delete a buffer, you may not release it from its virtual memory 
space, leaving a corrupted virtual memory space. Also this behavior is 
right, because mmap(2) says:

"After  the  mmap()  call has returned, the file descriptor, fd, can be 
closed immediately without invalidating the map‐ping."

>>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>>> +               __vb2_buf_dmabuf_put(vb);
>>>> +       else
>>>> +               __vb2_buf_userptr_put(vb);
>>>> +
>>>> +       vb2_queue_remove_buffer(q, vb);
>>>> +       kfree(vb);
>>>> +
>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * vb2_start_streaming() - Attempt to start streaming.
>>>>    * @q:         videobuf2 queue
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>> index 724135d41f7f..cea666c17b41 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
>>>> media_device *mdev,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>>
>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>>> +{
>>>> +       return vb2_core_delete_buf(q, b->index);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>>> +
>>>>   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers
>>>> *create)
>>>>   {
>>>>          unsigned requested_planes = 1;
>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>>> index f81279492682..80ace2e1e932 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>>> video_device *vdev)
>>>>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>>> vidioc_prepare_buf);
>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
>>>> vidioc_streamon);
>>>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>>> vidioc_streamoff);
>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>>> vidioc_delete_buf);
>>>>          }
>>>>
>>>>          if (is_vid || is_vbi || is_meta) {
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> index a858acea6547..1c737279d3ef 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>>> v4l2_ioctl_ops *ops,
>>>>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>>   }
>>>>
>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>>> +                         struct file *file, void *fh, void *arg)
>>>> +{
>>>> +       struct v4l2_buffer *b = arg;
>>>> +       int ret = check_fmt(file, b->type);
>>>> +
>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>>> +}
>>>> +
>>>>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>>                                  struct file *file, void *fh, void
>>>> *arg)
>>>>   {
>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>>> v4l2_ioctls[] = {
>>>>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>>> v4l_print_freq_band, 0),
>>>>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>>   };
>>>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>>
>>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>>> index edb733f21604..2f232ed884c7 100644
>>>> --- a/include/media/v4l2-ioctl.h
>>>> +++ b/include/media/v4l2-ioctl.h
>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>>    * @vidioc_prepare_buf: pointer to the function that implements
>>>>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>>> + * @vidioc_delete_buf: pointer to the function that implements
>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>>    * @vidioc_overlay: pointer to the function that implements
>>>>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>>    * @vidioc_g_fbuf: pointer to the function that implements
>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>>                                    struct v4l2_create_buffers *b);
>>>>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>>                                    struct v4l2_buffer *b);
>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>>> +                                struct v4l2_buffer *b);
>>>>
>>>>          int (*vidioc_overlay)(struct file *file, void *fh, unsigned
>>>> int i);
>>>>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>>> diff --git a/include/media/videobuf2-core.h
>>>> b/include/media/videobuf2-core.h
>>>> index 080b783d608d..0f9e68f76b77 100644
>>>> --- a/include/media/videobuf2-core.h
>>>> +++ b/include/media/videobuf2-core.h
>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>>> enum vb2_memory memory,
>>>>    */
>>>>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
>>>> void *pb);
>>>>
>>>> +/**
>>>> + * vb2_core_delete_buf() -
>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>>> + * @index:     id number of the buffer.
>>>> + *
>>>> + *  Return: returns zero on success; an error code otherwise.
>>>> + */
>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>>> +
>>>>   /**
>>>>    * vb2_core_qbuf() - Queue a buffer from userspace
>>>>    *
>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>> b/include/media/videobuf2-v4l2.h
>>>> index 88a7a565170e..3beeb4c735f0 100644
>>>> --- a/include/media/videobuf2-v4l2.h
>>>> +++ b/include/media/videobuf2-v4l2.h
>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
>>>> v4l2_create_buffers *create);
>>>>    */
>>>>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>>>                      struct v4l2_buffer *b);
>>>> +/**
>>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>>> + *
>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>>> + * @b:         buffer structure passed from userspace to
>>>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>>> + *
>>>> + * The return values from this function are intended to be directly
>>>> returned
>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>>> + */
>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>>
>>>>   /**
>>>>    * vb2_qbuf() - Queue a buffer from userspace
>>>> diff --git a/include/uapi/linux/videodev2.h
>>>> b/include/uapi/linux/videodev2.h
>>>> index aee75eb9e686..31bba1915642 100644
>>>> --- a/include/uapi/linux/videodev2.h
>>>> +++ b/include/uapi/linux/videodev2.h
>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>>> v4l2_dbg_chip_info)
>>>>
>>>>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>>> v4l2_query_ext_ctrl)
>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>>>> +
>>>>
>>>>   /* Reminder: when adding new ioctls please add support for them to
>>>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>> -- 
>>>> 2.39.2
>>>>
> -- 
> Hsia-Jun(Randy) Li
>
-- 
Hsia-Jun(Randy) Li

