Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5A6E3B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDPSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDPSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:31:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF4213D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:31:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud9so58420553ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681669867; x=1684261867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlSBR/ShimGduJqFPI5aceEu54uJPlimp53JoHD6PME=;
        b=yFv2QCH3hdQbx8P4vVE9YZ6FaDSEmZtc0t1GxIAa1LajI3B1pOfGVqFOiJKTbaMMT3
         mEEzH5DJ+XWhjKg30hTxyGqyVmZ61OxMMNxwzfYvCglBLb4qLiCEvvcgENB8A67A2GDN
         zEJBPifwHT00k4boYDIlWdJubiETWr/nzLWn9tyIAvnBIka5+nei0TUt+Aq4fQMhtuOy
         YVm82apquBqlN3MKcfzagkW+BYtOYlN32x5sRUKZqzSCrnsnzZ6lWvm/GMPScUKSxxzZ
         nQmS/sbEFZGNY/TxoFfEgYxnSiYxx8JTlwkqtGSucta2THKSeajuJymxMUstaYsp6zKJ
         Kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669867; x=1684261867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlSBR/ShimGduJqFPI5aceEu54uJPlimp53JoHD6PME=;
        b=c4Ip7QP6UVD++pO2u8xpZJMPk0pi2XTa7FBAuNRWgXfHjjiUxzB2kQpE7aHHncxBlF
         tLE0LxjvaMwtRzGdsUvq3YOBTT1ogKCmNcLliXThNSD626tnzd3MdqFnVq+GgvKu9bwx
         EndK4tzaG4s7ZYqK4peFgUppuIqxbjJVe+Gbi6YAEm8b8CmMRJDYmbCpx8T36cCHvL9l
         UlIEAQYbaLnzmzxmE0tCo6XrnlzIjXEOm/kUxtr9FAzprZHZjXeQ2nVWyDjBWA+1/1RC
         +PawltRmsJW2SiN5Z+gXWMstr6gu739WHHktK1u6zlq3BYydwTaO8KJ6ryVLES/4ldKi
         KsIw==
X-Gm-Message-State: AAQBX9frS3gzt4JPbKohsVQfJ2E5tXL6aMAXkO+LVHF3YvvFvTN6rDyf
        yh5/3cPVBEilDaQtIuB+7liUwA==
X-Google-Smtp-Source: AKy350YW7KeEJrlhpMsn0KWhTkUJxdnRtKPEFgnpdqTcJQnTkS+JAd/5gtmkuKjD2e622LFsZTZUzQ==
X-Received: by 2002:a17:907:c018:b0:94f:6025:be53 with SMTP id ss24-20020a170907c01800b0094f6025be53mr1731474ejc.50.1681669867471;
        Sun, 16 Apr 2023 11:31:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id gv35-20020a1709072be300b0094f07545d43sm2896853ejc.188.2023.04.16.11.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:31:06 -0700 (PDT)
Message-ID: <dcaf82c5-8fc6-68fd-c087-8d55def90ea0@linaro.org>
Date:   Sun, 16 Apr 2023 20:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add gate-clock
Content-Language: en-US
To:     Yangfl <mmyangfl@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230416173302.1185683-1-mmyangfl@gmail.com>
 <20230416173302.1185683-4-mmyangfl@gmail.com>
 <8b3ea617-8d4e-cf0b-1cb2-d02405c39487@linaro.org>
 <CAAXyoMPcmbUGDpM6YAyJqGaXvgg2rQOCSdGGnaVQoGd5OE4OwA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAXyoMPcmbUGDpM6YAyJqGaXvgg2rQOCSdGGnaVQoGd5OE4OwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 20:28, Yangfl wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2023年4月17日周一 01:41写道：
>>
>> Did you test the changes?
> 
> I don't know what "test" is here. make dt_binding_check passed and it
> can work with the driver.

I don't think so. If you tested it, for sure you would see warnings like
"node has a unit name, but no reg or ranges property".

Best regards,
Krzysztof

