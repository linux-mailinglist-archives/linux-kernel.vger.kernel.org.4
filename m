Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68B4626125
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiKKS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiKKS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:29:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25445CD01;
        Fri, 11 Nov 2022 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7tbDqOMUc+B0QqDmK1vKonS3aMRfoeVXeqTyBRBdDGw=; b=XfnFLZn3DzVTYvZQ7U1999V054
        8yFd9Y2yjEJWPS6NgNmRXeNoQVxgbA3uabTTmUgrTCuCWP9Yqaet3TCpPe6f3ONXMBxoDfdYiIY2R
        5Nwg3IcBTLt07PHgYxJqqNgj7hA3kEy07TReI/iQ6e4Ct643vfhJRdTLdq1KDjIY57DdV9+iQp/6w
        7llxZh830ds70Q+8jjOg3pIgxgvLWkuF281Lw9uI6fIcJPOBcQV61/mQsthid3SRGwWwYaAuYwdSh
        cy0bHfLdANcW+nTRLfgzyzrwCq0tNQH19UMil8FptHpVHzbPUUisXw7jL6iig49FyTBlJGx2F+a3g
        Z95zCMHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otYm1-0006OL-Ai; Fri, 11 Nov 2022 18:29:05 +0000
Date:   Fri, 11 Nov 2022 10:29:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: add modalias file to sysfs for modules.
Message-ID: <Y26UcbviRaoK9a3C@bombadil.infradead.org>
References: <b2d1004d-4a76-ab0b-d369-a38c2d7c1624@csgroup.eu>
 <20221111152852.2837363-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111152852.2837363-1-allenwebb@google.com>
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

On Fri, Nov 11, 2022 at 09:28:52AM -0600, Allen Webb wrote:
> USB devices support the authorized attribute which can be used by
> user-space to implement trust-based systems for enabling USB devices. It
> would be helpful when building these systems to be able to know in
> advance which kernel drivers (or modules) are reachable from a
> particular USB device.
> 
> This information is readily available for external modules in
> modules.alias. However, builtin kernel modules are not covered. This
> patch adds a sys-fs attribute to both builtin and loaded modules
> exposing the matching rules in the modalias format for integration
> with tools like USBGuard.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>

Thanks for the patch Allen!

I'd rather have something generic though, and it would seem kmod [0] already
does this, have you seen the kmod support for builtin.alias.bin

Can't that be used?

[0] git://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git

  Luis
