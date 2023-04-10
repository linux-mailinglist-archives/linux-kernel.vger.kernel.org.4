Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D36DC880
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDJPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDJPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:30:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011230F4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:30:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt17so1113522ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8Pyn429W1/wp1DI5s9de8EnnQwfVf1lqFb2czkxkME=;
        b=F3fk/SBMp8tAOXilQTsptvctAzvKRopbIV1fWonXvr5RdOGFL/6XqAqBoFL3cWsG8c
         9K9tktPHrW1oTcFrE53rBSck4a9CVoidSXwRh6o9cpq3q9bFoal3+TIPoP9s/FjfurfC
         q7JkdmRBv1BFl2fZZBTFTy86CV7LAWXeBmAt6mtLKwlsPnEZFZECT/4HjNnnlnKvGxaO
         JQ57CGdREsx8YHhpwzaDJ/9GWLT85TB+/IJBio9WmgHHmzyxAZr4lGSwEIA70hIgoCNh
         aqJeJIL7YRWFmyhcfCr2EmmPZWaxm4Ps5MEnGqWA5RnaDyxL7cf4qU4nj3B2osOU5ibh
         eD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8Pyn429W1/wp1DI5s9de8EnnQwfVf1lqFb2czkxkME=;
        b=nRXFTUoFCvSZFUETvjTYO/Q1JxpeP0Zj9LBlkH9k0kw0QrsJb219QJmixJRLDsMGIC
         6SUPPGJRz4oC90/c9JYRotb+2uqHUUWnhVZB03Hn92z4XknZmLgiDilCaloAHR4LTqSl
         exD1KXTMwaY2qHzest12GjFUyyPsa1LKbOtZN4TSvvXtDUv8wiwPx3uLfbOxJi2Fvs2L
         fFbKioL2NY7LKwzdazipvMKf8ue3Ilxtt0eVeGB45IZDa62Mw3uKlMMa/mVRWEL3qifC
         VHkynEQrAO1lNHlLvpGhmA0dj2Kqh9+sTGrIYi7b8VptAZnpbOkhzWVGMzQZInCv8DWe
         9lXA==
X-Gm-Message-State: AAQBX9eM5kfojiMlOQMLlvXgqMKSoWXFh0FBUgJGK8V5+gppwasWui/j
        HdPVCVGPLdihXxB9JiaalNBAVg==
X-Google-Smtp-Source: AKy350b3hxrDKBGR1lzxxof8ns1PA89D/99bVkbjAasQmU+Zs94T6DtaBtUrAOVGBmPLtDth1gX5Kg==
X-Received: by 2002:a17:906:c78f:b0:931:636e:de5a with SMTP id cw15-20020a170906c78f00b00931636ede5amr6331879ejb.31.1681140609418;
        Mon, 10 Apr 2023 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id hg15-20020a1709072ccf00b0094e002dd3bbsm84738ejc.224.2023.04.10.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:30:08 -0700 (PDT)
Message-ID: <565d0cdd-14b3-1b17-c978-4f4ae557e71c@linaro.org>
Date:   Mon, 10 Apr 2023 17:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/8] regulator: dt-bindings: fcs,fan53555: Add support
 for RK860X
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
 <20230406194158.963352-2-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406194158.963352-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:41, Cristian Ciocaltea wrote:
> Add compatibles to support Rockchip RK860X regulators.
> 
> RK8600/RK8601 are pretty similar to the FAN53555 regulators, while
> RK8602/RK8603 are a bit different, having a wider voltage selection
> range.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

