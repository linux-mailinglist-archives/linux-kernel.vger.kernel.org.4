Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5860E5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiJZQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiJZQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:57:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55E9A299
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c23so10357993qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw8Lu/nQQlzhzTL10tzeDgp/jy8BsPpF+rlfLrRcyN8=;
        b=euX8EZYonvHctlnqgw4g4DrpHpWeKzU4dH1zN89SY7X0p3B+C4H5P/S01aDJ/Hfavc
         85ERgyQny3gfjrEPQLOq4a0NIDKeToV7G8DCIZ+cDs5sVfBYAWDzHAO/nHHAGJDsSodq
         /6d2z+/EK4rYJCmj12JcRrONlDyTgscTLW/jaMq99+psKaDrmncj0l0xhXE9lJexDAiZ
         KpY4Ed542LoNhwqzR4PMTU7Tx1t+10SKOo34ox18erkmxSO0ekY7q6IhnbRAuVa7873Q
         xDMoeqUj3DqYDo2gvUC4MQ2E3n2/yroAUu9i+Ri/0jV8CsCoJDI1Ktjosp6rBfvOvujs
         XcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw8Lu/nQQlzhzTL10tzeDgp/jy8BsPpF+rlfLrRcyN8=;
        b=CDgNU4B3YL69KjihgnPaFxB5Fi7aFbzRlsrzV4XJCFlpg5c5ei20PyDA8M6P2fXlAo
         1XozfE6kiPbzoZUbxQ6JWOOAOnmEghfGEEiI261lg6d0XtoHW49P87R3v3VHWp/XBtQz
         CuSc1LFmIcL9ebXvKtFghPCoG6SzfPOYEP0+I82J1iz9Y1Zs4ZxnFu5r/ZQ0AvhuYP4a
         ip7cSOlJZ3pq0apl8wbXMRovWtTf/CFeCwyCbmiBUAA0icyAH7+UL49/D5PaxQcnsAIh
         yBqhYj+Pvkhk9Zaft4dbiXdA26A7XRCnA+ay1NsFU6Xg/5cs5SCL7d5zdbLoI4q/1Hp3
         6WNw==
X-Gm-Message-State: ACrzQf2kmTCwWhD/ROIC0PAgMGWj+XL5QJX9jvZJID3pXNaEswUMMR2J
        aT/5ce7AFZjpcvS0gxJaxdpgSg==
X-Google-Smtp-Source: AMsMyM56+TJJXBIoEqLeE0nQ00qzkhNR5Zixg8AxhMZz/SGfFeHt9tR2a1kFAmxd1/7ssYQcejFGmg==
X-Received: by 2002:a05:622a:34e:b0:39c:8965:549 with SMTP id r14-20020a05622a034e00b0039c89650549mr37591547qtw.268.1666803477017;
        Wed, 26 Oct 2022 09:57:57 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm4360759qko.53.2022.10.26.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:57:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ti: correct indentation
Date:   Wed, 26 Oct 2022 12:57:45 -0400
Message-Id: <166680346261.49767.5822216815717858081.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002092010.69030-1-krzysztof.kozlowski@linaro.org>
References: <20221002092010.69030-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 11:20:10 +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> 

Applied, thanks!

[1/1] ARM: dts: ti: correct indentation
      https://git.kernel.org/krzk/linux-dt/c/cfc35a16f42e15cf5d9f070205c4be6a873caaa2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
