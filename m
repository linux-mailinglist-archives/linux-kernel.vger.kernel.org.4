Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C56E131E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDMRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDMRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:05:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA056592;
        Thu, 13 Apr 2023 10:04:51 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.232]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKsf5-1q3qmO31kz-00LIxD; Thu, 13 Apr 2023 19:03:25 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 476813C0EE; Thu, 13 Apr 2023 19:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1681405402; bh=prF/9k2Xus4Gm9F26joQ49+N2+VxW+Wm+lPAuwRp3dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWQ6fAU3wvVnrinGJLkjxvqSon1S0SVzZW5AcGXighRgxgZiYYmHDiL2A1IkifD+o
         hsuVrD+WosyjaO2AwMJcNqGA0EnoQHvB0nCqQFQ5+cJzBjnAHRzTVnZwXj474Y6r97
         785SyyD1yi+ohEHMz1L7R5JktSQEAIUsNBk+VsJs=
Date:   Thu, 13 Apr 2023 19:03:22 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <ZDg12nC0XGx6ZdRX@fjasle.eu>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
X-Provags-ID: V03:K1:bO1rw56I77aHqH/VCK3YAqnRlsHmHlJPegGsTHf6wVQeF9YdNeJ
 BX3WJOp72K1UoDLThrwGftGd8Tou6vI7+bFnsDkSM4a0cjjzr5bUQwvX/Qa0dLBZwd+I9Q1
 AbVv5/6hFwpVX5/Onm0auumhAvtx6eYUlwrhEcx2meg3ZxNOmmE3dRq6t0bH3Z40+sKBWu0
 oeR7zTDfws8wScvscxvjg==
UI-OutboundReport: notjunk:1;M01:P0:fa520UNgWXc=;8FOl1iK4C45pcNI0FlwShKu27eu
 AR1PbR3UET4azRwIN69vPZrhsdhu/TboQH3jYuaixatTTKsxsrw/KY/3J7YiT4nHQ7ouKLeTK
 o2aMGIsgAYtWIok8YtDmPzzuOKvoZjiTFGVEI0/lEXk+WxlnkSr9BmsrrsdmLpCCjfcpXHvvT
 L5rpnFig3FIO45uSJR9CBcDPqtSP2lTtXuyMXRT9PMfaxGeQntIvINiDxp0R2u0EzPWrMiCi9
 TJ8vxu2Y5CUsnksiErOdqLZqjGcs0kbiEdeMTx/zkzNQwjDIvTiesy7oXB4RBNeewiTRAOAAE
 udl9PC2nzs2B2OrjKu1YwuKQDKk80xKquTAzSPkAvCgclMqCGvoNBDjq5iZC3FVfJRkMGwxVR
 GuMpQO54FfgpkfmYqf1x7WNZAdxdUgcNgN4UDE4eXLRAklz/2mN+fyTq0j2ZQZgn2RdGMWzo0
 eEFiiZX+C7oqD7pHmBbf8kevY7dEagD+h9Hawg7oo2SCxzAPaSUD5O9OhCs414C4OYXvQUWvl
 x5u2TbyCwDQ7Ru7JNZFxZ/wKPt97lr+C8HVl0jciEHjA020Gs9yx8IWUnplQHUjpSQwQa4HpD
 +eVlfQMFgpYS9ifiBoFhPFm0ud7IcanC/flGF9ZVLh6gR2sEWMf+CsBIwxYMe4HvXz59QsavW
 ppf6tgPmY+MiGlqWXVean94SHi4S+PxUJ2gKsT4DUQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:03:05PM +0900 Masahiro Yamada wrote:
[...]
> [2] Be careful!
> 
> 
> While testing the patch submissions of this,
> I messed up my repository multiple times.
> 
> The script takes some time because it builds many objects
> internally.
> 
> However, once this script starts running, you must not hit Ctrl-C.
> If you do it, your repository will be sprinkled with a ton
> of untracked files.
> 
> Apply this patch, and run "./scripts/check-uapi.sh -p v6.0"
> and hit Ctrl-C.
> 
> Repeat it a couple of times, and "git status" will show you
> something horrible.
> 
> 
> You will never know when git is checking out a commit
> because this script hides it by 'git checkout --quiet'.
> 
> 
> So, this tool should show a caveat at least.
> 
> 
> 'git checkout' should not be hidden, or
> maybe a caveat message should be shown.
> 
> 
> CAVEAT
> This tool runs 'git checkout' a couple of times internally.
> If you interrupt it, your worktree might be messed up.

John, did you consider using git export for obtaining a source tree that
can be used for headers_install and the following comparison, instead of
git stash+checkout?  AFACS the script does not depend on any other git
functionality than providing a specific version of the source tree.  I am
pretty sure that leaving the original working copy in its original state
is supporting the script's popularity.

Kind regards,
Nicolas

