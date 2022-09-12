Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A25B5F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiILRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiILRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:43:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BB1EEC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/QAJEuED/J+g7NKyksx80eaJ80eOlNtdZTqJ5r7s0Io=; b=LRn7KEa2X+/6bTzF92mUvfjJrh
        BkNmjJ/5WvK2tIyHZAKBIWrzq4KOdcpP5M1H0ouyk9DKbGfOzoeuKtX3cjOfCWFzC9wwujaU4eAQL
        twGIftfRRqbpX3uV9zWx1H8qrhhy8bW8fIW/NS3nK9Isip5UMiBYGzvuk480O7fctolNLObNoSFtW
        JNApIvrVkOUfJtodOiDqiwH3adhFMImBMxxyXynrkR94iZ63hnIEgF0S1Ajwt9vVv+WeOI9TOZE//
        GXwYZ+yJZIKQ8cnVEXHAjvq2jg2clD7nIflGaWFL0fUkL08Gu7l+jnffOmEYCjw7jux7XZtMj+Olp
        pxkNsmvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXnT4-00G7dK-Uz; Mon, 12 Sep 2022 17:43:35 +0000
Date:   Mon, 12 Sep 2022 18:43:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] XArray: make xa_dump output more friendly to read
Message-ID: <Yx9vxqmBR5rtMm2o@casper.infradead.org>
References: <20220912124647.17164-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912124647.17164-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:46:46PM +0000, Wei Yang wrote:
> This patch helps to adjust xa_dump output by:

Thanks for the patches.  I'm at Plumbers right now, and then I'm taking
a week off, so I don't really have time to look at them properly.
I'll try to remember to look at them when I'm back on the 26th.  If I
haven't responded by the beginning of October, please remind me.
