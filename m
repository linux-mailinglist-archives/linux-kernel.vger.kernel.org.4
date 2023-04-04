Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6D6D62C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjDDN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjDDN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:29:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9A30F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:29:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so130576801edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680614952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s483NaMM7Zoche7s3BZ3DdRWDccYZvUuzEvQy+0pu+s=;
        b=eC5yxf+/hg0s55JuY5sUtl/t6JuiaYzwPx3JDJ9CmYtFzjcZVDquKOslt3GCZ7wqS6
         +epqb6ngRhESn6/P+2lYXlS5BjsLkOV9K0ugwatpLneZJxzIn3gDuU2fIMDAGEMPm5Yr
         fxjM2z/0dRnGzLef5gRYmf5HhVphR0c0RVo/aD1ioBxNrVGXiS5wb3gd+M5WRTrckVM5
         P+8GRJtuJ3zvEVTn2X5QU6sQD/dmX3rv3OBkZyQAXY4bnu6krPRY53Hrudf9KUSaWj/1
         tMqYamUvRDryuYuSubu0r29Qu3Il9A1DljJKsdQxM6WhtNRq6AXjIU/OT9hKqdTKYN/8
         6UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s483NaMM7Zoche7s3BZ3DdRWDccYZvUuzEvQy+0pu+s=;
        b=rIoO4MqzJgsJrbpqHhiFw/VGPQlCy3sfQ4rmKH66TnWdG2hei6KMWjauCUdCGcX9qo
         gGL3CPgikPdfb3tG+bdNUVGH28iJOPHGA+TvDpqhFWxC6E8e+UbA3buR7YwdqsmrkeM8
         cjFvFdc80mdrL9Ww2ial9E7Kue7hvtdpKiiAHeUpZ6MSGFXlaNtZ1WZA5QqsnkyE9fI1
         5OkIbALhdAawf6/Rf37IoQN+D7ZS+qBcg2wAHaCKowFCz/NedGFSycS6Y74CaopDkBiV
         30239bBES31QmbhCdZG6GT7dEJpFoA7k0EBDYebHTQHB6n2AoqFBHpKpiqFntkeDcd9m
         4xmg==
X-Gm-Message-State: AAQBX9cC2wmeW59uHl1Md67874ufxTuglHVDLhBCikOziVFFCJzjOmYQ
        2K/Aj0S1pmZegc6hSD1DYGhMXQ==
X-Google-Smtp-Source: AKy350YBmPHL8nFhi0Lkzwx2+5sWJyMEQ48kEVnHMQQN2hlCF5LrHqzWw6QBBitOO7aULRs2Ye+VQg==
X-Received: by 2002:a17:906:454b:b0:933:48ce:73a5 with SMTP id s11-20020a170906454b00b0093348ce73a5mr2267697ejq.56.1680614952348;
        Tue, 04 Apr 2023 06:29:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7467:56f4:40b7:cba8? ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709064b0700b00946be16f725sm5982854eju.153.2023.04.04.06.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:29:11 -0700 (PDT)
Message-ID: <63d456fa-4db5-96fc-107e-060e59754096@linaro.org>
Date:   Tue, 4 Apr 2023 15:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, damien.lemoal@opensource.wdc.com,
        xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
 <20230404082426.3880812-7-rick.wertenbroek@gmail.com>
 <d9afc07f-0346-1fe7-907c-261e4c6f92cd@linaro.org>
 <CAAEEuhrnp1QyP498V1wzyLv6KvfRCpNidF9NJpzg+kofWqrJtA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAEEuhrnp1QyP498V1wzyLv6KvfRCpNidF9NJpzg+kofWqrJtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 10:58, Rick Wertenbroek wrote:
> On Tue, Apr 4, 2023 at 10:45 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/04/2023 10:24, Rick Wertenbroek wrote:
>>> Update the example in the documentation a valid example.
>>> The default max-outbound-regions is 32 but the example showed 16.
>>
>> This is not reason to be invalid. It is perfectly fine to change default
>> values to desired ones. What is not actually obvious is to change some
>> value to a default one, instead of removing it...
> 
> Hello, the example value <0x0 0x80000000 0x0 0x20000>; is plain wrong
> and will crash the kernel. This is a value that point to an address that falls
> in the DDR RAM region but depending on the amount of RAM on the
> board this address may not even exist (e.g., board with 2GB or less).

We talk about max-outbound-regions.

> 
> Also this address requires pointing to where the PCIe controller has the
> windows from AXI Physical space to PCIe space. This address is
> allocated when the SoC address map is created so it can only be that
> one unless rockchip refabs the SoC with another address map.
> 
> The example never worked with the values given as reported by e.g.,
> https://stackoverflow.com/questions/73586703/device-tree-issues-with-rockpro64-pcie-endpoint
> and here they set it to 0 (base of the DDR, which is a "valid" address
> as to it exists even on boards with less than 2GB) but it is still wrong
> to do so.

Again, my comment was under max-outbound-regions, not under some other
pieces. Does this all apply?

Best regards,
Krzysztof

