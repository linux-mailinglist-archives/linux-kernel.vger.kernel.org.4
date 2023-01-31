Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805866834B7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAaSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjAaSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:06:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DD3C2E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:06:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11292466wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh+BttHshTvqwVfMkHR/OJvGZDmWyNUQNSwogcN12jI=;
        b=iHKBxNV+ta9uv97C6OR1AKGkARIXP8jzYYDNtobOQo58BIfJ7D0pZ/G29kPMKXXKyY
         TyIIh6jr+G00O42SlppKSBMuCD0b4RQzmHhBzRpKsx7eoOvRdcElZu42kyGr8bVvhKse
         xxETzx89nrhf5rKWogWmljTQ9pNBaSorebDwm4k4N4s6WkaZomppS182PStPSMXQT6d2
         5nfJooRJ3gYGmPoIXl+rOvsDK6W5Ys22gLupIDhsBLpFSKbgt27FZba6SnG5lmQYYnHy
         6MgMTIh2qCzp8TFF0yNZj62WyrZrp6eYLr7+agac9rIsfOeaCIQgbaGnvL3HkO2qeNMc
         1qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh+BttHshTvqwVfMkHR/OJvGZDmWyNUQNSwogcN12jI=;
        b=04cw+VBs6gDp7+bKQFrx36bPljKZJjga9ZuDg+29kXbRLwVmrtXq+6vI+77g1rzZCq
         1ZStQ5uDVuFdhoB9rANXbptmUj33KkLyUNwFd3eL9W6fLwJQAjR3cE+BVYDwh7d6uu77
         plVu2f8ymVXZXIZbGweBY5IAT1sC64lyGDzvfTGoGcFjc8stRPdaLu4j+EOc2IjcIdZ0
         hX5GC8M0zZ/nGsei00J1/+7REm/HXjp4BUlkj6G2BJa6vPzYNtq+c1xT5Q1+e1opxu22
         66TYxwqzwSZnubyNIefSkaQ7AwliNHEmS3T4DPnVl8KDyCgBdUEQmoMgOCN3w6KbYrrr
         uQAA==
X-Gm-Message-State: AO0yUKVXh6t2+KBS5Tmcb52EPCQfVpaUYstusfCJhUykqwBRbM7A9vj0
        QHIU4WWGifLvEfCU952rfwWJ7GWm7+a7sq5V
X-Google-Smtp-Source: AK7set+U0oWmsLzOC6Wyg2iH/NpVV8Td/9IjuerrNEU8eAfO3O1xFO2g9XLO9KPaJo27WpX+EyH3Lg==
X-Received: by 2002:a1c:4c19:0:b0:3dc:5342:9f53 with SMTP id z25-20020a1c4c19000000b003dc53429f53mr11821146wmf.38.1675188393663;
        Tue, 31 Jan 2023 10:06:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm16145460wmp.22.2023.01.31.10.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:06:33 -0800 (PST)
Message-ID: <ecfd20e4-905a-3ce3-86af-c9d9ad0cfd94@linaro.org>
Date:   Tue, 31 Jan 2023 19:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro
 (xiaomi-elish)
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230131123515.833-1-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131123515.833-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 13:35, Jianhua Lu wrote:
> Add a compatible for Xiaomi Mi Pad 5 Pro.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> No changes in v4
> 
> Changes in v3:
>   - Pick up Krzysztof's A-b

Where is it?

Best regards,
Krzysztof

