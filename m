Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E2749708
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjGFIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:03:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336E124
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:03:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso3973335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688630597; x=1691222597;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qlbbFgac1/Ja02xC/p+4IB4p9VIZ8NXZch+0Qc/D5z8=;
        b=FQZQzQS4ICl8IGihWJT5Qjdh0/3GCDGCfqPSewteN2SQk7+2qZt5NiEsj/cflk604x
         9IAc1/MCGcDAIAlJRf+fkhYnRwSKy3GkiTMXoFSsPJDL4rXTOqzZcWWvKl++JHB5muqF
         JZ89G9vZLxm5d8H/6YYn//ZgcF9Rtd/ZXPlM2twsASSrX+WcZGybtz5o380opb2pFwOh
         rK2TmgSyEjvHfWKs3tZU7eH2E3nloJjSltGJnTW5fwzXM0HGTCfQ7Y5eZFERL8wG94d3
         vRCsgRop6L8t+rcAmCvA1TcEYn91jPoof4B9xdFVoLrzxiwxk+rdm/hFRYqoBl9n+oL/
         A4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630597; x=1691222597;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlbbFgac1/Ja02xC/p+4IB4p9VIZ8NXZch+0Qc/D5z8=;
        b=IERSP2iuHLlTiYVfLCQx4I+MGZ4dITXNNLFscqhaiHjJ88QUOYY42cvn5kg3AJcTCU
         WGQVQxasLW0JZzL1byqajQaLvoqzXaHrWDMiFO7SWQqeZBl0Dg2Z5CWN9mYH3I6JlVxA
         e+p31m/k8L/cZKLVanr37YI/dhcOyMMXa2txelekGcLKTkU16P4vd/ICJohPx24uSx6M
         FIIQp5+UpTclUUoV/qw8rmY9A0ecq8xDCHkUGxwBbMK9gm7oKbcD/1/KiOX+t/O5cPeG
         I5ulotZ2mK/CH+AsjZeJ47IzB/ah8fG1rogzHrG5Xv75tmEfdQqNrz7upzv1CtoXAmYS
         vDHw==
X-Gm-Message-State: ABy/qLbx+vv4rMc+wK9JGWD9NCe0F0Ybzabm61VeXsaIGEboLyUhfIN7
        B52KndHXYL2dK6XHGe/2dsosGg==
X-Google-Smtp-Source: APBJJlH3H7iv9EeKrV3bNZOSnPe7hFcBCKi00DBiYy4qv5WWAJRzgEOhhaRZPxCDwVWhUB7/AnC9UA==
X-Received: by 2002:a1c:f70a:0:b0:3fa:d167:5348 with SMTP id v10-20020a1cf70a000000b003fad1675348mr721447wmh.1.1688630597224;
        Thu, 06 Jul 2023 01:03:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c220900b003fbdbd0a7desm4303559wml.27.2023.07.06.01.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 01:03:16 -0700 (PDT)
Message-ID: <230a8df6-f057-413f-dbd0-da33403359c4@linaro.org>
Date:   Thu, 6 Jul 2023 10:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>
References: <epds77sccy4cc5cdpoc4ir7sfz5sz3biwep6rbks2nuyqncidu@77gb4t2wy6vn>
 <47a5678c-1eb3-dfc2-a9ac-f8e497455d11@linaro.org>
 <unsithzszj7awvsmxwr7reshso5ju7u4nssil5tty6pocictf5@gwoltpgeecer>
 <6e070141-8c0e-59ed-8a08-58c3fadb17df@linaro.org>
 <lidknise4copce3vb2wth4z3fl2p4npsc4u6ajqb6zsp6lnpca@rp6wxcmy2aa4>
 <CAA8EJpq_VeY=44FqYm7QAT32AR=rmMOV0RtAfNFkb1hpSp29dw@mail.gmail.com>
 <djrx34qwb7yen47dmlsym4mg2pib4syncvdy52ma3sin7uhs7j@gi3znayuucnj>
 <a718f7c1-4ef1-18c8-33c7-c5da22e92c89@linaro.org>
 <q7wrbmdhdy2d3gqig3j34lqxdcwzbom7djlncfznxsa6ktm7j2@i5x4ngi7p2ia>
 <9e071beb-9d9d-c6dc-8196-a3e23ea73713@linaro.org>
 <nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 09:59, Maxime Ripard wrote:
