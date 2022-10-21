Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54516071C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJUIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJUIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:10:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162899AF80
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:09:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so1703560ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VHPFgmHGt6vQ1ShPZTuxkB9fjJz+VfCu1DDPt9RZxl0=;
        b=eslRu3OzdDavFh/yjk6FOTqiRv9GtrLojydGZ36GOVjzvV3nBAvntnzi3W9zlDh9pb
         24G5GrI590knZpsx5KUTmoFYT9Kta98aTCl6iwykObQ1qv1RYeC37EM1rVlrgXt7ObEq
         IbLkcfhk73aZMQGx8cTUSdsXJyb+2KizRARlIWuqu0puC2l9VTvat+o1/hy5MI+X/ihl
         wbzwglUBQYdE9XzByh1Fx8btb1Hjev3ByLE8mkvzHtc44tTunkzeVculQHLC2638Kt8f
         fMqKSfFTRbokbe4HRVvkrmXnxSjpyBWZCpALpugZNHIRLxEDqAxJVVIo3+kusMKFLFsD
         /0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHPFgmHGt6vQ1ShPZTuxkB9fjJz+VfCu1DDPt9RZxl0=;
        b=2QuJFJEFkvSJM1I1Mbev3fkFqxQLt25ozu8S8Tw/ZnGtnxxGbk8LAN6teD9xAlGgLh
         fpTSc9hBZNMjTjJHaRTpweXyjV8hrmRDNIY6rVQfDQtNeooigCzukEA/6StDtwvVRKvz
         zK/5jqjFSUh4dqg8vMSGqnZC2xfs3QWukVrH4UDlqXQ9+cZpkDVa6lc7UJD/CDs2dae/
         6LDrvC9veFkUyAR8PeAXnvXo1TatS7eBwOdS09NB2myJHQbYT/odjEKf1b68ORld3PSS
         ixEnSncZULnYqeBDavcvSy1Wm6i0oD38t4WWUsomGCtGBFqcP2ahCuEE7eR8O1Pxc55N
         ZJAg==
X-Gm-Message-State: ACrzQf2xJUXLqdQu3VfZpmYWdkSIPtRUryL/eqU8VvVp6rfcnvpz87II
        G1WWpNlGzEjETnObxGON3rddhpyQKdwdOJI+RfIcTw==
X-Google-Smtp-Source: AMsMyM4He3zpyM3ToJ33ioXWzMnZQ/PXDACMo3hh/u4JU9FPyY68k0VaVpXPQNjuYP/2OMSedbeR+cCWLCt8oKeRfyY=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr13629183ejc.690.1666339794570; Fri, 21
 Oct 2022 01:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Oct 2022 10:09:43 +0200
Message-ID: <CACRpkdbvo5vyqpfP3EJvFRhK1hzq4uH=vzoq-H6q6hwJ0Bkc4w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 10:13 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

>  maintainers:
> -  - Sricharan R <sricharan@codeaurora.org>
> +  - Bjorn Andersson <andersson@kernel.org>

This is fine, but what about adding yourself as co-maintainer on *all*
Qualcomm bindings? I think it would offload Bjorn a bit. Just a suggestion.

Yours,
Linus Walleij
