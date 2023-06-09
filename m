Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940E72A0C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjFIQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFIQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:58:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3713A3A8F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:58:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso2531187e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686329881; x=1688921881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUb5nVm7hFEBhuv59behzuKW8dLna7emUUL4IOqj/Es=;
        b=k0pP6Yhd3tBEViDCSHkbzEXgsqBEiMFY4yu+KoHTzdKB2j5qstboVWNWylre1DXBAi
         bIOqo0z/GXU22r0SD+x4ONdlvCmhoecZ5INom/OyUQgupL45ebVoRNdWWribHpPyBrkj
         W6iv9HkY1PNCAhp9gdn9wz2y9nRHHoJMsAEAXJOnkYtl0MW9rdC6CpFqIJdhr3QKYF1X
         OGFU1rKCxbgE6MHmhJIs1ldfddy9bjqDjIlQMsM4PyX8OVvrnUCP+q9Hj6lHWWaGJcl/
         nFDhDQLI0Lltq/2EdH3GOUgjKeKTauO+4tUXrrSaPCsx2z1pLaZ7zaSsqS0Ixa6qO0O5
         YSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329881; x=1688921881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUb5nVm7hFEBhuv59behzuKW8dLna7emUUL4IOqj/Es=;
        b=JsuoCOdODCdYtdnw3PS0P71ny81BeYTzWnaDA6t8G1klzJpphE5hf3U31u3R0+GfD8
         9Mulr/Qier3+4p9JieShWTv3mmzQGfeGgHDeRtKtirlyHKbAaNjq6gsr/5tJoQd/ExeB
         DIYRRPrL+AohG71wmwt+TY29/1BYU198cC+/9JzOciglbHxKhuDNJxJCFIUJGeaUNUM/
         gqJ4L+bJA3IeSdQUf+FxXk7J8kN+/OmLqhc0EaCykJFyVywdjgu+2cC1RaUaDw+92q8n
         M8Om72CkFj64VH+WJ0KQRg4vDaWNvHSZQQiFGJPVg8qT6aU5WTVfG4sYW4wZzF3gI/J6
         Piag==
X-Gm-Message-State: AC+VfDy29io9MDJQDHq0gT67LsRn/8t1uJZOC5+Hf8zn20bw7Jwbmjm7
        uG9MkV7IywcYknvUN8I3ZmFv9Q==
X-Google-Smtp-Source: ACHHUZ5XREmgDhoET21rXfbNBJMsOO4k1ia54yVbEFbqrn3hb5hXibwbLwjxN3epvSvRqhrKKRNXdA==
X-Received: by 2002:a19:6550:0:b0:4f4:b218:e85f with SMTP id c16-20020a196550000000b004f4b218e85fmr1067786lfj.31.1686329881358;
        Fri, 09 Jun 2023 09:58:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x3-20020ac259c3000000b004f39bb71ed2sm601806lfn.138.2023.06.09.09.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:58:00 -0700 (PDT)
Message-ID: <f34a03ce-6295-b5d1-bf42-a43cfb382ea3@linaro.org>
Date:   Fri, 9 Jun 2023 19:58:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/5] drm/msm/dsi: Adjust pclk rate for compression
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v5-0-028c10850491@quicinc.com>
 <20230405-add-dsc-support-v5-2-028c10850491@quicinc.com>
 <js3mcglahq53mcyxa6deltjlu4xpc2pnafwz2rbk3dl4ovws2o@5xw2wzvfaj2v>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <js3mcglahq53mcyxa6deltjlu4xpc2pnafwz2rbk3dl4ovws2o@5xw2wzvfaj2v>
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

On 08/06/2023 23:36, Marijn Suijten wrote:
> Same title suggestion as earlier: s/adjust/reduce
> 
> On 2023-05-22 18:08:56, Jessica Zhang wrote:
>> Adjust the pclk rate to divide hdisplay by the compression ratio when DSC
>> is enabled.
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index a448931af804..88f370dd2ea1 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -561,7 +561,18 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
>>   	clk_disable_unprepare(msm_host->byte_clk);
>>   }
>>   
>> -static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool is_bonded_dsi)
>> +static unsigned long dsi_adjust_compressed_pclk(const struct drm_display_mode *mode,
> 
> Nit: adjust_pclk_for_compression
> 
> As discussed before we realized that this change is more-or-less a hack,
> since downstream calculates pclk quite differently - at least for
> command-mode panels.  Do you still intend to land this patch this way,
> or go the proper route by introducing the right math from the get-go?
> Or is the math at least correct for video-mode panels?

Can we please postpone the cmd-vs-video discussion? Otherwise I will 
reserve myself a right to push a patch dropping CMD mode support until 
somebody comes with a proper way to handle CMD clock calculation.


It is off-topic for the sake of DSC 1.2 support. Yes, all CMD panel 
timings are a kind of a hack and should be improved. No, we can not do 
this as a part of this series. I think everybody agrees that with the 
current way of calculating CMD panel timings, this function does some 
kind of a trick.

> 
> This function requires a documentation comment to explain that all.
> 
>> +		const struct drm_dsc_config *dsc)
>> +{
>> +	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
> 
> This sounds like a prime candidate for msm_dsc_get_bytes_per_line(), if
> bits_per_component==8 is assumed.  In fact, it then becomes identical
> to the following line in dsi_host.c which you added previously:
> 
> 	hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);

