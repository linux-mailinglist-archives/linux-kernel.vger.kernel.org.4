Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAB6E3FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDQG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDQG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:27:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233E1737
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:27:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u3so9256287ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681712869; x=1684304869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZhVlgtCkjykFI3362iDf9ok4Q5/L8endAPoD1oRjnA=;
        b=M/BBDRVpq3Qz72h/QrsYFZirctpqQXzcx+UgExn33c7UpLcFYy35fbnujNlg9pkU/5
         6pEDbn8Y181Ip/HsSf7GzIv4IQhozyoy09kqc/5W7ZO5cnenowtlNX0nbyPdQu/ntJjd
         Jov/jpScYqmJeaxx15U1pxxrYRDPaGg6j2C21eJZVadFB4CWGOHcojR0sH6wOroqxYwa
         QTi9zN1gRhGzUBuX8lBi8ZucfXIiKrM0FZQkIczMyJi2Q5VS9lHYuQf++1q5fALpw2ig
         mzRtmUzIsZFFqzSafVlAN03QRrb0YUFUQqygCMETq7sO25321HM9g4RolIpoOyrRczyC
         rqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712869; x=1684304869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZhVlgtCkjykFI3362iDf9ok4Q5/L8endAPoD1oRjnA=;
        b=QoeKdNa+C9OxwLnM7wvmEjpT2OAbP6VpHiq/KJKSdId7R4zNsCUrylAwhvgAoshcGZ
         S618PzBbTosLfmjhrqY6QN1RkxK4ufphsu+6OHmU4m1HaSIx+Me93JjIjg8U4MfGBmzg
         kqm4PU29kAmq4P0Tm6rYXzsc2uhjeus4cMEVwIVPOdc5YBRR3i4mNOs+O80XMR5yOirB
         e/PiOIlAOUt2MJOZWlvJdfbecu6TwAM+XOitr9OPSyzZHVZoRiOUoznUI/j4qN+30Jfp
         gHgU4EEazKBclfxZ9jjQTV4HB/uQdMQuKwUOjSZ98Hsic86bO9LPKX7nI6Q764pbaCFH
         0Zgg==
X-Gm-Message-State: AAQBX9etZ11FIwjlroifKW1euX4qtuWabZ5TbK6D+4HyngoeDSdXIVQ7
        GDpql87mGDJO4gy4/YH9rCT6zw==
X-Google-Smtp-Source: AKy350aPF7fJyzUSSHBpxDjT4g8JZpxv5eabpBr8r+cEIjDDIZKYZt6rMjGs/0wqSq7MNs1NhofUsw==
X-Received: by 2002:a17:906:53d1:b0:932:20a5:5b with SMTP id p17-20020a17090653d100b0093220a5005bmr5762356ejo.23.1681712868963;
        Sun, 16 Apr 2023 23:27:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061d5a00b0094e44899367sm6057778ejh.101.2023.04.16.23.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:27:48 -0700 (PDT)
Message-ID: <81ed4e15-19ea-34d9-3e05-d1195b2cdd57@linaro.org>
Date:   Mon, 17 Apr 2023 08:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/4] clk: Add basic register clock controller
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416194624.1258860-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 21:46, David Yang wrote:
> These clocks were provided in `include/linux/clk-provider.h`, but lacks DT
> bindings. Add DT bindings for them.
> 
> v2: split clock controller and its clocks

I gave you several comments on v1 and this vague changelog entry
suggests you ignored all of it.

Implement feedback and respond to each one that you ack it or disagree
with it.


Best regards,
Krzysztof

