Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C266EA502
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjDUHjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDUHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:39:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19186A4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:38:50 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f9e41dfa7so4287097b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682062729; x=1684654729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbLVXy+xDpAqXOw3eLwbqNtcQaFjWeU5ILDIT0cNbUg=;
        b=mST3V/2nI8K5sew2KQtTF50x8ftoZePkg1QvEKHIydeu0oqB3+NYCr7eKWARFDydch
         tGKSAhLcPy7j8fiT/jd5jrV5lTYJPAG4qPSeadhCdmY6cC5UncClXrjhPzYl51B6WzDC
         8Mjl6sj1z0nONe1EesQqBIi1YMOGaD5OaY6fXWNqZhP5oytIv7e3WWan3IDrnQIRoHRG
         /IXK50KeJgYzyZ6A50UMYt+GKK/iJmwxTIMfzrZDxq6KpGuy5X1aL1n2FEO4NrGiWa4E
         w60ggOCtYHtm6nXBEPq0JDKy/VE+fjn4JDf7xmtaJ/Ayh2p9nh+AYcdAhmoDS67xWz0y
         5MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062729; x=1684654729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbLVXy+xDpAqXOw3eLwbqNtcQaFjWeU5ILDIT0cNbUg=;
        b=HG7vBWZiJIS5ySzSG8atl+ML8lKjP/6NbyPYNLlUapcta4c+GDttVQtxWD5DnZZaLn
         cLlI6tukXbveVcAQ9bQ+NgtBoyUPT1r1p3Bn/t98yVLlljzhWXNg4nv1oKp5CcdJEoTP
         vPemanhnVfCCfiA2h5ttodO+pd2F9zfW/jKbzxmM8fq81DLhM9KDMGEZBBnqdHziq/Ke
         PrKnp3y5CW9wN21IhvC/4gjUol43rDwGi6i/wDcO3b0bcdO+X9Lq5bfdAP8FNid19lS3
         KR5XqauNR7c7PXdVZC+/gNbB82G12WKbsUcFFrBwAxSqbz/7wMN8iy9Jz7wFNAF15QqQ
         DcBQ==
X-Gm-Message-State: AAQBX9ebbH4hw/erB/NufCJsP+YeJcN75ldDsnAMS2DiILIrYBPbK23W
        GVg19HcQg7wrqIo71ObHTrgDne6IVllMWJ2l0Cw9rA==
X-Google-Smtp-Source: AKy350aIpaPr4xkUOoyYRC1YeivqX5fuZiepgJF9m7/Tyv5uVXU7MJ7jIbfLDhJLisWLy8EL4Ur1dcuPwccTzu8ER1g=
X-Received: by 2002:a0d:d742:0:b0:555:d20f:6572 with SMTP id
 z63-20020a0dd742000000b00555d20f6572mr1162824ywd.12.1682062729773; Fri, 21
 Apr 2023 00:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230414-immutable-irqchips-2-v1-0-6b59a5186b00@linaro.org>
In-Reply-To: <20230414-immutable-irqchips-2-v1-0-6b59a5186b00@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 09:38:38 +0200
Message-ID: <CACRpkdbzNgkmhxhGTP3Rs-PkirDTXRWbOWjF1R4U61Wm1mAQaA@mail.gmail.com>
Subject: Re: [PATCH 0/6] pinctrl immutable irqchips
To:     Marc Zyngier <maz@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 4:06=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> This is the final set of immutable GPIO irqchips conversions
> for pinctrl. All done by trivial thinking.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

No reaction to this so I just merged these.

Marc: for the next cycle we can start checking what is left.
I think making irq_chips unconditionally immutable is within
reach.

Yours,
Linus Walleij
