Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D566E3B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDPS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDPS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:27:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1B2122
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:27:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u3so6601216ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681669625; x=1684261625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hq0Q6wAskItqzcqOpwtpc6JqQ468ZGZvjBNgr8B43M8=;
        b=FkB4FQjiUGtlOfB6x1PlP04HMciKpjnbn2tgyaA5GIJMZum7uH2/qyIELdnmDXi2F8
         GB+3+4z57AAFZDIOgC/EMA5AEAyQ7UMD/Z6p7jZgqBZjlxOlRPPCSzR6EON/EcJG9CRE
         w+XGBN185Pb7bhkd/qI5J0U5YUsXuW32JlHZpA2PjODiu90C8wR1joT12rVMj3czci0R
         E74fuFy+LBqnv7kwWfzCGv6quiJ3OGrFtBw1fH0Tc65MZSYdAODnmGWKcorPZ5onXedd
         VtQdoowp6luL3l7bdAp45kNvxaVE1zIChhz7OQsJP+9PTOpoG9oZEs+0PRKcp29wuurk
         6YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669625; x=1684261625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hq0Q6wAskItqzcqOpwtpc6JqQ468ZGZvjBNgr8B43M8=;
        b=fA8KdNCxyNWZoKZ8k5UPV8IoLFe8HpBUyOz3QUZMdDFcosltR2Qt0Qpu5UU5aCDUZ/
         kfM49s7woVs2JDhgsXgEf97ttH0DuqkAomC1L8PpQM5IfLh8uJ+XBCK1VbJiVIY94IG2
         0Mkvqdt/rPaUZyfRShQBWtllYJbKk4FuDWLTACaDf5Ksp8ZUn3atxtaVFtubbymmO9Zz
         7AYrohGlccHIlA6aB1piGD7SauKFGNEYcngfk/CdtEvK5lA/KV1gUnQO/7A3U5Vk6IVW
         l71rO90pg9yXbcs1kTeBfVq8nBu5KGBOpOfjgcvIBRVPnlPEOOIu/xjzWupX8VFAc4/A
         hL5A==
X-Gm-Message-State: AAQBX9d5NF2yBulNonjCvtIYXFAUGdS9NTz2mUK6MKEeFdFDHe4sdybN
        J43/NY01VgFyfFI4+uaLi7H3Eg==
X-Google-Smtp-Source: AKy350bYpP3jHXdwlV/K/hLgaWhHQ1ZZqrjCWLK9edGDtv0WBGsGSrwuLD9bRyxBEOQJKcdC+ltAog==
X-Received: by 2002:a17:906:71c4:b0:94e:6dc8:7ba7 with SMTP id i4-20020a17090671c400b0094e6dc87ba7mr5656457ejk.34.1681669624962;
        Sun, 16 Apr 2023 11:27:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906b08600b0094e6db4d4a1sm5393320ejy.186.2023.04.16.11.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:27:04 -0700 (PDT)
Message-ID: <d221e0fc-5dc2-22d4-c35d-07860b475124@linaro.org>
Date:   Sun, 16 Apr 2023 20:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: Add simple-clock-controller
Content-Language: en-US
To:     Yangfl <mmyangfl@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230416173302.1185683-1-mmyangfl@gmail.com>
 <20230416173302.1185683-2-mmyangfl@gmail.com>
 <c6571a6d-bf55-14b3-102d-814af6763be7@linaro.org>
 <CAAXyoMO3PXtbc1KxF10+BkMNEKKQuVrHKmR=n8rRPJycbQyxug@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAXyoMO3PXtbc1KxF10+BkMNEKKQuVrHKmR=n8rRPJycbQyxug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 20:22, Yangfl wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2023年4月17日周一 01:38写道：
>>
>> On 16/04/2023 19:32, David Yang wrote:
>>> Add DT bindings documentation for simple-clock-controller, mutex
>>> controller for clocks.
>>>
>>> Signed-off-by: David Yang <mmyangfl@gmail.com>
>>> ---
>>>  .../clock/simple-clock-controller.yaml        | 50 +++++++++++++++++++
>>
>> Where is the changelog?
> 
> What changelog? Series changelog already included in series cover.

Changelog of each patch, since there is no cover letter. If you skip
some people from CC, then be sure they get cover letter (if such exists).


Best regards,
Krzysztof

