Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86E687818
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBBJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBBJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:01:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D154542
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:00:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3201049wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKq4treMgsTZRQILo8co/I9Ikhm/khYV4Rk1K1haA+o=;
        b=ke2QSu79xcXZE3aviAuMKJB0RiGvC0HU1IkEzQCn9BWGIDp+8J87I596Wpl3vtefCY
         T3LMFALxH2p68zIH22LzxnzCpsO7dI1RtjabOWdl7heuMF6yj2cD5xJyH5FnQUV3oKo8
         XZYkO+7XyoFtwYgpCcx+WhkzemkNm5DkPP2MnkR457eQBgEYHf7v/XCJAN0RLVbfv3f4
         kRVrO3l3JO/Z51P8/5Pw8ACYazE67NTJnc62fE3Qm6m3d7UWZvJGI6QFNWx85JAPAEWd
         JSDT0yO+fxE7EDn3CQC4Ls0PAlVhM+le0+rXlAqV3/JSa+WsGLOytkI9c/OV9t0sL1vS
         /fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKq4treMgsTZRQILo8co/I9Ikhm/khYV4Rk1K1haA+o=;
        b=utCUL6MgBlXQbHZ33XTmTFsZkFYJ7kqkaPKP/+1uQh+gYxBLyU3hWxoJRx/9dbExVe
         wa5Twn7z9L1rXsijGfpW3t6iRkfXVe50l59GCsNgB7PQh/+PuDrJUfbtRNNwPEmuSXal
         d9wkZ134ZW7oectCEVA1M9sdme+BdFAQeQyyWFDOU4m3e48yJMtnzLBjYyWDL0B1FBmv
         yuD/jQVw0UyZP5F6s+MlEjOA1ZY89Kbes64OxqU2JqqwwepbX2CLmEuqJQ6XlEGejKgY
         5QdMJl8mVRvNljn+LtWAdwsptcbK/K3aTEPKjRK/1sT40MwKwevIm33bnLwpqJA2lZRE
         rdoA==
X-Gm-Message-State: AO0yUKVYDM7lBCbPwX/toTMV45do62h1q33+4Y2/JSsOAeE4YgC0RBHm
        JQdetMasw7oUaR78FY765lCh1w==
X-Google-Smtp-Source: AK7set+tyNTV3l7sW0JxoBoTjOb8RNLhrkTDJKOM6kz+QcCPq6BNZ4oMn9RCe2ZwvLOjHwOTVQ7lcA==
X-Received: by 2002:a05:600c:3d8a:b0:3dd:af7a:53ed with SMTP id bi10-20020a05600c3d8a00b003ddaf7a53edmr5251781wmb.11.1675328447118;
        Thu, 02 Feb 2023 01:00:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c424c00b003db0bb81b6asm4000970wmm.1.2023.02.02.01.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:00:46 -0800 (PST)
Message-ID: <ac9be40d-bbcb-02b1-2708-61f88095111b@linaro.org>
Date:   Thu, 2 Feb 2023 10:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/3] Add ASPEED AST2600 I2C new controller driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 11:33, Ryan Chen wrote:
> This series add AST2600 i2c new register set driver. The i2c new
> register set have new clock divider option for more flexiable generation.
> And also have separate i2c master and slave register set for control.
> 
> v4:
> -fix i2c-ast2600.c driver buffer mode use single buffer conflit in
>  master slave mode both enable.
> -fix kmemleak issue when use dma mode.
> -fix typo aspeed,i2c-ast2600.yaml compatible is "aspeed,ast2600-i2c"
> -fix typo aspeed,i2c-ast2600.ymal to aspeed,i2c-ast2600.yaml
> 

How this can be a v4? Where are all others?

https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600-global.yaml
https://lore.kernel.org/all/?q=dfn%3Aaspeed%2Ci2c-ast2600.yaml

I see it for the first time.

Best regards,
Krzysztof

