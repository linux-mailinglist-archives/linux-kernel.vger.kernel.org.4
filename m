Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F89679F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjAXQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAXQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:51:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B9402C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:51:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1221230wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/QMMkQsAXBBa4IBbrvm4yS2dc9M5I00KgHxkFWOUUng=;
        b=xeHwl1bE5tMvkNH1gfNfo5m7pzXks85uRUkzl8dV/+6wp2pMQumaw+cFBx8Tc9BOpV
         hQILrbfB6di+QXD1sqHyJfTvZ9ektQMBT3u6ffli/988weTOskp9yP24mQcA19fKUg3C
         P6g2IbYCht9THXNpQsQ2wdPIWobGxZ3c/ZCJOTksrQVV11g5d307vbdKdsX6RQy+vbyU
         aVZxsmoqQbxNKP9Wz1yJRLQjuWQ4gb01JAzaj3+fKUxKenuRbPwx29X92I0XImHVAMh9
         0Z3tXdRAlEeeoGhH5bumdxt5cM+ulVtLf4dFmFVJlg4u3HQ+mlgKBwDW2/7bMJ1J3M8V
         l0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QMMkQsAXBBa4IBbrvm4yS2dc9M5I00KgHxkFWOUUng=;
        b=ZzjopFLmqQ68Z4ZfM56WSVIWYZaSxWUhK+D7tEoFBdQwI7NZLf3kvy2LCaTUntJ98K
         nG8/C9+kszSsc14alkJZmv41KThfzbR3mUOnrEXxB0R86bfg4E5n7k364Xh8WsJ+D/D/
         ixjHwhiVE0c0b23ttLFBokXB1cC3BzwklsCHv3VWlWVpFqC4jMeUKG31cqXbLeSXeJYr
         +MEgU7ZEJXLlwUH0RPLmXeGOHNVSkdQFdpEwNxGJATUR2Ndmil56TacfmSTXcl9LUXej
         VehGN3SLhRZ+YrY9HF0LtXkN2N+YjXcBKYeDRHlykNnF8/G8u22sTVc5vxq2LSObvZuk
         StZw==
X-Gm-Message-State: AFqh2kq+ubNIynVe6Vjk80ub72ilBD/uBPbUSL0eo7s0vAAlhauKjAs+
        fbC4vVdhOFp4Cll92Tsun/LmNg==
X-Google-Smtp-Source: AMrXdXt8XQViyHJmlnaDU66tWa4jYlI82ZCZUzvfPU6LefEDhLrqkRGVUFNirb/KGeJcRRn60uGwuw==
X-Received: by 2002:a05:600c:c0a:b0:3db:2858:db84 with SMTP id fm10-20020a05600c0c0a00b003db2858db84mr19347934wmb.34.1674579075475;
        Tue, 24 Jan 2023 08:51:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebd2:15b:f444:7985? ([2a01:e0a:982:cbb0:ebd2:15b:f444:7985])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c449200b003da105437besm2366267wmo.29.2023.01.24.08.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:51:15 -0800 (PST)
Message-ID: <95132025-8f0f-8179-40b7-8bf83458886a@linaro.org>
Date:   Tue, 24 Jan 2023 17:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] media: meson: vdec: implement 10bit bitstream
 handling
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Roszak <benjamin545@gmail.com>
References: <20230124034058.3407235-1-christianshewitt@gmail.com>
 <20230124034058.3407235-2-christianshewitt@gmail.com>
 <6ff68c4bea9d48980853e9af9db1fc0bf13976ae.camel@ndufresne.ca>
 <07933226-fbab-fa78-6b96-38e365577605@linaro.org>
 <478d5a7569b7879aa3410a5b3049d745867df780.camel@ndufresne.ca>
Organization: Linaro Developer Services
In-Reply-To: <478d5a7569b7879aa3410a5b3049d745867df780.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 17:26, Nicolas Dufresne wrote:
> Le mardi 24 janvier 2023 à 16:26 +0100, Neil Armstrong a écrit :
>> On 24/01/2023 16:21, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>> Le mardi 24 janvier 2023 à 03:40 +0000, Christian Hewitt a écrit :
>>>> From: Benjamin Roszak <benjamin545@gmail.com>
>>>>
>>>> In order to support 10bit bitstream decoding, buffers and MMU
>>>> handling must be cleaned up to support either downscale output
>>>> from compressed 10bit decoding to uncompressed 8bit NV12 output
>>>> or to compressed 10bit proprietary encoded frame format.
>>>
>>> I understand this is step forward, and agree with the patches in general, though
>>> I'd like to know if we can expect 10bit secondary buffers in the future ? Or is
>>> the AMFBC that only 10bit format supported ? Should be expect the 10bit format
>>> definition to be added later ?
>>
>> The support exist, but it stopped when nobody aggreed on how to handle the different
>> layouts generated by the decoder.
>>
>> There's at least 4 possible layouts vs how we represent then in DRM :
>> - GX 8bit: DRM_FORMAT_YUV420_8BIT | DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC, 0)
>> - GX 10bit: DRM_FORMAT_YUV420_10BIT | DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC, 0)
>> - G12 8bit: DRM_FORMAT_YUV420_8BIT | DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_SCATTER,AMLOGIC_FBC_OPTION_MEM_SAVING)
>> - G12 10bit: DRM_FORMAT_YUV420_10BIT | DRM_FORMAT_MOD_AMLOGIC_FBC()AMLOGIC_FBC_LAYOUT_SCATTER, AMLOGIC_FBC_OPTION_MEM_SAVING)
>>
>> And probably more depending on new SoCs and new codecs.
> 
> Thanks, I didn't know. I think V4L2 strategy here would be to pick and expose
> just the minimum to make the mainline driver viable for 10bit decoding (unless
> again you have a secondary format like P010 available). This would suite better
> your users then just waiting for the perfect system to be in place.
> 
> p.s AMLOGIC_FBC_OPTION_MEM_SAVING is unlikely a layout from its name. FBC is
> generally loss-less for correctness, but loss-less compression always have a
> worse case scenerio bigger then the original, so we still need to reserve big
> chunk of memory. For memory limited device, ARM came up with lossy compressor,
> that guaranty a certain compression ratio. This name sounds like a similar
> feature to me.

