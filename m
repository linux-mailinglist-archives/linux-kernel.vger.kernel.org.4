Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D986F4BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEBVOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:14:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D4510F3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:14:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00d41df22so189246e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683062082; x=1685654082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9P/QuNBKbdebYLBwYAAK30MQzjSHHu9hFYcUK5a+Wo=;
        b=Y7pfv34sFJP6MWFNCCJy0saWVM3tcTkdqa3e2k49N7RTtCj6ZRniW07nCohVibpv1C
         5hMu8/cg4ksSvGHbwI8yupZJcRWPzENrThdeJla0/+ZF2ZoJAXVJVCFnBhtGvklVZViX
         /SSr1vdmIHP0QsEUxdiXl+/Tfc54mF51TNLIjiUHTOz6tflMtaFy6atWOgd0eP3vXyT9
         WJ2MRm8JH3ekjc/nip9C7WajsH3R/XAGTAxGjR4FQVn1UV0zWF1een8f1Cx2QT9hiQPw
         K/MtSeZZfNjH3TPnB6PLTANB7Kfl95zi4MgpxCJxFHd2lILA9FrS288EkwFapNBJamw2
         7lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062082; x=1685654082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9P/QuNBKbdebYLBwYAAK30MQzjSHHu9hFYcUK5a+Wo=;
        b=Z9ZcqrOVIvLTlNGhUxkXnmS+9xCSEP1ElwCB2CkjELTsWqWLXde8W5jdcqxDQlTIEy
         dwq0bOzj6/smAN8PGdvSuBJOXJQNwYU7DhgoipOEyRMwPSlVhmyHMomefCENzpHq9Umj
         CJBuQLv3mDlClg1MWuZl9Xgc6NPaMZVigmatGi8PRxd4qtIyROQXdPwyg5WEvqzmmvKQ
         vXqVqVcCZ3QXzcgoDsLCNvX0D53yQS0HacEhpWa+NWDWOeRYeCy70x/SuGliJzVzC61c
         /q75w+V6W/33ft4aS7wJ1CteEzphMKTade+de1080fv64rCafdY9sPfhJRkAGbI9dhmJ
         myew==
X-Gm-Message-State: AC+VfDxfpK4sV7b/I4JO/GIYhp8fR+G5Q/5hQnW4UMmGU6vio9y5LUXv
        XFxAE/OyLuN/O3N+kH0dd4pTpA==
X-Google-Smtp-Source: ACHHUZ5qr2JMQgQ5x+vB+uEOUaiH2Lbv0PJnfjAWkSZJHxdNrTgNtmj9+eGDkM+hqw97nhQaSXfd2g==
X-Received: by 2002:ac2:46f1:0:b0:4ef:d567:4854 with SMTP id q17-20020ac246f1000000b004efd5674854mr307075lfo.11.1683062082451;
        Tue, 02 May 2023 14:14:42 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004eb4074f40fsm5573686lfe.241.2023.05.02.14.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:14:42 -0700 (PDT)
Message-ID: <e36a8034-605d-1f78-95c3-1c85689e2256@linaro.org>
Date:   Wed, 3 May 2023 00:14:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/7] add DSC 1.2 dpu supports
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 00:02, Kuogee Hsieh wrote:
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from [3].

Changelog?

-- 
With best wishes
Dmitry

