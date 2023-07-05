Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC3748114
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGEJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGEJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:37:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097B1984
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:37:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so399254366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688549838; x=1691141838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3temixJ6Fkf9izigan+iMmm78OhnHSIa1ec6GoB2uj8=;
        b=aLRLcWFzUQQqvBurnmFQqswp/Ql0mwi1v+kgXnLKzEhZYuPTqgsUuPeaDL/6G3DAtP
         8ZmTfbbKkVPioSbHQYY7jqKsoArmdTbIXuTxnh1kg7KPjurvgoQN5DNSYIKD7p41MUrO
         rMmtWg+C4TpKuNqQnTGtSvgvTp9bLsu6b/hah6PXtQlJAtoaGPEOTYZtJMoma7hSPYEk
         14iugakvA/fQofY76/CTiiYz1oU1CwYwRpFj+MW3WvT494x6Y26P5rRj6SJcGfMlNBDX
         h6OW2SHZl+L9kHqt2aHIcuauR+7iuVqP8FzcTrf34gL775vz5kQ9t2ojdkdZvZMvzgCM
         uWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688549838; x=1691141838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3temixJ6Fkf9izigan+iMmm78OhnHSIa1ec6GoB2uj8=;
        b=gWU5aUjO4sQv/Ddp7S7ErIW8KsuS0AmnU5wLBQYj2WECnfGumLdR97TcLXJUeTTtjt
         4y4UbgvMPzwRp9d4ikCMkMenMoccbQ+QutPbdRkC0Rw0kHeYvaCQibJrTVoTe1thVCTw
         V2hWx3bzt75NJCxnQwNcfFGlJIsgMTSPVgM5zQoyMxETmJVjOTiik5Hyzh+dYNfhpKQp
         SMm4vEGETw5U6uQYxAEkRjelkKXjjb676tjRm8XQpQ6tlYBSn/VVFa+vjJkPtBE9RZKH
         QlwM8SkzJSPmle+ux/+yKuie+Mo2u1wWj2/D3+gedY7Q/MvGCUniLnywB0+z2PXpnVT1
         QyYA==
X-Gm-Message-State: ABy/qLbtqMLQJdP1KuToE5E5sbwJfwj0650r9PEZyIjy9Fqf/dFEwTOd
        lLxAw5qHqiICDA+rOq9V+CYDAA==
X-Google-Smtp-Source: APBJJlE6MJ95nug/jztU9D00I7Ejzm8oIjJb0qAUuf3oiu2yf7ucApr5lfPeWSojp/OseGZ2Q66SiA==
X-Received: by 2002:a17:906:82d7:b0:974:4f34:b043 with SMTP id a23-20020a17090682d700b009744f34b043mr12442202ejy.1.1688549838013;
        Wed, 05 Jul 2023 02:37:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gx23-20020a170906f1d700b00992dcae806bsm7199530ejb.5.2023.07.05.02.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:37:17 -0700 (PDT)
Message-ID: <2d9b2341-84ca-d152-8a42-90b815c66125@linaro.org>
Date:   Wed, 5 Jul 2023 11:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
 <61e9e380-dcb0-4dd4-562d-bffea2da5097@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <61e9e380-dcb0-4dd4-562d-bffea2da5097@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 11:28, Ahmad Fatoum wrote:
>>> +        items:
>>> +          - enum:
>>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
>>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
>>
>> Same comments as for patch #2. I think this should be rather deprecated
>> - not a good pattern.
> 
> The middle compatible was my suggestion, because there's also the Debix Model
> B Standard and Model B SE, which is the same board, but different SoC variant:
> 
>  Model A:          Commercial Temperature Grade
>  Model B Standard: Industrial Temperature Grade
>  Model B SE:       Industrial Temperature Grate, but i.MX8MP Lite
>                    (No Neural/Video/Image accelerators).
> 
> As everything outside the SoC is the same, I wanted a generic board
> compatible that bootloaders can match against. The SoMs should probably
> not reuse it, but I think it should be kept (perhaps renamed?) for the
> SBCs that don't utilize the Debix SoM.

The order of compatibles in patch two does not really look correct,
although it is accepted in some cases (e.g. Renesas). But anyway "Debix"
sounds like a vendor - they even have website - so compatible for all
boards seems too generic. This should be compatible for one specific
board. I understand that one board can have different SoMs (it is
common, just look at Toradex or Variscite), but it does not mean that
board should be unspecific.

Best regards,
Krzysztof

