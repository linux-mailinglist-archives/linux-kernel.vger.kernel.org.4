Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9295F5FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJFDdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJFDdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:33:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AAD32D8A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:33:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w2so954805pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZypkVBAfHrcA/Q7sSlWkb2baVWptvt05qyCXewMKrP0=;
        b=U3l7YpOiSN786nYy0F9iSrz+hms78emMHJEPHqw+qH86Y3ERnk/oCwlGIb6931XUfZ
         EILzvtLuMzHwgczzgLCq4xw7VVRFXXAagTcue8Azr4iIW3vQkLYGZ3mV/0qkaB3ROo6M
         qX2stFubLKxqDP0/ygDh9pxpZsdS9T9V6NfVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZypkVBAfHrcA/Q7sSlWkb2baVWptvt05qyCXewMKrP0=;
        b=xwAE6aHir4yxuZP7B3aoph8vyFMW3JCCUjy/Rs+nwmG+9ufRstYEoic9Lio4tGnFRY
         7JzobEYKdIF93+V0UtESGwtEBBHopuWM1QjplnFnDM2EkGjcdcE8pTC6SiLDpzxecj17
         nSMGO1Waum9tT29MsmZ3ERGGWl2Te4r0RAMfAhdWCh/Bkr0dtQDN65OGS5rIROa82gxc
         78yXbxLsKcRHQ5oKo9vM1KfJU0MoXMSmpvIUEIRejy0m9WyHJFXRMVNVjnT/GectAbgL
         kqZvAd/ew0hb5rRZ2hiJXBHxO8lXNejQ2dmtbBHDz9CvbITrXJErFvPml+laZPEJkJNI
         RWjQ==
X-Gm-Message-State: ACrzQf1nDk7LXvWCv3i1SZszc5c2WcE8bcRwV35vPkX8GZ0ysjJz8BvE
        oK1ZmzRgLqSNswJvOXRXS4tlGQ==
X-Google-Smtp-Source: AMsMyM5+X9z/N0UJJBkNIt6LdSKo9m/imecvK6N8D5Wh8pmEJA8aA7XN9izphrY3SWUME6vP22PzyQ==
X-Received: by 2002:a63:205a:0:b0:44e:d36e:4c4d with SMTP id r26-20020a63205a000000b0044ed36e4c4dmr2635759pgm.536.1665027189663;
        Wed, 05 Oct 2022 20:33:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902eb8e00b0017f7f8bb718sm1858696plg.232.2022.10.05.20.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 20:33:08 -0700 (PDT)
Date:   Wed, 5 Oct 2022 20:33:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF uapi: add spaces before '{'
Message-ID: <202210052030.6B472DFCB5@keescook>
References: <11563980.Ss37MnutNL@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11563980.Ss37MnutNL@mobilepool36.emlix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:25:40PM +0200, Rolf Eike Beer wrote:
> When searching for a struct definition I often enough end up simply doing
> 
>   git grep 'struct foobar {'
> 
> Sadly some of the ELF structs did not follow the usual coding style so they
> were invisible.

Thanks! Yes, I do the same. :)

I'll get this into -next after the merge window closes.

-Kees

-- 
Kees Cook
