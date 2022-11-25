Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD776638F97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKYSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiKYSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:18:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177154742;
        Fri, 25 Nov 2022 10:18:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f18so12013451ejz.5;
        Fri, 25 Nov 2022 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSTqWNHag3SUpc3s1sUcZFF6UQb8ezMgBBQvOC4p8IA=;
        b=BNqJGG6NUjVhaqHfPKxqWeQdHWINkXBo1nQ04UVvLY7ant299F/ym4pPSe0oto7cR0
         4XACZTwuMBzmtAZyCY6sxv/nnenKRB6tktqbVwmnCYCAv2KAr9usuv9yxgul+XU8W+jY
         n7scp0g+GaBXDcZaUp1QIgaFdCpTGUplZsDN+pVUXYKlgllGDQq9wCiOMZadKvvSIZUt
         A9IyezL6Fkmhs9/TJ0KV0SP6PuToVC/zVficpOVAZE7Y7ZZxfJHUEIrOFwmTGs2rNbSN
         jMfI1b7El163bpzxHhHaf5IT6Oty6dtmep7YPLQO7I1sqsIHBK8Y6DzhbxhjMPg3xcyN
         5OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSTqWNHag3SUpc3s1sUcZFF6UQb8ezMgBBQvOC4p8IA=;
        b=5Uzb2s9RZ0rO2UwlfuxYXnqvIf8PKirJ0LHbjWoVDUb4/UNi9dBZfAxk6W4HgofpRY
         nTRBUsjP/5qxKU24YJtZSFBCIeCPayP6ULasF/g5ZvampHmBCYsUBSOffCWMj9BRzKcG
         /7MeSQ6lR4Bc6vdCSsUFj8ErMBGnrfAEGzs01enC6l5DQrOvGPaJkz3EGZ9+ilLzmWcZ
         9sJWbd318Cxa0C/5YEvPhsAiRwgWnuVnzhTyfid5tB5x+lXFuqnXXhTtCxWQ1v2qV5rw
         QQC3C6YWP7g7GrZrr6S7dTKLENy++8hLoHUuG1iPtfTeIyCVRV/XayG948BLqMqy98aF
         HEpQ==
X-Gm-Message-State: ANoB5pkdg7QZo8UmAJoT3YBOffMnLNR+R67kESuSDVlcSNzBkNTr6wGK
        B00qhV5mESed4mmHjTV0QXyLOyp/huSmHfUtqjw=
X-Google-Smtp-Source: AA0mqf4/BJoTyjk07S/TT+v6WloICUBFRly4YcWuDlROWrOzgv+5CNKPR50fastJHx25Y7QVIpQuaLjvBbIvs45GkVo=
X-Received: by 2002:a17:907:7650:b0:781:e568:294f with SMTP id
 kj16-20020a170907765000b00781e568294fmr19286209ejc.447.1669400319844; Fri, 25
 Nov 2022 10:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org> <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org>
In-Reply-To: <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 18:18:13 +0000
Message-ID: <CA+V-a8vCUR15WFKiyZ=AgsdKovrnCngnQ_dBTx6PkDYde2=p+Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
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

Hi Krzysztof,

On Fri, Nov 25, 2022 at 12:12 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/11/2022 11:34, Lad, Prabhakar wrote:
> >>> +/* Device, Non-bufferable */
> >>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> >>> +/* Device, bufferable */
> >>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> >>> +/* Memory, Non-cacheable, Non-bufferable */
> >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> >>> +/* Memory, Non-cacheable, Bufferable */
> >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> >>
> >> What are all these? They don't look like flags, because 3 = 1 | 2...
> >> they don't look like constants, because we do not use shifts in
> >> constants. Are these some register values? I also do not see the header
> >> being used in the code, so why having a bindings header if it is not
> >> used (DTS is not usage...)?
> >>
> > These are register bit values for the MTYP[5:2] field. The DTS example
> > in the binding doc (above) uses these macros. I haven't included the
> > DTS/I patches with this patchset yet do think I should?
>
> Then why storing it as bindings? Bindings headers describe the interface
> implemented by drivers and used by DTS, but this is not implemented by
> drivers.
>
I got your point. I'll make use of the header in the driver for the
next version and fix your previously pointed comments.

Cheers,
Prabhakar
