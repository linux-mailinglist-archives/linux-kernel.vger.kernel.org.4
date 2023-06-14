Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61672FFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbjFNNNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbjFNNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:13:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A62122
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:12:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5186a157b85so4076491a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686748360; x=1689340360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S08ZeNXqQP5v9xLbtyoi47QEn3XexDdtBrQiOR2aUNA=;
        b=ygCBTdm74mYQDFjGHmbNGWaXGRjkqN/cbCWdPpx4X4Iyx5ncVTd7OAfdRM48U3lzam
         SsJtPLYc5grKSevCx1PV9R/x5EN7c6mJYKSz1ZddrjppC358eO5NWaHYhqvWNTWrStGj
         49MiVylg8OoetBcwOMIHrhqJa29f7qpIaLh5RoS/blIzxXtWJnFrxdbPQ86VU6O81+ig
         ZMDHISX4z96IIYxnEQ4iTr3tLFoCEmV6kMJdba0FJ7dyY7EUNq0mw8YzZNbbzDvLsJyw
         qV83hH6m5h+ooxdSkg4UzP7t8YpaAYWhU+TpNJbpLJOaGFedvyXxHqVkwKkVbQ7InpWj
         qXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748360; x=1689340360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S08ZeNXqQP5v9xLbtyoi47QEn3XexDdtBrQiOR2aUNA=;
        b=mGveGK1d3a35eW8qE1EXvmOmHliqlte45STwbaDDUAZM5WfRk9ZfBH19lq9eHt+9mE
         OAdxdhD7OUF2h3Ok4UNCccnflhEPHcY37CW2Jhn1m7FH1+XT7+symmWVY/3K4KwHAn8F
         tijpspKREwZpAMWwUiXiFaJMjgXJOltjxx3YvIIt9R8T4hNo2lfz/7vtLQGTK6KlGvzh
         aLaYPE5o97g1Fk718UJpKZyL+RxqcexNdvDMukUjBgAQgh7i6CpfmakqOBtMe80Beh8u
         i8Y8mFL+EhoGoGf9DwD7pzrGPlF8jt55wRE6gBtPUISzhV1MhHzrQNEgRq2+B/oN6AI6
         yKcA==
X-Gm-Message-State: AC+VfDwOiaLYklxKhW/s4ky49kWAozayRX1zgCCUzH7jNG1gpYRJAatk
        hGmNvCftUcmdKF0ARnqt/ZZ7wYLLtn1pDijVM7k=
X-Google-Smtp-Source: ACHHUZ6GOuDAoa4gpksMPRaoojmdo3dq1uAiUbBSCfD19wFN0HT5b/iWp+S+vfOecTCo3rv7erOUMQ==
X-Received: by 2002:a05:6402:1202:b0:518:9174:9b5f with SMTP id c2-20020a056402120200b0051891749b5fmr1685330edw.1.1686748359872;
        Wed, 14 Jun 2023 06:12:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b005149461b1e0sm7682925edr.25.2023.06.14.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:12:39 -0700 (PDT)
Message-ID: <ed54c63d-3342-a566-e12c-2b0672e89200@linaro.org>
Date:   Wed, 14 Jun 2023 15:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] usb: typec: fsa4480: add support for Audio Accessory
 Mode
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-3-15a92565146b@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-3-15a92565146b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 15:10, Neil Armstrong wrote:
> The FSA4480 Type-C switch supports switching the Audio R/L,
> AGND and MIC signals to the USB-C DP/DM and SBU1/2 to support
> the Audio Accessory Mode.
> 
> The FSA4480 has an integrated Audio jack detection mechanism
> to automatically mux the AGND, MIX and Sense to the correct
> SBU lines to support 3 pole and both 4 pole TRRS pinouts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

