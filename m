Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E056D57DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjDDFHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDDFG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:06:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4B1BE1;
        Mon,  3 Apr 2023 22:06:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0B74DD;
        Tue,  4 Apr 2023 07:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680584816;
        bh=BM4y5PjB7Ht/ou9MwaKxwHoLKvy3DMIrcmMHl5T7fqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceYbo2KWKKOwyoEKbR33mOzI1oQqktBtd9nAq58r974UdcFk+rt29bLcrQk63+9Jt
         5iWeG7pzDlru2wXrx+nKmh5R+PYAiQSRe9dabsKyglg3PVMl2nnw+zafbGaFQpSjZm
         NMG/ElLIaNZ6AJAxueQLv0B3obsEATfE9iJCnqvM=
Date:   Tue, 4 Apr 2023 08:07:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v3 8/9] media: cadence: Add support for JH7110 SoC
Message-ID: <20230404050703.GO16648@pendragon.ideasonboard.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-9-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-9-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 31, 2023 at 08:18:25PM +0800, Jack Zhu wrote:
> Add support for Starfive JH7110 SoC which
> has the cadence csi2 receiver.

This fits on one line:

Add support for Starfive JH7110 SoC which has the cadence csi2 receiver.

> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index add982edce64..5e36b994b8d5 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -560,6 +560,7 @@ static int csi2rx_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id csi2rx_of_table[] = {
> +	{ .compatible = "starfive,jh7110-csi2rx" },
>  	{ .compatible = "cdns,csi2rx" },
>  	{ },
>  };

-- 
Regards,

Laurent Pinchart
