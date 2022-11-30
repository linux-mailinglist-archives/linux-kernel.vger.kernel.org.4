Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB063DDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiK3S3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiK3S3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:29:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302A8BD33
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:29:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so8762985wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/mhURiSnctmudftnFtdoz6/q2M4E0iTIngIl1pzogU=;
        b=EXkGs8WY3WnjbsfHyJzvRucfFYBCKLg2OoAAZnOb/QPwRH+3S4V5sgJNGwMMKQ3nT9
         2Xb0YGfoWg8veu7GPIpZ0GgkLWVbqZ3fJ4/YQSHytBk3p1ctC993cy3PKZil2/yVVUTE
         cId59KXf8H6siK7W2A00aylbLGNYI+MHnOxsu2GjMYrFio9S+YHO87jgpUBSDofME/+W
         4Jl0H0EnSKxnDzGQs3a5WhNe7L3vjXj9Uw/xvOR6prOCoMB5ePFP+H9FzyEA2Fw86LfT
         nn33xq8pXc/UotbEvk9rwn673hiz0rGlVWl6rMmgFCuvlo0vH7ggJQulg587nx2obfos
         lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/mhURiSnctmudftnFtdoz6/q2M4E0iTIngIl1pzogU=;
        b=R0x1E9DuTIpwo4Lxp/+6kesDH5CwZ2nFpIxsGccwK05KaoLjth/FEecg6Xj4fTSgGE
         BbjSATv35Gno9LCw/wl6djvAPuCkKP8AzahG5loWsDBuED5voKVvr4Mi/21RjNxu8X09
         /cRrYx8iE0ftiY6+H36NwCjSKTP0mV/wf2we6WiWzo1IiPQOuFXei8rohnXDn5V+3IJQ
         TzMQQPyHtgApOTINOjd9Vnqai9ZLVTnLVGnsTc9YMcrf54db6LsxJxSNZetAY9blkQ59
         wkr9/d6aWOZHWe6Yx4oU972waVkgtZbI1QVYQbW5s83DVxLJjl6Y9Y2opfvDrTtJu5w3
         plUg==
X-Gm-Message-State: ANoB5pks/ABLSmxwzrpuaM4bmjVMwa4ZTp45MfpqhgpH0WtyNFT/yPeH
        lc/k265ktSAt5OBiwZerWPrK4V9z/2Z07fnu
X-Google-Smtp-Source: AA0mqf5dX/d2F14h/RN8hhwb9Smb/cMdcFa+bUh//IbKL245pVd2GTk7zTR9//+D8GoEll5KQTO2jA==
X-Received: by 2002:a5d:414b:0:b0:242:b59:c3c6 with SMTP id c11-20020a5d414b000000b002420b59c3c6mr14720594wrq.91.1669832959724;
        Wed, 30 Nov 2022 10:29:19 -0800 (PST)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c22d000b003b497138093sm2691867wmg.47.2022.11.30.10.29.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:29:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: fix underscore requirement for
 addtional standard extensions
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20221130180422.1642652-2-conor@kernel.org>
Date:   Wed, 30 Nov 2022 18:29:18 +0000
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E52B0E0B-F27B-43C8-85DA-4C7AC0C52369@jrtc27.com>
References: <20221130180422.1642652-1-conor@kernel.org>
 <20221130180422.1642652-2-conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2022, at 18:04, Conor Dooley <conor@kernel.org> wrote:
>=20
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The RISC-V ISA Manual allows for the first Additional Standard
> Extension having no leading underscore. Only if there are multiple
> Additional Standard Extensions is it needed to have an underscore.
>=20
> The dt-binding does not validate that a multi-letter extension is
> canonically ordered, as that'd need an even worse regex than is here,
> but it should not fail validation for valid ISA strings.
>=20
> Allow the first Z multi-letter extension to appear immediately prior
> after the single-letter extensions.
>=20
> Link: =
https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-fr=
om-asciidoc-15112022 # Chapter 29.5
> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings =
for emulators")
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 90a7cabf58fe..e80c967a4fa4 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -80,7 +80,7 @@ properties:
>       insensitive, letters in the riscv,isa string must be all
>       lowercase to simplify parsing.
>     $ref: "/schemas/types.yaml#/definitions/string"
> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> +    pattern: =
^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$

Isn=E2=80=99t it any multi-letter extension, i.e, this should be [hsxz] =
again?

It certainly used to be at least; we use rv64gcxcheri...

Jess

