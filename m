Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E65E8179
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiIWSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiIWSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:04:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801714DAC3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:03:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f9so1497958lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=buNZn9X8jcAPZ9BMYYXD3uzkNPl0jz9EraafURKcLDk=;
        b=e4jsdVtC/tIdnMJiGOaszhSVPazfaUDgETEQNU5jZUSTT9gyR3m+Fg7XMchApPG/1n
         gTXU3p9yw474py90/gYaCSIc9XpDKpHZeSNL4COBExXzU67q7tlSKa19lcE5+m0Q/7K3
         XZGmKNuhx2XDWHebYUkURMOnk4KG+jfYS27r/TbcnTnoOUOr+RFFYJLMevSJq/as+yiy
         O0It2GCwSl5fG4nD5HsdyoVRpOtsWQVXF03JwdMfqN3QtpJJLiQv2rxmCQQhZ7WAPt4J
         gKDkVtLSo9qps1kqKX06U4HICL4xAY6tglpVmT8pq1ZAi92n8jiKvYi4B1w3aQLTGxCq
         XH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=buNZn9X8jcAPZ9BMYYXD3uzkNPl0jz9EraafURKcLDk=;
        b=nND25JtEkYqgfXjCRplQzLz1ADB3aa9KJHhtlKQOe3XFnXCsfuTRMBIGl95QG0gCnq
         qV4qccrc3jyw9gYwfKGPVpI5guaqSEphYRhVL1BO0158OheD29Anbohd2DDdb8eDfmcW
         k/JxBKbr8/dgztKgkZ7rQnWWAVzK3e05fZiXueFgN3o03UZ129LWhfm1Tl+xIc4QqL/u
         F4xnV86KrQdd7DimcNQiLrPGZl0FTQD2XTEZFsqCrcc6KIOtFAutn3tHqQuftSMxo0xu
         ozIXHKa6AfotCFaX/Atgpim7EMIfltJAcFaw9AIgqjuTExW5nVa/A1oKkJOXYY8Jju+q
         pN7g==
X-Gm-Message-State: ACrzQf02ZlrM98imxTlVkH9O3IoXrEcco35HefRJiPpKoeh2NS6voFHT
        VB9f2Qm2aQJhlrlnJ/Sxs6vbAQ==
X-Google-Smtp-Source: AMsMyM51FvN9EWz1W4lgvaoOnAk72UUmHSPMKuJDm5lWCGTls6/bxpy+LmNOCkXN1FvVqEhH5rMU0Q==
X-Received: by 2002:ac2:5f84:0:b0:49a:fc43:6213 with SMTP id r4-20020ac25f84000000b0049afc436213mr3703899lfe.150.1663956179229;
        Fri, 23 Sep 2022 11:02:59 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004a0526b11ffsm411711lfs.133.2022.09.23.11.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:02:58 -0700 (PDT)
Message-ID: <fa9201a4-13ec-714d-9b7f-7498a4c6c86b@linaro.org>
Date:   Fri, 23 Sep 2022 20:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220921095053.88658-1-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921095053.88658-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:50, Tomer Maimon wrote:
> This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX 
> Baseboard Management Controller (BMC).
> 
> Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> period time.
> 
> Arbel BMC NPCM8XX Pinmux functions accessible only for pin groups 
> and pin configuration parameters available only for individual pins.
> 
> Arbel BMC NPCM8XX has eight identical GPIO modules,
> each module has 32 GPIO ports.
> 
> Most of the GPIO ports are multiplexed with other system functions.
> 
> The NPCM8XX pinctrl and GPIO driver were tested on NPCM845 evaluation board.
> 
> Addressed comments from:
>  - Andy Shevchenko: https://lkml.org/lkml/2022/7/14/1218
>  - Rob Herring: https://lkml.org/lkml/2022/7/18/1165
>  - Krzysztof Kozlowski: https://lkml.org/lkml/2022/9/19/68

How did you address this comment?

> 

Best regards,
Krzysztof

