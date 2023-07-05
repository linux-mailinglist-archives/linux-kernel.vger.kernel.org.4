Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89B7488BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjGEP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjGEP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:59:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948FF1BC9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:59:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3143b70d6easo3126533f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688572731; x=1691164731;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=moibl62gzAsWVTokluvPSFK/S0tyJbu/881cJb+p80o=;
        b=JSlq8CZYrL0RmBsVMhuobUhV95XMGPxVfjGNavCOWyxUgSDHCaJB4aAXpc5KoUvq40
         fykvC+WCiFXbWE5Z/OEaXbgEQO5+99cEZcZ439cMGWzd0tn/RtXvHe13K1KHd1M/7kxS
         agXTzzdaz8SDtGYRZtw+KzPgomGI6nfejQqRPgLR657DflSyEmtY9+UcMcetjEbXGOj0
         S3SDFqvZOjtSHTaVjrTDKmXS6TOaWRSwrdb5HqsIN2TlRZEbKVeQIt9vc2/DgiklaPyx
         XRzTGp9k6pT2BuWv6adsmAYFJtP1xt8B4r+oL5KMEzcv/dB7IqzPrpdKmwZ961oHLbSQ
         iZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572731; x=1691164731;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moibl62gzAsWVTokluvPSFK/S0tyJbu/881cJb+p80o=;
        b=fiq7CMi5K+EA+YfIYyMFh1zV6CcoGwLo8vH/pGtO+IUkXf+9qM1/QPWOHLev+E1VkW
         98ijqqCdlAcs2ixlaYtDzV6yckJGlEK9+nFAVwfzosBObmgrrxzjQhI3rNysAkFBwxmk
         c5rBWukC16nSVzowX7B0vamRLDPVwTH9PKVtEbJTY/sXZn64L6KrZ3TI4WCtagJNaNAS
         9VhyKw5XsGb8FHG1fm06IuvvrYv4gRp1cTynD8qPwfZFgMUtQQ6WPLXXumCbpKvDbCF4
         Aqtt3CV9MMPGiR0Q2V9sYKYot3fozNYoSX1JcRFpLwY2EdwAm1Dou6/QDjQj7XsG1xnx
         CUVQ==
X-Gm-Message-State: ABy/qLZb5ML03M7O2pMlMPrmnd6D8n/OZ1lRBzVtlOPkoiZHMneF4lAI
        zPhT2kCs1qZHNLq6DaJrEBaDlg==
X-Google-Smtp-Source: APBJJlGx+kWWfQ+ERifBEWKHxqWBwGmPAO4EZnQin0ptwlMz0lU3sRP6zkQMsbyuoLdBaBGZMnrUZQ==
X-Received: by 2002:a5d:4f8d:0:b0:314:11ea:480d with SMTP id d13-20020a5d4f8d000000b0031411ea480dmr14762913wru.9.1688572731063;
        Wed, 05 Jul 2023 08:58:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:65eb:d140:2d45:ee85? ([2a01:e0a:982:cbb0:65eb:d140:2d45:ee85])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm27119522wrw.117.2023.07.05.08.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:58:49 -0700 (PDT)
Message-ID: <bd6b9372-6eb0-c54f-9341-1dc46c4e63b0@linaro.org>
Date:   Wed, 5 Jul 2023 17:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: RFC: DSI host capabilities (was: [PATCH RFC 03/10] drm/panel: Add
 LGD panel driver for Sony Xperia XZ3)
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     AngeloGioacchino Del Regno 
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
References: <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
 <CAA8EJppG=MAVpK1J_8bNnkJ23y9NtgY7a2GVResXJvhEKyNsrw@mail.gmail.com>
 <739a8bd9-9ff0-5072-fdae-b64efdf86842@collabora.com>
 <e927cfcd-bf34-5daf-0e24-4dd828106968@linaro.org>
 <epds77sccy4cc5cdpoc4ir7sfz5sz3biwep6rbks2nuyqncidu@77gb4t2wy6vn>
 <47a5678c-1eb3-dfc2-a9ac-f8e497455d11@linaro.org>
 <unsithzszj7awvsmxwr7reshso5ju7u4nssil5tty6pocictf5@gwoltpgeecer>
 <6e070141-8c0e-59ed-8a08-58c3fadb17df@linaro.org>
 <lidknise4copce3vb2wth4z3fl2p4npsc4u6ajqb6zsp6lnpca@rp6wxcmy2aa4>
Organization: Linaro Developer Services
In-Reply-To: <lidknise4copce3vb2wth4z3fl2p4npsc4u6ajqb6zsp6lnpca@rp6wxcmy2aa4>
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

On 05/07/2023 16:24, Maxime Ripard wrote:
> On Wed, Jul 05, 2023 at 04:37:57PM +0300, Dmitry Baryshkov wrote:
>>>>>
>>>>> Either way, I'm not really sure it's a good idea to multiply the
>>>>> capabilities flags of the DSI host, and we should just stick to the
>>>>> spec. If the spec says that we have to support DSC while video is
>>>>> output, then that's what the panels should expect.
>>>>
>>>> Except some panels supports DSC & non-DSC, Video and Command mode, and
>>>> all that is runtime configurable. How do you handle that ?
>>>
>>> In this case, most of the constraints are going to be on the encoder
>>> still so it should be the one driving it. The panel will only care about
>>> which mode has been selected, but it shouldn't be the one driving it,
>>> and thus we still don't really need to expose the host capabilities.
>>
>> This is an interesting perspective. This means that we can and actually have
>> to extend the drm_display_mode with the DSI data and compression
>> information.
> 
> I wouldn't extend drm_display_mode, but extending one of the state
> structures definitely.
> 
> We already have some extra variables in drm_connector_state for HDMI,
> I don't think it would be a big deal to add a few for MIPI-DSI.
> 
> We also floated the idea for a while to create bus-specific states, with
> helpers to match. Maybe it would be a good occasion to start doing it?
> 
>> For example, the panel that supports all four types for the 1080p should
>> export several modes:
>>
>> 1920x1080-command
>> 1920x1080-command-DSC
>> 1920x1080-video
>> 1920x1080-video-DSC
>>
>> where video/command and DSC are some kinds of flags and/or information in
>> the drm_display_mode? Ideally DSC also has several sub-flags, which denote
>> what kind of configuration is supported by the DSC sink (e.g. bpp, yuv,
>> etc).
> 
> So we have two things to do, right? We need to expose what the panel can
> take (ie, EDID for HDMI), and then we need to tell it what we picked
> (infoframes).
> 
> We already express the former in mipi_dsi_device, so we could extend the
> flags stored there.
> 
> And then, we need to tie what the DSI host chose to a given atomic state
> so the panel knows what was picked and how it should set everything up.

Yep this looks like a good plan

Neil

> 
>> Another option would be to get this handled via the bus format negotiation,
>> but that sounds like worse idea to me.
> 
> Yeah, I'm not really fond of the format negociation stuff either.
> 
> Maxime

