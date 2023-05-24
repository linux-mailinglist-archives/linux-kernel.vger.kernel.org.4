Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF470F7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEXNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEXNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:38:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20AAA;
        Wed, 24 May 2023 06:38:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82F0E21FE4;
        Wed, 24 May 2023 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684935517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9PpiufmZYzleg+TlrTh557lZlXDEM/AsL/PhNB0ois=;
        b=b+R628QlRTNsSzyUC35Lh1Knve1z2zY9IzRDNTMeINWO8KcOzZ3/0LdvMfmwhO3yUgN9u0
        3NjN78LPfVkSTa/C8qWoZJEhRh0s7kTbxRKhntcnuX12jzeNk1N45LuX7TCP5yoMvJy4ij
        lnbnezv8q8w8QHqxzgg76qOTb5SCv3E=
Received: from suse.cz (dhcp129.suse.cz [10.100.51.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F3BE2C141;
        Wed, 24 May 2023 13:38:36 +0000 (UTC)
Date:   Wed, 24 May 2023 15:38:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/18] watchdog/hardlockup: Rename some "NMI watchdog"
 constants/function
Message-ID: <ZG4TW--j-DdSsUO6@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.12.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.12.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:36, Douglas Anderson wrote:
> Do a search and replace of:
> - NMI_WATCHDOG_ENABLED => WATCHDOG_HARDLOCKUP_ENABLED
> - SOFT_WATCHDOG_ENABLED => WATCHDOG_SOFTOCKUP_ENABLED
> - watchdog_nmi_ => watchdog_hardlockup_
> - nmi_watchdog_available => watchdog_hardlockup_available
> - nmi_watchdog_user_enabled => watchdog_hardlockup_user_enabled
> - soft_watchdog_user_enabled => watchdog_softlockup_user_enabled
> - NMI_WATCHDOG_DEFAULT => WATCHDOG_HARDLOCKUP_DEFAULT
> 
> Then update a few comments near where names were changed.
> 
> This is specifically to make it less confusing when we want to
> introduce the buddy hardlockup detector, which isn't using NMIs. As
> part of this, we sanitized a few names for consistency.
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -30,17 +30,17 @@
>  static DEFINE_MUTEX(watchdog_mutex);
>  
>  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
> -# define NMI_WATCHDOG_DEFAULT	1
> +# define WATCHDOG_HARDLOCKUP_DEFAULT	1
>  #else
> -# define NMI_WATCHDOG_DEFAULT	0
> +# define WATCHDOG_HARDLOCKUP_DEFAULT	0
>  #endif
>  
>  unsigned long __read_mostly watchdog_enabled;
>  int __read_mostly watchdog_user_enabled = 1;
> -int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
> -int __read_mostly soft_watchdog_user_enabled = 1;
> +int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
> +int __read_mostly watchdog_softlockup_user_enabled = 1;

I still see nmi_watchdog_user_enabled and soft_watchdog_user_enabled
in include/linux/nmi.h. They are declared there and also mentioned
in a comment.

It seems that they do not actually need to be declared there.
I guess that it was need for the /proc stuff. But it was
moved into kernel/watchdog.c by the commit commit dd0693fdf054f2ed37
("watchdog: move watchdog sysctl interface to watchdog.c").

>  int __read_mostly watchdog_thresh = 10;
> -static int __read_mostly nmi_watchdog_available;
> +static int __read_mostly watchdog_hardlockup_available;
>  
>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);

Otherwise, I like the changes.

With the following:

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 83076bf70ce8..d14fe345eae9 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -17,8 +17,6 @@ void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
 
 extern int watchdog_user_enabled;
-extern int nmi_watchdog_user_enabled;
-extern int soft_watchdog_user_enabled;
 extern int watchdog_thresh;
 extern unsigned long watchdog_enabled;
 
@@ -68,8 +66,8 @@ static inline void reset_hung_task_detector(void) { }
  * 'watchdog_enabled' variable. Each lockup detector has its dedicated bit -
  * bit 0 for the hard lockup detector and bit 1 for the soft lockup detector.
  *
- * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
- * 'soft_watchdog_user_enabled' are variables that are only used as an
+ * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
+ * 'watchdog_softlockup_user_enabled' are variables that are only used as an
  * 'interface' between the parameters in /proc/sys/kernel and the internal
  * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
  * handled differently because its value is not boolean, and the lockup

Reviewed-by: Petr Mladek <pmladek@suse.com>

Even better might be to remove the unused declaration in a separate
patch. I think that more declarations are not needed after moving
the /proc stuff into kernel/watchdog.c.

But it might also be fixed later.

Best Regards,
Petr
