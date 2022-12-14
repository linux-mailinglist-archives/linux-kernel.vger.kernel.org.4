Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD464C8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiLNMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbiLNMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:15:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4D10561
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:12:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p36so10069070lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7gGUfh2O1aqJ7sW1TLKX2uP463SCCE2U57Ix3rcUfQ=;
        b=oAG6h9k4jk0Hp0FaX9xRgI4P1DopwgfpEKtQ6njn/nbSOZ56xqJqdoXq817WHwlhzt
         R3MSk28vvXBDwW2sDyjNVXquwV9dIl+y6BNim7DEsFiN6FDVrg/5Vetv6IUUWnIUErx4
         D7Wx+fU9YzP8UccVasGnxCa9K6m9LbsTCSgn9XagwrtcJBhD9a1is1+A+uPXiLroWvdY
         qjeK+yZCFsxtxDOZr2J1Nzb5smm568Ip/xTTdAE7+6jsbkFfvc+i9JDZC9v/88pU+Sq7
         35LyxeW9dUAewe1p4UrBqwDs14eYTuLh53WmKjS/WLuFx9jzOsYKhJmH0ypL0kbfwnfs
         WnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7gGUfh2O1aqJ7sW1TLKX2uP463SCCE2U57Ix3rcUfQ=;
        b=EcsJQroN0xkrSFWGVdgeRiOyM64IPSyhvDB9k5A7mpkYqBY1+BmPvNBQ6cNgPJfwvp
         Qwa1MwqwR7usrEpAFCqEVevmdYTyJ+NXP6s8Ep/P1go19VRLvj0zRSOCLxPaBopu1xyj
         OKKEOhUbDSaSFC5Vbw3TW+Tzz/s8DlH9Cr2k+oRjjSS7EJeu8IsAZfthQukQ5n2/2DRP
         qjv62hM/bC33SS83MJXfW3kpFB0wJ1jble8mhxbnhwC9CCNstcvaSI6+MV7VV4Qhs/1B
         j1KweFFtU8oSuYPXU5qCQIasvyBHwjCNHDwpzJEGG/YL0ppkVIt+2jM84TP4+xQO4QvR
         zwyQ==
X-Gm-Message-State: ANoB5pmyoUjgRuN+M8JZ80Epkrm1r3aT2LzDI1FYQ5P/ch4SJerXPfT/
        BKIYJpe0ySeDY0jZOrVBb0KI0odRwTlarZY0
X-Google-Smtp-Source: AA0mqf7Da8bI7Ev81iQh1HoIJjwtR0hoABWj+ptiggsjMehEf7+u+hBLKkO76qG17BETGA44ywHZbg==
X-Received: by 2002:a05:6512:2111:b0:4b5:6163:b677 with SMTP id q17-20020a056512211100b004b56163b677mr5472085lfr.38.1671019921303;
        Wed, 14 Dec 2022 04:12:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t2-20020ac243a2000000b004b56d00b2d1sm782820lfl.285.2022.12.14.04.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:12:00 -0800 (PST)
Message-ID: <10917f98-4cc2-1d5c-4352-4cb3bf2ad52d@linaro.org>
Date:   Wed, 14 Dec 2022 13:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/17] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-11-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-11-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the SoC-glue logic implemented on
> Socionext Uniphier SoCs.
> 
> This SoC-glue logic is a set of miscellaneous function registers
> handling signals for specific devices outside system components,
> and also has multiple functions such as I/O pinmux, usb-phy, debug,
> clock-mux for a specific SoC, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

