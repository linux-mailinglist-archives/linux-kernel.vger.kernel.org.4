Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E20604AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJSPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiJSPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:12:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CCF317D2;
        Wed, 19 Oct 2022 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bq18bMMRKzKMA4r0xQKfR0raBVpNp1N44alRnyUfdbQ=; b=OoM3PT2AoFtqrN5tjzcU/+10LT
        MCPAMLWohxfKdGQMAdEg9duUWbhSCg4/Wlz/HwGnzWSahK89DrS/CqmYVpypVOWHR1bjdeywWsITp
        BD/MomOfls2XW95bUurgiyEomDYaw5NeO/G1COWvMoeTWwJoTqTcKlO3nqmpW5VOrP1EZgC1vjiof
        rEY5R2D+ih9rDpyGEswAvBM7PKeoBglZ7S5l9U9KUbktAcM4b2amvLUF8nKDtjaz426f+Ur7MYPus
        0dJlakaKim2veIQOQ2ALwkNWXmomwOr0W2PDRpKnzPcKSsNjUxqc1V88zVoXoJ4S918+gnmcff2jM
        ins+Lsrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olAca-0031Du-Jn; Wed, 19 Oct 2022 15:04:40 +0000
Date:   Wed, 19 Oct 2022 08:04:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq, elevator: pair up elevator_get and
 elevator_put to avoid refcnt problems
Message-ID: <Y1ASCGVJ1SJY7fi3@infradead.org>
References: <20221019132053.3597239-1-nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019132053.3597239-1-nickyc975@zju.edu.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this looks reasonable, but really needs to be split up into
a few self-contained patches.  I've started looking into that, give
me a bit of time to send it together with some extra cleanups.  I'll
make sure to preserve your attribution.

