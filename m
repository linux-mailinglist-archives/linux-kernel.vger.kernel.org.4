Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A5738EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjFUShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFUSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:36:59 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406410A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:36:57 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f87592ecaeso4942963e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372616; x=1689964616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a74KK9B3kOJ1bdQv09F1RuG2I+RUQYHb83xPvRjEsmI=;
        b=i+Zkrk4T1FXFP00P7dc5bUrBO9YvPIwMk8JYGA7F87ZxraaARTB0H8SykBGzY58zVQ
         p1cl7UhhGM9nlEYkQIqfEvf15aUQOmCJdURn+K2ZdaXVPll5b+F93f/6QjOCJuoFo/BQ
         zWMctqNaGRhxomy5yk5RzbKJJE9derc/kiTwBfymdLXsxyV46tFMfKHzHOmSQoo4aa3Z
         Xf/iFiAjM2KkPY3mQ5mbc8jJC1lZ2vDlqi646p7hGpI1JWp5x3/bFP9pOchaRRERnfAe
         dOZETs6AOEducKtTgX/LCvwOmHE4US4rwx/xW/fKFVOIAFSTIL+hop1owzsVYeciKaHP
         0Jfw==
X-Gm-Message-State: AC+VfDw77IL2HAw7My4oXb+kU1JyXF7dA6bVYDpq2Wgujb1pURToC+0l
        AtvavJEGYVrvxHIg/LR412Y=
X-Google-Smtp-Source: ACHHUZ5DDD0SzUrhoGXAR4gTtOCW/ZxlMtZE1wbMTz82ecYfHsPsLwBBPjiVs3jtJIo3LsB1zP7zwg==
X-Received: by 2002:a05:6512:54a:b0:4f4:cacb:4b4b with SMTP id h10-20020a056512054a00b004f4cacb4b4bmr10070190lfl.18.1687372615691;
        Wed, 21 Jun 2023 11:36:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600011c800b00311339f5b06sm5068900wrx.57.2023.06.21.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:36:55 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:36:53 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <ZJNDRSUZuZ2L+pwo@gmail.com>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621173135.wiprtgzslhw5z5or@desk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:31:35AM -0700, Pawan Gupta wrote:
> On Wed, Jun 21, 2023 at 08:54:17AM -0700, Breno Leitao wrote:
> > On Tue, Jun 20, 2023 at 05:13:27PM -0700, Pawan Gupta wrote:
> > > On Fri, Jun 16, 2023 at 09:48:50AM -0700, Breno Leitao wrote:
> > > > There is no way to disable MDS, TAA, MMIO Stale data mitigation today at
> > > > compilation time. These mitigations are enabled even if
> > > > CONFIG_SPECULATION_MITIGATIONS is unset.
> > > > 
> > > > Create a new KCONFIG option for each mitigation under
> > > > CONFIG_SPECULATION_MITIGATIONS that allows these
> > > > mitigations to be disabled by default at compilation time.
> > > 
> > > I don't think all mitigations are still controllable at build-time e.g.
> > > spectre_v2 eIBRS mitigation will still be deployed irrespective of the
> > > config.
> > 
> > Right. This patchset only cares about MDS, TAA and MMIO. I am more than
> > happy to send a new patch to also disable spectre_v2 eIBRS.
> 
> What about Retbleed, L1TF, SRBDS etc? I thought the goal is to control
> all speculation mitigations?
> 
> To be consistent CONFIG_SPECULATION_MITIGATIONS should control all
> speculation mitigations.

If I understand where you want to go, you think we should create a
single patchset that creates a CONFIG_<MITIGATION> for each mitigation,
and move get it under CONFIG_SPECULATION_MITIGATIONS.

Is this what you think we should do?

Thanks!
