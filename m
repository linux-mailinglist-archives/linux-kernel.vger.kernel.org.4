Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9F6EA646
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjDUIwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDUIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:52:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7BE9031
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:52:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54f8e81c3f3so21592047b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682067157; x=1684659157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qzjJ2PmHPgNU8/dkx2qqHLE2kyFi/31txFoMjeKLLU=;
        b=xaXz/vDLacrfHY6V/kcDWGeNcMH2mZ81JZSsoGOS/rKEz2WQNhO3NHJA1J4DyWH6bT
         8a2KC7t74JlURqUPKd9awN44hsywgwSge2LbUFn5vUM+9k/HxjPFqYCmzK9ENKmF4aFn
         Yq+mAqtrIIlZOAaRKFYwx3EfzfD+hpP8z5KviQ6S5X+e933suooOn6YeYjVci+qv9oyp
         JDZHSbJ0GXGyheFlP4VFqStaltwxO6WDf7J5YZYrSIZdKLG+oi00RxT+VV7mIbIYK+79
         e6c1WR+Lxrd7mpWP9p2ZEIqF9ZMynuEcMFo1DPwXoIe5vmuDsEWSPSL9aPceAohsKjDQ
         IBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067157; x=1684659157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qzjJ2PmHPgNU8/dkx2qqHLE2kyFi/31txFoMjeKLLU=;
        b=DfIhdUlTHnYTR7fWmm2rGHCGEFON2n9akaBkjRjkgk1ZrKPJ+iOAZjvuFRqU33/1X8
         QT/pWyX/4y2hH4SMsAbId01U4G47Qcm2chMcPLzFoaNdK3SNBXOUHKlg6vqv9q/HEEw1
         DNCKrR9oWtPDgtSLLfgKPE/crKNZ48jli8fEZkK8Ma2jvm/1waTWQs5ppe5BMfUTUtMg
         s6MljJiAZp7HqYmt10Q4dVTOdePzw1dGU+CzlTnccKXPEiHNO/CCJpJQMUhyG+uEJVRz
         V0EpY6KeKgnnub8oOJPBtmmwVFzgUqutrSxL8a2pSkInOdYlnvkaVz4o2ClKScfG56+Y
         fO9A==
X-Gm-Message-State: AAQBX9eS1EduKF6deg92a5p3nJ9HYIVAmZX/t6NySzOVopGsd/6UOU7L
        e025kgBCxQEYzIwC0bucn1gnvOqC388uEBjHyAfKNCWeqdV3HSnH69c=
X-Google-Smtp-Source: AKy350brYouH6uVQrJEsEI20GkTW3nJCEojKl2plTzL1YweX8CQObxGumhBmKmdN8wQ34j6TIPYXJ0L46+vmQSoD0k4=
X-Received: by 2002:a81:6756:0:b0:54f:b0f2:9b83 with SMTP id
 b83-20020a816756000000b0054fb0f29b83mr1167544ywc.5.1682067156896; Fri, 21 Apr
 2023 01:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230418150613.1528233-1-robh@kernel.org>
In-Reply-To: <20230418150613.1528233-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:52:25 +0200
Message-ID: <CACRpkdZNwasR9N3dD7b9nhYyEE9VNq4+cD0ZnZ+A3TeRGg+SCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8150: Drop duplicate
 function value "atest_usb2"
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 5:06=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> The enum value "atest_usb2" appears twice. Remove the duplicate. The
> meta-schema normally catches these, but schemas under "$defs" was not
> getting checked. A fix for that is pending.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
