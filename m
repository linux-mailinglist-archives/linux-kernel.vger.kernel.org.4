Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2D6E42FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDQI5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDQI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:57:14 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6424EDF;
        Mon, 17 Apr 2023 01:57:07 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id o11so6006552ybk.11;
        Mon, 17 Apr 2023 01:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681721826; x=1684313826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtUWIJu6Ns0zOdXgId6MZyD/lN9k8BpY4Fb8foShQOs=;
        b=Sodx6yV/BnJxGw7H8+G0BTk7whqvpAHu2KkZpYA0LuKYVoI/drhJQt+Du0Q/pwzdH4
         cSbvoNumG/9zDh460GXWwurZx3JipbtxwaB7+benH/cxlUmqZufTN7SHlH6NUCaeqw05
         rc18pQkAyC+YDQN0Irp9RRDY+WCunuUcd6tHdVRqld+tmmo3EAgaISdaD8WDuCWK+1kk
         uXf9KYGm0W/7LPiddFC4uvneExSUK4WPd+nGH7PZZwNRTBiUiJRTNdF6Lc0GuZKMRRiI
         boAQ0R4zr+eUUP/YFidmC7J88lmcafCIFvGXUi463eyKYGvv+vecsSKQmu01vkXa1oXJ
         g6VQ==
X-Gm-Message-State: AAQBX9cUHrWbE04gBTMFmSHyERrlvv1JBtDYix4zVB7LsCAUsiXTtYBk
        WSjE3ESApQM2rIATdIKY9QDpTnj1MX9ttQ==
X-Google-Smtp-Source: AKy350Y9IpHajHkecLsIIwjWmHZUGw72waksAEkDIrAwwcshEIkqTWuFlo9GgH1d+Gl+3WNIkcNKBQ==
X-Received: by 2002:a25:c714:0:b0:b8e:e029:7961 with SMTP id w20-20020a25c714000000b00b8ee0297961mr18025449ybe.34.1681721826173;
        Mon, 17 Apr 2023 01:57:06 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b1-20020a25cb01000000b00b92579d3d7csm399450ybg.52.2023.04.17.01.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:57:05 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54fe82d8bf5so96008127b3.3;
        Mon, 17 Apr 2023 01:57:05 -0700 (PDT)
X-Received: by 2002:a81:4407:0:b0:54f:bb6f:3deb with SMTP id
 r7-20020a814407000000b0054fbb6f3debmr8857925ywa.4.1681721824852; Mon, 17 Apr
 2023 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 10:56:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com>
Message-ID: <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Wed, Apr 12, 2023 at 8:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CRU, CSI on RZ/V2L SMARC EVK and tie the CSI to the OV5645 sensor
> using Device Tree overlay. RZ/G2L SMARC EVK and RZ/V2L SMARC EVK have the
> same connections for connecting the CSI to OV5645 sensor so just reuse
> the existing r9a07g044l2-smarc-cru-csi-ov5645.dtso and create a symbolic
> link to this file for RZ/V2L SMARC EVK.

Perhaps it makes more sense to rename r9a07g044l2-smarc-cru-csi-ov5645.dtso
to rzg2l-smarc-cru-csi-ov5645.dtso instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
