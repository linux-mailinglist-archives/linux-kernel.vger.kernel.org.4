Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDB607BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJUQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:13:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50506241B01
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:13:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k9so2757772pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRcCA+5xknaIw0oVE/LCld7bURKOPX8fuup0u7sV01I=;
        b=nGhz4uL2FlpW+2qKaaVqqONDhMf3mWlt0Lf/r4bWcTUH+m0huCqWKbCR4vJq8SGTNM
         bCHL+9g17wqPsbCznSOQN/828m/mh1ws+NLX3TKsDxmOMV9WuXobKYaCber7c483bQL8
         W0I7cFBcWd+kD3ifGklrmxeUBoDJ7E1YrLRYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRcCA+5xknaIw0oVE/LCld7bURKOPX8fuup0u7sV01I=;
        b=7TM6oyJGzVKP+RaMAHQn0IzY+xp8gI8MEAsY+mOtA8FilseZX0uMKlwSzIo3fHwf2b
         yQ+lovzY56Z/EFvR3A9Vxt/nrMwupLYh1/guSt9SHF7TL9C2YuaZvxuyI3QJ2oGwQMJZ
         cp/QgENjhz6ifqjzMsAcz0ap0gKq9ik6al8GVEpFShGT4Ml4yJB60u8yIgNzuvbUca6N
         W5XLfXcMeDPHGpdFTRdVbP1cPKSSoihVDx0GiPc+FrWVpx/AOYtkSqtJix+wpi+cSLH7
         s5ByNEK11XRqpbeHYLhUtCaPLgj3JKxAVdVD3UpGuvJ2CO3sZ4ht+5Jrgix8fZc+hY6r
         zvpg==
X-Gm-Message-State: ACrzQf3MNT2Y3AUg/9EkDI+XYnN9ZS84ZeYylIm/G96a0Az3uHEamsNY
        z2gAfDa7EyhpvB4x4AChqHEi8Q==
X-Google-Smtp-Source: AMsMyM74D9XTVDNnNdcogrVBFjPfuYyInNjCVCouu44cKdwQZRhllLmJvP00FcyQ/bx4PXgj2WI2Yw==
X-Received: by 2002:a17:902:e552:b0:179:e796:b432 with SMTP id n18-20020a170902e55200b00179e796b432mr19532013plf.21.1666368810845;
        Fri, 21 Oct 2022 09:13:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79e12000000b0056246403534sm15443919pfq.88.2022.10.21.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:13:30 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:13:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: {standard input}:24403: Error: Insn slot not set in unwind
 record.
Message-ID: <202210210913.11F9095@keescook>
References: <202210211348.RQ11yRji-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210211348.RQ11yRji-lkp@intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:32:16PM +0800, kernel test robot wrote:
> Hi Kees,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   aae703b02f92bde9264366c545e87cec451de471
> commit: a82adfd5c7cb4b8bb37ef439aed954f9972bb618 hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
> date:   1 year, 3 months ago
> config: ia64-randconfig-r024-20221020
> compiler: ia64-linux-gcc (GCC) 12.1.0

This feature isn't supported on ia64 -- I don't see how this commit
could be causing the warnings.

-- 
Kees Cook
