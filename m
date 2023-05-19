Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5995B709CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjESQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjESQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:42:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C633E114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:42:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2602848aso8878331fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684514553; x=1687106553;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=143EakvyOuVdHkumYHBraHpbTfkxgJP6S3+u9gTOH5w=;
        b=H6i68wdNAUIf4PQUqwLssDsY3GknAmQxtXtb71tGZxPoWwlYnwRqr8auBnpdr1ktOm
         9dBuw/oXX5ve66KfRi9b/9NAbhOgrtNe7xPpuWXNOnoUgzDZStfuCNo3L3MzZ8i3R67N
         UtAtpvq2RUUreDOuy5FhTDT0bGgGBgWynt2GiadslacGJNXaVFgolXG9lakRzjMWLgm+
         9ZiE87SjX2xi0dhJaqcEGBp7kn17U5hVlZblqBGVuNoVj7u4guslAG6HNZ+xvQb5nycM
         DgoCNnBo6BqbBYJ5DV6lxEAstGCkCAwf9g6xDGxApWAeBWzUIg+BsjLxlLUssp12Lldx
         H5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684514553; x=1687106553;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=143EakvyOuVdHkumYHBraHpbTfkxgJP6S3+u9gTOH5w=;
        b=KW1A6Kcl68HTrwfLUg+6sRDK/MHFmrAGELwJerzVVSsbu0r4rXZDbiWfBY9IwidLya
         8urT6EMPyJ7OSEqfJQ4n+YaqNnqUVza7WaFxvFDQShB4b1tdsdNr/7HY+C2A7WI+yrBE
         VuI1DkaTNkc0LeSbQLLBkBKXoji202l0vyi6kIcBkN3WxotJbpgzSqw8jfDXTyUmt23H
         xco5VT7PnJrACfjDwmxcHL966dy5hxL0StxNSO720njvdr7X893NrGFfiU4GJKhi2ZbO
         w9iM0TZ3VOWSEKJZuw9IMhgCsOFjEHaojduduqkx+vz9aPF1573wMTD+TZHfSnXcFXgd
         UYDw==
X-Gm-Message-State: AC+VfDz0Sg8hXvcv7s4sJG0XO/1LJZob5g+0X2j1ocfOA4rvOLmEHtOL
        u7C+6GVTN8UGcRRc6LSbh64PBA8FU3zcLEx52KA=
X-Google-Smtp-Source: ACHHUZ5CdyVB0/lT15XzwEt1IwNhkaSEWNdeA1DBJ6SV+PZd+UtKzg7gmtugTSK7682fQLSzo6Qxpw==
X-Received: by 2002:a2e:9008:0:b0:2a8:e44e:c75a with SMTP id h8-20020a2e9008000000b002a8e44ec75amr896865ljg.32.1684514553045;
        Fri, 19 May 2023 09:42:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l11-20020a2e3e0b000000b002aa40d705a5sm895992lja.11.2023.05.19.09.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:42:32 -0700 (PDT)
Message-ID: <e4824511-1148-83ee-b6e9-4f819e655f32@linaro.org>
Date:   Fri, 19 May 2023 19:42:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 3/3] msm: skip the atomic commit of self refresh while
 PSR running
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Vinod Polimera <vpolimer@qti.qualcomm.com>
Cc:     "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Vishnuvardhan Prodduturi (QUIC)" <quic_vproddut@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
References: <1680271114-1534-1-git-send-email-quic_vpolimer@quicinc.com>
 <1680271114-1534-4-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJppc3LDQy2RgVZbWki4Y-_FOTK67Y8RfK5Bm9gqdfqMjqQ@mail.gmail.com>
 <BN0PR02MB8173E9FF869F7EEFCE1F5410E4929@BN0PR02MB8173.namprd02.prod.outlook.com>
 <CAA8EJprj5cmB_STfv45NDCJ_e=aWfwMgaNmGkQBqFa8fQq6gQw@mail.gmail.com>
In-Reply-To: <CAA8EJprj5cmB_STfv45NDCJ_e=aWfwMgaNmGkQBqFa8fQq6gQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 19:11, Dmitry Baryshkov wrote:
> On Mon, 3 Apr 2023 at 15:01, Vinod Polimera <vpolimer@qti.qualcomm.com> wrote:
>>
>>> On Fri, 31 Mar 2023 at 16:59, Vinod Polimera <quic_vpolimer@quicinc.com>
>>> wrote:
>>>>
>>>> In certain CPU stress conditions, there can be a delay in scheduling commit
>>>> work and it was observed that PSR commit from a different work queue
>>> was
>>>> scheduled. Avoid these commits as display is already in PSR mode.
>>>>
>>>> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/msm_atomic.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c
>>> b/drivers/gpu/drm/msm/msm_atomic.c
>>>> index 645fe53..f8141bb 100644
>>>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>>>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>>>> @@ -192,6 +192,9 @@ int msm_atomic_check(struct drm_device *dev,
>>> struct drm_atomic_state *state)
>>>>                          new_crtc_state->mode_changed = true;
>>>>                          state->allow_modeset = true;
>>>>                  }
>>>> +
>>>> +               if (old_crtc_state->self_refresh_active && new_crtc_state-
>>>> self_refresh_active)
>>>> +                       return -EINVAL;
>>>
>>> EINVAL here means that atomic_check will fail if both old and new
>>> states are in SR mode. For example, there might be a mode set for
>>> another CRTC (while keeping this one in SR mode). I don't think this
>>> is correct. We should skip/shortcut the commit, that's true. But I
>>> doubt that returning an error here is a proper way to do this. Please
>>> correct me if I'm wrong.
>>
>> If there is a modeset on same crtc with a different connector. The new_crtc_state will not have self_refresh_active set.
>> Self_refresh_active is set from the helper library, which will duplicate the old_state and just adds self_refresh_active to true and active to false.
>> so we can be confident that if we are checking for self_refresh_active status then it should be coming from the library call.
>>
>> Also the EINVAL is returned to the self_refresh library API and the function will be retired.
> 
> Maybe I misunderstand you here. However, in this way EINVAL is
> returned to drm_atomic_check_only() and not to the SR code.

Unless anybody objects, I'm going to drop this patch now. The issue 
should be solved in the framework itself.

> 
>> And self_refresh_active is cleared on every commit : https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/drm_atomic_state_helper.c#n158
> 
> And this means that this check will not trigger at all, if I'm not
> mistaken. You've added code to msm_atomic_check(), so
> drm_self_refresh_helper_alter_state() was not called (yet) and thus
> new_crtc_state->self_refresh_active is set to false, fresh after
> crtc's duplicate_state.
> 
> --
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

