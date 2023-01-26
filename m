Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B087167CC83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjAZNog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAZNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:44:32 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A15196B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:44:24 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-50112511ba7so23315657b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PivYBvT//fhOJifn8GUHrZsSg9zLcCPOv6nlRmaHzI=;
        b=L/vb2O4i1Ct4bt7R0wAfNZVn9dcnDGaAWwDe/lEFy4Jb0JCId4n6nJPJ9mQeBqs0FZ
         9DYzDZ8Ak2EiY2ITcbblIaUQPlFbmGtQMZ+G6eSg27KxH8OBxEL8o4FvOd4v9WKMnVdG
         7Ca2q4Z8PWkQT8gl1VRERw9OtRl83xc1siK04f587Y2We6Pabxu9mLWMFqvQVmmmfhAA
         /BicSkLu0on4pqaeophqVdHWLAhp9HViAL+z8o1n0h1r9lUT4+8HJ80IlbJiDFvOitYk
         C2rhmaWKSl+Jncs3CRavXdnlYKoZSkmTAGNXs1T/wMBTvITnAcrn1yNRxk1yfE0L4pUB
         bBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PivYBvT//fhOJifn8GUHrZsSg9zLcCPOv6nlRmaHzI=;
        b=qyJrFuvjRAVcMfiPvYMx72K87SaapVLlhdAiK0mHdjYkoFYQoK80DVqX6JkO52lOCb
         k6e27Z7aonQ8zFt9gLPONcjx1bdnQoYmLOLgv9lgN61Xl7hQ332TFhnbg9WZjUWpVMW5
         X7Hsb0lidrY0hmI2GKweq20w2yS9TjIf7L3hGUDszsku3AILwjtJOHXorbPAJtyqdUr+
         jr8AuTnjafC4PgYe/laPyM1qAmi+e+slmAvq/ygfvx4sAOf1qiO8THmCI8bhl4MnLFEk
         WzVjBZRsqtCucW68rRO3t7BXTdalePM08o98rvVOf5cu4/DS44zjWd13iLenpUe/1v29
         58pw==
X-Gm-Message-State: AFqh2koiyXpR8uobUNEdcmpONv4lwqwLE3hfVe73VFFHaXF7xQtF6xyk
        05aikXX7IbXeQUNyxHF+Asvpkj/nK64QUBHTVWUuFA==
X-Google-Smtp-Source: AMrXdXuoa/a/hnuvpGi7fAa3/wjXsF3qLLk13Qa7zXuEJlGrjLfaBAXtJbT1Gdrgo4CC9bIxFoGoaXBu7LJTKcvch2s=
X-Received: by 2002:a81:6842:0:b0:4ff:e4bc:b56f with SMTP id
 d63-20020a816842000000b004ffe4bcb56fmr3073866ywc.488.1674740663215; Thu, 26
 Jan 2023 05:44:23 -0800 (PST)
MIME-Version: 1.0
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 14:44:12 +0100
Message-ID: <CACRpkdb4=r2un35p=7m9RAB5BSz3stnR35jVTirBKmv56qs65w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
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

On Sat, Jan 21, 2023 at 12:06 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Currently all Rockchip gpio nodes have the same compatible.
> Compatible strings should be SoC related.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
