Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57116045FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJSMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiJSMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:52:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D283F17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:34:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t25so10549725qkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PX18bToPOnvPyqbrZjvQaY5SwM0Ct0C5YKtPYXd9P9I=;
        b=rDQlZYT8SxjtV9ek3IiNUMnGCGrzvBJ5gDbOz/qnFZG3R7+MMCdF+PMSptg2eRMo4u
         nzp/fwAnNuann98pfuxf5pH79MDwO3LWITubYsb96DyVH63Qb9HGA4Quwu9qNTnwx1jn
         ZHmKhb1pfGWidPIt+8mZxniT5ZZULzEafvm97ZLlDT+S0wFGnpakbjDfCsv1cQ2LHz45
         IsYePLwOZjjX98oJ7rSpH51fMipB+mUf5r7VsQfYL+ebgW1NZnvA0LepBhhFU8kKvEmj
         Unv8W+pWDDwuoWro1a4LJ5w0DpcVXzDfKO18vnLF9v1cOyWECZmO5RWGrobvAosNgkKI
         njfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX18bToPOnvPyqbrZjvQaY5SwM0Ct0C5YKtPYXd9P9I=;
        b=lu701zctiyOU/sCdvkEBLI+wzDSlw2hK2R0yPr4bS9N6hrTQENKok2aw//rMSHeHtn
         EkXeX0edK7QJyds2LzRyIJ+/1HvmtUZ/5EYUWXTS+jLn8jgnCJJLhfedBza1DvTqOnUX
         GQW87AcBXXVhiCEqDUDsAUgvPwMoJveM325h6F8j0xCdDvhSd8mUVRapnrSB6SSO/09i
         vdu5rM2i9YdwBFDvEP2+o+CUfYti7Zmu46De1kayauixw06DCf4O3nNSUgwFqhAjspKu
         tFS9ZK9i4DqXWrSMjAqxcPT42BtMFoxAPkmBOyFAc7SwPL0rJwoovJJYZtuA1/AkGM3E
         /k7w==
X-Gm-Message-State: ACrzQf30xR4sTVATxoQRdjZSq7ikw+Bde3hX9sAEPr+YyCWmmCaG1ROx
        CPx7zu+PQ5FTYc7ui/856h6Pig==
X-Google-Smtp-Source: AMsMyM5Fh/5Xj6uqwhE3SfgD49hweT3z6vUVN1Wqv0vpArs/K2txN9tLrVzgrE5g2C4WhAlRwY85Ew==
X-Received: by 2002:a05:620a:2627:b0:6b9:1b05:7b9 with SMTP id z39-20020a05620a262700b006b91b0507b9mr5334977qko.776.1666182782282;
        Wed, 19 Oct 2022 05:33:02 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a450600b006e8f8ca8287sm4712954qkp.120.2022.10.19.05.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:33:01 -0700 (PDT)
Message-ID: <b035a095-f8d6-1951-67a0-e2c1f1d18492@linaro.org>
Date:   Wed, 19 Oct 2022 08:33:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add loongson2 clock include
 file
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221019035117.29352-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019035117.29352-1-zhuyinbo@loongson.cn>
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

On 18/10/2022 23:51, Yinbo Zhu wrote:
> This file defines all loongson2 soc clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

You sent the patchset twice. It's confusing and might cause review to be
missed.

Send a v3, including my review. Send it only once.

Best regards,
Krzysztof

