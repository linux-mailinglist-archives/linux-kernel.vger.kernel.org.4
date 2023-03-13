Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DA6B735F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCMKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCMKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:01:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F43757D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:01:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z42so11937938ljq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678701682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8EVi5ERJnamFr2Gsb+8yMGGkxRY6AZZMTHAy+zY/ds=;
        b=ZbczpPemcGtSDV7FvBq8HO4AIt6ZjSRx1dmY0hiI6opN2P7VUpcb4TN8MuyV2B1ncd
         K3tUxAHx6HrivDBc/ppDebQhOgF82D+ZyMnHn5Uw+SeWkOepa8RYoeFek+/BvBjBLDxa
         7hdOAQygmZICWG1SQ1i1+2DnVA/XLiVGo4yXsArwtRs6MNLvd0YkfqAiESypEPg7P1OU
         1AUVUwtAGqLOPaWu/faxlrSVqeFAGE+n9J+XmaJPBHGBW/v11YyHUffWeuk55EG9jg1W
         aKGxTeum6FHYvRhnKI6JWQt6RxG0jhASCAi8Ey1S6IbIQU6DHTyuz5m/IGrmxI862GDa
         ZdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678701682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8EVi5ERJnamFr2Gsb+8yMGGkxRY6AZZMTHAy+zY/ds=;
        b=LPOJppJuvjDR4vGJb9OhpreXKojVJbD3/FWzk3Cm4gnU4c6tnJjoLulBW/OJJqT28b
         QOqqq45qubFMbcuC1GddzNdz1AdOCQgtxCug1swvAzIPiGm0qFIqw1zUley/WIC2lnAb
         l+yam0tLzdT4DdOhTBnQDmM/WaITbChS6cr9bHnmHkVcXkOSsGoo3Kkr1jyvyGtwuEwM
         MDW09xhAcf9EQwFSNqekRmoL1/cUu7xOsY71AW+XrN3i+FTkVhLHeSqAECclFQ3Wle9H
         2lv/tSltLlP8Xh/u2BNK7Hb9MdR1+x11gYP/LieAjnlU+xywQyyRrG/jZ4dzs/Zy2yK9
         sWCw==
X-Gm-Message-State: AO0yUKUzLkPaGkcbPtIjFT4sFzJZXmsJqZQsVlBa1ZOnWY8hQCMrcpmr
        2M/ofqH1KyRdxYS0i8g5cwxhek0OVaswvn9MDiU=
X-Google-Smtp-Source: AK7set9s0h6K73aYDAdMN5kpvI7uPOC8vE1OpRRr1Gnk+9BbSRSZRLnZIQBQj3kdkLkvJdJmi1ULYg==
X-Received: by 2002:a05:651c:304:b0:295:c3cf:e81e with SMTP id a4-20020a05651c030400b00295c3cfe81emr9979963ljp.19.1678701681807;
        Mon, 13 Mar 2023 03:01:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9556000000b0029868d1820dsm923524ljh.60.2023.03.13.03.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:01:21 -0700 (PDT)
Message-ID: <13ad09ae-1995-271a-1079-f9e4f6e06eb4@linaro.org>
Date:   Mon, 13 Mar 2023 11:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230313071325.21605-5-quic_kbajaj@quicinc.com>
 <202303131722.uo5Li701-lkp@intel.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <202303131722.uo5Li701-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>>> drivers/soc/qcom/llcc-qcom.c:20:10: fatal error: 'linux/qcom_scm.h' file not found
>    #include <linux/qcom_scm.h>
This moved over a month ago. Please send patches against fresh -next
and not some ancient tree.

Konrad
>             ^~~~~~~~~~~~~~~~~~
>    6 warnings and 1 error generated.
> 
> 
> vim +20 drivers/soc/qcom/llcc-qcom.c
> 
>   > 20	#include <linux/qcom_scm.h>
>     21	#include <linux/soc/qcom/llcc-qcom.h>
>     22	
> 
