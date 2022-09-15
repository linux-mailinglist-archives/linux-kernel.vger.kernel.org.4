Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEA5BA283
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIOV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIOV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:57:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96F8B9AD;
        Thu, 15 Sep 2022 14:57:12 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b136so29834642yba.2;
        Thu, 15 Sep 2022 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cPaq5546jvH8aSMw37Z0a/MsJlDcjDxx//GnCdJb6rc=;
        b=owIFgWeXa2WIc57acLhZaC+Nruso8LkLfXri92gyDu0I5Okpy5HFyVBaU1sakAHAU1
         tXZ842zF7oNOBoTH8LHv5GD89MTcRvtbNeuxw5LzpNPqoB5t07TgC6y1mo3EizgMKfoI
         x2anyGPZOymMW6CnLibb0F24j+++2v/rIbSep5ip5v3gTYyIIMzFWskedc9D/THLD+U2
         ptZ+GkkdQla6MJgRxt90V1uQ92yunnIwZPuwsDXZzbfVUbLH6ckedR5jKDIKf0Z8ql/O
         8+ywDI7BgKrHZXYGOjj9TJwmVXhJSuOcOcvY0OpY5ncIXghOVAK7+cm5nYwedEJ+uHfp
         q9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cPaq5546jvH8aSMw37Z0a/MsJlDcjDxx//GnCdJb6rc=;
        b=dg/Jy2Ob5N3RIyqcVKDNiK+zSe42csCX38iBam+qU4T9jq5+H74100ze0IqkN4EgB5
         OJHV3YL2+eaYg6ANe514TvhB743GLTzQFP5A5KNItv+QiOvfo7FXWlxyW9m1fAwpwhUh
         AWs9vo4PibuNUncQOaN8CCquOrKMEYCjyj4yz0INjnB7BKn1rPMwACtAdkvg5pJcINUI
         9ueFe18DfoxEr0e6KRPvKSdoAj+O6lyvKz2ADqBfiroGl8pp50LSz7DJzQPGNf3qmVpt
         zQAYp/OC1JmtGGncHe7gxANoOwiH/OCqQq9d0oZz7IeQUnyyOk0VtTqytqNlM1LxpHcQ
         /2dQ==
X-Gm-Message-State: ACrzQf3BOUc7tC2IjY4+a2gegeWg3BhkX/3J3JUv4BJZcSd+rKF/NWXE
        hMamdvuXgEZdke0YHb7dEmu2ZSb1RymOA6EaynY=
X-Google-Smtp-Source: AMsMyM4CJb/auFvW3u8hqAtr+nMrB3OgfxFI1GmkaXoEovGm0BaVYp/lJB8GvxqgOnaB2wVGQo/dLc68ih6DLvysGRU=
X-Received: by 2002:a25:808d:0:b0:6a8:f9e8:eba0 with SMTP id
 n13-20020a25808d000000b006a8f9e8eba0mr1783881ybk.279.1663279031516; Thu, 15
 Sep 2022 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <10896a74-5875-a083-846f-eed5f457ba1b@microchip.com>
In-Reply-To: <10896a74-5875-a083-846f-eed5f457ba1b@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 15 Sep 2022 22:56:43 +0100
Message-ID: <CA+V-a8u8NdzaOmnQocAi_tthE=J_-LabG49StxH3gyV2QJwirQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: soc: renesas: Move renesas.yaml
 from arm to soc
To:     Conor.Dooley@microchip.com
Cc:     geert+renesas@glider.be, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the review.

On Thu, Sep 15, 2022 at 10:13 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/09/2022 19:15, Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> > is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> > to the soc/renesas folder instead. This is in preparation for adding a new
> > SoC (RZ/Five) from Renesas which is based on RISC-V.
> >
> > While at it drop the old entry for renesas.yaml from MAINTAINERS file and
> > there is no need to update the new file path of renesas.yaml as we already
> > have an entry for Documentation/devicetree/bindings/soc/renesas/ folder.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3:
> > * New patch along with this series previously posted as a standalone
> > patch [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > ---
> >  .../devicetree/bindings/{arm => soc/renesas}/renesas.yaml        | 0
> >  MAINTAINERS                                                      | 1 -
> >  2 files changed, 1 deletion(-)
> >  rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (100%)
>
> Got one error from the rename:
> /stuff/linux/Documentation/devicetree/bindings/soc/renesas/renesas.yaml: $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/soc/renesas/renesas.yaml#
>
Argh, how did I miss that!

Cheers,
Prabhakar
