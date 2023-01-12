Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD6666D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjALJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbjALJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:08:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48454DA1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:03:19 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so43140366ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPg45aihulxFcwTt727w+mL/usKIND+jUszExCuHhXY=;
        b=MEKnkpY7fZaDBRZ0GOoGL+5J1rSvAP8tz+GM5LCiulO58ykRwW5361vjH5gxAeEoTv
         8HhjnXzMTuVGML79PFXQGwbgf5poVUiyY3JZQ/kxQKDoQDOgSFvZirbzNAoalx5RnAIo
         W837pnqEu6ErV/K5C/TSut+95htAA3jdC85im8RYpa2Mv6Wf8gigkXc66wQ3vp7EW9jG
         99CbxHCvE1P/wla42oE6rDpKSOx9JX2xV8TtbABTXNatIUem6GM68FEzT9TlJi46V4F5
         p4OAsmgHzFf9g/x76nO013ohi75SH8DxRI4ld+AMCZf9VNCU4qQSAPS7K1ju3MGQsRPN
         surw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPg45aihulxFcwTt727w+mL/usKIND+jUszExCuHhXY=;
        b=YCKwCox1pS4Ok0Dvsgorm9tUW6kDZvCChnMbwh4G0AisXuBpyF7fgr/sCh3n1XjK17
         ZurLxD9Jvjluo4SeQBwqFmsfreJvuBiUIgkITDXGV2tUP444m7wCJMOnSbz0FaYo2Jj3
         1tqApncJ9eYGouWusur8uYxOEq5spsfdmd7ceCQnIwrSuk9lQqzLfl2UR6ctaDKUn0ZV
         JvoVm/V1ZEzhDl0KejH0RWyTKHerBHkuNbC9HV+3o+vdFnZaPfQE680xGVwlCjVS68+n
         bdxAo2a0MXcYy+8yhSdoWNs70YdY+5KnxSQyPPbU/9aJ9vRqmXtqZkjKjzla2juXSnxo
         9tdw==
X-Gm-Message-State: AFqh2koHQK1ryHN0EeYt82e/h6D328mAnPjB5AvaF/NiZ/F9qc41e7nM
        6DIWOHE3TYzp64ZDjZJFs0uynw==
X-Google-Smtp-Source: AMrXdXvzRX9flDjGK/8oJ+WqOQPVMaaniUk/Te2rCqcHpO/BoL8tDSkKBKpzsxbv6klDJbEcUyLzaA==
X-Received: by 2002:a17:906:1655:b0:7b5:73aa:9984 with SMTP id n21-20020a170906165500b007b573aa9984mr60091934ejd.14.1673514199160;
        Thu, 12 Jan 2023 01:03:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007933047f923sm7202212ejn.118.2023.01.12.01.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:03:18 -0800 (PST)
Message-ID: <21a5fc20-05d7-5d96-aa75-bc335835033c@linaro.org>
Date:   Thu, 12 Jan 2023 10:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: rt3883: add proper function
 muxing binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com
References: <20221231160849.40544-1-arinc.unal@arinc9.com>
 <20221231160849.40544-7-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231160849.40544-7-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 17:08, Arınç ÜNAL wrote:
> Not every function can be muxed to a group. Add proper binding which
> documents which function can be muxed to a group or set of groups.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

