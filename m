Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7155D5FE665
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJNAoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJNAol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:44:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D8E3F;
        Thu, 13 Oct 2022 17:44:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-345528ceb87so32654707b3.11;
        Thu, 13 Oct 2022 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8LDuQyUJtNYxJgy4BlDNCydbYtmE3vLtBYETof5SnFI=;
        b=aRJ9OBkeAuELPWfuoujR12QWft/Ey5aPla71BTas+EejTpfSwC9FVGNF8SltaCwzZQ
         zD9o78QeP6QiZYQNMMAH+h839ISvygSDDs65k6nrRQsIBf5Pdw0fFWsbgWUC1ePoIf8g
         6AaFsRw02DRQaTN/s/dXhsnREKsp6OeZYlcqkQNNSPrHnmZwJXtcRIlqaVkg4AC/mrvw
         +7V8cjVk1nh1E4yGM3w96/npUZI3lEz++igpvFat6+NbnUbm71MbzgSXRVSsGcM4Ax1w
         2iqbbqO56uMv6TT0qnU5IjoSjWCopl5I9oyQYzKpE6KMXzykYxLRTALvN4C0Ox/s/tpG
         1RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LDuQyUJtNYxJgy4BlDNCydbYtmE3vLtBYETof5SnFI=;
        b=1tnFPxKBIOD3wQh6OTdZDUN3s3PnziYzZxuZ/AKOI1DMfIUBLLg0zXBX2hfzzyNMQn
         nBedL8qzomiwEhGCkt1PsbvnhgwGFKBj25V4rnBjYWQiiPJ/jP6a5P9vrS2NWH6KaGq3
         XSfm6re6SljgpFMD2PHvHfkooF6gEGTBDhvJa8Q3zJmNIq9FMx0AJMtdkZrWxvCYJiT7
         ISrt2plbIn/zo8AgUm91eESUJ95uahn4Gu1D0wwrgOvlaJiMlCQLCtzFdqggwxLxQvrT
         wv8lLdcUevQyi5YFW/axtOUfAMpSrAHoLGqJpi7BBkUSUovOcHqC+2PZJv1fRnqohUta
         5YVw==
X-Gm-Message-State: ACrzQf0wUMRaXJua8a6AvyFkYxv3lJEcma6msLZROT2rr5tVEU1vTsPC
        ReW+qCsU2/WfZitrstgF3Y7sPhZ+GNlQrHhbKJo=
X-Google-Smtp-Source: AMsMyM4n9AR/vXW+jIEymBK/T8UROD3M5E+x6DA76Ee13P69cmAzOptvubKJKVG4i4e+MHfBE1wR1w8ea59kqZXCG7g=
X-Received: by 2002:a0d:ca86:0:b0:354:5995:d6a4 with SMTP id
 m128-20020a0dca86000000b003545995d6a4mr2514235ywd.504.1665708278429; Thu, 13
 Oct 2022 17:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101515.354-1-lukas.bulwahn@gmail.com> <CAMo8Bf+MHVLOh-U0EyP1DoJPDSHscC=st0TYZ9L76+xgfBxaOQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+MHVLOh-U0EyP1DoJPDSHscC=st0TYZ9L76+xgfBxaOQ@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 13 Oct 2022 17:44:26 -0700
Message-ID: <CAMo8BfJ0F6Ya9kwKckCqT0YWiU31RWM4RK1U+CypwNMqNS68QQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: update config files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 8:33 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Sep 29, 2022 at 3:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Clean up config files by:
> >   - removing configs that were deleted in the past
> >   - removing configs not in tree and without recently pending patches
> >   - adding new configs that are replacements for old configs in the file
> >
> > For some detailed information, see Link.
> >
> > Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/xtensa/configs/audio_kc705_defconfig   | 1 -
> >  arch/xtensa/configs/cadence_csp_defconfig   | 4 ----
> >  arch/xtensa/configs/generic_kc705_defconfig | 1 -
> >  arch/xtensa/configs/nommu_kc705_defconfig   | 1 -
> >  arch/xtensa/configs/smp_lx200_defconfig     | 1 -
> >  arch/xtensa/configs/xip_kc705_defconfig     | 1 -
> >  6 files changed, 9 deletions(-)
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Applied to my xtensa tree.

-- 
Thanks.
-- Max
