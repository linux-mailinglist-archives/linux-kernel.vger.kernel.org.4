Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965B5BABCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiIPKz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiIPKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:54:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56E8E463;
        Fri, 16 Sep 2022 03:40:32 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 125so10636347ybt.12;
        Fri, 16 Sep 2022 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pijsLZci+Y5WxQfjpHIxAUQemzUmYfv8LSTQWbva0zA=;
        b=iRhVvoSb/PL5tbgbcOVD028DNQWlkc7AngVaPB9y0nCiOFoAzhUKc7Vv8pOOVO0H4/
         hTVcoSYRzyyG2REHD3NxhZ9ysB9vMiJNmbODJYf8gWMV3hX0D/+VrszN+PBqV8P8JJ8e
         6XKcir1qffASClG38txCPGS4sdpA0FHLab5YhOmtiwTei5KWge/O2oodzowTmDeeBANt
         kXanPXgJ2AUf8C7LGzhPmXMooa88hrXQ7CI7ZQQtIFPRd1z73o1GYZO2xRWZMSbXXTF9
         mKDFFVimYY6LfVmBnJH9rRJ/f0y6X+9SxbqT5J18ROvmWu9VPnNhYsJ2DfR6HkAlyB/+
         kxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pijsLZci+Y5WxQfjpHIxAUQemzUmYfv8LSTQWbva0zA=;
        b=lsSTp1q8RSFl37m15bRfwcvZsFW0a7hpWQnDR/Vg5pmtrV2lXs9nLL3o8BesoTNQD7
         MAPDbJj/6n/1sX2zn+0ETd/870fxooSFuZHjeJfgg83YTxxi/Teg7XLAmoWaSImPvR+S
         RxL3WcAsJ3CHndOkHGCaJGVl0ETmDCegoTPIGOMZuaWuSNc/hTrU2O15Bwc+jB2qnmiD
         OwfDmF7hzZ7yBjd8nKKQVyzRvFoa6GM7LSz5kqKyavxhd0lgkTqS6sEHNgMTp0dWl3TJ
         1drOy5fseLU8RAuzrO0X4mQ+iGsQZin8z4xOta3yTAfshzgkiZJhFROCXIYcCrjgch7J
         bDgQ==
X-Gm-Message-State: ACrzQf2T6Egcs3YMP3ptCGAaiYgH5IxMeDjbVNsPQK/kAxZYatknPFUW
        iQQ+ZOmIIeH8xlUnaqnlOa4Jy6JGRbtuwG4M5ldz2y657W0=
X-Google-Smtp-Source: AMsMyM4jEic7On6aTRCZStCEJ9sNe0VQWJDOpxSXOa35o8SlndxF7GbY17yaVv9LdKH1AchZTVtkIiu09m3Mg3JTrI4=
X-Received: by 2002:a25:808d:0:b0:6a8:f9e8:eba0 with SMTP id
 n13-20020a25808d000000b006a8f9e8eba0mr3859047ybk.279.1663324832111; Fri, 16
 Sep 2022 03:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220914214132.GA2173@tom-ThinkPad-T14s-Gen-2i> <CA+V-a8ufbsiz3p2n3LmYxES2aJYN9y8byF9bSyckNFz=fB-5LQ@mail.gmail.com>
 <7a01b1cc-6d00-715c-1e21-b8836a64a9a0@linaro.org>
In-Reply-To: <7a01b1cc-6d00-715c-1e21-b8836a64a9a0@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 16 Sep 2022 11:40:05 +0100
Message-ID: <CA+V-a8uL=cwYXJD9j61LcM0xXweeVp-Q3fgd5n8C3BM+D9vLXg@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, Sep 16, 2022 at 11:28 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/09/2022 11:24, Lad, Prabhakar wrote:
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - clocks
> >>> +  - clock-names
> >>> +  - clock-frequency
> >>> +  - vdda-supply
> >>> +  - vddd-supply
> >>> +  - vdddo-supply
> >>> +  - enable-gpios
> >>> +  - reset-gpios
> >>> +  - port
> >>
> >> I think we don't need all of these properties as required.
> >> The only "really" required are:
> >>
> >>   - compatible
> >>   - reg
> >>   - clocks
> >>   - port
> >>
> > Agreed, it's just the driver requirement hence the previous bindings
> > had marked them as required.
>
> Please mention the change from pure conversion (with reason) in the
> commit msg.
>
Sure will do.

Cheers,
Prabhakar
