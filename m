Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A45BDD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiITGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiITGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:35:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47F4BD0D;
        Mon, 19 Sep 2022 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQejfzOTLyVYbb0Ee26cQYZo4hJMC+wlpWSmhGWbBjM=; b=yLG1qn2xAB9YULJEI0M0N32sVE
        IJCZP+Xssy+PIAyXMm/Nz/if3Cg28eewsHQLgoZkn9LYJoWUCb5q/MfsD9KWDwhoC4ItP2av2qpJQ
        H9/fpXctJMhdYnmiwAutRnFZ2vAAL/uO/tkqtv92mCw4BCWEcxOSwNvJJ7R7Jv21mP3IKmH5DOKeq
        6Ih+CtWpEepZJqZfO4NNbYBd9iU6Yoj5O47r8IZH5zds97GqK5CyxHXanqSqVkmTW11+PIsC77LjK
        HMSqzx4Ndxl+F+Be5xbC6sUoldgOW3HKmPtcPUlQaNbNX1hfLlYCUifafexu60ZF8fnrbTMs0+MGQ
        nxZu5ilg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaWol-001123-VU; Tue, 20 Sep 2022 06:33:15 +0000
Date:   Mon, 19 Sep 2022 23:33:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Subject: Re: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by
 default
Message-ID: <Yyleq43/IBofsMMn@infradead.org>
References: <20220919094635.184804-1-ecurtin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919094635.184804-1-ecurtin@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Err, no.  We should not add config options for every damn default.
If you want to force it on CONFIG_CMDLINE is your friend.

