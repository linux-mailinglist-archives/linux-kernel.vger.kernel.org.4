Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00067664628
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjAJQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjAJQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:32:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912F85C89
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:32:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bn26so12419965wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QuzbVCChpPx+rGaPIq8dHHS4EuNxVBGmVWr4Va3xo74=;
        b=s7U+y5Oz7tIRvD972353bs+//bJkzJOJy8dEyT3V0seHT8faP05kCBKRkOOfLC/3Q2
         khsrE/uvDOaL1cxhP4Nb2OEMNygi9QroDRkVeDbsKSn2hnXlvbMGwHOXBAzsVy38sJAO
         QsAGB3T1fS8mjPzdfooRgf27bCITsXgW76dgMzTfZFOtq51YQjQfDdtbDd6XPBkNF2Dw
         jGdXYRHZZmLVEM8FDcb+JhA2YzqNwfKbpGDpn8AYXltNZ/VtadTafumdA3uJX4vaxsiy
         rrsTTMwfuQ/KFMX+32Za1yeKAJzX58yzI1ntgUO0uGrW1oDuN3PABfoGVoxSef+fdZBQ
         nGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuzbVCChpPx+rGaPIq8dHHS4EuNxVBGmVWr4Va3xo74=;
        b=NvCXzf/9SB/4L3uypxhKbf0nLEKpd1ziO7I/js8pnxRj76WKINZfLpqZlB9mydgkVr
         9uOrXCu8Pk32ueY3yj8SA3te3FELQyHpEsd+6TRZqnoQWTK22wjCWRwgFGhmjXXMgE2D
         +LZ1TwSD1OE9Isr+6BecOFPu637T/CYgAJ24EqcikVvU9RlM0yDIXZkPLC5h7NPXzyWQ
         1ZJj9gFPlahlvM/w/u/i0hrRA2cfBb+ivRsq/i0qcnWe0qp5qdFwPbrbSbOe4BXRQxe6
         3IjRyG0adX0w+kwBsZ39vgONSzlw/uGb6BZUCte/UpQ5QPd6i1t9KzRAeMCiN6Y1MAqj
         qhFQ==
X-Gm-Message-State: AFqh2koLmvllSr9wnrAsDvKLmXtg8/YJ6FgKXUfEIBHcnwmaesPpf5ax
        q097YE4UD85EDJJxuHaSlRwtUA==
X-Google-Smtp-Source: AMrXdXtSCGNwFYMKfMVzHWvbvChN4XjFuVYEwrUFK0U4mbHjX4GIFKntuwa8PQWIutEaY8g9EcHY3Q==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id bz16-20020a056000091000b00242733baf28mr58796163wrb.5.1673368354494;
        Tue, 10 Jan 2023 08:32:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d6686000000b002bb3229a03csm10562820wru.34.2023.01.10.08.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 08:32:33 -0800 (PST)
Message-ID: <9849e94a-abd6-37f2-8c49-e923bb554dee@linaro.org>
Date:   Tue, 10 Jan 2023 17:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add zhihe
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230110155014.31664-1-forbidden405@foxmail.com>
 <tencent_89603CF732FEF0B9A2E88CF0E45A62F42D07@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_89603CF732FEF0B9A2E88CF0E45A62F42D07@qq.com>
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

On 10/01/2023 16:50, Yang Xiwen wrote:
> zhihe is a placeholder for various 4G USB dongles made by unknown
> manufactures with similar design. It is widely used in China to refer to
> these dongles.

No, it's not descriptive enough. If you bring support for specific
device, this device is already known to you.

Best regards,
Krzysztof

