Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7E621B81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiKHSLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiKHSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:11:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336715E3DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:10:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so22355640lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN4ncCbN5RXq4bC+MjIVUQcmL6JMKzPTfDQ6haXvn40=;
        b=TvkxlNCJYlXgbwKJ9uhCOG1ZdtKYxRdjqIoE23FwVJwjBRO452fLQA194b0cxvY4bX
         PqMgG7HVAu8bRxc9KkQNpQK/BF7AgQJMCc097kvMqV6lR1cW0qbEE/hPYNEpXyn2SmWX
         QmoED+FTYkD3gxElk8y0uZ7hkEA83qlUpMnzPAFISDC4VWG2HJha1EAnOq+QPkK1ObFo
         uRU2hkN6tW/mC4f1EKwb/xoNmHJme3mvQ48XjAT5DUyirJA6jwabHyT4DwwDPqVA5iB8
         1Du8LV/QYG4Lt9kMLecUhSihQdiXrZ+ZjP7mxzfiyBUjGKl+kjttu+lFDZZJ1wvpd73x
         2Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GN4ncCbN5RXq4bC+MjIVUQcmL6JMKzPTfDQ6haXvn40=;
        b=7DIFL4hXNmYPifvgI6gl/1S/d/0KUaS6D/GOtaLUoVJhv+acAge3WT7sIwvAg+/lBg
         lfFIYuTxP4+4rxKUe5npz/Va3gJZsN1w4H3RR8+sVIOCgo/hpYou7VPgJT9i9/7AX4lu
         ZAbvVhw+InuKGuDyMDQr8G+3CCO3TSP81Yfx77I/ANKXNTs47UUKdSKbBpeOW/0UZt8/
         YrzntUGPFnShWf3WfE5V6C+va518RisUf0+aRdYZPK0Rw0qwMAQJQej9LKeiXkw36p01
         Js4bo+O6Fh/rHTJWLDW/ijy5vj6U0I5UV2lzL98zfInojsbx/A5YyXcLCqJSjnwXhrgD
         0Vbw==
X-Gm-Message-State: ACrzQf1lgt1aB3ATtXdmDGTcDQT+U2j67wANLfeBU21fkji/YBEXZFSJ
        Q1eQRLO/iLKhFJBlsqYn4QEzvg==
X-Google-Smtp-Source: AMsMyM52maW3sfRovKLSKGvPEi5QOxDIojC6VtVzehizWEqqHR11l1zKljI5liw/ss4HdcCpLn/rhg==
X-Received: by 2002:ac2:447c:0:b0:4a2:4fc6:4cbb with SMTP id y28-20020ac2447c000000b004a24fc64cbbmr19141894lfl.99.1667931057375;
        Tue, 08 Nov 2022 10:10:57 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k19-20020a192d13000000b00492b0d23d24sm1867848lfj.247.2022.11.08.10.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:10:56 -0800 (PST)
Message-ID: <e77cf459-b4f3-199a-0c59-85a166a286a7@linaro.org>
Date:   Tue, 8 Nov 2022 19:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 04/10] dt-bindings: timer: rk-timer: Add rktimer for
 rv1126
Content-Language: en-US
To:     Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20221108041400.157052-1-jagan@edgeble.ai>
 <20221108041400.157052-5-jagan@edgeble.ai>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108041400.157052-5-jagan@edgeble.ai>
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

On 08/11/2022 05:13, Jagan Teki wrote:
> Add rockchip timer compatible string for rockchip rv1126.
> 
> Cc: linux-kernel@vger.kernel.org

There is really no point to store it in the kernel log.

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

I would argue this also does not make any sense to keep in kernel log.
It's maintainer, not a person who is somehow interested in this commit
and should be cced.

Keep both below --- in all patches.

> Signed-off-by: Jagan Teki <jagan@edgeble.ai>



Best regards,
Krzysztof

