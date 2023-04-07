Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72296DB1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDGRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDGRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:42:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA253BB96
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:42:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a25c4f49b2so1147245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889324; x=1683481324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCJBn+LV6Sw7OAfizOJEGae3D9tERqlvcOUfu0w0v9w=;
        b=f2Hy+gUmypC61FZjpBgjNc/XgvxTOME7kxHD5CgsiiLONDJ0uGaPOd0VsvyK9IAcKM
         YCMZlfDwqFaEOSmOdtSE2HeLW/0quTgY7Ny0dhk8px8kavE9LUIYdthXog1GIX+rq2fE
         g8QS73QBlzrsxk6gaJ+O/XLCA2rqxISinXTYyUthkLmBrbZM7ZIFXt9S38ACofBHt7P+
         dptOeElYK2OgQ0wNuuT3DfiVwL3MzQyLTRnlUE0+IB/r4ycxDRicgexH0w6MJtyetQ1+
         IGrOxD8aNU79hee5zjeh76EgzLJ6mJ4Ruz4wxkM/ZC6EOIWhplr5BfzYNq6f2EmnRqac
         A5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889324; x=1683481324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCJBn+LV6Sw7OAfizOJEGae3D9tERqlvcOUfu0w0v9w=;
        b=diLIsIbHKPX7NjHgpvqZWmOJE7mTNQT+Xzxi3BgH8yOyFW+vyRO8dpHRO/xOtZ/yDT
         smLCUjTl+TGi9s1rGjJahf2Pfoe645UL74Y6GF5mQr9f/ndGmKhagdoYNkmuiFwcCCHh
         l8pMbntl5RXfbpOrE5+KBzNc7iSLWO/TbzFsZN5W5DwYv/+1OpvVAh4haW0AayG1DcmL
         ZgDqDtK5eNZrrR263vxIB/9VLPNB0EFxuSbHIjVnC/oqb70JBksXrc1CQtlX0eZY2eb4
         oxEnKKuopF3GTQHUsqjICanDGLI03vvTpgJoLPYvmTz5fYBYZlQAEFlzOFTBpNCyZvSv
         4eMg==
X-Gm-Message-State: AAQBX9ekVJcu3Z6RdlLRQE1e2r9F2iw2m1O7U/mpUQYoeBHAtVmd+Ytf
        +uvEjcs+6gX4ruFBiV1O7bRGbRFy3B2L6DtuputyMA==
X-Google-Smtp-Source: AKy350aUCyZLaAV21BNIhr8D01YQwfaMcMC3ERAqD6aKrlIBdnYZELskAEaom95VFSvRH3V0KPE/o9w3eCEDFaZkXdI=
X-Received: by 2002:a05:6a00:2d88:b0:625:c832:6a10 with SMTP id
 fb8-20020a056a002d8800b00625c8326a10mr1525908pfb.4.1680889324079; Fri, 07 Apr
 2023 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230324132649.2649166-1-trix@redhat.com>
In-Reply-To: <20230324132649.2649166-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:41:52 -0700
Message-ID: <CAKwvOd=rjd6+Di4GSm2kfKRdBmrMyyL-VdQ+CR28NX_G5p0AGQ@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip: remove unused hw_to_inno function
To:     Tom Rix <trix@redhat.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
        nathan@kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 6:27=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c:284:36: error:
>   unused function 'hw_to_inno' [-Werror,-Wunused-function]
> static inline struct inno_dsidphy *hw_to_inno(struct clk_hw *hw)
>                                    ^
> This function is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/p=
hy/rockchip/phy-rockchip-inno-dsidphy.c
> index 726928ff1273..401b0aabb159 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
> @@ -281,11 +281,6 @@ struct inno_mipi_dphy_timing inno_mipi_dphy_timing_t=
able_max_2_5ghz[] =3D {
>         {2500000000, 0x15, 0x54, 0x7f, 0x15, 0x6a},
>  };
>
> -static inline struct inno_dsidphy *hw_to_inno(struct clk_hw *hw)
> -{
> -       return container_of(hw, struct inno_dsidphy, pll.hw);
> -}
> -
>  static void phy_update_bits(struct inno_dsidphy *inno,
>                             u8 first, u8 second, u8 mask, u8 val)
>  {
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
