Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC866E47F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:38:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122145267;
        Mon, 17 Apr 2023 05:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/kAqe46GPlTlTTztecN0A+e7AHck1zm1Pu9CTMhHLAarWv8ux1v4cHzwDXdXmePaSSmCQSb6AiN9wC0oxnRQPfU3vZe2RZ8ok80MTqRNPjAXVmjJ22vFsp+620DHiwLohN8DUaCIUzr4KZxQ52oOkReGbMuD8RE8jVZKeRHaqr6BQkhlSyXIYh8DPxYJ5HRqIVPYLoNTWQmIUe4fI8QtZe1ZWc6ikEkjp/xIHp5SFN/z+ZixvNL+/EAB7hJUdIZAfsZvo8LU0P2AcLyiB+1wzynWn03a5EhMmTKokMW9uSoaSKOCcvTTC0vgdmyuDxA4h6+c+z6ql1NrzfHs23ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOrcjaTiPlsuwJocR7ykoIe/ZKGwLwqAoRXN6G2T6Dw=;
 b=gPT4mhbwC+66EiXYOFz/UiVQq9TwGvloKpqL63CNrpPTBooyZK+5eHrJNqTeZPpmG/NCXNAuhpDqhqf5cVL3XYtn0Ya17I0dYpX52EqvBEdnnY74D+2TqwfiTJ6JGLPuivot9JCFNqh0Kqo0HddJ1+7UNE43DUnctEhemnE0LLGmHotoe5+msP/LLtv86KsRgAMv9U2TB7KmJZCTcW3sCQUv3YaVRYmskrTolSM5OPkuJ6tcG+n8vhHaj0xle/GgLd0WhWq4qhuRFyZwKmKau9Ek/EKsxKECcmrgrDFS85tyHN795CMFT5P5p1bJ766LAigE5AUVGK9pPFn6Leg9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOrcjaTiPlsuwJocR7ykoIe/ZKGwLwqAoRXN6G2T6Dw=;
 b=sjAiPhD4Fi32wbl5esPfT2ZfpXalj+FJZygcykugTdNHDKb39XnRWCiuMH/PGKH9qiRVFE/4YQg6GJFaBOnbxtt278n0p6wGYBoK2iOwIm8qA3v02W0+BXj6HXLQlNMttQso/CK2VzwVIhlxr8gNC/Z7BdblxCu/sVb5TJejd4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB5936.eurprd08.prod.outlook.com (2603:10a6:102:f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 12:38:22 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:38:22 +0000
Message-ID: <ccae3994-3b1b-4050-ea34-98f97cf886e0@wolfvision.net>
Date:   Mon, 17 Apr 2023 14:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
 <ZDbKU5kwcb7RGeCo@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <ZDbKU5kwcb7RGeCo@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd3abd5-3f68-4a27-e92a-08db3f40a155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glYV16OrWYIBaLduXbxwcWo3d1+1AqjFl0IXvwaXCatOP8jT07fgxnSFANVCaZVhETEhikiuxsdseeNknHuOj172rQk16laxE8KF6RFEls1HwC3X4WPraM79kPD8hMYLh9PQNxAHW2+yXeNWWGOZHLV4eHWMjNBRhz2gl5sv2cjgCitAsjASafGCJq64Uq1WgZVlCFxu/1vldGaKeak99n6D6aj+kDq9Dq6y1ea/qcHrttRnhEWjSGuY7e3yTftUBZXJa6lUbdJqd4T58WlRTma5BPvLemkPO1KHekwPLRfCTQsuamy4waN4c+utKlfI/z9ygwITja35eBJl2nLg39c8roPZO3BIVmLDbHJqpGSDunVYa5VV1pSmTPsw/NRlvEOO0L8U79L9Oq0I1UfpX1ijV7Lh2w32yY+zxkGv3Q8tDGjo3W79CIPGHIq0wFSbVPS3gdToLOuziwv75jGusf7xLv6QCeXKKralE6S+WfLOclTW0QznbQbIvXtLbuA2JdosnoF/uOOGzHR3k7RSiYFVZzHsfx8qQsMCmCHy05rcjHTJ3Fv7rEpI4+asCkUfjyJI/6LTz7EKCg+TTHMVMoUvCwryG1rqvONNsUinLVQzViH1CW8TDXu2b0wtglzM/jfT3CyE1y6Renyg7D+kLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39840400004)(396003)(346002)(136003)(451199021)(44832011)(83380400001)(41300700001)(5660300002)(2616005)(31686004)(2906002)(38100700002)(53546011)(6512007)(6506007)(8936002)(186003)(8676002)(6486002)(66556008)(36756003)(4326008)(478600001)(66946007)(86362001)(66476007)(54906003)(110136005)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09XNEd0UXRoQlBkL2x0RmphbWovYWxEaCsvbndDTnVQOGUvY3RvQWV3VlJn?=
 =?utf-8?B?aGhkWkduT3RBL1JIL3A0K3F4d2UyTElkR3d1bnFjUWZ2NFlMaVMybGsxbmQr?=
 =?utf-8?B?MGRQVEEvb2V2dWFzMXEyUjhBbDFRdkNmQjJzWndJRHN6M3MyMEMxY3czb3JQ?=
 =?utf-8?B?dlZHRjZvTExiNUY1RGgyekpjMGpsL1d0SWU3bXhBZGJvRmJ1VitENmh3UFlr?=
 =?utf-8?B?bkdXQ01hanl6WGlNcFV2ckhDSjViTVpFblp3V2hVbFpMUndEZFdXU2tlc0Fo?=
 =?utf-8?B?S2tvTm4vaU5HalovdjBDbG1TUEpVVnFVTnNkc0pQejR5dFpyS010eGI4UUpB?=
 =?utf-8?B?R01oL0RzbTN3cWtIajBBOEI4RElMYVQ5TmZIczM2T0ROdmVueDYwVXBMblpC?=
 =?utf-8?B?amUxVG9uL0ExanNGcDZrU0tRVlgzV3l3d0dIelNCUFp4T1M2dWZWUnNLbWov?=
 =?utf-8?B?eW1JdjdhNjVwbm5RQmRBSTU3SjJ5N1p2dUUzakZCKy9WeC9pdmI3Rm9wNjhv?=
 =?utf-8?B?d0ptVFBDNzg3Q1cxcUZNQjFCc3phNjlWaS9PdjlkdEdBNTlYRFlMS1BNV2dm?=
 =?utf-8?B?QlE3ZXZZcXFOeWtwUzJMMVBRNlBKOEF1a2JKRzJaZWhDUkNkNzJ5L3ViOHRO?=
 =?utf-8?B?QlE2NG93MlYwL2pkSVBra3h5dkdIREFpMDRSREFtMCtEZDU5S293NWFUdHMx?=
 =?utf-8?B?bm1MendlSFZWUHluQ3Z4TXBtY1NyQWZSOGo2a1pwSThlNTFFSnB6djBiaDB2?=
 =?utf-8?B?cEh0REd3RXBSN3ZneDE3UDd4NlJUNm8xb1Z0NVJBQmF5NTI5VFYwZ0dGcDBK?=
 =?utf-8?B?Vk54bWd1S3dHcTlmV2dCVGVNbEN6K3RralE2Q1hMVjJtTUdtb2IzYTdDVERI?=
 =?utf-8?B?bkdpUGFhWFZiNk1HK0RaeVJwbUZiNk9xUVA5VE4vMVYrTnFlNnI5L1RyQ3dz?=
 =?utf-8?B?Tnl0QXNiaFBickVTYUZPUEc2SXlPVzdDdEYvNXBZazgrRElnbWVOL0g3RWpv?=
 =?utf-8?B?TkVoT3FWZ0ZLTXRGNEhKaUdiQWFvaytVaW5wQW81ajN0MzMyWkRkZG1NdzhK?=
 =?utf-8?B?dW85MzdaM0k1NVBVQlBndEQzOURwWDVXUklCeVlkK1BhK25pekgrSVdmUCtS?=
 =?utf-8?B?Mm1FVnZCVGttdThSaW5OTkFjRXhram1KMzdUbUJ1VXBEUjFaL3VtT0JTbjJT?=
 =?utf-8?B?VFp1bXc4dmZKNUNleVlUVzcvcEtqRmZoRjYxMU5rbUZsNHdvR2lBOUxqODBy?=
 =?utf-8?B?L05KQ2xBWVlpelljVWRZdWdzOVhuRnV4U25xTkFPN1kvdHR4a1RGNWlkaEoy?=
 =?utf-8?B?QXVySkFJcUdoc0Z1NTVNS3Y3K014Z3JDZHV0RHFVcnNQNGU4cE8xaW5GRFdU?=
 =?utf-8?B?RkMrQTFtUENrb00rK29DOWx5UmE3VUtERFYzODZySzJqV2NKbE5VcDN4cTFO?=
 =?utf-8?B?Sy9RYWY5RlJ3QWJjRGtLcXZ4TTBsc1pHZDVTUnhGMk1uMEQwMStSU3pHYVlJ?=
 =?utf-8?B?cG5QT1cyMGNMejRMakhpdUc3bzZSVVJNN3dRcGwvMHJNMVpxL1RML2NvUVlB?=
 =?utf-8?B?dUttL2FHM1JlV1gwcFlGNGNIaW01cm0xNWVJV2RMeXE1Q25tRmVYWk5KM3Na?=
 =?utf-8?B?TmNnemQ3QXBjWUlIZERlc1NGZUd2QUwraGczeDI2Q3VDZTlIWXdyUThiQm5z?=
 =?utf-8?B?SFZUVy9jaXZrVFY5Z0U3d1ZBM3YwdkdtcTZ3S1Y5V3VZNHNJU0dWaUpIRzN1?=
 =?utf-8?B?TjgyWUtkYzlmZitKR3dSVXJsdVN2TFBFTUVHTGpEZnRCbWhNdy92VTNjVmVI?=
 =?utf-8?B?am9YUmpZd3BSSDhFTXJtRlZmZDArVnV0L0QrMWRBY3UxbUxlVTI0eU1Jcnhr?=
 =?utf-8?B?dmZtbFA5WEliYjdtV0FXYzNmeTk2VGxUU0wxSUNoOW1XMDR2VDQ2Rkx6RVAw?=
 =?utf-8?B?eG11RzNWNFA5NC9aeXJKNnZZTmtPSCsrUlY3dFNWWDY4MjY0U0dtOWhHcnVU?=
 =?utf-8?B?RTluUmZ2cjNldGlBSGZ5TFRSOS9TMTZYeFhhQ3g2SDZSemVRL042MFZRb0x5?=
 =?utf-8?B?dzhnNDV3clVRMk15UHhaeXVLZ2ZHRFJydlFIZTZDYWF6ZnQ0a1B5NDh5OCtO?=
 =?utf-8?B?Nk9CTXJpbHR3ZVpCd3FGQjJ3VFA2dDNTdzhyMmtDZGd1bXNqSVd3K2xUNnZt?=
 =?utf-8?B?SFFCMUw2ZjhXU1lmZk5rZExTS3I5bWxGR2VPeHcwZjFCTTArY3RmbXpheE1h?=
 =?utf-8?B?SmpTcC9xN2lmd0tmTWZKVE1SKzZBPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd3abd5-3f68-4a27-e92a-08db3f40a155
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 12:38:22.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w94QlELEcV0BlAz3juQvKECylqOpGkGVgUKV+tX+W4V+PS54Ot04Hd19+2xnLRceBjobPFPxFUKLJpQJVIlBDPs9th+hbeGhEbAc8ixYD2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5936
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/12/23 17:12, Sakari Ailus wrote:
> Hi Dave, Michael,
> 
> On Wed, Apr 12, 2023 at 02:55:56PM +0100, Dave Stevenson wrote:
>>>> If the ranges aren't updated, where should that out-of-range lens
>>>> movement leave the lens?
>>>
>>> This is up to the hardware controller, but I would guess it typically
>>> stops one step before disaster. Wherever that may be, the error
>>> condition and the current position can be read out via this new STATUS
>>> control.
>>>
>>> Does this sound good so far?
>>
>> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
>> Laurent), and I'm just expressing my views based on the lenses I've
>> encountered.
>> All of my lenses have a single drive for focus, a single drive for
>> zoom, and where there are multiple elements they are all connected
>> mechanically. Your setup sounds far more complex and is likely to need
>> a more extensive driver, but it'd be nice to not unnecessarily
>> overcomplicate the interface.
> 
> Could we also have a driver that uses these new controls?

