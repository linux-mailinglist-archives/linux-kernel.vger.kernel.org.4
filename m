Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBE6BB6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjCOPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjCOPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:07:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8EF1DBA0;
        Wed, 15 Mar 2023 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hhjj39aBNPHmPcImnS2rxOatDMbbYAct3kQhJtKMQjM=; b=DN3Hm7BwaEm+fyFv1RrWLL/1mU
        f0GDNRGuVBJjo+IkdehaM/kgpKMmKXK+8lZWOlTNLU/eeWpt37/N8GvppXsLzGvJoqDz810zlH0vJ
        zFCEZflEYPt79Zq6IT+c9p4F9gKjkJne9O6+tNpnYweum37WINJe5bpT4xG/JHegZ7TXgM1XooeB4
        S9i5e01Qq/WxI7bIxSAOafDDtgOKx9hGkoMMHeAORVhHVskyUYIjhlvHKJNh1TAWahmO3hz8AUdVD
        gZQ/hETWfckMEbOExZy/8wR1tgWMiuH9rJCnU36jY2VvBYpibNgElJicMc/EfBWq6yHbxRFxFWzIK
        luNvyxiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSig-00Djce-24;
        Wed, 15 Mar 2023 15:07:14 +0000
Date:   Wed, 15 Mar 2023 08:07:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] blk-integrity: drop integrity_kobj from gendisk
Message-ID: <ZBHfItq+gXGBvyWG@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-4-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-4-761a50d71900@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:40:05PM +0000, Thomas Weißschuh wrote:
> The previous patches made the integrity_kobj member in struct gendisk
> superfluous, remove it.

Maybe fold this into the patch that removes the last use?
