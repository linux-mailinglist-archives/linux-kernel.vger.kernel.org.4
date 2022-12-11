Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9857649630
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLKUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLKUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:21:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E6CE2D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:21:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c1so15319321lfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jrjy7/A8lGuek/y+MrW/CXKs3XFptSd1FylhEw2u4wo=;
        b=zpRDpNS1ycmQOww8y8MUVbWxSq8OS1GRnxl4xPJ+HbzA2QJY2t71gZKiQP7M/UTFhj
         +C4FBZohaM2R9CX7nSPu/cmrajcLubgkWadq0BuWZs8teijkzLXuLmos/A0cwiUVD4Nl
         eunh2Oio95gcm9gyAf1rua1z62eQDWfd2lDfAgeS2O5qeLiOMErO/mVjVVw+Q3KWnlgs
         TrVHG5EjrPPKAm+qfelRHFuwD15OmxfkZY8Rix36wu78P0AwrHrnDdjPt7zPigQvudDv
         O/2zSqoM4+jg8gYYSURdZEBfIVag1j18ggjyzamJE2YCgBVZLoMEfnfPaOWPy7JPTdyF
         Twtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jrjy7/A8lGuek/y+MrW/CXKs3XFptSd1FylhEw2u4wo=;
        b=4J1ojh9Z+H/hKy8ktcda8Sd94nUYJiYLE7OYufeN/cvwmuUSubGhhtdE4Q4AgtFtZi
         mccACpow7YdJDSuqRVSQXcmLjaYeA0FSQ0RHYmNxpB5U6tW9h6oy6rStUr7gj1ZZ1YHE
         IJVe+vnSG9nNoCoS9tAN0E0bpr4uLpqcCHN8UgBcS4YtMjpTYJ4Cq5PcDOgfiaU9SUD8
         s5EfYJTwk16FWjGw8b6sBrtG5y52kQlXVN982Ej+FyzQ0CodfG8J2I58uaQ/QV3M0s5z
         qf3zlig1bycVEJ7SD981bRUetaTx99jQdR2oWzPFQmtqbtnz4quppZCJdTfUb/TDlPg2
         8yLQ==
X-Gm-Message-State: ANoB5pmqmjYcuyEoJs0K8rN5Vuxh+lLxpW1i3Gu6uzN/2tP1nnZLsgiw
        2Oksfsezy8+nteaDjTb4p3MaxQ==
X-Google-Smtp-Source: AA0mqf5t3BoUEQ0U2k7kMRFWJYtekznOsbHiw7p86sMnZElkNfsN7/gDczW12E//NKdvF/nTBVar1w==
X-Received: by 2002:ac2:5f49:0:b0:4b6:e121:4617 with SMTP id 9-20020ac25f49000000b004b6e1214617mr1341017lfz.68.1670790095722;
        Sun, 11 Dec 2022 12:21:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z1-20020a195041000000b004a2c447598fsm1318355lfj.159.2022.12.11.12.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 12:21:35 -0800 (PST)
Message-ID: <71073d48-e086-36cf-c7a1-9a5e8154c273@linaro.org>
Date:   Sun, 11 Dec 2022 21:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/1] dt-bindings: mfd: x-powers,axp152: Document the
 AXP1530 variant
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221211012132.1650783-1-martin.botka@somainline.org>
 <20221211012132.1650783-2-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221211012132.1650783-2-martin.botka@somainline.org>
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

On 11/12/2022 02:21, Martin Botka wrote:
> AXP1530 is a PMIC used on board BIQU CB1 SoM
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

