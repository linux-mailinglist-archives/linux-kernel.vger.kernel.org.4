Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CD6105BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiJ0WZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiJ0WZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:25:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1A34984;
        Thu, 27 Oct 2022 15:25:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r83so4209374oih.2;
        Thu, 27 Oct 2022 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TrIIhVZx5BXAQ8nT8vfvPQ7H/iZjq+OzPVDs0LA4cw=;
        b=MAv6HPgqfMygKs4BTr7A1U9j44lASKl92+O5gK6Jduhv540AVv0A6qWGSZQPhfBPUR
         yU/pzd5FIYlVg+ivxD0wlld9CLV4KLhTMg4HjhEzlozgEROj6wD2/V10aAh4aXQcP35U
         BafnDpsvMD09E4SRDLfNlxZnDUA98DW/atAWsyjouJMoTF39YF5qUxKgT2HKGmoPvNs7
         10teZts3aMs9T5wV9egaMWF493y0DsYnvC5tFR1v2iYOOeaO9k/0DcpjDm87935i1Xkv
         jkbuDvE3yWYSOVKjh/2ivDegzeWuZMFR0claopai1LeNUuf33rzsByUqaqwVleAFccHR
         dszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TrIIhVZx5BXAQ8nT8vfvPQ7H/iZjq+OzPVDs0LA4cw=;
        b=67RnaX2CaWlwzIeDGSJKrkbBaZ9LAeNh5MnQt4hjiay3A6R8x9K1pIHjqsG172JJTQ
         E1/IR059gn24iK6LJ8oeP9pCnYBw45QlPVyvIZpH+QhzH73zCPsoyQ1Pt0dUQlaBF53i
         ZtubniNe9kxMLQtrSULHZBreRpgXCXOx6CC1sYhBqulX0QBQw2ALARAdAqHdq5ErExa4
         klQnoAyczgtYALkLHakOiiT+M91ggl69Bm91VAurFiOcVvuzzok5wl1OTiHgXZ6zY199
         3iZLVN98LYwbqleLXXcauPmatdQCSGvFw0ToNmHHI6qQR0ThZ7SMvOVSE8fklbOe6qYu
         MiUg==
X-Gm-Message-State: ACrzQf27xuY+3br1SW/CbtkLPZw48ZonI5NJTCtykTgYgMkw9dj/BEun
        tQZvb2gcTqMX2KYoBpLYsDTsh7u2u28=
X-Google-Smtp-Source: AMsMyM4HyPKTVue/7qcHWPFRtfbuE/YEWKdjke4PrvWEFGKaDXaKoQo6j4ADz/XbbOo50/dADPB5vw==
X-Received: by 2002:a05:6808:1495:b0:354:fff1:e0c7 with SMTP id e21-20020a056808149500b00354fff1e0c7mr6360344oiw.114.1666909519681;
        Thu, 27 Oct 2022 15:25:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6-20020a9d2c06000000b0063b24357269sm1009481otb.13.2022.10.27.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:25:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 15:25:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH -next] hwmon: (smpro-hwmon) Add missing break in
 smpro_is_visible()
Message-ID: <20221027222516.GB3123386@roeck-us.net>
References: <20221027195238.1789586-1-nathan@kernel.org>
 <20221027210016.GA1938309@roeck-us.net>
 <Y1ryPDF4CD+6gIMY@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ryPDF4CD+6gIMY@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:03:56PM -0700, Nathan Chancellor wrote:
> On Thu, Oct 27, 2022 at 02:00:16PM -0700, Guenter Roeck wrote:
> > On Thu, Oct 27, 2022 at 12:52:38PM -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > > 
> > >   drivers/hwmon/smpro-hwmon.c:378:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
> > >           default:
> > >           ^
> > >   drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
> > >           default:
> > >           ^
> > >           break;
> > >   1 error generated.
> > > 
> > > Clang is a little more pedantic than GCC, which does not warn when
> > > falling through to a case that is just break or return. Clang's version
> > > is more in line with the kernel's own stance in deprecated.rst, which
> > > states that all switch/case blocks must end in either break,
> > > fallthrough, continue, goto, or return. Add the missing break to silence
> > > the warning.
> > > 
> > > Fixes: a87456864cbb ("hwmon: Add Ampere's Altra smpro-hwmon driver")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1751
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  drivers/hwmon/smpro-hwmon.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
> > > index ee54e21c2c12..667e88b6bae5 100644
> > > --- a/drivers/hwmon/smpro-hwmon.c
> > > +++ b/drivers/hwmon/smpro-hwmon.c
> > > @@ -375,6 +375,7 @@ static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
> > >  				return 0;
> > >  		break;
> > >  		}
> > > +		break;
> > 
> > The alignment of the break; statement above is also bad, and a default:
> > for switch (attr) is missing.
> 
> Would you prefer those fixed in the same patch or a separate one?
> 

Same patch, please. The resulting code is ultimately the same.

Thanks,
Guenter

> > >  	default:
> > >  		break;
> > >  	}
> > > 
> > > base-commit: 0ffb687b6508c36a17b99bdaf014b38532404182
> > > -- 
> > > 2.38.1
> > > 
