Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB4626D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 04:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMDP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 22:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMDP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 22:15:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45412773;
        Sat, 12 Nov 2022 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TWlZ6+x7VoJGecTM86Bt4H1jlYmszLGqugIaVNd7H4c=; b=3UNpxq03qw4svRGFsQaxZbWhL+
        gFL+4iCpXEVl+9kZm9KAy8861rPXz5zKMdRXUER45ASAL5d1yhLYFrzB+HbFj/U70L2QnPss/bFyR
        bx+iuyaJEtlO/Dq+U9RK1nzjFJqfmQd8YRNqH0S06d/yiKwFUmE1iSNSt4wqQtSfwEOImoOrKBN5L
        RMHpMw6pqfSd6c0ZohmdAXsFD7RJ8MpEYKTTfuT1ZHr3doGK+KkiN7OWWKkMtH8lSCdHEZkxaQk8K
        yIRS6iCzjO3PQK284ULtlvyfUEFN4Liho9lKQcHHOloaayiuAqtYOJ0LOF/K7ePAHPuVJ+ZDWTNGz
        I5r/2zhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ou3So-009Cx8-PC; Sun, 13 Nov 2022 03:15:18 +0000
Date:   Sat, 12 Nov 2022 19:15:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>, thunder.leizhen@huawei.com
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map
 symbols to built-in modules
Message-ID: <Y3BhRvt53xO5A0iQ@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-5-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109134132.9052-5-nick.alcock@oracle.com>
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

On Wed, Nov 09, 2022 at 01:41:28PM +0000, Nick Alcock wrote:
> The mapping consists of three new symbols

The entire commit log does not describe *why*.

Can I also trouble you to rebase on top of modules-next [0]

Does the kallsyms loop more than 3 times now with Zhen Lei's work and
your new symbols on top on a allyesconfig build?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
