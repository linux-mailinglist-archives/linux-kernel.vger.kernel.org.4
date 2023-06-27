Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2873F5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjF0HcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjF0Hb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:31:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEAE1;
        Tue, 27 Jun 2023 00:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccSasgEMsywHDcDcpwBKPnE9Rjjuxx3CHTHs/3y5Yf9GoPyRjdEZsFhVAsBxYYgpOwukNjKFtxu/r1z3mxTDqF3hrf6mkwjj2wiZqeWfSCPLFloFTWuCzYm/f9v+emXKchR4TKa97pIe2xzEaTv1P5AJY8M5Mfwpliybg9AKu17L/eerQ1nhfMFJ1hju0Gi0O4wOYwxY55vmlE2naWHTq+Noe3t7WE1dFFWF0V4SZ5ndHRgw+EtHgy6o0gKYmYlM41WFHnDj0J733yk0tyNbwDlcTINVj4BinWci2GY9NMpB40687qDFZbqF7l/lXn9dkfw6fwG5g3E0qrLhypAjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtYPwN1O4TXEk4IQOO3RKgJ64PcDT0Zt+w71uyP6kFI=;
 b=Jfe5iBS/ZQ/w/svAgfu3IDuy12JzWW9ZfKdGywcjEdulDskqstukA+ZDkjJjY+go941QNosKi1xhM8IsRO6R7YDPi6yOQsM6I99zscQgzFxA6edI0d9dCKwyn7gs8AxfHKuXLkfxM7mW92gVv02CWLB9Iu2EDMV8RbYFsoVN2UaOoLJATFiJcZaK5JimkO2S6KUPVI6PVXu1fangRS/9kOzprlPwQrR91RH3SeAweNMQQ3YUOyxvBNSQ2FgrZMl5JKKZLyxiyD/35D2ABQB9Yr2uS83U4Amzj45f2ZiWSD7w58AV0A9o+lhMUGqwiW++P1dF48q2dy5pp0P3EnoWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtYPwN1O4TXEk4IQOO3RKgJ64PcDT0Zt+w71uyP6kFI=;
 b=Axln3x3iPnjbmq+GIneVcad+V4nw3hjzCySAYroHZOeO0XOWraidyZFyB7pFvfZSssd+P/GrPNE4iubAPs3TOI6o95m77yvdeg3URgevCfcVd08ZZs1HpkSjnP7UZYUCoolDSYsRERMmDbSFFxn7agul5vMk7POFxauRBt2bApY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6267.namprd03.prod.outlook.com (2603:10b6:510:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:31:24 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:31:24 +0000
Message-ID: <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
Date:   Tue, 27 Jun 2023 15:30:25 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230622131349.144160-11-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2d67d1-9eb3-4ac7-4e38-08db76e082a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmPywxDwTfFQja/bq4cAtS2a0cnc3m6AVjW81YlGlxEC4LkQ7mgFvEuAGdHo0xfZH1+6tS/oTIXL6XQCHhBfMfLLMLDcewk8+UaHESsiRUX4NHrZemQza/aXY77fkjXvuao7QhR7GYP3m69uyRa8TnyMZGqpSBix43D8IIjUM+aGFtB8dkGeUynbM1QPqeibH675ZEH5TdvzOas/UXawTp2ZOG7Ka6ero7IumG2/oEoz9xNIGsSEhifOlpLY6yjuYrsUw6X2V9rDF6AoqCemieACpkCe4CKTKIwNzI6MrKPCp3/vv/dSYIX3dV4eaICynwRL0DyUCpOqd4MWKw1zK7PLokf/KW4Yda69Ai+5BlL/FpYDaZXE5QxUb3gNO1xX3E2/MCvGZY5QDMy2pwBnYZ0ZLa0nBQO6StRBV1D38LJj5eNnUtGxjth8ohzkv6CHHhPt5/Ti+mA3Scqar4+E5yOhD+QZXDb6Bo7LWysJO1uMJlOZ8A9ZCwKZBweOWAIlHl1d6TFDuDMzmkaG5zUOTYytl2cnR6DH5+m1n/cPzCUWHLLaVsfoQ8QwARt7s75+nECQZjX1G/mhxaNgHY3T8GCeFEl/vrcD3NRNLExndG97g6UT2BDNTtp+WT0Ra7dyA8Kbvq04CBsUeHgFiX8EZ+0/P35kii1k1+zFuuvVAu24WHEdcMIPQV5mp/oE2Y5p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39850400004)(366004)(376002)(451199021)(36756003)(2906002)(478600001)(6486002)(83380400001)(2616005)(6506007)(26005)(52116002)(53546011)(186003)(6512007)(30864003)(5660300002)(7416002)(6916009)(4326008)(316002)(38100700002)(31696002)(38350700002)(8676002)(86362001)(66946007)(8936002)(41300700001)(66556008)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpaVTBNdGJTNjFMNWtBOTRKOVpwV0JzM1hOWXE1M2FWb0tJa3FjVXpSUnE4?=
 =?utf-8?B?ZWdKRUN5WkVSWU9pd2RRWVlUU2FwYnd6bjdiWFRWb05URTJFZWMzaEtVeERz?=
 =?utf-8?B?aUNpdXZ3NTQwUUd5ZlRab1Q0RWNUd1BGQmpXUDc5VGVGU1NFZ0gxZXZoMG9u?=
 =?utf-8?B?ajRxZ2NBK1hCMXYwVnBpZ2hkOURUNWVyZWc0V20xb2xHekV3bWptMldOVU44?=
 =?utf-8?B?V0cxTzRFTU10YTZNcWluYXYvc1lEdytwZ1JidGh6Ymhac2c2L1lEYlNzQ2c0?=
 =?utf-8?B?NnhqanorMVljZDFGbktiL1pqeStOdVo5WWU0RWkrOVJhbWU5Z1c4cEM3cGZ4?=
 =?utf-8?B?RUtCUXFxQkJZQTR2QmJHNjdnaWVYWjgxL0Q4d05Dc1U0TCtlL2xmWE8wM1JV?=
 =?utf-8?B?bmhWUlY4V2c1MThDYkorc0NYMk9wNjZpbXlFOEsyUkVWOTVFN1A4RWhkdVlZ?=
 =?utf-8?B?c2FralZxZytoeDF3eEFtNTVWMVVtT1dtejNvSTBEVlFWQ0x0Qktxcno0NXor?=
 =?utf-8?B?UmZ4N0xYOUtyVEZQRG9zaC9XdXUyRjgra2k5R1ZOeGlpUUMzMlpEcFFMdGxB?=
 =?utf-8?B?YlJuZmkwb3Z2Y2dueWhHcEsxV1N0MzR6bFZUWTVtVFphZHFTMm0vUFVzbmtp?=
 =?utf-8?B?Mm1wSkt5T01JamF2MDJqczJkQ3dBRkhrTjVwaVVjL2p2ZC90NHRweVphdDZh?=
 =?utf-8?B?WGlFNUJQZEV5Q3M4SmxRdnhrcUMrWEY4NE1lVFpQNVFLU1ppbGJSSTNJUTlM?=
 =?utf-8?B?NVVON3hyRmlIaEl4YUpNaTRJc3BINXd3U2lXYVgxM3QvNXB6bWIrTGdIdC9G?=
 =?utf-8?B?dHNabjhJRjY5MThoSnBCNHd6em83ZHd6aW5tM3MwU1J1UUoxdUxlOEZPT2Rw?=
 =?utf-8?B?bytOMXFmR2NuS2ZVZDJUL1NSZGxsRHVOUlRSd1FUZDdjZzY0N2ZHdVR2Z0Ey?=
 =?utf-8?B?dDZCTUlFaWwvRUdyOXhFblBHcGErcmJkTDZXTWZ5QmFndHNOMVdadnJzOWpw?=
 =?utf-8?B?dkdiY1N4b0c4KzQxYXZMdTZyU2NjS0pmYVhnbzc3LzJ2NHk1Z3FXVk9lTEVz?=
 =?utf-8?B?TTltK3d0RlJnZThoQnFvWHhvM2ZuVDhkeEx4S1pPMlpIOG5URzBFNFpiKzBn?=
 =?utf-8?B?SXlxUEhqUUt0Q2g3ck5xWnhKVldlbXJUSXlRWjI4SHM3VGFuWEpJYkorUzdo?=
 =?utf-8?B?aWw2MktITmgyMUdCOEFLYTk5M2ZQZTB3WXdGcWwveXJkYkgxdjJMR2RFMmsr?=
 =?utf-8?B?MUszMmdDNzJIMjNJZnhZOVNJMytxOEd2amFtcjVxK3lFNEZTVTR3V3VnTnd2?=
 =?utf-8?B?d1Q0RDg4N1ZnNi9pZFJVYzdSSXBrMHd5dExvNDhxRFRzZzhPcGE1U1Yrck5X?=
 =?utf-8?B?MXBFd2t2dEFNUXJSOVFLUVd3Q1hFMjA4WENZdWpGSmJUdVJDTlhTakQ0WTM0?=
 =?utf-8?B?dHdGaWRNaXVsQi84UDErRmtBQVJvVHFmUGlrRlFwYkFmUW1hMXNscGtxOUZI?=
 =?utf-8?B?UGZ4Y3dMcGNoeCtLc3RZMHdGQ0RPOThlTzhjRzhXdEFpVXJQenNvVkFWSWcr?=
 =?utf-8?B?TWI0TzBFTUtGNU1qMUdOajhKNGlHT0hRUXREY0g0R0EwbjVubE8vVTQ2TVlu?=
 =?utf-8?B?Yk9kNjJ6R0hwMzhzUEh1MHBFclBzK1plWXZyZ3E3ZjM0THNXR2lQdjJCK0Rn?=
 =?utf-8?B?Q0RDN1lrRDYyTTZwS0pMc1dyNFgwTm9XL1o0RlF4dHV2R24yaGJPeE44VVJI?=
 =?utf-8?B?NzNleElCVVpHQ2YvSWZESkFqSmJjdGpramVRc0pqaGNKZXJyT0wzeGN5Y213?=
 =?utf-8?B?a01CdVdjdjcvZjFSTnNDa0drMlNJWGxzMzdsUVdJanF5dHNzZzVIdmdNQXRT?=
 =?utf-8?B?SjlwdG95NWh6WUt3NGdPK1NGckxsWU5sMkQvZHA3NGdiMXBzNmFzZ2tMYXEy?=
 =?utf-8?B?bzdOVXJtY3ZSQkxHVnQ5bGptdmtTK1J1UW9CU3czS1dVZUYzbVJKTHR5YWhI?=
 =?utf-8?B?b1RQL3dvRUhkZUFZUjJjdFUzWjFEN0JKb2ZyRVZWVDhWVHc3ZXRzQVAwTzdt?=
 =?utf-8?B?d3dyM3ljejBteVhUSnplN2p1YjNKcWsrUTM2aEp1M2t0R0krRFpISWNoWlhv?=
 =?utf-8?Q?cezSx/gViTeHx6NPM7Y3uzUc3?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2d67d1-9eb3-4ac7-4e38-08db76e082a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:31:24.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1LN511u4grReHDtOCKz/APgK45XbaryqwDO+bsPan62HENrgfOvvVcMI193HunOoYW8vrFNUWIM0/Wb65xa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6267
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/23 21:13, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>   .../media/v4l/vidioc-delete-buf.rst           | 51 +++++++++++++++++++
>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>   include/media/v4l2-ioctl.h                    |  4 ++
>   include/media/videobuf2-core.h                |  9 ++++
>   include/media/videobuf2-v4l2.h                | 11 ++++
>   include/uapi/linux/videodev2.h                |  2 +
>   10 files changed, 128 insertions(+)
>   create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>
> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
> index 15ff0bf7bbe6..8c74016e12fd 100644
> --- a/Documentation/userspace-api/media/v4l/user-func.rst
> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> @@ -17,6 +17,7 @@ Function Reference
>       vidioc-dbg-g-chip-info
>       vidioc-dbg-g-register
>       vidioc-decoder-cmd
> +    vidioc-delete-buf
>       vidioc-dqevent
>       vidioc-dv-timings-cap
>       vidioc-encoder-cmd
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> new file mode 100644
> index 000000000000..0e7ce58f91bc
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +.. c:namespace:: V4L
> +
> +.. _VIDIOC_DELETE_BUF:
> +
> +************************
> +ioctl VIDIOC_DELETE_BUF
> +************************
> +
> +Name
> +====
> +
> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
> +
> +Synopsis
> +========
> +
> +.. c:macro:: VIDIOC_DELETE_BUF
> +
> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
> +
> +Arguments
> +=========
> +
> +``fd``
> +    File descriptor returned by :c:func:`open()`.
> +
> +``argp``
> +    Pointer to struct :c:type:`v4l2_buffer`.
> +
> +Description
> +===========
> +
> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF` ioctl to
> +delete a buffer from a queue.
> +
> +The struct :c:type:`v4l2_buffer` structure is specified in
> +:ref:`buffer`.
> +
> +Return Value
> +============
> +
> +On success 0 is returned, on error -1 and the ``errno`` variable is set
> +appropriately. The generic error codes are described at the
> +:ref:`Generic Error Codes <gen-errors>` chapter.
> +
> +EBUSY
> +    File I/O is in progress.
> +
> +EINVAL
> +    The buffer ``index`` doesn't exist in the queue.
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 899783f67580..aa546c972c3d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
>   }
>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>
> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
> +{
> +       struct vb2_buffer *vb;
> +
> +       vb = vb2_get_buffer(q, index);
> +       if (!vb) {
> +               dprintk(q, 1, "invalid buffer index %d\n", index);
> +               return -EINVAL;
> +       }
> +
> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
> +               dprintk(q, 1, "can't delete non dequeued buffer index %d\n", index);
> +               return -EINVAL;
> +       }
> +
I know the driver could implement its own 
v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is used 
by the hardware as a future reference frame.
But I think we need a flag to let the user know which buffer is still 
used by the hardware.
Alternative ref case is safe, we only know it's existing when it is 
dequeued in current V4L2 buffer mechanism.
While the Golden reference frame, such long term reference frame could 
last much longer.
> +       if (vb->planes[0].mem_priv)
> +               call_void_vb_qop(vb, buf_cleanup, vb);
> +
> +       /* Free MMAP buffers or release USERPTR buffers */
> +       if (q->memory == VB2_MEMORY_MMAP)
> +               __vb2_buf_mem_free(vb);
> +       else if (q->memory == VB2_MEMORY_DMABUF)
> +               __vb2_buf_dmabuf_put(vb);
> +       else
> +               __vb2_buf_userptr_put(vb);
> +
> +       vb2_queue_remove_buffer(q, vb);
> +       kfree(vb);
> +
> +       dprintk(q, 2, "buffer %d deleted\n", index);
> +       return 0;
> +}
> +
>   /*
>    * vb2_start_streaming() - Attempt to start streaming.
>    * @q:         videobuf2 queue
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 724135d41f7f..cea666c17b41 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>   }
>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>
> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
> +{
> +       return vb2_core_delete_buf(q, b->index);
> +}
> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
> +
>   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>   {
>          unsigned requested_planes = 1;
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index f81279492682..80ace2e1e932 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, vidioc_prepare_buf);
>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF, vidioc_delete_buf);
>          }
>
>          if (is_vid || is_vbi || is_meta) {
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index a858acea6547..1c737279d3ef 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct v4l2_ioctl_ops *ops,
>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>   }
>
> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
> +                         struct file *file, void *fh, void *arg)
> +{
> +       struct v4l2_buffer *b = arg;
> +       int ret = check_fmt(file, b->type);
> +
> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
> +}
> +
>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>                                  struct file *file, void *fh, void *arg)
>   {
> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print_freq_band, 0),
>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_query_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf, v4l_print_buffer, INFO_FL_QUEUE),
>   };
>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>
> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> index edb733f21604..2f232ed884c7 100644
> --- a/include/media/v4l2-ioctl.h
> +++ b/include/media/v4l2-ioctl.h
> @@ -163,6 +163,8 @@ struct v4l2_fh;
>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>    * @vidioc_prepare_buf: pointer to the function that implements
>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
> + * @vidioc_delete_buf: pointer to the function that implements
> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>    * @vidioc_overlay: pointer to the function that implements
>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>    * @vidioc_g_fbuf: pointer to the function that implements
> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>                                    struct v4l2_create_buffers *b);
>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>                                    struct v4l2_buffer *b);
> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
> +                                struct v4l2_buffer *b);
>
>          int (*vidioc_overlay)(struct file *file, void *fh, unsigned int i);
>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 080b783d608d..0f9e68f76b77 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>    */
>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb);
>
> +/**
> + * vb2_core_delete_buf() -
> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
> + * @index:     id number of the buffer.
> + *
> + *  Return: returns zero on success; an error code otherwise.
> + */
> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
> +
>   /**
>    * vb2_core_qbuf() - Queue a buffer from userspace
>    *
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 88a7a565170e..3beeb4c735f0 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create);
>    */
>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>                      struct v4l2_buffer *b);
> +/**
> + * vb2_delete_buf() - Delete the buffer from the queue
> + *
> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
> + * @b:         buffer structure passed from userspace to
> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
> + *
> + * The return values from this function are intended to be directly returned
> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
> + */
> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>
>   /**
>    * vb2_qbuf() - Queue a buffer from userspace
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index aee75eb9e686..31bba1915642 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip_info)
>
>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct v4l2_query_ext_ctrl)
> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
> +
>
>   /* Reminder: when adding new ioctls please add support for them to
>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
> --
> 2.39.2
>
-- 
Hsia-Jun(Randy) Li

