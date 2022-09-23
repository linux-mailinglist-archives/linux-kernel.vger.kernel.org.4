Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46895E819C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiIWSOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIWSOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:14:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00396FFA7A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:14:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g20so935996ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oMvGRyf6B1xSW6jldiB/4L2hCW2oiTVar6DgwfxZevA=;
        b=joMXbDUN23NrSPuFVRuQxyZ18+85jHWvFlgB5rHkyQB6MuTQv+11Blst3Emk2PKY+n
         nQnCehdvxQMvsQA4btPpAyPP7A2rskO/wpWNTd326VLi8qNLiaxtGTsbjoX+ObpiCpJm
         J0XwvrZycGuZOZVovoupWtzvwrgXa8V/+Stgj+L2zVD5+vIf8S8/dQGNT4ECX7/na9dK
         5ZrHOBzj5+T0zFen0C0YlgJjDGjqrrYvSllJnoBgLL1qLQEjpVVCO3efy9H6SOOqBcm7
         TV+wstyMe4wWuqQKw6QpkQHV2tLOj0lk3tSZefrxu3+P5luZKiLRGS3ChfdurG1sEBAZ
         2YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oMvGRyf6B1xSW6jldiB/4L2hCW2oiTVar6DgwfxZevA=;
        b=vThYk04FHOpmCclegyWs8c977Y6og88722NHx4YcdbowhPtGJMc1Ci+yR8b1lfUEuk
         jmmhnvfmV4IQkCm/PXq+rirMKPL9cs8B3tIuh+MgNkgg33CmRV7JcJXpa1vkoyhKESIS
         yhwI+BNPGCp4DhgV6rSzoDHP5WE1xoaXICZLPDqJrK4gW+pFo+L9yVzB0pEGoOxkiv+D
         1XPT/vIDS94bF5W/tz3nVYL9t25R6GRUKjv3B5HTNMdqHeQvTJFQFqoKj9mxk+CfTUbt
         ZZU9ktbZ04qXjlFyb283Bm4DelOxVA+sRbjc/P+vBBNkcnFrrSCLXlswI4FrbaPD+rxN
         GRKw==
X-Gm-Message-State: ACrzQf04tgjw01N/ZBm81dVp/G9GyfhSPbq7ga37nCsG0F+l1ILaXP3h
        bnFY+5thvV7D5dNPjzB0yhMgrg==
X-Google-Smtp-Source: AMsMyM6ZNkXX2AkLZWL390O0wf6Nou5HbOXvCjEuUZ/Qb6dNDl3VBmNR01p6Z/h5HcJXrDEEqprZhA==
X-Received: by 2002:a05:651c:19a6:b0:26c:4a66:aa42 with SMTP id bx38-20020a05651c19a600b0026c4a66aa42mr3624111ljb.231.1663956849278;
        Fri, 23 Sep 2022 11:14:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004a0526b11ffsm415225lfs.133.2022.09.23.11.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:14:08 -0700 (PDT)
Message-ID: <ac24dc0f-0038-5068-3ce6-bbace55c7027@linaro.org>
Date:   Fri, 23 Sep 2022 20:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 4/4] net: stmmac: Update the name of property 'clk_csr'
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jianguo Zhang <jianguo.zhang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220923052828.16581-1-jianguo.zhang@mediatek.com>
 <20220923052828.16581-5-jianguo.zhang@mediatek.com>
 <e0fa3ddf-575d-9e25-73d8-e0858782b73f@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e0fa3ddf-575d-9e25-73d8-e0858782b73f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 11:10, AngeloGioacchino Del Regno wrote:
> Il 23/09/22 07:28, Jianguo Zhang ha scritto:
>> Update the name of property 'clk_csr' as 'snps,clk-csr' to align with
>> the property name in the binding file.
>>
>> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 9f5cac4000da..18f9952d667f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -444,7 +444,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>>   	 * or get clk_csr from device tree.
>>   	 */
>>   	plat->clk_csr = -1;
>> -	of_property_read_u32(np, "clk_csr", &plat->clk_csr);
>> +	of_property_read_u32(np, "snps,clk-csr", &plat->clk_csr);
> 
> This is going to break MT2712e on old devicetrees.
> 
> The right way of doing that is to check the return value of of_property_read_u32()
> for "snps,clk-csr": if the property is not found, fall back to the old "clk_csr".

I must admit - I don't care. That's the effect when submitter bypasses
DT bindings review (81311c03ab4d ("net: ethernet: stmmac: add management
of clk_csr property")).

If anyone wants ABI, please document the properties.

If out-of-tree users complain, please upstream your DTS or do not use
undocumented features...

Best regards,
Krzysztof

