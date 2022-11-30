Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37963CE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiK3FJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiK3FJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:09:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB2F30579;
        Tue, 29 Nov 2022 21:09:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36367619EF;
        Wed, 30 Nov 2022 05:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6219EC433D6;
        Wed, 30 Nov 2022 05:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669784977;
        bh=pZq8PuO6WLyuksUNfuVgxMMTnDCW8ptCAhQ4jZHJzws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXIBSVz2NF6WKnK+PwGDNw2ebh4Pyuz4+8GzTUkBJg73TpihnVJIvj8YyhdGqMNna
         fOI3RJZV/SkL/nMCkYU8jlA7rLgj2sWBT/MEROnqp3bT+3EgYBUgz/2vuzxNf5Dbbr
         weptsmjtW5euaMyJyESbZvD52fn673ucTo4XzUd9jTbbhaM60Z4x8G+Q27OPnyw4cw
         neMr9VnUOH3GITdEZQKhJCUY/HY7pg4WFcdBSoDo8Y9+B46q8/RkRZE5hsZ+yn6sCL
         xtrQ1GqqX8UmE26n1QwP9hlPlIO3Rjh6XnYxCuuIpMcGMnQhZ4WGa5c+jvdrLcfySC
         OkRQ789V/JrTw==
Date:   Tue, 29 Nov 2022 21:09:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        leitao@debian.org, nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com
Subject: Re: [PATCH 0/6] crypto: Accelerated AES/GCM stitched implementation
Message-ID: <Y4blj2RZB4PI7ZYZ@sol.localdomain>
References: <Y4Xyflca/hkvR0eR@Dannys-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Xyflca/hkvR0eR@Dannys-MacBook-Pro.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:52:30PM +0800, Danny Tsen wrote:
> This patch has been tested with the kernel crypto module tcrypt.ko and has
> passed the selftest.

Please make sure you've tested it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.

- Eric
