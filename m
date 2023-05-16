Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0147059FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEPVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjEPVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:52:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9D8A50;
        Tue, 16 May 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iad4KW0Ynj7+nr6qQMYgGnWW5G6cg8fV22lwzFPncog=; b=guEHUICMEIw2mK38zuFeUaa+84
        CfKKdYwFMuuGu6SpIcOMnyKBbjk4f//mtZlPJM1vqX4jGnTd28cJG5JOtjWe5Oq0Kz2MohaDY0Ccy
        M/e3iKnEiCPQKHREjGGSRSEQRXJoqs6EOYWrOEr/270mo09MxqtFvGyZlP0rnKX6/dAEUWNqscl4a
        xkDM8i0EqWXW6t1h6PMlH6osrzf2kUAw8dU9rmrTQeJm1XOVUWnjAFPewKrDhR/Anm6jGZVPG7hU4
        1F5ShgYSWpEoQiZpY5ewsgE/VCDD45W9io5dF6DDXK61kkljGRatDn807jzC15Sw4hQQxIR4DGjrd
        SJA29XmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pz2Zt-007E4K-1L;
        Tue, 16 May 2023 21:51:29 +0000
Date:   Tue, 16 May 2023 14:51:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Fix a NULL vs IS_ERR() check
Message-ID: <ZGP64ejOZLJEL81O@bombadil.infradead.org>
References: <36ef6042-ce74-4e8e-9e2c-5b5c28940610@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ef6042-ce74-4e8e-9e2c-5b5c28940610@kili.mountain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:12:51AM +0300, Dan Carpenter wrote:
> The crypto_alloc_shash() function doesn't return NULL, it returns
> error pointers.  Update the check accordingly.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
