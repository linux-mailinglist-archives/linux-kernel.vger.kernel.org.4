Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5995964A98E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiLLVcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:32:36 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E63899;
        Mon, 12 Dec 2022 13:32:34 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7ACFE1048; Mon, 12 Dec 2022 15:32:33 -0600 (CST)
Date:   Mon, 12 Dec 2022 15:32:33 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] LoadPin: Allow filesystem switch when not enforcing
Message-ID: <20221212213233.GB15511@mail.hallyn.com>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:57:41AM -0800, Kees Cook wrote:
> Hi,
> 
> Right now, LoadPin isn't much use on general purpose distros since modules
> tend to be loaded from multiple filesystems at boot (first initramfs,
> then real rootfs). Allow the potential mount pin to move when enforcement
> is not enabled.
> 
> -Kees

Reviewed-by: Serge Hallyn <serge@hallyn.com>

to the set, thanks.

> 
> Kees Cook (4):
>   LoadPin: Refactor read-only check into a helper
>   LoadPin: Refactor sysctl initialization
>   LoadPin: Move pin reporting cleanly out of locking
>   LoadPin: Allow filesystem switch when not enforcing
> 
>  security/loadpin/loadpin.c | 89 ++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
> 
> -- 
> 2.34.1
