Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C37149CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjE2NCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjE2NB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:01:59 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06609B
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:01:57 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-557de45f56aso1726204eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685365317; x=1687957317;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yRipnQwdG9ZVcAtJhlrN7pDVZmxkTajuArBHYu8ek0=;
        b=RhWYIIn6FOyXnTMRli6QpcUnLZ+6KMc1KddrJLnjQLdI4/G+HqOiuv4J+nQDV+9LGW
         LYdauWv66YZXuulJrLcitGqgMNM3w7/EiP/MsZKjZp8nPNG7kenPLr0f/tPUD/yvLFzb
         LSLYORSTs8uIvjAM9CpHorC9Tuf+HwfcVvpxbLswxngYl5HfkR7hQ9eHrl0cWQ0BZ/hN
         MCLwLaKyHThUVrqA0sQjJHavTnAtNTUTcGr60m7df/TZUQasKWiy3ET4g/lysj7iuEUc
         /GhB0nm2R13Ui8LP8h1nB8pLBo6uZSx223EO76XRsGyBR4vrjCmcepO6uXUmp2RABfeV
         GKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685365317; x=1687957317;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yRipnQwdG9ZVcAtJhlrN7pDVZmxkTajuArBHYu8ek0=;
        b=YvZKNJzaTtsRHOsLqr50HywT5pJCb9syM7eqYVx1hwY8fwbZYHlzwVaBIXugEn+wMX
         SqNdeuFDGl/zYSlhOkgC2/QLaIcokxezfDFDZz6X3eQn9B6gQtEMWJtk822CvgvnC7/c
         Ue4i5V2JBAtJQAGlRas5sk1nTNnxD+PUhRTVQZf2oj/YYZdAu10609J2DIlBVIu+Kr1m
         cBi91ld2jGoUVE1a6ZoCUMgItcRC/Ovdfbl0fSmB5+Rz8AbMvOXxN1rSDnUqS8ArFHcW
         8umWMQ+HaURGM5+q9D5s6jKRaclS/LdbrsBhTUyEG/kL+04WBOjc2x+bRkRBTQTH3a9Z
         KAIA==
X-Gm-Message-State: AC+VfDyGHIpx/qILI/7M5nQg3YPamG1gtM6dk3ZTW7GdP29ibjVrNpS7
        el+ko1KVYSRbg2KZ5fr5LT1S5+Xzmlmd0U6wadY=
X-Google-Smtp-Source: ACHHUZ7nXtRyuCzXt1OG0dCPx8YkZPevnwBacML0NnpoQGHPzjAOuD17pwczWSFDHU/sF7Dv2g7JRK0gmrVkQR2SXVw=
X-Received: by 2002:a05:6870:73d5:b0:180:5c1f:5446 with SMTP id
 a21-20020a05687073d500b001805c1f5446mr5537914oan.50.1685365317005; Mon, 29
 May 2023 06:01:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6851:58d:b0:4a7:cda8:5f81 with HTTP; Mon, 29 May 2023
 06:01:56 -0700 (PDT)
Reply-To: georgebrownhoward02@gmail.com
From:   georgebrownhoward <gh239444@gmail.com>
Date:   Mon, 29 May 2023 15:01:56 +0200
Message-ID: <CANTrA0vUPSCfAVgr4bsGZpAGm1eVfovNyK1NWRKmTrk_X9H8dg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

Mijn naam is George Brown. Ik ben advocaat van beroep. Ik wil je aanbieden
de nabestaanden van mijn cli=C3=ABnt. U erft de som van ($ 8,5 miljoen)
dollars die mijn cli=C3=ABnt voor zijn dood op de bank heeft achtergelaten.

Mijn cli=C3=ABnt is een burger van uw land die samen met zijn vrouw omkwam
bij een auto-ongeluk
en enige zoon. Ik heb recht op 50% van het totale fonds en 50%
wees voor jou.
Neem hier contact op met mijn priv=C3=A9-e-mail voor meer informatie:
georgebrown0004@gmail.com

Bij voorbaat hartelijk dank,
Meneer George Brown,
