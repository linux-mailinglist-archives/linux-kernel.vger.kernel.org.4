Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F25E9C92
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiIZIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiIZIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:54:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869211169
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:54:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q17so6599073lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xH/VWjkeReXpRX9hNsqn6iJRBBhODPMyKniE40e1DmQ=;
        b=WPMvGa3GhTVyne+ucl3l1h2e3EAmtJjpnv+EEXkKaRBAWimtux3gr0VjPeN5H+Vydf
         YqiyGepJ8FZjkdWvybIzokJSwN9n5FhUh0ZJcEuOnzNw/neaCpVlEdsilA4ghUdft4GR
         YQSe8BHuCQWmq+d4J5SELoxT4190MIdC83GRKh5F4G90B8ny7gw7DqJvREAE/OSSsQgI
         Zk2AVqLSZ7wl1JRn9flbtQy6Lmglcz30bM318D/MfHdxWyCT47IoN3QggzJ41ClPe2Mo
         GtiGe+g0tpmoKj6dJ7IvTRdgSyGHX3+FGOWwt+D6j4LwKYWHfFAlyJZWM601MX6hgy6R
         f2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xH/VWjkeReXpRX9hNsqn6iJRBBhODPMyKniE40e1DmQ=;
        b=pKfYZXaZ3+HDTEVKp/zAXXCOtctuDBHRCVLEjnRKIDe3zVOyb/EhpfPimxhPACJSPf
         bpbKaUJgWpRkiWe2117uBC/b3rA8QOMPqcodH1HkORsxA66o3OO3XV9yxTl+2Z5Zy+jv
         6npSbpeKn6vyGlCJC2r9kwlm92j1LJGtFRyWgqvet1StJqWoCPv6u3BNkFaIcldr50bP
         xuwin2jzQOk3P4r/cSruxirkp8VYZ39iltdfTtY5M0GyNOZDZf3CE7oRSPtZuixwY6/v
         CJLwOR7ckqLZ82Bz2g/xUS0ZhKXfU8C6GbgPtBcTgWb6gp0gYyIgAnylVqW2NAAi4zj3
         Bs7Q==
X-Gm-Message-State: ACrzQf3NT9QjgoI338Utg26sQeOXfaV5+kRtdVO3O/qmaSDhfwO2CKLH
        gToU8XcKV41to4CqAnGixh+CxQ==
X-Google-Smtp-Source: AMsMyM5/QP3PvbYuQkluMZfjda3hzOgQHl0/rxn5wuQcIYRdv65cbyR7Cu1V8aQFSUV2WHXmpDyzjQ==
X-Received: by 2002:a05:651c:2205:b0:26c:622e:afef with SMTP id y5-20020a05651c220500b0026c622eafefmr7711929ljq.242.1664182489969;
        Mon, 26 Sep 2022 01:54:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o3-20020a198c03000000b00497ad9ae486sm2471618lfd.62.2022.09.26.01.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:54:49 -0700 (PDT)
Message-ID: <825b1178-6c05-e39b-2f65-4936e6280531@linaro.org>
Date:   Mon, 26 Sep 2022 10:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: pm8941: fix vadc channel node names
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925161821.78030-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925161821.78030-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 18:18, Luca Weiss wrote:
> Node names for the channel are supposed to be adc-chan@REG.

Why exactly?

> 
> Use this format and at the same time sort the nodes by reg value.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 

Best regards,
Krzysztof

