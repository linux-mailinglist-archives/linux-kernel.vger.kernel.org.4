Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC272FD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjFNLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbjFNLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:55:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03331BFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:55:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f62b552751so8412077e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686743735; x=1689335735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv/GwV2w/s1XOWDjj7UvX/0sKbvp29mJL9R2dK69wc=;
        b=IOwIuW/a1zAfPZaRWrd646FOcfeyRubilQTZrt+HFVhmIYBiDZ4AV1pos3rO2n3or+
         Ls88VyeCX2rUUHKLZDeBMpv4117TCTdvjlA90Kjtp4XC2+gLpkcBIRqMtD8dfPkXI0iw
         AEbh07I264SrfU/dVYkN6nN1liKLNvYBi8acMrRosd4Ekj0yaodPJIVvlGoupeoccd/L
         qTbs/reSnSG5eZP7qT6BwCKoxsJjupzk7eMIjxWd09D9Crfl6D9fwhnDT6EumsLwVcYV
         WPhXagWGygY6SeMPtjxg/MdNwflXiF6dbJaV8RJe8aO3Hw901Dnz9b7YINVdLHFWDC5L
         QbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686743735; x=1689335735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv/GwV2w/s1XOWDjj7UvX/0sKbvp29mJL9R2dK69wc=;
        b=Tvs/8s5y6Gml+VFyydORHBZL6Zdncgq4+GOND+8C3teRAlAuJXp3C6boWTMpmaQqyZ
         fOo4sp+UUOZ7Q0WrIiHEydouuyXI6vvcR4tgwQIeHkSzQpdFzTT9IT/2x1VQFgfwnoQN
         wcDxZRrdf2qEutGglIf+bcT/UqCBlLRwrGkvGXx2pv5qlQGfKglB+A8w1qE1StiCrdf6
         ENPLvs4M9LhDq2qDFGnOtQDtqO5GSi+/wDqDl71IZqHpUME4WYkv41oKbOFSaid2ntbB
         5EnJhEhWTCcBwiCL0Sq+baGTfyc1kQHcAPUzeXgSG0le0EcllfUjYGt7x1acyPeoqoG0
         mu9w==
X-Gm-Message-State: AC+VfDyhPntUQ+zUt1la47JxMKek2GVBHpKV5nOhQ58wIxR1RGiqd3Qo
        ZgfuXzv1FG5FnCAC1GPu7VsFBA==
X-Google-Smtp-Source: ACHHUZ7UIgwPnNgtVg8gTMmxTLbVJ6LtLPWnod6cj64WHWT1Ri75+jSp2Zz2YTYWMn4FC16sclFpjw==
X-Received: by 2002:a05:6512:2f5:b0:4f6:7e3:ac87 with SMTP id m21-20020a05651202f500b004f607e3ac87mr9216669lfq.14.1686743734996;
        Wed, 14 Jun 2023 04:55:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ja15-20020a05600c556f00b003f61177faffsm6547045wmb.0.2023.06.14.04.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 04:55:34 -0700 (PDT)
Message-ID: <5e9e525a-690d-38ce-d80f-da433d4062fd@linaro.org>
Date:   Wed, 14 Jun 2023 12:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ALSA: compress: allow setting codec params after next
 track
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com,
        corbet@lwn.net, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_plai@quicinc.com, quic_mohs@quicinc.com
References: <20230609150416.24525-1-srinivas.kandagatla@linaro.org>
 <87edmebk2w.wl-tiwai@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <87edmebk2w.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Takashi for review,

