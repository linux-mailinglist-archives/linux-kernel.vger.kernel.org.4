Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8B73724D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFTRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:08:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122A10D0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:08:26 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a9db19d663so4517542fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687280906; x=1689872906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPlUpaESmFXmAV66+b1zbSLli4Uazi7WstGyzYnlL8Q=;
        b=evyhWqxMmaFSN4XuTAFRQEtpaufofDUDF/BnAJGZgSN3JIRiQOdj6YwRDBU8a/VjdY
         kuAXp1WiBdRnWXrKNqA+21Hb86pePqUHt4zQ1cp54Vl278noNJ9eDttgLLZ/Tfi4Z+kM
         iMMnQu4hO8ocKqWOYFOX17upmg9fUB3udIHipM/IVLJOU6OMQpPXuj09Hr7ZGvONJGXM
         tQ+srGQ5rYHpeIL7Ib4ZVpxIoEUs/18S4+L6tIIQxizl7zbVnE6jYQz8vMmAEE96s6w+
         YOxllz80fnEqi4p8vflN1LeRLh1JfomVc1w8301UCFFErbe74Kxj9Cr1tC2JtQwIxDXJ
         ftlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280906; x=1689872906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPlUpaESmFXmAV66+b1zbSLli4Uazi7WstGyzYnlL8Q=;
        b=TQu/OJTvs44T8Bxb5T3uGDqeHjXYtR52Kc6SodDSTwPCoYadetVBj83AeuvUEa065L
         SXLUcWghWHKO2/GDOYjtUAk7uCbTRY3qUhcujSsGqVu1me/0tIPxmdWC7R+DSkt7p50M
         uvTPctqFoV2WxdMou8fbjZBECTGF0yeSsvKHPls7q8vZvOBzuuq+P0yP2x7VooqPkonA
         vgsn/7ric0s9/aCf14p9MfbCPR+jt+xjFul+OYkRB3TOdn0PSxkqizQgBCxuQJ7VVfiE
         k2coRxnu0onN9Slx2IP9KC0fDDs+8rwVObBAR0ikFIBet7nJSU26502duMSJw+3QtwWH
         wMQQ==
X-Gm-Message-State: AC+VfDx+OR8LKsaxenwYWc7ixLq0v75GUJ4LGvpDpp4vkAi2ftsnaSoS
        DBpnJYHQ3loGslkNB+OmmNZbg6FKhFuIOJIOu/WpOg==
X-Google-Smtp-Source: ACHHUZ4RFHPGUZU1HKDnnXGV3LuEfxMOZ6TY2ggl/uGIjn7aYRfweo73+LErL1NW11Sm/GbAkOb45mZgSAFkhjVteBw=
X-Received: by 2002:a05:6870:d897:b0:1a6:d702:f03e with SMTP id
 dv23-20020a056870d89700b001a6d702f03emr9703837oab.1.1687280906189; Tue, 20
 Jun 2023 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org> <20230620165028.GA3805350-robh@kernel.org>
In-Reply-To: <20230620165028.GA3805350-robh@kernel.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 20 Jun 2023 12:08:15 -0500
Message-ID: <CAJe_ZhdEgucXJk0B3uRqsEaQ4r3AiixL1H0PBYZTX8rfpTgkbA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 11:50, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 15, 2023 at 10:58:13PM -0500, jaswinder.singh@linaro.org wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> > Specify bindings for the platform and boards based on that.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  .../bindings/arm/socionext/synquacer.yaml     | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
>
> Should I pick this up or Socionext maintainers will?
>
Please consider Patch-v2 that changes the subject line and specifies
the SoC compatible 'sc2a11b' (Synquacer is the brand name).

Thanks

-jassi
