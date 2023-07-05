Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E4749047
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGEVwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGEVwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:52:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC21619A2;
        Wed,  5 Jul 2023 14:51:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ed230c81so133947b3a.0;
        Wed, 05 Jul 2023 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593913; x=1691185913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4CAs3KeJkV+VtOgVWyKLS47+26Kg9qfg3imYR9VXy0=;
        b=U2XfRaBh6G+45W9IzFyza4TNyzwwKyqFhSbd4P89BtP1Wj3WpIIOP6R3MzOmwdIpT8
         skHtTghfzOa3bn9CBjudP8eOzdIIOLXNOlf0wmHYiA2jEJ5DVAwrVOE7/URvJuwkf1w0
         1/nTd9OoRrwB/NBVmECQv5bJv/kkKbd/Hjs/T42I2YRIPkRoGA1E+/zcT6tCwzXq3zEB
         sT6yEHzBOPqGavtpTMp6ay8Pgn1hPQPudVEsaYYqK+Bp2jjzGdYPeLPiEwCtBGM6dApL
         l+ixvCLIrZWxx+7zWji/z4DhB6vyQtlBjlxpXmP9jVFkAJZQ4qTO+lbkcRWuuHs30voQ
         Ij7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593913; x=1691185913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4CAs3KeJkV+VtOgVWyKLS47+26Kg9qfg3imYR9VXy0=;
        b=P+CNDr7b6uNbvpDEyFKrW33c7OaMKtnJK1iKExY6ogrAFZFUe8YSL36jzADkWj0ZaL
         v0tUBRwTHhZc0G+/l7oXmo+fdOYot9/0wFhS0xOHKIqzksNSIN5Dylc7oze+15QR/z4U
         c0WsTLiS44eTg7pcJvQ7nRGTLOlFxhRI/WdBy2L1yLey/768ppO8eddVMd2004GjazaD
         OqrwnmfCpC4c4i9dTCipLDBxczoRa1x1/aQJ4lgh69tLqCodG4G1rHMBh0QWvgXQ+gqR
         AHcswFxwe9aHOrPf6oP/YcmAxWZogXf9aYdD6BIDjDAb678834d9CPtdzfeYlKgLX1Nq
         9YhA==
X-Gm-Message-State: ABy/qLYpGgDi53Kg9ItdEH3mZZ6INdx3g3LfGM7TiI65nGYKQyttV6Az
        8Sw7L6Z1aT92eIPWOidkIKo=
X-Google-Smtp-Source: APBJJlHv2oYOMRuzjkfmL5Y3YIpCLCtwC3suVy0QSGSl1e5gH9ODE2JfjeghBek1d84e+ERvfcIzIQ==
X-Received: by 2002:a05:6a00:1399:b0:682:616a:f910 with SMTP id t25-20020a056a00139900b00682616af910mr140964pfg.20.1688593913118;
        Wed, 05 Jul 2023 14:51:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id m18-20020a638c12000000b00543e9e17207sm31061pgd.30.2023.07.05.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:51:52 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:51:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] input: cpcap-pwrbutton: remove initial kernel-doc
 notation
Message-ID: <ZKXl9up6n255YOFW@google.com>
References: <20230703230005.14877-1-rdunlap@infradead.org>
 <20230704000821.z3tx4chw7x6pn6nq@mercury.elektranox.org>
 <ZKXEcr+43Qkj8Y4m@google.com>
 <20230705212845.w2yhqb75fqx6psim@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705212845.w2yhqb75fqx6psim@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:28:45PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 05, 2023 at 12:28:50PM -0700, Dmitry Torokhov wrote:
> > On Tue, Jul 04, 2023 at 02:08:21AM +0200, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Mon, Jul 03, 2023 at 04:00:05PM -0700, Randy Dunlap wrote:
> > > > Change the beginning "/**" in the file to "/*" since it is not a
> > > > kernel-doc comment. This prevents a kernel-doc warning:
> > > > 
> > > > drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > > >  * CPCAP Power Button Input Driver
> > > > 
> > > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: linux-input@vger.kernel.org
> > > > ---
> > > 
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > 
> > Applied, thank you.
> > 
> > BTW, the driver is missing SPDX annotation, Sebastian I wonder if you
> > could send a patch addressing this (given you are the author it is
> > better coming from you).
> 
> DONE: https://lore.kernel.org/all/20230705212231.631525-1-sre@kernel.org/

Thank you, much appreciated.

-- 
Dmitry