On 14/06/2023 08:04, Takashi Iwai wrote:
> On Fri, 09 Jun 2023 17:04:16 +0200,
> Srinivas Kandagatla wrote:
>>
>> For gapless playback it is possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Or if DSP's like QDSP have abililty to switch decoders on single stream
>> for each track, then this call could be used to set new codec parameters.
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
>> some additional checks to enforce proper state machine.
>>
>> With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
>> anytime after setting next track and additional check in write should
>> also ensure that params are set before writing new data.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Changes since v1/RFC:
>> 	- removed introduction of new IOCTL, as suggested.
>> 	- update the state-machine doc.
>>
>>   .../sound/designs/compress-offload.rst        | 52 +++++++++----------
>>   sound/core/compress_offload.c                 | 10 ++--
>>   2 files changed, 33 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
>> index 935f325dbc77..205cadcabe70 100644
>> --- a/Documentation/sound/designs/compress-offload.rst
>> +++ b/Documentation/sound/designs/compress-offload.rst
>> @@ -256,32 +256,32 @@ Gapless Playback SM
>>   For Gapless, we move from running state to partial drain and back, along
>>   with setting of meta_data and signalling for next track ::
>>   
>> -
>> -                                        +----------+
>> -                compr_drain_notify()    |          |
>> -              +------------------------>|  RUNNING |
>> -              |                         |          |
>> -              |                         +----------+
>> -              |                              |
>> -              |                              |
>> -              |                              | compr_next_track()
>> -              |                              |
>> -              |                              V
>> -              |                         +----------+
>> -              |                         |          |
>> -              |                         |NEXT_TRACK|
>> -              |                         |          |
>> -              |                         +----------+
>> -              |                              |
>> -              |                              |
>> -              |                              | compr_partial_drain()
>> -              |                              |
>> -              |                              V
>> -              |                         +----------+
>> -              |                         |          |
>> -              +------------------------ | PARTIAL_ |
>> -                                        |  DRAIN   |
>> -                                        +----------+
>> +                            +----------+
>> +     compr_drain_notify()   |          | compr_set_params() iff next-track set.
>> +  +------------------------>|  RUNNING |----------------------+
>> +  |                         |          |                      |
>> +  |                         +----------+                      |
>> +  |                              |                            |
>> +  |                              |                            |
>> +  |                              | compr_next_track()         |
>> +  |                              |                            V
>> +  |                              V                            |
>> +  |                         +----------+                      |
>> +  |                         |          |                      |
>> +  |                         |NEXT_TRACK|                      |
>> +  |                         |          |                      |
>> +  |                         +----------+                      |
>> +  |                              |                            |
>> +  |                              +----------------------------+
>> +  |                              |
>> +  |                              | compr_partial_drain()
>> +  |                              |
>> +  |                              V
>> +  |                         +----------+
>> +  |                         |          |
>> +  +------------------------ | PARTIAL_ |
>> +                            |  DRAIN   |
>> +                            +----------+
>>   
>>   Not supported
>>   =============
>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
>> index 243acad89fd3..fe67228e74b3 100644
>> --- a/sound/core/compress_offload.c
>> +++ b/sound/core/compress_offload.c
>> @@ -294,6 +294,9 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
>>   	case SNDRV_PCM_STATE_SETUP:
>>   	case SNDRV_PCM_STATE_PREPARED:
>>   	case SNDRV_PCM_STATE_RUNNING:
>> +		/* Make sure next track params are set before writing new data */
>> +		if (stream->next_track)
>> +			return -EPERM;
> 
> Hm, does this logic correctly match with the comment above?
Yes I agree, it bit confusing and also going to break the partial drain 
path.
> Also, this misses the mutex unlock.

Thinking about this again, Its not required have this check here to 
start with.

Something like below works, I can send this as v3, if this looks fine.

------------------------->cut<----------------------------------

diff --git a/Documentation/sound/designs/compress-offload.rst 
b/Documentation/sound/designs/compress-offload.rst
index 935f325dbc77..655624f77092 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -268,11 +268,12 @@ with setting of meta_data and signalling for next 
track ::
                |                              |
                |                              V
                |                         +----------+
-              |                         |          |
-              |                         |NEXT_TRACK|
-              |                         |          |
-              |                         +----------+
-              |                              |
+              |    compr_set_params()   |          |
+              |             +-----------|NEXT_TRACK|
+              |             |           |          |
+              |             |           +--+-------+
+              |             |              | |
+              |             +--------------+ |
                |                              |
                |                              | compr_partial_drain()
                |                              |
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 243acad89fd3..30f73097447b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -589,7 +589,7 @@ snd_compr_set_params(struct snd_compr_stream 
*stream, unsigned long arg)
         struct snd_compr_params *params;
         int retval;

-       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN || 
stream->next_track) {
                 /*
                  * we should allow parameter change only when stream 
has been
                  * opened not in other cases
@@ -612,6 +612,9 @@ snd_compr_set_params(struct snd_compr_stream 
*stream, unsigned long arg)
                 if (retval)
                         goto out;

+               if (stream->next_track)
+                       goto out;
+
                 stream->metadata_set = false;
                 stream->next_track = false;
------------------------->cut<----------------------------------

> 
> 
> thanks,
> 
> Takashi
