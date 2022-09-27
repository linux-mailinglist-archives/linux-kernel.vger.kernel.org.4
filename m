Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59605EC94F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiI0QVe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI0QVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:21:31 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115AACBAC4;
        Tue, 27 Sep 2022 09:21:30 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 969E240DFA;
        Tue, 27 Sep 2022 16:21:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id A3D7B20027;
        Tue, 27 Sep 2022 16:21:20 +0000 (UTC)
Message-ID: <69264558dc554c45a78bb1400c28ca62d1020302.camel@perches.com>
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        David Vernet <void@manifault.com>
Date:   Tue, 27 Sep 2022 09:21:26 -0700
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
References: <20220927160559.97154-1-corbet@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A3D7B20027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: t8xkp64wu1qnmdhnp7pxoeh1e1tq8qx3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/041yyABnfCORCQC0nD9VStxdySrQuses=
X-HE-Tag: 1664295680-533016
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-27 at 10:05 -0600, Jonathan Corbet wrote:
> The top-level index.rst file is the entry point for the kernel's
> documentation, especially for readers of the HTML output.  It is currently
> a mess containing everything we thought to throw in there.  Firefox says it
> would require 26 pages of paper to print it.  That is not a user-friendly
> introduction.
> 
> This series aims to improve our documentation entry point with a focus on
> rewriting index.rst.  The result is, IMO, simpler and more approachable.
> For anybody who wants to see the rendered results without building the
> docs, have a look at:
> 
>   https://static.lwn.net/kerneldoc/

Seems better and sensible enough for now, thanks.

