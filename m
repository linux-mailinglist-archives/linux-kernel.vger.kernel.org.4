Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828536C61DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCWIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCWIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:35:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DEEF95
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:34:28 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-541a05e4124so383296107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679560465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4RYoPJ1LErLnjfKLVajCu6GU5STQHSZ9DUFEBKc2Ss=;
        b=GrRWMTpR78EiK4AGRh+wmlmCJc3yCLkLpH/UHF4e9cGS6u0ubEfnOhxJ/TlOwky0s8
         WB6++T3F+9k6IZ4E6+AnMDkgBvTHjHkZssw2T5snvgHlVXVPzEJ6Lhy0yxo616B3KUTU
         7XXdpc6YcBqJoe2ZM6oL5xe8PYDGY+d8y/Xt5QMGsideAAPUH7yrMGJrZrmRx5+uzFon
         jgdS8g/ujPnYr53RqC/hbmGIU9ZTPYW4D9iIrTFbAxBWC/Tkxy1GXf52JO1bIRBLV35U
         wd0qCFxzRzWpV6lqBEIAUjokdAC1KQf8QK7ezjT3lAgU8GP3x/f/kbyhwAIVnwj0lwNL
         MzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4RYoPJ1LErLnjfKLVajCu6GU5STQHSZ9DUFEBKc2Ss=;
        b=xkgS/RLedYDGCd9t3tn9+EG2VJDZLnQ2arsnL/RK+Uz1tnpW7og/p05xT2aJkXzQjx
         +ERbgGUcx8f167UhqacBTlCU7Veqwlb36wbG2RIAniCHTob7WxOxtArhUR/Jzg4I/Y0h
         sH9qJn4EHybIocZcxP5fKfbO4aM5Xft1jAUrdiNusYhb7lJMZ1DfPBo9JVH4hYwgoJ0Z
         gy9M0FauV/WijsxRz7N0etvOxOpgtob3LEa9cw3+xmGJMFG1jNwaFH0UykmV1/0ditZQ
         zIoi6oPEeLyK+P8M8w4rEpcdNneki5fNLM80LIHZ7Cqr/SFu2ZCKIp/azrycudFiMEew
         X1cA==
X-Gm-Message-State: AAQBX9caMOZQ3XzkPMjOgJgW45V/yPzBuz21BfU3Fpo3W8fKR53a2Ayh
        2rdw3O1VXGzbvwiomvr0rdViDhD2duoigXGW2OvMNQ==
X-Google-Smtp-Source: AKy350ZaGM1U6Ub4iMxUNlQn/D6/CcT7QXGB3nXKmuAYzeKKqb6dW4NRFfS7v1XCoePQnsn6MuXULcyXhrBnNby8wqc=
X-Received: by 2002:a81:bd11:0:b0:532:e887:2c23 with SMTP id
 b17-20020a81bd11000000b00532e8872c23mr1431390ywi.9.1679560465580; Thu, 23 Mar
 2023 01:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230323012929.10815-1-dipenp@nvidia.com> <20230323012929.10815-4-dipenp@nvidia.com>
In-Reply-To: <20230323012929.10815-4-dipenp@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 09:34:14 +0100
Message-ID: <CACRpkdbPSyQbe8pC8EzhyGoVor+piaKRCoXLfoW_n_9JyYLu1g@mail.gmail.com>
Subject: Re: [PATCH V4 03/10] dt-bindings: timestamp: Deprecate nvidia,slices property
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:29=E2=80=AFAM Dipen Patel <dipenp@nvidia.com> wro=
te:

> The property is not necessary as it is a constant value and can be
> hardcoded in the driver code.
>
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>

Looks completely reasonable to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
