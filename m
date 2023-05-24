Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2370EDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjEXGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjEXGdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:33:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272E184;
        Tue, 23 May 2023 23:33:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae58e4b295so4314835ad.2;
        Tue, 23 May 2023 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910011; x=1687502011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZytcZ3VwuCq76/D3BihoAAg5jsM5s58IhQgHv2bVFM=;
        b=GpblBLOMdDyZ+rJGSJxBbZCR9/80prxCXE+n6rOOpHjWfF8CY2Six/JuqKmwYhOkaG
         HBdgLQgpecx7bLSVh/jBSO6nbpzmg6hqwfoOSOpx0IfaRfHLqP3uMCdB7W8I/1U1MjYy
         bQ4/XqYTbvclzL7LtYmYC/ziLw17xj0uT+Czto+8UuDURPlLlQxpOcF/mqN1hPxDw8jy
         ZrrpHMiYW66mhXFmIxVkMpjTCufKQ9HILNOqaffEME5UtEppPVnw1dj9in5szCTQ+REU
         +lpzl8jGJN+KjbULvKyRpniR9qvtMPPLWcuJuObwqUOREPZn/stfxnYoHETREkHWgJ13
         XE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910011; x=1687502011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZytcZ3VwuCq76/D3BihoAAg5jsM5s58IhQgHv2bVFM=;
        b=LPbo4tsidBInvGyYLTddWQ4Ih9fIJGWQSjyJbaZ5iCHCnE5/qeDfgS3rJPst5HAt6O
         OZxXMnRWd2rknIRJaiWkmTrgX5dbPpKRg02UGDcsdTeJ4IV7Tn6ejds2aBupDkp4DPF4
         11poBmyeYp5Or49x7bUHNAi8GOaR5AsSJXYnEPKs5YTSlfhZCU0ZkNCxRcWiBMcCdkmt
         KCfzQowxv22MwktRvgKCyCaGAYxpwj/fp9RFjPF7yF+EUdqGPQ2+VVqv+r96l/CY8xkk
         LKGB8QP3nAZLlbfOEDEMsZ5hBYo/0lPMC8w51kf8F7mCgL1r+edfuc8NW2QrZxBVhUe2
         SA1w==
X-Gm-Message-State: AC+VfDxHUbP/DHjnllncbSZb1NrXPdoTCmyrq5Glak+Yu8cl7zAzJrKY
        Mjs72TCzUDQAdNfwpRkqp7eJPAhGwEYjeVAVuKY=
X-Google-Smtp-Source: ACHHUZ5wUYGy14v/X3nxf4KjcKO/yzfIyoOlWFtzMxIPOAsvC35YFvTWQcIvTclY9hddhQ+5BkP1YhLf3yt9BZdFThU=
X-Received: by 2002:a17:90b:e8f:b0:24e:3b85:a8a with SMTP id
 fv15-20020a17090b0e8f00b0024e3b850a8amr17345777pjb.8.1684910010949; Tue, 23
 May 2023 23:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230511152120.3297853-1-AVKrasnov@sberdevices.ru>
 <c873b5a9-17ad-767c-5b20-35a49ab2bd40@sberdevices.ru> <aa67ee8b-898b-319b-f167-b554700842b3@sberdevices.ru>
 <20230522161446.16d1f307@xps-13>
In-Reply-To: <20230522161446.16d1f307@xps-13>
From:   liao jaime <jaimeliao.tw@gmail.com>
Date:   Wed, 24 May 2023 14:33:18 +0800
Message-ID: <CAAQoYRkTMpeHABxwRAXVtyuUNXhEk8njcXxJiH7PWg3UsERVVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel

