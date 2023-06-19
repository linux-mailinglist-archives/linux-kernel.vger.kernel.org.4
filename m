Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A1734EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjFSIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjFSIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:54:04 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AECE50
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:53:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc405d9682cso2464929276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687164797; x=1689756797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLxFZi7zXkcKU5LLEJg/aSz/OCXeD9wZDC/9zhkx7NQ=;
        b=UaIka0b2cvYeaN4KTZouO6vXEBL150GxuHpHx6GjMn5ntJ95fq817okG5YGSunCMt8
         fBViAWgWIKVcMUMmchxHs9CPMKyYGVCqo3+u+WHssXrPPGvpQgbWGrRzikZQSoPxXNni
         GgiRrzr5lHLcDdLudzV3MB2c+RVB7avGInueRc/IQLuY8MozZaqnH3z7SbesaR6E6rnM
         y5YvPZgr/wo+usbhooq9luiTBXyWYh8CY/7TRD5WLRUiz1J2JO4/M/WHQ0RH7vrdNQq4
         oHP9BQso06OYZZElDaV9FXa58MlczvTEw6ePLOCyMpeomy3KCoN1IAs66TgbM+pNp16C
         ruBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164797; x=1689756797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLxFZi7zXkcKU5LLEJg/aSz/OCXeD9wZDC/9zhkx7NQ=;
        b=DALfHovJzXxk76CL7q2iJtlJTOb+WB8KsYjYw7vUx+NFoTKP6BC24OfJ+abdpC2DFA
         ee8LISir8xx/p00TTmECNH5U9VXZ56LTm2rctxJC/ttoGdg2lQLtW96quPicUP84wppk
         4MB3fUP+xHTnMXnfAwb2y80KwlYpOGProZqwlGtVh+WNBZF+xRlEFhH4TEkbHFzAaOEn
         H95rWoleSRQprfXXtpbQfhUj18Akg3+3iCBrZVWJuvKNc9TuqmNhUNut9V4CHxwmqONz
         xPp3xKQgRzEIOLbOrIxxBt1sUaCBUFbVXTHZZ37z0BZXM3f/z8FtuyMbkB6fvzP6FER7
         cQuw==
X-Gm-Message-State: AC+VfDxYWYg/FyuulhpITS8hYXBy5boRjh2icQYwis/g3MMa6lLPlE4z
        g5RvB0jt3Nmr54Pa2z0EqApg6PIzjuwNz4WkZl9OY0DwwkHSiyfc
X-Google-Smtp-Source: ACHHUZ4EywsUOBheswAbpJNJBP2MwZGkmFErpy/TTrkqdxKojVFCzC0SsE1b18OVK/J/9I+lSIGdtzwBbOTZXtNRoSs=
X-Received: by 2002:a25:8487:0:b0:bc9:1019:54d with SMTP id
 v7-20020a258487000000b00bc91019054dmr4104717ybk.18.1687164797486; Mon, 19 Jun
 2023 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230617111809.129232-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617111809.129232-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jun 2023 10:53:06 +0200
Message-ID: <CACRpkdZpiJtRnSWGX+mZSPkXoY3ooauzOxpPF038qPRN9MNORQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sdx65-tlmm: add pcie_clkreq function
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 1:18=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> DTS and driver already support pcie_clkreq function for a pin.  Add it
> to fix dtbs_check warning:
>
>   qcom-sdx65-mtp.dtb: pinctrl@f100000: pcie-ep-clkreq-default-state: 'one=
Of' conditional failed, one must be fixed:
>     'bias-disable', 'drive-strength', 'function', 'pins' do not match any=
 of the regexes: '-pins$', 'pinctrl-[0-9]+'
>     'pcie_clkreq' is not one of ['blsp_uart1', 'blsp_spi1', ... 'gpio']
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
