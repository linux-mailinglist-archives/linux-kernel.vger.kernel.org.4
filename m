Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0674DA96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjGJPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjGJPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:55:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFCE7D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:54:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso52146225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689004486; x=1691596486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+TLvPFhBy0VZnH7T1qJxJl1HxW6ZD/qq/fnzKOm3lg=;
        b=EKLidUAYuZqZn3qp1dUjWlm2DxvKzKwB7D7K6DaZP+xN+3JCwWc7oEHv4jldB3k3rr
         weY4MbI5L2NIAirxPFueNE7Yz7PYbWJD+/dMZC/owxPXra8uc41ZpzZTge9PBUciEtO9
         gxcJT/DLFwSf3AM6hzhK4MXqtPwuXsle6sMO45gOTVn/W3YBZIeMzmCsRK0NRKui+T2L
         rW8lxeXhrPBKAPSYpqubOGQvzgx0WEWh7JnSeZpEhIonRge1GiYWvYB6EW/A05Rs9a97
         X8M5WRiBBZEB8eaHNhzqwSGmXNLg9VlPkRLshqRP1ayIk84j9npdEbj8AS/J4yn8yAxi
         sFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004486; x=1691596486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+TLvPFhBy0VZnH7T1qJxJl1HxW6ZD/qq/fnzKOm3lg=;
        b=fJNSBapEUcvCMod/+ysj6HYTipZ6B8rq+AYQivMD4wIq04KjVjAvPrV0goiNf6qtrS
         SdmEeTERxRIqk11WaPD9l46aTdMQ3Zkwr7Cl941yOtE0gJCT5vniTy5hzW11RLlNExpn
         BCyHcydGiOnQ0mdR9wUm2378g1uDODwS4tO3rzHgWOFQd0y5ryrKAfACmhpwHH7/XjHy
         DsmqMZzg/c+u+K/tvbweDz9z16DAAZer8FOLGcvYf5vCNNC2etfFOvQYVW2fbni1PZFt
         L2nDXpcqJ30OlXUvp81J9c2C+uJRmqRT1pPT8US8R/tGlKISHqsp0pu1mbDSSTcQq5aW
         h4YQ==
X-Gm-Message-State: ABy/qLacDHppeZqXpO+GFitvQ6ZEV+6VKyREUOocWeBm7o9vCMTX4X1/
        tO2GesoVQleBrELkhtDrFho+wA==
X-Google-Smtp-Source: APBJJlHKZAYdKNWF7zxUjdZaYyNJ/9cmV19/PYxoCgu9UK9zQy7GLmvhMxO7al1IZEypAiDtH1//bA==
X-Received: by 2002:a7b:c019:0:b0:3fb:b3f8:506b with SMTP id c25-20020a7bc019000000b003fbb3f8506bmr11600743wmb.24.1689004485634;
        Mon, 10 Jul 2023 08:54:45 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c7413000000b003fba137857esm231670wmc.14.2023.07.10.08.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:54:45 -0700 (PDT)
Message-ID: <00522cf2-c90a-659e-00e2-722c4ac0244e@baylibre.com>
Date:   Mon, 10 Jul 2023 17:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 7/8] soc: mediatek: Add support for
 MTK_SCPD_STRICT_BUS_PROTECTION cap
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-8-msp@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627131040.3418538-8-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>


On 27/06/2023 15:10, Markus Schneider-Pargmann wrote:
> This adds support for MTK_SCPD_STRICT_BUS_PROTECTION capability. It is a
> strict bus protection policy that requires the bus protection to be
> disabled before accessing the bus.
> This is required by the mt8365, for the MM power domain.

-- 
Regards,
Alexandre
