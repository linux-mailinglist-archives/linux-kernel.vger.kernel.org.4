Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721369B521
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBQVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:53:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38948E25
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:53:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g16so3376546lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrYTA9ehfsvjQ2qG5X1k0zYCEbq+LYYxzJxLjm69hqo=;
        b=QOYBkUXHs2WGR2RY9Cl7thRfNc7rrF6Ki0EE4FKplBKuWQ3y9zQiUR/SP1/8768+Md
         m7px3SfKFTU+A4FgIpUNECBrtYZv8FeScl+A32VAkUgdA+nd1KqFI2ry1MAAPtlltxgd
         knzyDJqLNL3HubGVKEHzTlJnX4nBiDt2Adk2fFW8loBYRf3uM8q+YHHMwRR3misgi8SR
         Fc+KpgG6056leD9Vj/q/FAtnsIKKBbZfhJbVgXhoXkykeCg3omZNYEbg9hsotJ3ZC6fI
         aMeIMtVYq0VPiXQIpUlC0akEU/cfE6vXCSKB0plmgn199AS70Hq/qBNGozUCOC/9JRqW
         J3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrYTA9ehfsvjQ2qG5X1k0zYCEbq+LYYxzJxLjm69hqo=;
        b=XWlLurvZQpqzoTXBiHXKPwv9ONZZYn8VICuv8GrwQiFPpCCUdTwP0WnHlRdhahZqxf
         1ty3Xwe3U3uS14HribySok1ua2JyrfOOC9W9mld78bV7m6o6KieginGIt3MNX++Zx+dy
         sGRdvsdfeWJxkDEpyxdejM2YwEnyVsdMirXcaFVZbE2qp4H9z5awgL0gXa3up8efZkOw
         BCK6Jori8SzXNi8ZZuFRq2oNhR40dowlB99SzEa1ogjfsZA5P2w8IOhRjDBjUxrLx8aq
         VdUd9F+y4M4xMYTThQsd2HYV99ycMXviTeuU21jK4qOEjuLW8++JPiW3izxqJTX6MCSE
         OjdQ==
X-Gm-Message-State: AO0yUKVBOVWaUhlZnXz9YdFJhp0yTMMcNKJ5eNFps8Z48jEtl9zi3AdZ
        KSjDmmF7QzRDFnrvq5DYMhKucQ==
X-Google-Smtp-Source: AK7set/lwfUg5aQxQh5XTDxnNOktYivNX1xwI+g+h8QmaqrpaHYpf2rRQUZ8wDRxH7BzUCeYprXFPg==
X-Received: by 2002:ac2:4c8f:0:b0:4d7:2187:e1c8 with SMTP id d15-20020ac24c8f000000b004d72187e1c8mr499038lfl.44.1676670788426;
        Fri, 17 Feb 2023 13:53:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t1-20020ac25481000000b004d16263b36bsm786961lfk.111.2023.02.17.13.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:53:08 -0800 (PST)
Message-ID: <7ff320ef-22dc-a3fc-764e-bfc50079dfdb@linaro.org>
Date:   Fri, 17 Feb 2023 23:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v13 13/13] drm/msm/disp/dpu: update dpu_enc crtc state on
 crtc enable/disable during self refresh
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
References: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
 <1676219337-6526-14-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1676219337-6526-14-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 18:28, Vinod Polimera wrote:
> Populate the enocder software structure to reflect the updated
> crtc appropriately during crtc enable/disable for a new commit
> while taking care of the self refresh transitions when crtc
> disable is triggered from the drm self refresh library.
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

