Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3C71615E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjE3NRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjE3NRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:17:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBAC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:17:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51403554f1dso7010328a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452666; x=1688044666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlNRAu+sEqLR68lQ/UatfZNoRCWXT5cJKm3Hf7V3cqY=;
        b=f33JruTlMMoPyVZkVavi0A8dxukxKGnRaj+eiilvbN8KQ1BhNxAH2fgnQlW6hT7los
         cyTU52WlvsApotwNQHpjaVYOs7XRCMVsPDDQFEWvUV6AVu2UD8kuqLaT7iFeX8AZQ8TN
         p2XdXV/0788Q80hkom3MinHMcMOLxp1fYBVEY7rIUpxxuVQPghvLxcm90taS72++Ll4Z
         WRVTVi4hGV6XcpxcB5/7n+HK9rnO/Mgmb5OrirRnRX/4YgLYIdrANYVJ/23WpSqD1lKe
         5YfUX2jS+5oME1Z0yMWjvUj8aZ8zKoYgwTgkUOiKRM8XoTE677gZMmbPrN1D5DH4LYMj
         kSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452666; x=1688044666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlNRAu+sEqLR68lQ/UatfZNoRCWXT5cJKm3Hf7V3cqY=;
        b=AHyANtvtVHGq/fGiApAV6ZCF3VJxhWsQ/Sq4ceKHe/vFDzfHukivQRi/1bmgM/bQQP
         hNOruXY1wOftZLsYlbjyZ7qtSPSefFnTao0wsBoxoDU5pTsHrAX6U2EMbCD0DodCbIQU
         o/5njl/rZgXgovzP8tVtTHifTR5bUmYinKlKE/QD6HKHdrAg0B2O7/IqXbGF70CK5WHn
         NTKO59Vi/vUfb7FksyjjRWeBdluKsKm4LWXJutu4V4mJisKa8xV6ilN2MFfvyOLCc0t4
         mPFNuLvAjIBQF4XFlKotgKvaG9NimGfnAyiXqeV/wKaZGWE+M7KdQOeQOBuFdZjI0M1B
         WtMg==
X-Gm-Message-State: AC+VfDy6GM3kqCW4/eayRQhXW8/QYC33W+YfTr6qoPJq9OKUeD3CpMuG
        wNJMViXdGuYNivuf3lxN0jIm7A==
X-Google-Smtp-Source: ACHHUZ50wxHHnMyT/M88twI82FLThHbRKUAp3t34rKhe2wbJmxLklwc1X5L/E5GjzkfV5y5besrNcw==
X-Received: by 2002:a17:907:7206:b0:974:1ef3:e6d1 with SMTP id dr6-20020a170907720600b009741ef3e6d1mr1727125ejc.9.1685452666001;
        Tue, 30 May 2023 06:17:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id m22-20020a1709066d1600b0096f777fc1ccsm7235383ejr.200.2023.05.30.06.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:17:45 -0700 (PDT)
Message-ID: <83fb5973-5514-6c66-fc15-84fb439f1398@linaro.org>
Date:   Tue, 30 May 2023 15:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230417125844.400782-1-brgl@bgdev.pl>
 <20230417125844.400782-5-brgl@bgdev.pl>
 <9f2c0b2d-b11e-512f-1566-5097547c60d1@linaro.org>
 <CAMRc=Mey2mjNppokxcNBTyaZPTjBkiuQX-DHTvMXJkiLKq7UoA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMRc=Mey2mjNppokxcNBTyaZPTjBkiuQX-DHTvMXJkiLKq7UoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 11:47, Bartosz Golaszewski wrote:
> On Tue, May 16, 2023 at 1:42 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/04/2023 14:58, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> The GPU SMMU will require the clocks property to be set so put the
>>> relevant compatible into the adreno if-then block.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hey IOMMU maintainers, could you please pick this one up for the next
> merge window?

I think you missed to Cc them (except Will).

Best regards,
Krzysztof

