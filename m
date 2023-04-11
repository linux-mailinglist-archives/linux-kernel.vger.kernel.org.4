Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C926DE28C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDKRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:33:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3504C1D;
        Tue, 11 Apr 2023 10:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcwGr1Oz5EO1i6laoi0BDO8lx90HyyDmKlXpw99+VxCH8zo8BQrK9GM6Evb4yFVp+/GUtJ+boR78Bi8YDxY7soMrqDv6cR8psPWgaxH0yf47SCo/CJ20n3KEVFkRSZr4tlNqRdEuZybvLUaXFonzy7+NkkGVZNDRvjvBCARJlxYjeDObJYzY7OQAN63Su71VBiobVFoUFpl3jqDGB9Suo4gBv9/uZU8Jtmivo+uI+HxYQqxFmLIpiJ5PcAi2rsKjhxm5u0cXHm2cTTilyyVE7Ke74KjcbuG6XWl5esifyUFur5UQ8u/8WlywuQiNsisxZ0uxX56r7u1h+1gaIuU8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldvx1DI3OLHJpQDqNsi3uASe2B01bNf+ldlnXjrQOC4=;
 b=E93GyHzwPMFyf1lVkG0zrX9teqclYose2gYcDvJTlwz1ZfPMLsP2liMgwy2e+WOdRTl1LVAlJW2uGbe4Eb6Bo+KuU/jRMFM3Lx5jS2dg4ZhayVVp/lmkXon4oYcQTTLNXEquJjrFKkSUB5hNoutfmYO3u+dEjNeCWKk8Ktq83zZJxcZx/qyt48XjfwF/ZAomJgoTV7Rpqg7+bBs6xgBCoIPtZI/pBWqwIKCSnFVZzvxHzsuwVVQj2MbOB4xqtsC75d4UEhGz0lFdlrzJGfQ6B+6AbHdIiZ+CReUriuJT6TIiU2iulXs1XxMfLbYNZLgHRU/XleNBYNYDdQw/MH6nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldvx1DI3OLHJpQDqNsi3uASe2B01bNf+ldlnXjrQOC4=;
 b=paeAhCNlsqZWyPx4PPnDyJYL3MP9l2L9FR7t+ae+yRCje5+OS/DMbz51Yx/HOn10ubGGY8YHjFHdgUDt8tOeIHuGHjc5lZstpXxRNumqBZIzSWHv+sXAraWzfp7TAbNDwonGSH1RulraCaffKpA7WPacV1is3C7WFirV2CBvlh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB9930.eurprd08.prod.outlook.com (2603:10a6:20b:564::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 17:33:29 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 17:33:29 +0000
Message-ID: <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
Date:   Tue, 11 Apr 2023 19:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Content-Language: en-US
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0302CA0018.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::28) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 055c5067-1127-46d7-d2ed-08db3ab2dd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vVxJq7TO6yfHAgSj8ueUaEPffz6G8P3ETdZvlRCrrOYjVv5J4LLG1qSH+fcNl1GIQYi6QKkv53ixuYKftPFv8nRnIEgw2ZKtJR14JSz7etbxS6GzRn/EI+eKuSW4cCQca7TFA5HfYnGeJE/yJYNfbqph3WyuN3wxr9HD3PsdTJ8l73l9v0C9ZAExAC2EH2ZWtPs80TQDHlg7b4NDt+p5YaWEzlpVAXrgmWbtgNd2JtmP7QepOmDhp05ExqaCZu8TC58jrVjEqQnBX1OijvzvDkOA4GI0n9ZkBs/zoHxhjP9Fiur1ad7zYJtQEjzXlPv7ogsaAUN6iUKZHwrF0Suaypta8lIQBw1kklKQm05uSRBfIj3Dgcf0vBCn7sGymowKbm5p8C0hTAu0tjRyRtherZRoXEkTQ35OtWE64bzy7YpZBxuepHvy/Y+ZTTb/o1DrqazEOhANt74luojLhmXOgTyCUVgL+6Yhc92MK+yuIURnrTEPUUxJy4a+0TDTgSdEahcuqWrbjcAJ/2JWB/uMEahOnBIHEUkT2eP/YjyvCHKfORN7upLsUKBdCUWPiesGZ+d/9ILyLx0ZbwpT+bxgovt4tUQ17zFMcUfQe48N/n8/RdI9U179EB7DzCVqs0OYbXdtWJoN7oNwBDTj1vEDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(396003)(366004)(376002)(451199021)(478600001)(36916002)(53546011)(26005)(316002)(6506007)(186003)(44832011)(54906003)(2906002)(966005)(30864003)(5660300002)(4326008)(66946007)(8676002)(6666004)(6916009)(66476007)(6486002)(41300700001)(8936002)(66556008)(31696002)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3Z5MER1aFg3QmVCRU9aSkxDNWozbXZ1c1VCaWdpVU0yekV6a0U3enZ0Q3Fj?=
 =?utf-8?B?U1BQT0J2NzlKRFRVMStkTXA1VzNhWHYwcHEyT0tIS2tCRXBHN1pGOHZtQ1pq?=
 =?utf-8?B?SnlrRmpMUXFUVi9OUnpOZ3pGeEovWUVpNit5cXNlOVFhbExHNlMzZ0ZuR2Rz?=
 =?utf-8?B?cksvYUE1VkNXTmtUZ2pHWjFMcWNuT1hRNTAwM2wzSHlUM1E0TFV4eFhwNzJN?=
 =?utf-8?B?ckJYZmNWaWYvRWJvRDRZeE9YanBWSHBXdTAxWXlGbVdYZytLcEp0UE02NHVC?=
 =?utf-8?B?MytxODdvWjEwUDZxOUNxL21WT0ZkWEZ4RHgweFRCaXJpc0JFS1FDWjNwTnc4?=
 =?utf-8?B?dENwdjhuZitxTmRnUENGckplL2lxeTdUaXRFc0VOOFZQakxDNkd1eVZjOFhN?=
 =?utf-8?B?NVMrVGVPRnRQRW5PZXVpZzFyMyswNGtTOVo3WXpBNUNQQWZDNHZaR0E5WHJ1?=
 =?utf-8?B?dWNFNkpJaE5WcW90alk2aWVpcHZEanA1VnhCWWM3QktMZmpNaS9ZdkZTaG5x?=
 =?utf-8?B?ZFhRODhkTGZubHRMN3k4SFcxV0xRZFdoWUlJNnFTVXBFMGp5YzJNa1psSFRK?=
 =?utf-8?B?VWpQZkNpNWxPNitsNEsxSi9WS2c3VldmK21wa3hBS0hRVzZ2NE5IS0g1OVdx?=
 =?utf-8?B?dWlpMFBhWjR3Vk1YK3c5eTllbWFhUVZmZjFsMWNPdUduUWxQWjJyNUdBTjBD?=
 =?utf-8?B?TEp6eUdSZEhCRUlJTjdEOXZOVDExcmJaSFFDVHVLaVRGb0twYjVZMWlaYTk4?=
 =?utf-8?B?UWVYYkJKdFc5QWMrTzkzaVVSL0NSVDM1WnNaUHVFZWF4U2JHNFNHRHNZZ1BL?=
 =?utf-8?B?b3ZpelBLWkNtOGwwU0kzeHBDcFYvVzZXQlh0aG9lUFp4MG9sNk5wcEY5b3la?=
 =?utf-8?B?OG9pRG82dDZjZk5DT3dpMWxaYWxHWmZFbVBlTWtSV1QydWhMekRlSWJCSlRC?=
 =?utf-8?B?cTdzcUJ2YUdacjczZU1yRlYvSFd0WjJXZ1FPOFFCYVdrM1VjaWtrQXlkNnpT?=
 =?utf-8?B?aUVzdFUwN0Vib3VUQU9wdmxybnB4TUgzeXVQL3JtWmNPYy8xeW1TZ3dBekdx?=
 =?utf-8?B?S0hmNnlRVE1OcFJ3a1dFbHQvZDlNM3o3SVc3YmJCcm4rVi9kWDdhMkI5L0Fw?=
 =?utf-8?B?T1cwR240MXdhSmNZUEtYY1ozcWpiUks5WGcxeE5USkxaMFQ5TURkWEJEZksw?=
 =?utf-8?B?Vlg3MUxGVS90M0NOekxOZllZeGxpTHJNU0o5bG5tVDV2Z25MVUZjaFhjR3pl?=
 =?utf-8?B?djllc3luZkZ4VXVQNHVvRVAwTkRkQWV2TnB6eXhEeTRlZFV3ZHRqMWk3SjhC?=
 =?utf-8?B?THZlRVRiZHFkZVdmQnBVdjEyTDJpbG1NWkl2akgwektORlVoM2RXeThSN2Fw?=
 =?utf-8?B?YjRodlp1QnpsS2wyWGdRY2dJaVpSRG9zbExCUDMxcWZVS0wrVVN2OUVsR0FD?=
 =?utf-8?B?aEhVZmZ6RFoyc3I2T2VCVkhWUFpiZ3B0NDYvdGhSM2tpaUlwUlpMMjJOTFVu?=
 =?utf-8?B?R0JWNndkejVONzJodUQ4QTU3N1VvUVY0VnNuSUprQzBhUmFaRkN6TnEyb3g1?=
 =?utf-8?B?cmNmOHZFQlhSZ2xCbU9CVnRkem5xalZvRFF3a2VtaHpXY1JVRzBVRkxodEhw?=
 =?utf-8?B?TW9lMDZvYXFqYnRkd3pRS1Q0RUcwSm9hTDBlZVFLYmdEdnZ4OUJ4YWMybU1n?=
 =?utf-8?B?c2R3aWxxQ3NZcVkyK3d5TC9kYmFkNnVCSlJXWFhoVUFDaG5Ld0VIelBOT3pM?=
 =?utf-8?B?WHZWZkVhUTVQd2NINHBDZ2Z5Wmx1cU01T2xUOEpyVTZmMzRWWjlCclQ5ZzZT?=
 =?utf-8?B?ZXlvQnRBcWh4ajI2M25UZm96TlZZdUxQWDVJVVlCRWVaVUFCWW52WDdra0NJ?=
 =?utf-8?B?OHhRdTJmWklOQlEzVUViWmRJU0NRMDdFRCtUZHkrU2s0ZzVIcEtRanEvaiti?=
 =?utf-8?B?MjlyWk9vZzlwQXZldHdFRkpJbHBNS2h3OFg0elFFRENQOFgyZmZKbVZ6VDZP?=
 =?utf-8?B?TkZQOWFNM2NpcEZML3ZGa0oxYkJSekxFQVZTdUpvS2hOalFjbmZHeVdVSXpC?=
 =?utf-8?B?KytPOERKZ1dMUXlzWE5EU0Job2tMRGt1MThQRWZXWURMQ3BtQmtsYWtPMlB0?=
 =?utf-8?B?WUVUbU9IQnY1clZYd245VUd0a0pDWTRTVEt5cWwvc2NYUmlQZW5rTGpxUE4x?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 055c5067-1127-46d7-d2ed-08db3ab2dd38
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 17:33:29.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHOj2RyJ7u2J23q8WznPN9m/d4EF2t+PRNJUDCm2mYJAhMJjIxamVulgQCWMW6p8jBeKkyJ9GxHjycwgYzdjxIjxlVpUU1OuR4pXP7d48LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9930
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/6/23 17:16, Dave Stevenson wrote:
> Hi Michael
> 
> Thanks for the patch.
> 
> I've got a personal interest here as I'd love to be able to control a
> couple of CCTV lenses that I have. Those have standard motors with
> potentiometers for position feedback, not stepper motors, but
> otherwise have the same limitations of slow movement.

