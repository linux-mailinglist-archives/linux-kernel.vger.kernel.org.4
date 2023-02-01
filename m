Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AED686D89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBASAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBASAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:00:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508434C0F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:00:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so2119319wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMPRrxUBoBI3GJFXWBxFBuHLcyvjM70But0PbdWLZd8=;
        b=zcq1J2eLIL+k2q8df55+ye7Hxys2tMJLTMlQRglp0sCTmeX/RqUd9z3mxGK/mSKkqd
         ANH3AhrvgDD2klQxeiJ55Gef5I2N2kQFnkp7P2PbRPdMVFpHRcGHU/XeV+pjTbIw8Mcv
         QL+M+250rUWo6HGkkyd4nXZNeGEdXgQUNAzBylF6Zy+nY1DSsmqxVOkL+7JRGniqf11F
         fRiGPtv6/y62En1ObVdszuTROgt3dO/1wTFwi9mkTO1mKbHGyoG4PRHu3f0scB2eZtOt
         Hx8SzQwXntyvEl4p+yxIAHqRpzNvTNrucANIy8kfq54JUgTAlbJ0i/bch4ldoDb2vqGH
         mDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMPRrxUBoBI3GJFXWBxFBuHLcyvjM70But0PbdWLZd8=;
        b=Xz5BXx1DX7L/SjPn64RBecTOPGZUI3nm81vRyc73dSwX2ywBmBG6HZELvalZCZJ2KC
         3IKmP3/1znzDutem8zXWV/nKhVECtLJQPmwahDXGQkY15/NaACQ/BTorrcmyCpcX0oO2
         rVvexFBl6dX9OR/nfGBmCfNYlFZ3o3ag4rqtGr5qcAbHkz2LiBDcliY/7lkWZD5J9Hh0
         o+UDsSGju5yTa0V7FuRe+v6TkbVH7ZPs9dxRxbCr0rEfmTDaVcyMdD44K2LGH/wW40G4
         voym5c9uzoWd+7ZwW1p1dZqnNxjxgGr+w0iy0nrsx+wDhQPkboW+ge9u5mMA5BZ/WKvI
         odCg==
X-Gm-Message-State: AO0yUKWCJd3JCjpNAMw4M8WJl5QxkDZSUjnDObOdXFE2YtmLqp/zWREs
        bpO+QSgdPyfi0jXkl1hzD0xalg==
X-Google-Smtp-Source: AK7set+rZR3r6zfz/UnvhpCpt95V3+7+BylVCA1TjSIvxc28PMNGrKHsuxPu+R81HdFHgJKsJ7dsOw==
X-Received: by 2002:a05:600c:3ac7:b0:3dc:557f:6123 with SMTP id d7-20020a05600c3ac700b003dc557f6123mr3078809wms.1.1675274409864;
        Wed, 01 Feb 2023 10:00:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c16c400b003dd1b00bd9asm2241103wmn.32.2023.02.01.10.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:00:09 -0800 (PST)
Message-ID: <63371986-1690-3515-57e3-8b18e33bacc7@linaro.org>
Date:   Wed, 1 Feb 2023 19:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/5] dt-bindings: mailbox: qcom-ipcc: document the
 sa8775p platform
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230201152038.203387-1-brgl@bgdev.pl>
 <20230201152038.203387-3-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201152038.203387-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 16:20, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the ipcc on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

