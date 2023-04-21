Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011E6EA62C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjDUIpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjDUIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:44:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57EAD3A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:43:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fb4c97d55so4661457b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066628; x=1684658628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB7OczqlU5GlOy2Zd9Rj3EOn0m2+6oU/DJ3XuT+77QE=;
        b=OXxmlnhFGlBUHNcmd+OkPmbb9r/taSkf+vrVB+i1O0PVlopkmHODWY18HgOWPt6ATq
         xWPpEEQgelEDU0l30b8lhpkE3OVCpcAnji+iG/0dXp7XEOwWg2eXoAnTRWFMuMU260dw
         VtUHwow/hj3KIcM1h+cs2oXVhYoR3o8S7ebPPiIpdSYfetwbwei0ThU653b1OMshM3eB
         Oyo0iqnOvnYwHfzXTKfCOAYGOKV61mq5B+2g9SGqDD9IcMV2i02uEvRwgFiqnlhJutbT
         b3HZpLH6fJ00az+cuhprxokwGl1bFzggbv1Eubn+VWuTyVvPQg0rdt8fZxyyJYCLKJfd
         Ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066628; x=1684658628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB7OczqlU5GlOy2Zd9Rj3EOn0m2+6oU/DJ3XuT+77QE=;
        b=K9UdOURJiexHDKWCKNwLC4mfnPTsKYGyYpQ2Eus6h7YFTgA1z8BhEY0PQ49wyXfDWX
         nteOf3rbx4MYLLJsqdzPhT5mBlXGdyI69uPe+RMGIeviP63pkSPGJ79EfHHMbBK849OJ
         orO/9Of5zP+DQpElCegmhc1xHNAIOkILNGMqBfVDcbm/7gBzCglAi+jdqawSY5/037IG
         nPWdFqsUqncnB11sZllRoFVrkCtQTEJlzIP+i3D0pY1/O2LpnZe27fiUrgqwT4yB89FV
         m3PcRCCnH7ThF7FAucFoM9rWFJDuALyv86P8qmyhUr0hPC4OshMC5zm9naDR7MMt9EZt
         9f7Q==
X-Gm-Message-State: AAQBX9egnPFplZ65eVrGA96cdlMO3wRJCdu15j/cqaRusjjNlVpYKheY
        Aq/KTr90mmRCrAuUQC6KkXkXqSsvgWEuLLNb3T11iQ==
X-Google-Smtp-Source: AKy350bpPZ0S/XO6upKWqUoG5fpVD9ioAg/A0YRm/02f/LCUie/ZnJMKTyUgcbE6/nIhxLdF5BrdASq+GnAR1HP9tSk=
X-Received: by 2002:a0d:ea0d:0:b0:552:a2e2:684e with SMTP id
 t13-20020a0dea0d000000b00552a2e2684emr1188907ywe.52.1682066627835; Fri, 21
 Apr 2023 01:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-6-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-6-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:43:36 +0200
Message-ID: <CACRpkdbyB8FagXey1-huiirHPasJs47pMGKx9TZ0+X0tC=0R1Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: Comment that the LSM303D also has the
 Magnetometer DRDY
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
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

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> Per its datasheet, the LSM303D also features that
> pin.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
