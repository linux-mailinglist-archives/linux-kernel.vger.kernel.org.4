Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1730D5F5B77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJEVLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJEVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:11:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45540220FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:11:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t16so92703ljh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LTqZVtGTo4LnOvaWLfy6AvLCxwm8iledHO3/h6h8ZG4=;
        b=vYbuqqJ8hieu4+MpYmk+2m0P5EjfWLCq6SKr9qQm5P3Ba7pmCS4lwB0cIXEu6b8/P+
         oNhBDCWK0qubtWQeeaEKIdT3OH3Zsik6IZ+M6bu/jxkIpcWUZPxZtthSq2sTVGXVGbyc
         UBWdeFtV0N2dR3hwOWUEp5ubNs0FTVXNLqu1QeC2rKCnm8doXRP0IYAmWvxDaH2u40Ut
         YpsyMnIXzitmmMOfO14g+m2NcX0rTG0FZ8IlGtYPukPSFceFVkYEOkPUFuHOrD3LRs0z
         D/L/V/MOAv3Vd1+HZ0na0QTG+H/OrxdOTDq24Oqlz0tTfGj9I0yuYWU/TNA75Hz1PAyO
         /mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LTqZVtGTo4LnOvaWLfy6AvLCxwm8iledHO3/h6h8ZG4=;
        b=ETgCAP975opppvCzDZ91DR55gMJzgiz5lDzlLDmD5643ZTP3TBkvFedKCnjxdGMtfW
         zM6NgTM9424RGBCW8fRU2nZwk+Abfn+WQn9T3GLH2jaKy9LVk9nEp1OXiIxbrS5B+t0L
         mtJ3hd8gK3Zo00rcD1nxVoYA2Ru6o3KqEhCI7Lq0zYex3/QHqC8nCUCWK/2CpG98/Rjx
         H8JLeQcm/zHDTiEokCdxIe6KwOge6Tr/hvwdvgBhTVDS+cJtEuWYqkzijGSHl/o91Fg6
         9si35wcgmtFuqwHl+CPj87bcLQzTMyuqQ4MS8ZD0ntQmKr4Pd2Jfbb/8TxkqGnOxc6YM
         jl7Q==
X-Gm-Message-State: ACrzQf0GMGdlLr2raVyPd643YFtjio8wm24g526gkNBajfXPQ/vm0eDk
        H5/r2m7EPo3iANl115ppeArRLA==
X-Google-Smtp-Source: AMsMyM6mOxWgJmjfeqUJWO09AxgXEEuf6jq3lkAHauJp9T5jJNPh0Rh36vCwi7uAI7Miji8Yt2V5pg==
X-Received: by 2002:a2e:a602:0:b0:264:5132:f59 with SMTP id v2-20020a2ea602000000b0026451320f59mr575673ljp.0.1665004267588;
        Wed, 05 Oct 2022 14:11:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512115000b0049ad2619becsm2454720lfg.131.2022.10.05.14.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:11:07 -0700 (PDT)
Message-ID: <bdef4aec-f9b1-48d9-874a-2511a0f213de@linaro.org>
Date:   Thu, 6 Oct 2022 00:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 5/7] drm/msm/dsi: Account for DSC's bits_per_pixel
 having 4 fractional bits
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
References: <20221005181657.784375-1-marijn.suijten@somainline.org>
 <20221005181657.784375-6-marijn.suijten@somainline.org>
 <CAA8EJpr=0w0KReqNW2jP8DzvXLgo_o6bKmwMOed2sXb6d8HKhg@mail.gmail.com>
 <20221005205845.rwkzyit4daizi3z4@SoMainline.org>
 <20221005210845.yednmbqec4bzukxm@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221005210845.yednmbqec4bzukxm@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 00:08, Marijn Suijten wrote:
> On 2022-10-05 22:58:48, Marijn Suijten wrote:
>> On 2022-10-05 22:31:43, Dmitry Baryshkov wrote:
>>> [..]
>>> In fact, could you please take a look if we can switch to using this
>>> function and drop our code?
>>
>> [..]
>>
>> Do you want me to do this in a v3, before applying this fractional-bits
>> fix?  [..]
> 
> One thing to note:
> 
> 	/* bpc 8 */
> 	dsc->flatness_min_qp = 3;
> 	dsc->flatness_max_qp = 12;
> 	dsc->rc_quant_incr_limit0 = 11;
> 	dsc->rc_quant_incr_limit1 = 11;
> 	dsc->mux_word_size = DSC_MUX_WORD_SIZE_8_10_BPC;
> 
> Here a bunch of properties are hardcoded, seemingly for bpc = 8.
> mux_word_size is only ever read in drm_dsc_compute_rc_parameters() so
> only becomes relevant _after_ the migration, and is currently dealt with
> correctly by:
> 
> 	mux_words_size = 48;		/* bpc == 8/10 */
> 	if (dsc->bits_per_component == 12)
> 		mux_words_size = 64;
> 
> Aside fixing that to assign these values (through the proper constants)
> to dsc->mux_word_size, is it worth looking for the right parameters for
> other bpc or return -EINVAL if bpc isn't 8, to uphold this comment until
> support for other bpc is validated?

I'd say, return -EINVAL or -EOPNOTSUPP for now, let's fix that later. 
It's definitely a separate change. Let's wait for a device with such 
panel to be able to test it.

-- 
With best wishes
Dmitry

