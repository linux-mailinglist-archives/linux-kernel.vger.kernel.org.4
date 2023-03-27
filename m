Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2266C9C58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjC0Hid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjC0HiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:38:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DAA55B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:37:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so1338235wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902669;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PTyjeyB+LiPlbSLSBvv/DoCKWzMb1pZcoCNBXde7efk=;
        b=CF2bcNKzDLgbNseAerc+0cAre9/4rDu3GzL2RRUeKhnjkWjGLkvL1wtOgmHwuoI5aJ
         OBOgBVcpFlfTTWDWcrMGbfmo6Fb9iqGYRHvKxMZO8eGOm65sBFoskXv/As9gkvxvHrO3
         zbjpD/bg8kg5qbfPrKIFmNEryBbdebsYUPIiJ081KTYtAFMCdnHpd2/VKPbSjPxYLYiH
         igBUGTFq243kTaLZDyCi1OuVe78bceZu1I/+1O63RRhQWLd5DqeptIAkHIKs/L7oU7Do
         PPFJRTyB5d9tMLvbcFDUvOOFdBMq2EEv3W+7Vya15W2kih4kuyA7l54CrWvk6mEx1AVA
         QCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902669;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTyjeyB+LiPlbSLSBvv/DoCKWzMb1pZcoCNBXde7efk=;
        b=sCI8au8EGjD3qrNm424nYsyrgqtsf8ocGdgo9gMnOLMMWzN8zgzytFuLhFUFNVNabS
         qX1y0ifIZrYgr7weEHd12mesA8U6XXe2OJ8ffUSvx3N6dpk8V7xfmmaqsqEwGeeN0jyd
         vmDgjecaSw3NxKcUEPu2/B2XB/gi8UseQAgLTu2AfgEfGqbWbou1rsF4WyLyLiKPzXre
         qnDoT/ve7y0ZvWKwkI3KZXWpSgVkMccxWNNF2AlaLK11A3eZzPU3LiAudBnFZuM6TgW3
         4l4J4SApYK2KzJQNjIdPPj8B0Iqp7APOY8Nk2wo5zY45aXyxSKCuZuSYstI5ttKe50aq
         CizA==
X-Gm-Message-State: AO0yUKWF0qYw76Jna88Jx8QslRVb7fv6jVMUjdRS5GuY+KxzW43nkaYD
        q/tIiqroeHo2/MNx86m312JCuQ==
X-Google-Smtp-Source: AK7set/gBEBLHlpaqospGTeQnkjVDZlPZ+h6+Fz/IXtUpLQgYPM75dXsSD+nbRDJh26Q5hxWuEf6fg==
X-Received: by 2002:a05:600c:3150:b0:3ed:1fa1:73c5 with SMTP id h16-20020a05600c315000b003ed1fa173c5mr8461158wmo.27.1679902668757;
        Mon, 27 Mar 2023 00:37:48 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003ede6540190sm7893266wmq.0.2023.03.27.00.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:37:48 -0700 (PDT)
Message-ID: <0296a9df-2d40-8852-efc4-955cf4f791d1@linaro.org>
Date:   Mon, 27 Mar 2023 09:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/6] dt-bindings: display: panel-simple-dsi: document port
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
 <20230326155425.91181-4-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326155425.91181-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 17:54, Krzysztof Kozlowski wrote:
> Panels are supposed to have one port (coming from panel-common.yaml
> binding):
> 
>    msm8916-samsung-a3u-eur.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../display/panel/samsung,s6e88a0-ams452ef01.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
