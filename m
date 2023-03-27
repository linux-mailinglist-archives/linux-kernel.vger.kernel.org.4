Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0A6CA135
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjC0KWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjC0KWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:22:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E661A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:22:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c29so10720762lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912551;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXuNWn+kwx1/pVD5N4boc9q0CgRFBEBRRr2sRkN+SN4=;
        b=cwF5ErRR+qEDo0+T4zOR4jg1boWAGPkaZJymyGJGbK3R+fC61Cn7zLoNsaqTnln1iP
         V043SOgg1QBKyNOihel//YzABPaynsyKEIPS9dvixrXiNp4gevxsJvX/E5xpko0xuem9
         eDQ8jGxY4+1HG+c8XDJzhVvc3lvNqrU+tdBYjccwLwpWTYozqiKGele8eag7MaiG7zY+
         zWWkutCtl6X5+w5iBtYPshQYCCr21ArVdKjUtRBteZPQxFO9vXml1hy7PkM9BZVtNsLR
         Hd+4bYiknSz4DVDmQhxrhA/mJxLE4cASg8KXuJG+s/EuAUpEBhS1lAX622klH3UP1bK/
         x68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912551;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXuNWn+kwx1/pVD5N4boc9q0CgRFBEBRRr2sRkN+SN4=;
        b=amIiCXiauz4NjIglR3bdnTDASFut5/khk/GDR2qNNsyuSSSnwuhEJEDyqDGMtkUq8L
         Ua8TmoWt4jJprFR+LTf7WVEhrzj9xrgUKbieIT2AK5i5mQv4OmCekLK8yWaOpiCk7rSl
         OCm0FzKAvaxAJ4CsdnPFRNCfUgUpXY7Cm9ztlX42GTOZYwlz105Y31EZAEyPiH0vj7ib
         kH5UwvK1P2HYScu6bPyF2vLb3z4JMDkoB7KAU1MBGfmBpZpCWpLvGPiu3yOEQrALfnBr
         S0Obh3jKCsOq+J0sTf8TpzoEfvlZJA8Z39NLRZaIuZLd3RZkEMkQL8/6438n2WiGFU50
         cu1w==
X-Gm-Message-State: AAQBX9dHMtd8jc0YlHArOLjlUDOUsvec92Qdna8WuZqkqjVCbJ0sdfpj
        bcjILgfpCeeK24UmBBhSWyEaKQ==
X-Google-Smtp-Source: AKy350bDp4KKf73jwCTmhjkPKmh9+gjpKxmjaff2URSut+nOkp8CGfFIaLZSpnZlvGMATa1FrEEnTQ==
X-Received: by 2002:ac2:4219:0:b0:4db:28ce:e5ef with SMTP id y25-20020ac24219000000b004db28cee5efmr3021764lfh.0.1679912551323;
        Mon, 27 Mar 2023 03:22:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004d0b1327b75sm4627086lfo.61.2023.03.27.03.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:22:30 -0700 (PDT)
Message-ID: <c49d6297-5376-ab9e-886f-e9df1f815bc7@linaro.org>
Date:   Mon, 27 Mar 2023 13:22:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sdm845-xiaomi-beryllium: drop
 invalid panel properties
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
 <20230326155753.92007-10-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230326155753.92007-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/03/2023 18:57, Krzysztof Kozlowski wrote:
> Panel does not have children with unit-addresses thus address/size-cells
> are not valid:
> 
>    sdm845-xiaomi-beryllium-tianma.dtb: panel@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

