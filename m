Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DB625F57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiKKQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKKQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:22:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089D7343D;
        Fri, 11 Nov 2022 08:22:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h24so2915694qta.9;
        Fri, 11 Nov 2022 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Hb3/hz4ZzQFtFyUltakQHofgYH8Pt984+VvX+J+nGo=;
        b=A28c4bWexQFtshv9I2DytoSyfJp61wPx6M+Ygs8gmNkKyjKN69nuFJV+lUs5osTF5c
         2PhWrfa2lx35KMIZXAu2pkVi6iyQ3tJR5p1DD9ceIU3InsqoqJE/KMNtuNl0NL+lVSFy
         1XQM7tlGSmxnRPlJC7BZ2aefo7OcEr/BLHGZTY4B0a7p0SypC3cT4bkBWVrYNGhuygYw
         sAtu2x3sBGN67FJEdqzqzxaRH7g9LrHudW816fIa319ClyyGho60M55rQuLMppqlLDNr
         rBnKW6TPQ/FNdXlW46g7XR3L1daNkaZpuU3RNSmuiQkw/pAOn1k0oEfS8mqMZ7RD6T6R
         Yx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Hb3/hz4ZzQFtFyUltakQHofgYH8Pt984+VvX+J+nGo=;
        b=z2LaWrSovb1V248asUILf0yPC1XR+xVQdG1IUmpfnVnQOLWWSOGs2Ed73EIXqW0s3i
         ejWFCj34B4mciytXkG+dBwlD1CJI1jbmprYdEhr7Ex3OHHX68oQHAfSzWAEz23+Yk5/m
         y54GF7aUhAGIHUwgMUj586Ts2o2M30shctslDdCOxNxUhtRRUfkVWr3kLmtsWUgMV0kg
         W7yA0OMrF8nCZnrUsJPjBCrhga49Dy/CjKNdR1I1NLbdBzovnEiN3d/PUohh2RbhhZwY
         Jnmg9fvYvBtuFb3yfwR5A7M1hYwDvz3CwRQsOplPE7Hg5SeOWXbw/SFpjeQc5fWdidIL
         Bqrg==
X-Gm-Message-State: ANoB5pkvCUsPanNC2iudqouR02PROAIBzjFnbHxLQKR7RinCPturhG4A
        5cXfKGyAZaCBuTGPRqE8olc=
X-Google-Smtp-Source: AA0mqf5MxRfM/Jnp92/6HGygTm13qVdF9gbceKqcBv/cRygi35xYBmDktU+5ftidZ0854goIf9XRpQ==
X-Received: by 2002:a05:622a:4110:b0:39c:bfcf:ebb1 with SMTP id cc16-20020a05622a411000b0039cbfcfebb1mr1934580qtb.53.1668183766050;
        Fri, 11 Nov 2022 08:22:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020ae9c109000000b006ce76811a07sm1587285qki.75.2022.11.11.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:22:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 11 Nov 2022 08:22:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Clear up macros and comments
Message-ID: <20221111162244.GA231145@roeck-us.net>
References: <20221107142455.655998-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107142455.655998-1-savicaleksa83@gmail.com>
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

On Mon, Nov 07, 2022 at 03:24:55PM +0100, Aleksa Savic wrote:
> Reorganize macro definitions into sections for each supported
> device, with additional comments on their purpose. This should
> make it easier to follow what report each offset is coming
> from. Also, reformat per-device initializations in
> aqc_probe() to organize them into sections (fan info,
> temp sensors, other parameters and lastly labels).
> 
> No functional changes.
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
