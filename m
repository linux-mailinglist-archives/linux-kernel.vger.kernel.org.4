Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7116C0170
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCSMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCSMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:08:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282122CA5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:08:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd5so36758170edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679227685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ztN0SlyYyv5h+bTr+KEp1+MVZxbNezPNA5K1eKjYPmw=;
        b=Mkj3aWw7ipS3ypo1h70Eq7sgzFfTWY3Gg691bbHScGEq4oLH31lan+wqryOv6mjUS5
         f7DVczlVfPaLAe1c1FB0NOH6YxwhTbj/oMITeSbrY01x7HnmqKHqIBIQ5Vh+lxNvdgl1
         tVlriSMz1oT1qUXP/LBm3lLk7blKm0lNz9Ftf3TVM+Na45ablLX9FbVQ8MZQ8J0Bdcxk
         ChPW+lkvO39NB/TVDndngfLZXX5yo16pM557BzsUVk38I7nogLcir3aO4oe6GX6uu34M
         w2Vpyr8y5k5k105+AHGHDeMrnVitgGQoBos8D4Badfa756KLpjPTGoDtyVVTrGa3XfJm
         KIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679227685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztN0SlyYyv5h+bTr+KEp1+MVZxbNezPNA5K1eKjYPmw=;
        b=KhLq9T9u1MBr3mcpDa4IXFfqMD86UuE2yozl9QohIaTCIt3EO0nm79S0cbzfMxP7g+
         vNIRd0XLilw2HoxNDNC8tD83f8MTgen+cQ0ggvRxbEtJBPCVaimoRRjZgexA6aRQUmxE
         TptkAOdWESTW/GfQoiS1DhfrJwLlr24m8+wnYVMd4p9Cl5VsRPJHUeMRvsh1WbceyFXX
         GHlX4m08WeGy/JkBzbl18Y1ToPuuHOhyobmbJpM8rTdf9vSX+QKmaMfJaR+rAPM8xsOP
         tP3ze+gHEAbL5C+gN+muFwsGuidzjBH9K5M2Oad/WBhQVwe9gUo5ijgKB45cBP5L+CaH
         7uAQ==
X-Gm-Message-State: AO0yUKUIEpimXY2gyqrygRinACXT3zJf5R682n1VQ6iRppbi8mIyMTcu
        dJSp82BhvDe7SgnIfFx+LEgq6A==
X-Google-Smtp-Source: AK7set8i+OK9jVxQpjaG9w6kQ5cP4/IcZQBO9SxYAjJNDODfP0a0d/621iRwGuZYfnjxwV2dc9t6gA==
X-Received: by 2002:a17:906:481a:b0:930:310:abf4 with SMTP id w26-20020a170906481a00b009300310abf4mr6115541ejq.50.1679227685457;
        Sun, 19 Mar 2023 05:08:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm3174460ejq.3.2023.03.19.05.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:08:05 -0700 (PDT)
Message-ID: <f5b69bcb-5959-ab1a-88f9-314255249ac5@linaro.org>
Date:   Sun, 19 Mar 2023 13:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v14 1/2] dt-bindings: clock: add loongson-2 boot clock
 index
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230318075340.22770-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230318075340.22770-1-zhuyinbo@loongson.cn>
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

On 18/03/2023 08:53, Yinbo Zhu wrote:
> The Loongson-2 boot clock was used to spi and lio peripheral and
> this patch was to add boot clock index number.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

