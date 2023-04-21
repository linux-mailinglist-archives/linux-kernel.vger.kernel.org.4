Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DE6EA51D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjDUHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDUHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:43:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778AA86BA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:43:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f3cd32799so217087466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682062995; x=1684654995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQ6tUNbQr0gBTZA8iuY2w84kK0dZFD9Zeb92jq9bHGQ=;
        b=ul4pLogaDSm78AOEkl8Y4mu/tlwH26o5ejyYE/ug97QoM6QB3I1ofVBePog+mssOKO
         5Bgu2Y/pG1i04Mt3a3g1HFK8K0A4+CIcPIHzzxggbu6reKbeSmfxwDvNG8CNOir8mpYJ
         MePMlIsvW09b5Gdbujr/ViLA6R2JD2/7EnXAQOGDQnLWHRUP9c6h7aWOdjxhRXnjnzQ+
         InYdNxfoC5cEql5U1FW8vBF4Tt6Fj944dSnrZC8LJwn6yZjQugUWwkTKeLGGaHBkqh3k
         hByyxBFLjAl72vQuSo2+bi/zkbZg0Oq2OvqAEcVkJLolDiDhR3QE5EcXIZvoTizgqBHi
         Tvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062995; x=1684654995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ6tUNbQr0gBTZA8iuY2w84kK0dZFD9Zeb92jq9bHGQ=;
        b=lYKVR7AT9I+B+3kNOBYEgxByOKjMmGyBeZWdEkQI6K+QFRN8BG9tGs4exZywGxLNwn
         guWtDuZ6pRW/ogm/zb8xqKbVZI5mK8Hh2HLskDejIkFFYrvP5s1qfo1ns2m9ces0YZ1D
         6vShi2QCnXYYlE05cfH50V7CoUd/hlk91exNy//3dZFHc970InEPsjYkUhIB7M8RSndf
         qwl/K7gJ/ASFX4j6UAGX71G6/mic00V0gkPq/bqGipS0MtfYti0JDiEWRVnU+6GQ5YeB
         oMLCKVWy2By+7AmlpApsFKSnLWI4JeU52kLOOqTNSM+To/aSEA8ydaQ9tIK7m34Xdpkd
         wxzA==
X-Gm-Message-State: AAQBX9dOczPAV8RcpW1b85KeBPGDWYfgolwie1wjHPHtVeQIIg84CPBa
        HIISTlWUjTa9kCZga4eBfZbc4w==
X-Google-Smtp-Source: AKy350aB4v+mwockIVyi4LYQnDA/uLM4PrpP01lJrsoDu5tBp6jBJgvZthlEM6bEjpFzS2B+3m6Rlw==
X-Received: by 2002:a17:906:6a16:b0:8aa:c090:a9ef with SMTP id qw22-20020a1709066a1600b008aac090a9efmr1518820ejc.55.1682062994984;
        Fri, 21 Apr 2023 00:43:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id pv4-20020a170907208400b0094f49f58019sm1720848ejb.27.2023.04.21.00.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:43:14 -0700 (PDT)
Message-ID: <fa21a112-5331-7166-32ab-e3d314d80272@linaro.org>
Date:   Fri, 21 Apr 2023 09:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] dt-bindings: net: marvell,pp2: add extts docs
Content-Language: en-US
To:     Shmuel Hazan <shmuel.h@siklu.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        horatiu.vultur@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20230419151457.22411-1-shmuel.h@siklu.com>
 <20230419151457.22411-4-shmuel.h@siklu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419151457.22411-4-shmuel.h@siklu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:14, Shmuel Hazan wrote:
> Add some documentation and example for enabling extts on the marvell
> mvpp2 TAI.
> 
> Signed-off-by: Shmuel Hazan <shmuel.h@siklu.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

