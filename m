Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CF6735BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjASKil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjASKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:38:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B34FAFE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:37:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b5so1449858wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bKdKCwIEVj9M4OKQvCJxtHfc8akbBWqKFuI0Hwm5VQ=;
        b=abiQ+0Ax0T69l5OzX1lCBFU9o1uoA15jyF5nqmf1NSEd8y2hpLY95Nyc5l4gU+hBka
         4U8smJsKBRjvEB9p3VlBHMSSZGyoaLP7lNk1tjL1rlBgPfz5A+sHhHmR8vxzhtGK66tf
         7G3qV60vd3adXxN6B9ADkhWwTif/4glN32jgcQHBmfXfnDHEx5eIhrHrEr8crqbheB3W
         6757bzv7i0qlKmoVthZUQPKny12E/fyqyPs5Y3rI3kkChTGN2yX0xNEqIfo2WLw3gKHB
         6zphkY5X8RPWFgLaw6FWsV2QPxMCDvcQbVFuhZZjc5VVsEUAcJ1eMWjE9X1F4h55fHWT
         TL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bKdKCwIEVj9M4OKQvCJxtHfc8akbBWqKFuI0Hwm5VQ=;
        b=jn5ITGUksGzSEwkh8A7YnO98Z2TvomCr0cu/BnI4yREoEM1TodC+W1cbZv3X87ocOQ
         GVZwU+FBco3wm4vvjL6wMOTErlphZbY+p/9MgNMOohzcCSHM2nB2lMFDej/uHIMhgiSj
         hKZv/BP8pSVhCwS1GgtNOWNugOoXeLOgf4vC9cPNHxNGEYpKz2XWRVfw4S/iT15YcuCK
         Vx+Lrz8SVBuZLAWHB65StM0pn4NkcHfjYEojqs3qIYGD7kGxCiHnXReh22B2sOatnGKB
         Fj/P01eNe2sQYpUvXz3fDECQHCE7M+fO9GyVqunjNErP+j5WTuzwTYDWTxUx/cQMqCcg
         hi9g==
X-Gm-Message-State: AFqh2krntDMB5Kp4yH2BAminjsvE58eLxfKLZTLMtt6WU8x4OO3zJFjl
        Tlq6SmH5rFmpU7XhBPpynwRYxQ==
X-Google-Smtp-Source: AMrXdXuhLwFKsOieEPkv4WnlwiLr1ZX0SsmCVM5hkKGfIQ6kvwNtlt7dCftyMakfb35HvImagi0P6w==
X-Received: by 2002:adf:ff8d:0:b0:2be:3538:76e with SMTP id j13-20020adfff8d000000b002be3538076emr4276307wrr.66.1674124677351;
        Thu, 19 Jan 2023 02:37:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003d9b89a39b2sm4394636wmj.10.2023.01.19.02.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:37:56 -0800 (PST)
Message-ID: <67170ce0-8622-8b35-e73a-7d873b7a3b8b@linaro.org>
Date:   Thu, 19 Jan 2023 11:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 01/10] drm/hdcp: Add drm_hdcp_atomic_check()
Content-Language: en-US
To:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Jani Nikula <jani.nikula@intel.com>
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-2-markyacoub@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118193015.911074-2-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 20:30, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch moves the hdcp atomic check from i915 to drm_hdcp so other
> drivers can use it. No functional changes, just cleaned up some of the
> code when moving it over.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-2-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-2-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-2-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-2-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-2-sean@poorly.run #v5

It seems all your previous versions were sent not to correct people and
lists. Therefore we see it for the first time even though it is v6! It's
not the first such weird CC list in chromium, so maybe your
organisational process could be improved? Not only for you but for
colleagues as well, so you all start using get_maintainers.pl on newest
kernel (not something ancient)?

Best regards,
Krzysztof

