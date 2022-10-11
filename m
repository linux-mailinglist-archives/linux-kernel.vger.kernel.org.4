Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE95FB21A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJKMJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:09:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD95B053
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:09:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b25so2436354qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wA2PG1QV5nKHw4b8l0hoDe51fcPxcPalio0IbUmeyTM=;
        b=FXrqF8s7XtbX/Ycq5jUsbxK5DGdGYyeznM+Y/KtKVTpxB1WEgtBvfXGtmS/mY3Z6QP
         xTZJNxIlqUEMrPqMRIQg2lU/J2UfnvzpakaYep0KVD439+H4JvQBNEdDUfDC2Z5sJWjd
         RY2zgbnUiGWHR8vWDuwUHpcUjv2BW7E78N5wbmLogOeltArOPTXSWzoXD5QbJSInup6Y
         qr8x5sh/Ue5Hr+qbjR0soe72IxM2R1XjMVWfMMrOUFB/UCNqsmEvppyH6bwz0n9MwXzs
         76IUxf+rLZBn49IgdPDPhnUq4s/TCfJtG4++2/wj2vkldnNK9BLMjX37rBHO2FjAuhbt
         3+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wA2PG1QV5nKHw4b8l0hoDe51fcPxcPalio0IbUmeyTM=;
        b=KrUkvdvVQd7emxOs+iULh3ATy40bi0qz39uTHzc65ueej2YcUyAdVbYCzuvfmUq9xx
         TOltVXSgsQPv2Wpm9WbHhXdoq8GHRDe4aVpuqfCmNyuRbfNyOnqORbsDPw7JnBjXrzdG
         gyxX0xBz6hzsIhRCRofH751DTXYFHoM6K/riIln3jM3Er05TCVwe3i0ZUNHnMdRSlGoC
         WXWC0SEXKrlqEISG9PRIF8FIgM+avOpipcJ34YxTqR9NozQZzjQpzBHQWoauXuLDGtyy
         dZIp/ISZDapNnbNUtF88KWlQstQfkQ4E9tz3ECaNVK9fZlgt48SDaAn76lsCJNnpcHdS
         uXtw==
X-Gm-Message-State: ACrzQf1wZXoRbeVSCZ9Zuv2+K6POaOfzGYlP0EXD5fiKqnLOS6RpEpUU
        EL9mW4WvoJkcqnbm+LD3pNkdFj5dFxcOjw==
X-Google-Smtp-Source: AMsMyM6EDJdIKnBSo3ZfKOacjcSSHQnz7CckztC9dG1sbPnETMw/m0XvV2QlBBo1fJbyvmgZOQSIIg==
X-Received: by 2002:a05:620a:2909:b0:6ee:6c83:9769 with SMTP id m9-20020a05620a290900b006ee6c839769mr3710909qkp.732.1665490145001;
        Tue, 11 Oct 2022 05:09:05 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bm4-20020a05620a198400b006cfc7f9eea0sm12917572qkb.122.2022.10.11.05.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:09:03 -0700 (PDT)
Message-ID: <3c516469-8f89-9c4a-e558-5281d07510c7@linaro.org>
Date:   Tue, 11 Oct 2022 08:09:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 8/8] MIPS: DTS: Ingenic: Add support for the JZ4755 SoC
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221009181338.2896660-1-lis8215@gmail.com>
 <20221009181338.2896660-9-lis8215@gmail.com>
 <2e89fc3a-bc54-17e7-d352-25db877172ff@linaro.org>
 <CAKNVLfZ4zPdhv=zJOcDk_hnVVoU51L8uAsoXEmzJpecsyc5KmQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKNVLfZ4zPdhv=zJOcDk_hnVVoU51L8uAsoXEmzJpecsyc5KmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 16:00, Siarhei Volkau wrote:
>> How do you build it? How do you test it? It's basically non-compillable,
>> dead code. You need a board.
> 
> I tested it on a Ritmix RZX-50 handheld, 

You cannot, there is no such DTS.

> although this patchset doesn't
> include it as it requires many other changes to be fully functional.

Exactly.

> I decided to do this in two steps: add platform first (this patchset) then
> specific drivers and quirks, in the next patchset, when this one passes.
> 
> Of course I can add machine's dts with working parts. What's the usual way?

Don't add dead code to the kernel, so DTSI comes with DTS.

Best regards,
Krzysztof

