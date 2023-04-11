Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0066DE772
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDKWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDKWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:46:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E16210C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:46:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i26so12709178lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681253191; x=1683845191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPQslJNp3mv+NTxxi/+JnTD498FdxuUbK0Kjk/H6R1I=;
        b=ggwD1spgRfSGAzjqndMC7HbihkTAUzlWxIjDzG6NkKFqkHQkYkyO0TpXjZeFfW2O6+
         /gcLGechUXVtX1LUVbb/frBKi02YybN4Df7ZFUB3bm8CBNaLEVj0iW9IxMLHHQo/2nZe
         HjNYu4Rtyc3cqVSm8uqfpHQQJjmw/V+rRvbyEdZk+QL6ZsXIfvu6gENpF5qJ4TVO9gV6
         PYz8/wSz8+mo/869D3krUBOE6YTGwTV//V5vP//UxVEi4hoIEeTpXJAfmZRmaR33Ck4V
         EalwevHbrmXjn77SJsC1nryjBZu7pEVsxvJmedBqS7HuWnl1F7Oy4lIVLEKRtdsBE8sl
         ontA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253191; x=1683845191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPQslJNp3mv+NTxxi/+JnTD498FdxuUbK0Kjk/H6R1I=;
        b=qmXaQ3ch+ZkBwMT2jyJq05dVsMSb5wiUVXnP8bO1P4fbhhCO/ymrloHZmZuP/jCAc2
         PTOB9NJu8WNbhLWM6+/i6cPxANsNRhOgIrzrX4jPv8QAekOEQLDk4OlRL6KeoZ47rYdB
         0N25PxM165jORagPq3KysYwTuahiT8DObrUXnQrY/stkEqAF0Vfp82jQtkLJTJTUIDM8
         VNMx1bGORTz54yY149rTsw1vh57OvxbWUIPPYiy/eKEIYpKhiGmdkb2JG+UiOiCwK7Lf
         GDmiwbWOMPTmJHPWmUPLIaz4lieIk+A/h9bYwzdJDCZYf/uwSSfUaGSCfENFMx6FbwH7
         htFQ==
X-Gm-Message-State: AAQBX9c0Ww550zL3Mhef5k6dZpCiRXqduTzHf50W8XAsD0T7nHe1wRZI
        TVTEkfPiP0XCK9nVWyaTGvubLgd8qTrb3oKJ9lc=
X-Google-Smtp-Source: AKy350YRm3WG6Bx8TrGJD8ffdBV7TmvIVsnuGuHf9TJIpAE1QlV3/3ejTxel4C6YgctZz7bRgXjjXw==
X-Received: by 2002:a19:7014:0:b0:4dd:9b6b:6b5b with SMTP id h20-20020a197014000000b004dd9b6b6b5bmr3326272lfc.16.1681253191554;
        Tue, 11 Apr 2023 15:46:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004e9b307d2c8sm2707629lfi.238.2023.04.11.15.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:46:31 -0700 (PDT)
Message-ID: <e6407312-c2fb-e77e-0c9e-abc2a014464a@linaro.org>
Date:   Wed, 12 Apr 2023 01:46:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] MAINTAINERS: Add Marijn Suijten as drm/msm reviewer
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20230411224308.440550-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411224308.440550-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 01:43, Marijn Suijten wrote:
> As I get more and more active in the drm/msm space, yet sometimes miss
> out on patches (where I was involved in previous discussions), add
> myself as reviewer to make this involvement clear.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
> 
> Note that this is only a slight commitment from my part to look at
> patches arriving in this area, most notably on the DPU1 driver and only
> if day-to-day workload allows for it.

I think Marijn does a good job of reviewing incoming patches in the 
mentioned area.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d7c816d46a..fd1b717c57d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6536,6 +6536,7 @@ M:	Rob Clark <robdclark@gmail.com>
>   M:	Abhinav Kumar <quic_abhinavk@quicinc.com>
>   M:	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>   R:	Sean Paul <sean@poorly.run>
> +R:	Marijn Suijten <marijn.suijten@somainline.org>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   L:	freedreno@lists.freedesktop.org

-- 
With best wishes
Dmitry

