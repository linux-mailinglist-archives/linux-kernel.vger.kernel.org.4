Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BA67801F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjAWPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjAWPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:41:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45083298DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:41:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t5so11223980wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXCK8+4pwBoN/PPZdEC5uZ0441SKSjWCGzz9sOXF4WA=;
        b=Gq7N/5f/dm907S2s95WddCgz2SPDJqx3jdQjw63tObNUotX8A1a2nwEQTIW8zLc0Bc
         32Ow2LueltQlPmFD27f3FiTg8+gy4lXPOTAEvCKMwLykk+YnCH9QOPqg6FhyXWijJtyZ
         59H0hdbLitzR0OuveGHOcXUhmgTDyZyFM/3dDMhwD/n/qKdf2a5hnTxCVGlDG9vTT5gs
         /b0iXquNdt1ZvKxoABL9FXeZCEIVBbk6AyNHp3Dg4Koa4FZ0febLMj6lvtWb1+cVQmtL
         9BjCADRSb0hhSHj1ZZzacokBiYCtFXPOe0KP/odN2uNCoOC5+H9t75lUAcHxQKzcSQgi
         4RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXCK8+4pwBoN/PPZdEC5uZ0441SKSjWCGzz9sOXF4WA=;
        b=OdTOEzcTY1ssMwdKhwwZGZIPAClG/YGl1vUEUKC3zGSHsjU4Lu24ziXe7BNC1yz2QB
         hHXXPkc/GOrR9fSDdXItMB5HSxvJ3VTXR+RAbLr6n8prgEHj3oBhkFI1x/i4S9iIj7AN
         PfwRdsYToBClAIBnHHi5q+3AY1vr6SmKCBVkdaEdcZeI88Zc+5jbjrZ57f8J7eTyQ2gz
         Z4PFJbpymVQw/mSJTO64n0f8oWsoYF1qmoj0lQ0tTexw5WRfKpDeK2Qh2xHpONGSAK1r
         Y3mDlaKSphMOhNBIuVEbKHjsXmrwsvf5DGWxMwZKQG2jaaNLAhiIdod2Rj9aC39uxOHO
         1tDQ==
X-Gm-Message-State: AFqh2krmVgIp6DFd6BrAqb/eygR4t3LtByL7ygMArqEKBY9E+jxueJyb
        jdqjq/vVeGfcfTsY/ltecoyUqA==
X-Google-Smtp-Source: AMrXdXuBoUwMvAd/YfOcifByrJaMm2ho3lHEp8fql+PNjdwlzRsoBXxTm0E+49t+J2WwjGL6pXs8KQ==
X-Received: by 2002:a5d:63c4:0:b0:2a5:3a52:a034 with SMTP id c4-20020a5d63c4000000b002a53a52a034mr19494443wrw.35.1674488461847;
        Mon, 23 Jan 2023 07:41:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n9-20020adf8b09000000b00241d21d4652sm4602308wra.21.2023.01.23.07.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:41:01 -0800 (PST)
Message-ID: <9000e022-69be-3324-1e6c-a255d56a1dd8@linaro.org>
Date:   Mon, 23 Jan 2023 16:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/13] dt-bindings: serial: cdsn,uart: add power-domains
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
 <20230123151302.368277-5-krzysztof.kozlowski@linaro.org>
 <26046a72-27e6-213f-6b69-5cb82367dcf9@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <26046a72-27e6-213f-6b69-5cb82367dcf9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:39, Michal Simek wrote:
>>
>>   examples:
>> --
>> 2.34.1
>>
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> btw: I was running it and I have seen that properties are checked only on nodes 
> which have status property okay. On disabled nodes properties are not checked. 
> Is this standard behavior/setting?

Yes, because disabled nodes might be missing several properties (e.g.
clocks or supplies).

Best regards,
Krzysztof