Ok it's not that simple, seems I need to do a recap of the situation.

The HW decoder is a firmware running on top of a set of propriatery (or perhaps
bought IPS, but hidden behind the firmware) HW.

There's 2 generations:
- the old generation supports only a single decoding at a time, and implements the
"old" codecs (MPEG-1/2, H264, ...)
- the new is build around the "HEVC" core to decode multiple streams with support
of loadable context, and supports H.264, HEVC and VP9 (and VC-1 on new SoCs).

I'll cover only the new core.

The new core supports decoding 8bit and 10bit streams (except for H264), but the
decoder only works on "compressed framebuffers", which is similar to the ARM one
or any other SoC vendor does internally in fact.

But the firmware supports copying the output frames in a non-compressed NV12 double
plane buffers (buffers can't be single, we need to provide 2 buffers with a specific
aligment), but we can also get the compresse buffers and feed them to the display unit.

But between generations, the compressed buffers layout & options generated by the
decoder firmware are different, but on the Display side the IP & the possible options
are the same.

So we *need* to know ther bpp and the compression layout + options on the display
side, and we can't use the SoC name for that, especially from ffmpeg or gstreamer.

But we already upstreamed the DRM modifier a few years ago, so this is done.

So now we need a way from V4L2 to get thoses informations from the /dev/video endpoint to
correctly set the fourcc + modifier for display.

We hoped we could use the same modifier as DRM, but it seems this is now out of scope.

Neil

