Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118E5F9CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiJJKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiJJKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:37:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FB5D0D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:37:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so1290490qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sERisia4dOvqdIZgNN2ucvL5g52X/Jzu/XrvgNDyvfY=;
        b=WhtbZ6oXgaR8sheD9Wo1GZX9UYFI3NmjKyxthJaE2wfq9bR+kWObYV0DJPkv/0tSw/
         9dc8hmeXhzfnxRGZ/YhNb3fC2hs/iiZi2nW2SOBOeH9sxi8T2IwFwMZLv1IFQDQjVGkN
         wRZKWPeUkXWbTD9SkEj3YONitkaa39E0dM7H9oea7Nrx8+RuZptpTeOEl4b6gtq1idZ5
         UtpwJSUS81KczbywYEiUL2NtIDs/TExpiq5FupuCErkzmju5Hh7t7GAjG5faJxnBWuS6
         l2OJcRdxbXRp76RhfvB+5vRxkkDPcReqCONhzzCeXa2epz3n12OtC3jaVngp/hbb9JYa
         28Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sERisia4dOvqdIZgNN2ucvL5g52X/Jzu/XrvgNDyvfY=;
        b=rrOn8lpYlwI/WotBvF8hzMSaUomaXAzCqvZrE/Yr7pOBB0XbTY/t0MgtrO1aqZm6gJ
         AzVmJa+KiJ1B5zPZGzpXkkyz1S9LkLz6jcDt2Q7rU4DDOSpBSaF7CYhsidy26BhctDLd
         Y6nIuNb4VJIOe/81oGT3emuDLTX0VmU4wUuEE2z2/b8kKuI1CNS3E164XRhAULJbwOXx
         +5TUZ+av/kj8r9RZl/0ohFOoqJT/gglh2WxfQhcNCH7HqpCHPdjlbqlgIz4ZJk9+r0ac
         203IkfgjheKG+qLmzzerZmKiWMtqlw326YWmCqnhzyeltvjimU6D4f9aywHE8bR2VhnV
         OiCQ==
X-Gm-Message-State: ACrzQf216AaZMHz765nt0pb7l0n5wXI9K8DQNIElOD9wXPxg0mtdk/lT
        vmorUoOx03NeKoK95soaO/UpSg==
X-Google-Smtp-Source: AMsMyM4AdU991qDfue9VsxlaLwIDkrmZugBsKf9PFMKPLoH0OD37ufAFmjGKjov8Z26JoyMpspuE7A==
X-Received: by 2002:a05:620a:4454:b0:6ce:bfbf:7e3f with SMTP id w20-20020a05620a445400b006cebfbf7e3fmr12228021qkp.748.1665398269085;
        Mon, 10 Oct 2022 03:37:49 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id t28-20020a37ea1c000000b006cdd0939ffbsm9884769qkj.86.2022.10.10.03.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:37:48 -0700 (PDT)
Message-ID: <c485b780-6b66-0072-6805-f68638f3cb88@linaro.org>
Date:   Mon, 10 Oct 2022 06:35:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: power: gpcv2: add power-domains property
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        ulf.hansson@linaro.org, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20221010100958.290307-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010100958.290307-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 06:09, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some pgc power-domain requires a parent power domain, so
> add an optional power-domains property, otherwise there will be
> dt check warning:
> gpc@303a0000: pgc:power-domain@1: 'power-domains' does not match
> any of the regexes: 'pinctrl-[0-9]+'
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

