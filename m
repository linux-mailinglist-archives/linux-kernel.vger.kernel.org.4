Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052706FE026
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjEJO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbjEJO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:27:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB04214
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:27:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so10946371a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728824; x=1686320824;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5fqs9Y81ig3TpwIrDEGqHqhJO5UVO6aYGC8XalYxes=;
        b=xH7fsAxQmiOMEPwPdPPTVNCnDQW2EVH6Jk9bva0QjqcRfboxKPc+DXuYeedLV41s5v
         Tzny/MXflkypr1NmOwJOm+VSY6hjqfP8KeD/3Xbjfz3cIVQnFwDas7GsWLV0BarVRZ3y
         FqGmviBpRee3SIf0k4ZW2rNxe5rNYDo9BY/Gru7AEuZZcKzPeuUllvws7yiacaJSD+M5
         CdRR3zTqi6UTQ3Fn+QXYd1iLFJ2bLZp/I8+IqBNEnM2WjcOcFWFLxJklG6LjXfkGa1SF
         Qh9cRpjOaeaZtiO2hBhKAaSP/8uQoot6WwG7kkJy+A3DNqHcSpkb2/yfpCL2uUbc7Ho9
         Qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728824; x=1686320824;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5fqs9Y81ig3TpwIrDEGqHqhJO5UVO6aYGC8XalYxes=;
        b=kO5a90kZV8WLkcceXXOxznKHpOMNScQOtDgs03W6yx+tP1OmCOzupDyMwy4vZsEHhP
         I3cAEB3nHi2mq1qrhho0fEnEvDew8sjncVY3rbw8Lxj9u8I3ljyoPCfr8GHKArVkkcNv
         XAZkZkYgiz7/E52Exa7V2dsI09pwNTKKUHivf4ZHeMbUBeSG2gpUt6y7FueP7r4Wh+ay
         13pMnh+Hgl1HIndXj9dwjMXsjzEnGKKVoiIUqalhvhGw1zjF5JtFGYiERpnzHUawjZuo
         Z1bt3B6UdnVW7s5MNlEq8c6Q0YISfJ/8Jz3HyTyxVRC9mtc0cohJi6MwMcYPu09NIaC0
         1W7w==
X-Gm-Message-State: AC+VfDxtMF57d3ji3iGfNk8jCxvVE8/6zJgXWxWexwe1OuWwHgSkCF6o
        MuH3KoR/2MuDsDaDJm3okxio1A==
X-Google-Smtp-Source: ACHHUZ4eGNGOFkcqZsv2DkqHDoiknTmiRfn50NcREBtwsSikvNTtdlm/miXdxBddhhEuDHXs+wkbNg==
X-Received: by 2002:aa7:d593:0:b0:50b:cd19:7545 with SMTP id r19-20020aa7d593000000b0050bcd197545mr12095722edq.33.1683728824599;
        Wed, 10 May 2023 07:27:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id r9-20020a056402018900b0050dab547fc6sm1967824edv.74.2023.05.10.07.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:27:04 -0700 (PDT)
Message-ID: <0b75ca9e-2370-bce4-f7dc-c90b8332bb53@linaro.org>
Date:   Wed, 10 May 2023 16:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/8] dt-bindings: qcom: Add ipq5018 bindings
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
 <20230510134121.1232286-6-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510134121.1232286-6-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 15:41, Sricharan Ramabadhran wrote:
> Document the new ipq5018 SOC/board device tree bindings.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v4] Checked '0' schema warnings.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