That's great to hear :-) Thank you for your feedback!

> On Thu, 6 Apr 2023 at 15:31, Michael Riesch via B4 Relay via
> libcamera-devel <libcamera-devel@lists.libcamera.org> wrote:
>>
>> From: Michael Riesch <michael.riesch@wolfvision.net>
>>
>> Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
>> the status of the zoom lens group and the focus lens group, respectively.
>> The returned data structure contains the current position of the lens group
>> as well as movement indication flags.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
>>  include/media/v4l2-ctrls.h                         |  2 +
>>  include/uapi/linux/v4l2-controls.h                 | 13 ++++++
>>  include/uapi/linux/videodev2.h                     |  2 +
>>  6 files changed, 81 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> index daa4f40869f8..3a270bc63f1a 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> @@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
>>      to the camera, negative values towards infinity. This is a
>>      write-only control.
>>
>> +``V4L2_CID_FOCUS_STATUS (struct)``
>> +    The current status of the focus lens group. This is a read-only control.
>> +    The returned data structure contains the current position and movement
>> +    indication flags. The unit of the current position is undefined. Positive
>> +    values move the focus closer to the camera, negative values towards
>> +    infinity. The possible flags are described in the table below.
> 
> The units are undefined, but positive and negative mean something with
> respect to some unspecified focal distance represented by 0. That
> seems a little odd.
> 
> I was going to suggest that it seems to make sense to follow the same
> units as V4L2_CID_FOCUS_ABSOLUTE, but on reading that description in
> [1] it's the same text.
> I suspect there was a little too much copy/paste from
> V4L2_CID_FOCUS_RELATIVE, or the intent was that increasing the value
> brings the focus closer, and decreasing moves it towards infinity.
> 
> If we did specify that it was the same units as
> V4L2_CID_FOCUS_ABSOLUTE, then what would that mean for use with
> V4L2_CID_FOCUS_RELATIVE? Then again the only user of _RELATIVE appears
> to be ov5693 with atomisp and that just maps it onto _ABSOLUTE, so
> potentially it's redundant and could be deprecated.
> 
> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-camera.html