>
> Hi Arseniy,
>
> avkrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:49:50 +0300:
>
> > Hello @Miquel!
> >
> > Sorry, but who could review this patch? :) IIUC this logic is very hw s=
pecific and we need
> > someone who knows it well? I tested this patch on our devices (with alr=
eady known Meson NAND
> > controller).
>
> + Jaime, who might test
>
> >
> > Thanks, Arseniy
> >
> > On 11.05.2023 21:21, Arseniy Krasnov wrote:
> > > Cc: Mason Yang <masonccyang@mxic.com.tw> and Boris Brezillon <boris.b=
rezillon@collabora.com>
> > >
> > > On 11.05.2023 18:21, Arseniy Krasnov wrote:
> > >> This adds support for OTP area access on MX30LFxG18AC chip series.
> > >>
> > >> Changelog:
> > >>   v1 -> v2:
> > >>   * Add slab.h include due to kernel test robot error.
> > >>   v2 -> v3:
> > >>   * Use 'uint64_t' as input argument for 'do_div()' instead
> > >>     of 'unsigned long' due to kernel test robot error.
> > >>
> > >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > >> ---
> > >>  drivers/mtd/nand/raw/nand_macronix.c | 213 ++++++++++++++++++++++++=
+++
> > >>  1 file changed, 213 insertions(+)
> > >>
> > >> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand=
/raw/nand_macronix.c
> > >> index 1472f925f386..2301f990678e 100644
> > >> --- a/drivers/mtd/nand/raw/nand_macronix.c
> > >> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > >> @@ -6,6 +6,7 @@
> > >>   * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > >>   */
> > >>
> > >> +#include <linux/slab.h>
> > >>  #include "linux/delay.h"
> > >>  #include "internals.h"
> > >>
> > >> @@ -31,6 +32,20 @@
> > >>
> > >>  #define MXIC_CMD_POWER_DOWN 0xB9
> > >>
> > >> +#define ONFI_FEATURE_ADDR_30LFXG18AC_OTP  0x90
> > >> +#define MACRONIX_30LFXG18AC_OTP_START_PAGE        0
> > >> +#define MACRONIX_30LFXG18AC_OTP_PAGES             30
> > >> +#define MACRONIX_30LFXG18AC_OTP_PAGE_SIZE 2112
> > >> +#define MACRONIX_30LFXG18AC_OTP_START_BYTE        \
> > >> +  (MACRONIX_30LFXG18AC_OTP_START_PAGE *   \
> > >> +   MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> > >> +#define MACRONIX_30LFXG18AC_OTP_SIZE_BYTES        \
> > >> +  (MACRONIX_30LFXG18AC_OTP_PAGES *        \
> > >> +   MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> > >> +
> > >> +#define MACRONIX_30LFXG18AC_OTP_EN                BIT(0)
> > >> +#define MACRONIX_30LFXG18AC_OTP_LOCKED            BIT(1)
> > >> +
> > >>  struct nand_onfi_vendor_macronix {
> > >>    u8 reserved;
> > >>    u8 reliability_func;
> > >> @@ -316,6 +331,203 @@ static void macronix_nand_deep_power_down_supp=
ort(struct nand_chip *chip)
> > >>    chip->ops.resume =3D mxic_nand_resume;
> > >>  }
> > >>
> > >> +static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, s=
ize_t len,
> > >> +                                      size_t *retlen,
> > >> +                                      struct otp_info *buf)
> > >> +{
> > >> +  if (len < sizeof(*buf))
> > >> +          return -EINVAL;
> > >> +
> > >> +  /* Don't know how to check that OTP is locked. */
>
> Jaime, any idea?

OTP info could be check by GET_FEATURE command.
GET_FEATURE command with address 90h could read sub-feature
parameter table, P1 is "3" means OTP protection.

Thanks
Jaime

>
> > >> +  buf->locked =3D 0;
> > >> +  buf->start =3D MACRONIX_30LFXG18AC_OTP_START_BYTE;
> > >> +  buf->length =3D MACRONIX_30LFXG18AC_OTP_SIZE_BYTES;
> > >> +
> > >> +  *retlen =3D sizeof(*buf);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int macronix_30lfxg18ac_otp_enable(struct nand_chip *nand)
> > >> +{
> > >> +  uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> > >> +
> > >> +  feature_buf[0] =3D MACRONIX_30LFXG18AC_OTP_EN;
> > >> +  return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> > >> +                           feature_buf);
> > >> +}
> > >> +
> > >> +static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
> > >> +{
> > >> +  uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> > >> +
> > >> +  return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> > >> +                           feature_buf);
> > >> +}
> > >> +
> > >> +static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
> > >> +                                  loff_t offs_in_flash,
> > >> +                                  size_t len, size_t *retlen,
> > >> +                                  u_char *buf, bool write)
> > >> +{
> > >> +  struct nand_chip *nand;
> > >> +  size_t bytes_handled;
> > >> +  off_t offs_in_page;
> > >> +  uint64_t page;
> > >> +  void *dma_buf;
> > >> +  int ret;
> > >> +
> > >> +  /* 'nand_prog/read_page_op()' may use 'buf' as DMA buffer,
> > >> +   * so allocate properly aligned memory for it. This is
> > >> +   * needed because cross page accesses may lead to unaligned
> > >> +   * buffer address for DMA.
> > >> +   */
> > >> +  dma_buf =3D kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL=
);
> > >> +  if (!dma_buf)
> > >> +          return -ENOMEM;
> > >> +
> > >> +  nand =3D mtd_to_nand(mtd);
> > >> +  nand_select_target(nand, 0);
> > >> +
> > >> +  ret =3D macronix_30lfxg18ac_otp_enable(nand);
> > >> +  if (ret)
> > >> +          goto out_otp;
> > >> +
> > >> +  page =3D offs_in_flash;
> > >> +  /* 'page' will be result of division. */
> > >> +  offs_in_page =3D do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
> > >> +  bytes_handled =3D 0;
> > >> +
> > >> +  while (bytes_handled < len &&
> > >> +         page < MACRONIX_30LFXG18AC_OTP_PAGES) {
> > >> +          size_t bytes_to_handle;
> > >> +
> > >> +          bytes_to_handle =3D min_t(size_t, len - bytes_handled,
> > >> +                                  MACRONIX_30LFXG18AC_OTP_PAGE_SIZE=
 -
> > >> +                                  offs_in_page);
> > >> +
> > >> +          if (write) {
> > >> +                  memcpy(dma_buf, &buf[bytes_handled], bytes_to_han=
dle);
> > >> +                  ret =3D nand_prog_page_op(nand, page, offs_in_pag=
e,
> > >> +                                          dma_buf, bytes_to_handle)=
;
> > >> +          } else {
> > >> +                  ret =3D nand_read_page_op(nand, page, offs_in_pag=
e,
> > >> +                                          dma_buf, bytes_to_handle)=
;
> > >> +                  if (!ret)
> > >> +                          memcpy(&buf[bytes_handled], dma_buf,
> > >> +                                 bytes_to_handle);
> > >> +          }
> > >> +          if (ret)
> > >> +                  goto out_otp;
> > >> +
> > >> +          bytes_handled +=3D bytes_to_handle;
> > >> +          offs_in_page =3D 0;
> > >> +          page++;
> > >> +  }
> > >> +
> > >> +  *retlen =3D bytes_handled;
> > >> +
> > >> +out_otp:
> > >> +  if (ret)
> > >> +          dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret)=
;
> > >> +
> > >> +  ret =3D macronix_30lfxg18ac_otp_disable(nand);
> > >> +  WARN(ret, "failed to leave OTP mode after %s\n",
> > >> +       write ? "write" : "read");
>
> Let's avoid WARN() calls (none in this driver are relevant IMHO). Just a
> dev_err() should be enough.
>
> > >> +  nand_deselect_target(nand);
> > >> +  kfree(dma_buf);
> > >> +
> > >> +  return ret;
> > >> +}
> > >> +
> > >> +static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff=
_t to,
> > >> +                                   size_t len, size_t *rlen,
> > >> +                                   const u_char *buf)
> > >> +{
> > >> +  return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *=
)buf,
> > >> +                                      true);
> > >> +}
> > >> +
> > >> +static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_=
t from,
> > >> +                                  size_t len, size_t *rlen,
> > >> +                                  u_char *buf)
> > >> +{
> > >> +  return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, fa=
lse);
> > >> +}
> > >> +
> > >> +static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_=
t from,
> > >> +                                  size_t len)
> > >> +{
> > >> +  uint8_t feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> > >> +  struct nand_chip *nand;
> > >> +  int ret;
> > >> +
> > >> +  if (from !=3D MACRONIX_30LFXG18AC_OTP_START_BYTE ||
> > >> +      len !=3D MACRONIX_30LFXG18AC_OTP_SIZE_BYTES)
> > >> +          return -EINVAL;
> > >> +
> > >> +  dev_dbg(&mtd->dev, "locking OTP\n");
> > >> +
> > >> +  nand =3D mtd_to_nand(mtd);
> > >> +  nand_select_target(nand, 0);
> > >> +
> > >> +  feature_buf[0] =3D MACRONIX_30LFXG18AC_OTP_EN |
> > >> +                   MACRONIX_30LFXG18AC_OTP_LOCKED;
> > >> +  ret =3D nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> > >> +                          feature_buf);
> > >> +  if (ret) {
> > >> +          dev_err(&mtd->dev,
> > >> +                  "failed to lock OTP (set features): %i\n", ret);
> > >> +          nand_deselect_target(nand);
> > >> +          return ret;
> > >> +  }
> > >> +
> > >> +  /* Do dummy page prog with zero address. */
> > >> +  feature_buf[0] =3D 0;
> > >> +  ret =3D nand_prog_page_op(nand, 0, 0, feature_buf, 1);
> > >> +  if (ret)
> > >> +          dev_err(&mtd->dev,
> > >> +                  "failed to lock OTP (page prog): %i\n", ret);
> > >> +
> > >> +  ret =3D macronix_30lfxg18ac_otp_disable(nand);
> > >> +  WARN(ret, "failed to leave OTP mode after lock\n");
> > >> +
> > >> +  nand_deselect_target(nand);
> > >> +
> > >> +  return ret;
> > >> +}
> > >> +
> > >> +static void macronix_nand_setup_otp(struct nand_chip *chip)
> > >> +{
> > >> +  static const char * const supported_otp_models[] =3D {
> > >> +          "MX30LF1G18AC",
> > >> +          "MX30LF2G18AC",
> > >> +          "MX30LF4G18AC",
> > >> +  };
> > >> +  struct mtd_info *mtd;
> > >> +
> > >> +  if (!chip->parameters.supports_set_get_features)
> > >> +          return;
> > >> +
> > >> +  if (match_string(supported_otp_models,
> > >> +                   ARRAY_SIZE(supported_otp_models),
> > >> +                   chip->parameters.model) < 0)
> > >> +          return;
>
> I would start by checking the model, then it's list of supported ops.
>
> > >> +
> > >> +  bitmap_set(chip->parameters.get_feature_list,
> > >> +             ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> > >> +  bitmap_set(chip->parameters.set_feature_list,
> > >> +             ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> > >> +
> > >> +  mtd =3D nand_to_mtd(chip);
> > >> +  mtd->_get_fact_prot_info =3D macronix_30lfxg18ac_get_otp_info;
> > >> +  mtd->_read_fact_prot_reg =3D macronix_30lfxg18ac_read_otp;
> > >> +  mtd->_get_user_prot_info =3D macronix_30lfxg18ac_get_otp_info;
> > >> +  mtd->_read_user_prot_reg =3D macronix_30lfxg18ac_read_otp;
> > >> +  mtd->_write_user_prot_reg =3D macronix_30lfxg18ac_write_otp;
> > >> +  mtd->_lock_user_prot_reg =3D macronix_30lfxg18ac_lock_otp;
> > >> +}
> > >> +
> > >>  static int macronix_nand_init(struct nand_chip *chip)
> > >>  {
> > >>    if (nand_is_slc(chip))
> > >> @@ -325,6 +537,7 @@ static int macronix_nand_init(struct nand_chip *=
chip)
> > >>    macronix_nand_onfi_init(chip);
> > >>    macronix_nand_block_protection_support(chip);
> > >>    macronix_nand_deep_power_down_support(chip);
> > >> +  macronix_nand_setup_otp(chip);
> > >>
> > >>    return 0;
> > >>  }
>
>
> Thanks,
> Miqu=C3=A8l
