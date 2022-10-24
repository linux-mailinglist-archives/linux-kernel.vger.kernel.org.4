Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1B60AAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiJXNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiJXNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:35:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436495FC03
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:35:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t25so5944849qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVYj3QCBceIQ1q0wupJzLP0eSYUUbr2KRyu/kK2/7zc=;
        b=G0DWAFKOqyqQFdFIXlj6kLBpRnL5JYzlLp0E6WVy4pls3/6j1AeLtxzxBZ+jhLV++/
         PxHwC8uWse4I21Ym1lUCctWJicItZ9iEVOYX8Zcr9KIfD34MRXA+/Po28atn5QAX6ZNy
         k0v0iZYVXFg+8BTYHuXTpqhOYFcbX2bEFUF5ZlIPXjXBnibhTJnVqr8Xf0zyHHEoUwMk
         BuPuwWFDZdb7LxzX9D/z4tHwdMqfwK8ojwOnJJ9APk1xpHu9coKLCb2z+3XGXdrbx4gD
         6cS65pGdMJEyUJ+/nb33LGpxrL9SaqhVoD30uprXtaUUNXFTopDYnugtpAsxcLkQNqcU
         qAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVYj3QCBceIQ1q0wupJzLP0eSYUUbr2KRyu/kK2/7zc=;
        b=jsISHQhbyyGMSW9Hl38HvHPBpdZenhBqPfeRdSh3L3I+XdulOwBT4hJBri/A0MJApM
         ANG1rkGqk8iQbY80xjDki7vA0WiTQdqPj5rlUBKYL9LodeyfN5GIEcgqqW/oKgadrOZ6
         wkgDzZftr90SQ1U6T2Tc2v1a9CIe7e2wtkGlhL7T+4GrYZA3a+IjMLZoasPEn19v/P3l
         hIKqzN6b7rOnAO1v3XTdF0Pzok/1LwkmejcbGL+9fvXE1yAeyH32MBmtGfp5lIsVKufV
         drw6d2Txr7LdxVhSeNM0pmQuQoPjE0nO8KurkkcpOBnATlbbvKmuuuPZj2QZfHTR7t2p
         wllA==
X-Gm-Message-State: ACrzQf2FnLOfXeWK13dsDRAGrMlPXKJC7urKphf1MN5TJaPwXm3gl2X8
        +XoVxOQcMwTLzRL6jHjRBwLSUlUTNlo+7A==
X-Google-Smtp-Source: AMsMyM6WG2RrPBdlHGOnuUF5Zn/OxURzRJxpLn8hbsfkyCG52+3lz7p0PbPJNXd2mLDYhFv1n98JaA==
X-Received: by 2002:a05:620a:22cc:b0:6ee:3e43:ac40 with SMTP id o12-20020a05620a22cc00b006ee3e43ac40mr22841775qki.454.1666614323567;
        Mon, 24 Oct 2022 05:25:23 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id f4-20020ac84984000000b00398426e706fsm12571885qtq.65.2022.10.24.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:25:23 -0700 (PDT)
Message-ID: <41060ee4-0103-3c09-632b-81af396c0a06@linaro.org>
Date:   Mon, 24 Oct 2022 08:25:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 01/21] ARM: s3c: remove all s3c24xx support
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        Christer Weinigel <christer@weinigel.se>,
        Guillaume GOURAT <guillaume.gourat@nexvision.tv>,
        Heiko Stuebner <heiko@sntech.de>,
        openmoko-kernel@lists.openmoko.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The platform was deprecated in commit 6a5e69c7ddea ("ARM: s3c: mark
> as deprecated and schedule removal") and can be removed. This includes
> all files that are exclusively for s3c24xx and not shared with s3c64xx,
> as well as the glue logic in Kconfig and the maintainer file entries.
> 
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Christer Weinigel <christer@weinigel.se>
> Cc: Guillaume GOURAT <guillaume.gourat@nexvision.tv>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: openmoko-kernel@lists.openmoko.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

