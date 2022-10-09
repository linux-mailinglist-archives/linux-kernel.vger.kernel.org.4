Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D065F8D8E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJISzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJISzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:55:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30938B867
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:55:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r14so13855780lfm.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qH4ZdZe+x9C/mI7GHILlpyuEO7Jb1CNK+ic7+GHbAPg=;
        b=U67pc2OnzYA36zslKIYqtHiPcMCpSF7wMvMSO3Ncc7e7XL4rSnYrEgUVrEq5SVQ3Jk
         uK9TEAAsUiahgTYMsFuMpELEL3XYe1l1WY4z7K8NtsVsxGL7kjDBGRSZS622q3mb5vrK
         bFtZI96xetuaJyGuSbGpTMzg1sWCiBdqiJX7ifEXJ/NW8yldlwsFFwncDIutLsMQFFIA
         9A0qENGe9B0nTnApk7TRWE4myDf2aK20z5RQ0McOfYvLuURpLcy7rrFc1hQJqBPu3YxO
         ppd1k+MPhESgcA/+n31BW1JR6etJ4e/nWL/S09r9Oyn+ppQEJwhEPcbmkhAs4lcoNuEr
         H9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH4ZdZe+x9C/mI7GHILlpyuEO7Jb1CNK+ic7+GHbAPg=;
        b=fekPEzpz8c6Otja6qFVT0dXrTWsmNMGu/HLx5lOVewIaefMlCZ9Ma8Vfrptgnjbrhv
         cxcKOX5p3/vvGjsCgI3O0cYcxQ4cFKPNh4c+1UyZHwkYgmtOZkrLTK3uTOTJEQJfITKD
         q2pC9vp7cvdtvw4/oljsHUbp8oBzO6iCo6Oe0G5ooz9WFFNssMaZklH1l6qj1jm275oo
         bYRnp9n+NX3Jrj/WXImJf2kmNiwWLo2OMhy2cpZ1KaicFz2zADYpRK1zI8Rk90BA3ctx
         LPyjt75czOk27Yf0CK1XL8B3aUB8IfzkQzMyforOAeCgGBBC0KChsPX5o+lvSd1n5KJg
         KCVg==
X-Gm-Message-State: ACrzQf0jZ2f5Pt8Z1vHHZashbeVwBT1B9BiHn2libt46MZN/1vPG1gFk
        rVf+ZYqVTFnnrmy8/thEOzICmQ==
X-Google-Smtp-Source: AMsMyM5XudCQ8+NtBNRpwa0An+WQMISOz2GaDYRpbDg8sJiqOjSyAFsOtplF00BqphiaiAFA/WnMKQ==
X-Received: by 2002:a05:6512:6d2:b0:4a2:4f62:270 with SMTP id u18-20020a05651206d200b004a24f620270mr5064072lff.143.1665341750545;
        Sun, 09 Oct 2022 11:55:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h15-20020ac250cf000000b00499b27a329esm1108791lfm.300.2022.10.09.11.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 11:55:50 -0700 (PDT)
Message-ID: <a36325ea-b1a1-4137-97c0-a76ad72a7c87@linaro.org>
Date:   Sun, 9 Oct 2022 21:55:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 05/10] drm/msm/dsi: Appropriately set
 dsc->mux_word_size based on bpc
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
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009184824.457416-6-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009184824.457416-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 21:48, Marijn Suijten wrote:
> This field is currently unread but will come into effect when duplicated
> code below is migrated to call drm_dsc_compute_rc_parameters(), which
> uses the bpc-dependent value of the local variable mux_words_size in
> much the same way.
> 
> The hardcoded constant seems to be a remnant from the `/* bpc 8 */`
> comment right above, indicating that this group of field assignments is
> applicable to bpc = 8 exclusively and should probably bail out on
> different bpc values, until constants for other bpc values are added (or
> the current ones are confirmed to be correct across multiple bpc's).
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