I think we agree that the _STATUS controls should use the same unit as
the corresponding _ABSOLUTE control, whatever that may be.

Then, the question is whether the description of FOCUS_ABSOLUTE needs to
be revised. I would agree that the intention probably was: "Larger
values move the focus closer to the camera, smaller values move the
focus to infinity." (cf. the phrasing in the description of IRIS_ABSOLUTE).

It would be interesting to know whether zero and negative values are
(intentionally?) included. Since they are not explicitly excluded, my
driver exposes the position of the lens in motor steps to the user
space. If the values were (supposed to be) restricted to positive values
like ZOOM_ABSOLUTE, this would not be allowed of course.

As to the relation to _RELATIVE, I think it should be clear that all
controls should act on the same scale and I don't see any problems here.
However, feel free to point out what I am missing :-)

>> +
>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_LENS_STATUS_IDLE``
>> +      - Focus lens group is at rest.
>> +    * - ``V4L2_LENS_STATUS_BUSY``
>> +      - Focus lens group is moving.
>> +    * - ``V4L2_LENS_STATUS_REACHED``
>> +      - Focus lens group has reached its target position.
>> +    * - ``V4L2_LENS_STATUS_FAILED``
>> +      - Focus lens group has failed to reach its target position. The driver
>> +       will not transition from this state until another action is performed
>> +       by an application.
> 
> When would the lens state transition from V4L2_LENS_STATUS_REACHED to
> V4L2_LENS_STATUS_IDLE?
> If it's reached the position then it is at rest, and being at rest is
> the definition of V4L2_LENS_STATUS_IDLE.
> Likewise the lens always has a target position based on the control
> value, so it's always at V4L2_LENS_STATUS_REACHED when it's not
> moving.
> Is there a need to have 2 states?

