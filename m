Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7932C5F7822
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJGMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:43:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A4CA890;
        Fri,  7 Oct 2022 05:43:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b2so11080366eja.6;
        Fri, 07 Oct 2022 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0tzMj8HZWZ88Pvlv1sPYkG81c5uF1cjDyqGb2ZsiQk=;
        b=RFskFc9lenVJPeQ1UbCk4NriqcIUAGWTaqrqkecrY73Sk7sGMyvtAxthwMY0hYEwNX
         EbwFjRHdP3H23BIU8BKWFAImB++mw7TONsldnubK2Lse9Jv3BQQMzR1OKja3nhWYqE9G
         nM0H5zyLJuJ35IabxHPgayUZgF1Lswxv91ptsyQNRML6ptBbmQ3PUcWscCNK7lKqlp/v
         x/F1Bm9W/fp6fzc7xftQQznGx/gmz6Fm22s7+++JrtqdhT1u9MEquKgTgnUhCi1yJeUh
         MUXPEB2J2tk4tZYRXArveRvP2L0dkT10+WybmwNESUGeWpNcaIdDzzfv4shEIzfi9wWW
         hivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0tzMj8HZWZ88Pvlv1sPYkG81c5uF1cjDyqGb2ZsiQk=;
        b=jptZiRW2NbYgB9mq97wg2h+SZUBN9J41jn/Sw+Pt0I3xYaAJYMccFa2YaRqCnVgXKJ
         pjBz4cd8hRj72pY5Ew/GZlH/2UqZiCL9ahzSlYFgEJbStxhqudaYyrmpxGakjKwfwLny
         +UjcxUChlotypJn5kjmqFNZcBX0PwwxWfHCDhf/j7r7LMbtCy1isLMOs5UM74gnTS7ZA
         1AboF1/bMjXdRt1a6X7EvUzIFtmjNcl/xSsSdaxG7XXeSHoWvxUuJeiLUqpKLjx5n7fA
         axcSSboRl73nh4gexXj5Pc+GOpmxRbHjQvExKpXo17hX46gze5Hxm+io26i+r+FS3sGF
         s0Cg==
X-Gm-Message-State: ACrzQf3DQmB5b36TRN6Uei3N9nJUh4Bv/tYus2GbNmOWVo5pl/uPNynB
        Kkw3mDM6NWkgw34d0/z/0rE=
X-Google-Smtp-Source: AMsMyM6Dtsj6UDrj1l9WTDelpdwpLjj6rLKnsvySBaZ4BfN3keNpmQdH+U6zZBANuFGitZA31R5J1g==
X-Received: by 2002:a17:906:ee89:b0:73d:70c5:1a4e with SMTP id wt9-20020a170906ee8900b0073d70c51a4emr3767197ejb.683.1665146627297;
        Fri, 07 Oct 2022 05:43:47 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b00738467f743dsm1209601ejc.5.2022.10.07.05.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:43:46 -0700 (PDT)
Message-ID: <b30ce02b-ae60-4841-6a04-46eae019e41e@gmail.com>
Date:   Fri, 7 Oct 2022 15:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/34] dt-bindings: pinctrl: qcom,sm6115: use common TLMM
 schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-7-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <20221006140637.246665-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/22 17:06, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>
