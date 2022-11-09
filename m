Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07786225F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKII4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKII4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:56:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39ED1C405
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:56:08 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 13so44935198ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwM72Ua0ekiGqkhKASYWwqBoA+TbdBlu5UDAHrfVL4Q=;
        b=nu/DVC/kaS4AKDzH5z1vOxRf0tR76I/SSeJYm44O+ma1i+J+U5LAq2aR8CiUrHV9Rh
         bvOWc5d81lnnP4shgh4pE7qYlul4Ub+e591wKrJHs0Nk+AKLNRNLt2J7lDkr4cL8d3uG
         l4gmKDqswLuDys2IFDc9q+n1O94mQd0fQmyS75Zki/TO1srXWiUGKbQie2tLS9FwUAyT
         8sv19w3pL+ZGlEiukVS0bn8RCj9shZstcrSb3RW4+LWTWqxVf6AXxIWrnAinrbjea0xn
         pxQZ4NFtMKkD8uF1dCbUZ178xIGZ+/maCnrEUEblvqcLeALjzjCxKFpqY4ngN+LjVk9E
         bSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwM72Ua0ekiGqkhKASYWwqBoA+TbdBlu5UDAHrfVL4Q=;
        b=osXhBevs560KTyn/DgoGBi/CJQWeRDxqGyxt1VWQogM2VmhV6VLZL++Y4x6o2YjU5f
         12Fz0FGJAyfI5/l+odi7hnCeM8YW7F/BI1b2NDrxZFkr7d2szSF/VyvwECl99nYEVlx9
         zVL9W0KYT/NG3XXAvy3M0OsIXpW0s+tKe9EILY5ibA9+Dx5SJx32yGxzhjMrH+Jbd7Dj
         aad5+ClSmUsHpMhsrosj7CzxXbIpYh9W7ttN9Mozn30tdHPvsX/rLQIaWZLlaKX3PeK/
         zj9+6pBjs1AdBfeAZaW50vi3XJBoumX78kOAAH30SY/mAJj8P879lfTMELt/l2PQCNGN
         YTYg==
X-Gm-Message-State: ANoB5pmz0ijFb/1L87Th1lwTsi7FSKXz8eQvzytETFUP9R02H/5U2hgf
        bd3KjLT4Lna1pVGMXpj9fkpeqIAWx1jmoquyE7s1IQ==
X-Google-Smtp-Source: AA0mqf5VidT+pHQAg79Ye9+m6oSlsfItXAI/qk++7PYogawsDst06uknrtsSrJsFQ5kwbcQ4Nld6r+av6314xzMzk4E=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr14437129ejs.190.1667984167367; Wed, 09
 Nov 2022 00:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org> <20221107185931.22075-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107185931.22075-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:55:56 +0100
Message-ID: <CACRpkdYmVZkV5BYRG1kT_f3GPt4vb+k+ZqxCh7A1cHJ6h-EjqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom-apq8060: align TLMM pin configuration
 with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 7:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Okay!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
