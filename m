Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F5369E3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjBUPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjBUPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:46:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3026850
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:46:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g1so18695194edz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u16sfEdS2C/gTVXZRyQ3AT0mcBQxN7EzKfbEW8hZNRA=;
        b=BImcg4PHyrzRx7lCTqf17yE5wSlAMdBynlScZGJeNdipmeN1vlB4yMRgwWSXDbwqDb
         pWjKEh33GMJDsuZacvmd3Tu403UfE5Lx1653W3pCEwxLkkw1pgWKivJHruAnY38+CJVP
         N3V2JcoS7jZeYtUl2saeDyxvgCxhkmCe72Gz1fJdP2d8N/LWjH1opybZFqQxbqNsiC6V
         ReH8zdTqjbFIGshx1lf+0ZH7CzSo/IQzG2DOgQhtaV80dGfFQUSAoBEp93p/8GxaKjbs
         m566h8ym4WhqEwWs6dV0LKcH0e3WvvO7gpcF7xAQ8xdmF+V8U8XxE5vMKLeLKfJWQPuw
         EW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u16sfEdS2C/gTVXZRyQ3AT0mcBQxN7EzKfbEW8hZNRA=;
        b=Mk7ZH8yUy9myzvzH0v48oDxLXuUJ6zlfx3JJqI4P892A1+4CRI0jzmcBv+pAbKSOYm
         XRvIICLKb5iJJ1WfwAaaWNUl7UVy5G+o7gakLlT6MyzI9TumSPeYXlRQY/l6VRbY4wOX
         hUOld8Far6eDJiuXfGUZALtsrJ6J2pyWFg5MLSjojFkIQLeAJrKahf0gDjq/8QwwnLF3
         epLzfEE4+LW3gvZwBGaOYQ3Oasl4xaUFxLggZhVYfcLTGLNHleseBQ84p0Rf9TS6N5MM
         XWh2WsaV+l17ktJlKHV0bbKxt/FbsY0I8Q9msuDvDjCLA6e4PnC2lMbIqKCk+hT5n+QN
         M87Q==
X-Gm-Message-State: AO0yUKVQ5Rt4oGxODF19Ee0pXHWLmouSQvQF5UewE37vqusL/DrYPgof
        72kQrz62dcu51vzpOedgVC+5nQ==
X-Google-Smtp-Source: AK7set949xxyApvw8v1lxUUydJ6o7tr/03eK8U2SeE8V8KCn7nyc0F3LMmjBD/d8CfKHsxfcMEt1/Q==
X-Received: by 2002:a05:6402:2b8c:b0:4a3:43c1:8441 with SMTP id fj12-20020a0564022b8c00b004a343c18441mr5441613edb.21.1676994387995;
        Tue, 21 Feb 2023 07:46:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id dv4-20020a170906b80400b008b904cb2bcdsm5244605ejb.11.2023.02.21.07.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 07:46:27 -0800 (PST)
Message-ID: <1459c825-d915-c55d-ad1d-4bc590e580a8@linaro.org>
Date:   Tue, 21 Feb 2023 16:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: add a compatible for
 sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230221150543.283487-1-brgl@bgdev.pl>
 <20230221150543.283487-2-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221150543.283487-2-brgl@bgdev.pl>
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

On 21/02/2023 16:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the compatible for the cpufreq engine present on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

