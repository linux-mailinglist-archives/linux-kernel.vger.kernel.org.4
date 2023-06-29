Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5F7430E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2XLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF2XLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:11:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF7630EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:11:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so19571841fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688080297; x=1690672297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouIIJPlckIJc9s2Ly4rKH2jNlWjaAkDeAVhQw+0U5tI=;
        b=m4m8CXI5kC9XyLaB3B93wRD//YHWodMtxl8KCaREWm2mLWWsOuW2lkGcxQb58OX/Z/
         Ad662wXUZPHwSQYS4o4BeqGrSKnLU0jAVe0i0Fo5db3KfKvNW+TvQ6XPT0oF8WzbFue+
         D6w0CTphRNULh071DYz+veN2UHVwygD1RslfbZSniNwqHugKQoMf+llv5QYqiC3uMdiZ
         Sr2xQughruiYIKC/i99TZhG0Y8OcRRBMQFKcxRZgWEqCywKswIbBlA/FYJHGF7IABDh9
         WScBt11ybJihu6wKpgYSUNXNvMF6E8kbQap6AYhqQSKFWSq5IlUGplv9GtbBeXP5apMB
         cEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080297; x=1690672297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouIIJPlckIJc9s2Ly4rKH2jNlWjaAkDeAVhQw+0U5tI=;
        b=ef/ZeugVL0hZwHETH9XkCuUnX8LRVYkdxdcgVIXt7febbPDOZVL2d/XhNfwC5DdX7Z
         RYOeriN9vu8l2oGoZsfBgylpE41jvYvXZy5IXjjtOwhCyeWJhtbC5+Qlx7wfzgvqO1cL
         D+6jdqzBY9krtLaNpFXBSoZrs2ReOny8SwI/5YsxC3/RJBSm1M4vLElS5zSDnqQmU+zo
         f8YIWe8ktKStibl96fA3qpbWMsUEcd+g1JS853O1KrQLGfWqEUyMd0/6WB/G/WVHuutK
         6+DY7Okz/XjtbqLBhQEfTDixe/ogp/oPDmhsM+4ealiP+MlxO2+i6Gdwj0ulv2jxS2Uy
         Il3w==
X-Gm-Message-State: ABy/qLZJSxNhD/eA8DE43duFC6JIf9cUF9p+xdHn+C+7oKRo/JXrLm49
        a3MaFa7TyR2yHB7ptdIJ2ZuneJvjP3roSaj++tORzA==
X-Google-Smtp-Source: APBJJlFPCnjLtVPVAgBt/mvIUDlRQlncLV2H4x3FcrZq3O2Nmv/iTODNm0bAvQbrqOeggFoTUGqALCq8sh+oIRyH6BE=
X-Received: by 2002:a05:6512:1094:b0:4f9:5a61:195c with SMTP id
 j20-20020a056512109400b004f95a61195cmr976866lfg.13.1688080297379; Thu, 29 Jun
 2023 16:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy> <20230629-museum-playhouse-6dbe7e573f2c@wendy>
In-Reply-To: <20230629-museum-playhouse-6dbe7e573f2c@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 29 Jun 2023 16:11:01 -0700
Message-ID: <CALs-Hsu5yA7eBPOFQkmd94GR+15wuFkbYbYSg4RubmkdQDyi8g@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] RISC-V: shunt isa_ext_arr to cpufeature.c
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 1:30=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> To facilitate using one struct to define extensions, rather than having
> several, shunt isa_ext_arr to cpufeature.c, where it will be used for
> probing extension presence also.
> As that scope of the array as widened, prefix it with riscv & drop the
> type from the variable name.
>
> Since the new array is const, print_isa() needs a wee bit of cleanup to
> avoid complaints about losing the const qualifier.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
