Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163B663513
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjAIXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbjAIXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFF186B7;
        Mon,  9 Jan 2023 15:16:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so15552719lfb.1;
        Mon, 09 Jan 2023 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/mDgzPnUXxALwSc77P9Iyw1b4SZpp1LqX9N2wGlWLw=;
        b=B9m4CHmihRuEgTAs5tZdrZAp2YkSVYMp9hhXtVqPSGsJZsNcLaeAboG9f4nTdukK9p
         Y1ZjFYzcPThHQHD8b1mtOqNz8k5ByfxT+HHPYTAStlbClZOKfq+bzW6jutvTNMXef70u
         VBuA9bshNVdHboSaacxRpJjkCNMxooU9ncuKkRMAR9zaOq5iAAWRhZBgZaI3UjxfQUfT
         T/JwXSJrFJXGGuYmeTCQObWPapGgN3ChggBX1xVvb0CpEFK0AQ0AT+wWL8EDpYKu5M4v
         0QwuOwPg9Ioc0TEgjCxbhG1PSPv9DrFneXReAYGzJaqG1pZlP6w2ZpOFKwHh6Q5fUgjK
         9vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/mDgzPnUXxALwSc77P9Iyw1b4SZpp1LqX9N2wGlWLw=;
        b=6BcGv8Zvk+3nW4sNZYZICvGvmDUXUmioZKoIiyqOqlWqxEbHqdGXBtYz5bLwFX+R12
         XLoFFJV6CXhk//W9fSmXNprHFHr1VdMRW/fjuD+6kmLc4yNXgBkCN4AZvoijYiE8CVan
         eONtaeurgfldSi2m/NvCbMdXBGYFhi44KRUSZxiWDUv3VdHABWk+XOEFc66DTbA+9/R9
         08LeRG3p3j622y8gnhbu6cX/BAfK3anNEoNzr4YHXbRDM37WoStrse4fM+/2Xpck+lMH
         dljwGfDHEZB9TTJ5IqAKL5Ylsr5Rdj0DrvERqUj98JoRpLlc5bGdVHQ7lUc4HCzkeSEt
         Wi7w==
X-Gm-Message-State: AFqh2korFBSQ1+s0IOXv+BjLIGynlUAjptI7SXNOsdfnCjSo8YAY2qCS
        LG04moSUsqIFx/MBPH38ibs=
X-Google-Smtp-Source: AMrXdXtPzJ3f1pblhBDPvSsW8oOxmBG4ZNuXw1pydRuDZV67dLZ7d4g4JIcTmwwjCI8J3zIceTrK1g==
X-Received: by 2002:a05:6512:c14:b0:4b5:abe3:c63d with SMTP id z20-20020a0565120c1400b004b5abe3c63dmr22375060lfu.42.1673306186813;
        Mon, 09 Jan 2023 15:16:26 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w20-20020a05651234d400b004cb8de497ffsm1836363lfr.154.2023.01.09.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:25 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
In-Reply-To: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
References: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
Subject: Re: [PATCH v4 0/3] add color management support for the crtc
Message-Id: <167330408778.609993.9217470869804308069.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2022 01:08:12 -0800, Kalyan Thota wrote:
> Add color management support for the crtc provided there are
> enough dspps that can be allocated from the catalog
> 
> Kalyan Thota (3):
>   drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
>   drm/msm/disp/dpu1: add helper to know if display is builtin
>   drm/msm/disp/dpu1: add color management support for the crtc
> 
> [...]

Applied, thanks!

[1/3] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a4d6f8253645
[2/3] drm/msm/disp/dpu1: add helper to know if display is builtin
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4cb6b1eebb92
[3/3] drm/msm/disp/dpu1: add color management support for the crtc
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c48c475bd75a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
