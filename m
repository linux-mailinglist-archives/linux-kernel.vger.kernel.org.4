Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193C76294BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiKOJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiKOJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:46:30 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4C22B04
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:28 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so16807863ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTCPHlKJiNqjfIcGyW+8cKWVQmtYwBfK2EmFcufHiE8=;
        b=UoJoJpNga2JN91C9mlsCc8amblFjryx7MwFX+YRWgXFhv3E+Qu8wZS1LcIjhDxIE4N
         zedEezVrZfERXru4BWS9TrCK0I7UKMY6XSe4DjgXnrzmEraLEx9VdkEL44nied7To91n
         FdVXQXpMfoB0BsMZr2DF8uDZTzhVtuDGmIdtBeUNK5Rq7cLaRrwi9TWoKGekT8dhCX5G
         1DipqTtLUHOCnXoTCk1Kzm3mwwAwk96twho6Pbvf8sj/0Dk/QDP0EGJLcpsFEUHKSFC/
         3Lm7KslBlbI5INGsTnKsleEHFy3ilDjqepIwsXYx3Qg/lkUrlvRk0wytdBjYwiXwYOZt
         kptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTCPHlKJiNqjfIcGyW+8cKWVQmtYwBfK2EmFcufHiE8=;
        b=ThmxFKWhNAW3Pf+EoH1MWrRcOqcZ72sVE2b9Ktf3I7FpBlOa5QNh5/4TYZbTKf5DSs
         gbRe3n/Hs8lm0udg+u3ze8BtFyYL8d420vlZB4f1JPSlaMVFDZVhlRwnNr1QgS9vWiYA
         GyHKLH0wCXQrnLxsUnPHHHEkQ4W1rF8hTvR3BdRdpDMH6lvtGrvuwCwtzJbFvntmXAEO
         0mwDvMxwzC8Zg8RJwvnKQhcpXt37m+ZcFS3LBalwol2ml3itDJFIkqzz5F7v+aJcnOD2
         ogQEs+nAf/Aqs4DKsSFkPg5hlgDmbNK4aA+X8VNthKk/o3PIhaaVKpoWwcXS2yXU3mvb
         fPfg==
X-Gm-Message-State: ANoB5pm9uQ7e/ywi/8+mhpbfId13RQ2QWE8DaDOJbjSIzCZQlYxkSh/J
        DenwIHC4LaZKrMYUOjx3TbgGeYuAgUqHCRkV
X-Google-Smtp-Source: AA0mqf5Nu8UdAoc7UgGkcl4B6tJiLU5Cx9Yce67WDQMPaTN2UMUL7oUZZzzTczFOFrBNVji5CsvCWA==
X-Received: by 2002:a2e:a44a:0:b0:26e:89d6:e6fc with SMTP id v10-20020a2ea44a000000b0026e89d6e6fcmr5090612ljn.145.1668505587408;
        Tue, 15 Nov 2022 01:46:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512069000b00497a41b3a42sm2149059lfe.88.2022.11.15.01.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:46:27 -0800 (PST)
Message-ID: <e125f05f-3f31-a5c3-e4c7-1132ce0be9b5@linaro.org>
Date:   Tue, 15 Nov 2022 10:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 12/15] dt-bindings: soc: mediatek: pwrap: add
 compatible for mt8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-13-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-13-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> Add dt-binding documentation of pwrap for Mediatek MT8365
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

I am not going to review this - please go through comments you received.

Best regards,
Krzysztof

