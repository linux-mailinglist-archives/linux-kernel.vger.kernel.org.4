Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3C5F8D96
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJIS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJIS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:57:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCA71A228
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:57:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d24so6884640ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDDeNedlMFreEkFqdCoxqyamH5eFrq2g19d8reIB7Ls=;
        b=WeThPWRXkwpZfJsWoWGSVb4uWG4PHezAIA37BaqNXSNIVx1dbJNzDf2VsdmdR+8HqF
         f6cRHKZoEjwZtxzNyXnM0ke1R9FfMvLXyrn3xXpKN4fWgINYQPNuDnqDH2IqWPDLR+8y
         XHoBNraba3Od7sWAq3DB3FXN3RmmTGXZcPnR6J8vv3tgC4Z+D4No6vUU5cQ6b10uHq4e
         MI8qejIcGDMT8YWYpfl3K+bAEt3HWch5vnJYWXMKTtoiIcRtE7AqaurW8rI87tZVeZPs
         D75m4rqncv1XQdFmXIcFQ4nLrY2nn+98c4j7bSvTuGFTTRu3sLzAcPmgl/gYq+IUWtHj
         iUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDDeNedlMFreEkFqdCoxqyamH5eFrq2g19d8reIB7Ls=;
        b=j4gxsgptKZvTwC4W26u7cWawabT4oDYDvRH/JYI4eF0v4hGR5zC/mp3pNHT5aKb0DH
         N4s+J2pZ3gH0IaEd1aEQS7I4nvk5CEBv6Rvupa/HfcGRH9aw5uMPnxzSRGcuQHZ+vNih
         zmILd0jRRczEPd/viNHshXId7v0qO13La9+ecyB6NNVjpP0N3Fne0Qf03fjq7zzKBJAv
         OWyo/r/Bhi77fJcLJtxwEAPUKkwxYsBLMGZ/O1DYb5kwHkoLDlclt5oEagK03lEbgBkl
         L8+5Y0nomwPgVrVhQ8LgPAGFg8nU4vsgEc+9yUB81bxprO9jOn7Cd0UZtoRCeorRJbqt
         QHuw==
X-Gm-Message-State: ACrzQf2onUDaClSgs2MPx3ugcn81oYsnmx9itLtpmwTa1YTxohzjtaKv
        HJve1FuAwFTIzvHYCX1kYt6WuA==
X-Google-Smtp-Source: AMsMyM6fBnWKqL2m8+7OmLJdVQRJBD+PLD6fsTbPQKaR/ZodrumStMsrSZTw2rU8z7gB/eEeIjRerQ==
X-Received: by 2002:a05:651c:210a:b0:26e:ea0b:26ad with SMTP id a10-20020a05651c210a00b0026eea0b26admr1445510ljq.149.1665341843459;
        Sun, 09 Oct 2022 11:57:23 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b00492d7a7b4e3sm1122940lfr.4.2022.10.09.11.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 11:57:23 -0700 (PDT)
Message-ID: <b2bdf59e-abeb-2828-ae05-8cdb34c27c9c@linaro.org>
Date:   Sun, 9 Oct 2022 21:57:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 07/10] drm/msm/dsi: Disallow 8 BPC DSC configuration
 for alternative BPC values
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009185150.461323-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009185150.461323-1-marijn.suijten@somainline.org>
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

On 09/10/2022 21:51, Marijn Suijten wrote:
> According to the `/* bpc 8 */` comment below only values for a
> bits_per_component of 8 are currently hardcoded in place.  This is
> further confirmed by downstream sources [1] containing different
> constants for other BPC values (and different initial_offset too,
> with an extra dependency on bits_per_pixel).  Prevent future mishaps by
> explicitly disallowing any other bits_per_component value until the
> right parameters are put in place and tested.
> 
> [1]: https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/DISPLAY.LA.2.0.r1-08000-WAIPIO.0/msm/sde_dsc_helper.c#L110-139
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

