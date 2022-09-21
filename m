Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6995E53AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIUTRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIUTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:17:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F85901B1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:17:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c7so8186808ljm.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FFWYf30fxjjXlIOxVdGNR+WbXDYJYmOBDe6NwowrDcw=;
        b=nggP6OM3QKE6RW+j+AFHq3/wAShbkUl0R9xn+imGaZzFd7yKoMYAIqvC0gr6vCDY/m
         PoYI5CY4V4PpLDLBD7PlUdr1HlQ/mxJwPRtSdB2BtBCVgeaL+enLaFBFf43w8XhZIWvh
         iESv1WEvk4cMdyp/q1Oi35yB90zYiqvIWt4eFYGQ8nJ+vEM/K4zoJo+zGoeQ//eo5J6C
         ULC0aLKmorK8ArIYG71AI8SXT+C7ZFI0hCSSOi7NzVK+A/PfkCbfT1P1EciLvUnPhGv+
         +6ocLClqNKXmGocImDYJq1XK/SRHqlDIhQRLBRrlc4YZ+NNdg9pAgiU3NxPT8NO2iTAK
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FFWYf30fxjjXlIOxVdGNR+WbXDYJYmOBDe6NwowrDcw=;
        b=eUoKEKFtzPeSIMA280Mph9jsEihhq39ATIqeJQ+D0MPKTITAyPv4mICLvxYl1SUV8m
         GT+DrGQemToxNtjR/zIfF4Aq9emn/2PhPzGNMdVHEdxfju+TU+zY7abZwdK/m1PqnAwr
         lisSrip69NaCNjjIqjBlQw1nSO8rOHnA6ncjl7qrt36lbHxDN3cmqhZWJp5chxCaY/sC
         Esre7x45C4r+heuWgt4Ta1+HvIHS06t31beBqwXKIH11v1pfjORgkBwW57XsfkB8ihZ0
         NaTieMERaZ+XSC9ClzK4jmx+lX9aSyY9tfUIybaQQyWpsG5h0wRmKb4fKWvCOxpy9W0/
         P7zw==
X-Gm-Message-State: ACrzQf33cVTgYCILc7nngHSFq/EBxky98YUzZa7vL3rifHmwodrOzq6F
        16l7gfB3+TrhqlLUh04LXdyQ0w==
X-Google-Smtp-Source: AMsMyM5IvOZj2smJRYesMDeMVzK6M8cYzNjZL/HD4dd4Um+JJBWr7edNvCVbQncMORTAMITwyrLtXA==
X-Received: by 2002:a2e:9606:0:b0:26c:442a:40c2 with SMTP id v6-20020a2e9606000000b0026c442a40c2mr7470688ljh.458.1663787851473;
        Wed, 21 Sep 2022 12:17:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r8-20020a2e8e28000000b0026c36023a9asm342207ljk.131.2022.09.21.12.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:17:30 -0700 (PDT)
Message-ID: <223e2055-bc5a-a1ca-46e7-a3f6cbdaa761@linaro.org>
Date:   Wed, 21 Sep 2022 21:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/4] dt-bindings: remoteproc: qcom: wcnss: Add
 qcom,pronto compatible
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
 <20220921043648.2152725-4-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921043648.2152725-4-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 06:36, Sireesh Kodali wrote:
> This is not a fallback compatible, it must be present in addition to
> "qcom,pronto-v*". It is also not documented in qcom,wcnss-pil.txt.  This
> is the reason for documenting it in a separate commit.
> 
> This compatible is used in the wcn36xx driver to determine which
> register must be accessed. However it isn't immediately clear why the
> wcn36xx driver relies on this extra compatible string rather than just
> looking for "qcom,pronto-v*".


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

