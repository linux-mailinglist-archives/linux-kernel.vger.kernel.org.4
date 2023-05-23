Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2570E71B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjEWVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbjEWVFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:05:19 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372A18E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:05:12 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-335d6260e9bso11785ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684875911; x=1687467911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2Nz3y3qoiTuBk9TgDabiliDyiqWiXu5FrWlJdz9mKE=;
        b=ONgWeoapPdsXjtVlfZgOTY0YX7WN84kwZ+lxvIZ+Z4JgI0d0KEejBZHFG14bnlJ8Q+
         LZeXd5pYKxQT6vTp4kKHY+jHAhAZi8/eoyCBQRuqWVxLQJoqe3fxhEpjMLOmJ0t4EV5O
         C113c5SM7jQNkt7uGolh64LfDpkgaTWEJgX1opjbWVEySvF3wUojSBVnrGtP/tEFCq4p
         m4LMDyEPLJwS7ZciKAWcb9dX5wnFmi6JjZfCCScrpUDy2m0JOawJU844QlTAVLEcMsck
         FxZKf03dsMlrbic8t+xD8NpLBtvkNXlX85QjS/kETmPvBM88UyGkRopycXAYOQ0k4qtV
         w6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875911; x=1687467911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2Nz3y3qoiTuBk9TgDabiliDyiqWiXu5FrWlJdz9mKE=;
        b=KJq56uMvaoNq8Bv4bNEAdBgbr2u9k9v76q5iJ1oPn5qVgXEJ1eVbvs6Muzb9J2eTo3
         ZLqn7/+EUMl+aT8UYLVyYG5LxxfWw7DZAYzptGFjBp/c7IK0q3Bcck6KBYG433QoIuWz
         dgvjwsCPqrVSgkIUOcfkh/5yURYtWrCHYu4kgVa299C8RVD149zaa+Ukv2cs+ghKiaoe
         EkxQqQ+JrDkzUSwGSeD86uJgDzIA+2Ff0KvONLNH5DZJqUSk/NWaz5lTPN7+3hbjLHZe
         8Rz94ZeFNRq/NhPuas4nAgoZHbhUDKyTaM4rGljt6JObvVsBc0H7C0G2eekksMZKk7t0
         Ul5Q==
X-Gm-Message-State: AC+VfDxgTH+ktB5NIYKy4VRsiqamwqxCLFVEHYG7c9E0X9xF5Si/1H8g
        S6Do9h2LRycUhTrYObqaerwl52oCDXJ3Jcs1y9tqRA==
X-Google-Smtp-Source: ACHHUZ7Txm8nqQaZy6MgeGTbwmpy46SQwfW06R6g1Du+QW7rpPJydUuYPp9gS6UClgiky4qhjuFMErdp4zPAfwqP4vc=
X-Received: by 2002:a92:cda9:0:b0:335:62cc:3972 with SMTP id
 g9-20020a92cda9000000b0033562cc3972mr41564ild.19.1684875911458; Tue, 23 May
 2023 14:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032316.3464732-1-yangcong5@huaqin.corp-partner.google.com>
 <20230519080136.4058243-1-yangcong5@huaqin.corp-partner.google.com>
 <ed8fc8f2-e5d8-8e08-dc29-e1197c911571@linaro.org> <CAHwB_NK8wKaXw6Gy9CFnsZB0XrqokiHGXoMNAzd0R+myYg4gxQ@mail.gmail.com>
In-Reply-To: <CAHwB_NK8wKaXw6Gy9CFnsZB0XrqokiHGXoMNAzd0R+myYg4gxQ@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 23 May 2023 14:04:56 -0700
Message-ID: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
Subject: Re: [v1 0/2] *** Support Starry-himax83102-j02 and Starry-ili9882t
 TDDI MIPI-DSI panel ***
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, daniel@ffwll.ch,
        hsinyi@google.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 22, 2023 at 1:01=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,neil:
>  Thank you for your reply, it's not that the polarity of reset is differe=
nt. The state of this rst needs to be high during a certain period of time =
(when hid touch communicate,). I have tried to set the default property to =
high in DT, but from the log and waveform, the rseet single  is set to low =
by boe_panel_add before hid touch communication.As shown in the picture, rs=
t needs to be high before hid ready. Datasheet: https://github.com/HimaxSof=
tware/Doc/tree/main/Himax_Chipset_Power_Sequence

To add some breadcrumbs, I think the issues is that panel/touchscreeen
are intertwined and really need a solution like the one proposed in my
series:

https://lore.kernel.org/r/20230523193017.4109557-1-dianders@chromium.org

Cong Yang tested an early version of my series and indicated that it
helped solve his problem. Presumably if that series (or something like
it) can land then we'll unblock the ability to support this hardware.

-Doug
