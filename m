Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85063F542
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLAQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiLAQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:27:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88878B9552
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:27:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id be13so3294605lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioDN+pQOq5HgtdlEf9mzg0ol1oWyOo4wG8Vd6+93HFU=;
        b=DcPJ/+ro4LTVRBqT5fBcbYkOTmqVTNe/CEugS6D/beI6xfBxbs78ENrgSxClvaMHcf
         RkbIdl7gtHfOWwI7vMXWHhX3/ZQJeTmu6dmNEE9l+s7/JEKxMpaKnirFvkUKKDnsR6jx
         L1MSIZ/lnV08pyOMAh+9dQPAme6uv1CtegPV9HmyAnBJp+wpSBA3UaM+weZbXxut9o39
         ByIve5BWXDhp765OWpbJ6zeXzaR0ZoPf+5HezQBGY/u0jgUdnTuZA2W6Obo6IM5ajJyK
         hLpoSl+NddeROjGsWeZjbzHBYqzf/+UCxy4xp9TE3sE07m3HM/2L4X1wD2zpQgYSdMvh
         m46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioDN+pQOq5HgtdlEf9mzg0ol1oWyOo4wG8Vd6+93HFU=;
        b=caCQtRY2j4Y+9unUzoQ+KPwha4GQcJw3xzdhO0FJBq93dSZC1NK917UdWuWyOzYi03
         EpNxhPTEqhM9SDv6RNi/aCHvbm3XvyS6tTTksOXh3I4CaK9VbSFUcxtghWR94YHcWDzC
         aJzTG5PvltGRit/pj0zD6b6oNxUadvYN8EoK6WJU+N/HoSlMjdusRJPTMqjGK0prJtOJ
         8aTNMVHAYLVBw44900dl23AFm+T0ukmV95m02TmcCOGXfdtfOBVJnSgOWf1Fj2hkV6LH
         WzGdv+GBv878Pf3yISjtjgyqrfk3HvXYGMDoxaalkRvwsa7TEAbXKIugmpgDP6bJuMty
         HTjA==
X-Gm-Message-State: ANoB5plKokgAqAFeVpQxJy/WPXBc66HMz5gR0Y9/O4c0BBVl4i4GHjgq
        9cR84lN9L6s42v8SAg9FnNahHg==
X-Google-Smtp-Source: AA0mqf7SXeJYAFY40xLBV+mv7rmI1226pH4qxPkT72pkjWhQqM7mclAyG6E0AGksRTezv8lCWk5gNA==
X-Received: by 2002:a05:6512:3a7:b0:4a4:77a8:5ba1 with SMTP id v7-20020a05651203a700b004a477a85ba1mr20981287lfp.569.1669912033890;
        Thu, 01 Dec 2022 08:27:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p21-20020a2eba15000000b002796fb63dbdsm439396lja.13.2022.12.01.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:27:12 -0800 (PST)
Message-ID: <9ea881a6-5786-2e3b-7341-60180359d2b0@linaro.org>
Date:   Thu, 1 Dec 2022 17:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add sm6350
 compatible
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130081430.67831-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 09:14, Luca Weiss wrote:
> Add the compatible describing the combo phy found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v2:
> * Drop misc schema changes again since same schema applies to sm6350


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

