Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21156600AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjAFM4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAFMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:55:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC27A91A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:54:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so128100wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VQTtg9FSwvM20hhEBQ4latfuLMcaI0mRbc2gb+Wsmo=;
        b=zGZsa8cLWEhtzBevZZussjAm4VHCN2pntlxPMLfsR3UVJPOee021IF6+6gUefIjOI8
         IFDwpsrLlHuGtmcITRyyTTqXLa9L+CI2xskRTX2kKfbFQlHgHAg0z1bWHRHk8gbeV7HR
         pV6KrpISoASdQsrrBvwFlS8J5bVPDnIoK6xtWc+0iO4L7X6CJombsXW+Dua/axoA4MJk
         fxSpo2VD2OTARoCzMKQQ6sISZPjXleM4MS+8+9pqBGBSB/iP1Y9ZUVDjkBdpCGyQebhY
         pll49HcO5hsd7sLhqj3fWKgx7OOn2bpwls0u8wpIE4rMvGIj1ubCnRZuNGu8PGmjt1dc
         2J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VQTtg9FSwvM20hhEBQ4latfuLMcaI0mRbc2gb+Wsmo=;
        b=Q2pZdw4qx7ZPU9YoaDn05IT3bzHh3teJ4uATZkTDnGP8mkFK31KR+ajeww6rFhcW9F
         jVOVADG3P8BoEXE4sb+IWhAM0cdZftF69K6Ajx0J4tXJIqKpp9mXwsENDyOLdLHGAudE
         kXBztfNFqRR6M4WCHHaUKZwSEROu0sCDql3rfmHbbQbdSleAQdZmLMNk5El14iaRbayg
         pnD+Rm0+b76fySFPwgLhuTbPVJUAbM+g//NTeVHoq+K2hjtpV2vEmeDgWh1Fp/sQNT7e
         NSh+mIrbObS8CxkYQRca82XUNbJdiVDBALFdxXooO8a/UC6Gu31ZV8qIujcPs0IwlMZg
         gdLA==
X-Gm-Message-State: AFqh2koCWwrBB/h4rpnB9FZjNfwftzLFtNKfuQm4qcMnShvBhNFnMHOm
        /M6n3mYUn3/8IbDVl64CN8ZXqA==
X-Google-Smtp-Source: AMrXdXsdMCQTT70zgRFV/Vn26wT2YcgpPEAUPM7w5hQReZi/R7gT2YVbZF36R1ACF5NF6yt+Ntl4wg==
X-Received: by 2002:a5d:525a:0:b0:287:6400:1f9c with SMTP id k26-20020a5d525a000000b0028764001f9cmr21089842wrc.42.1673009652170;
        Fri, 06 Jan 2023 04:54:12 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d6a08000000b002a1ae285bfasm1078634wru.77.2023.01.06.04.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:54:11 -0800 (PST)
Message-ID: <18bde666-db4b-95b9-7ce1-a012ed33bf04@linaro.org>
Date:   Fri, 6 Jan 2023 13:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: document the Visionox
 VTDR6130 AMOLED DSI Panel bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-0-9b746b858378@linaro.org>
 <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-1-9b746b858378@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-1-9b746b858378@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 15:22, Neil Armstrong wrote:
> Document the 1080x2400 Visionox VTDR6130 AMOLED DSI Panel bindings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/panel/visionox,vtdr6130.yaml  | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