Good point, I need to reconsider that (and possibly remove one of those
states).

> If the position is the same units as V4L2_CID_FOCUS_ABSOLUTE, then do
> you leave the determination of state to the application?

I am afraid I don't quite follow.

But FWIW the application should read out the flags to find out whether
the lens is moving and, if this is not the case, whether the last move
command (FOCUS_ABSOLUTE or FOCUS_RELATIVE) has succeeded or failed. The
failed state is important as there might be the possibility that
depending on the zoom lens position certain focus positions are not
available (and vice versa).

>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>      Enables continuous automatic focus adjustments. The effect of manual
>>      focus adjustments while this feature is enabled is undefined,
>> @@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
>>      movement. A negative value moves the zoom lens group towards the
>>      wide-angle direction. The zoom speed unit is driver-specific.
>>
>> +``V4L2_CID_ZOOM_STATUS (struct)``
>> +    The current status of the zoom lens group. This is a read-only control.
>> +    The returned data structure contains the current position and movement
>> +    indication flags. The unit of the current position is driver-specific and
>> +    its value should be a positive integer. The possible flags are described
>> +    in the table below.
>> +
>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_LENS_STATUS_IDLE``
>> +      - Zoom lens group is at rest.
>> +    * - ``V4L2_LENS_STATUS_BUSY``
>> +      - Zoom lens group is moving.
>> +    * - ``V4L2_LENS_STATUS_REACHED``
>> +      - Zoom lens group has reached its target position.
>> +    * - ``V4L2_LENS_STATUS_FAILED``
>> +      - Zoom lens group has failed to reach its target position. The driver will
>> +       not transition from this state until another action is performed by an
>> +       application.
>> +
>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>      This control sets the camera's aperture to the specified value. The
>>      unit is undefined. Larger values open the iris wider, smaller values
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>> index 29169170880a..f6ad30f311c5 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
>> @@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
>>         case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
>>                 pr_cont("HEVC_DECODE_PARAMS");
>>                 break;
>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>> +               pr_cont("LENS_STATUS");
>> +               break;
>>         default:
>>                 pr_cont("unknown type %d", ctrl->type);
>>                 break;
>> @@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>>                         return -EINVAL;
>>                 break;
>>
>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>> +               break;
>> +
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>>         case V4L2_CTRL_TYPE_AREA:
>>                 elem_size = sizeof(struct v4l2_area);
>>                 break;
>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
>> +               elem_size = sizeof(struct v4l2_ctrl_lens_status);
>> +               break;
>>         default:
>>                 if (type < V4L2_CTRL_COMPOUND_TYPES)
>>                         elem_size = sizeof(s32);
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index 564fedee2c88..9b26a3aa9e9c 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>>         case V4L2_CID_CAMERA_ORIENTATION:       return "Camera Orientation";
>>         case V4L2_CID_CAMERA_SENSOR_ROTATION:   return "Camera Sensor Rotation";
>>         case V4L2_CID_HDR_SENSOR_MODE:          return "HDR Sensor Mode";
>> +       case V4L2_CID_FOCUS_STATUS:             return "Focus, Status";
>> +       case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
> 
> Is there a need for the comma in the text strings?

