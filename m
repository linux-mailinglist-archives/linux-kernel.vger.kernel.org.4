Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EE6DB1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDGRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:36:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF8B45E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:36:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q20so15800926pfs.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889002; x=1683481002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKQ/0jGnOo/TaPpGUaml4IRy69MNIBKloNhJZjKlyT0=;
        b=KD6ZnfzfidIvC2otpuKywoCEsPFpclOlyGbsChbiRW+NoHLgvlIIgbDR4G+StlGoIH
         70V+Xb3tH88TdmFrqGplFBGXqlCuzUxbpiYDRXsLBoXwoTz2W/3cDhHDXwaLaBxXrYgF
         HoyNSRrWgdMunOUk6NYADKkEMctFlUeJ1Iki7CFRPojkLCxojNZhXIY4q/yC9rhMflBI
         HVPtR1t3cZu8XwM35jE6pq6TIb9CglNvwwY1HkADONdXRkNJsKn9yWoPfVIRjtounOsv
         vbp2pu43LZzeofyFbChgOgo1nVZLGY29Dl835qQC8chqq9E88SUh/NyYFrzZxEKcCFHk
         R1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889002; x=1683481002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKQ/0jGnOo/TaPpGUaml4IRy69MNIBKloNhJZjKlyT0=;
        b=moXKmq+98if9TGCT2kMP72uM0bJjmr53L9U+F2CuCxLJfjwMQfnMi50xk32YOcHBLw
         tDay0MStDsnDjGBFoNizggj+EmVvocFLgRrR2HkEHeMte4gbQU7EeiTQGsx6I+Rb9G1L
         cbylH6GdoEq753qxmSzOd3K8ZGm8I1SLlUPpGL+S3uR723TIpmL1Dll7MNEmavnkZvsE
         9ixVi8SkCRLi5OcYB8KYlpykCr4ta5Lc7LkuIBbYmzeQaBF0Ers8dmNNWcmL1F1+MFoe
         oYwdvG1hNmvL4y0YATmVc0JzK3HmthjnyH6lZVX1Sp7ExoLsnbTfz9fKEI53+Vy1rynv
         8poA==
X-Gm-Message-State: AAQBX9eCUymak+QqbBnxN8XtCtljyAlqZjTMWuNov7qmxx4rqa5DqIbX
        uSF9H4ap4Bl88Rb5bMayOX/WDxmhKJRuX6oXyE28KQ==
X-Google-Smtp-Source: AKy350aSeVgPhP3/iHKIqEYixpWTIqJFHUyWjp2+JIS3RbQGz3Zhh/BGeX+aSZcOD/B9rL3bBeCHzbu+p557vPjtJzU=
X-Received: by 2002:a65:578e:0:b0:513:a488:f05f with SMTP id
 b14-20020a65578e000000b00513a488f05fmr620379pgr.1.1680889001970; Fri, 07 Apr
 2023 10:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230318133952.1684907-1-trix@redhat.com>
In-Reply-To: <20230318133952.1684907-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:36:30 -0700
Message-ID: <CAKwvOdk=TGUTJMN1Am6EayVd1M9NRy_SwpUQBFWCb=+5KyMeXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/kmb: remove unused set_test_mode_src_osc_freq_target_low,hi_bits
 functions
To:     Tom Rix <trix@redhat.com>
Cc:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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

On Sat, Mar 18, 2023 at 6:39=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/kmb/kmb_dsi.c:822:2: error: unused function
>   'set_test_mode_src_osc_freq_target_low_bits' [-Werror,-Wunused-function=
]
>         set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_ds=
i,
>         ^
> drivers/gpu/drm/kmb/kmb_dsi.c:834:2: error: unused function
>   'set_test_mode_src_osc_freq_target_hi_bits' [-Werror,-Wunused-function]
>         set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi=
,
>         ^
> These static functions are not used, so remove them.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/kmb/kmb_dsi.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.=
c
> index cf7cf0b07541..ed99b14375aa 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
> @@ -818,34 +818,6 @@ static void test_mode_send(struct kmb_dsi *kmb_dsi, =
u32 dphy_no,
>         }
>  }
>
> -static inline void
> -       set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_ds=
i,
> -                                                  u32 dphy_no,
> -                                                  u32 freq)
> -{
> -       /* Typical rise/fall time=3D166, refer Table 1207 databook,
> -        * sr_osc_freq_target[7:0]
> -        */
> -       test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES,
> -                      (freq & 0x7f));
> -}
> -
> -static inline void
> -       set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi=
,
> -                                                 u32 dphy_no,
> -                                                 u32 freq)
> -{
> -       u32 data;
> -
> -       /* Flag this as high nibble */
> -       data =3D ((freq >> 6) & 0x1f) | (1 << 7);
> -
> -       /* Typical rise/fall time=3D166, refer Table 1207 databook,
> -        * sr_osc_freq_target[11:7]
> -        */
> -       test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, =
data);
> -}
> -
>  static void mipi_tx_get_vco_params(struct vco_params *vco)
>  {
>         int i;
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
