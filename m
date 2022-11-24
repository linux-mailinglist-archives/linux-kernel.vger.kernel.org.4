Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91586376E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiKXK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKXK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:56:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D32F48419;
        Thu, 24 Nov 2022 02:56:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6FE2B82777;
        Thu, 24 Nov 2022 10:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03929C433D7;
        Thu, 24 Nov 2022 10:56:43 +0000 (UTC)
Message-ID: <8e3a3b74-0016-8e07-fa1b-fab34014f801@xs4all.nl>
Date:   Thu, 24 Nov 2022 11:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] media: v4l2-ctrl: Add main 10 still picture profile for
 hevc
Content-Language: en-US
To:     "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>
Cc:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "Maheshwar Ajja (QUIC)" <quic_majja@quicinc.com>,
        quic_jdas <quic_jdas@quicinc.com>
References: <1661239563-14346-1-git-send-email-quic_dikshita@quicinc.com>
 <7122b146-46c7-7e58-5b26-4b94d3a8c1d8@xs4all.nl>
 <DM6PR02MB514811A30653D54C9010F25AF3759@DM6PR02MB5148.namprd02.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <DM6PR02MB514811A30653D54C9010F25AF3759@DM6PR02MB5148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 08:34, Dikshita Agarwal (QUIC) wrote:
> Hi Hans,
> 
> -----Original Message-----
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl> 
> Sent: Wednesday, August 24, 2022 5:36 PM
> To: Dikshita Agarwal (QUIC) <quic_dikshita@quicinc.com>; linux-media@vger.kernel.org; linux-kernel@vger.kernel.org; ezequiel@collabora.com
> Cc: stanimir.varbanov@linaro.org; linux-arm-msm@vger.kernel.org; Vikash Garodia (QUIC) <quic_vgarodia@quicinc.com>; Maheshwar Ajja (QUIC) <quic_majja@quicinc.com>; quic_jdas <quic_jdas@quicinc.com>
> Subject: Re: [PATCH] media: v4l2-ctrl: Add main 10 still picture profile for hevc
> 
> Hi Dikshita,
> 
> On 23/08/2022 09:26, Dikshita Agarwal wrote:
>> Add main 10 still picture profile for HEVC encoder.
> 
> Hmm, is this the same as the "Main 4:4:4 Still Picture" profile mentioned here:
> 
> https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding#Version_2_profiles
> 
> If not, where it is defined? I would also prefer to have this patch merged together with a driver that uses it.
> 
> It is different and definition can be found in Latest HEVC spec, Annex A, A.3.3 Main 10 and Main 10 Still Picture profiles.
> https://www.itu.int/rec/dologin_pub.asp?lang=s&id=T-REC-H.265-201906-S!!PDF-E&type=items

It will be useful to have a reference to that in the documentation.

Also note that I can't merge this without a driver that uses it!

Regards,

	Hans

> 
> Thanks,
> Dikshita
> 
> Regards,
> 
> 	Hans
> 
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>>  include/uapi/linux/v4l2-controls.h                        | 1 +
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 2a165ae..5b2da84 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -2424,6 +2424,8 @@ enum v4l2_mpeg_video_hevc_profile -
>>        - Main still picture profile.
>>      * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10``
>>        - Main 10 profile.
>> +    * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10_STILL_PICTURE``
>> +      - Main 10 still picture profile.
>>  
>>  .. raw:: latex
>>  
>> diff --git a/include/uapi/linux/v4l2-controls.h 
>> b/include/uapi/linux/v4l2-controls.h
>> index 5f46bf4..1159337 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -743,6 +743,7 @@ enum v4l2_mpeg_video_hevc_profile {
>>  	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN = 0,
>>  	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE = 1,
>>  	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10 = 2,
>> +	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10_STILL_PICTURE = 3,
>>  };
>>  #define V4L2_CID_MPEG_VIDEO_HEVC_LEVEL		(V4L2_CID_CODEC_BASE + 616)
>>  enum v4l2_mpeg_video_hevc_level {

