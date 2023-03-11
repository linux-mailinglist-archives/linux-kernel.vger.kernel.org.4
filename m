Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E896B6127
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCKVtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCKVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:49:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169525952
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:48:52 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g27so4676969ybe.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avxORhp0kgP64csxpACe2lIp7clmoiWT+buAVHFj3Nc=;
        b=SvB+Yt3B6vMI7SzhX+OqMjxdEcXKooqniB7M4emFHM4IrJv22AHfu3/pshLPOfpNcf
         IXFPOGOLNYpvg/LdcyF/kb4wfrtQllkGahShUydijKp2tQWFdDLGXovERBdh/GMeBjMk
         Yd3DtDXsGeXtupKttlzPTcrPPPl/cTDS2VLNMGIBe30qV0HR14fkgW5Pu5ETBaBLYWzl
         nxrP1gupaRueT/AzRVwMF/NLmmwpi1SMmJtiPykyGDdfrbEclKRUGRcX57yZcNrFoCFM
         36Q306aZjNUZ+oiN7/mnz9Z15rA2YP34rCnqUswxgNLRMsmDzriXz9+R2nUaNdQ1UNbE
         wqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avxORhp0kgP64csxpACe2lIp7clmoiWT+buAVHFj3Nc=;
        b=NPSlLsagNvaZmhtBv08EHvDmQWV1ghq90rY2I1zAMGs6a2u4YdCStijqzS/f+nKNhg
         sUPwbHpi7MKEYCqP/B3M7x17AhO/7AEVtvG2vljVEpS7zCr1zSp71t0cb0vq5IPEzdPp
         1xdoTJANQLE4WjPebquzKEk0Oh/FnM4nPyW9vSuKor0wcVdiJsdBcuzBpHTpMtvbdj9J
         Bd7MeeK9kCqZoefta2xOZsI6Ngjb+wasZsbiN68s6Rmc8WvOksnp4klWTyAL4nlVcdwl
         uIIu4FEKr3hVvCIrMGc+GH2LmPqvDt+LDtel+WMnicbpxEz78AqyawZZvvDDvZLXZ6TV
         G2sA==
X-Gm-Message-State: AO0yUKUC7p4CCUyOnMAyG36S29M9qLdglaA6dxTTxiPx621K43aPbFnL
        rh+perI7/l0fF9SFqGxFYlhSuooZ2EtEEr/VRJUw4A==
X-Google-Smtp-Source: AK7set9WUuzYTIu0VGcBjZgeP3fzHchaShWW88niS1CjTGA6sYt4+6dioF4aKW72ufcsWNGNH6ODRKgk4q9A3qI7nbk=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr18396213ybq.5.1678571331687; Sat, 11 Mar
 2023 13:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org> <20230311111307.251123-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-5-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:48:40 +0100
Message-ID: <CACRpkdbou26bxA1vkm2C2X_Ncg_O_R_X8UV=U3__iw+4g2ED3g@mail.gmail.com>
Subject: Re: [PATCH 5/8] gpio: sifive: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/gpio/gpio-sifive.c:263:34: error: =E2=80=98sifive_gpio_match=E2=
=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
