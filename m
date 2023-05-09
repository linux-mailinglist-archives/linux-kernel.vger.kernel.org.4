Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6590E6FC2D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjEIJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjEIJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:32:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CF3ABA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:31:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so10220036a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683624710; x=1686216710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpyp88z1I8Iz4ssWAYip/S0rI/Ti+jaoje7zei8uE0k=;
        b=w2MZ5vCArdyktuy2hjMHXft05Usx1sHDcYiI1RsW7Wz897G24kUaMx9PinBx6jt7ed
         ZQFoosOVY9dbjgfW1IczKthuPsry4YxdL3ZQj/6pY4k4ivQzFnHYnHtav9YmonLIbHDB
         +EikZ6wi21w/i2kpCCkdCBq71YYB9NEjgJf5+QLdmKHdXCDOFjRv/VwildiLkzOXEsa2
         1bdwn1+RkQM20+Zj9eh+tk1AtMKiyXmklD0MNDodXPMNSDBUv59b0ESDk7dOkyBwWt0K
         Kgz1z9exFiyjJdyocwKvVzWUSXGMyaHB8dVNBXX5IVDw3rKsxJ1udWSHmR0Lwy6nlaGy
         Wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683624710; x=1686216710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpyp88z1I8Iz4ssWAYip/S0rI/Ti+jaoje7zei8uE0k=;
        b=bl+ici8bpERi33excqmoIzCG2Me/yzF5rURwJJJdL1+/p5W8ovfFEzeOlRdoJL9UlK
         7TmOFkeYwreDEXVJL4FuTQJsSJPGaCupcIXUXNyMt0XIgQyUVQa3B1hw3lu9oX8s0g1G
         bjRlXSjmgti0hQPNfxZ4Udmp/Z694Za+I7eiEtQ3I48/dqve6VIHVqtxz/7jTgBTPVrX
         2xVUJ9nS90o2aqvlYbDb/WKx4J2OGRWeo8mvqNJGVmLI0NvO6fGJFzcXniaJn10NYFn3
         LmQ0WGk4icKy0jeoBgQBPGLsnPZP2ttcfUtfzIkV4oAdRpW1j6xK714qiwSa/D0AeeWi
         AVEQ==
X-Gm-Message-State: AC+VfDxpVAH7B25aaZ3l04Ja67FIeD6zrFBM8lS4caVhjuCfI7guzTkh
        O5eNgoclEIBgZsjhl8Khxaakeg==
X-Google-Smtp-Source: ACHHUZ6mCIa39pUXuz8D/0qQR2zNJvZGwC/puYhg9AlXx1N2/XCQevUQkURPunSUG89h+u9MUt6UZg==
X-Received: by 2002:a17:907:789:b0:965:fd71:f1d6 with SMTP id xd9-20020a170907078900b00965fd71f1d6mr9735379ejb.16.1683624710550;
        Tue, 09 May 2023 02:31:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b00959c6cb82basm1081708ejc.105.2023.05.09.02.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:31:49 -0700 (PDT)
Message-ID: <2880d5bb-61ce-a4d7-f870-b5549a5d88f2@linaro.org>
Date:   Tue, 9 May 2023 11:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: enable PCIe controller
 on TI platforms
Content-Language: en-US
To:     "Verma, Achal" <a-verma1@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230509063431.1203367-1-a-verma1@ti.com>
 <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
 <de6432db-0da0-b535-1f44-04541116be8b@ti.com>
 <63dc3d1b-ba17-48ee-a02e-83b2903e360a@app.fastmail.com>
 <b48613f5-9442-5a41-34fb-760d9edf3682@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b48613f5-9442-5a41-34fb-760d9edf3682@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 11:19, Verma, Achal wrote:
> 
> Hello,
> On 5/9/2023 1:58 PM, Arnd Bergmann wrote:
>> On Tue, May 9, 2023, at 10:08, Vignesh Raghavendra wrote:
>>
>>> Also, see [0] for history. We really want these to be
>>> modules unless its necessary for bootup.
>>>
>>> You may want to revive [1] and get it to mainline
>>>
>>> [0]
>>> https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
>>> [1]
>>> https://lore.kernel.org/linux-arm-kernel/20230110153805.GA1505901@bhelgaas/
>>
>> Agreed, that seems simple enough. Ideally these should even
>> be removable modules, not just single-load but unremovable.
>>
>> Doing that may require changes to the cadence PCIe host
>> code if that does not support unloading yet (I have not
>> checked), but should not require any changes to the core
>> PCIe host code that supports loadable/removable modules.
>>
>>       Arnd
> So, my understanding is that following change is expected
> +CONFIG_PCIE_CADENCE=m
> +CONFIG_PCIE_CADENCE_HOST=m
> +CONFIG_PCIE_CADENCE_EP=m
> +CONFIG_PCI_J721E=m
> +CONFIG_PCI_J721E_HOST=m
> +CONFIG_PCI_J721E_EP=m
> +CONFIG_PCI_EPF_NTB=m
> 
> I also want to inform that pci_j721e.c is a single file with both host 
> and EP functionality, last attempt to build it as modules depending on 
> host or EP selected failed because of symbols dependency.
> Refactoring of pci_j721e.c into common, host and EP specific files could 
> work similar to the Cadence driver, So I will follow this way and push 
> the changes.
> 
> Please let me know if there are concerns.

Aren't HOST and EP just customizing main module?

Best regards,
Krzysztof

