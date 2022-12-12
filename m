Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AEF649A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiLLIj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiLLIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:39:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38969BEF;
        Mon, 12 Dec 2022 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zr+LzmsqOxE2SWoY3n7ygSNQvczxGbNu/n79CO+xp7g=; b=kzRCc7F+pv0O7XF9u6CEPW9l95
        S1z9Sfzlyqsad8kyIrx6+2VYUv/QD0vkG1AHwwOjn6jdQ80iCiXcxcqqSTwF288OQk/TD+Cineyjf
        vUwFIU0E8BiPRaFsH50Ko+wSmr76Gu4dosx86n6HUcSwjGEtiibaMUsSkENsR3p9aRMn/ENm4JxQO
        lDEzerdi1jwMMCq4oDkgsoRHnkBfKdWOOT7mFxsetzPQlPldS1tByN6riJWILOKyxsoRYMf/dIr3c
        ps42vz/g23DPk0q93YWqqi6zgcsutuQYlYnU3MWZZYCgcPCLttVUSGC2lKKVkKXSd6XvUNYy1+YIL
        PaCaoT7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eLk-00AO7a-9p; Mon, 12 Dec 2022 08:39:48 +0000
Date:   Mon, 12 Dec 2022 00:39:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: remove left-over due to now gone pktcdvd
 shortcomings
Message-ID: <Y5bo1I5SytNV8ytv@infradead.org>
References: <20221209084130.31805-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209084130.31805-1-lukas.bulwahn@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 09:41:30AM +0100, Lukas Bulwahn wrote:
> Commit f40eb99897af ("pktcdvd: remove driver.") removes the pktcdvd driver,
> including the config CDROM_PKTCDVD and CDROM_PKTCDVD_WCACHE, and the uapi
> header file.
> 
> Remove some further unneeded left-over due to now gone pktcdvd shortcomings
> in the scsi library.

Right now the removal is only in the block tree, so this will have to
wait until that and the scsi tree are merged to mainline.

I was actually going to send this patch at that point, but we can
just pick up yours now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
