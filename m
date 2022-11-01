Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87078614E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiKAPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:31:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF7F10DC;
        Tue,  1 Nov 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667316654; bh=LOFb+W8OXqIpGc7LBazim5AxknZKIrWvFrYeZMuLT84=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Y2gfjy8BkKsubSvmjjDFsw4SddC9KZHGtfKvJ+x95z/uUmgnGbppiW4TJFbvfQvbM
         KcqrND/DVOHxsMMOvTVVsC3xMGq1524utz3kGtaiz5uvFFFDL3Y6Rp1DeTWu//QfMy
         l6AuS6ILgBVZZ0qmQtaQ4bg5fnR9+4OqLLlD+/sveOXhBSLmpkmrNDCxBuIQ0suCwr
         QbZFPp6QfgSt5KK4mXwtLr4oL45vOdG/j15B1Swyx+Vdj8ZGf374KpodvuGm9i/FJE
         x4DakXzcW4GjtlILosJFcMUpc4gcXK354iaN7qlZNx7Dcd4j+AsPdAa5+NWDQWCUsr
         MdZeWaByEDViQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.182.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1p6XSc33vw-017W9f; Tue, 01
 Nov 2022 16:30:54 +0100
Message-ID: <5574dc8c-1665-d736-eeda-cbdbef422394@gmx.de>
Date:   Tue, 1 Nov 2022 16:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/2] fbdev: ssd1307fb: Drop optional dependency
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221101150947.67377-1-andriy.shevchenko@linux.intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221101150947.67377-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8q5zU6TltpK9eRNKqOHDOxdbvvn43g6M0iwRoQ2cZQRDsfCKd0
 ahsqBsTSULZESY7rSXzZs2UQkQ6h6Pp7s63Dkqwv0RryReh7i4hVU7hAFIe/G+V7o+pgHkm
 k4pRI+0MxN5KRWCL9dwFWMy4XVzHrAC7+XRYbfY2ayy1uci8q1Jfci81UMA/x2g8lIqoW+6
 d4SkzjnV/WTjuRTyTzQ3A==
UI-OutboundReport: notjunk:1;M01:P0:caIEGPY3TKs=;Hi65LKaBmmaPJ3fLNjmPbtC17nz
 ZgoGhHy4KjtbxohlC+yOLPzmQIRzvUghdnzO7dyd2YNkvnSBiJdPgx1f9+fiYudWkywJg09mQ
 LRqLu0uM8zgARjFU2zwhox7Mk/sf6JVxqovrUxhc0wibJ4xT8fb/c2t6cdmNRIU5N/IN9QoQn
 YE5hgvjSu4ff1egF4dCAL+jKBknVm8wNo2TMbQkU1Vwm2AINPR87Q1QWWpQuUpe3NCarZUoyt
 4Gyb50L1KQBv2k8/2i8ieeV8+dfIFYYV+TuvdcHNq6tlvSoIU2DFCMnnsqgXQOCOjKXdwb0xl
 TC+w1hh4r2rnBBuH5fI1Eik9OZNmE8GfOxaEsILlKMqgdibn7z0VE7T1+eFze9RScmHmT06Ba
 KbCMJt/LuHJ5pUDqGirLoxD+A/5/2nkpMMqhx23IyMSvHvWm2OjiBKVJY2c2biPVuWyJ9pcwv
 vDt5oE6D5aQYOxp8g4OC51rlfET04EWomqSQrMbY+X9X03nm3l6uuibTrWUQAsPUKTARLcGD5
 H1xjyz4L+2kXPcg9RQ1ca3DoO8dwrmgLzrysD5OzoJrrjps+s34lrtHS+uKdMH5nvahXoqN0j
 oFSpQIkXmnEmhG0sNA1hpjztU63ohHWEvegypGmCrvKA9NRz4XZVdcL0fUxyY2pC9BwZkMDWw
 YZov38q/795YBFNLMpmMR8UyJWQFRTKCTuLa/aYdK6jr2oessPXTmVS0jHGwSSPAoqKsEW5W7
 sMznNt+BK6nfH3uw0+Q+viZZgaeXSe77goihLSASGjXJLKArQoNGxv5YdJyQjPBxCmFH10uTD
 j+B9ebH2SZTORYNXFtFgPQANi7pmtVKsSiwMDQRJTSDkKGZNZV1XFMEKBogvYIpDjvrFFq8oy
 frE4q/jedWMRj6XJp5zAHx2J2glAw9aFr+gqxhc0VrF04akQ91Z5iYAEWsWv2+3am1k1aFNgq
 ALzJmXNbYRdxMYbUo17Je7GH81k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 16:09, Andy Shevchenko wrote:
> Only a single out of three devices need a PWM, so from driver it's
> optional. Moreover it's a single driver in the entire kernel that
> currently selects PWM. Unfortunately this selection is a root cause
> of the circular dependencies when we want to enable optional PWM
> for some other drivers that select GPIOLIB.
>
> Fixes: a2ed00da5047 ("drivers/video: add support for the Solomon SSD1307=
 OLED Controller")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Both patches applied to fbdev git tree.

Thanks!
Helge

> ---
>   drivers/video/fbdev/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index a98987aa2784..b88d8bfe992e 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2218,7 +2218,6 @@ config FB_SSD1307
>   	select FB_SYS_COPYAREA
>   	select FB_SYS_IMAGEBLIT
>   	select FB_DEFERRED_IO
> -	select PWM
>   	select FB_BACKLIGHT
>   	help
>   	  This driver implements support for the Solomon SSD1307

