Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35AF73FC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjF0M7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0M7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:59:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C4E1;
        Tue, 27 Jun 2023 05:59:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635dbfa710dso18548336d6.0;
        Tue, 27 Jun 2023 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687870750; x=1690462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5+DuaCiOR+WAyBglQbQg08A79GQ+8qOpe+uAJINk1c=;
        b=m0CC08U9FXkhchI54swpLsV6pI+g0px1bOiqzSuiiPa/mJruusL7KGGgD/ORhipJyM
         5Z2sEQBsuEpSn8k12lr7hL2ta3/Bb0ZLy0Gp122QZSq0rLgi0b1banHOuhE1s9CXhnq0
         jCWopxGWJZtyoIO2fLvsSK9y7QK7FBWyFQsAxM91HMWmPMVYV0u/of131gfQ65rSnnBg
         XZZfd2MyLqF2cN7eI5HdYNNIJRL8N9keF+sUJy5dXDWnCYYyQGwUTyXubHWoblPLJQ1h
         YhkFI1GVpgFupPMfhQdOk2HuJINgf0MJoXTe21+bWdNpX/L8SaUrgcd0TpTy+K/RVG39
         HZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870750; x=1690462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5+DuaCiOR+WAyBglQbQg08A79GQ+8qOpe+uAJINk1c=;
        b=cAmVUxDqOzU+sg8ZFbWldAc3uUdqG6SLCejl0mD9XI7r1PGcvDdV985DaiuykzQuff
         qgOdhO2In5z/4WE023iqPa5UG9WoIGs+F8cb50d8IjmDc7dINno1JiuvcD8m0EDhvvVM
         kvIrlt8lsHNrn57R9GhGb7Y5atEbSvQQhRdwdxz7qDi7VJ1IgWHLqPaupDpdY4W8OJdl
         DaTsEhcqwa9JjPesTpFjZjZchaHx4GE2JxuriSdyFrGYDiaV0sG21VnDS8gjJNRojRjt
         6VQVtOzmqTcIv3FYgjVQjiYpq0kasR3l7w1vepExnma+KEzWb7PYyLu9RbBMHGdFpuDf
         9kgw==
X-Gm-Message-State: AC+VfDy4/xdh0xTzydk/3FfAyTj7sPKbt+KJqMYudKcRXRaEznKwdTEZ
        O26yDTKWDhXYrXm9CjYDssEgQVr3BvyU1U+8sw0=
X-Google-Smtp-Source: ACHHUZ7+L3rt8Etz7M+6oZM4CgUMh79FhCOfRxyrdMbPFyBlJyxEgk6URk9C0QQdVRaEcqHAjx0Q6qJjixNcDd9/2tU=
X-Received: by 2002:a05:6214:20e4:b0:62d:edf6:6dcd with SMTP id
 4-20020a05621420e400b0062dedf66dcdmr33702421qvk.51.1687870750297; Tue, 27 Jun
 2023 05:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626102752.1583-1-youkangren@vivo.com> <CAGRGNgW_eeM2h7JBe98asaYjnF8hwAr50n8dfSabeK2H0u4=Qg@mail.gmail.com>
 <PUZPR06MB59369ADE01FB04AD9A7279A9AA27A@PUZPR06MB5936.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB59369ADE01FB04AD9A7279A9AA27A@PUZPR06MB5936.apcprd06.prod.outlook.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 27 Jun 2023 22:58:58 +1000
Message-ID: <CAGRGNgV=aNXvVZ8QkxE8R3Lr7edm6BPZ3adi5E23QeFO-q7nRw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ray_cs: Remove invalid conditional statements
To:     =?UTF-8?B?5bCk5bq35LuB?= <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
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

Hi,

On Tue, Jun 27, 2023 at 10:44=E2=80=AFPM =E5=B0=A4=E5=BA=B7=E4=BB=81 <youka=
ngren@vivo.com> wrote:
>
> Dear Julian,
>
>     I found a warning at compiling time that the if and else branches had=
 no effect here. I looked at the code and found that the contents of both b=
ranches were the same, so I merged the contents of both branches into one a=
nd committed the changes.

That's great, but it needs to be in the commit message.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
