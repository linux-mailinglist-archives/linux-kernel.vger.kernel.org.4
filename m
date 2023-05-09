Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAE6FCD81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjEISKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjEISKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:10:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764D5B8A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:09:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1230451366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655798; x=1686247798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtIwXP7XX6CNvX90xvzkTb++FzwrEZ6PL4sjQf/MAoI=;
        b=MjcfYztGjslc2Nn0eLKw9epXhQfiBsr7oQT1euGYEJff/qnIHXuBsaUcLkpeqUazO+
         XFAyqJfdsa0kMtC50UBmyfLXsCxKCdaEVzrkWsMTPVHZzfhq/T9d+I8Dmk67bk3Wo2Kg
         o3AatLjZNitUC7ZfvA+znLfiOhfPUSeONqoEtLD7ZI7bHb64P4Ypg1MXPiTOUwseqO3a
         VoTioSogb+r1CzpKFx8eTeT8HPw8ws4tp9pscMgjIMLeVl/n02g4W0aphgoYjFXWUwtc
         xTPUW/rnwGYJjRKf4GWNpLuXdn2l5VCiAxCRUV20kgZiN0ebEnxdB3DHUkrDqbtsQSP6
         KmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655798; x=1686247798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtIwXP7XX6CNvX90xvzkTb++FzwrEZ6PL4sjQf/MAoI=;
        b=Td2dekQheqxh7qD2t4Ip+tdtErMT5D/MuJreDQbTjsYL2DwHauLLiBkud+XCiXu+2I
         4V3GDyyYI07uAv0u/UZ/jjXGR+xs8YKTBbquDJVIMZCcOxLz6IH+PNfX4cWvo+QcYgTr
         V4X4uGm/5d09AoHZoA8Rx13P4vKw72F6XGF97dlnjlGg/4ilrzTc1LbDFOzyMwChIKRg
         nVVIyTSMSDplxIlzKQ7nwrf4pF/sbXyo4vbDeaMdafiDxph0BPPhlueb4xnDRbR7bbqa
         036ypzH2ie7F2PLzcCqc4H7Z1BTwJM1WiZ0bSb+lnnoITW+fC7VPTFMkKhUJ+XbtFTQp
         Lhug==
X-Gm-Message-State: AC+VfDzLRrrFvW4IGnqjiU2kMZ7TNMezW8+DHbUuQ26eB3jefmRvP6X+
        XqN4QO46xWkmsF8rv1MP5PcBvA==
X-Google-Smtp-Source: ACHHUZ6NF2Ql91suaaPN6PxHtMSdFZkdc+FSwOb64SB30td68JOV/MfNrqGsZjkOqMyccWiEb/SgHA==
X-Received: by 2002:a17:907:3f87:b0:969:bae5:fa3c with SMTP id hr7-20020a1709073f8700b00969bae5fa3cmr4428101ejc.63.1683655798395;
        Tue, 09 May 2023 11:09:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b0096776c39540sm1615493ejc.31.2023.05.09.11.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 11:09:57 -0700 (PDT)
Message-ID: <5fe4a4c2-e65e-0ac9-25e7-7554d48d81d5@linaro.org>
Date:   Tue, 9 May 2023 20:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/13] ARM: dts: exynos: Fix some typos in comments
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
 <20230501195525.6268-12-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501195525.6268-12-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 21:55, Artur Weber wrote:
> Change 'specfic' to 'specific', 'optiosn' to 'options' and remove
> duplicated 'are listed' in DTSI heading comments.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---

This needs rebasing.

Best regards,
Krzysztof

