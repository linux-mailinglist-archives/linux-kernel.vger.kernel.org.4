Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53FC6BE096
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCQF2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQF2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:28:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D72D156
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:28:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y2so3960670pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679030918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JypFrOzIO0MXDs6uCiWRo8IysoMLGN4UV2Agh/hsCgI=;
        b=Qf/pR+EyDe9bkrg2GDKSKAv6isMAEA5jNctyIkNKqRigUg4b+TgCHjBVFh0Z7yDXJN
         LtAC7l4u0AK2HBBNa44trD0yqz8KGlInXI4YnY1Kv/ybUdHdQ8rBpDvHRdSQim1Ij+Nr
         FutQB142HH9FbrLO7bNCzZ6AIyqMFfXnuaGuEqKb4wWb5uM7hkmVYZ8OnsA4tqOY4ZYZ
         85udphYuqWBb6/RkmxgZ1R9/dSapjSyxJ7lNQG+vGZk7CZ0Ec2FkD7mrA7T4uJRrQ3nv
         SAH1U/nz2EXrt3c/+gKrvUbxPvDhjdaWgcGMAG5dAC/2fTrZAHHfkDh5LlLEaXBGP0NN
         veIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679030918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JypFrOzIO0MXDs6uCiWRo8IysoMLGN4UV2Agh/hsCgI=;
        b=NgohSOlibC5zoG2/0XVUv1SyepTTHTgORcubXp/+Qvbqg0gBON1Kv3Uu8uflfPGeMw
         6OsmrOOP1bb8DuwZGese4KbKoGd5JvnQ+qvrPEaKlh6zY8WM6xX03d6aQbmp122TWsIv
         1fruBMOI8K2R6LX4Dq2cZlTFkrgRttgjM6jUv/nb0IvzNx0CnrmArQp7yPW5ek9WvNsl
         bG0TxxkfhQ6zrQA0etXa2EyDMOfotVS/5TuxYpQeCBsgjo0K2tqwZ2GsqhcblxDqkkqb
         qscD7xh5em7GABonkYSHb9uUIap/z2KsM517DmCYQeH0G3Kns1PTN377v+OxrGJ7BkIU
         wEaQ==
X-Gm-Message-State: AO0yUKXrrq9zrCEQGGhexeuZpmYiYJUqgI9UTAXpTRvnBvjpMX+m/0pr
        WMKyasNHlfvWmcd+Gwkr20r41BSP9JVPEA==
X-Google-Smtp-Source: AK7set/qV4kZBFHdu3plDFgC2akoAcjWhNM978VMmdTluoccOCbDJz/wAe07qhfhX0Lyqrh7abcD6A==
X-Received: by 2002:a17:903:1111:b0:19e:6c02:801c with SMTP id n17-20020a170903111100b0019e6c02801cmr6256766plh.14.1679030918122;
        Thu, 16 Mar 2023 22:28:38 -0700 (PDT)
Received: from sumitra.com ([14.139.226.12])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902bb8b00b001a06eb43880sm603185pls.153.2023.03.16.22.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:28:37 -0700 (PDT)
Date:   Thu, 16 Mar 2023 22:28:32 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     drv@mailo.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3] Staging: octeon: Fix line ending with '('
Message-ID: <20230317052832.GA83480@sumitra.com>
References: <20230316171614.GA82631@sumitra.com>
 <92ac2441-aa53-41ad-b5b-a12b465bb826@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ac2441-aa53-41ad-b5b-a12b465bb826@inria.fr>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:37:25PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 16 Mar 2023, Sumitra Sharma wrote:
> 
> > Since, the coding-style limit the code within 80 columns per line. This
> > causes splitting the function header into two lines and results the
> > first line ending with a '('. This causes the checkpatch error.
> 
> This should all be in the past tense: limited, caused, resulted, etc.
>

Thank you julia for the help.

Regards,

Sumitra

> julia
> 
> >
> > Place the function parameters immediately after '(' in a single
> > line to align the function header.
> >
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> > v2: Change patch subject and description
> >
> > v3: Change patch description, noted by Deepak R Varma <drv@mailo.com>
> >
> >
> > drivers/staging/octeon/octeon-stubs.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > index 7a02e59e283f..3e7b92cd2e35 100644
> > --- a/drivers/staging/octeon/octeon-stubs.h
> > +++ b/drivers/staging/octeon/octeon-stubs.h
> > @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> >  						  int32_t value)
> >  { }
> >
> > -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> > -	int interface,
> > -	int port)
> > +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
> >  {
> >  	union cvmx_gmxx_rxx_rx_inbnd r;
> >
> > --
> > 2.25.1
> >
> >
> >
