Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E510C5F71EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiJFXiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiJFXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:37:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED21142FE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:37:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z20so3059568plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6w++0UYRYYRcY+xx88ScArCTi1ipokn2/JlIBlSrGmg=;
        b=I2sser8aNPvcfMiVuDPWGoxmgCp7DUUWz+lY5XubZaSgKyPyJO7lKNPi+YrtKb6In+
         MY72dEXIA0tlPsd3/FejBOJQaWzxggqqmaaBikFpwR/LDI8rCiTlzWI0RBrhUSGzz6kT
         nt6sBegoG/UXYUwCbj5bTLCJlXzpFnFLO3AqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6w++0UYRYYRcY+xx88ScArCTi1ipokn2/JlIBlSrGmg=;
        b=1+Pg/vbCmzzR16vmMs+1vzK/L3aDMPnCpmeN0FbX1YZjB1TNIGodMsetQqCwEDmTCd
         ciatakb1G8Ue/9rV4cnQbV5Ekp5IqhR8K/w6zncUhVHL1V7VnP0XEbjvm/PaQBthbbIm
         drf7XFDZuJGt6nJCcRD6rXScbzHm+Ifx+n23hIfVmLsusCvqqAwWCObJdYjpEyiiF5UM
         uZkZ4MVVMIpzytd8jJV0etMSuGbPR2pDVSn2HNO72Cwur3kPTDeTfMuJ5HTn9wk1A4Xr
         SnSoUFbAhJl39BrCjOd9Jo9qyRuz1BCCRcfAdEnT9DJFt46zefTI0eKQNM4EM/kEk4Lj
         xMCg==
X-Gm-Message-State: ACrzQf2NuUUGqPhQ6A/FQz3xi8NJasDAsaE5PE1kEcOtIXkFCqzAHJCr
        NoI7grm2Z2vT9H6wokbKq0mcpg==
X-Google-Smtp-Source: AMsMyM4kDL5a/Dlffn01IBeDnGXhq0ef/rGYfpdZb7ToB+kR3GWSyeZrgAkAjBhjrLrJaZuY+1T3qg==
X-Received: by 2002:a17:903:3113:b0:17f:6846:6266 with SMTP id w19-20020a170903311300b0017f68466266mr1891369plc.150.1665099461056;
        Thu, 06 Oct 2022 16:37:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b203-20020a621bd4000000b0056186e8b29esm180665pfb.96.2022.10.06.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:37:40 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:37:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Message-ID: <202210061637.8C09C55@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
 <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:29:02PM +0000, Luck, Tony wrote:
> > Tony, I see your recent responses, but if you'd rather not be bothered
> > by pstore stuff any more, please let me know. :)
> 
> Kees,
> 
> Occasionally something catches my eye ... but in general I'm not looking at
> pstore patches. You can drop me from the MAINTAINERS file.

Do you mind if I leave you? It's nice to have extra eyes on it when it
does happen! :)

-- 
Kees Cook
