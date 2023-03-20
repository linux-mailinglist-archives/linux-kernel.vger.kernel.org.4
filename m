Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B86C1A52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjCTPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCTPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF57DBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:41:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so48478856edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679326863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Is6JeKucWy0ZXmWuzYtnHpHbkTUkmwFW9c2TBjUQtE=;
        b=ih59+sDHpbunSe1L4S7EYfu2T/PovEAeCUIwFRNPWtn+3zpzADgZIIvBGL2B6F47Yo
         wG7C+HXGcA9B/J4fMPMW9cBpIhjkMxJNtf/PYCdPm4HETADJ4pnX+bSPD6Qp0a84RMdQ
         2GGnGsfA9VauAnfzZDWzEWwtrPV7yMd13+/D90TIrqL3e43TewnCt2kTeXivQlTMBY5P
         LO4O8suLzCb/hKHrvJ3wBETqFlsDX3YHrbyLx8ys+fJDnRICwDrMcy4jFBQD2SYGE5d8
         3TGp1XPN1ct+Y138iG8v4kCxjTc14F77wcqn9Ji2/ywyD1/WoShqYD5/2sUxoVPOkZAi
         Cucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Is6JeKucWy0ZXmWuzYtnHpHbkTUkmwFW9c2TBjUQtE=;
        b=nXLKz6CUsnMgPiveBdC/HQainiIAV/eThipffmjkZvqXZ+WyiSrxFeF5q81/7xVJ0f
         pODsJ6ypGi8sDKRvAPj2f8yQni8G9ifvzDw4nG7UpWYKPFQda047pewEJfZNYXK0GEnP
         zf2CWprcqL66iWHjjOZ0yNj9Q9NcQz4RpFx3Ha9T99AoVtrZJELdq8orW1K+UPgYx6g7
         AYelC6Yv167gPFOULqpJKaGSVVhEdqvDnFbNLvzz7yzNYL0akifgGh1YcOPWXNM1KHqN
         3g8rMLWTvNWlBQnao53G0loyp+f6NHmen27mAatrrpt4QSfAEkNaiTdvIX+M/iwLN/W+
         6rbw==
X-Gm-Message-State: AO0yUKXooe2JLTC8ZLZF/mEdIGlOl9xx8vdWzyqIB1Ue5uMT7H8sydJn
        FCynnE+FuOdAYq2dIuFR5PGzMrQeuetLTeUyMfEwWt4e7oU=
X-Google-Smtp-Source: AK7set+nu+EtMtZWpYCzYff9J7f7wH29y2sBXEKnm5Lokx+omZ1fDpaa6ftITGSCZB1lCEY3d9sVnYRI6N0Ql1c398k=
X-Received: by 2002:a17:906:4d84:b0:920:da8c:f7b0 with SMTP id
 s4-20020a1709064d8400b00920da8cf7b0mr4198081eju.6.1679326863403; Mon, 20 Mar
 2023 08:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com> <ac3b4356-d4c3-25e4-9bc2-c5b369c676b2@gmail.com>
In-Reply-To: <ac3b4356-d4c3-25e4-9bc2-c5b369c676b2@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Mar 2023 16:40:52 +0100
Message-ID: <CAFBinCBNDDP=H8s6SSGKrxrh_TVDjfEfV7T5UJ_Hxsgu-kjuJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: amlogic: meson-gx-socinfo: use new
 soc_device_register functionality to populate machine name
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 1:37=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> A new fallback mechanism has been added to soc_device_register that
> populates machine with the DT model information if machine isn't set yet.
> This allows to remove this code here.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Assuming this is only applied after/together with the first patch from
this series:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
