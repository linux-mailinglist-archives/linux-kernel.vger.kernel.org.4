Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21A68FC0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjBIAkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBIAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:40:17 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF81A948;
        Wed,  8 Feb 2023 16:40:15 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id l3so104184uai.3;
        Wed, 08 Feb 2023 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6yX8VtZkx7dl2y0upkcZEBUIVD0yPRaz/YpeYEK5qc=;
        b=j5+3BSSxWzyMTSFYyKcdbAA2UxfpbXtQxjNUEe+bp7oXS18i3QAgONLadfd0QEGhke
         bYg+Tbd+5cTwWHGRLC59kAssApBoADqijkZhEe2dckxKqHTe5JAYcqnu/ohqgeQg2/Az
         JBN0uIFc+k72nZeghGw5s+1FCFE0Yvm7STeYDTpNBXaWASFBUN/Z+TnZPr9GBWyOIcOu
         KWVMmw9vErTVOG09FIJ+fzbrdnMJp+XV/r7WWSG56cpyw58teLH9sIigeFE01XSgC/sX
         ZXbwhlUBwChzcrdEZtQk8rB6nvh1p7WY+fT3NB5hwsZplbdiow1gbHMry7ukoZ4K7/G6
         CEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6yX8VtZkx7dl2y0upkcZEBUIVD0yPRaz/YpeYEK5qc=;
        b=S/G8aweIVcx1gRflQJSuugH/BIZOL5IYDvSoopwYgi3ZSoC8OcUABbKbyoK8zNpKkm
         ow5S6g9SMFCSaQEHY0te1vQcI4Q8uws2gTYgBu2tcLkhO5ddwEw/OlP2LeqgO7eTr1w5
         I9SH+m6M5WTdUal9MgO/6kYwXbyEScgeniywH30o8ebDF5Uy9yOFLnMo/4X4PHGEJQOG
         S0VBd5J7LoMFMG7kbN3xFuaAEEzQhltbz+/yG/vsRV1GTsMhzPoV2YBK75rnGZsP2oDi
         70lenUq5hr9kt5OE6gYVoWv9sz87Ze12YJ5P/tzgsKNNHK1oxCb8JtbJR5X7YrpRUt6L
         YkFw==
X-Gm-Message-State: AO0yUKVLKGw3xHKU1tL2Vq4GGGDmkUDlqBNfydiK2uofDEJpXy5r4bEw
        wecMDNd3lya0s5gSd/Pf/IUtVLNm7rdsJPaj1GRi/4PTbDE=
X-Google-Smtp-Source: AK7set/RoWCG5oItzj0ni8FCUva014iFjlEjxRCH3uSFsS91QvQd0FLVKEHMk8zyLIiGaCtobYMVj6vx9xmZFFsN9Zc=
X-Received: by 2002:ab0:3345:0:b0:655:1afe:37a8 with SMTP id
 h5-20020ab03345000000b006551afe37a8mr2430233uap.27.1675903214887; Wed, 08 Feb
 2023 16:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20230207091902.2512905-1-milkfafa@gmail.com> <20230207091902.2512905-4-milkfafa@gmail.com>
 <867ec517-ef29-e8ac-8e0c-6f7ca440cf3d@linaro.org>
In-Reply-To: <867ec517-ef29-e8ac-8e0c-6f7ca440cf3d@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 9 Feb 2023 08:40:03 +0800
Message-ID: <CADnNmFpf8kMeHYrUcab5Mg3P0zZ=kUi3o8bLCz-EdyAHVKoLNw@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] dt-bindings: arm: nuvoton: Add NPCM GFXI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

> >  .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++
>
> This is still wrong location. arm is only for top-level pieces. You
> wanted to put it in soc.

I'll move it to Documentation/devicetree/bindings/soc/npcm/nuvoton,gfxi.yaml.

Regards,
Marvin