> 
> Nicolas
> 
>>
>> Neil
>>
>>>
>>>>
>>>> For that, "am21c" name is moved to "amfbc" to reflect the upstream
>>>> Amlogic Compressed framebuffer modifier naming.
>>>>
>>>> Compressed frame buffers allocation is also cleaned up so it
>>>> can be shared with the HEVC decoder implementation.
>>>>
>>>> Signed-off-by: Benjamin Roszak <benjamin545@gmail.com>
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> ---
>>>>    drivers/staging/media/meson/vdec/codec_h264.c |   3 +-
>>>>    .../media/meson/vdec/codec_hevc_common.c      | 161 +++++++++++-------
>>>>    .../media/meson/vdec/codec_hevc_common.h      |   3 +-
>>>>    drivers/staging/media/meson/vdec/codec_vp9.c  |  35 ++--
>>>>    drivers/staging/media/meson/vdec/esparser.c   |   1 +
>>>>    drivers/staging/media/meson/vdec/vdec.h       |   1 +
>>>>    .../staging/media/meson/vdec/vdec_helpers.c   |  44 +++--
>>>>    .../staging/media/meson/vdec/vdec_helpers.h   |  10 +-
>>>>    8 files changed, 161 insertions(+), 97 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/media/meson/vdec/codec_h264.c b/drivers/staging/media/meson/vdec/codec_h264.c
>>>> index c61128fc4bb9..d53c9a464bde 100644
>>>> --- a/drivers/staging/media/meson/vdec/codec_h264.c
>>>> +++ b/drivers/staging/media/meson/vdec/codec_h264.c
>>>> @@ -353,7 +353,8 @@ static void codec_h264_src_change(struct amvdec_session *sess)
>>>>    		frame_width, frame_height, crop_right, crop_bottom);
>>>>    
>>>>    	codec_h264_set_par(sess);
>>>> -	amvdec_src_change(sess, frame_width, frame_height, h264->max_refs + 5);
>>>> +	amvdec_src_change(sess, frame_width, frame_height,
>>>> +			  h264->max_refs + 5, 8);
>>>>    }
>>>>    
>>>>    /*
>>>> diff --git a/drivers/staging/media/meson/vdec/codec_hevc_common.c b/drivers/staging/media/meson/vdec/codec_hevc_common.c
>>>> index 0315cc0911cd..1c74b4837dcb 100644
>>>> --- a/drivers/staging/media/meson/vdec/codec_hevc_common.c
>>>> +++ b/drivers/staging/media/meson/vdec/codec_hevc_common.c
>>>> @@ -30,8 +30,11 @@ const u16 vdec_hevc_parser_cmd[] = {
>>>>    void codec_hevc_setup_decode_head(struct amvdec_session *sess, int is_10bit)
>>>>    {
>>>>    	struct amvdec_core *core = sess->core;
>>>> -	u32 body_size = amvdec_am21c_body_size(sess->width, sess->height);
>>>> -	u32 head_size = amvdec_am21c_head_size(sess->width, sess->height);
>>>> +	u32 use_mmu = codec_hevc_use_mmu(core->platform->revision,
>>>> +					 sess->pixfmt_cap, is_10bit);
>>>> +	u32 body_size = amvdec_amfbc_body_size(sess->width, sess->height,
>>>> +					       is_10bit, use_mmu);
>>>> +	u32 head_size = amvdec_amfbc_head_size(sess->width, sess->height);
>>>>    
>>>>    	if (!codec_hevc_use_fbc(sess->pixfmt_cap, is_10bit)) {
>>>>    		/* Enable 2-plane reference read mode */
>>>> @@ -39,9 +42,17 @@ void codec_hevc_setup_decode_head(struct amvdec_session *sess, int is_10bit)
>>>>    		return;
>>>>    	}
>>>>    
>>>> +	/* enable mem saving mode for 8-bit */
>>>> +	if (!is_10bit)
>>>> +		amvdec_write_dos_bits(core, HEVC_SAO_CTRL5, BIT(9));
>>>> +	else
>>>> +		amvdec_clear_dos_bits(core, HEVC_SAO_CTRL5, BIT(9));
>>>> +
>>>>    	if (codec_hevc_use_mmu(core->platform->revision,
>>>>    			       sess->pixfmt_cap, is_10bit))
>>>>    		amvdec_write_dos(core, HEVCD_MPP_DECOMP_CTL1, BIT(4));
>>>> +	else if (!is_10bit)
>>>> +		amvdec_write_dos(core, HEVCD_MPP_DECOMP_CTL1, BIT(3));
>>>>    	else
>>>>    		amvdec_write_dos(core, HEVCD_MPP_DECOMP_CTL1, 0);
>>>>    
>>>> @@ -73,7 +84,7 @@ static void codec_hevc_setup_buffers_gxbb(struct amvdec_session *sess,
>>>>    
>>>>    		idx = vb->index;
>>>>    
>>>> -		if (codec_hevc_use_downsample(sess->pixfmt_cap, is_10bit))
>>>> +		if (codec_hevc_use_fbc(sess->pixfmt_cap, is_10bit))
>>>>    			buf_y_paddr = comm->fbc_buffer_paddr[idx];
>>>>    		else
>>>>    			buf_y_paddr = vb2_dma_contig_plane_dma_addr(vb, 0);
>>>> @@ -114,8 +125,8 @@ static void codec_hevc_setup_buffers_gxl(struct amvdec_session *sess,
>>>>    {
>>>>    	struct amvdec_core *core = sess->core;
>>>>    	struct v4l2_m2m_buffer *buf;
>>>> -	u32 revision = core->platform->revision;
>>>>    	u32 pixfmt_cap = sess->pixfmt_cap;
>>>> +	const u32 revision = core->platform->revision;
>>>>    	int i;
>>>>    
>>>>    	amvdec_write_dos(core, HEVCD_MPP_ANC2AXI_TBL_CONF_ADDR,
>>>> @@ -127,12 +138,14 @@ static void codec_hevc_setup_buffers_gxl(struct amvdec_session *sess,
>>>>    		dma_addr_t buf_uv_paddr = 0;
>>>>    		u32 idx = vb->index;
>>>>    
>>>> -		if (codec_hevc_use_mmu(revision, pixfmt_cap, is_10bit))
>>>> -			buf_y_paddr = comm->mmu_header_paddr[idx];
>>>> -		else if (codec_hevc_use_downsample(pixfmt_cap, is_10bit))
>>>> -			buf_y_paddr = comm->fbc_buffer_paddr[idx];
>>>> -		else
>>>> +		if (codec_hevc_use_downsample(pixfmt_cap, is_10bit)) {
>>>> +			if (codec_hevc_use_mmu(revision, pixfmt_cap, is_10bit))
>>>> +				buf_y_paddr = comm->mmu_header_paddr[idx];
>>>> +			else
>>>> +				buf_y_paddr = comm->fbc_buffer_paddr[idx];
>>>> +		} else {
>>>>    			buf_y_paddr = vb2_dma_contig_plane_dma_addr(vb, 0);
>>>> +		}
>>>>    
>>>>    		amvdec_write_dos(core, HEVCD_MPP_ANC2AXI_TBL_DATA,
>>>>    				 buf_y_paddr >> 5);
>>>> @@ -150,60 +163,67 @@ static void codec_hevc_setup_buffers_gxl(struct amvdec_session *sess,
>>>>    		amvdec_write_dos(core, HEVCD_MPP_ANC_CANVAS_DATA_ADDR, 0);
>>>>    }
>>>>    
>>>> -void codec_hevc_free_fbc_buffers(struct amvdec_session *sess,
>>>> +void codec_hevc_free_mmu_headers(struct amvdec_session *sess,
>>>>    				 struct codec_hevc_common *comm)
>>>>    {
>>>>    	struct device *dev = sess->core->dev;
>>>> -	u32 am21_size = amvdec_am21c_size(sess->width, sess->height);
>>>>    	int i;
>>>>    
>>>>    	for (i = 0; i < MAX_REF_PIC_NUM; ++i) {
>>>> -		if (comm->fbc_buffer_vaddr[i]) {
>>>> -			dma_free_coherent(dev, am21_size,
>>>> -					  comm->fbc_buffer_vaddr[i],
>>>> -					  comm->fbc_buffer_paddr[i]);
>>>> -			comm->fbc_buffer_vaddr[i] = NULL;
>>>> +		if (comm->mmu_header_vaddr[i]) {
>>>> +			dma_free_coherent(dev, MMU_COMPRESS_HEADER_SIZE,
>>>> +					  comm->mmu_header_vaddr[i],
>>>> +					  comm->mmu_header_paddr[i]);
>>>> +			comm->mmu_header_vaddr[i] = NULL;
>>>>    		}
>>>>    	}
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(codec_hevc_free_fbc_buffers);
>>>> +EXPORT_SYMBOL_GPL(codec_hevc_free_mmu_headers);
>>>>    
>>>> -static int codec_hevc_alloc_fbc_buffers(struct amvdec_session *sess,
>>>> +static int codec_hevc_alloc_mmu_headers(struct amvdec_session *sess,
>>>>    					struct codec_hevc_common *comm)
>>>>    {
>>>>    	struct device *dev = sess->core->dev;
>>>>    	struct v4l2_m2m_buffer *buf;
>>>> -	u32 am21_size = amvdec_am21c_size(sess->width, sess->height);
>>>>    
>>>>    	v4l2_m2m_for_each_dst_buf(sess->m2m_ctx, buf) {
>>>>    		u32 idx = buf->vb.vb2_buf.index;
>>>>    		dma_addr_t paddr;
>>>> -		void *vaddr = dma_alloc_coherent(dev, am21_size, &paddr,
>>>> -						 GFP_KERNEL);
>>>> +		void *vaddr = dma_alloc_coherent(dev, MMU_COMPRESS_HEADER_SIZE,
>>>> +						 &paddr, GFP_KERNEL);
>>>>    		if (!vaddr) {
>>>> -			codec_hevc_free_fbc_buffers(sess, comm);
>>>> +			codec_hevc_free_mmu_headers(sess, comm);
>>>>    			return -ENOMEM;
>>>>    		}
>>>>    
>>>> -		comm->fbc_buffer_vaddr[idx] = vaddr;
>>>> -		comm->fbc_buffer_paddr[idx] = paddr;
>>>> +		comm->mmu_header_vaddr[idx] = vaddr;
>>>> +		comm->mmu_header_paddr[idx] = paddr;
>>>>    	}
>>>>    
>>>>    	return 0;
>>>>    }
>>>>    
>>>> -void codec_hevc_free_mmu_headers(struct amvdec_session *sess,
>>>> +void codec_hevc_free_fbc_buffers(struct amvdec_session *sess,
>>>>    				 struct codec_hevc_common *comm)
>>>>    {
>>>>    	struct device *dev = sess->core->dev;
>>>> +	u32 use_mmu;
>>>> +	u32 am21_size;
>>>>    	int i;
>>>>    
>>>> +	use_mmu = codec_hevc_use_mmu(sess->core->platform->revision,
>>>> +				     sess->pixfmt_cap,
>>>> +				sess->bitdepth == 10 ? 1 : 0);
>>>> +
>>>> +	am21_size = amvdec_amfbc_size(sess->width, sess->height,
>>>> +				      sess->bitdepth == 10 ? 1 : 0, use_mmu);
>>>> +
>>>>    	for (i = 0; i < MAX_REF_PIC_NUM; ++i) {
>>>> -		if (comm->mmu_header_vaddr[i]) {
>>>> -			dma_free_coherent(dev, MMU_COMPRESS_HEADER_SIZE,
>>>> -					  comm->mmu_header_vaddr[i],
>>>> -					  comm->mmu_header_paddr[i]);
>>>> -			comm->mmu_header_vaddr[i] = NULL;
>>>> +		if (comm->fbc_buffer_vaddr[i]) {
>>>> +			dma_free_coherent(dev, am21_size,
>>>> +					  comm->fbc_buffer_vaddr[i],
>>>> +					  comm->fbc_buffer_paddr[i]);
>>>> +			comm->fbc_buffer_vaddr[i] = NULL;
>>>>    		}
>>>>    	}
>>>>    
>>>> @@ -213,33 +233,50 @@ void codec_hevc_free_mmu_headers(struct amvdec_session *sess,
>>>>    				  comm->mmu_map_paddr);
>>>>    		comm->mmu_map_vaddr = NULL;
>>>>    	}
>>>> +
>>>> +	codec_hevc_free_mmu_headers(sess, comm);
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(codec_hevc_free_mmu_headers);
>>>> +EXPORT_SYMBOL_GPL(codec_hevc_free_fbc_buffers);
>>>>    
>>>> -static int codec_hevc_alloc_mmu_headers(struct amvdec_session *sess,
>>>> +static int codec_hevc_alloc_fbc_buffers(struct amvdec_session *sess,
>>>>    					struct codec_hevc_common *comm)
>>>>    {
>>>>    	struct device *dev = sess->core->dev;
>>>>    	struct v4l2_m2m_buffer *buf;
>>>> +	u32 use_mmu;
>>>> +	u32 am21_size;
>>>> +	const u32 revision = sess->core->platform->revision;
>>>> +	const u32 is_10bit = sess->bitdepth == 10 ? 1 : 0;
>>>> +	int ret;
>>>>    
>>>> -	comm->mmu_map_vaddr = dma_alloc_coherent(dev, MMU_MAP_SIZE,
>>>> -						 &comm->mmu_map_paddr,
>>>> -						 GFP_KERNEL);
>>>> -	if (!comm->mmu_map_vaddr)
>>>> -		return -ENOMEM;
>>>> +	use_mmu = codec_hevc_use_mmu(revision, sess->pixfmt_cap,
>>>> +				     is_10bit);
>>>> +
>>>> +	am21_size = amvdec_amfbc_size(sess->width, sess->height,
>>>> +				      is_10bit, use_mmu);
>>>>    
>>>>    	v4l2_m2m_for_each_dst_buf(sess->m2m_ctx, buf) {
>>>>    		u32 idx = buf->vb.vb2_buf.index;
>>>>    		dma_addr_t paddr;
>>>> -		void *vaddr = dma_alloc_coherent(dev, MMU_COMPRESS_HEADER_SIZE,
>>>> -						 &paddr, GFP_KERNEL);
>>>> +
>>>> +		void *vaddr = dma_alloc_coherent(dev, am21_size, &paddr,
>>>> +						 GFP_KERNEL);
>>>>    		if (!vaddr) {
>>>> -			codec_hevc_free_mmu_headers(sess, comm);
>>>> +			codec_hevc_free_fbc_buffers(sess, comm);
>>>>    			return -ENOMEM;
>>>>    		}
>>>>    
>>>> -		comm->mmu_header_vaddr[idx] = vaddr;
>>>> -		comm->mmu_header_paddr[idx] = paddr;
>>>> +		comm->fbc_buffer_vaddr[idx] = vaddr;
>>>> +		comm->fbc_buffer_paddr[idx] = paddr;
>>>> +	}
>>>> +
>>>> +	if (codec_hevc_use_mmu(revision, sess->pixfmt_cap, is_10bit) &&
>>>> +	    codec_hevc_use_downsample(sess->pixfmt_cap, is_10bit)) {
>>>> +		ret = codec_hevc_alloc_mmu_headers(sess, comm);
>>>> +		if (ret) {
>>>> +			codec_hevc_free_fbc_buffers(sess, comm);
>>>> +			return ret;
>>>> +		}
>>>>    	}
>>>>    
>>>>    	return 0;
>>>> @@ -250,21 +287,24 @@ int codec_hevc_setup_buffers(struct amvdec_session *sess,
>>>>    			     int is_10bit)
>>>>    {
>>>>    	struct amvdec_core *core = sess->core;
>>>> +	struct device *dev = core->dev;
>>>>    	int ret;
>>>>    
>>>> -	if (codec_hevc_use_downsample(sess->pixfmt_cap, is_10bit)) {
>>>> -		ret = codec_hevc_alloc_fbc_buffers(sess, comm);
>>>> -		if (ret)
>>>> -			return ret;
>>>> +	if (codec_hevc_use_mmu(core->platform->revision,
>>>> +			       sess->pixfmt_cap, is_10bit)) {
>>>> +		comm->mmu_map_vaddr = dma_alloc_coherent(dev, MMU_MAP_SIZE,
>>>> +							 &comm->mmu_map_paddr,
>>>> +							 GFP_KERNEL);
>>>> +		if (!comm->mmu_map_vaddr)
>>>> +			return -ENOMEM;
>>>>    	}
>>>>    
>>>>    	if (codec_hevc_use_mmu(core->platform->revision,
>>>> -			       sess->pixfmt_cap, is_10bit)) {
>>>> -		ret = codec_hevc_alloc_mmu_headers(sess, comm);
>>>> -		if (ret) {
>>>> -			codec_hevc_free_fbc_buffers(sess, comm);
>>>> +			       sess->pixfmt_cap, is_10bit) ||
>>>> +	    codec_hevc_use_downsample(sess->pixfmt_cap, is_10bit)) {
>>>> +		ret = codec_hevc_alloc_fbc_buffers(sess, comm);
>>>> +		if (ret)
>>>>    			return ret;
>>>> -		}
>>>>    	}
>>>>    
>>>>    	if (core->platform->revision == VDEC_REVISION_GXBB)
>>>> @@ -278,19 +318,24 @@ EXPORT_SYMBOL_GPL(codec_hevc_setup_buffers);
>>>>    
>>>>    void codec_hevc_fill_mmu_map(struct amvdec_session *sess,
>>>>    			     struct codec_hevc_common *comm,
>>>> -			     struct vb2_buffer *vb)
>>>> +			     struct vb2_buffer *vb,
>>>> +			     u32 is_10bit)
>>>>    {
>>>> -	u32 size = amvdec_am21c_size(sess->width, sess->height);
>>>> -	u32 nb_pages = size / PAGE_SIZE;
>>>> +	u32 use_mmu;
>>>> +	u32 size;
>>>> +	u32 nb_pages;
>>>>    	u32 *mmu_map = comm->mmu_map_vaddr;
>>>>    	u32 first_page;
>>>>    	u32 i;
>>>>    
>>>> -	if (sess->pixfmt_cap == V4L2_PIX_FMT_NV12M)
>>>> -		first_page = comm->fbc_buffer_paddr[vb->index] >> PAGE_SHIFT;
>>>> -	else
>>>> -		first_page = vb2_dma_contig_plane_dma_addr(vb, 0) >> PAGE_SHIFT;
>>>> +	use_mmu = codec_hevc_use_mmu(sess->core->platform->revision,
>>>> +				     sess->pixfmt_cap, is_10bit);
>>>> +
>>>> +	size = amvdec_amfbc_size(sess->width, sess->height, is_10bit,
>>>> +				 use_mmu);
>>>>    
>>>> +	nb_pages = size / PAGE_SIZE;
>>>> +	first_page = comm->fbc_buffer_paddr[vb->index] >> PAGE_SHIFT;
>>>>    	for (i = 0; i < nb_pages; ++i)
>>>>    		mmu_map[i] = first_page + i;
>>>>    }
>>>> diff --git a/drivers/staging/media/meson/vdec/codec_hevc_common.h b/drivers/staging/media/meson/vdec/codec_hevc_common.h
>>>> index cf072b8a9da2..13f9f1d90a94 100644
>>>> --- a/drivers/staging/media/meson/vdec/codec_hevc_common.h
>>>> +++ b/drivers/staging/media/meson/vdec/codec_hevc_common.h
>>>> @@ -64,6 +64,7 @@ int codec_hevc_setup_buffers(struct amvdec_session *sess,
>>>>    
>>>>    void codec_hevc_fill_mmu_map(struct amvdec_session *sess,
>>>>    			     struct codec_hevc_common *comm,
>>>> -			     struct vb2_buffer *vb);
>>>> +			     struct vb2_buffer *vb,
>>>> +			     u32 is_10bit);
>>>>    
>>>>    #endif
>>>> diff --git a/drivers/staging/media/meson/vdec/codec_vp9.c b/drivers/staging/media/meson/vdec/codec_vp9.c
>>>> index 394df5761556..8e3bbf0db4b3 100644
>>>> --- a/drivers/staging/media/meson/vdec/codec_vp9.c
>>>> +++ b/drivers/staging/media/meson/vdec/codec_vp9.c
>>>> @@ -458,12 +458,6 @@ struct codec_vp9 {
>>>>    	struct list_head ref_frames_list;
>>>>    	u32 frames_num;
>>>>    
>>>> -	/* In case of downsampling (decoding with FBC but outputting in NV12M),
>>>> -	 * we need to allocate additional buffers for FBC.
>>>> -	 */
>>>> -	void      *fbc_buffer_vaddr[MAX_REF_PIC_NUM];
>>>> -	dma_addr_t fbc_buffer_paddr[MAX_REF_PIC_NUM];
>>>> -
>>>>    	int ref_frame_map[REF_FRAMES];
>>>>    	int next_ref_frame_map[REF_FRAMES];
>>>>    	struct vp9_frame *frame_refs[REFS_PER_FRAME];
>>>> @@ -901,11 +895,8 @@ static void codec_vp9_set_sao(struct amvdec_session *sess,
>>>>    		buf_y_paddr =
>>>>    		       vb2_dma_contig_plane_dma_addr(vb, 0);
>>>>    
>>>> -	if (codec_hevc_use_fbc(sess->pixfmt_cap, vp9->is_10bit)) {
>>>> -		val = amvdec_read_dos(core, HEVC_SAO_CTRL5) & ~0xff0200;
>>>> -		amvdec_write_dos(core, HEVC_SAO_CTRL5, val);
>>>> +	if (codec_hevc_use_fbc(sess->pixfmt_cap, vp9->is_10bit))
>>>>    		amvdec_write_dos(core, HEVC_CM_BODY_START_ADDR, buf_y_paddr);
>>>> -	}
>>>>    
>>>>    	if (sess->pixfmt_cap == V4L2_PIX_FMT_NV12M) {
>>>>    		buf_y_paddr =
>>>> @@ -920,8 +911,13 @@ static void codec_vp9_set_sao(struct amvdec_session *sess,
>>>>    
>>>>    	if (codec_hevc_use_mmu(core->platform->revision, sess->pixfmt_cap,
>>>>    			       vp9->is_10bit)) {
>>>> -		amvdec_write_dos(core, HEVC_CM_HEADER_START_ADDR,
>>>> -				 vp9->common.mmu_header_paddr[vb->index]);
>>>> +		dma_addr_t header_adr;
>>>> +
>>>> +		if (codec_hevc_use_downsample(sess->pixfmt_cap, vp9->is_10bit))
>>>> +			header_adr = vp9->common.mmu_header_paddr[vb->index];
>>>> +		else
>>>> +			header_adr = vb2_dma_contig_plane_dma_addr(vb, 0);
>>>> +		amvdec_write_dos(core, HEVC_CM_HEADER_START_ADDR, header_adr);
>>>>    		/* use HEVC_CM_HEADER_START_ADDR */
>>>>    		amvdec_write_dos_bits(core, HEVC_SAO_CTRL5, BIT(10));
>>>>    	}
>>>> @@ -1148,9 +1144,13 @@ static void codec_vp9_set_mc(struct amvdec_session *sess,
>>>>    {
>>>>    	struct amvdec_core *core = sess->core;
>>>>    	u32 scale = 0;
>>>> +	u32 use_mmu;
>>>>    	u32 sz;
>>>>    	int i;
>>>>    
>>>> +	use_mmu = codec_hevc_use_mmu(core->platform->revision,
>>>> +				     sess->pixfmt_cap, vp9->is_10bit);
>>>> +
>>>>    	amvdec_write_dos(core, HEVCD_MPP_ANC_CANVAS_ACCCONFIG_ADDR, 1);
>>>>    	codec_vp9_set_refs(sess, vp9);
>>>>    	amvdec_write_dos(core, HEVCD_MPP_ANC_CANVAS_ACCCONFIG_ADDR,
>>>> @@ -1166,8 +1166,9 @@ static void codec_vp9_set_mc(struct amvdec_session *sess,
>>>>    		    vp9->frame_refs[i]->height != vp9->height)
>>>>    			scale = 1;
>>>>    
>>>> -		sz = amvdec_am21c_body_size(vp9->frame_refs[i]->width,
>>>> -					    vp9->frame_refs[i]->height);
>>>> +		sz = amvdec_amfbc_body_size(vp9->frame_refs[i]->width,
>>>> +					    vp9->frame_refs[i]->height,
>>>> +					    vp9->is_10bit, use_mmu);
>>>>    
>>>>    		amvdec_write_dos(core, VP9D_MPP_REFINFO_DATA,
>>>>    				 vp9->frame_refs[i]->width);
>>>> @@ -1283,7 +1284,8 @@ static void codec_vp9_process_frame(struct amvdec_session *sess)
>>>>    	if (codec_hevc_use_mmu(core->platform->revision, sess->pixfmt_cap,
>>>>    			       vp9->is_10bit))
>>>>    		codec_hevc_fill_mmu_map(sess, &vp9->common,
>>>> -					&vp9->cur_frame->vbuf->vb2_buf);
>>>> +					&vp9->cur_frame->vbuf->vb2_buf,
>>>> +					vp9->is_10bit);
>>>>    
>>>>    	intra_only = param->p.show_frame ? 0 : param->p.intra_only;
>>>>    
>>>> @@ -2130,7 +2132,8 @@ static irqreturn_t codec_vp9_threaded_isr(struct amvdec_session *sess)
>>>>    
>>>>    	codec_vp9_fetch_rpm(sess);
>>>>    	if (codec_vp9_process_rpm(vp9)) {
>>>> -		amvdec_src_change(sess, vp9->width, vp9->height, 16);
>>>> +		amvdec_src_change(sess, vp9->width, vp9->height, 16,
>>>> +				  vp9->is_10bit ? 10 : 8);
>>>>    
>>>>    		/* No frame is actually processed */
>>>>    		vp9->cur_frame = NULL;
>>>> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
>>>> index 1904d58875ad..3cd29ab4f979 100644
>>>> --- a/drivers/staging/media/meson/vdec/esparser.c
>>>> +++ b/drivers/staging/media/meson/vdec/esparser.c
>>>> @@ -320,6 +320,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>>>>    		if (esparser_vififo_get_free_space(sess) < payload_size ||
>>>>    		    atomic_read(&sess->esparser_queued_bufs) >= num_dst_bufs)
>>>>    			return -EAGAIN;
>>>> +
>>>>    	} else if (esparser_vififo_get_free_space(sess) < payload_size) {
>>>>    		return -EAGAIN;
>>>>    	}
>>>> diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
>>>> index 0906b8fb5cc6..a48170fe4cff 100644
>>>> --- a/drivers/staging/media/meson/vdec/vdec.h
>>>> +++ b/drivers/staging/media/meson/vdec/vdec.h
>>>> @@ -244,6 +244,7 @@ struct amvdec_session {
>>>>    	u32 width;
>>>>    	u32 height;
>>>>    	u32 colorspace;
>>>> +	u32 bitdepth;
>>>>    	u8 ycbcr_enc;
>>>>    	u8 quantization;
>>>>    	u8 xfer_func;
>>>> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
>>>> index 7d2a75653250..fef76142f0c5 100644
>>>> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
>>>> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
>>>> @@ -50,32 +50,40 @@ void amvdec_write_parser(struct amvdec_core *core, u32 reg, u32 val)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(amvdec_write_parser);
>>>>    
>>>> -/* 4 KiB per 64x32 block */
>>>> -u32 amvdec_am21c_body_size(u32 width, u32 height)
>>>> +/* AMFBC body is made out of 64x32 blocks with varying block size */
>>>> +u32 amvdec_amfbc_body_size(u32 width, u32 height, u32 is_10bit, u32 use_mmu)
>>>>    {
>>>>    	u32 width_64 = ALIGN(width, 64) / 64;
>>>>    	u32 height_32 = ALIGN(height, 32) / 32;
>>>> +	u32 blk_size = 4096;
>>>>    
>>>> -	return SZ_4K * width_64 * height_32;
>>>> +	if (!is_10bit) {
>>>> +		if (use_mmu)
>>>> +			blk_size = 3200;
>>>> +		else
>>>> +			blk_size = 3072;
>>>> +	}
>>>> +
>>>> +	return blk_size * width_64 * height_32;
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(amvdec_am21c_body_size);
>>>> +EXPORT_SYMBOL_GPL(amvdec_amfbc_body_size);
>>>>    
>>>>    /* 32 bytes per 128x64 block */
>>>> -u32 amvdec_am21c_head_size(u32 width, u32 height)
>>>> +u32 amvdec_amfbc_head_size(u32 width, u32 height)
>>>>    {
>>>>    	u32 width_128 = ALIGN(width, 128) / 128;
>>>>    	u32 height_64 = ALIGN(height, 64) / 64;
>>>>    
>>>>    	return 32 * width_128 * height_64;
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(amvdec_am21c_head_size);
>>>> +EXPORT_SYMBOL_GPL(amvdec_amfbc_head_size);
>>>>    
>>>> -u32 amvdec_am21c_size(u32 width, u32 height)
>>>> +u32 amvdec_amfbc_size(u32 width, u32 height, u32 is_10bit, u32 use_mmu)
>>>>    {
>>>> -	return ALIGN(amvdec_am21c_body_size(width, height) +
>>>> -		     amvdec_am21c_head_size(width, height), SZ_64K);
>>>> +	return ALIGN(amvdec_amfbc_body_size(width, height, is_10bit, use_mmu) +
>>>> +		     amvdec_amfbc_head_size(width, height), SZ_64K);
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(amvdec_am21c_size);
>>>> +EXPORT_SYMBOL_GPL(amvdec_amfbc_size);
>>>>    
>>>>    static int canvas_alloc(struct amvdec_session *sess, u8 *canvas_id)
>>>>    {
>>>> @@ -440,7 +448,7 @@ void amvdec_set_par_from_dar(struct amvdec_session *sess,
>>>>    EXPORT_SYMBOL_GPL(amvdec_set_par_from_dar);
>>>>    
>>>>    void amvdec_src_change(struct amvdec_session *sess, u32 width,
>>>> -		       u32 height, u32 dpb_size)
>>>> +		       u32 height, u32 dpb_size, u32 bitdepth)
>>>>    {
>>>>    	static const struct v4l2_event ev = {
>>>>    		.type = V4L2_EVENT_SOURCE_CHANGE,
>>>> @@ -448,25 +456,27 @@ void amvdec_src_change(struct amvdec_session *sess, u32 width,
>>>>    
>>>>    	v4l2_ctrl_s_ctrl(sess->ctrl_min_buf_capture, dpb_size);
>>>>    
>>>> +	sess->bitdepth = bitdepth;
>>>> +
>>>>    	/*
>>>>    	 * Check if the capture queue is already configured well for our
>>>> -	 * usecase. If so, keep decoding with it and do not send the event
>>>> +	 * usecase. If so, keep decoding with it.
>>>>    	 */
>>>>    	if (sess->streamon_cap &&
>>>>    	    sess->width == width &&
>>>>    	    sess->height == height &&
>>>>    	    dpb_size <= sess->num_dst_bufs) {
>>>>    		sess->fmt_out->codec_ops->resume(sess);
>>>> -		return;
>>>> +	} else {
>>>> +		sess->status = STATUS_NEEDS_RESUME;
>>>> +		sess->changed_format = 0;
>>>>    	}
>>>>    
>>>> -	sess->changed_format = 0;
>>>>    	sess->width = width;
>>>>    	sess->height = height;
>>>> -	sess->status = STATUS_NEEDS_RESUME;
>>>>    
>>>> -	dev_dbg(sess->core->dev, "Res. changed (%ux%u), DPB size %u\n",
>>>> -		width, height, dpb_size);
>>>> +	dev_dbg(sess->core->dev, "Res. changed (%ux%u), DPB %u, bitdepth %u\n",
>>>> +		width, height, dpb_size, bitdepth);
>>>>    	v4l2_event_queue_fh(&sess->fh, &ev);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(amvdec_src_change);
>>>> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
>>>> index 4bf3e61d081b..1a711679d26a 100644
>>>> --- a/drivers/staging/media/meson/vdec/vdec_helpers.h
>>>> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
>>>> @@ -27,9 +27,10 @@ void amvdec_clear_dos_bits(struct amvdec_core *core, u32 reg, u32 val);
>>>>    u32 amvdec_read_parser(struct amvdec_core *core, u32 reg);
>>>>    void amvdec_write_parser(struct amvdec_core *core, u32 reg, u32 val);
>>>>    
>>>> -u32 amvdec_am21c_body_size(u32 width, u32 height);
>>>> -u32 amvdec_am21c_head_size(u32 width, u32 height);
>>>> -u32 amvdec_am21c_size(u32 width, u32 height);
>>>> +/* Helpers for the Amlogic compressed framebuffer format */
>>>> +u32 amvdec_amfbc_body_size(u32 width, u32 height, u32 is_10bit, u32 use_mmu);
>>>> +u32 amvdec_amfbc_head_size(u32 width, u32 height);
>>>> +u32 amvdec_amfbc_size(u32 width, u32 height, u32 is_10bit, u32 use_mmu);
>>>>    
>>>>    /**
>>>>     * amvdec_dst_buf_done_idx() - Signal that a buffer is done decoding
>>>> @@ -77,9 +78,10 @@ void amvdec_set_par_from_dar(struct amvdec_session *sess,
>>>>     * @width: picture width detected by the hardware
>>>>     * @height: picture height detected by the hardware
>>>>     * @dpb_size: Decoded Picture Buffer size (= amount of buffers for decoding)
>>>> + * @bitdepth: Bit depth (usually 10 or 8) of the coded content
>>>>     */
>>>>    void amvdec_src_change(struct amvdec_session *sess, u32 width,
>>>> -		       u32 height, u32 dpb_size);
>>>> +		       u32 height, u32 dpb_size, u32 bitdepth);
>>>>    
>>>>    /**
>>>>     * amvdec_abort() - Abort the current decoding session
>>>
>>
> 

