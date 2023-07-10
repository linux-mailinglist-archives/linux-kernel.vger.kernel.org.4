Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1E74DE3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGJTcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGJTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:32:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5F2BC;
        Mon, 10 Jul 2023 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=LlnkGC74GytHxIJJwovutf2P2UKxE2NwtFzNvbCu77w=; b=dD1fzSZm0jygoNKQ+rjqYV5ieH
        MwkPL/1dkEj91m/+OIUepeywUTRrqPip2derKvuJJ+o5/teMxJHnp69oBMx5ZU9Pvj6dvs1Dseqrb
        6UjHZTZk/ajaal30G38cj0dnJX/rOzDq3rqi7U47LoshOpCnvPFc8XjjAVJK5sWxypFTaVrtb9Xme
        zDxPo9h5tfarAbWxeK3fhBtPBH56D726mv2DUisD4pVUU1kBE1kxUlH68KPFxj/VNmtYFMXeD9Bhz
        A3CHl7vTSVbWMoZdp4wOqnNyznYMHJ6rQMFRA5ZCJ5P8cNwNXzCE0Tr3SyjJcsTQSWHrcNEi6Dx7y
        VBcRVxQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIwcS-00CZN0-0B;
        Mon, 10 Jul 2023 19:32:37 +0000
Date:   Mon, 10 Jul 2023 12:32:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dyndbg: increase PREFIX_SIZE to 128
Message-ID: <ZKxcyC7hOStZrWy3@bombadil.infradead.org>
References: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
 <20230709-dyndbg-filename-v2-2-fd83beef0925@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230709-dyndbg-filename-v2-2-fd83beef0925@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:17:59PM +0200, Thomas Weiﬂschuh wrote:
> A follow-up patch will add the possibility to print the filename as part
> of the prefix.
> Increase the maximum prefix size to accommodate this.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
