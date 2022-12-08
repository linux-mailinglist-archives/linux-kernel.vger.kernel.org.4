Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26426477C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:15:20 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD19492F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:15:19 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3c21d6e2f3aso28776547b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLb6c3pV8MZQYOARt7wFYg4IvcTRaFrHi+WtxF8Db4=;
        b=lzDTGWDELDro1riwKG0siQz477cfqDaZbigVvRWIM9kyY1Y2ZaJm/6ScdYxqWk9A4w
         uRmTBk+AqMNB04d/2u8RFSfjO/sZaLnK/+RSu1G1PCfoRN/7l4y3s1OgBF7gG+tEAHtg
         glOHd1mrJtx3STLEzzYRw3xMVS32DpaFeEoFKQ6boob1WvMYQ6BVxDhPiyNUzW4YQ+Ar
         ntAI80HJc7iAx3daDrBeh9b9JJcM4FeHPiNNaUOOHs81KxK3kgoRompSSYsDBFxlqiXD
         jceM7dEHfsFCreLJOAxonQfz708upMPU89xbrmpPaV01mo6mWZo/qUFR1s3aj6zTZTtS
         2ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxLb6c3pV8MZQYOARt7wFYg4IvcTRaFrHi+WtxF8Db4=;
        b=EP1PKUx2aL6Lf5lSIzxM0iU6jP/rfk7FhyIB23ndi0Khd6CA3lY9Y+CszcFYpRODUE
         KLWXmXj3Z2TFqj6ID6MBfh0nKDy5ZjPBf9HZu4HHjUviXPJrz2BRCWWs4NZRu4U0+FTp
         H/DXwbC3mtUh3XX3/pzIB9UzhiqjZTVrksiDPRlZuRu61dhSV4RTmPipa8OLT4vL7z1+
         JxG2qdxtEpm5Yeb1ZAw4Yfk/VR1CPLbdcpLD9SAoNgFxshWbZUl/vPlht19frJaJLPcP
         Jmy8Pc6dUuHqW7zoHWo/NfGySlpOi/74UCeKg+rivCAcJFx5rJMGvrHrOpxEMrhDihRz
         kPrw==
X-Gm-Message-State: ANoB5pmYM22KozV5RMw6m5ELlNPNWvtBTCwa5vkBGNBFjpYMrn1S1TGC
        antuJRMrhz/Jw0F8tyb43+51iC1ERMS+EvSv0lE8Mw==
X-Google-Smtp-Source: AA0mqf5TMIaMGikCivHSN8QB/ySrGFpStI9jdjJ5wqz3y8/sxy4rK7Alc1fze08qJAV5K9Tf5G1tnU9ey8KciS44t3Q=
X-Received: by 2002:a81:5d8:0:b0:3f5:b69c:387 with SMTP id 207-20020a8105d8000000b003f5b69c0387mr10437422ywf.359.1670534118538;
 Thu, 08 Dec 2022 13:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <20221207131731.1291517-4-william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-4-william.qiu@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:15:07 +0100
Message-ID: <CACRpkdbjaiDhPcVH115w25oxseWrz=Yb-ugkmCOiqhRDmDZj5A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

thanks for your patch!

On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:

> +                       starfive,sys-syscon = <&sys_syscon 0x14 0x1a 0x7c000000>;
(...)
> +                       starfive,sys-syscon = <&sys_syscon 0x9c 0x1 0x3e>;

These are registster offsets and shifts. Don't define such stuff in your device
tree, use #defines in the code and just provide the phandle.

Yours,
Linus Walleij
