Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968B741FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2FjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjF2FjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:39:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2972733;
        Wed, 28 Jun 2023 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MUteH7xpdyoPgVzkM/6HFJaUB0mtXsV8h5SuaHj09OQ=; b=g07jdeiLgoiU6D4bn7YK4tVEde
        Q8nOVICVlQhcF+Y++751ixlSnIzctTX3SAGr7zB3Yuxgcn3TR2lAca9t7ZQPfHW5kR51VMnm6QFxF
        Y9CiNatIPNsHYFHuRkMOKf4TbYpM3H3/EQYKKvA6kl2rq4sd9LrlQestLpmSMlmWsD/Bso7pNgEfl
        D/Mjbcao9PPq6BNhPBh+HdNgB3P5L6FtHsLG07xB9JbIGiEAOHPJcu3sDk3S9NNky7bN/VteV0GRp
        54Tte84ZfMBu8aQ+VwHllCBD9UDrlPgiILhokQEsMYSJaPvYoI+FjnFZeWtYeBGN5G9nR0EXUgnpW
        qpo4IhKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEkN8-0001IK-26;
        Thu, 29 Jun 2023 05:39:14 +0000
Date:   Wed, 28 Jun 2023 22:39:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Message-ID: <ZJ0ZAmpNpid8Ff08@infradead.org>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628190649.11233-4-nmi@metaspace.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's the point in having a separate file for about 100 lines of
actual code?  Especially as that needs a header, intefaces, etc?

