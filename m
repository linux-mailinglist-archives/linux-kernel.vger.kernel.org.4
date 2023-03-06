Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5976AB63E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCFGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCFGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:08:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2B010D8;
        Sun,  5 Mar 2023 22:08:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00AA5B80B6F;
        Mon,  6 Mar 2023 06:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A7AC433D2;
        Mon,  6 Mar 2023 06:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678082919;
        bh=8Jp8UCQPas78u8DZ/4U8fa02zm3CaAUvefFTeXP5s40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZaW1+7PzYnP+W22z+/Et5Bww+5+GN+RNXLYCrgcX9qh1ze7K8c/sHbA6cTHQ5ZE5
         S9VezqX/Qpd8gPLMBjG/ReiF0GABTLMEpqJqucR2RYcr4NS01r/D8TmM2/N1ogqdEZ
         t93Sekzf1MVhLdy+QnnqrJP3TtYqdsWAyTN2Z5ts=
Date:   Mon, 6 Mar 2023 07:08:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 4/7] Documentation/security-bugs: add linux-distros
 and oss-security sections
Message-ID: <ZAWDZdNAIq8yk86Y@kroah.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-5-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230305220010.20895-5-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:00:07PM +0100, Vegard Nossum wrote:
> The existing information about CVE assignment requests and coordinated
> disclosure fits much better in these new sections, since that's what these
> lists are for.
> 
> Keep just a reminder in the security list section.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/process/security-bugs.rst | 92 ++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> index fb156d146c42..2dd6569a7abb 100644
> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -31,6 +31,10 @@ be released without consent from the reporter unless it has already been
>  made public.  Reporters are encouraged to propose patches, participate in the
>  discussions of a fix, and test patches.
>  
> +The security team does not assign CVEs, nor does it require them for reports
> +or fixes.  CVEs may be requested when the issue is reported to the
> +linux-distros list.

Note, this kind of implies that the security team would be the one whom
you request a CVE from.  We can't do that, nor do we ever even want to
deal with that for obvious reasons.  Also, who is to say that CVEs are
even anything anyone should be messing with in the first place given how
much they are abused and irrelevant most of the time?

So I would just keep a big "The kernel developer community does not deal
with CVEs at all.  If you want one for your résumé/CV, please contact
MITRE directly at your own risk." type of warning in the document and
leave it at that.

thanks,

greg k-h
