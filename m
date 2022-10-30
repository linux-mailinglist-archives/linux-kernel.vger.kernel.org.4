Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD26129B9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJ3Jtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ3Jtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:49:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6DCE3E;
        Sun, 30 Oct 2022 02:49:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so22812438ejc.4;
        Sun, 30 Oct 2022 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrESdhTf+ohvD7xti8OA6Uw5cnHRo0bNkMMZkvXzv/4=;
        b=XCPPldoPImUrN93VgBHvNuASTcusKXWwI3GrzvHSID9zUSdCg2D2FdY1dlvZIqGpQj
         t51wbjbN9deBfA2Q9Y6F0FjYilLwY1LAZW7jqAHedeSss1wUNUTwS75nBTPFHsKnet3R
         SjAhI73Ek+p3W72qWN/+VjVb7R2pw978ObKkS9aX995r3/eNyuaA+5GRJ9CwSL0cvJWL
         ywh2SzcOLIZQVEaU8QvdE3VaRMfikUtTq02cG7qkWDhW8p2UxLyQ7dHqU4dsQvRFdKcB
         3CaJkdiQjr6RlItkON76VjXpgFs/7YsuZncPWEWiaoia0Bs0lYVey8X8Lfs1c7TX+a1i
         rk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrESdhTf+ohvD7xti8OA6Uw5cnHRo0bNkMMZkvXzv/4=;
        b=xpIosqOKos771w3k6yhsOZVGH84qOlZAT7UigiglZCqjjN16cbYJFpz98ZqOqi+izt
         RQ7JU90oBA/iwBNUdbJ/gloroeEYAenlT7RSvBXGKGrq2hk/KKFSzAOOEZuTKIoD6OPW
         TXxt4M6zlCT+c+ByNM/2QFs9Q3skN6yl1IamnHb5lxTmUJ7DP6LJ9M7fzYcmPoChokWP
         OZd8jo+yOXE1A+5WqWDMcQJZSc4lMhtEXGlH7bAlJnfLuDNb+yd9AvPs1Cc9ARvulRKq
         dQMBhfewTWzjGQwp/h8iZ1Cp1ybPz6zOMtCzGDeE4i5ChqMsv5iJnsrO+GeR3D2FrMzk
         oRcQ==
X-Gm-Message-State: ACrzQf0QTla3Ab0TOa+p5+3R+LVBHumSlC5jABpqjUUGyrgkFY9RLSdC
        n8iBVMkmEdVfvs0p3C0NNik=
X-Google-Smtp-Source: AMsMyM7LXJPbJfwCst2+OBeGHE3sUGrmmMgHlv73Xnbhlcz9oB5xVLivRHIDUAjKFEfx4+i0M6n8Kw==
X-Received: by 2002:a17:907:7e9a:b0:796:7a21:1520 with SMTP id qb26-20020a1709077e9a00b007967a211520mr7581144ejc.236.1667123371124;
        Sun, 30 Oct 2022 02:49:31 -0700 (PDT)
Received: from [10.32.3.204] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906328a00b007836d075152sm1672391ejw.187.2022.10.30.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 02:49:30 -0700 (PDT)
Date:   Sun, 30 Oct 2022 12:49:16 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v4 08/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve pinctrl subnode and property descriptions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <4M8KKR.ECH2308DQOMN2@gmail.com>
In-Reply-To: <f5bf36e2-5be2-cec9-510d-bc99bb9b6bda@linaro.org>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
        <20221028153505.23741-9-y.oudjana@protonmail.com>
        <f5bf36e2-5be2-cec9-510d-bc99bb9b6bda@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Oct 28 2022 at 15:58:30 -04:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 28/10/2022 11:35, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Change "subnodes" to "subnode" in subnode description for better 
>> grammatical
>>  accuracy, capitalize pinmux description, wrap all descriptions at 
>> 80 characters,
>>  and remove literal style indicators from descriptions that don't 
>> need their new
>>  lines preserved.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
> 
> I propose to squash it with the one changing description here.

You mean patch 6 "dt-bindings: pinctrl: mediatek,pinctrl-mt6795: 
Improve interrupts description"? If yes, would that mean improving 
descriptions in mediatek,pinctrl-mt6795.yaml then pulling them into 
mt6779?



