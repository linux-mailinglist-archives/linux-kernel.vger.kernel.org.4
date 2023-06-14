Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B561730832
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjFNT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjFNTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:25:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503031FDD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:25:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so15779131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686770714; x=1689362714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlx36jZmWtlb1erKTGin5MoZTXEskRXNa44H+85CF9o=;
        b=aR+nWH8JD8bkRswCJOyVPg1veCPQRZ3PrDplyOQ0rWAdrde/kltUtsaLW8zJ1BZjgN
         V/PbwUiXBqJsNh0xyZROi+/ezJkQjaTtzHK4uyGLULT/VVLFsnimHdnfJXfr7B+jPnQ1
         yr4McbRCoOI9lcSFOh3zhc2Ys4W0ofj+bm+mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770714; x=1689362714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlx36jZmWtlb1erKTGin5MoZTXEskRXNa44H+85CF9o=;
        b=e7pzEFTjF/BprB93gp8JQ2MROLmqDynvmNmXF08nH8WgOD/lsSNLnf6jC7YbwY9I7+
         wc3aLgad++OKsS74kYULTWj1Mw24QQivMIPzMTSnbf9yQe5VyGJoSrIcy1nfbqjqDqd1
         4Wt61EUT1XH4WKFNzgaaYzuaGeiPydTfQGKNjtnGhO4kujNZtgAhwlHNMWudb5hNgCyy
         XO5m2IUfcOo7F9ijSraPNquYLiHBy+ZYTW/QPxrRbH4Tobg+DESAxQNY3SfsxIkkccp+
         LC2PvSSjqn8V19o2toYrouWwYgzpc1PA/K4HBVk3+wp8DEa/3dklEeDFdbBwujD7RDjV
         KgOw==
X-Gm-Message-State: AC+VfDxLYQIanIS/ID8D7kDyFCvwuGiHAGn0/Q5dtV2Ry5V42cGv/NaM
        mpe64TLyDMy11hP2dTSd9GnTog==
X-Google-Smtp-Source: ACHHUZ6M40gmMoCv/5AcV2iEYCshha0B/q7xkC1RmAgGFw58zKoc4sHncOWtEp+3UoFyrAwNPfr+zQ==
X-Received: by 2002:a2e:2416:0:b0:2af:23c2:5dce with SMTP id k22-20020a2e2416000000b002af23c25dcemr6861472ljk.25.1686770714247;
        Wed, 14 Jun 2023 12:25:14 -0700 (PDT)
Received: from [192.168.1.128] ([80.208.70.1])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b00514a5f7a145sm7958814edb.37.2023.06.14.12.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 12:25:13 -0700 (PDT)
Message-ID: <a65003fb-4557-a1ab-bee3-103ec5e6de6e@rasmusvillemoes.dk>
Date:   Wed, 14 Jun 2023 21:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: timer: fsl,imxgpt: Add imx8mp-gpt compatible
Content-Language: en-US, da
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>
References: <20230614113612.365199-1-linux@rasmusvillemoes.dk>
 <8f2d0993-4b19-18f3-1261-01c7149672e2@linaro.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <8f2d0993-4b19-18f3-1261-01c7149672e2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 19.19, Krzysztof Kozlowski wrote:
> On 14/06/2023 13:36, Rasmus Villemoes wrote:
>> The imx8mp has the same GPT as imx6dl. Add fsl,imx8mp-gpt to the set
>> of values that can be used together with fsl,imx6dl-gpt.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> This allows what imx8mp.dtsi already does, namely
>>
>> 	compatible = "fsl,imx8mp-gpt", "fsl,imx6dl-gpt";
>>
> 
> https://lore.kernel.org/all/20230327173526.851734-2-u.kleine-koenig@pengutronix.de/

Thanks, I looked in -next and didn't find anything, but didn't think to
check lore.

So could somebody please pick that up? Shawn?

Rasmus

