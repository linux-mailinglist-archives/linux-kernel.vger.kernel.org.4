Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5808E6758A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjATPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjATPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:32:54 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD2BCE22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:32:49 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4fd37a1551cso52591097b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IPtDJM5M6jGN6qD0tP24K72UIm4iRXYGKWNFo7x72g=;
        b=SPoq6nBK/JeShjz0kPsSHbBdOJtV/AmVLorEPqTuGDzC70Ow5DX8doU0rsRDKCcTD1
         Jltcq/okn/fjqBisJ9sE69yh3amFyHgGDIqt3YyHdPR0N6qepAWxsS2OMETpUksYGV1S
         kwvgHr7iyU+Zf8HqHBuJwD0xp+BnLHmYnP0u3hdglzpy03kUEls0HWOct6IEtaAqANmb
         Q+V1t217x323JxoCLe6IfUbqtk4A/Ytth5Y1OutLyazCII9UdOCnZNL5iFxHvuAhrIPK
         3bwvEBE3iFXfMvlRByIuUpVcNW3pdXTUVnZ8yCJLWxGQb/RIggDxCRemoyzqpl81n21X
         kMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IPtDJM5M6jGN6qD0tP24K72UIm4iRXYGKWNFo7x72g=;
        b=SMDH/Q2hZ3+62CMuidj1D1gtdqZnlk4qVdWwofgQu+yHgbycW94qycmUo4wKxY81HC
         5ruSWAHWyTisCZpcl6bhoQSeqNCRVs0pZ+J2MvP0g0SttDvMSzekuQ341Y8HSPi0N/1x
         m0JSIE7ArKhjUXjK6pOakaL1OlSTYxdhuxSVZ/YAY0eRXUZ0C0rAGqpJ03UeBwqR0vvX
         yx7ONWaXSynkPGZO/c8d8jXheatko4b7Ie+9AMwvotEhdWBZiQj0qNHbPF463xxNwLeO
         6kSVgqa3/4tBq737V1iApp37Mz45oi+Rxavjk7M9Bqs3/eAbUNLLAsTkJFle00ghRYkk
         +AvQ==
X-Gm-Message-State: AFqh2kqHOS22uEC3D44EYFdSTx1cIA30Fwx/PrDJWMajnsp2KZfK+fZL
        uzakmAqhd6yAxeO4dIvnLpa73w==
X-Google-Smtp-Source: AMrXdXtru88v2k61i9cQGS6ax35vAmCsXdW2DZPSz/qrSHebfuajOctI7UdN7zUMawsmB7qZX4N0+w==
X-Received: by 2002:a0d:d610:0:b0:3af:2118:fc34 with SMTP id y16-20020a0dd610000000b003af2118fc34mr11723672ywd.34.1674228768750;
        Fri, 20 Jan 2023 07:32:48 -0800 (PST)
Received: from localhost (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006fed58fc1a3sm26448188qkp.119.2023.01.20.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:32:47 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:32:47 +0000
From:   Sean Paul <sean@poorly.run>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
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
Subject: Re: [PATCH v6 01/10] drm/hdcp: Add drm_hdcp_atomic_check()
Message-ID: <Y8q0H7SiDkdfmyXP@art_vandelay>
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-2-markyacoub@google.com>
 <67170ce0-8622-8b35-e73a-7d873b7a3b8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67170ce0-8622-8b35-e73a-7d873b7a3b8b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:37:52AM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2023 20:30, Mark Yacoub wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > This patch moves the hdcp atomic check from i915 to drm_hdcp so other
> > drivers can use it. No functional changes, just cleaned up some of the
> > code when moving it over.
> > 
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-2-sean@poorly.run #v1
> > Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-2-sean@poorly.run #v2
> > Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-2-sean@poorly.run #v3
> > Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-2-sean@poorly.run #v4
> > Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-2-sean@poorly.run #v5
> 
> It seems all your previous versions were sent not to correct people and
> lists. Therefore we see it for the first time even though it is v6! 

Hi Krzysztof,
Thanks for your review comments.

Here are the addresses the last version was sent to, who is missing?

To: dri-devel@lists.freedesktop.org, 
    jani.nikula@intel.com,
    intel-gfx@lists.freedesktop.org,
    freedreno@lists.freedesktop.org,
    rodrigo.vivi@intel.com
Cc: bjorn.andersson@linaro.org, 
    swboyd@chromium.org,
    abhinavk@codeaurora.org,
    markyacoub@chromium.org,
    Sean Paul <seanpaul@chromium.org>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Maxime Ripard <mripard@kernel.org>,
    Thomas Zimmermann <tzimmermann@suse.de>,
    David Airlie <airlied@linux.ie>,
    Daniel Vetter <daniel@ffwll.ch>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
    Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>

> It's
> not the first such weird CC list in chromium, so maybe your
> organisational process could be improved? Not only for you but for
> colleagues as well, so you all start using get_maintainers.pl on newest
> kernel (not something ancient)?

I can't really speak for others, but I use MAINTAINERS from drm-tip. The 
previous patch sets were sent before 24df12013853 ("MAINTAINERS: Add 
Dmitry as MSM DRM driver co-maintainer"), which might explain why you think
there are absences?

Thanks again,

Sean

> 
> Best regards,
> Krzysztof
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
