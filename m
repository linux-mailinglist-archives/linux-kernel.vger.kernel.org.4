Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF75729073
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbjFIG5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjFIG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:57:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAE3A95
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:56:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-569386b7861so37985837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686293818; x=1688885818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPnqXMOZVL6sTkCADxUPTqWs/TKz+PEnmIF/0BFjH8Q=;
        b=mzFSM/gnMPcPABMe+P7vONS3ZNBzFZ9yP/J/Kr8qWjXAfWXj9lFRm4Yq5/znbHMaWX
         xa4OS/lQHkFrz2nfYSXYiYy3orqqgjwZKo5yrQXNxWb73VSA5KzWr+QN1yf4Kq1ghL/J
         9Ccjx9032BjHefkUrpu6AZrB5c3oKZX04WJs+3IDQYMldxlmefymp3XWso0HIvfnRkvA
         JM2W9KMPJzbH9r7LPO0+vj+3i4N1F5IXtIDzl0LJ2fI3VES6vCs964litPxtkO4+S5aB
         KMxYJRmNiIiUJipGFNW3tfV+VYH93p2PzrqIvxzh0OO9Wo6GlXn3Oi+pJ1JLC9zZQBIK
         CIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686293818; x=1688885818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPnqXMOZVL6sTkCADxUPTqWs/TKz+PEnmIF/0BFjH8Q=;
        b=gzmySGxe8FtQQcaDA/LaHHpHq+6ecEPxIgli50Gi4mlXkJwFrmKOslgFJl1QLqblqG
         3RX7vt4U4IVNQ3LSx6VQITAzjC70t65xsHRX7seJ326+1AjFZJnhjf/yc0wMXj5n6OM9
         q6P7rwyZuLXQFM/BkCx8yYnBMgc7fVt+EcF0hQav+Yj455nfg2A+poWRiIirrl6iCdrn
         ja3UsuSueHhhDAznTv7R7Ekc+RI1mh7M/GRD4MzoHHh8g+G3WqL66h4h7c5m9idKdiGT
         w4vIz0h0q7QVQ6uU0RtkxYJ0tCwhQzLidkX8iO33Q5i8qNK02PSWuMnSPSLyf5MF7R2s
         MRRQ==
X-Gm-Message-State: AC+VfDzEiSnTa5vuUTjYeLjlUS+kzZWR8F6NX+kqEDriDVQHMDxQqkAR
        Jid5gVWNJw0eYTgnLPIHlMX4OKR3ee6SoFz3Onig9w==
X-Google-Smtp-Source: ACHHUZ5X127VTzj4zOV1xeRhWkNtYt3iBIPKSBWOTbrgngPPTDrQ5epKwgsmZoP+K3u1v9n+9tto9vaqGSEX4/wb7mQ=
X-Received: by 2002:a25:54f:0:b0:bac:46f2:8d0f with SMTP id
 76-20020a25054f000000b00bac46f28d0fmr2700548ybf.3.1686293818393; Thu, 08 Jun
 2023 23:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230601173831.982429-1-nm@ti.com>
In-Reply-To: <20230601173831.982429-1-nm@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 08:56:47 +0200
Message-ID: <CACRpkdawgFtSt3wEGz5MC9apFiLgUbta4TRc6YhOrEGbT6Okvg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Drop k3
To:     Nishanth Menon <nm@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Thu, Jun 1, 2023 at 7:38=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:

> If you could pick this up for the next 6.5 kernel window now that we have=
 kept the
> old header around for one cycle.

Patch applied!

Yours,
Linus Walleij
