Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F055F11BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiI3SlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiI3SlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:41:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D16110EF0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:41:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m4so8111177wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K/wUM4ocxdPQPd4OIa/gI/hhYcWvE/v6SP9Mth96aEI=;
        b=eUNAnTqIsSwB10rJdReAw+Wf9aSVB6pQEoXQnFIffMaicLIc1PQQJ4wRvDag2WLmet
         p9rFZ2FxBGoeNdBw/9fGeI9KkOECQpIY3KDSHW4fyTRFHigmCn6ojMSiMszAOJVP1Xb8
         34O4sToDM3S3evERRo9muFZdGjqkrNC/8p3hr1drWHJnib/h8JjdjGMQvA1fqVkin2yC
         67JhGoUpv4iXGBorK89iKfnWbhb5Ldg5VjkhCrA/7c3TQBzWGRCflKtO/8+33keccTYI
         K2TeUgF+MbNpjPSHm0O7dG6erasIRWYnTXMCwpzAy3xJF34Qtz0PD5ReviQ7DBFcovQT
         rG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K/wUM4ocxdPQPd4OIa/gI/hhYcWvE/v6SP9Mth96aEI=;
        b=0/YmCkUtyHObBAZ9cGoiLQ6ckIyPQ2lCAAjtYKlkXLZtboVTeg3Ouu+M8YwX5ur1Yv
         J2OxzeKQyP7PItBnv/mh9EGvAA0lUYZ0+ZdiS2adLDny4Owd+lHNrvdlYTuzmN8d5+Ff
         O7SdHrgWq6WCVnvcRCaNdGvExM86awWnLAG7UsQ1RCpm3VDsKsc1hJ8DmmRF0xQSosre
         EeYMEm66QmKomiOKfI/IS7nm7xQYkjrMCnYKWgaFhMieuiGEi0yOVtXUro1MPAkqy4Q6
         g/rKoCoSvVQ6YMZXyMCjoJvEUPV1F+lafd0CBnBy4i2VIP5+FseeUCtJo++ak+T48NdG
         1tdQ==
X-Gm-Message-State: ACrzQf2AIlxmE5hLVlaExkvB7IIZ2C1IV+bl7vYI68ZHp0SfoDVwhRnp
        PUhKw3RaoTAQNKE/Mlo492+g//vXDS8u0g==
X-Google-Smtp-Source: AMsMyM6blaLJoCHa+v9NEv7b/MCHAiEmhwrH2splatl9f8XphUZ2pA/KdZiwcDqpWzNmKSFJNZN+Dw==
X-Received: by 2002:a5d:6da9:0:b0:22a:f828:73b5 with SMTP id u9-20020a5d6da9000000b0022af82873b5mr6449997wrs.229.1664563276038;
        Fri, 30 Sep 2022 11:41:16 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4b8600b003b482fbd93bsm7122132wmp.24.2022.09.30.11.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:41:15 -0700 (PDT)
Message-ID: <02223d7e-d514-bedb-2f74-f42482468fd2@linaro.org>
Date:   Fri, 30 Sep 2022 19:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, tytso@mit.edu
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 15:47, Akira Yokosawa wrote:
> I guess all you need would be just a short notice along the lines of:
> 
>      "supporter" in the output from get_maintainer.pl means "maintainer
>      of a supported subsystem".
> 
> No?

Oh and I forgot to say, Krzysztof suggesting listing the entire set of 
those who should be mailed and not confining to maintiners and 
supporters only and TBH I think he was right.

Reviewers, sub arch mailing lists, and in some cases LKML are all required.

We should state that more clearly.

---
bod
