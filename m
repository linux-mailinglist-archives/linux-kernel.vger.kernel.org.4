Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6166792E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjAXIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjAXIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:17:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531672B6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:17:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso12224271wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiP0gZn/cpqwNmZsHPi77/HmJt+0GSm02rEXJE0mZuc=;
        b=rz5WOHaNNlWgEXLRbetKeX7R0dRN7zSC9YmNQarI9o4w7Tq5jxfXRqxTsxgHzpx4I9
         0yCwad4pvGwH35vsywIACFAKq4+tmuXHMABvAo0ziD9anYJtCqDdCdcshYllGX+jL33S
         V2jUHNwZjihkw5PkuVs6JSLbPqas8jVCHD1eRQgn0qmI9O5z3akmD8e0KxYGOkHPcExc
         Fs2kH8M96BLXC3Qw6sek5qgvA/pZtumGefcPFbod9+08KQP1qc8bRANz9r4AuZ40tlvZ
         UWZ75isPIPXvR1YDxyxT4wsID9oqc6K65nm1U6AzoDk60eiCoeQHwjb7C+rjvLNcASJE
         as0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiP0gZn/cpqwNmZsHPi77/HmJt+0GSm02rEXJE0mZuc=;
        b=6GhhF3DANFdevqjea3MdepsJvvW3CZddypB3QJqhuBowtNaI22WyejoRQTltMaIHPm
         hboqUsXrkVlvhn5ECanbN65K+jRmGeFnj/G5I1aQkJXOrjsS2QenW/7baUxto2XBrPRc
         3poADhk2QWewOB/8x1QU0IoBGZBSHjzswyuLk1RADxcgWXRNgygN+NLHw/Q4pVuX4Dhy
         KJLsfMSLvbIhxGq2yIpQmYaVX4mcCzynPD0+zIdxGbrvNAPeVTZIdNrgPDk3Ohn00gYL
         fkb5JrU9/9gcocgYJly3UjwSEdmEsLUzshrH086p49aeJjDnmWcfMgOn6rsEa4DllA89
         sunw==
X-Gm-Message-State: AFqh2kplZ8aZkRWt5QaTKkbEEyibDQoM0iPQWrvZV6PtwsNWZWexlOYx
        b6i5JTjxEIIEGB5X3GhI+5lepw==
X-Google-Smtp-Source: AMrXdXunRvOxaqJzjCgh5gUlJhksZxNRxnNWUPvYFTObnizcuMzYRwgIcDkar5wVJKqfvWoZ4n/TQw==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id f16-20020a1c6a10000000b003daf6655b66mr27262779wmc.6.1674548268129;
        Tue, 24 Jan 2023 00:17:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b002882600e8a0sm1298395wrr.12.2023.01.24.00.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:17:47 -0800 (PST)
Message-ID: <934be0a4-3639-5f72-cf54-b796b32df484@linaro.org>
Date:   Tue, 24 Jan 2023 09:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, Han Xu <han.xu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Bert Vermeulen <bert@biot.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anson Huang <Anson.Huang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
 <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
 <20230123201751.GA2450665-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123201751.GA2450665-robh@kernel.org>
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

On 23/01/2023 21:17, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 06:39:32PM +0100, Krzysztof Kozlowski wrote:
>> Cleanup examples:
>>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>>  - drop redundant blank lines,
>>  - use lowercase hex.
>>
>> No functional impact except adjusting to preferred coding style.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>>  .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
>>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
>>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
>>  .../bindings/spi/cdns,qspi-nor.yaml           |   4 +-
>>  .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
>>  .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
>>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
>>  .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
>>  .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 -
>>  10 files changed, 150 insertions(+), 152 deletions(-)
> 
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> index d35c6f7e2dd5..18afdaab946d 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> @@ -95,7 +95,6 @@ examples:
>>               <&dmamux1 1 40 0x400 0x05>;
>>        dma-names = "rx", "tx";
>>        cs-gpios = <&gpioa 11 0>;
> 
> Looks like the indentation needs adjusting here.
> 

Ack

Best regards,
Krzysztof

