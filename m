Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2129653A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiLVCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:23:45 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E412D31;
        Wed, 21 Dec 2022 18:23:44 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a66so511852vsa.6;
        Wed, 21 Dec 2022 18:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VFTDHnDll88TPaYL7KvtdsNvFq8ZgzXZIlFN1ok/uLs=;
        b=KsDKiECBrS56TPmqiIUDPte07tYoYqXGw4oyNgupkaTeF10bKGqWZCQjJuhu4+lO38
         84vAlBc3LmdWvvnSHh0Dr7mcoTD7NWJmR4K2SeQwhaP0dUMrfe+Um/p7KYjlaH4Tn514
         u1s5HfcXBjMFbloTUXP3Xfb5V+nMkvXMBuwhrHEpbyj9Xbu1Rm6yIpuspfng+9rneHtn
         LdcReBjgck5EQDqBYw0q5WkZoeQBZN9Oi56ERWA7jqIodUjdnpucUdmtiIghlRCXlx6S
         dxaHJssKGDeqQVPdGRxiiae+Xp4gKtvS6uYCYX1dO0JctffNJDdX8WduyelfG906B9c4
         BhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFTDHnDll88TPaYL7KvtdsNvFq8ZgzXZIlFN1ok/uLs=;
        b=ITFLZLvn6vxQhDxwMdswlKNkcH0cYPecCJeXEy3QWBUyYOrbcCQ/E4pKKUiFiBP/oq
         F3UsxwKIBruzvU5i5IlZM/pKz/NLs3wqGuykWVZ86bftwZnxsz6nGHjYJk9Q5fpYlesr
         VwnKaPDbEOdxDn7JFpKoIglBWb9lyR62C+oFtIM/rxwvXw0TPHyomD/D5pxSxp8VBeTQ
         eXt7ae6X3Y4nKoikn3b31G3+jC0XqsnlCWQ3qic3CPMpirCwGaMoXnBN5kAflW/2rS0q
         wlei/Gi3wHAkQc16JBtrdkemK6Lgi6cWbeNvSncP1xteKaUfl65P/aDuTv9Tq8Hrs47f
         m4qQ==
X-Gm-Message-State: AFqh2kqx6NRCX3Q4I4fCggBXzWP2sEalLiUTUDCirofbF/bBdUWImJ7g
        k/ipwLo7uqNxrFrzyyzMlej0scQhv+VS58STnXU=
X-Google-Smtp-Source: AMrXdXu485GKY0plvl7WKqc853dOIB+mUZa+WCeJDChwDEPLzOiTiuVy1grv9+2X/WaCczrEUdfD4Rdc6OnYT6f3IQY=
X-Received: by 2002:a05:6102:105:b0:3b1:4aad:9c47 with SMTP id
 z5-20020a056102010500b003b14aad9c47mr497116vsq.73.1671675823724; Wed, 21 Dec
 2022 18:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20221220094055.3011916-1-milkfafa@gmail.com> <20221220094055.3011916-8-milkfafa@gmail.com>
 <078aa497-e441-ef3d-c206-de23ca2658c9@collabora.com>
In-Reply-To: <078aa497-e441-ef3d-c206-de23ca2658c9@collabora.com>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 22 Dec 2022 10:23:32 +0800
Message-ID: <CADnNmFpjrRy2J5mrFnp6JRiY5W=Xot83PV_JMuBWMP-uf63Rig@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
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

Hi Andrzej,

Thanks for the review.

> > +static void npcm_video_ece_set_fb_addr(struct npcm_video *video, u32 buffer)
>
> static inline void?
>

> > +static void npcm_video_ece_set_enc_dba(struct npcm_video *video, u32 addr)
>
> ditto

> > +static void npcm_video_ece_clear_rect_offset(struct npcm_video *video)
>
> ditto

