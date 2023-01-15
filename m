Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2166B3F7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAOUxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjAOUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:53:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0387CC09;
        Sun, 15 Jan 2023 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673815983; bh=45L2L28GNcnhB3rxUq2EtpTvB5BL2cm6rdlZA5WHnTk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hyLrnCmZrUo6XGOoa8Xc8jZE7sZQykTLks/zhgmpuf/hBCxFI4PfoZtj2xxbh4f/A
         uvy/FyscpwmrgCa5IgDYZzPrboKZoHaCvMANz73SIdW1b6rSdRMDIwpfo5iaBviDhB
         nabOatXR3fdIFO1sv+amfvRPZ0vmfE5Im4X354kxrFHv10QUajJLQd/iuhTye0LeUc
         0WiWyJTswc3+IWR8hgGmspsqXevpSE2MY96RkO++BLPSYxix1WTjl5z1bn3pmiS18W
         ubTHCs1uvJq94S7/ndjd94l/57FIP4kQsyr8VkRcx2EAJ4jxDfGgROj/yy296Nuj0r
         pJirXEZGJi6Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.161.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1oXKbu14mn-00xsS8; Sun, 15
 Jan 2023 21:53:03 +0100
Message-ID: <a336db6c-4168-d60a-df4e-0a9f718077ef@gmx.de>
Date:   Sun, 15 Jan 2023 21:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbdev: fbmon: fix function name in kernel-doc
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230113063639.6940-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230113063639.6940-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FjCiif4xKJA/+y5TK8pRJVMqSAVpWh8PjH7iKrQiI2McE1lWdH
 OtcR4Sc1bEuJdNDNglyfhzNSAWaVzNUgcNNkvokZDm5CJPAbEI+HXziQr4vlRLZO8wIYbpN
 cnnAc2A2+eK1+iTt7TzOg2/Bbibx27kROCal69XYPyPkUEReqjQPRlUtwHhCZww/VW1f8I1
 4HGzCsWsdbABe9shjUJAw==
UI-OutboundReport: notjunk:1;M01:P0:y4w7Y19c440=;XJhwBK/pdPpGXWdm9BLSRlm059J
 eyv+Oby8QbrUjZpgtIviBn8D0sLjGCiNpSswf9Qf8lgR357Wm7yBDYf136tgmkophDpHokcOk
 oBW+AvghBh947wWYQWniAFLJ3yYkWFA6vVNWl7js48IPUcmrD9H+WLiG6Acxcrdoisx99yf28
 ICT5ExtI6vWpS7kkpDA7rxJ4UlhN47ppq2u/RR9/c3eJ3UQYa8OSKCoYv4cyieVlKTr7n9vGK
 BPHI1Z+h71np2rxRdCF4sFe9cqn7AnSIbZ4Yeg8or8a5lyfgQGul/GP8Y2L7yqPnKlUOG8j1y
 lQCofhU8VPv/tkKdu30Ez46fMclIE6i4H3WSzUNyc4iY/5RnBAo9DX9/ePbPDgIRF95ErygfB
 miugrQnoMQjZZNFxnIrxUbStnv7rwzZ1bZXL2o09ceV8GbkjydGqH/9F0QP+bEQpwJfsdCMF2
 HU2xlI/YG+tEfFh7kV3R3CWhRFoMKinsRUIgieZWKPdCKeMBddid01UHjtsj5qxL5N4HrT4Q7
 z1D1tMyRnjuYLdX1wXflojCgx0KNMJkQu5yL+Z8+IK2kYaR1TN+jZGqtmHrih3eFUjXVoeqCQ
 XREjRO33eQx0/dz9f5Xf0jEMRHptezK+0LR1gl7qUh7bJ0WIEIvEP9FMI4/UNWXq0iSpqaiWF
 0ChestTgs5vKfGAYNLtj8ndh2Wi/Jkm2mPOM55bAbPq/mHC5Agc3U8DWwXPizoY9R/gM/3FaQ
 uSM5eJtCw1Zp7N6H+QpyMnQKJ0SmJnWdFbNg/bwlG+0cswrGeUp0iPvZ98Fck4ngPtSPq6wFa
 J7/ZesiFNSDbUYAvbVP0b8IsUU40Fi0FDjkTof8olMQEJfh0FKrJdtIwMMVAO8QwhTZAFjmRX
 byavQONuJnP55bekTEaBEfVCN8buhGtuW7KoPdlkyllxfVRRYQzNi+6PQ9m2w2MhW7WzOVYRa
 qY4YRQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 07:36, Randy Dunlap wrote:
> Fix a kernel-doc warning by correcting the function name in the
> kernel-doc comment:
>
> drivers/video/fbdev/core/fbmon.c:1073: warning: expecting prototype for =
fb_get_hblank_by_freq(). Prototype was for fb_get_hblank_by_hfreq() instea=
d
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/core/fbmon.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fb=
mon.c
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1050,7 +1050,7 @@ static u32 fb_get_vblank(u32 hfreq)
>   }
>
>   /**
> - * fb_get_hblank_by_freq - get horizontal blank time given hfreq
> + * fb_get_hblank_by_hfreq - get horizontal blank time given hfreq
>    * @hfreq: horizontal freq
>    * @xres: horizontal resolution in pixels
>    *

