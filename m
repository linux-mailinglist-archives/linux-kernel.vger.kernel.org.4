Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B590970FB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjEXQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEXQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:12:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0DBF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:11:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso753311f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684944718; x=1687536718;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k72tOLHNx9m56BXts73JUfuZbFrbujBUrTnehtgDexQ=;
        b=EtUy1cT338QhJ12TcFnp4j/CEuWv4Yt8jNNXowheZkIKoGi9WlZzNh0xDPDTWoMoZF
         AXBqX7soBwzGywtMChbffgU6DKKeKQCq+EBqimBte3QJLQV8wawUdTFpAB4rAVPJxYGM
         IIvm3K3uaJjas73TUnERcMICPokNky1JbBvie2mjaTh6TtIC2qeR9Fohgh1563uI84ff
         CQo1kKdnhAuyAHong+zSvjmeNs/mtplC7GQlK36bX/Ffi1mEdl22qrqH2wVGGC/N8fut
         Si0wa9LslXA//MwsEhc2/0vfkOxC47LHpN4S8MReA6rN+WtPTta11s/kPgqTjHQiBAuC
         DXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944718; x=1687536718;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k72tOLHNx9m56BXts73JUfuZbFrbujBUrTnehtgDexQ=;
        b=ZibKrk16D7XWyHahHjcT3BeJpxkCSHLyYftri0PYTnz2RB25CtDM6tO3gjogUOxviS
         RxdX7p+TNED5HuoACgH2ymeBY4KbwXsbo0xcFIMltm/11Hr90XYsVYVUghxV3644fQIQ
         j7MeGbGnJGD9YJ9IO3KiX/bhDoZnjSTt9liPUU1g1vulgXuIPGgwmtpezpdL1/V3Zfyf
         u+Lb8bPCqG7BkcB2R3Koa0t7RuW3ljqj65JmN+yZGAk6Y0OjoQhQxAf4bAXwLevoTTDA
         gf/5meAhLIUyoF4o+W6d/ikstnhNaH/+IXuDgvpK34UP6/DPbcR9UmgsCoK3eXEFfs7J
         ZDEQ==
X-Gm-Message-State: AC+VfDwpHIjt7pIOpJLO8a0XBVQoWnNUb85k+gp/mMHA+TvY4cJ97joq
        mqz9L1aW0jBENenk3PpAOw/USA==
X-Google-Smtp-Source: ACHHUZ7yzSRYJcrJoJX1pJvtfP6AqsaU7Xxlwr8toSEa+a55GzhttWpC2GloIzGWvYf5g3l7Wu+/rg==
X-Received: by 2002:a5d:604f:0:b0:309:e24:57aa with SMTP id j15-20020a5d604f000000b003090e2457aamr209929wrt.19.1684944718139;
        Wed, 24 May 2023 09:11:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:39c7:394c:5a3:4047? ([2a01:e0a:982:cbb0:39c7:394c:5a3:4047])
        by smtp.gmail.com with ESMTPSA id c14-20020a056000104e00b00307b5376b2csm14807613wrx.90.2023.05.24.09.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 09:11:57 -0700 (PDT)
Message-ID: <9a489856-436f-0c7b-9bfc-2336d26ad403@linaro.org>
Date:   Wed, 24 May 2023 18:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: (subset) [PATCH v4 0/9] drm: fdinfo memory stats
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lijo Lazar <lijo.lazar@amd.com>, linux-arm-msm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        Peter Maucher <bellosilicio@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
 <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
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

On 24/05/2023 18:10, Neil Armstrong wrote:
> Hi,
> 
> On Mon, 15 May 2023 07:30:07 -0700, Rob Clark wrote:
>> Similar motivation to other similar recent attempt[1].  But with an
>> attempt to have some shared code for this.  As well as documentation.
>>
>> It is probably a bit UMA-centric, I guess devices with VRAM might want
>> some placement stats as well.  But this seems like a reasonable start.
>>
>> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
>> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
>>
>> [...]
> 
> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
> 
> [1/9] drm/docs: Fix usage stats typos
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0020582a8afe9a8570f80ec503c59bf049a616de
> [2/9] drm: Add common fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3f09a0cd4ea3b9d34495450d686227d48e7ec648
> [3/9] drm/msm: Switch to fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51d86ee5e07ccef85af04ee9850b0baa107999b6
> [4/9] drm/amdgpu: Switch to fdinfo helper
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=376c25f8ca47084c4f0aff0f14684780756ccef4
> [5/9] drm: Add fdinfo memory stats
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=686b21b5f6ca2f8a716f9a4ade07246dbfb2713e
> [6/9] drm/msm: Add memory stats to fdinfo
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e9757f5ddb98238226ad68a1609aa313de35adb
> [7/9] drm/doc: Relax fdinfo string constraints
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=90d63a150b85fd1debb9c01237fb78faee02746a
> 

Hmm no idea what happened, but I really applied v5 !

Neil
