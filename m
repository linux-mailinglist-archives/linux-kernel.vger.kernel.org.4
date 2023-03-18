Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6A6BF780
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCRDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:07:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C0D2966;
        Fri, 17 Mar 2023 20:07:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso7198006pjb.2;
        Fri, 17 Mar 2023 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679108831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URZQ3gLDJKimA8H5HfP/flcS8+UR77bug41nYZUBjAI=;
        b=bhwRich09gdEYZiFJBIfMyaJ6k3QyBPx6nzUio9WiZ0/0Hfs+tjFSzj+mSkwZxGuCo
         UJrNcQdlkZYOtCDpH/kLCzXxXneA+/DRkw2ctPU/4ndciIMtsP7ngsRYaWa+nEf87Azh
         arXIhLdZt/SyGCeHaNN5enFbpnDUcqCbTUbMBsSZsyPx6lGUp9gGr3RndtnHlSnsjPrk
         FGZk2hLl4LnqWk8sr2QSU0W/ZfYKi9Z4UOFYcwAJkWk9H0afyQRBoIpDHCogsB7H6cg+
         oYOeSydk0CNBwU0FFfHPI2rxfh+HIiZ+Kt3dFnAq2OJRBoN+uYkDcLB/uSdVSLLtgu6S
         S0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679108831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URZQ3gLDJKimA8H5HfP/flcS8+UR77bug41nYZUBjAI=;
        b=R6Prp5pGc8iCYIQP+Bf2ZVfk+T0Fk5hvjyobF/MEKyLwDlOz0elzysrhcXGg8YzNbU
         +52EZnZv3dHTpz9fnpvehnFd9Pbo5h94Mxq4jqG/by2NAbcy73oYFjISya4GrMjgGbqi
         XzjeeYx1xFwtiQVhyN+QBH1hZChkH5LuiIzakGqEdYw16RJyyXo+euOSA4T+RKHDbmGf
         Wp+GuLigWpZHrsC0SWYDr/itObenSfmZgnkAyCER5tKrFKR/Sp74xEoNb7aPeUSyEPH1
         TiXyj8u96dfVu3xBnE2cIh694+YWfNKmmjU6+4r3FDuUcoffQ2t0viGXPBlUXdbIaQyA
         FcHQ==
X-Gm-Message-State: AO0yUKVIXUOX7T5+AGImrQiuB1j5imDlQRPXkKcPqtUW5t8Q9qZl1YfL
        hdVkQREMOg043UWL52VUBJcN2EHP4Qs=
X-Google-Smtp-Source: AK7set+sXpYsxgs1XShPfJfOrXFTCTdYJJnhtA8rWOmBQsIn0vb+NQ9X4koH/HjXIFY9cncCFmaTYA==
X-Received: by 2002:a05:6a20:2444:b0:bc:96bd:d701 with SMTP id t4-20020a056a20244400b000bc96bdd701mr13140312pzc.13.1679108831008;
        Fri, 17 Mar 2023 20:07:11 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id w6-20020aa78586000000b0061949fe3be8sm2218319pfn.106.2023.03.17.20.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 20:07:10 -0700 (PDT)
Message-ID: <f21df56b-43b8-a48e-ab8f-e0cf2b163976@gmail.com>
Date:   Sat, 18 Mar 2023 11:07:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
 <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
 <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
 <a90fc6f6-df95-3a4f-da5b-ebdafbe7dd34@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <a90fc6f6-df95-3a4f-da5b-ebdafbe7dd34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/18 上午 12:06, Krzysztof Kozlowski wrote:
> On 17/03/2023 14:21, Arnd Bergmann wrote:
>> I only now saw that you had already submitted this several times
>> at the beginning of last year, and this is technically 'v5'
>> of the series, and it would make sense to add 'v6' to the subject
>> next time and link back to the previous [1] and this[2] submission
>> on lore.kernel.org.
> ... and address previous feedback. Or at least make it clear in
> changelog that you addressed it, so our review was not ignored.
>
> Best regards,
> Krzysztof


Dear Krzysztof,


Thank you.

Of course, I will add back the changelog.

And, I have a question. If subsequent modifications made to a patch, 
should the

"Reviewed-by" still be valid? Can we keep it?

Best regards,

Jacky Huang

