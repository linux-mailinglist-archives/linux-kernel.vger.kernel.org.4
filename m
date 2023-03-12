Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46E26B6A56
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCLSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCLSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:48:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671C18B34
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:48:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id da10so40417173edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uklOMUJVS+u74q2lNQ2L3Oa76MwPD6cKkPZXD0PzvOk=;
        b=svKsHNyMXagddsb4ZzAWmX2zcAIp0zVSsyZng3nX5FZgR0Fojt5NcyvJeKEvZbdiZq
         VpwT/97PGGZHbzLS2vQd2fRrgrDIqAmYiPgFwM1vv9JPe1LSDpYhVJKG9OdEFW1DU6fi
         +8UXQcfy/zjYp2jMD0pe9MA4jrM13ASK7QpFRkmlJeZEU3BiKimfG4OnWmQx9zJcIhHI
         vgE7/x1IXpiP0DbMmjRowE/t8vr5Ch2/jIA+ZZZxYoeI/IO0wTjn+bWj4xEjKjyuOpC2
         mR0uYCTT9VUC1MO9QT3Nirk6/TREnSVFv8Ns+MfHZFSpOOTAYJ+BJeex6scKi9ur75Tv
         +BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uklOMUJVS+u74q2lNQ2L3Oa76MwPD6cKkPZXD0PzvOk=;
        b=cItM7kQ6+OgbwovySHcGe6l86aKsxBvmNuRJe/OsYN4C84XCgw/i8d4BPn5S3y/dPO
         wV9etXHKaSY3IctS9m73wrtKsYBJ6ZYGhbOlTJ5dPb2cJitHo0zLV4AbU42fuAeeKii6
         R+v13l7JfSVdvHBOclJauhPqZMYWJc/VrTKIKJnznC7csAuED/DDrtOZTQaCrVoUi3jY
         LMwW8Rv+ewRItQ6+6JRhCw0DUmFmCYGm9RhlWUd7F6WZ/Xoq1mP4B5Yk++vpZp+KfbMD
         PLLRcHrWkxBKJKdVQ38eXnskZ7lMhMOhkfiHqiQiizARmv2ifgmkYW87li+gRaMnZF5s
         4vhg==
X-Gm-Message-State: AO0yUKXOuWrf6j379kZ8rwADemZGOK6Ck30+EeInJ/J5rM/VnXH0t2fC
        w9Lv+VdiDukwllSfSdnSn1yYO85lFyZhPclzywc=
X-Google-Smtp-Source: AK7set+wLPwfiYTBJKHeb6798JXdZToZ1wN8CLYiuEE03LcKlvgRWrhC81BlP33K3TpRYzt56OBfGQ==
X-Received: by 2002:a17:906:1604:b0:8af:7b80:82ba with SMTP id m4-20020a170906160400b008af7b8082bamr30601317ejd.20.1678644712043;
        Sun, 12 Mar 2023 11:11:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090636d200b008d0dbf15b8bsm2441348ejc.212.2023.03.12.11.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:11:51 -0700 (PDT)
Message-ID: <f0f6d714-f35c-fa53-f9bf-44cd4baa4aea@linaro.org>
Date:   Sun, 12 Mar 2023 19:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678644516.665314-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678644516.665314-1-sleirsgoevy@gmail.com>
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

On 12/03/2023 18:58, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> 
> Add two new compatible strings, "samsung,exynos7885-dw-mshc" and
> "samsung,exynos7885-dw-mshc-smu" respectively, to denote exynos7885
> boards that need this quirk. But it's very possible that all
> "samsung,exynos7-dw-mshc" boards are actually affected.

And now this is third copy of the same email. This is not acceptable.

Best regards,
Krzysztof

