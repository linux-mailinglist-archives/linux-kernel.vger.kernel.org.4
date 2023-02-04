Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45D68A7B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjBDB5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBDB5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:57:07 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8175CFFF;
        Fri,  3 Feb 2023 17:57:02 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so1900913oty.7;
        Fri, 03 Feb 2023 17:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTTmY033OeRGN/EKD8JFUB8h9jNEfxU+2QET99S9mlI=;
        b=bb5cjbuP/IY7c/Ps78H61Np25tv0ppeortD9RHwREmVHfmCEBoFO3hH6l5644CSc3J
         kDAUhd/RJTaNjlwsaUN+K8Eht8VmTMs/e8yhHXppPqyCAsTBrog3TqjF31AZMzafVQmV
         leCfF0OymiRUkhCqPL6rTF7bNQ0ePGuN/uQv6LX3p6rT+lgYENUeqTUn4rnxQYDn2c9L
         xujiZo9HXkjxqEPrI+46OCJ7+VZAsTsapIpDiayit5mcrFD39Uh0LsV0c/hrOIM+5aNv
         IjWQMarMT/G78SdIaKbmrQfA6SN49vfQ5fyF/3bs07ERb53Bz7JLHpBVcpwgVPLOjHj5
         BBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTTmY033OeRGN/EKD8JFUB8h9jNEfxU+2QET99S9mlI=;
        b=h1VsTvmIo2mNnZHcH54IREH7f0QRU0J9NsIkbEJuL9p+wDjs7F3MMU8RGJUj0PH8mz
         wGZQc3p92UnlNFITpuMVRCLqGaPvtZ80hOCpE7qYS0jql6tMfqgxinVQ9TOMrrFzh5eo
         k42FFHNHaJf4GeDgTXzy+MCg30WK6XTVYjR1OHAoRwVS8uTsTAhN4YMxcoTo6iQDLiIm
         8BeYnK5eenunjGW5kjFtOiHEvcm9MWxDpIgBPUG2QV9/a0oD11EVrETOK8clBefOjFR0
         li9MKG4+AhBv+azQ8vfId/2pwUb+8hgXQNyIps3Ql+TxaDvOp9GAoHfLZ40KaTtPswxH
         KE8g==
X-Gm-Message-State: AO0yUKVeS/8nIfDmzoVEPpXImNDs268P2mpg8ObJR0TUusMJIYcuMtyQ
        7HufbQ8Ru8WxpyHPfrYqqaksUzY+MUM=
X-Google-Smtp-Source: AK7set/kagwYDFeLn55TK/ylCxSECoRZOrtcUxrHcJODjUAVydjW7jtWfMkRwLeo5yK393/NqwEYyA==
X-Received: by 2002:a9d:3e06:0:b0:68d:597d:84b1 with SMTP id a6-20020a9d3e06000000b0068d597d84b1mr3502229otd.28.1675475821608;
        Fri, 03 Feb 2023 17:57:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o33-20020a0568301c6100b006864c8043e0sm1807575otg.61.2023.02.03.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 17:57:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Feb 2023 17:57:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lm85: Bounds check to_sensor_dev_attr()->index usage
Message-ID: <20230204015700.GG3089769@roeck-us.net>
References: <20230127223744.never.113-kees@kernel.org>
 <20230128131319.GA4173006@roeck-us.net>
 <63dd8c1a.170a0220.d3456.3451@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63dd8c1a.170a0220.d3456.3451@mx.google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:35:05PM +0000, Kees Cook wrote:
> On Sat, Jan 28, 2023 at 05:13:19AM -0800, Guenter Roeck wrote:
> > On Fri, Jan 27, 2023 at 02:37:45PM -0800, Kees Cook wrote:
> > > The index into various register arrays was not bounds checked. Add
> > > checking. Seen under GCC 13:
> > > 
> > > drivers/hwmon/lm85.c: In function 'pwm_auto_pwm_minctl_store':
> > > drivers/hwmon/lm85.c:1110:26: warning: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Warray-bounds=]
> > >  1110 |         if (data->autofan[nr].min_off)
> > >       |             ~~~~~~~~~~~~~^~~~
> > > drivers/hwmon/lm85.c:317:29: note: while referencing 'autofan'
> > >   317 |         struct lm85_autofan autofan[3];
> > >       |                             ^~~~~~~
> > > 
> > 
> > This is a false positive. The value can never be >= 3.
> > It is derived from the last value of the following
> > SENSOR_DEVICE_ATTR_RW() entries.
> > 
> > I resist making changes like this to the code just because
> > the compiler can not determine the range of a variable.
> > It blows up code size amd makes it hard to read just to
> > make the compiler happy.
> 
> I think it's worth it given the index is an "int" and it'd be very easy
> for things to go wrong in the face of other memory corruption, etc. I've
> sent a v2 that I think is much more readable and non-invasive but
> provides similar robustness.
> 

That line of argument would suggest that we should perform parameter checks
on each function entry all over the place, no matter if the range is known
to be valid or not. Maybe that is the way things are going, but I don't
like it at all. I have seen that kind of code before, in the telco space,
where it typically at least doubled code size and resulted in mediocre
performance, just because of a rule that mandated checking all parameters
at the beginning of each function.

I assume this is just one of many many patches you plan to send to add
parameter checks to similar hwmon code ? I _really_ don't want to have
the hwmon code cluttered with such unnecessary checks.

Guenter
