Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7065E895
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAEKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAEKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:03:17 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEEA102D;
        Thu,  5 Jan 2023 02:03:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED03DFF815;
        Thu,  5 Jan 2023 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672912993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwK9pvRfjwBdJNHXPaYqmCSQq++D7SmsZdpp8kJRkTE=;
        b=QeM5SGgr5AB1hCD4CXUwjf1uk4cehuufO9XLEWWQsNFeFBdHd5Hvspt28D5auUE9r+MvV2
        SrI5P0fPRnNw9tjru6fapsShNDhk9imdx9kUDobfOBxPhTp2tkueFLxQIgdkOxJUumtkVJ
        LtB5S8bqg7QrwBPvwN+aZqHV7DhQgBZryManUJLWaBixofJhWv4BEQW2DCB/Hq/eSmterc
        VubZeZJOKlAo6fPOpJOzOuDrTpWG8qKOu3v26oqbzDzDmiB5mTeNlAs7eEi9rLrfbvi+vv
        N0eLfFL4+LlQG47py5R6sDQPYKtB+y2lD/BbxyAVE+0eiWCjsLp8w7VCWNm27A==
Date:   Thu, 5 Jan 2023 11:03:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][next] nvmem: layouts: Fix spelling mistake
 "platforn" -> "platform"
Message-ID: <20230105110310.373f076b@xps-13>
In-Reply-To: <20230105095828.2951-1-colin.i.king@gmail.com>
References: <20230105095828.2951-1-colin.i.king@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

colin.i.king@gmail.com wrote on Thu,  5 Jan 2023 09:58:27 +0000:

> There is a spelling mistake in the literal string. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Good catch.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/nvmem/layouts/onie-tlv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/oni=
e-tlv.c
> index 074c7c700845..767f39fff717 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -48,7 +48,7 @@ static const char *onie_tlv_cell_name(u8 type)
>  	case 0x27:
>  		return "label-revision";
>  	case 0x28:
> -		return "platforn-name";
> +		return "platform-name";
>  	case 0x29:
>  		return "onie-version";
>  	case 0x2A:


Thanks,
Miqu=C3=A8l
