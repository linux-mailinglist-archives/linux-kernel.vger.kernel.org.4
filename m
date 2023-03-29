Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A66CD69E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC2JiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2JiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:38:24 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730ED2132
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:38:22 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id v48so10896410uad.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680082701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kdo0962g9qjrK63Wmlr//5n9bFicAZn9s+ZEU+BxU8=;
        b=q3onjpNwj7m5wtVnisBHU/iaWonRFIgMPOAw3rp3d/782pYTSYBWvY5LfgqPeNm2RN
         gVM3r5bX4Cpl4OH9hB3g3HXP2qn9+/BjhXM22B5Uj+FxS7Q75IJp3n7osKdseE0QO5pQ
         nHHtiu4UwkZEi6LvPj3FEaXJU3sWIIiNVhCaduhGxgY6wkgT2nlOK4Bv+4EDPK7JphgV
         6TFzR7WXUBLKTS2Rud9/ilyyUZFVYeVdrgpK4hrKndbwlAlErwS2/5oGvjlDlKlzyDNx
         YVqKoKEPhpCnRwt2ETHySzBH9Q2yOCNensInbY8tHBYYCmxSAU/RwWvu6d1qqFQNXFs+
         8jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Kdo0962g9qjrK63Wmlr//5n9bFicAZn9s+ZEU+BxU8=;
        b=SxK2eGdWm1emy/XVf66+o7Ptyu+dSsThpcENWefl3B2fEZQUYmS7V+ecl7Zn+J6b64
         wpA2whFzJ008x7h718+WrZRdDGYFLFcZBPgYJOMLjekR5Ez/rZNp5Se+K7dGJIR/7Dyz
         LbqrC1Kc4SmSHD+QSDZeHbh6X0+K+Y0Ebbd9g1QV/qTMd8n/NxLKdx1Y3mA7G2DLz+us
         h/xaC19n9wsALtTvFBHzd0k7goqNV7rqIyytA6r3xvUJiGUqZsABCOl39kgVWa27/MHj
         L9u4FjC7/Iuow9wBUO8XUr4J9TYhaOHeXravcZktrMlPzAlCtZ6xBkrjdQRy5G1Yzypu
         1HlQ==
X-Gm-Message-State: AAQBX9fDPp3yAFeGygnUWJ45sR0wAQF8HU1eAd3HdevaP1dPOVCxPX+O
        /U1xjYalkFP5fKFsrFEDY4mRMwAVveg48bYnsrE2dA==
X-Google-Smtp-Source: AKy350aFwmtLvugVS91SXWv58KL7rNgH36bP8Zd/ssQQS9euHnK+TiBtfXgpvNKAwXuEGqbYg0WQqyzlGYvf7hTsufM=
X-Received: by 2002:a1f:9f52:0:b0:406:1ef2:7bc7 with SMTP id
 i79-20020a1f9f52000000b004061ef27bc7mr10108602vke.2.1680082701571; Wed, 29
 Mar 2023 02:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230329093200.419041-1-colin.i.king@gmail.com>
In-Reply-To: <20230329093200.419041-1-colin.i.king@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 29 Mar 2023 15:08:10 +0530
Message-ID: <CAFA6WYNOzJxwXA_RfAkHxp-w1Pu0UQpeZOoP7tyaGBSeBuERVQ@mail.gmail.com>
Subject: Re: [PATCH][next] optee: Fix spelling mistake "Unuspported" -> "Unsupported"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 15:02, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a #error message. Fix it.

Thanks for catching it, it has already been fixed as part of this PR [1].

[1] https://lore.kernel.org/lkml/20230314184441.GA2936721@rayden/T/

-Sumit

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/tee/optee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 290b1bb0e9cd..df5fb5410b72 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
>  #elif defined(CONFIG_ARM64)
>         return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
>  #else
> -#error "Unuspported architecture"
> +#error "Unsupported architecture"
>  #endif
>  }
>
> --
> 2.30.2
>
