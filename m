Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D272005C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjFBL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjFBL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:27:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9C195
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:27:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba1815e12efso1779535276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685705266; x=1688297266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd3UXHgx1H6xb/h3DMlUvIvASHkgkOBuNAmK4hfk6DQ=;
        b=cbVhzP7/zdjRJTbH/O2KA3DMnC+kVZLIIA55FgXZiZjTzHEveOn0YVSuIZCa/fUO0h
         TDIp4LUXZYla1uIEON0ZKsUHP+1zaGfea69NibJPt3GnEOZf2ZJT603EvU5BgANc2YfK
         TZ6N4uONZj53FFhWPZivbYWpUJkLVpgtalm0szKRVizMbm6bzEYJaey1XyeKYOSY0w2j
         VUDzEYxksXoCPv813DE/8No6BUCQ7a37CsQ+xKydUOcdJnYa+Xebso2tjJbIO3Tn14XB
         LK3hQItmZQqlhUeuhwNpw1vI3gj0xVINDHHewrC3Cs9WUzQIpdwMCxGCUW3VVYIafQFa
         E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685705266; x=1688297266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd3UXHgx1H6xb/h3DMlUvIvASHkgkOBuNAmK4hfk6DQ=;
        b=R1KK+XYSNKgz/qUzNNKKBS6pS5PgOfei01f2Zqt1RtCMaVsqXbIFt4voELCQiaO5KN
         vhavGLWTZZmbE6nBRMjOAqa3drZKUIJgXx/XVeuPs21FZO5Wx8oF8gGgrqRyUONDGDxE
         kBtEPrU4DHnsKbOlmx1E4Y+xkblqMPjYG//VlIeSgbCT8NUcHSoD+ktwiOrFBTkNcJZ0
         jo1wZQgKkpMO5kJ2YG+mtxgbhx2iojzX7beTdwgTO2H78hv1+zy8DDKUd6CqJSx4xU4W
         kMO2xkffQwNZNljgnhhWZbQyAF2t5NUtu7TYpsDPPkFjprv8UbWECXzi/5Ayw7T/N6iM
         njvg==
X-Gm-Message-State: AC+VfDxl3ULU30H2mZPr6G718PmMJ1owv2yKEMBmt7gOndT5/enyvqrH
        b6c5jxAKYwNHD8y94yKNKn4R/omE01NHsaSaKVQ=
X-Google-Smtp-Source: ACHHUZ5/CgoAaTKXgZBGZtIq7/YjFFDe0J/JXCM3DG1loHU5/LHyCqL+EwAIsnu3L0PLZJzZFSKWslsk5kJzBkLfa58=
X-Received: by 2002:a25:ae15:0:b0:ba6:cf6f:960b with SMTP id
 a21-20020a25ae15000000b00ba6cf6f960bmr2650507ybj.27.1685705265946; Fri, 02
 Jun 2023 04:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230525205840.734432-1-u.kleine-koenig@pengutronix.de>
 <CANiq72=qi4yXH+24zFHFatBdUHy_ekNrFoYnpZL0fSMa76kpug@mail.gmail.com> <20230526125959.jksnrsvtokqkdcqs@pengutronix.de>
In-Reply-To: <20230526125959.jksnrsvtokqkdcqs@pengutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Jun 2023 13:27:34 +0200
Message-ID: <CANiq72=a17sRYGH7ky=WEXuDyxSMCRJePvt0HTY3_1mV18TLCw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Switch i2c drivers back to use .probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
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

On Fri, May 26, 2023 at 3:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The overall idea was to make the changes in a way to require no
> coordination between maintainers. So adding this change to your tree
> would be great.

Sounds good -- applied to `auxdisplay`, thanks!

Cheers,
Miguel
