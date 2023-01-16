Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC466CE63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjAPSIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjAPSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:07:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F639CDF;
        Mon, 16 Jan 2023 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bv4/NfwG2bRyLUAe4HN91Bd9uW/2GM4dYG62/PHE/nI=; b=vVVry2SVrryRRTVlZ97g9++Tq9
        TKWbQCQDeiohDK7VTXOjvm9g9WGQNfIdj98crojfWi+PCIRp2P0OpOeDMZA1P11cJix0bz69G7PLM
        brFtMWw9EdCZoPbneh1Kt7emuO9TqmMZtEoqmacyBgSHGmhql5K06bxleuMRBbOnIoFJtolKXcHRa
        noaZaN3dyr7FQRz1NOQmx+7hI1pIrgg+Wd6EEEA5txl1HFao7JTyDKaidOJNTokd79/K84vq02CXO
        s1o8t3G7icLnhFyTXdD1H/JXd+6EUbKn0saibkMJr9VfcPJ8rgme5aAGOf8uFtJRTDa+yhm3ac/zP
        Bgjoz/Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHTfg-00Bavl-89; Mon, 16 Jan 2023 17:53:24 +0000
Date:   Mon, 16 Jan 2023 09:53:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     corbet@lwn.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v2] documentation: fix Generic Block Device Capability
Message-ID: <Y8WPFMFxpfdZKs5a@infradead.org>
References: <20230110132104.12499-1-fantonifabio@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110132104.12499-1-fantonifabio@tiscali.it>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:21:04PM +0100, Fabio Fantoni wrote:
> - * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
> + * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to

The numberic values really do not belong into the documentation.  They
are just implementation details.

