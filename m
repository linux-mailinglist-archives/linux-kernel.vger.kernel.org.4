Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56707606C33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJTXtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:49:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628822BCA5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:48:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w3so667600qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dS4hfR02qYvZB7Bb4tWiMTB/anhTb33LWwxclEsGY9s=;
        b=QZEXQJrkx0aGBjrJxXsZtxUUyvmfrDEweLua3bGpr/JVKyHtPw/boNLjfeJYSbwKq4
         sLnrD3QEDechFmVVSEtwxYavPfZXjs7zaH7QfuHbqgZWh3gvFMUOPbyIAokJ0S95i4la
         4CiRevpgbA4ssTCVUiM1eu9SdClg1tCxnrwqrXvzZjmkC6NdsFLAMI7AB2S8892x31Iy
         tHbI/lqjQ7z4/Q9K0FpFxmH2HZlY0Yb9fNDMove1CUUdbeL4oTgz6hV2LXQ+RFWfeaV8
         CgTCaBwhJfFymoyebmqf4x0HcMwuvlNXsyj4a9t5AaXIztRZ4RG6YfNIS+Wf6hVYZp5R
         herA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS4hfR02qYvZB7Bb4tWiMTB/anhTb33LWwxclEsGY9s=;
        b=HDtdsvT5QWsN/18OO23H82la6elyQvUtmJowEbb6IW3AwWsPMn7CKM0dkJWbyrg6hK
         UmhZBUy6OnON3uWzbTkTDQhE2rgTGHVE4WVYqYtabwb9IHS3MsRp9QifGiZyTpbJXgul
         AlGC6wrMZNF0znIAaHoDQGdQmba7RAQ5rBQpLiZnGAhVlVJ4QS+OQ+SmEbSBsnZywQTN
         jRv609tmhSfHh3PWu0ySojklpXjCUvAhL1dynZ4eEUHpgfGcwkCO+X8p4dQFsou2ew+P
         ryymAfkJAnKohslhDvu6n3V0P0fXrKwftuVLtwyORw6iYt18stdOLSEhY18evMv4WL+6
         IANg==
X-Gm-Message-State: ACrzQf19mG9yVg7izpBcGUr8aXNSiNHTRsvhzkCO72uxXLp74VZy2dbv
        v80Hyma8WtJodIMPDCuxKgwDgw==
X-Google-Smtp-Source: AMsMyM7bLLmc20dhGG4wWgl3HNX5yVnbBe4VbwxcNqPfNyOUUhokOfcn/MNCkjLrugngsleWYJGT0A==
X-Received: by 2002:a05:622a:13c8:b0:39c:c0aa:cdfa with SMTP id p8-20020a05622a13c800b0039cc0aacdfamr13569388qtk.251.1666309738691;
        Thu, 20 Oct 2022 16:48:58 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006ceb933a9fesm8198894qkk.81.2022.10.20.16.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 16:48:58 -0700 (PDT)
Message-ID: <3d1fed2d-5e98-6c90-7911-c3d2b1f1eeed@linaro.org>
Date:   Thu, 20 Oct 2022 19:48:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [net-next 2/2] dt-bindings: net: adin1110: Document reset
Content-Language: en-US
To:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20221019171314.86325-1-alexandru.tachici@analog.com>
 <20221019171314.86325-2-alexandru.tachici@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019171314.86325-2-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 13:13, Alexandru Tachici wrote:
> Document GPIO for HW reset.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

