Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121436E6123
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDRMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDRMWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:22:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03FF3580
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:22:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud9so72457485ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820558; x=1684412558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NCi64XGNvnIcRoPfYbsVQEhFpTLdIc0VlKvzW5v7qU=;
        b=maFFAOMtTbJViPc8gHoncMZVt1U2Au3ypnEeegMeWLUYOz6jdNkKS7yJLBivFHX7J+
         jeU/saqkWGkaad+b3a/AkjcMbAsLUZNS+KdH5D6U92eyJMJ/oeHuW9kyfBN4dYvlR6dg
         tyJ0Xsiax7fTOTj2z5GhwpsK/PY8T5SvFWA0JIaKYVoVrj+hE2izgsjeVWS4sope6xdO
         Vl9l3xhodT7SzE+rpu4QOMchQwMFpLLw+ZTXH8vUdwS5eMjzBTHwvmkTqKGMJR4hSYAF
         /HCx5yMn6FXudnjiaHZz4m4/Kd4oEFC8yPXzZSW9tQgp6iBj79h0aGxj2ERsNK8TepBO
         iy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820558; x=1684412558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NCi64XGNvnIcRoPfYbsVQEhFpTLdIc0VlKvzW5v7qU=;
        b=gAjOkFYIjEqFu1qQT36uBu7I6/TI4mdURxy7E1izQzl7nY/4jGM8ik077599QusXKF
         rBPj9M3ht2JQCg5L8s3SSeACEO9lG/izNF1ROSlE1Du6v7BKOdl+Bd9SVoOely3X+tVU
         Nj0TH4h15CZJkWKcpr30349nLxr/s0GqgHlXxtuklxLnDpP/olK3ZfEuYDdUVgWzZGXK
         3O24MKWNeZPbxstrToUE8PfQfPa/qJxB/mK6zaNphdAjr361B1hIwP6Vb3zgZM/F9/Mr
         I9TxcsafvqkoCp6N8JNHnMnbrINEDyDI7gAaXGb/v1yULWqr2YIRaWAtMrwYRjU+kJiT
         hK7g==
X-Gm-Message-State: AAQBX9fVNu2N3/yoCvX6NGxC78wULHx/3yaj+f7Qgn97Jmffc7jSg+nO
        6k3SAcMkRaq1DHtz6oBpCdg5+g==
X-Google-Smtp-Source: AKy350b1rlGbHV/ZqnW3dz26WRMbmKf54LQJWDdP80OW6WaojgFD3laTViuXV1OQzbIbItrUdqokLA==
X-Received: by 2002:a17:906:82c5:b0:94b:88c6:9282 with SMTP id a5-20020a17090682c500b0094b88c69282mr12465494ejy.22.1681820558103;
        Tue, 18 Apr 2023 05:22:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id rx22-20020a1709068e1600b0094f968ecc97sm2278664ejc.13.2023.04.18.05.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:22:37 -0700 (PDT)
Message-ID: <c79e7d05-0b62-40e6-0864-35b2821c69e7@linaro.org>
Date:   Tue, 18 Apr 2023 14:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/7] Add JH7110 USB and USB PHY driver support
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230406015216.27034-1-minda.chen@starfivetech.com>
 <517670ca-ba2e-811e-3eb2-7f38011c9690@linaro.org>
 <985d0a57-1fc8-5725-4d3a-33dcc5d49d67@starfivetech.com>
 <5953bc83-9609-6d12-7e9b-ca5202151fb3@linaro.org>
 <a75ed45c-55c4-ff94-86f9-313ec79720ac@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a75ed45c-55c4-ff94-86f9-313ec79720ac@starfivetech.com>
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

On 18/04/2023 13:12, Minda Chen wrote:
>>>>>
>>>>>
>>>>> base-commit: 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
>>>>> prerequisite-patch-id: 24a6e3442ed1f5454ffb4a514cfd768436a87090
>>>>> prerequisite-patch-id: 55390537360f25c8b9cbfdc30b73ade004f436f7
>>>>
>>>> fatal: bad object 55390537360f25c8b9cbfdc30b73ade004f436f7
>>>>
>>>> What commits do you reference? How are they helpful?
>>>>
>>> I use "git format-patch --base=(commit) to generate patchset.
>>> Maybe I set the wrong base commit.
>>
>> How are they helpful if these are private commits?
>>> Best regards,
>> Krzysztof
>>
> base-commit is not private commits. 
> I should set base commit 197b6b60ae7bc51dd0814953c562833143b292aa. This is 6.3-rc4 commit.
> But I set 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35. This is 6.3-rc4's previous commit.

You missed the point. I am not talking about base commit. I am talking
about your prerequisites, which are useless. What can we do with such SHA?

Best regards,
Krzysztof

