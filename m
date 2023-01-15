Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617266B1C5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAOPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjAOPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:01:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146469EF6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:01:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so62614441ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3bq6rsilb+yzIau6JvOZs+9VdaUZxUWRaQK2SaliZM=;
        b=PsQwIqKmv8mUgQAfKRBTar7hkJFBWu8yHkUFdSFiONL0FtNX3oQmt62fwmI1uJMD+J
         +sddKvh15EIZgSODInndERNNqf33Cxj0ivluoXf/++txbGPkWKElLS3YwqdsE9CxR7MN
         CdenhB8vdwxa1nD/TPDp6Ks/nG7rbqocCxvY5xAvtvDTAq/QfjJZ00bC/UXZ87uvwgLK
         5EBa7NXKP7Zyockn+St7pD/YqdEIrRqXeagIwccNWWpN9BdwkiNngvUrNSCBJvy5LmRf
         D/2VGuv18XneRm2cv6sFDRTVuyjhIDREtzOIfVOKy4maK43/FZ8/uQMgI2RpWSJ/nlCS
         i4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3bq6rsilb+yzIau6JvOZs+9VdaUZxUWRaQK2SaliZM=;
        b=SBgC0aAD5KL5sX2nQ0vZ0IFTFDXWYjEbEFOgqailmp8fThvD0lmLhTEiLiz+xKTxxt
         rRTbibkFxLRx6sa2OKluOASW2F02XsAslKSTMwmaCIgkUmKe7GC3LkgLsiQEHvWeoPhO
         0nX8eGTuTCSY1fqpGa/ykhTI0ygQ/rxPUk0nBB6GjkU6B6RulV9hOMuIYUwEiwyq2mpM
         La4V38SNMz78osvvCBkatcy7PzhSoWvsZGlaV31qZR21WreIAz2Sie8GmLOfuhX2iQ+p
         XQssnQQUYQJ4xGZsQDzMcpr8EzzW+9JojdY8h2JGdCB/IEJRT9vxKr0kIRlR00T8+iDI
         sCjQ==
X-Gm-Message-State: AFqh2kqmGtu+Ntak30UQWmUDgCz8EgojMmbn7+FU8+c0lNpDu4SaurJr
        lMdirR47WiIjvdbCCo+In+1c6g==
X-Google-Smtp-Source: AMrXdXvutsPygOCMzesZ9qxp8xuN8emB9CtkFkWEFKnljtZ5h28K7Ck5Gtyv2iBBY6sW3n/hl5B9WA==
X-Received: by 2002:a17:906:850c:b0:7c0:f44d:984 with SMTP id i12-20020a170906850c00b007c0f44d0984mr95610347ejx.74.1673794915641;
        Sun, 15 Jan 2023 07:01:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b007c14ae38a80sm10633909ejc.122.2023.01.15.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:01:55 -0800 (PST)
Message-ID: <3c2c4da5-c63b-dd2a-c918-4b8163a52512@linaro.org>
Date:   Sun, 15 Jan 2023 16:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
 <CGME20230113121816epcas5p469f952d775cdd709de18ec63b24cedf7@epcas5p4.samsung.com>
 <20230113121749.4657-2-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113121749.4657-2-p.rajanbabu@samsung.com>
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

On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> Add bindings for FSD CPU DAI driver which supports stereo channel
> audio playback and capture on FSD platform.
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

