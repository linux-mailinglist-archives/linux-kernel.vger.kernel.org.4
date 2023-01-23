Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60835677F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjAWPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjAWPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:18:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54D2B2B3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:17:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so9280804wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oXHlh1GVe6XHIGjfxqBlGpday517k1tv+6ix4arA+Zg=;
        b=mTElaErKpyr/9+bfvnELgYwdkqnRrQO/qiv+5Uq27OCgDaLZ8aaksxAjd9sARIF4ia
         /MKEh6h6m5FSzyCivP3eglyAgdt3BzjqP26wkFUqzy2+/dG/8NmUZ9FlogJnpdCcldb2
         acKe0v4SIDaiXlfpQSpvIWPAs+IMm42n+sNx5ilNe2CRyMLhb+Qf8XUxMGpucgpCVr/5
         0xYCWc18aYTj2u9uyVm24v9OmlUdvlO9ti00jk7Cxckx4+EiBdL7LzF4JhLmGJ/0jnTk
         phGT5/FRGPYaX0W8aQOgkpWZLLlyatLsvD9LaqDBhKUfBRUYuNa/ewbjRDB8VrtWU+Az
         k2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXHlh1GVe6XHIGjfxqBlGpday517k1tv+6ix4arA+Zg=;
        b=1xKWIfB3nlfA3I1zxBN8tPNpn3fn+BryCOebFrKFBqKLRQJ7o0SaP19WqPuA/z9oDN
         xpNBp6EX6lAq0jfLrWOdrHcSQgKJZKS0qr+oCrhQ3TPhz0xgJGHokolfGkJCrXIi/9dc
         7b+h9oL67SiMj3Lqh3WmTqmxbbfJaghYjfSxUKxg3eRTCdHj9Xj79O1R/wewFawvdUS9
         PgSNrEh633y7jWmUcaZUT5P7n4e+ijVy+tbiwkugLasguI0tq+pslkDXja9Si9MAJbt+
         RYa0E1j2DVHnlowJrTcYzlL76nO2FvrQ2QSDEFS9Nm0/PHw6aA0tUZ6Vy3wJDCV3ikUs
         jldQ==
X-Gm-Message-State: AFqh2krnWMUXy4Dz42rnmiMpiQBb9PvsFOufwOqv4u6nZhjsZqF/T/5I
        xwC4qQKtJQ+W7xgWtUU995c6Cw==
X-Google-Smtp-Source: AMrXdXv4pjrlJCiDM72DBhh38Wa+y+wDQd0b3eQquuYXJF+qOVFv9nVUL1oHgw77dN4sbV8WLhp+iQ==
X-Received: by 2002:a05:600c:1e1d:b0:3cf:674a:aefe with SMTP id ay29-20020a05600c1e1d00b003cf674aaefemr24094598wmb.22.1674487004649;
        Mon, 23 Jan 2023 07:16:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:343d:5dc9:ee00? ([2a01:e0a:982:cbb0:b3d5:343d:5dc9:ee00])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm10449596wmp.15.2023.01.23.07.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:16:43 -0800 (PST)
Message-ID: <767eb8e4-fba7-e25b-bcd3-3f05db9a6d80@linaro.org>
Date:   Mon, 23 Jan 2023 16:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 01/13] dt-bindings: serial: amlogic,meson-uart: allow
 other serial properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:12, Krzysztof Kozlowski wrote:
> Reference common serial properties bindings to allow typical serial
> properties:
> 
>    meson-axg-jethome-jethub-j100.dtb: serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
