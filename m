Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201C6514C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiLSVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLSVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:23:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2413E88;
        Mon, 19 Dec 2022 13:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJEjs4w9RjAuPcUp9a/5NnXUH1nF7wn+b5FOQZwXA1Q=; b=LEuNWkwuc2mG5+GKr6t5jDyWM8
        a1Q4ERvpvwn9nUW3OzpputaUlwdvMhqPtQDxTGyMLijmcCoXb9ptMkWgFgXADoy5hOr/ya5Jjf6P7
        S6jMm95LX0QasaS4uQQ32nxnAPpZU4OiE02ukOuzCxpZMNkQW04e1+vVpOSWJSaEFTfk1c6hmBIvI
        JVH9G27hSI1j1v2T231XGRzIM/7CGYIUgP0jLrDTb3NoiAWLZ6N3a+fZtk1nxXjc7jtILZVNmMKdm
        7pwnzSvDWaJHJqdxn4BxbYXObFdefeTTccAuPnW6C6kYrIZH6jrq9vYT45jav5lcWJKyEMNJAbs8h
        YSqG9CeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7Nc0-003uYz-B4; Mon, 19 Dec 2022 21:23:52 +0000
Date:   Mon, 19 Dec 2022 13:23:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 10/10] docs: Include modules.builtin.alias
Message-ID: <Y6DWaODE5F9x+Qq1@bombadil.infradead.org>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-11-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219204619.2205248-11-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:46:18PM -0600, Allen Webb wrote:
> Update the documentation to include the presense and use case of
> modules.builtin.alias.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  Documentation/kbuild/kbuild.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 08f575e6236c..1c7c02040a54 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -17,6 +17,12 @@ modules.builtin
>  This file lists all modules that are built into the kernel. This is used
>  by modprobe to not fail when trying to load something builtin.
>  
> +modules.builtin.alias
> +---------------------
> +This file lists all match-id based aliases for modules built into the kernel.
> +These are intended to enable userspace to make authorization decisions based
> +on which modules are likely to be bound to a device after it is authorized.

What is an example? This sounds obscure.

  Luis