If you are referring to the driver for our custom lens controller, then
I have to say that it is under development and simply not ready for
release yet. Also, the decision has not yet been made whether or not
this will be an open-source driver.

A different approach could be the adaptation of the vimc-lens driver,
which currently only supports FOCUS_ABSOLUTE. But this would raise
several implementation questions and at least for me this would be a
nontrivial task.

Is it required to have a driver for this interface (in the sense that
the patches cannot be accepted otherwise)?

> The controls themselves appear reasonable to me as well. I guess there are
> changes to be made based on the discussion?

I'd summarize that whether or not the status controls are compound
controls of the type V4L2_CTRL_TYPE_LENS_STATUS is the open question.

As a potential follow-up question I recently asked myself if the struct
v4l2_ctrl_lens_status should contain trailing reserved bytes for future
extension (no idea, though, what this could be).

Alternatively, we could come up with "V4L2_CID_FOCUS_CURRENT (integer)"
for the current position and "V4L2_CID_FOCUS_STATUS (bitmask)" (and add
further controls when they are needed. Here, we lose atomicity but maybe
this can be ignored. One could assume that all relevant controls are
read out with a single ioctl which provides at least some level of
atomicity.

Any comments and/or recommendations to this open question would be much
appreciated.

Other review comments will be incorporated in the next iteration of this
series as well, but they are quite straightforward.

Best regards,
Michael
