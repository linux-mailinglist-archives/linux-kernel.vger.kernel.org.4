Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417CC7494D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjGFFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGFFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:07:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD210EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:07:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so136051cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688620029; x=1691212029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hffRxnSunklfp89DvzvKwrWLyrgvALeN7SrVEPvDGfM=;
        b=P3c5Ah9qbElG18sj1GFPMyDiu/SS2+LTy7Ar2rnSPEBE1HJ//UgMlpZWTZ307UWpA0
         UdSX5eWZMYwgGCA+lSGEyKwbGOluaLUhuOu8nIqgMmPfA5Zn3OoUdrvHO8kljaGXC+LG
         wysq4DhNl9b5WHQkJMfvMH038IzSwuDyP5zT/8Gu0iox6x2tBGT+byKjC0Pxw0PW6Z5I
         ss9XF1C+aTIq/YhDdfV59dyzOr0oi/t3qAfffIQ/mP+rzbSnVDw+46z+aj4PKB/4rP4A
         ogLXbyrZI2bRePeUpP1FRLLIkItgP96LTrewH0MINhim4aQobRNUPn5+LsQ165pq45KP
         z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688620029; x=1691212029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hffRxnSunklfp89DvzvKwrWLyrgvALeN7SrVEPvDGfM=;
        b=Qvsuo4IwHenSZKwGq8AS8T1kCAtWshsRqxa2x2nxi5pJ43WlBbXnpoPaYxWHG9YgOJ
         3iO7APsMBaWqVihWAlAQ3voJRxQVpPORIk5xpHMu9fjoyb/9XpQk5NhQYCWeK3hRq/jj
         UpnKW+Ey9fO4mH5tMuKIN4vEwgAYvLVdVUauOi7g7+fASC1aoUfhw7sMyQiqFU1Imv39
         I8IeBH9yNPKNcPkiTs2Un1pcxzJ0N77QHfhG7UaY/4VvsZoDCCs9TsNRhWzs1dagtaYw
         bHDdjKgs1X0ThpBzgVGNxDGCY3ZXlcbSRwXB+/dg2EZGYOGNhWZe0jOizSvyp2+C4iBd
         OV2w==
X-Gm-Message-State: ABy/qLZRfiBv0BzJYH90st7G88uY2R0eD/ftUDhOouy+oSogLLNK6Act
        W/w1fEsbc/PZHyFflHNz85V2KFh9RTYznrrdSqlMcCz46Fk48V5V+g==
X-Google-Smtp-Source: APBJJlGGYKrR1oEbXVo41fG7AIqxtwNP5cFvFHu0YbwAbU9CriMrOnef4ZhaOJso815c6Zac+BtBRSCVqOzeXBALYTw=
X-Received: by 2002:a05:622a:2c2:b0:3f0:af20:1a37 with SMTP id
 a2-20020a05622a02c200b003f0af201a37mr40610qtx.15.1688620028818; Wed, 05 Jul
 2023 22:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230704052405.5089-1-rdunlap@infradead.org> <20230704052405.5089-2-rdunlap@infradead.org>
In-Reply-To: <20230704052405.5089-2-rdunlap@infradead.org>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 5 Jul 2023 22:06:57 -0700
Message-ID: <CANDhNCoicO=CRuDnWrs--XikWu=SwNPU46erntiCjWvSoWZv2A@mail.gmail.com>
Subject: Re: [PATCH 2/3] jiffies: add kernel-doc for all APIs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 10:24=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Add kernel-doc notation in <linux/jiffies.h> for interfaces that
> don't already have it (i.e. most interfaces).
>
> Fix some formatting and typos in other comments.
>

Looks ok to me. Thanks for sending this out!

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