> On Thu, Jul 06, 2023 at 09:33:15AM +0200, Neil Armstrong wrote:
>> On 06/07/2023 09:24, Maxime Ripard wrote:
>>> On Wed, Jul 05, 2023 at 11:09:40PM +0300, Dmitry Baryshkov wrote:
>>>> On 05/07/2023 19:53, Maxime Ripard wrote:
>>>>> On Wed, Jul 05, 2023 at 06:20:13PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Wed, 5 Jul 2023 at 17:24, Maxime Ripard <mripard@kernel.org> wrote:
>>>>>>>
>>>>>>> On Wed, Jul 05, 2023 at 04:37:57PM +0300, Dmitry Baryshkov wrote:
>>>>>>>>>>>
>>>>>>>>>>> Either way, I'm not really sure it's a good idea to multiply the
>>>>>>>>>>> capabilities flags of the DSI host, and we should just stick to the
>>>>>>>>>>> spec. If the spec says that we have to support DSC while video is
>>>>>>>>>>> output, then that's what the panels should expect.
>>>>>>>>>>
>>>>>>>>>> Except some panels supports DSC & non-DSC, Video and Command mode, and
>>>>>>>>>> all that is runtime configurable. How do you handle that ?
>>>>>>>>>
>>>>>>>>> In this case, most of the constraints are going to be on the encoder
>>>>>>>>> still so it should be the one driving it. The panel will only care about
>>>>>>>>> which mode has been selected, but it shouldn't be the one driving it,
>>>>>>>>> and thus we still don't really need to expose the host capabilities.
>>>>>>>>
>>>>>>>> This is an interesting perspective. This means that we can and actually have
>>>>>>>> to extend the drm_display_mode with the DSI data and compression
>>>>>>>> information.
>>>>>>>
>>>>>>> I wouldn't extend drm_display_mode, but extending one of the state
>>>>>>> structures definitely.
>>>>>>>
>>>>>>> We already have some extra variables in drm_connector_state for HDMI,
>>>>>>> I don't think it would be a big deal to add a few for MIPI-DSI.
>>>>>>>
>>>>>>> We also floated the idea for a while to create bus-specific states, with
>>>>>>> helpers to match. Maybe it would be a good occasion to start doing it?
>>>>>>>
>>>>>>>> For example, the panel that supports all four types for the 1080p should
>>>>>>>> export several modes:
>>>>>>>>
>>>>>>>> 1920x1080-command
>>>>>>>> 1920x1080-command-DSC
>>>>>>>> 1920x1080-video
>>>>>>>> 1920x1080-video-DSC
>>>>>>>>
>>>>>>>> where video/command and DSC are some kinds of flags and/or information in
>>>>>>>> the drm_display_mode? Ideally DSC also has several sub-flags, which denote
>>>>>>>> what kind of configuration is supported by the DSC sink (e.g. bpp, yuv,
>>>>>>>> etc).
>>>>>>>
>>>>>>> So we have two things to do, right? We need to expose what the panel can
>>>>>>> take (ie, EDID for HDMI), and then we need to tell it what we picked
>>>>>>> (infoframes).
>>>>>>>
>>>>>>> We already express the former in mipi_dsi_device, so we could extend the
>>>>>>> flags stored there.
>>>>>>>
>>>>>>> And then, we need to tie what the DSI host chose to a given atomic state
>>>>>>> so the panel knows what was picked and how it should set everything up.
>>>>>>
>>>>>> This is definitely something we need. Marijn has been stuck with the
>>>>>> panels that support different models ([1]).
>>>>>>
>>>>>> Would you prefer a separate API for this kind of information or
>>>>>> abusing atomic_enable() is fine from your point of view?
>>>>>>
>>>>>> My vote would be for going with existing operations, with the slight
>>>>>> fear of ending up with another DSI-specific hack (like
>>>>>> pre_enable_prev_first).
>>>>>
>>>>> I don't think we can get away without getting access to the atomic_state
>>>>> from the panel at least.
>>>>>
>>>>> Choosing one setup over another is likely going to depend on the mode,
>>>>> and that's only available in the state.
>>>>>
>>>>> We don't have to go the whole way though and create the sub-classes of
>>>>> drm_connector_state, but I think we should at least provide it to the
>>>>> panel.
>>>>>
>>>>> What do you think of creating a new set of atomic_* callbacks for
>>>>> panels, call that new set of functions from msm and start from there?
>>>>
>>>> We are (somewhat) bound by the panel_bridge, but yeah, it seems possible.
>>>
>>> Bridges have access to the atomic state already, so it's another place
>>> to plumb this through but I guess it would still be doable?
>>
>> It's definitely doable, but I fear we won't be able to test most of the
>> panel drivers, should we introduce a new atomic set of panel callbacks ?
> 
> That was my original intent yeah :)
> 
> Creating an atomic_enable/disable/ etc. and then switch
> drm_panel_enable() to take the state (and fixing up all the callers), or
> create a drm_panel_enable_atomic() function.
> 
> The latter is probably simpler, something like:
> 
> int drm_panel_enable_atomic(struct drm_panel *panel,
>      			    struct drm_atomic_state *state)
> {
> 	struct drm_panel_funcs *funcs = panel->funcs;
> 
> 	if (funcs->atomic_enable)
> 		return funcs->atomic_enable(panel, state);
> 
> 	return funcs->enable(panel);
> }
> 
> And we should probably mention that it supersedes/deprecates
> drm_panel_enable.
> 
> We've switched most of the other atomic hooks to take the full
> drm_atomic_state so I'd prefer to use it. However, for it to be somewhat
> useful we'd need to have access to the connector assigned to that panel.
> 
> drm_panel doesn't store the drm_connector it's connected to at all, and
> of_drm_find_panel() doesn't take it as an argument so we can't fill it
> when we retrieve it either.
> 
> So I guess we can go for:
> 
>   - Create a new set of atomic hooks
> 
>   - Create a new set of functions to call those hooks, that we would
>     document as deprecating the former functions. Those functions would
>     take a pointer to the drm_connector_state of the drm_connector it's
>     connected to.
> 
>   - We add a TODO item to add a pointer to the connector in drm_panel
> 
>   - We add a TODO item that depend on the first one to switch the new
>     functions and hooks to drm_atomic_state
> 
>   - We add a TODO item to convert callers of drm_panel_enable et al. to
>     our new functions.
> 
> It should work in all setups, paves a nice way forward and documents the
> trade-offs we had to take and eventually address. And without creating a
> dependency on 30+ patches series.
> 
> Does it sound like a plan?

Yep that looks a fine plan to start of

> 
>> Or shall be simply move the "new" panel driver supporting atomic to bridge
>> and only use panel_bridge for basic panels ?
> 
> I don't think we can expect panel_bridge to be used all the time any
> time soon, so I'd rather avoid to rely on it.

Ack

> 
> Maxime

