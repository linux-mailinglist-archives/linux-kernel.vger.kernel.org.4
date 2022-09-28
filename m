Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800A5EE3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiI1R4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiI1Rzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:55:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE13F8FBF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:55:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d42so21612727lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RySF/FjOO1GJmZpMt3yLrNw0vVaRtkwBKj/MtxZCzyE=;
        b=I8SJ9poqEvCIk2DgzRT7ZquaH5ic5s5zWfRGu57XknDzHcbJ0d2+5tufNgaX+SZOgK
         iXa5GECZs0kE8YaAazIruVRlIwbRUXnhGZXgr2YB/YXf/7pBfQBJaovfCJVNFXH5DO4m
         w8EQuty5M4R+O3vn8fxtE9FkV2mHoq3ino3thSrjFV89HwX98HlYZAljHJ7p98i7eScu
         SCmXEyzlUS4NU0cGFyVlbClD0mnM85qZVR9lTT9IJvg3EsFAbNfwF2ZsNlLI/o6VLQwl
         A03to7J8JTG535P4/tSjV3epoBL0kAydF+bxmJelz0uoN6rfjSjEM6cDW4oI16+GXXhh
         /ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RySF/FjOO1GJmZpMt3yLrNw0vVaRtkwBKj/MtxZCzyE=;
        b=rZnecW5RLlIStjar+Jk405qPLFhf9ZUFdrg4XeovKTBiYEd3jFz3wfb3K8K2uuPq0w
         kyuhAA9kzqV1IpvT2yvcpNgfmdS1Gyjh4E5vqviV1jO4OzdpVBeJ9f9GblL1BCM8q9Pz
         pnsYdd1mK6yE1/wFwSxwKU/Dr4eWPZnEsFG2/x3TdpuGZaZ/u5Daqd2/sR0pTTH/9vnV
         I+DN0D1kuLv46dyPN8Hp5kA/CUksLG0yqAhbGJDEppFXUdN/HZw9qyFhsTfdj2TlnzNN
         x68dkCpE6d2dttocao5JhG818msMg2b/lx6lvh2tRqdA1VnyyKzpjUD9xvtyeTQPp11D
         DXEg==
X-Gm-Message-State: ACrzQf2m49w4VOBYaFHgXfJ8CWKh7zAcb0pPvglKcd7HQwP0z2huZnL3
        /SKfZebVFY2uvHbf1K/Rg2ok+A==
X-Google-Smtp-Source: AMsMyM4PwrV47R+BLXnK2qxEhAboUnRzt6mhHLgt2feQ3YoLSJUFN+6Ute7NLQOGoXEJwNd4u8VQjQ==
X-Received: by 2002:a05:6512:3c88:b0:499:c78:5bb1 with SMTP id h8-20020a0565123c8800b004990c785bb1mr13483062lfv.503.1664387748009;
        Wed, 28 Sep 2022 10:55:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z12-20020ac25dec000000b00493014c3d7csm528592lfq.309.2022.09.28.10.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:55:47 -0700 (PDT)
Message-ID: <2529003b-b253-9764-1060-02aafdcd44e3@linaro.org>
Date:   Wed, 28 Sep 2022 19:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/7] arm: dts: qcom: mdm9615*: add
 SPDX-License-Identifier
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-2-b6e63a7df1e8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-2-b6e63a7df1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:14, Neil Armstrong wrote:
> Replace the licence blob by a clean SPDX-License-Identifier
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 


Rebase on linux-next - you use old Bjorn's email address.

> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> index 0827de5426c1..073c15354483 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> @@ -1,46 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR X11
>  /*
>   * Device Tree Source for mangOH Green Board with WP8548 Module
>   *
>   * Copyright (C) 2016 BayLibre, SAS.
>   * Author : Neil Armstrong <narmstrong@baylibre.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.

The text is actually MIT, not X11. I think they differ by last X11
trademark statement.

Best regards,
Krzysztof