> > +static int npcm_video_ece_init(struct npcm_video *video)
>
> static inline int? But...
>
> > +{
> > +     npcm_video_ece_ip_reset(video);
> > +     npcm_video_ece_ctrl_reset(video);
> > +
> > +     return 0;
>
> ...the return value is not inspected by the only caller anyway, so why not
>
> static inline void?

OK, I'll declare these functions as static inline void.

> > +static int npcm_video_ece_stop(struct npcm_video *video)
> > +{
> > +     struct regmap *ece = video->ece.regmap;
> > +
> > +     regmap_update_bits(ece, ECE_DDA_CTRL, ECE_DDA_CTRL_ECEEN, 0);
> > +     regmap_update_bits(ece, ECE_DDA_CTRL, ECE_DDA_CTRL_INTEN, 0);
> > +     regmap_update_bits(ece, ECE_HEX_CTRL, ECE_HEX_CTRL_ENCDIS,
> > +                        ECE_HEX_CTRL_ENCDIS);
> > +     npcm_video_ece_clear_rect_offset(video);
> > +
> > +     return 0;
>
> Nobody inspects this return value. Either void, or check the return value
> at call site and handle a non-zero failure.

OK, will change to void.

> > +static unsigned int npcm_video_get_rect_count(struct npcm_video *video)
> > +{
> > +     struct list_head *head, *pos, *nx;
> > +     struct rect_list *tmp;
> > +     unsigned int count;
>
>         unsigned int count = 0;
>
> otherwise if the below condition is not met, ...
> > +
> > +     if (video->list && video->rect) {
> > +             count = video->rect[video->vb_index];
> > +             head = &video->list[video->vb_index];
> > +
> > +             list_for_each_safe(pos, nx, head) {
> > +                     tmp = list_entry(pos, struct rect_list, list);
> > +                     list_del(&tmp->list);
> > +                     kfree(tmp);
> > +             }
>
> why does a function whose name implies merely getting a number actually
> remove all elements from some list? count equals video->rect[video->vb_index];
> and everthing else looks like a(n indented?) side effect. This should be
> somehow commented in the code.
>
> > +     }
> > +
> > +     return count;
>
> ... an undefined number is returned
>
> Which makes me wonder if the compiler is not warning about using a possibly
> uninitialized value.

You are right, this is not the right place to remove the rect_list.
It makes more sense to remove the list right after the associated
video buffer gets dequeued.
I'll do that change.

> > +static int npcm_video_capres(struct npcm_video *video, u32 hor_res,
> > +                          u32 vert_res)
> > +{
> > +     struct regmap *vcd = video->vcd_regmap;
> > +     u32 res, cap_res;
> > +
> > +     if (hor_res > MAX_WIDTH || vert_res > MAX_HEIGHT)
> > +             return -EINVAL;
> > +
> > +     res = FIELD_PREP(VCD_CAP_RES_VERT_RES, vert_res) |
> > +           FIELD_PREP(VCD_CAP_RES_HOR_RES, hor_res);
> > +
> > +     regmap_write(vcd, VCD_CAP_RES, res);
> > +     regmap_read(vcd, VCD_CAP_RES, &cap_res);
> > +
> > +     if (cap_res != res)
> > +             return -EINVAL;
> > +
> > +     return 0;
>
> The return value is not handled by the caller

> > +static int npcm_video_gfx_reset(struct npcm_video *video)
> > +{
> > +     struct regmap *gcr = video->gcr_regmap;
> > +
> > +     regmap_update_bits(gcr, INTCR2, INTCR2_GIRST2, INTCR2_GIRST2);
> > +
> > +     npcm_video_vcd_state_machine_reset(video);
> > +
> > +     regmap_update_bits(gcr, INTCR2, INTCR2_GIRST2, 0);
> > +
> > +     return 0;
>
> Never inspected by callers

> > +static int npcm_video_command(struct npcm_video *video, u32 value)
> > +{
> > +     struct regmap *vcd = video->vcd_regmap;
> > +     u32 cmd;
> > +
> > +     regmap_write(vcd, VCD_STAT, VCD_STAT_CLEAR);
> > +
> > +     regmap_read(vcd, VCD_CMD, &cmd);
> > +     cmd |= FIELD_PREP(VCD_CMD_OPERATION, value);
> > +
> > +     regmap_write(vcd, VCD_CMD, cmd);
> > +     regmap_update_bits(vcd, VCD_CMD, VCD_CMD_GO, VCD_CMD_GO);
> > +     video->op_cmd = value;
> > +
> > +     return 0;
>
> Never inspected by caller

> > +static int npcm_video_start_frame(struct npcm_video *video)
> > +{
>
> One of the callers ignores the return value, but not the other. Why?

These problems will be addressed in the next patch. Thank you.

Regards,
Marvin
