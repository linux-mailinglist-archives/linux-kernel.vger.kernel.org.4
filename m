Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC25BA97F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIPJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIPJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:35:51 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377E9D8D8;
        Fri, 16 Sep 2022 02:35:48 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oZ7l7-005FHo-7O; Fri, 16 Sep 2022 19:35:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Sep 2022 17:35:41 +0800
Date:   Fri, 16 Sep 2022 17:35:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     'Guanjun' <guanjun@linux.alibaba.com>
Cc:     elliott@hpe.com, zelin.deng@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography
 Complex) accelerator driver
Message-ID: <YyRDbT0fQQwsVpKL@gondor.apana.org.au>
References: <1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com>
 <1662435353-114812-2-git-send-email-guanjun@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662435353-114812-2-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:35:45AM +0800, 'Guanjun' wrote:
.
> +static const struct file_operations ycc_fops = {
> +	.open = ycc_cdev_open,
> +	.release = ycc_cdev_release,
> +	.unlocked_ioctl = ycc_cdev_ioctl,
> +};

What is this device for? It doesn't seem to do anything so why
not jsut drop it?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
