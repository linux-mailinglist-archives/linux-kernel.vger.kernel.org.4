Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAD682A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjAaKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjAaKer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:34:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281214496
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:34:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so9970292wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pGDnJGJacVF1PMUap5ezjy6PuTvYC3mIm+zih6cOuVQ=;
        b=fUXj+8w9PNWhPejeQuG8YDIzmXrPw6BgnpaSXVKcjFMoLq7zZ+qdUWYNnvJQxBJk/Y
         8jkYlJdHo59yRxNSn38ydjWTQBf5+6mQK0Y1MksanP88KDqz6LZ35Z1V3C8z7cqWYOq0
         nyViAp4vJFBB5AawR2mxkaq6VoCNFLSunydwkt89OM0wmw+nVjjS2CcHfFGbAIV6DJKj
         66AYmiLwy0hbS5wvYT2aKFoNwApOSlWupeyoKa4dXFmfdwcnw1iYGqy8J1g+X+WftVPe
         d+yjmfKQkXCGHo17mMZWRaUiswqTqR2sURPPqtYCPMFxiyIFgEVa1OZWtWkpXlIjO3Zf
         66Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGDnJGJacVF1PMUap5ezjy6PuTvYC3mIm+zih6cOuVQ=;
        b=SgLfOcnHCTOCGM5xuxf60KlLMrYYuCyHqkTDmXnTPuxU0tMxK7zl4j6V1Z3k1yfca+
         ksCZiKbOhFy9DaUIYhgJaNgu7WDLQcFoLf2Hpmm1pyz2IS2DZdXsO3Gv0NAP+mW/nJWH
         R1jRzOVQRdPdAOphfMrcexguOezj//cir7kuwav2uGJznP9EPWO5bRcyIG+5dx1b8pue
         uysEu6ixhm9Ybv8r2CUk+U1e4x80d6mkblKT8rj41wsrBckD4XvovdAtZlMdVwUR19TE
         Yth8LO0LSd6T4vVqIr6z9cLvx/ucLD1qV5tFeNAvDlkvJ76Xo6L9t3LcRpQqa9UWa6KI
         YkGQ==
X-Gm-Message-State: AO0yUKUTMMYz9FMUafLHaySoVY49Z0GmWKXS09iu2rxACMDWt7E6Yxa8
        qiL4bZZaKeSDuXlyrK142jMrPQ==
X-Google-Smtp-Source: AK7set9miOpPKqLx30aMxVqgYoOxwtZBLwr3guJySEdGJ1fZiIka9A50E9jnmWTtUAeA/hVHH0RuVQ==
X-Received: by 2002:a1c:f014:0:b0:3dc:4318:d00d with SMTP id a20-20020a1cf014000000b003dc4318d00dmr14272307wmb.11.1675161284465;
        Tue, 31 Jan 2023 02:34:44 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id m29-20020a05600c3b1d00b003dc51c48f0bsm8923701wms.19.2023.01.31.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:34:44 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:34:37 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     troy.lin@rock-chips.com, shawn.lin@rock-chips.com,
        hl@rock-chips.com, ty@wevs.org, mike.rudenko@gmail.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robin.murphy@arm.com
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <Y9juvficPxFUfgHD@Red>
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Sep 20, 2022 at 10:35:44AM +0100, Robin Murphy a écrit :
> On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> > The Rockchip driver has long existed out of tree, but not upstream.
> > There is support for it upstream in u-boot, but not in Linux proper.
> > This commit imports the GPLv2 driver written by Lin Jinhan, together
> > with the DTS and config blobs from Wevsty.
> 
> Note that Corentin has a series enabling the full crypto driver for 
> RK3328 and RK3399[1], so it would seem more sensible to add TRNG support 
> to that. Having confliciting compatibles for the same hardware that 
> force the user to change their DT to choose one functionality or the 
> other isn't good (plus there's also no binding for this one).
> 
> Robin.
> 

Hello

I am very interested on how this serie was tested and which tools was used to ensure output was random.
And how did you get that CRYPTO_V1_TRNG_SAMPLE_PERIOD(100); was the best choice.

Thanks
Regards
