Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059847478CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGDTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:44:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C310CF;
        Tue,  4 Jul 2023 12:44:38 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5703d12ab9aso72395027b3.2;
        Tue, 04 Jul 2023 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688499877; x=1691091877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwfdFxLnz2FRAYtKqKmj4b/IYrsbglqXAF9+qfbe5K0=;
        b=fIkXGW5SzTQnVanAdBKLRIui1tnMupzY6X4m+moKXsIXlWp85WTrn+bLoMZRSvZiC9
         oTQRF31FImWEgwDWM1kFKabWLPXA1RHYyDxWylNomB6XpCCQBceYUUQIkBn/Gy8AYE21
         0Oq9kX6FIbUEL8WLz/axyagGAXHQpRlfB5n7yFxMLy8LqXU0XJ6hDvjteA0tsUc9jNUQ
         FerDXy8o/sL0Kf9/Jv/dwsKCRV6FpETzx8hPuX+kV5c16w44VHz2S4uvBAqI+PkPaRGh
         tecvzzhvURt2dvwCU1P50RFKoHiKBHrC5qy/3BfytxGbNFmNtbrNGtF2yOlYqVoZA+LP
         RFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688499877; x=1691091877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwfdFxLnz2FRAYtKqKmj4b/IYrsbglqXAF9+qfbe5K0=;
        b=NMG8KIz8vDAKdbpul51i6TqDzWsfAdAmYTZqZ9bAa0cLjpF/zTT06FQNH8VKlkCiq1
         tIrJ4xNVUOfGANNpQF/Lw2dHYfadZceECW/ZcbdlUpZ7mY8SIQZwKkZ2OexpLtBO7UbK
         CK6y5yNC/eg7aEngApzKos2HFpQ3rJ4jnmyjvY1uyJAhcj/ge1EU94x3k8G/GRU9tgNy
         EY1JLzWJI5TrKgkPz6Q1CD2rO0i4ZOATOk5u1q2bYTuvhMklW0CVfjM4W4CAw5MUWpMk
         Li8VS4K/9D5rRHy8Ikd0LuAu50BE8JcMuz7I4NDdeqVi/omx5rV5OkyXKnCmenvWYrDq
         +OOA==
X-Gm-Message-State: ABy/qLaO3uN0AcxhLRxXfBGrVV6kSOKe8zFDnY2WN2dzmuLo1Dr6SB4v
        cnpg1Kymww1huLamc0JQ3oksLJRUgm3Cte6dIW4=
X-Google-Smtp-Source: APBJJlGeNxZLiIdiIciCrp+/JDchClBogoOdy2+YZQ7E+/tkRLYhhyQYtmrGZmuZ3SXs7GTI9sZHuSHj1qxKJ2MAiN4=
X-Received: by 2002:a0d:ca55:0:b0:56f:fba4:9b85 with SMTP id
 m82-20020a0dca55000000b0056ffba49b85mr13441942ywd.7.1688499877233; Tue, 04
 Jul 2023 12:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org> <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
In-Reply-To: <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Tue, 4 Jul 2023 16:44:25 -0300
Message-ID: <CABgtM3jpj4AdS5nydni0a4X98hXUzVLdWrPQva_B2E=kCBEnxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello.

>
> On 7/4/23 06:17, Greg Kroah-Hartman wrote:
> > Drivers should not have a single static variable for the type of device
> > they are bound to.  While this driver is really going to only have one
> > device at a time in the system, remove the static variable and instead,
> > look up the device type when needed.
> >
>
> This is expensive. I think it would be much better to just move
> the board type detection into the init code and not instantiate
> the driver in the fist place if the board type is unknown.

I meant to do this, since the probe function is called only once and
is meant for hotpluggable things. But since it works as it is and only
loads in supported hardware it didn't seem necessary.
Modify what you see fit. And thanks for the attention to the quality
of the driver.

Joaqu=C3=ADn
