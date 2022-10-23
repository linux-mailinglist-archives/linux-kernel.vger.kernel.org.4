Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABC609336
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJWNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJWNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:03:15 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3546FC62
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:03:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id l9so2218790qkk.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCqTq1pPm7I1xT+HP3x7Se2GkYTdlef4gn4o/9jUS4M=;
        b=YNsmxiEW05f7vureKtD3GIu/M0sQYQdaMrrwIf6mnF/z7x9n0vLKEyZow5ISH3fLw0
         qimM6ZMB4mr8xtx7Joc6bYavH2aov1Ou/6r3/uEH8LQ2JQuxn8JDysYgXLgn00ZoTjaY
         0NwNsTc12HXmFOtnZrIZwp/FY1uyPczqnhgsz03aLWyeXz312oGl/temG0bia+uOjEng
         0tiOngCOa9GofYuU/OxCqKCWbzwEiVPlAMpiGgCuEpej9c4vaduS//hwRmKmf8LM4rSE
         UIr+xpBs8PN+traIS+2eXmu6449j8VOJxbFh02q2A2Ce/e4EIjw1isdN3gPJSgNezOTs
         RSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCqTq1pPm7I1xT+HP3x7Se2GkYTdlef4gn4o/9jUS4M=;
        b=luNnkSKCd12b9JIuvxanvUeRO31Hr20B80TwopxjbJEMB2rb5sFySRP02M/iYnTxvu
         UBgp8ZW1hlm23fTMcA/CbRn6FOEYp2PNQ3nboEdgqHD5swB9QzgFeZqs6XCy5mrYhbnJ
         EjOV3zKJS0uVb7kX2JiCJb1auzNdR/h6F9alfdaWWUfrR83cXdTsR35Tgelnq6TEu2MI
         2K2Kt947Tv6f50LXZfTBg5t1grhIwCGXMDBBPvVNYo6Kvbv6oE5B5d37wm6vkaNY9l1q
         9NJ0nSOASFSOi/BgslnshHMshL0SDeGvTF20QXq3hZghjhZafmRFOZQa4tsP26R3kUMo
         bJjQ==
X-Gm-Message-State: ACrzQf2iGhdca+k9ii2UcG20HKtWdSYk0qhiB7OjV8a1CzGqoS4qs0Mu
        qpNZupAxnpahar3zYZf4aTnXHg==
X-Google-Smtp-Source: AMsMyM40XDGsIZJWzkb5SuUumlq4zOOEJ8g8fTWMm8cwssRfGiZ+jCoN9I4BStll1vbKizur0c8WCA==
X-Received: by 2002:a05:620a:448c:b0:6ce:a013:7fa3 with SMTP id x12-20020a05620a448c00b006cea0137fa3mr19244655qkp.532.1666530193368;
        Sun, 23 Oct 2022 06:03:13 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b0039c7b9522ecsm11288064qtb.35.2022.10.23.06.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:03:12 -0700 (PDT)
Message-ID: <29dfeb9c-0bca-4550-1cfc-7a044f92bd87@linaro.org>
Date:   Sun, 23 Oct 2022 09:03:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add device tree for Sony Xperia 10
 IV
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221022194218.210941-1-konrad.dybcio@somainline.org>
 <20221022194218.210941-4-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022194218.210941-4-konrad.dybcio@somainline.org>
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

On 22/10/2022 15:42, Konrad Dybcio wrote:
> Add support for Sony Xperia 10 IV, a.k.a PDX225. This device is a part
> of the SoMC SM6375 Murray platform and currently it is the only
> device based on that board, so no -common DTSI is created until (if?)
> other Murray devices appear.
> 
> This commit brings support for:
> * USB (only USB2 for now)
> * Display via simplefb


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

