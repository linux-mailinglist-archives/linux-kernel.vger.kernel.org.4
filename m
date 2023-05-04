Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568866F76F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEDU1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjEDU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:27:13 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16872D7AA
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:13:47 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so9820735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683231094; x=1685823094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhLpJ+4XVYMTBbKU5i+ULfTcOdDtMfpoFQixhCU6m6w=;
        b=ulhuEvU+yNAeamz7Ga8sSg91ahSLWl7ZlPxkvjhMFVs+0M7Laq899+w5ojfIE/zI6G
         v8v0hsTCGClTd0A5WJt1FDv0CHRqZdzQLnt0TheXbvzlVvCego89g3llE976WHepDt1X
         YRWj7WVipWkKuUld6B/sN4LDGyF9jdPRWfge+ZVKgm1DhcJNatZOAePmOx0ieM7nMFOS
         tU7E+8qxa3reUT5QEawY9ZVWESyjawhe3QpmQHM3+EwV8OZzcSBknalUONt6F9f3Cs3X
         yP0pExGx74QK790kAx1qnZsuPzjDzUwnU3y9PvGuLm9XwWF1hyBesVs5vlYrT7RAKW78
         fu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683231094; x=1685823094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhLpJ+4XVYMTBbKU5i+ULfTcOdDtMfpoFQixhCU6m6w=;
        b=R+jTIvqbd7ntW/ci60X1nF+PG6EeU9h+CAAxR/hByXnHsY1PgnPCg8liYl+OzeVLis
         66Oa6BKbmiEMTp7ccjJGetztXMJvhaEl8ABPibVnOs8JoZrvOesiX+O3IYsCGv+/r1eu
         vgqKYcHxlRN0gIat5Sfi2SreqBUG0CpG/3W/p5U+w5Lm485Y2ruuldAGaLSj0GJu6Y2q
         0mXrV9zqHGUex5PrfeXyXZOze/HQBtm08GAJgHrfMIBV4iW8fdTAvfTkU8h0lwVTPoub
         I2Qg3fxcHyO95b+pPp2vaYzapE6GmpzqbpvOyRxtjHqdZWpO4wG0P5pa1W4wa9FYPiQV
         dsGw==
X-Gm-Message-State: AC+VfDwrO22QrYJ/9SKm64c+Upen9D46YImtUSkmVuXgr40UYrIwJ9Mf
        5gfTxpD5m3dFA5/iNHz3nLcEFZUgc6lrmVsAsoc=
X-Google-Smtp-Source: ACHHUZ42P42FbCtfpSKN3KOROAYlmZPNwEI3F+cHVDekGGCUpP8K37i1bTQKHm0lbQ5uu6KwhWGzaQ==
X-Received: by 2002:a05:6512:964:b0:4d5:a689:7f9d with SMTP id v4-20020a056512096400b004d5a6897f9dmr1925019lft.57.1683230363234;
        Thu, 04 May 2023 12:59:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 19-20020ac24853000000b004d887e0e9edsm482lfy.168.2023.05.04.12.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 12:59:22 -0700 (PDT)
Message-ID: <06864435-3db9-a91c-2e99-69829d8296b1@linaro.org>
Date:   Thu, 4 May 2023 22:59:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into PP_BLK
 and PP_BLK_TE marcos
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
 <ljt5mp4ew5lcrrrdd7xyof3jv3friafbmr3im35ddwxjc42ekh@toez7xfdreg2>
 <CAA8EJpreM9i3DUp+93K7p14f_tNMy-m+C-WdyN5_drmmkGV66g@mail.gmail.com>
 <u7hlzltevx675gfg4w6emmeceo6nj76taqeecsor6iqsi3hmki@lg43y65m6chz>
 <11ef769a-5089-57d4-db87-4c5766d98206@quicinc.com>
 <6qg25ffuq6xcfz3vuqm5lguspihjospctjclxmwyu2ifau4p7b@txywjmir7lg5>
 <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 22:50, Abhinav Kumar wrote:
> 
> 
> On 5/4/2023 12:36 PM, Marijn Suijten wrote:
>> On 2023-05-04 11:25:44, Abhinav Kumar wrote:
>> <snip>
>>>> Sure, if you really prefer a split I'd go for two patches:
>>>> 1. Add the flag to the enum and catalog;
>>>> 2. Add the ops guard (functional change).
>>>>
>>>> Then don't forget to reword the commit message, following the 
>>>> guidelines
>>>> below and the suggestion for 2/7.
>>>>
>>>> - Marijn
>>>
>>> Plan sounds good to me.
>>>
>>> Marijn, we will wait for a couple of days to post the next rev but would
>>> be hard more than that as we need to pick up other things which are
>>> pending on top of this. Hence would appreciate if you can finish reviews
>>> by then.
>>
>> It depends on how many more revisions are needed after that, and not all
>> patches in this series have an r-b just yet.  Given the amount of review
>> comments that are still trickling in (also on patches that already have
>> maintainer r-b) I don't think we're quite there to start thinging about
>> picking this up in drm-msm just yet.  I doubt anyone wants a repeat of
>> the original DSC series, which went through many review rounds yet still
>> required multiple series of bugfixes (some of which were pointed out and
>> ignored in review) to be brought to a working state.  But the split
>> across topics per series already makes this a lot less likely, many
>> thanks for that.
>>
> 
> I think the outstanding comments shouldnt last more than 1-2 revs more 
> on this one as its mostly due to multiple patches on the list touching 
> catalog at the same time. I have been monitoring the comments closely 
> even though I dont respond to all of them.
> 
> One of the major reasons of the number of issues with DSC 1.1 was QC 
> didn't really have the devices or panels to support it. Thats why I 
> changed that this time around to take more control of validation of DSC 
> 1.2 and ofcourse decided to break up of series into the least amount of 
> functionality needed to keep the DPU driver intact.
> 
> All that being said, we still value your comments and would gladly wait 
> for a couple of days like I already wrote. But there are more 
> incremental series on top of this:
> 
> -> DSI changes for DSC 1.2
> -> proper teardown for DSC
> -> DSC pair allocation support
> -> DSC 1.2 over DP
> 
> We will be posting all of these within next couple of weeks on top of this.

I'd say, it's fine to post them now, as we have more or less agreed on 
the helper series. The interface between the series should be stable then.

The RM series is probably the one having bigger dependencies/conflicts 
on other pending patches (include virtual wide planes)

> 
>> In other words, let's take it slow and do things properly this time. And
>> who knows, perhaps the rest of these patches are more straightforward.
>>
> 
> Ack. the intent is always to do things right the first time.
> 
>> - Marijn
>>
>> <snip>

-- 
With best wishes
Dmitry

