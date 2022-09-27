Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5605ECD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiI0Tq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiI0TqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:46:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF118D0C0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:46:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e18so7230576wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=DeB7QMH3bIq5iaWc+HNtDZ/EEbhGqYVc00tj6aMlmZM=;
        b=6d19iBbLjJfjcI3h5ypTQXXNp8K1NZfNM8svzDzOme2DYusajPqmg7VXzWgUo7HcTr
         W2lWdZWDO6uGFWijF+Ldubxs9S+syHIV+Hz1syz9fU8RLrk4QWAFvJDRhi+9HJpiNQdf
         Xrk2HP5CXO4HQUT0LnFVC6Fs4Tu/L3QEOk7jYUrcxQs51sO7NrolM5YE2CFoF1iI4tkB
         m12nIJsOnRThu6N7vSxBMDCvO4mqYVtlMGH8pjTubyooLN+iCGKLhwoFUjsCMG+Bv6CT
         LZLblnWW96/5b/tBiUjaEtXmlx7aoeQf+cFSf54sjwvixqarV6w4Fx+0tjTDl1x8vCqJ
         PKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DeB7QMH3bIq5iaWc+HNtDZ/EEbhGqYVc00tj6aMlmZM=;
        b=onpwLU+wWGK3zG0CUb7bJejxEWKYD/DpgjeLrskWvTCxyaH6OZ9BtvItKutjSp+8I5
         vvuVWbhnHND+OiCltrIwBZmPocNhTx8ZaGI6LPo5MG5amaJ+R+fp5W2RATdhXUVN8bME
         hJ9NkZS2B6jl0LqaMapOtC0FbS5fNi4wWM7Lufr6v0WXKUo1Aqdt3Ulmj/88r66kPVsW
         c1/9BkFM0Fj8mO3hMLs9vgR2MvQdKdGf+ttkIYMdbxPnAeklIQjcsbQ3vAK0Hfuyz3II
         Wjva9DqVuc0vMV7tCIfzmvz7sUPHURwFQy3fImhquiOTOkAg8niH3duS3AVEu2jZGTYY
         XVVA==
X-Gm-Message-State: ACrzQf2CBV2booWceUolpItet/g9QlPkuCkAmlEZtrR1CZaGtqQAeYO5
        Av+JFGVyK2xuWivb2Mv1NLLVaQ==
X-Google-Smtp-Source: AMsMyM6A9nO9S0tgG3oTWD9BFg3cuE4+ACkC9O+BJbF8uOGSQDV2r48m9qfcYk2ORWaJ6ZvG/NUJ8A==
X-Received: by 2002:a05:600c:a46:b0:3a6:9c49:b751 with SMTP id c6-20020a05600c0a4600b003a69c49b751mr4024777wmq.169.1664307979007;
        Tue, 27 Sep 2022 12:46:19 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id ay11-20020a05600c1e0b00b003b47a99d928sm2857278wmb.18.2022.09.27.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:46:18 -0700 (PDT)
Date:   Tue, 27 Sep 2022 21:46:15 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <YzNTB+RQK6yITi7/@Red>
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzMm4d3sZBHpitm9@aurel32.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a écrit :
> On 2022-09-20 10:35, Robin Murphy wrote:
> > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> > > The Rockchip driver has long existed out of tree, but not upstream.
> > > There is support for it upstream in u-boot, but not in Linux proper.
> > > This commit imports the GPLv2 driver written by Lin Jinhan, together
> > > with the DTS and config blobs from Wevsty.
> > 
> > Note that Corentin has a series enabling the full crypto driver for 
> > RK3328 and RK3399[1], so it would seem more sensible to add TRNG support 
> > to that. Having confliciting compatibles for the same hardware that 
> > force the user to change their DT to choose one functionality or the 
> > other isn't good (plus there's also no binding for this one).
> 
> It might make sense for the cryptov1-rng driver (I haven't checked). For
> the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find the
> RK3588 one), and from what I understand crypto and TRNG are two
> different devices, using different address spaces, clock, reset and
> interrupts. The vendor kernel uses two different drivers.
> 

I confirm that TRNG is not on the same IP on rk3568, something I didnt remark when doing my V2 driver. (I need to remove rng clock from rk3568 dt).
But the rk3588 crypto IP and the TRNG are in the same device.

