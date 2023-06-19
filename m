Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EA7350FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFSJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjFSJzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2834E4D;
        Mon, 19 Jun 2023 02:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4208F60039;
        Mon, 19 Jun 2023 09:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45961C433C8;
        Mon, 19 Jun 2023 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687168532;
        bh=dg64LBbhZre0iSW1WRzVIezX10Cu3hVtKjbhYw1bhh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IT7zTdQx66k5VWrfdBoDBzmgd+AdrfVwnymhz9V3GnQa36LBeqEEQ53S+TeGVgV0j
         m3iofRtvah4kyDOf0BsB/Uu3XiNzUUjF0hiiqoSE5bnm3/pQOhXoj6UYv4r7JFKkvD
         0lEXqofQZjSLhVsOdJdGXIn+ZYiADCVOkyk1LTUA=
Date:   Mon, 19 Jun 2023 11:55:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <2023061946-latitude-negligent-e4ae@gregkh>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> The Linux Contribution Maturity Model methodology is notionally based on
> the Open source Maturity Model (OMM) which was in turn based on the
> Capability Maturity Model Integration (CMMI).
> 
> According to Petrinja et al., the goal of the OMM was to extend the CMMI
> so as to be useful both for companies and for communities [1][2]. However,
> the Linux Contribution Maturity Model considers only companies and
> businesses.
> 
> This patch addresses this bias as it could hinder collaboration with
> not-for-profit organisations and individuals, which would be a loss to
> any stakeholder.
> 
> Level 5 is amended to remove the invitation to exercise the same bias
> i.e. employees rewarded indirectly by other companies.
> 
> [1] Petrinja, E., Nambakam, R., Sillitti, A.: Introducing the
> OpenSource Maturity Model. In: 2nd Emerging Trends in FLOSS Research
> and Development Workshop at ICSE 2009, Vancouver, BC, Canada (2009)
> 
> [2] Wittmann, M., Nambakam, R.: Qualipso Deliverable A6.D1.6.3
> CMM-like model for OSS.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  Documentation/process/contribution-maturity-model.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/process/contribution-maturity-model.rst b/Documentation/process/contribution-maturity-model.rst
> index b87ab34de22c..863a2e4c22e2 100644
> --- a/Documentation/process/contribution-maturity-model.rst
> +++ b/Documentation/process/contribution-maturity-model.rst
> @@ -62,8 +62,8 @@ Level 3
>  =======
>  
>  * Software Engineers are expected to review patches (including patches
> -  authored by engineers from other companies) as part of their job
> -  responsibilities
> +  authored by contributors from outside of the organization) as part of
> +  their job responsibilities

This is fine, but:

>  * Contributing presentations or papers to Linux-related or academic
>    conferences (such those organized by the Linux Foundation, Usenix,
>    ACM, etc.), are considered part of an engineer’s work.
> @@ -103,7 +103,6 @@ Level 5
>  
>  * Upstream kernel development is considered a formal job position, with
>    at least a third of the engineer’s time spent doing Upstream Work.
> -* Organizations will actively seek out community member feedback as a
> -  factor in official performance reviews.

Why are you removing this?  I write more performance reviews now than I
have have in my life, all for companies that I do NOT work for.  That's
a good thing as it shows these orginizations value the feedback of the
community as a reflection on how well those employees are doing at their
assigned job.  Why are you removing that very valid thing?

>  * Organizations will regularly report internally on the ratio of
> -  Upstream Work to work focused on directly pursuing business goals.
> +  Upstream Work to work focused on directly pursuing the organisation's

This is a good change.

thanks,

greg k-h
