Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE664CFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiLNSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiLNSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838A2A950
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:53:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z26so12009031lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rJMrpZYZD2A/xpXae8B0oejAWRcmuy9sfR7fFaHOBc=;
        b=QVQrCEIZvayjhKBW1SqgqlwaNf8PyYteWOCCf4E1q99+gQs2QJayeOl1370H60k3o3
         3EaCcdL3nZuLdvqUlQOx0TjWZX67iRRGNVSY5yQEQUWCT7g+53BaMSIFnv0dEhGx5LKl
         zThoZ0JdxlKAxhtU+xZTknQD4h/BeoFbejEoLtSeH5yuDhTgVie5zrtKwvUl8MwU8ngw
         6re8naZmhWWkl10KJSdxZ3UYnrp7PSm7Si0qEUch0vyDR7tD5imx2wtWB1UK/FVD4kGJ
         MXTDlCQF5xdphRE10L/a2Cdlw600HMZr+3FoI/F0aP+I3zDOWEg5BrzbeaA/kY2H8aKx
         DCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rJMrpZYZD2A/xpXae8B0oejAWRcmuy9sfR7fFaHOBc=;
        b=yhgqeGsJBGuue+oRr+iDvQzUi7ctocDisoyPqSYxKbNvCxt7+bDoGMVrDodUgkq0l1
         8WRGlDelhHMhQv8xASbdBshEwWHgHjGSa8MAgPjWjfTv+gyA5xqtbmPGTo9Ou3hyDmtX
         cn4jE8+IHMwGBm7h5DHyX+rX5qPNHyF85gpVUqIP0eyT6VJi8QG2zcmP4/LP/STOjyzT
         SM5V0ibkDqA1YvHyg/nNER3qbjTW9mn+w0qcAP7+//ySaph2cHJJz6ZMOPbeV31Gg5jH
         X03DLPLDBFPc+9qr9kXg4MhFVdfvfDeLtshbDKLpOMmeP7CHn2rSMVy0Zgt+2k3YWnnu
         ml+A==
X-Gm-Message-State: ANoB5plfMBkxQEdl55G3XLql8JirkE3617t1nJmjWDS+3eY61UGlnokS
        oAsdheG/Lp3IFQFTvzTbTLPUWA==
X-Google-Smtp-Source: AA0mqf5a2Ur10inLKK3tfDV562RQOWwl9Gjlcf6ElvbgqgUeC00yin0AqxKIn1vOT9+/BxoUPUnKjg==
X-Received: by 2002:ac2:5201:0:b0:4b5:889c:f2cf with SMTP id a1-20020ac25201000000b004b5889cf2cfmr7321525lfl.20.1671044026895;
        Wed, 14 Dec 2022 10:53:46 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512348700b004a2511b8224sm905068lfr.103.2022.12.14.10.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:53:46 -0800 (PST)
Message-ID: <7d0b3010-bcb1-657e-1d7c-a66cca7ebe8e@linaro.org>
Date:   Wed, 14 Dec 2022 20:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 5/6] drm/msm/dsi: Flip greater-than check for
 slice_count and slice_per_intf
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-6-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221213232207.113607-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 01:22, Marijn Suijten wrote:
> According to downstream /and the comment copied from it/ this comparison
> should be the other way around.  In other words, when the panel driver
> requests to use more slices per packet than what could be sent over this
> interface, it is bumped down to only use a single slice per packet (and
> strangely not the number of slices that could fit on the interface).
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

With SoB in place:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

