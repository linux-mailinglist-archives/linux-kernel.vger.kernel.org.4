Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126D06F9FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjEHGWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjEHGWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD818173;
        Sun,  7 May 2023 23:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B70611F6;
        Mon,  8 May 2023 06:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E155C433A4;
        Mon,  8 May 2023 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683526960;
        bh=RRAYVfzWI2CIN+ZmTd/bzNs5d6ZXJ0prYFtjqrq3z2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4YgewhFTRgROcxCyKuBM88Ro5dZcDfEdqGb2E2BWYtJsRXK80FvMuA7UGFy65kux
         bAD8oHDIXaIfKFPPtGxUjrkK7huabRA9/6kIkF1a3OlYDam6HMf91YLHBoKvw7YFR4
         Au+xRTY1OgmQO8DrNfVhmaYZrkkbxbtfwYA9PbK/aAzNL3BiPoC5dMlz6RBCOaq9xh
         RivPf/taKaKqXy9eBIOXA1/e71am5j/Hmfi+rzqVuvCYr9YXfJ7kje7kGzvGEyq+oz
         EQP2zvPn1HTq+3z8rsdzuU9Q5l3EUiM1c8Yutb/hkHFVYCk+S4HgrFHUEYoy/YL+uM
         rRP+4zBcgZGjA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-965ddb2093bso486965666b.2;
        Sun, 07 May 2023 23:22:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDwc8SPuayNecgN74ze4Fpsd5zSi0Dt3uiyzuUnDfsOMz2PgBtUF
        HQH0OiJmosiM52GCocOPBu18BykDBNBuey16YB0=
X-Google-Smtp-Source: ACHHUZ55KUUiXjfH7U+W0+3/jL7jTooOxMmTkX1XEA+KeGqCKoJTXMo5o9ehY/VtsJLfH0v1UixisOeQfdwZzRiJWqE=
X-Received: by 2002:a17:907:1c05:b0:930:f953:9608 with SMTP id
 nc5-20020a1709071c0500b00930f9539608mr9710495ejc.0.1683526958366; Sun, 07 May
 2023 23:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-6-jszhang@kernel.org>
In-Reply-To: <20230507182304.2934-6-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:22:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWgiQOidm5S-XqzfXff1HS+p=V4zUFD0mMBvUa-b0OFw@mail.gmail.com>
Message-ID: <CAJF2gTSWgiQOidm5S-XqzfXff1HS+p=V4zUFD0mMBvUa-b0OFw@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
To:     Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Wei Fu <tekkamanninja@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 2:34=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> I would like to temporarily maintain the T-HEAD RISC-V SoC support.
Wei Fu is working on TH1520, and maybe you could have a discussion
with him? Thx.

F.Y.I

Wei Fu <wefu@redhat.com>

>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..e1e51accec4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18155,6 +18155,12 @@ T:     git https://git.kernel.org/pub/scm/linux/=
kernel/git/conor/linux.git/
>  F:     Documentation/devicetree/bindings/riscv/
>  F:     arch/riscv/boot/dts/
>
> +RISC-V THEAD SoC SUPPORT
> +M:     Jisheng Zhang <jszhang@kernel.org>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +F:     arch/riscv/boot/dts/thead/
> +
>  RNBD BLOCK DRIVERS
>  M:     Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:     Jack Wang <jinpu.wang@ionos.com>
> --
> 2.40.0
>


--=20
Best Regards
 Guo Ren
