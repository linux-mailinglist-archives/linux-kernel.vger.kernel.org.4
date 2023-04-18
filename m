Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39A6E65E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjDRNaw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:30:48 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0914F6B;
        Tue, 18 Apr 2023 06:30:47 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94ea38c90ccso62016766b.1;
        Tue, 18 Apr 2023 06:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824645; x=1684416645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv3rHrXx1ar+7vAH1+tI2B1buQtV7SGlDsdzgUm+D7w=;
        b=jOpioAow/Li1RpxKPE5sdJ3ueGebezTdscVHjgBnYLOgsBLG349EhVtaxEERiKtnHR
         M33yp5vFuvx6KY0HzRdnEe17XNoRIPLnELtXd+KyG5TrrbjYGqo/5WqTGj8MxYoCCQQS
         D3ftHEjJf/ycgej5L0FIJh1SaG1qToGkZW/wK2F1m2UZSfDMS7t4LX2ePv30MhBxfk8f
         kQiqF2uU3N94x9IC2+6i8v4D+deoVjRwCwg9iThkic3xAlwehlVah74l77yJPLZqhfUa
         JLWL/Qe2K0sMKDQiO0QMe6C7jd8h9SJd8/mPZoB5Xe5GHOhrbpftmpTgU2rBA0SKcvWV
         PgSQ==
X-Gm-Message-State: AAQBX9fvafUXE6HO/5TSNJQjQWdqf2Af+kk92hr/YgYSGLkxUl6WCl+F
        lCIUX7yiWGeT7aSguz5T9SE0T+pJ/to05M+pZ9iMfnC0
X-Google-Smtp-Source: AKy350bi3ArTSH1lCwuhVvvp5sh16o3PVpjQnd4plqbYjNeiwe4P4WvwFfrIwgfXTNxZ1fjn5BpMl8oJjigvBb/xUfI=
X-Received: by 2002:a17:906:648f:b0:92f:39d9:1e50 with SMTP id
 e15-20020a170906648f00b0092f39d91e50mr12555457ejm.3.1681824645579; Tue, 18
 Apr 2023 06:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <1681789108-28130-1-git-send-email-wangchenggang@vivo.com> <20230418035307.f6p2jp3nxgfyebns@vireshk-i7>
In-Reply-To: <20230418035307.f6p2jp3nxgfyebns@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:30:34 +0200
Message-ID: <CAJZ5v0gZFU8Lreto8fDYa9PYUo=ZiNLr21FFSbYxMcsAc0hA=Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Delete unmatched comments
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chenggang Wang <wangchenggang@vivo.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-04-23, 11:38, Chenggang Wang wrote:
> > The function no longer returns a value, synchronize the comments.
> >
> > Signed-off-by: wangchenggang@vivo.com
> > ---
> >  drivers/thermal/cpuidle_cooling.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> > index 4f41102..7779739 100644
> > --- a/drivers/thermal/cpuidle_cooling.c
> > +++ b/drivers/thermal/cpuidle_cooling.c
> > @@ -236,9 +236,6 @@ static int __cpuidle_cooling_register(struct device_node *np,
> >   *
> >   * This function is in charge of creating a cooling device per cpuidle
> >   * driver and register it to the thermal framework.
> > - *
> > - * Return: zero on success, or negative value corresponding to the
> > - * error detected in the underlying subsystems.
> >   */
> >  void cpuidle_cooling_register(struct cpuidle_driver *drv)
> >  {
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Daniel, are you going to pick up this one?
