Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD55F5D68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJEX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEX5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:57:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC71D13F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:57:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x59so605525ede.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aEfEliKsuauHqKdKxHLW94n4jylnSfwinxLKm0znj80=;
        b=eZHoNR9QM8zqCFZEkkIK6CEYP3UvO4RG4LCukozoU4VwLH4Ur2Mt3UHVTW9u9RsiUH
         UUyC2SRPvE4oekShfuFO0KEr7p+6Eq0+PFf/gdD3j2H/OYzRwYAlqlqYLX6h4iBGhvZI
         uld/HMXHvk7zAi9IHfZZWZYcBw87folqCnP4OQmrbiFt/iEMZAQoy8rPQY1lCQcRbiJ2
         bZDKJhAsJyG0oRNl1yKtFzHs6/9/1l17DOw8eGYWGFp7/5i+nLGjF+/WCM0JQgh4jCVe
         4mVkTRwIyotUNaFV214rYRNMmrfRA/D8cRvt8dEni8gobB00Y96HflLssHhEEQZcMX5r
         pzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aEfEliKsuauHqKdKxHLW94n4jylnSfwinxLKm0znj80=;
        b=fQ1NYBlKL/rimnCnh2208Ck8K87SbYvZeQs3ykwhoWFFVsFzv/QrwOLoSjPCByQ8xG
         7R/uhqi9F27N4W0nsTJc2TyOSBDv4jdDaqDof0fiJbVxkM1N4UJ1AOZVQFGGC2nXlYeV
         yeaHsQwz+ex8cf2qaoQ4Lyxlx7Ao0n+DKrwvL3CyMOVFaD/beQllD8aL6XWLUgJM2Gpm
         Y/y/8gyDD9kF/X0sfZyBtr1H+aJYwubj1sz5DkfwlKXwJ3cSV45UrNCeonb26mgxDsMf
         kMDUYf0Y8FTBICR1xNW4GCgIUyrICql/cK+kpibL1RWR/vc1v2rc69Fwhw9pYgIMuxj1
         96bw==
X-Gm-Message-State: ACrzQf1cP9acopb1upbdFqMswoE6QB6iNCJG/TdYNK7kI+ldcunKRplK
        Vrqbs3kOyzCxaKVUmqs8NW4=
X-Google-Smtp-Source: AMsMyM59fRhAVfuLlqqfBsq+sSCqEj3R7DAkNeGkv5SxOuS3qiZQj6bSfe90oMKmAJ9iidqs4rZEqg==
X-Received: by 2002:a05:6402:40cf:b0:459:d7de:d5 with SMTP id z15-20020a05640240cf00b00459d7de00d5mr600496edb.288.1665014265007;
        Wed, 05 Oct 2022 16:57:45 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b00730b3bdd8d7sm9463175eje.179.2022.10.05.16.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 16:57:44 -0700 (PDT)
Date:   Thu, 6 Oct 2022 01:57:28 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Brent Pappas <pappasbrent@Knights.ucf.edu>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Message-ID: <20221005235728.GA118549@nam-dell>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:10:44PM +0000, Brent Pappas wrote:
> Replace function-like macros "HB" and "LB" with static inline functions
> to comply with preferred Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>
> ---
> diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
> index 1d1fe8bff7ee..8a8fbc274b73 100644
> --- a/drivers/staging/most/net/net.c
> +++ b/drivers/staging/most/net/net.c
> @@ -36,8 +36,8 @@
>  #define PMS_TELID_MASK         0x0F
>  #define PMS_TELID_SHIFT                4
>  
> -#define HB(value)              ((u8)((u16)(value) >> 8))
> -#define LB(value)              ((u8)(value))
> +static inline u8 HB(unsigned int value)                { return ((u8)((u16)(value) >> 8)); }
> +static inline u8 LB(unsigned int value)                { return ((u8)(value)); }
>  
>  #define EXTRACT_BIT_SET(bitset_name, value) \
>         (((value) >> bitset_name##_SHIFT) & bitset_name##_MASK)

I cannot apply your patch. I think your email client modified some
whitespace characters.

Check this for more information:
https://www.kernel.org/doc/html/v4.10/process/email-clients.html

Best regards,
Nam
