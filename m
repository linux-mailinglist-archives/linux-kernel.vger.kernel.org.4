Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6276000AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJPPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJPPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:31:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9671371A6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:31:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z8so6459173qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu5J2M3zkZhLlmKkPts4TzG2N051rte3Zf/Ut5VRj1E=;
        b=MXGLad3rsvLDEMuRtg32uiJX+BVHq67x453O5q26hqtxLKqZ7pwZx/OiFPnCqZ0srB
         1Pk3lR6Vw5SF3ygHvrEDcNnIUTf0cpiKnqDSeDmTAz8S+Jv6NZ0WKFfI35QjiTIPF+9i
         L+fGirE62PDL9RzeBujrNgkK0YHqLPWTwnFi62XwfSD9/DeZwMmI2w/Im48fwMnEIV7d
         dH5neV9UPBIwjwxAFJ+pHDupjj5X8NtzYfeIXu8YF1PjbCIMkowpILh9sSEoEq/pWSnj
         l/o/hElG+tLgeFro9xBPEUC6Q2TtsNa2EovfhDTs5c0APbUgdc+caxD3hoYgWWx+D69s
         8ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu5J2M3zkZhLlmKkPts4TzG2N051rte3Zf/Ut5VRj1E=;
        b=poIgQq0d3+PztWtNi87z/DBXCJtx0XegNXap9KowSxC94AkFkPoaNJl525sXV7kiQj
         oqeq5qSfeZdDDHVmjFy5wVsrdzLkZdK+Dzu16TxG6SufPT0QN4P+xLdKeECtwjaA/lPN
         Yc17mp1hBaRINA07xqSja8OqqK2hGBoYs35riPocZx6QXbH7ojbJWhtYp4sZGX/0Aq8P
         ZPniFBYUkKh1giOCdY9RcdPOhpgKbWWEM2da2iYgjT9wXymUhL5FCEhYdaBRgsgnou08
         yBYbLQH1Qq6uTPbiWjSPc//dTNh/xg2C6TOA/XjM9frGQDE6rTSaZGjhPFNtKtPPKe2N
         gRDg==
X-Gm-Message-State: ACrzQf1t5ZqO+WJQPF/1+Gxq3tS5MuQ96IvTZLHMIzUGuRjv9kuq/7P/
        MPU3XcFWQ3NI52O4mIbmzxM9QA==
X-Google-Smtp-Source: AMsMyM6xMvZlHPUopTOIHO4SV8vfcMvs1EF1LGbppZTIcn+VogWCIeBCOx3fOnmO2ZHOg+8ra842aQ==
X-Received: by 2002:a05:622a:156:b0:39c:8dc:d543 with SMTP id v22-20020a05622a015600b0039c08dcd543mr5459995qtw.458.1665934311073;
        Sun, 16 Oct 2022 08:31:51 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id bk25-20020a05620a1a1900b006ce9e880c6fsm7107816qkb.111.2022.10.16.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:31:50 -0700 (PDT)
Message-ID: <73a2f525-e08b-7d1f-9bce-f6348bf2f0cd@linaro.org>
Date:   Sun, 16 Oct 2022 11:31:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/4] dt-bindings: ingenic: Add support for the JZ4755
 CGU
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221016150110.3020451-1-lis8215@gmail.com>
 <20221016150110.3020451-3-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016150110.3020451-3-lis8215@gmail.com>
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

On 16/10/2022 11:01, Siarhei Volkau wrote:
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

Missing commit msg.

> ---

Best regards,
Krzysztof

