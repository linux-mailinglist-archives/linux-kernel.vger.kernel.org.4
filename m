Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E596C2DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCUJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCUJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:28:16 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C73C83E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:28:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54184571389so270163887b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679390894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76Qus1bli/VwOY3y8BO9Hj8Ms3aeQpfzWEQJcd1zGgg=;
        b=VkpYKq5PwFB/4tSmj2zzDcO8TG8YaKieF9O6DL6vMZ17b6c3VAUsKvhZx9GWRjWNJW
         tcPskQ6SjDjflBtEMeBhXQ+0YlUzTnKYc+W69Phzp50XFaNeNGmLAeDnqgfzSZK5ivSw
         YQrGh2L9JNZ/Vaq0gHO3ipTylEYUiEE0pL7/2BTUAsQVCwe7R7JY03ywBVMGGSWqOb7s
         Kx9WTRMdYGMMR0MSb7qKDY1AgspEJrZeWK3ubDyFmtGaAqQ/gRHAe5awTEPAGc/cXWdn
         N6JzUarIhOdiehx8Hexc1yJuE0HYYnC1XQOIqeArQFNjYgpPWPTVNbjXraz8QMbtke8I
         Sqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76Qus1bli/VwOY3y8BO9Hj8Ms3aeQpfzWEQJcd1zGgg=;
        b=F73rs7PwKBoabz9JpSl4Wx8iP9MDiZEBe+iPtCjqunc6aiB3BeA1RtSrtSWfKYMpg+
         7fLCtlS1vl9d3bY/0++MLlLE5ZFcN1CsuIlLVqVL8vlRsH+5pApRVRTNX8a+VGyBTGOq
         kZ9eec+7YeBAH8Ar1iDLMGL7kV9Hv0Q2DFem1hHf+ABAspYhLjjVmrFaNHRID5k0ov87
         1Al+I8BKIlgAD7Hu2SJJFxtkEzY4BrelYeID8aYgbaqeGkRt8avfwZXhtTD2YitkiqKi
         n/VGQRgxWdYcjick19GJ3B7zwvLO54j7aVKXAQjd/r9E46DF7YVjqdqdmQs3rc86Fg5t
         lWFw==
X-Gm-Message-State: AAQBX9cxPvHj48Aet6wlKXL/WtvvtXGOxCcYxbB9x5dfeFDQIIJAd63Y
        M5vkY+7YKsPkuspF9C3VFAN/qUKGpylOEOY/iPSlZA==
X-Google-Smtp-Source: AKy350YexCT1RHA6Cn204g9h8Q7dT08X4aKbreYthmzBiusk86//w6WusQsW0SU29UHZG3AZ4xmbQp5CwJHhY3dQlIQ=
X-Received: by 2002:a81:e20a:0:b0:532:e887:2c23 with SMTP id
 p10-20020a81e20a000000b00532e8872c23mr636381ywl.9.1679390894044; Tue, 21 Mar
 2023 02:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233928.2920693-1-robh@kernel.org>
In-Reply-To: <20230320233928.2920693-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Mar 2023 10:28:03 +0100
Message-ID: <CACRpkdbrsh6e-AJ9Qp2G=47zBsRWxDxOfZXp9-7kvOSQ1Vw0Kg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-riscv@lists.infradead.org
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

On Tue, Mar 21, 2023 at 12:39=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:

> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
