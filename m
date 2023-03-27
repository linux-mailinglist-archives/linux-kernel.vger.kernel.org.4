Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA56CA7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjC0Odv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0Odt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:33:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748ECE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:33:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p15so10819625ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CcCvJ3M8X5bAT0MjMyx1DIy4dFWq+26CM4dvph3VyA=;
        b=qyvfOd4NZMIuS2cCHeUDyJhTUOYo+PZdpDghf7+nGJANwRa2wD46ockofA01/GMBjj
         P4EMGYRT4W2V1ICq/1wqC11cQVb+3KazFNQTR2JEvqewPFsbJZeS2grXj3NfhYP8fftY
         7l/bH0t42kLO9GzCgy3MHa6HmdeXitZm33YLagQ9Xi4D2Djfvvn+s8OME+VN1mBQ2ZqQ
         LbTEhEoBjDwhwcqe9etqDKtkd5D/l7pEFGvhVUgf55Wdg5cCizseq3Kz6ptPhXGKe8hu
         5Avyn45l/SDpgwFPx58Bvz0xmEWqr2a3oQ4Z1ImkwdLxDd2MKAMGi+RFTI+Sotaa3YcG
         Osng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CcCvJ3M8X5bAT0MjMyx1DIy4dFWq+26CM4dvph3VyA=;
        b=OOTtV5nY9xulHRmJiMzZWi9/r0I77V3GG8ucbUsc5OT8vWVdOO85GNXhRX7yo1miLf
         ktpjSwWQ6ush6mgp8UOGlgXaMrj+psH7XXTFUud+V9nd7PzfaRaTmF8/dsB74pi+Ngv/
         0FQd9Ch6CUwV5BRYm+qxV1IRxMX92R5ishzWmTXpsgyLXRAq/ptEBhqurVDoqVFfI3QL
         OsQbHJC46fGsrWCv6DzXNMeBFIITXtrEt5nhSvo/lYwjspQ95V36T3G2bEF29h84dE5z
         m43TI9rnTt/Wv77JrGv1tbb8Xd824uyl1MHiZ/MQjlvgnUes2XaK/8l93LwW8irDEHwp
         9rgA==
X-Gm-Message-State: AAQBX9ccdqNDVkUyQssMQhlGpTJZPtn7yov8LMJ60Wmt+wjsXTo/T+Kg
        P734fqlzJPB7VAYQkTA0yJ5I22uYF0O9+0/2brbxaw==
X-Google-Smtp-Source: AKy350bNunvajuzPd/DqZePLz1idoUffSv7bokNWvRXeIBJYkk+GTrK7xk0ngdbDtiU1co3aD0VeZxdvhKus7BlJcQg=
X-Received: by 2002:a05:6902:a8c:b0:b7b:fb15:8685 with SMTP id
 cd12-20020a0569020a8c00b00b7bfb158685mr1336018ybb.9.1679927624688; Mon, 27
 Mar 2023 07:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org> <20230327140752.163009-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327140752.163009-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:33:34 +0300
Message-ID: <CAA8EJpoQwWm046sBv5KGm2Ccw7U5JG58ppaPo7PGcB5iDgUugQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: mailbox: qcom,apcs-kpss-global: use
 fallbacks for few variants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 17:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Rework the compatibles of IPQ8074, SC7180, SC8180X and SM8150 as
> compatible devices (same from Linux driver point of view).  This allows
> smaller of_device_id table in the Linux driver and smaller
> allOf:if:then: constraints.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
>
> ---
>
> Changes since v3:
> 1. Narrow the scope of the patch after feedback from Dmitry.
>
> Depends on (merged to Qualcomm SoC tree):
> https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thank you!

-- 
With best wishes
Dmitry
