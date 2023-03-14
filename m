Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186026B908E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCNKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCNKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:49:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2B1D93C;
        Tue, 14 Mar 2023 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678790882; i=deller@gmx.de;
        bh=+H999tQFo7smOtY8vl9Sq4foFE7+8XAXs6vN0vwnsCg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oBLE1QyMpuuoR1cS0O6DRUI4nCpZeHo3qlFTw5vK3WrqsQZipdvY9g5+d4RWFww0I
         Swc3UNSbl+OmGDETIsRw55tlCgIoVUSkO4OoG3ppY+ZQNYVcU2dj3shQbAyjkiL07R
         hIHroHTBQxiH1LmCorORaZJt09iE5YqrFjhmftq5vLDIGqr0q77GnMq1uv9dX9AI6M
         k+BLiBY+YFMQ+06MqLUESm3+5ehmkLpcLyfs4OBTsq1+VUTazjQ+SDSkJzoiBmPm7e
         04wTTspujkcMMC8uQhLgTT63nIohVQoJZG5h3KbxRD64h4YKH+BcS+ftsGboIdQAh0
         KcxxWXeSOja6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1pYiog0gIG-005cDM; Tue, 14
 Mar 2023 11:48:02 +0100
Message-ID: <8e402daa-a9ba-59c2-92c4-f1ecd155acda@gmx.de>
Date:   Tue, 14 Mar 2023 11:48:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next 1/3] video: fbdev: pxa3xx-gcu: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COWrltcDftZwEH+WQ+1z1WpXjeLD2DaQry6p1pznqypdP8qXABj
 KHU3O/ZUN9Uj6ZJSbYFEVW0shSyut/P2oppX/bSeAJ6qvvvuuDHCcEQcGepkptijfFAtxhN
 obVm/UHfvmd34X0TXZClEK6rQ4WEA745BZH5QXrXUmwQBWrno5VOAHaNNlhdlV+DHun2X9I
 8FKOBmS+7G3WCklyeuFnA==
UI-OutboundReport: notjunk:1;M01:P0:bhN6TB1bLJM=;Oh5EPKU3hhF4QPWCwTgxxnd+FXV
 OXFu+/UM6E2zVQmLXUeI1jUknJIytDkupCrY6XRlK1A+RcBOmUD3JsXZQg0fntH8jPgd3j+0i
 qcVmDCcUDFRbWGatbuJ3pVjfOSdXyK11nQF8lzKTOQQv2WjiombRfog+MHGARMPWfN5faKYbA
 9ahYXk+KYxKH0ARONCoQC7KLyFeLjmlad2dU/xZrLNAgQhyzoQD+mApYfLgVZtx/aACLL50SK
 xk9fgzPomHDl/9SHvZUuqgt9DuU7Hmi8g3rDkQa2m5K+yIay786YaJx+VyLjlmrrb/7Wj57K2
 hjYttI8GVQbhfdubtx3Eq6kUBq2YossvdQ4FUAXgq+hRmSj8z7oyMvfHCbtZOSRFoe1cQ4AYU
 IIj6F2x/VPBLFBfpfa+VUSouA33RZl9y5Lamvi25S9IG32EXt4ci9oKIj+dp6mojzDrkJ7xMX
 chGrWHcCgONZolf7D9g1x5iWrmurnxY9jOtAI1crIDKM/JgrjST0ar3lP4faU8F1uyzHewOeV
 xAtAt/nJ6qpm1LT1wtQy+qi+TrNyABIRfYT7wDa0JjU1H0RO1i/W4Sz3ivt36HwNV+UNrRPAN
 JjTZ42M54wi6xNnHeFEI1So5pEfN7/Cvft756QyPYMdn32aiTnnUZTnm/CV0qy625ZMUdS4BC
 UrptGxSqlN5Ys5tdD3aU0VQwY9BkOJZGqOZfdiCNY3J5BkF/KBppRGawCh4xhCgfNq0wrNwir
 at7i+GwCtA0PhEYSm8WPpwdpYGQDQR+Jy0RkLExm4hBJsR4owH4p3D4oZVZcGg+qLP1WJg13p
 5DDttsuxqJQRWFJC6Y1J01ykz/FJMU9Rf0ti0lDeM7T99F4Yoc2BdTYgF46/fICo5b69PWy4m
 QI6Z7s4JLfHZT49jU0c7AoxisEd0YH31zFsMldo2QGXPh1jyESFCj84thEub4QoNvEI4BTiOc
 /pbthbU65VjJtHWoWjhUEiVEXAg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 06:42, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

series applied to fbdev git tree.

Thanks!
Helge

> ---
>   drivers/video/fbdev/pxa3xx-gcu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3=
xx-gcu.c
> index c3cd1e1cc01b..d16729215423 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -599,8 +599,7 @@ static int pxa3xx_gcu_probe(struct platform_device *=
pdev)
>   	priv->misc_dev.fops	=3D &pxa3xx_gcu_miscdev_fops;
>
>   	/* handle IO resources */
> -	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->mmio_base =3D devm_ioremap_resource(dev, r);
> +	priv->mmio_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r=
);
>   	if (IS_ERR(priv->mmio_base))
>   		return PTR_ERR(priv->mmio_base);
>

