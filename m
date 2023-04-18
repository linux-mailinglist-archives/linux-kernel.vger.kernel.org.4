Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8757A6E6980
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDRQ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjDRQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:28:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131D13856
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso4231636a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681835289; x=1684427289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJlWGu+2bQtbqWA973Suq+EwkurQD+u5p2hnYjezJq8=;
        b=vv4dJ7uJKbOE+JhO+/5j8nJXF1CxEI2XsKRxzV3q+siggej4sDDk1smkZ+DmgjmiG3
         anjf3zz5wFjLrjuBZpfetK4dewEBUxHKZ9Aj26Jemf2bdfwjx6wCwM1qL1zwr8ar+56y
         Kt9IS8wPX46yvHpkFfNJp/KdANvr058YVUxAbFKW24AzORpNUD4P2aWLo0as+dkWyQgc
         h215sM45EUqr1s0cJVLRusWX/OyTzY9nFD7RMSktgvvi6lMRrpeUdMOnbaTuBvowbdVC
         hqQ1lx3cMz3y+RybL6yX8ahNQIXccfxQk18K80ra56ywXqBKV3wLnZf/EOPQHV5jsIsE
         IWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835289; x=1684427289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJlWGu+2bQtbqWA973Suq+EwkurQD+u5p2hnYjezJq8=;
        b=VDZs7ksO9fKCoNtwgkcS+bFoaF3iUyfhrSScIARrLPE5zMCkPpmH+jlWYvkcW24/80
         Zg32QsPwOxHJEpcjUBIckWCkLw6yi8EUWhm++gvzLzFzNUm7YlDKxisyeTQehezJDwac
         gSisF9KzbceN0ktA6etH4zEwBHPhejgF+LCUT4AyIsgizkrCWsP4MaUTIyVMn9AbxUau
         X6+EkXhjSEubU9AOUCFogHzvNOSu5qwMSzWBYC2GcL3xPeflLMIdMtAGGOPsPQMdiwNx
         it+6G0PLKbExQaHlFwvstQ9Bd5PcURM/jTK3auSr/1t2PqQRteSPtlE9hC0MrdJQ/QnP
         fH4A==
X-Gm-Message-State: AAQBX9cJuJ3TJi08hOkpqH5eIBHXXQNp3j0eabJkjxGDSUHP17qAICLS
        S+5IXeTUxwtRQiLpK69FbWBOkA==
X-Google-Smtp-Source: AKy350Y/3IgBgDv4R48Q63JLX5Uidf6WHyS26p9iorYJyBkECnJNn3F9M9a7PLWNGg3ixsvhOmHD1w==
X-Received: by 2002:aa7:d691:0:b0:502:7d3f:1f04 with SMTP id d17-20020aa7d691000000b005027d3f1f04mr3245803edr.19.1681835288562;
        Tue, 18 Apr 2023 09:28:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7dbda000000b00506b0b80786sm2028340edt.36.2023.04.18.09.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:28:08 -0700 (PDT)
Message-ID: <c8013f4d-5567-824f-53c0-03c2816447c4@linaro.org>
Date:   Tue, 18 Apr 2023 18:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: timer: rockchip: Drop superfluous
 rk3288 compatible
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
 <20230418120624.284551-2-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418120624.284551-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 14:06, Cristian Ciocaltea wrote:
> The compatible string for Rockchip RK3288 is provided in both the 'enum'
> and the subsequent 'const' item. Drop the unnecessary entry from the
> enum.

It's in three places, not two. The one which you remove is actually
rk3288+rk3288 which is obviously wrong. The commit msg could be
rephrased to point actual mistake being fixed + Fixes tag.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Best regards,
Krzysztof