Not sure, actually. Some other strings used commas. Monkey see, monkey do.

Best regards,
Michael

> 
> Cheers
>   Dave
> 
>>
>>         /* FM Radio Modulator controls */
>>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
>> @@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>>                 break;
>> +       case V4L2_CID_FOCUS_STATUS:
>> +       case V4L2_CID_ZOOM_STATUS:
>> +               *type = V4L2_CTRL_TYPE_LENS_STATUS;
>> +               *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
>> +               break;
>>         case V4L2_CID_FLASH_STROBE_STATUS:
>>         case V4L2_CID_AUTO_FOCUS_STATUS:
>>         case V4L2_CID_FLASH_READY:
>> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
>> index e59d9a234631..f7273ffc20c9 100644
>> --- a/include/media/v4l2-ctrls.h
>> +++ b/include/media/v4l2-ctrls.h
>> @@ -52,6 +52,7 @@ struct video_device;
>>   * @p_hdr10_cll:               Pointer to an HDR10 Content Light Level structure.
>>   * @p_hdr10_mastering:         Pointer to an HDR10 Mastering Display structure.
>>   * @p_area:                    Pointer to an area.
>> + * @p_lens_status:             Pointer to a lens status structure.
>>   * @p:                         Pointer to a compound value.
>>   * @p_const:                   Pointer to a constant compound value.
>>   */
>> @@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
>>         struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
>>         struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
>>         struct v4l2_area *p_area;
>> +       struct v4l2_ctrl_lens_status *p_lens_status;
>>         void *p;
>>         const void *p_const;
>>  };
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 5e80daa4ffe0..8b037467ba9a 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
>>
>>  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_BASE+36)
>>
>> +struct v4l2_ctrl_lens_status {
>> +       __u32 flags;
>> +       __s32 current_position;
>> +};
>> +
>> +#define V4L2_LENS_STATUS_IDLE                  (0 << 0)
>> +#define V4L2_LENS_STATUS_BUSY                  (1 << 0)
>> +#define V4L2_LENS_STATUS_REACHED               (1 << 1)
>> +#define V4L2_LENS_STATUS_FAILED                        (1 << 2)
>> +
>> +#define V4L2_CID_FOCUS_STATUS                  (V4L2_CID_CAMERA_CLASS_BASE + 37)
>> +#define V4L2_CID_ZOOM_STATUS                   (V4L2_CID_CAMERA_CLASS_BASE + 38)
>> +
>>  /* FM Modulator class control IDs */
>>
>>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 17a9b975177a..256c21c68720 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
>>         V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS        = 0x0272,
>>         V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX      = 0x0273,
>>         V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS       = 0x0274,
>> +
>> +       V4L2_CTRL_TYPE_LENS_STATUS              = 0x0300,
>>  };
>>
>>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
>>
>> --
>> 2.30.2
>>