This would imply a simple /3, but as far as I understand it is not 
correct here.

> 
> If not, what is the difference between these two calculations?  Maybe
> they both need to be in a properly-named helper.
> 
>> +			dsc->bits_per_component * 3);

I hope to see a documentation patch to be posted, telling that this 
scales hdisplay and thus pclk by the factor of compressed_bpp / 
uncompressed_bpp.

This is not how it is usually done, but I would accept a separate 
documentation patch going over the calculation here and in 
dsi_timing_setup (and maybe other unobvious cases, if there is anything 
left).

> 
> As we established in the drm/msm issue [2] there is currently a
> confusion whether this /3 (and the /3 in dsi_timing_setup) come from the
> ratio between dsi_get_bpp() and dsc->bpp or something else.  Can you
> clarify that with constants and comments?
> 
> [2]: https://gitlab.freedesktop.org/drm/msm/-/issues/24
> 
>> +
>> +	return (new_hdisplay + (mode->htotal - mode->hdisplay))
>> +			* mode->vtotal * drm_mode_vrefresh(mode);
> 
> As clarified in [1] I was not necessarily suggesting to move this math
> to a separate helper, but to also use a few more properly-named
> intermediate variables to not have multi-line math and self-documenting
> code.  These lines could be split to be much more clear.

I think it's fine more or less. One pair of parenthesis is unnecessary, 
but that's mostly it. Maybe `new_htotal' variable would make some sense.

Also, please excuse me if this was discussed somewhere. This calculation 
means that only the displayed data is compressed, but porches are not 
touched. Correct?

> 
> [1]: https://lore.kernel.org/linux-arm-msm/u4x2vldkzsokfcpbkz3dtwcllbdk4ljcz6kzuaxt5frx6g76o5@uku6abewvye7/
> 
>> +}
>> +
>> +static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
>> +		const struct drm_dsc_config *dsc, bool is_bonded_dsi)
>>   {
>>   	unsigned long pclk_rate;
>>   
>> @@ -576,6 +587,10 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool
>>   	if (is_bonded_dsi)
>>   		pclk_rate /= 2;
>>   
>> +	/* If DSC is enabled, divide hdisplay by compression ratio */
>> +	if (dsc)
>> +		pclk_rate = dsi_adjust_compressed_pclk(mode, dsc);

Looking for the perfection, I'd also move the pclk adjustment to come 
before the is_bonded_dsi check.

> 
> The confusion with this comment (and the reason the aforementioned
> discussion [2] carried on so long) stems from the fact a division makes
> sense for a bit/byte clock, but not for a pixel clock: we still intend
> to send the same number of pixels, just spending less bytes on them.  So
> as you clarify the /3 above, can you also clarify that here or drop this
> comment completely when the function is correctly documented instead?
> 
> - Marijn
> 
>> +
>>   	return pclk_rate;
>>   }
>>   
>> @@ -585,7 +600,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>>   	u8 lanes = msm_host->lanes;
>>   	u32 bpp = dsi_get_bpp(msm_host->format);
>> -	unsigned long pclk_rate = dsi_get_pclk_rate(mode, is_bonded_dsi);
>> +	unsigned long pclk_rate = dsi_get_pclk_rate(mode, msm_host->dsc, is_bonded_dsi);
>>   	unsigned long pclk_bpp;
>>   
>>   	if (lanes == 0) {
>> @@ -604,7 +619,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>>   
>>   static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>   {
>> -	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi);
>> +	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi);
>>   	msm_host->byte_clk_rate = dsi_byte_clk_get_rate(&msm_host->base, is_bonded_dsi,
>>   							msm_host->mode);
>>   
>>
>> -- 
>> 2.40.1
>>

-- 
With best wishes
Dmitry

