Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26964E761
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLPGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:47:30 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62E10B6E;
        Thu, 15 Dec 2022 22:47:29 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id q128so1411010vsa.13;
        Thu, 15 Dec 2022 22:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txLtQDvzTpy5ap+f5S1nqMLqOhcer94Y5wQ0WtwOPcA=;
        b=aX+2wM9qNl8cgOihVMVDxoi/JUNSm+jjxtY3aRcpQK2IGUcfkb1fw+TYCfI1PCdknU
         G/J+VsW8T2CsBzfpO9AVUHn19PHHjZ6wCU/Jm+dGw0MxwQcZCYej5yS8IemHMrP7iXxP
         CDCWbh1FWMNj+bhGix4v0PXWR5/Av+Feq2vyQdGSja3OHT9ja3N6pVNAAZEu3ZklQ8KE
         Q4Qul0GMb24/XZEb5ng/+1ojoUbjxPO05dQ8BmGyICVC5QSBonqYFUX2a18cXz2MJ7Gr
         BHhRgsUni2hSUsQiVY/iPt2M5NIGBHcwDMun7n8ZpR9a9RWrsioyphjxYISwEwlOO86d
         LRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txLtQDvzTpy5ap+f5S1nqMLqOhcer94Y5wQ0WtwOPcA=;
        b=tfgmQpAi9OwuuukFJEhLHspDxXpcIy1P1DKMw/qlIN+KEGQy1bQMChc+qJQXXwTSri
         CSR5eZLVhmCNwlxEbVXvQjtG7bb3hM5aG9JEEQkhGshC+RgIdPP8eszhOop8/Y2NN7KZ
         r88xxA2yoCHmIF8VdSxfQh9VbM9OZ44CQGI3fjZpshNkjwzl3IioJ+WrVqlHiZmzq4Z2
         P+0XWhI3Kv7k8cZYHe9+P+1GvpS2TXJ7hLPbBbqLwXiHGQT2IYHJbdModgaYprjHgis5
         z089mAE5rplZcGv/q2ctYSy9SUJkDubTb07r9QXAuqLmEGlO9JDU7npDcIFI5Hg3I+Rv
         8lIA==
X-Gm-Message-State: ANoB5pnk/4upcnWncD3anJmzxGVi2PBcydIJ/tuY0tTK+qiVM9pj5njC
        Fs/z9tsytVsERmeb47oHO9qHwOTeNGeW6Vc6pbN7wXggmUfzGw==
X-Google-Smtp-Source: AA0mqf5Lxb04LUZqGw52cDrLLG0QVwDsfAEI0ScpPVmAEmKbL3q3P5lS5AGexica45gS2sX1dPMDDpONO6iB+KCxBHQ=
X-Received: by 2002:a05:6102:f09:b0:3a6:eec3:b246 with SMTP id
 v9-20020a0561020f0900b003a6eec3b246mr53598501vss.64.1671173248564; Thu, 15
 Dec 2022 22:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20221214092636.810883-1-milkfafa@gmail.com> <20221214092636.810883-3-milkfafa@gmail.com>
 <7e67b2d1-394e-2353-df37-5ae3cac64b9c@linaro.org>
In-Reply-To: <7e67b2d1-394e-2353-df37-5ae3cac64b9c@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Fri, 16 Dec 2022 14:47:17 +0800
Message-ID: <CADnNmFptyu_kCdVeFbYUO0vEfLaSniSuz3UmJFiLfv3yF6Gvfw@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] media: dt-binding: nuvoton: Add bindings for NPCM
 VCD and ECE engine
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com
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

Hi Krzysztof,

Thanks for the review.

> > Add dt-binding document for Video Capture/Differentiation Engine (VCD)
> > and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
>
> Subject: drop second, redundant "bindings for".

OK.

> > +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
>
> Drop blank line.

OK.

> > +    ece: ece@f0820000 {
>
> If this is video codec, then generic node name: "video-codec". "ece" is
> specific, not generic.

OK, will change to "ece: video-codec@f0820000".

> > +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
>
> Drop blank line.

OK.

> > +  memory-region:
> > +    description:
> > +      CMA pool to use for buffers allocation instead of the default CMA pool.
>
> maxItems: 1

OK.

Regards,
Marvin
