Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB66E3B34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDPS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDPS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:29:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F161A4;
        Sun, 16 Apr 2023 11:29:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mq14-20020a17090b380e00b002472a2d9d6aso9261929pjb.5;
        Sun, 16 Apr 2023 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669741; x=1684261741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM6ZTKFSwLjmZBZKdndPtCFsDR1dpvC8DYinuafG8Ps=;
        b=k9zFlbGaDExAA7Xl0JJvcL0glnpS7tDjHMyKGEG3nusOheeBUfRdyN3R2NGDQnkiHf
         GVrZFod9D5ujoku3vrxXoACy5k51LStvEPjnZclQgyJ5pmJGgiKPtvga7z3QbFLtyQzR
         hoG/Usp0c+LurXMS49rAyxMtr2NFPqpRk/fmnq8BNUfuomkFeiflk+iSXKyur6fB8Ibl
         V7bCRy6sFt1hGFW3W0gVMm7sABZMVyI7aHp4hJ5aOu3GbIC4Eup5cLGP8DmUZUhuqg6A
         j2+x+04hKjnZwmQ7vv3gpPdCXVvjULRZas6KjDYc0a92bRyWv70m7LYamp8mgHi0WiB6
         PySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669741; x=1684261741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM6ZTKFSwLjmZBZKdndPtCFsDR1dpvC8DYinuafG8Ps=;
        b=WyRX8LDojxjhsNJWs661X6yf92X3kOz7gOPzPlJ7QOBWvCaPjosC34ouWD5TCFIvuY
         9xmp95pHQCEleeVegExfc8ifnEjYha61GG2CMYQ3/e/NtL/S6UblIAXX8dl2iYsl7877
         7p57Kf9+gxqaqC0bH29lv8tIW01vO+BlqA4YzD1xDzZmkRYojf6WdZryEoD4su/JiMp2
         CGjuYytSg8ECuik6YQZ3i2PAlYyF1xhll4Ftd7sE1bEMAAHTPYp2JBgzVMCclKXpPRZF
         jhzuXZx0kGkZ8s6SsnhUvWBReLM3OSq6on/f/JEGnpT4iCAgMwZQCnGuE9oJz95q6sNi
         f8aw==
X-Gm-Message-State: AAQBX9cFzHhH9sIBVt2Vtp/6hp0Lv+Y/HhPFcel6uIoy6/0PeVOdhxzX
        5uvw6RZMJt384Mr0v3AbQcDo9BCVWYgFwQ/NL2c=
X-Google-Smtp-Source: AKy350ZYidDVZbxRWg/n50JRcami0lAGgSpT4VEQcvxqkLezHbfC/nEFx2WGcfEvr66I6Hr6GBFcaBe9mauXk96n3oE=
X-Received: by 2002:a17:903:68c:b0:1a2:73b3:b398 with SMTP id
 ki12-20020a170903068c00b001a273b3b398mr2685467plb.6.1681669740879; Sun, 16
 Apr 2023 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230416173302.1185683-1-mmyangfl@gmail.com> <20230416173302.1185683-4-mmyangfl@gmail.com>
 <8b3ea617-8d4e-cf0b-1cb2-d02405c39487@linaro.org>
In-Reply-To: <8b3ea617-8d4e-cf0b-1cb2-d02405c39487@linaro.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Mon, 17 Apr 2023 02:28:24 +0800
Message-ID: <CAAXyoMPcmbUGDpM6YAyJqGaXvgg2rQOCSdGGnaVQoGd5OE4OwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add gate-clock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=80 01:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Did you test the changes?

I don't know what "test" is here. make dt_binding_check passed and it
can work with the driver.
