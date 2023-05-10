Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3145B6FE021
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjEJO1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjEJO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:26:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8339007
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:26:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so13589473a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728795; x=1686320795;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIQPhYtqBosQVm2m9V/olCqkEptW6QZ61h/6KfT0E4k=;
        b=FHQ3FpJPwOTUgYBnspviACSV7j5Qj4QMDvrXoB9NFtLLxIoyqracPXEhrsSUsP4D0E
         4aKktP8YVVG5JhxiCCfdVrQaShEqAcyXRQ9RcoVOc3poxEDFKSg+h+9xHlWu6VIRy3U0
         cM/H/4NdAFELm8sAggm9C3c8ucfzXdqTKXXtpSTwjJRBu5z++GIzO6q7VcJLOkVWOQue
         MYfuMBHwBoZ5kdsCTV3aWyEjqKbkCU/pqgMzU5myPufPVF4123aXsm+imIbMp55CYMgz
         F7CeZX2KJVZl1fs0OeauaTs1l/Emg8RznE+gsrwZoMy1+1gVx9bLi3SWjzmdaQpVlZsU
         J7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728795; x=1686320795;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIQPhYtqBosQVm2m9V/olCqkEptW6QZ61h/6KfT0E4k=;
        b=Wz5nVUAKalWncKWAdgi3K3qbjvgIRWzzekq1isTbaFPRorBnni/4ZToUnqywTRiX86
         vXNHD84BOiv5Dh92LXcOUosHZdoRJXM9giU9vmAiDTc+DjiHK5d5GxpylQj/u5tTMntC
         6VoYShUNn0+Cfvp6Kd3rx/xjf0zHCgg0XOnwyLwUBEpPsfFcLwHzHbYC/yEwqFv3c978
         gKjzJahpZnkFjsZiNDqo9BFu5mkeydwQGT2H7lLkhuolDzjvhLv/Z9dVXjjoxJbce61+
         w50NaPXvRhdDv3WwelFF+GbhLir/Z5/L9OscTkGtjj6NjdrCfxv12bf8/C8xd3k60a+6
         JrvA==
X-Gm-Message-State: AC+VfDwW9r4hfphKZNM9FYYerRzycOdnloe56GtWTaiS2AEanYM2+IhP
        ufrZTY/ZYytx7p/+myWQsM2uaw==
X-Google-Smtp-Source: ACHHUZ4kFwEQKZh206/3VwiwKyEUVQRybitZ/IwLHqaBtdLRuItDunzkv8CU95Is7HHu9KPxG20ujw==
X-Received: by 2002:aa7:c0d7:0:b0:50b:d53d:7ceb with SMTP id j23-20020aa7c0d7000000b0050bd53d7cebmr12915261edp.40.1683728795357;
        Wed, 10 May 2023 07:26:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id ay20-20020a056402203400b00502689a06b2sm1911779edb.91.2023.05.10.07.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:26:34 -0700 (PDT)
Message-ID: <51a332f3-10ec-4fac-971b-4dfd16d018eb@linaro.org>
Date:   Wed, 10 May 2023 16:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/8] dt-bindings: pinctrl: qcom: Add support for
 ipq5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-4-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510134121.1232286-4-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 15:41, Sricharan Ramabadhran wrote:
> Add device tree binding Documentation details for ipq5018
> pinctrl driver.
> 
> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v4] Fixed all comments from Krzysztof Kozlowski


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

