Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42737437C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjF3Ixr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjF3Ixe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:53:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3235A0;
        Fri, 30 Jun 2023 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688115199; x=1688719999; i=deller@gmx.de;
 bh=yclpbwa2nMn46Zo9sja7sWvN3MOdzaJ89fOvhuYL0vw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=np0zpTfkYv7fmxlCu9VmHKMWcOGepbahVM+YISY4DJLVUuS1QSZ6jtLExKknE40cZHjEiNn
 8qEBAb3bdBFjNRzorG0lD91Ki3+Ae7Fb0GsI9FkFlYoA63OYVSOh+NSSygDvifCRDdJiA4h49
 shVxX5jAmK/cY2N9mRtqCs/z4TeVxuFoHK7XN0wSRhLJodcPe801BdBiqXkZa3cMe/Sc8FOGk
 q+K94jT4NGsoIMEUCZjtH0CZEZHqgX2Qop8mXi6gLuOQkoW5OE0qfoUdUSM8oiVuFTgZuFDsU
 ba4zbf4jpgxqKv1TLDBP45YlAje//h2uaNE6Zbhr5Tsp4eETiGtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1pq3F547zR-00ywRy; Fri, 30
 Jun 2023 10:53:19 +0200
Message-ID: <bd6d481b-22be-217f-e6f9-95a31575d7af@gmx.de>
Date:   Fri, 30 Jun 2023 10:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fbdev: imxfb: switch to DEFINE_SIMPLE_DEV_PM_OPS
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230628132652.87202-1-martin@kaiser.cx>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230628132652.87202-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UJmk3kDYtKsx9v8NINHGRE4AmIzh149vn7KQFoeF222OUiWAlwQ
 yhpu6zpLfmmxwnnZIP5W2bqI2d6yJmN+xs/Mj3tsKIyq6PGKCeaN96ncUkTWpVbPa5nGBgH
 5Rro5Vk9IR4TX1iDU+lHXTN27y3J6dids0L4eA00rfjbcrbNWWudJjI4IykIsQZJT8Bv+cn
 YOi6ZXIM2FBRVCjrzIqgA==
UI-OutboundReport: notjunk:1;M01:P0:OzRIr3icWdo=;uFSp3F0P2MjpucVdZ7yC5En2sZ/
 DPCdCYXIE4a584xpGHo8/5foXPF9YZZk3v4x5ZTp6JTZrfgySSUH30vIBjH2iuXxK1vwH5mVn
 IPfIRsxSzs5mJWqfRczMKe1hmCAdy/5mZEeGNMmAf9Ft9QJbQn1W3FTZAf0tjmA/ZqQN7lPiq
 9bbZC2izISPqfdKbeHavme6Jl+c9zpDaO4giyiZgmMBV4nuoBRtazkaoyo1oBmTJT+W1jrS4g
 yEuybnm8UbI0s0UOupVSXh7XqdQDAODHG/HYI1VB5B4HCedsJ+8ndhWlgFoVwevKiDWpAp+L5
 73XoJTWrqAz9HXAtbGhfBLfH8N5WsE4ChJGCD3duwzFm23CxyIsmCr4XeJXvXllnCA4pmTRpS
 7GKpVvJiJ8CMEwhAX3GUN6vTL6gWEdrb+pxsYxq5uURGO4LU6nI4X+WQWkSsS/H9vmE9VweR7
 NHei4rTgRXsMhdqThZOMbWmjTnVk4sKzN4hOsTqHNVhLpiIUiR1XR5Pjf4U0I/9cwF/XWa9Zf
 Wdldea/IfoTmivzox/B7g+VS6ke+pkM2T3KmSFxS9s7a7J+R9K3GQGmugg0eVvbDojMroDIPV
 vTCzkm2IHFgEwT0BJLpMBxBC2xXJAa++Hz2Sk+YPNHF+r1gdKNK+zBQ9AYFa+hjjbmjQ0Mpc2
 IZIbnq3pxRh1+lx1868fK5folGFXz58vfcvNpgacutZu83hiDKeibfJ9KvldQwnhQHx7+/ouh
 1TPivBlmbjz3sjYCms18cWjrr6YLsL3wo67TiIYgs/+cxgx38tPGkcXWUSWfUo6yhCUEpOORN
 Yko0s1e0pUt3KQHo/BKVcrrmQylGC5/fpHR2O51rGQ+XbhhU2ufr6ZG5WZ2Ms8kYLMX0VDnVH
 8MbzGuhi4WdCMUSYmWE1iDxzPwuBYu10XDDc4QqN6m8Wun13fbO3TizuKc4ddfOCMApxbvG22
 hP183mz5qBNPSvPEJoQDAWwG/Fg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 15:26, Martin Kaiser wrote:
> SIMPLE_DEV_PM_OPS is deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OP=
S
> and use pm_sleep_ptr for setting the driver's pm routines. We can now
> remove the __maybe_unused qualifier in the suspend and resume functions.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

both patches applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/imxfb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 5fbcb78a9cae..04f3bf30a529 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -1066,7 +1066,7 @@ static void imxfb_remove(struct platform_device *p=
dev)
>   	framebuffer_release(info);
>   }
>
> -static int __maybe_unused imxfb_suspend(struct device *dev)
> +static int imxfb_suspend(struct device *dev)
>   {
>   	struct fb_info *info =3D dev_get_drvdata(dev);
>   	struct imxfb_info *fbi =3D info->par;
> @@ -1076,7 +1076,7 @@ static int __maybe_unused imxfb_suspend(struct dev=
ice *dev)
>   	return 0;
>   }
>
> -static int __maybe_unused imxfb_resume(struct device *dev)
> +static int imxfb_resume(struct device *dev)
>   {
>   	struct fb_info *info =3D dev_get_drvdata(dev);
>   	struct imxfb_info *fbi =3D info->par;
> @@ -1086,13 +1086,13 @@ static int __maybe_unused imxfb_resume(struct de=
vice *dev)
>   	return 0;
>   }
>
> -static SIMPLE_DEV_PM_OPS(imxfb_pm_ops, imxfb_suspend, imxfb_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(imxfb_pm_ops, imxfb_suspend, imxfb_resu=
me);
>
>   static struct platform_driver imxfb_driver =3D {
>   	.driver		=3D {
>   		.name	=3D DRIVER_NAME,
>   		.of_match_table =3D imxfb_of_dev_id,
> -		.pm	=3D &imxfb_pm_ops,
> +		.pm	=3D pm_sleep_ptr(&imxfb_pm_ops),
>   	},
>   	.probe		=3D imxfb_probe,
>   	.remove_new	=3D imxfb_remove,

