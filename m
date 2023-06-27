Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5373F68A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjF0IMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjF0IML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7EC7;
        Tue, 27 Jun 2023 01:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC04861046;
        Tue, 27 Jun 2023 08:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E29C433CA;
        Tue, 27 Jun 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687853530;
        bh=uxVq6R7IQZafWDueCri447HjwsLG9DXntJCl08Kx+eE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aLrzrPvRdhGcLEoy8ikoWIjwqdjsNMcsx1zSzp1yUrXiLmgS9zvgrT9VmCx7BfXUD
         dBh4I9XSOnkFKouHVteQfELuY6TyAfxcCU1c69PsJvx61t3kKtw6wCnRuyadhMEigB
         B4gpDuuqfPdv7/Sd/+tipg/k2LrCC0MzlVuBnyNR7Nk6VqSchufBdwTbVdjmvmPR0z
         WmDqcZVYpSyDHQSKilBZmsDdgS1WSaTVlY1qbw0E4oc2LTn47ICDwGvdjGQmfM5vpx
         gUMxS0Sdfj/OFecXJ2WjRhGy1ksfUAg5IT9rhWOgrdRYaAhGwVSDr9NWMo5spMeNVd
         qOhVrBZp8O2uQ==
Date:   Tue, 27 Jun 2023 10:12:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Emma Christy <emma.t.christy@gmail.com>
Cc:     ezequiel@vanguardiasur.com.ar, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: rkvdec: removed redundant blank line
Message-ID: <20230627101205.49ea3617@sal.lan>
In-Reply-To: <20230621154247.43983-1-emma.t.christy@gmail.com>
References: <20230621154247.43983-1-emma.t.christy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 21 Jun 2023 18:42:47 +0300
Emma Christy <emma.t.christy@gmail.com> escreveu:

> Adhere to Linux kernel coding style. Removed redundant blank line.
> Issue found by checkpatch.
> 
> Signed-off-by: Emma Christy <emma.t.christy@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Changes in v2:
>   - Fixed Singed-off-by.
>   - Fixed Subject line.
> 
>  drivers/staging/media/rkvdec/rkvdec-vp9.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> index cfae99b40ccb..0e7e16f20eeb 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> @@ -227,7 +227,6 @@ static void init_intra_only_probs(struct rkvdec_ctx *ctx,
>  				}
>  			}
>  		}
> -
>  	}
>  
>  	for (i = 0; i < sizeof(v4l2_vp9_kf_uv_mode_prob); ++i) {
