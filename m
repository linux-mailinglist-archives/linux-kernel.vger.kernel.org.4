Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC007342C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjFQRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFQRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BABB2;
        Sat, 17 Jun 2023 10:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACCF60B78;
        Sat, 17 Jun 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D1C433C0;
        Sat, 17 Jun 2023 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023994;
        bh=hMT4LGOeCEN9ozXyV4zVUtX/Z9t+AI6WEzC3nEygvaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXOeFadJtidlKQEy2d9VpGOCLVN+DsY2EivkxGUfLg25UMgBIY+CIt3iVqkCueUDi
         SRH63yW8c3TqCPDceAyldogBMJQe9EjtJnVumtlFw2+P2Y1qh4swXh+YAN30X7e9zc
         nMk0HwGzvq8bUPLUMEGxZJYQHp04kc2ZjNso5PLlcAkUkn4h+0p06Pd50lWodbXukm
         INfxr8l+c09VHCmWM48f+GVuKbO4TGH4c7KCuSLPc/tGE+JibPPY/b3yGuPICD+A1m
         wGVNU2wCOtA7TuLy6+mrOLJ8G+Dk+OFcWvpMwjXUzLYeNBn0KHD9aHsFPno78OcoHA
         wOB8jGeWreHHg==
Date:   Sat, 17 Jun 2023 18:46:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 09/13] iio: inkern: Replace a FIXME comment by a TODO
 one
Message-ID: <20230617184624.61fb6252@jic23-huawei>
In-Reply-To: <20230615152631.224529-10-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-10-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Thu, 15 Jun 2023 17:26:27 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> This FIXME comment is more a TODO one.
> It is a note when someone will need for this currently unsupported case.
> 
> Change from FIXME to TODO.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 8bfd91f74101..19ddd77adb11 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -879,7 +879,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  			*val = max_array(vals, length);
>  			break;
>  		default:
> -			/* FIXME: learn about max for other iio values */
> +			/* TODO: learn about max for other iio values */
>  			return -EINVAL;
>  		}
>  		return 0;

