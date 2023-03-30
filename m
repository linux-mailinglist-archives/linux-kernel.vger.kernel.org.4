Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3166D6D0732
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjC3No4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjC3Nov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:44:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228646EB8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:44:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y20so24611076lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680183866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dXaODJDga8CYetavWpa2GSFUuU4punKQn75AbRbTHo=;
        b=fGgdQkXtZ+Vg96kNl4Jfo4Ky/1Dwn2qcO7SAaOoYgQXgvvzGgD3vwjB+h9/LBphXRp
         YgDfsqtstG1oYIUVcS1YhT7ak60+f6S4pbedPMYlKMxOwJ+tAyizdW/vpsowNg4kV5B9
         butVVKT4ZHOt9Rdh8RAZv9cQ4HQbyLFvvhV9VUS6Z9vllXHyJ4F/uDYcPIoAX9Cx2hqw
         Qr63cj7i4PcSkLs84zU5vksKxud6bWUIkVQC2vt3iV6Keg4WruhFNbEsa77vZgK9UjF8
         0boXRnVr1xCi15P4XzXRZZ2AwJ0TN6YPbOhpwu14ncsZ/guWUyd3WIP4hjhMAlB1n2q3
         r+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680183866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dXaODJDga8CYetavWpa2GSFUuU4punKQn75AbRbTHo=;
        b=eQu7FUZM/eI0nVQYdu/br58cN7DzbSMzJN8+Fi1A7KolV00rIuM3RQ7qgRHIc9QQ6J
         peqmWwMVtUPFhPomJh+qJjxuMxze2mrIG/tbkIWV4B/AXEjTK5UOaDDC/voGjSdU+Y2F
         vTbilJ6UwQ9ha7uXwqNSILSRTU/ym+AI9bUzI62sNaq7t5zVP9Hp5DT52gYiSp399r3W
         1qpzTEMJhfJy9t+HcRJdmPXrEJPw95OLMhRdLuTo7Wfdq8VHTgTagh/YtsXXfaeQVkXM
         wvSZ1a0hQ3eW/5Bep9Cv66JQXA0vY8qYQBceynfLkOWba/QVKPy7WrJftvOaF8emSmBa
         awFQ==
X-Gm-Message-State: AAQBX9czKprsD7J6kretvxfqi7gNNqvEhyaWSdv6FKJrEcXWT61SYnTz
        f8I50FVzpWg8orBfXeAtpa2/Eg==
X-Google-Smtp-Source: AKy350bVOd00ovsH5iQm9RMiEwmifowBDuv+HH+dRpAWlvbaxEV+uPUxMikMuJOtrsg8wMry14eXgg==
X-Received: by 2002:ac2:48a1:0:b0:4eb:2a26:babf with SMTP id u1-20020ac248a1000000b004eb2a26babfmr702020lfg.0.1680183866026;
        Thu, 30 Mar 2023 06:44:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b004b6f00832cesm5848545lfh.166.2023.03.30.06.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:44:25 -0700 (PDT)
Message-ID: <5eb0b699-47bb-ebb7-2ea5-0cf05ccf29ab@linaro.org>
Date:   Thu, 30 Mar 2023 15:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: aw2013: Document vdd-supply
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
 <20230320142103.3440-1-linmengbo0689@protonmail.com>
 <ea673f62-f462-a559-d0dc-0662efc60f9e@linaro.org>
 <20230330114633.GD434339@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330114633.GD434339@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 13:46, Lee Jones wrote:
> On Mon, 20 Mar 2023, Krzysztof Kozlowski wrote:
> 
>> On 20/03/2023 15:22, Lin, Meng-Bo wrote:
>>> Document vdd-supply, a regulator providing power to the "VDD" pin.
>>>
>>
>> No. This device does not have VDD pin. I checked in datasheet.
> 
> I'm confused.  This patch set much do something?
> 
> I guess a better commit message would help.  Let me request that.

There was a v2 - with a discussion - so we wait for v3 which clearly
indicates this is supply on controller side. IMHO, this is still wrong
because it is controller's property, not device's, but Rob gave here
green light, so v3 with proper explanation would be fine.

Best regards,
Krzysztof

