Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC3706275
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEQINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjEQIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:12:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7423AA2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:12:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so810846a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684311174; x=1686903174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1tI4Mj0GuSStRExKQnt10Sk/TUm6zi642R3YYtuxTg=;
        b=V8lPYAu5z6+U2gOqC3z7VJ6URsVOO59EBAapcvlyAJwMLkjWrr7Wo8CWmDGhwsYrsu
         a2QuWAVSgLVcpflAjiee1DWUQ3QFYYWm4bs7QBkGaFGJ0e6X3kvIItt5WsDmPyMaDbv0
         ECW7cs5cfAKHdX5/56inb70getKGq9ckpGPstIzT4dbHLvY83hCkguaYu4Er9bskuckq
         yVBnUpbEdmrGwHP1R61bX7HXL+W5BvToV+0tCQAF8nw1o4bjRMbJGpVRVpGCiMon3YYq
         CwGLNMl2Zk1brXQt53Iqh2/25aB7Vd6tAYJrjarZlSc3EZCU7eAaLoZl5TEb0z2PJAEB
         kKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311174; x=1686903174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1tI4Mj0GuSStRExKQnt10Sk/TUm6zi642R3YYtuxTg=;
        b=J/fUN7QVSC4WNd33ey3qa1PMoysZgej73QteNvBw/FTxnQqWTZWqUw9KWflZ1BF7Su
         nB/7hB4GwqOYxs6o8FZypPotO3DluXmEih+GFddVpmWi8mX+a2LXbpgt/RxVLkJtVxX3
         HqHq0ya229KUEqd5yBz/8fbHKBtE+8CdiQLxc0Xi74oiibhJOgJTN63b7LPVBczSdEw6
         HocEYW7t0bldDCR+uEA2o/tjDTpvClg4SYFcwaIv4Y4OfFrwBVn11fTDUbqvSvTwHLdM
         mvdFqRtSHpy5ZHUcwN2KOKF98iUa3RuZsxth7F7ZZYhTTt3np0BOBKX3a12B+RKzGgC7
         s/Dw==
X-Gm-Message-State: AC+VfDzrndCGvk5yCtdWN6PCAAAWos8JxGuIkrR/Y2YZzLQQP72/ioPG
        6DYzFJ1cHliiMiB5jr9yzPjxDA==
X-Google-Smtp-Source: ACHHUZ5K6XkIbwGR7BN6nwPpwg/ie+J/ruD+GqyEdrYyAZ5GpjgmN1Cyt5H5Q2dumD6Pk6xDfBnrBQ==
X-Received: by 2002:aa7:d78f:0:b0:50d:8cde:a335 with SMTP id s15-20020aa7d78f000000b0050d8cdea335mr1615810edq.15.1684311173952;
        Wed, 17 May 2023 01:12:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7c149000000b00509d1c6dcefsm9033171edp.13.2023.05.17.01.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:12:53 -0700 (PDT)
Message-ID: <8be8cc8e-5580-0f4f-a00e-46f392356026@linaro.org>
Date:   Wed, 17 May 2023 10:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Visionox R66451
 AMOLED DSI panel bindings
Content-Language: en-US
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-1-4210bcbb1649@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516-b4-r66451-panel-driver-v1-1-4210bcbb1649@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 22:20, Jessica Zhang wrote:
> Document the 1080x2340 Visionox R66451 AMOLED DSI panel bindings
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  .../bindings/display/panel/visionox,r66451.yaml    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

If there is going to be new version:
A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

