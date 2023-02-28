Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5379D6A603B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjB1USa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1US2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:18:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699C14E97;
        Tue, 28 Feb 2023 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Md9JrtUu3xnfZLvaIIJNt8/gwSPrEeVyF+t3AXsCqrM=; b=hPOpvUmwE+GwgMNIE3/72oaneU
        p43UVVetRqWVxdG5BNG/nc9ExKYmcf/IqZVYIROwQVC/Hl5pnCcquA3qFbzyeJbKC89Esdwpo2q4E
        c7gE+L4mmYidlsG90i97Ux3sLGRGcp5ft3bYrgTvIc69W2Iugj2zTW8uZ8VPrq0EfHbwa5WJy37JN
        Czj3riJGPq8P48oxwo1OpxHBJU+biqO/Pd0JsdzGPSY7jf7iNlzmafWcc+9Jw10lPbz9cM6eEglgl
        fs+syII0Uubs+WtkTLny7PnA2Fhnoelboo4ZllTBrxNrtKwRNSzbv20WxUA+gPsxUlthoFNx0uUgj
        IQ+IhUNA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX6Qa-00EBCk-UE; Tue, 28 Feb 2023 20:18:24 +0000
Date:   Tue, 28 Feb 2023 12:18:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dyndbg: let's use the module notifier callback
Message-ID: <Y/5hkFJsRnAuoRBN@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677612539.git.jbaron@akamai.com>
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

On Tue, Feb 28, 2023 at 02:34:20PM -0500, Jason Baron wrote:
> Hi,
> 
> Jim Cromie hit a BUG() while toggling jump label branches in a module
> before they were properly initialized. This isn't currently an issue,
> but will be as part of his pending classmap series. Seems like we
> should covert to using module callback notifier for dynamic debug
> anyways. First patch is just a cleanup.
> 
> Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/
> 
> Thanks,
> 
> -Jason
> 
> v2:
> -Fix: error: field 'dyndbg_info' has incomplete type
>  Reported-by: kernel test robot <lkp@intel.com>
>  Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/
> -make ddebug_remove_module() static

Do you have tests to ensure no regressions have occurred? If so what
are they? If there are no tests, can you come up with some basic ones?

  Luis
