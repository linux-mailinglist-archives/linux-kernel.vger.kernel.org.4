Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67618646705
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLHCef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:34:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA25862F9;
        Wed,  7 Dec 2022 18:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bM3gQMawq15L1CnHGjYYiIWNT3BujrTQZ2ElCcQyDy0=; b=39npV6yooKTyMLtK2+Mps8ilJy
        pIdOy7idXyxzBFY+lz5xiKpV6TjiF/VtUf4lQMWpOwA5affx4pjWiPikQGb5/3Np9ayeryXtWUSk9
        9ZYp6eSOL3uImE2ISkVj158U8h/0Y9h1mWNl+1Fi3e5kOf0z0TRietihSjrmOi747MQzGhxaI3urt
        eOrjarilgtiEvQB3GF17b10J9hyRvoltcXifdWaODU6UUCqxkGACueGtNK5Tu56y3w9oSlkQP+usK
        7Fj+rFjaKwDjlQSDMsvoumnWz9SD29RmDaT9803mmXa+151jhoWFcHFbAUyxlPwWYhSCDOMbsinhf
        KRjXE7YQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p36k1-000NdK-IT; Thu, 08 Dec 2022 02:34:29 +0000
Date:   Wed, 7 Dec 2022 18:34:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>, lucas.de.marchi@gmail.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] modules: add modalias file to sysfs for modules.
Message-ID: <Y5FNNYVSRglS0Lpe@bombadil.infradead.org>
References: <CAJzde06+FXNpyBzT+NfS2GCfqEERMkGDpdsmHQj=v1foLJW4Cw@mail.gmail.com>
 <20221129224313.455862-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129224313.455862-1-allenwebb@google.com>
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

On Tue, Nov 29, 2022 at 04:43:13PM -0600, Allen Webb wrote:
> This information is readily available for external modules in
> modules.alias. However, builtin kernel modules are not covered.

Why add this into the kernel instead of just a modules.builtin.alias
or something like that?

  Luis
