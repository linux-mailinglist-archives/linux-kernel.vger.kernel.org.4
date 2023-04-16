Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98736E39C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDPPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDPPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:21:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B11FEF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:20:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id xi5so57863471ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681658455; x=1684250455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvXM66+wlKkFUvRtmKhBXN6oxkloozMo1v8ngT/SFfA=;
        b=UEZNrrLfnOopAP4aSZZ5loJpKwTXS5274mRgre30gZf2wxcqHerllf9Anh+j9g9vZb
         hqqZmy//KHgOb3JDMvfaYfAgGxWJAAfIW07Kbcu+jKoZd3KxT/mtxK0oK0Qf/mb0CbQr
         eRRqhrXjFUm4Isx7pBlEuJxy9WxHaeJvZMMSm3cN0FtlD1BH5St8BJwRCzQPRcQz3lxx
         k/62L39R+pjfDnWJBYadZ2znMIh9sMYgmosxIJ6OQMQTR2NK/Nux2DS1d3QPWhEDbksr
         ecT7HMUhLuMZFTWVXrM6kqYnMHEltoTIoTljjKvAAzrpQS2/yuOctgD1U+5Z0c4uUky8
         DxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658455; x=1684250455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvXM66+wlKkFUvRtmKhBXN6oxkloozMo1v8ngT/SFfA=;
        b=kp5PT7cu58zgzJnXyA1J9gHcY76UTWp4wjDwhsYsdiRnu3EKeKB/mw4Jy4xIGkDruE
         zVQBhE9iZjzkrhPI3xjibyb+nqGmeFZZ3rFE/sHB7DHa652E7Y9tqw1ZVvLK+KQLFDY+
         SptQyVR2nf7XovQXnyWuLWgzwYbxVtUwb/A+xkea4ClyrR3H5voyEylT6heqAp+h9n+y
         4OPnRla3T/i/6TqReFWiuF1lEHts5sxqydFWtI/Mz27jd2Vggb9VHTLUpMlTEz4XUZ6R
         w3EESVZnmcgM3fXpnVzQ00qAwZnenLTLUxBAyJXjlmOmZ4K0iFlYp0EzyW763O7rSm5/
         mmtQ==
X-Gm-Message-State: AAQBX9d81mUGQ78sr3PetHcg9VypTopW0p4oUH9YepwxGcVIVAQNCwG2
        3QnJAFGxc7ECRLWjTXryMKgdMg==
X-Google-Smtp-Source: AKy350Y+s7Ijt20/BwCPxv3poFP7aqQ0pdWGGDzX92mJ9W66gTBIBYxk7M9UGVWa/Kap5xLj+TUBGA==
X-Received: by 2002:a17:906:c004:b0:94e:fa56:a74f with SMTP id e4-20020a170906c00400b0094efa56a74fmr4803037ejz.14.1681658455533;
        Sun, 16 Apr 2023 08:20:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5230726ejc.161.2023.04.16.08.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:20:55 -0700 (PDT)
Message-ID: <55392744-b707-2ab1-e897-dee562b94f6a@linaro.org>
Date:   Sun, 16 Apr 2023 17:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/5] dt-bindings: display: panel: nt36523: Add Lenovo
 J606F panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
 <20230412-topic-lenovopanel-v2-2-055c3649788e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v2-2-055c3649788e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 12:09, Konrad Dybcio wrote:
> Some Lenovo J606F tablets come with a 2K (2000x1200) 60Hz 11" 5:3
> video mode display. Document it and allow rotation while at it (Lenovo
> mounted it upside down!).
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

