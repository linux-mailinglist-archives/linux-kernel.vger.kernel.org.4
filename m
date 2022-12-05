Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57481642372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiLEHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLEHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:10:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CFBF5E;
        Sun,  4 Dec 2022 23:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=44OC1RvAvD0oCfSAH1w+pJ13wY3bP51cQgH0C3Dezfs=; b=A9iQFgguKVyQoprmdJyhQ4sT/Q
        QEbNxNInj6yDaT1uACEzB0YrCiEa8rxYfMscK1wc56+BBYHiBLsDa5/wO2721iSsMby2QdV4OZ/EW
        57rzxbsMPlS6cLyyYt9NJ2UgHQW02sLCx2HSBZozY+lQjvjMMvpmiF/3uUOriiqZiIgT48YviQt8u
        oPdB1PgE7RgIw3gCLLFS97kcLkqF2jwZaMVIHcqbfYh3HX9Ocwkb5Sl4ITxvmkkSDf6Vg2mm0AEaT
        bFwqXA7xYfJr4sE5ISvgJQz/pyQlz7XpHrd3Xaqbbr8qTWfdgGx5egdFOLFJI0FDXTR3LzRAkQvY9
        lacYvgWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p25cF-00FMKT-9I; Mon, 05 Dec 2022 07:10:15 +0000
Date:   Sun, 4 Dec 2022 23:10:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: sed-opal: Don't include <linux/kernel.h>
Message-ID: <Y42ZV/AwSqUlDnas@infradead.org>
References: <a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 01:18:49PM +0100, Christophe JAILLET wrote:
>  #include <uapi/linux/sed-opal.h>
> -#include <linux/kernel.h>
> +
> +#include <linux/compiler_types.h>		/* for __user */

Not sure we really need the comment here, we don't comment on the
other includes either.  Also why the added empty line?
