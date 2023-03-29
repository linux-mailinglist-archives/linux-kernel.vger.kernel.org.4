Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DF6CD4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjC2Il7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjC2Ily (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:41:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A81126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:41:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b18so18389661ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we/N4oQDR6XoZiEvq5GnI6M0YFT7oJjEt6185k+IGaY=;
        b=qFyiav9b1zdKBdgJCfyqcCgfBQBBsA1ndNq+BFIggKyw9cQxX1k9udJayM/p50i3Ov
         XHgtrpALhf5R3F/4m4bplS/w9Tvv1E9IWQhg33ExSmsRqULE+rAmnl2S48M8xvhdWXW4
         G4vD2EFmWTLP7+0KSCLYgJ7t8VeDgTjz35ekRb1Rts/9dPllu7Rd2oRy1X2EljuLDaDI
         9cRQOzYkmNzleaiRqiJpaDqAQgtV11V/IFo10uYG4AKrKOQsnVqFhSW5fShFt+ZAAKIz
         Vv/ALNRwC+zO+YL6b4j8tE8xMp9X8zOtWRykHa61iPEu9d6RxMwIFKs/hEFt8nYQcKwf
         IGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we/N4oQDR6XoZiEvq5GnI6M0YFT7oJjEt6185k+IGaY=;
        b=sx14SBNL1LWw7nWZfN04nSXlLe/ES1icYe8OmsmN4rVQo19q5q8d94iX2Bgoqe+v2I
         ip5Eo1ObZbXlFXTPaXyoXqftzLqyL1/6/WJko6/EaDyT8PRVK52fAFuF0YcWzqkuJNXJ
         NjhY+PWBV9qXyIj1dFWFU6kSdLyzZIAjhc0QsCY5jTlwqqQWMyd18/oshCyVQ2h647J5
         VFQ4apxhMNYyOPcVoQoHa8PNM3neAhB7u9BChVV8sd4Szrkr+i9GXUX8HbmsvqV5wF35
         x0dYv4sUfClvo8oOHIq70EMOg07CJhoch6yILwk1KgtsJV18TyI8lhhddXXDUY11596i
         /bPg==
X-Gm-Message-State: AAQBX9ft9dXtarjhW0XzGflcb7B85NQZkxwT9ArP9rJ5K4UPdBTMsSc4
        GPP3zBvBku/gD9ab0XP+OIs4j4JTKKqc+dymuv7pwg==
X-Google-Smtp-Source: AKy350aor2tRD3I/kJ+6CWloLqkSEKVo/h//FFtfDDrUGgRIOB5h7pz62ZhQRQC3LuXLMNjQOK3qmDTy7PR0MhwWPvs=
X-Received: by 2002:a05:6902:1586:b0:b23:4649:7ef3 with SMTP id
 k6-20020a056902158600b00b2346497ef3mr12388881ybu.4.1680079312776; Wed, 29 Mar
 2023 01:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230324084127.29362-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324084127.29362-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 10:41:41 +0200
Message-ID: <CACRpkdYNPNQRC22KD9gK2BwcEYJKc-2OvKmT9kVzTLDpWkK9-g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: allow
 input-enabled and bias-bus-hold
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 24, 2023 at 9:41=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add missing common pin configuration properties: input-enabled and
> bias-bus-hold.
>
> Fixes: 268e97ccc311 ("dt-bindings: pinctrl: qcom,sm8550-lpass-lpi-pinctrl=
: add SM8550 LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Linus, please take it directly.

Roger that, patch applied!

Yours,
Linus Walleij
