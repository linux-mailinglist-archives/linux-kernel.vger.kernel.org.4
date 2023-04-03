Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD226D40B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjDCJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjDCJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:33:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A22E043
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:33:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so114710795edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680514420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pJ6eXRjsaMGGDfeBu+1K6RtJzslqHClngY/FU/9dEI=;
        b=U+EX7VKqbZB/wtoXagqI+XZfXpY8zAt0lp9UslVqYlFHyBNLer7v5RUGr0YvIHMneR
         EjoCXh7U4WfZxrTSCX8xgmUmBVJ76f7NX+uQ2aRWr2hS9nxtLkQZn95k77VuHq5EpYBQ
         SCkCTWUa4kgW1QHqdo6wDjHZzQA2IJkIAYx9eQT9AQ3cFWTmXvpwW0KWgJ12FoXlVwuE
         RtXu2nhEKf/S2uBzcfWLx8hIQaJdNQ2AV4Gxk+rq6kSPUix8J5XSPAmWyutegZXvwnbT
         3+F4lzJKw/lHAwUl9I2Jk2q6EaYhQDVAExY8FLcUkJ9Gk7ahZGLeT0sPnqeOfcneW9rp
         lKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pJ6eXRjsaMGGDfeBu+1K6RtJzslqHClngY/FU/9dEI=;
        b=La3BpK9E1u0nft4/JFgDanofG0KaZwPGss1/3rh7jUjENeQodueh9TsP/I1i2wfzf8
         KvLslWVedzUExCR3uuIwpVxSqSXEMSONL5kML99Uho3Hb5dgfGiozFI7SWOfCqQEB/EW
         fygpxEN+6oarvWxSZ3fPWdf50mVP+o60tn0iwlQk1e/iuZFp0+spRZbLYPeeUUvivpxt
         hpeRCZjBOeAbxww3Adyd7JI95pBfqD5QghyAv9T/AD3yryPREz8eu1VdAiLNljDnWFO7
         yweyR1WI51S8yEaTUzk+AmcVPOdZlYTvltiNwwBAiPDzTwRSXoibMAnUfiygATgrVNLX
         ND2Q==
X-Gm-Message-State: AAQBX9euS6hSXJCMx7/9QGqozi76E0mVhRODQW5pOWkjzIhXpRDOpFEt
        BOvBp87VKlZrL1wlk+YrlbRCSN+Hz1udwmQSp08=
X-Google-Smtp-Source: AKy350bk7tt4Gs8+MRvbF3ybQd4h6ygHmS0CbM6H4F6FCeQHbluyyMLHNFjv9FTGL2XPwDxlLYAAhQ==
X-Received: by 2002:a17:906:5584:b0:930:ff11:a85d with SMTP id y4-20020a170906558400b00930ff11a85dmr35062320ejp.46.1680514420415;
        Mon, 03 Apr 2023 02:33:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709064ecc00b008e8e975e185sm4267202ejv.32.2023.04.03.02.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:33:40 -0700 (PDT)
Message-ID: <b59d5b6b-89fb-0bbe-a9d2-cfa83892423b@linaro.org>
Date:   Mon, 3 Apr 2023 11:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v12 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230401112633.2406604-1-a-verma1@ti.com>
 <20230401112633.2406604-2-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401112633.2406604-2-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 13:26, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add num-lanes schema checks based on compatible string on available lanes
> for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

