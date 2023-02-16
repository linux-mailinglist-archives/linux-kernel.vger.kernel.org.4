Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C0699269
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBPK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjBPK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:57:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47CF56497
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:57:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c1so2229064edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THtAgCOl9QgR+PBCQKm+XDfV9tIc7qpiTl9QgWvXcHg=;
        b=U6H4iC7hYR/chymc+q+RyndAL4se27QK3fvzV8WqQIXuxxRKB3uUKGFgBjrA7pUhA3
         TxIdXtyaKdN2b9jgQ/IS7kSk1qgAAicfUPdajYmMdO68hu6gElAWF2tGciziJJJ2dLBy
         unTddpuWUJKM5PW0GhDoICAGoSiD8ND3c6o/LqYpOJTFrtts6Z0Ctnc88pmdzINdTmOL
         z0G4cJOvTfV9H9Pe2fA72wHz2Y5/i1cyOIXzZmUQSlvV5V8FGEkKBISBPaNJfSQrpW6q
         xDWxuzZRmspaKsBw+tYYoLaPol80grKVz8IS3y1SyxRIZUxnJpQNorzRPOwfXEQA/bpf
         2MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THtAgCOl9QgR+PBCQKm+XDfV9tIc7qpiTl9QgWvXcHg=;
        b=XXVT1U7A9ewJhqahbgFo7CStz8LisxLb1/QWirXjPj2Ac5pGVmiIc+8zH7RCMouGKw
         7/xiAi/Equ8YXKM6PfZ+7sfVsD+F/iRG3NGEbFbPq5O8FBCcVUP9ffqx4enTg/tgoJtW
         Kr5bKoznxrSH+PNYbGg3iZP8/pFPCBSZnv1cRE3NTpQPDoEuLSYqx9rW7ftfyMmp8aYS
         a3Qnk58E7nTnR16VT5wYSWl+L1T+s0wj3tFVoGieAYvnxNsrBvBv2l2ED16FRoMtokLQ
         vZwe3DjIa5pFjm6mmseuOLGn0IuN6m+Y/2yCv79f4IrHtGEnsiXUOrFjYg0x41ndddEg
         dAKg==
X-Gm-Message-State: AO0yUKWuKtq8GyT4duW1D1Sm97uT45+zlIIbwL41WLeP+t6jbARI/oaC
        g9mn6Ivx8w01XWSxjZrPKKy+5w==
X-Google-Smtp-Source: AK7set9OfkNt5LKvITUMHqNbfAMut7qF3b/o8biOq9I1xBhTpbQURE55MHNjA797MY9Vjl5S1t9X0Q==
X-Received: by 2002:aa7:d4c1:0:b0:4ad:6fc6:ae9c with SMTP id t1-20020aa7d4c1000000b004ad6fc6ae9cmr432542edr.17.1676545023642;
        Thu, 16 Feb 2023 02:57:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x72-20020a50bace000000b004acbe8255f1sm669464ede.86.2023.02.16.02.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:57:03 -0800 (PST)
Message-ID: <97a62d16-42cf-d778-f9a2-ddc7cc936d1d@linaro.org>
Date:   Thu, 16 Feb 2023 11:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 00/16] Refactor Exynos PCIe driver to make it generic
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97@epcas5p4.samsung.com>
 <20230214121333.1837-1-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 13:13, Shradha Todi wrote:
> Currently pci-exynos is being used as a PCIe driver for Exynos5433
> only. This patch set refactors the driver to make it extensible to
> other Samsung manufactured SoCs having DWC PCIe controllers.
> The major change points are:
> - Renaming all common functions/structures to use "samsung" instead
>   of "exynos". Make common probe/remove/suspend/resume
> - Making clock/regulator get/enable/disable generic
> - Adding private struct to hold platform specific function ops

Thanks for the work. I appreciate it.

Some comments in individual patches.

Best regards,
Krzysztof

