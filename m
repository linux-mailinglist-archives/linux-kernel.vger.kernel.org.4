Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101560B97B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJXUNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiJXUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:12:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C1183DBE;
        Mon, 24 Oct 2022 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666636167;
        bh=icVbzJtZ9pqflJ14jNdNOlB/DYImZ+gyK6fC/SDHPeo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Kkvqf/+txMBi7sxfZs0V/5+nqVslh0tnBxX4/FfBbX4K5PxEYxT5PP/zpCOkVp7bv
         AjdzA1IvFe+Vl83LXPdeQMLwEY5VuZuTJREUOnmXgB7DCslsdCKNZhD1ffx1GoVLqb
         rKyNNUqFB0P2skYG5FNKeRZ8QSxQWKQjW3JNG1LI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.30]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1oqd7434DN-00EaCt; Mon, 24
 Oct 2022 20:29:27 +0200
Message-ID: <ec8edb92-a21b-6291-4275-d7cba97d7ad7@gmx.de>
Date:   Mon, 24 Oct 2022 20:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] video: fbdev: sis: use explicitly signed char
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20221024162901.535972-1-Jason@zx2c4.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221024162901.535972-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgln+OSb5Fs7l921QypIIY6GvbB8Dpo8NbcH6CX//FlDdIZKoPn
 HTH8weoBRqVlYnQaJOUuVnLRopE3hTyC0rQ7NFop1qJoWADAuwh/gwd/DNyU80Z/nBkvvlj
 xLpYb1wKKdGZeA8sSZnuNeBXV4k3vo2v4nRR1R3a5fNPt5ryrwPOPk8q//T+CrXTBvb8tGY
 ylAA2rLff9VDqREvNVy4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YeTgNuQ6oBE=:x+MrTPIRv+ADg3bGSjOX2x
 c8XbmCSjtFftDhFgoBgA63vaJowCwC+3di5UjTuwo1cjyBDugLxf99Ls4mxXN6KNNLDlOGAj3
 Wl6mR0AP9W+8LUZDKcgR9x2KCpFAxB7TRmVgTZk88Hvdh10HEecFZtsnjASzNO8/2eG8/PskI
 zCW1cPfDSUtI/WSbPa7xipFxEn0bVZTrkHYJEJucNxTHt47sb0MMTLPuKU305/eTDuJh2MnFy
 N7dUAut84zTqvFUU4rVzQEaytLznUNTgQWuMw8iJhg0Y9r1gxdBobn/uS7A7UwpBfvcO95+la
 ExXo7tBr/QBo2R1zZFQqkWyLFfgq3Ucb+aUoRrs8RCU5lp3A+epBw+c2uzINC6vK/bTysxH4u
 74VxveNrMEvEJeCuNwYfaQuCUZWS03JmRx0e8zzV08dapRsrcIyXp90UUGCB0ofpbwRdKa6z4
 iVJS+44cs4OdFyrWLx+JvO3V2lW2Ha1db3TeAI9VZOZvaWPWtO6g3smWISdQxmx26grR9QzR8
 lJ7/VCImckMTs7vQOJleMD4MEatVye+/uZlIWjiuxRpIOwD4mH23TQvkwYlVXhNnZB/5GsqLz
 VUqAexb1W2LapEPynIWtHfq6YnO/C6tIguZH2VlDJctLyBTyY5Ldteibfif7AdyVT3wbM3fg2
 n5zXbAYkC8SArLNKh7IcZp/j+BSvyWaVeWjbChcVR4rtPN+mKVI1BPOUYspQKnVDix+qvsoSE
 uLcConOmvdqLBSSqMr/QhnSEN8rMQhQdcMJxiNm60kLCxDxmZPMBEQ/gcuWMJjIfQdxzCQzXx
 XMUEoYR2xhoeI2ejsM8HtXUrRjSf1Apkwn2dlggGOeQrwU6mA+BQiIYmNFITAcbeVZxxG6x8O
 746n9OVaOt4FrW0BToKm4gwFWCF1UFE3c/CEWVbzDYx73EzfCMuD/Z/dtVcAYNxxwjhNnFDp5
 8utlguY9KCJgr07er4rwSu0GsC3jknq0TAIeME9v16xKSDcc2TIVpo976zBvonR0+MPybIcCM
 h2H2g5OJOn9BrqbcG9Fk4omj8xfqBjsC2nI7ULK4ZNtwSNkL4RWX1lUChj6VQVFEHo5ptjBdt
 UYRiyhO9rWcu/rgcBPXb83TqbyZiBMwK61+QvZcn0+DacPRzUpqe9iHCYEohp87oJsMkDWf7g
 5tWzTVkU2WEhcEoBQOaIM9TLnOhpui0xVHCt3i2ChLG+oBQnDCdeqVmhOuP3nugZ4AFSHjm5s
 1Vj1RWF2rhVPMK22jsLg7C4VPdecfyXbhtdJXGBCMdC5/PesfYAfQcVD1YpLkNrA9PuFXEDXh
 RC9SkKW4N7S/kPU5B8dCwYXVWnbtCTZlsjLfNmRqDveBSnMo782+7qGudFzP/fPnD3AzOq2WG
 C4txTHKBUgDkTOOgru1dp0fjnM5oXhkcvzC4mApzEc+DFHwaxpAHbIp2ScSj95wpB6eVqAIlb
 sXZ20FkJ2MN+Mk7WiXrpUkwEEJdEn2cTKNP1vqFwpg4tR3vGSP7j4/hbYLpbli5f3N1phP2fq
 r6dpFpstHxDSUm+0+SFiELW5DZ+6atWpEcW35DAGYFASa
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 18:29, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. This fixes warnings like:
>
> drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_P=
r->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Applied to linux-fbdev git tree.

Thanks,
Helge


> ---
>   drivers/usb/misc/sisusbvga/sisusb_struct.h | 2 +-
>   drivers/video/fbdev/sis/vstruct.h          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/misc/sisusbvga/sisusb_struct.h b/drivers/usb/mi=
sc/sisusbvga/sisusb_struct.h
> index 3df64d2a9d43..a86032a26d36 100644
> --- a/drivers/usb/misc/sisusbvga/sisusb_struct.h
> +++ b/drivers/usb/misc/sisusbvga/sisusb_struct.h
> @@ -91,7 +91,7 @@ struct SiS_Ext {
>   	unsigned char VB_ExtTVYFilterIndex;
>   	unsigned char VB_ExtTVYFilterIndexROM661;
>   	unsigned char REFindex;
> -	char ROMMODEIDX661;
> +	signed char ROMMODEIDX661;
>   };
>
>   struct SiS_Ext2 {
> diff --git a/drivers/video/fbdev/sis/vstruct.h b/drivers/video/fbdev/sis=
/vstruct.h
> index ea94d214dcff..d7a14e63ba5a 100644
> --- a/drivers/video/fbdev/sis/vstruct.h
> +++ b/drivers/video/fbdev/sis/vstruct.h
> @@ -148,7 +148,7 @@ struct SiS_Ext {
>   	unsigned char  VB_ExtTVYFilterIndex;
>   	unsigned char  VB_ExtTVYFilterIndexROM661;
>   	unsigned char  REFindex;
> -	char           ROMMODEIDX661;
> +	signed char    ROMMODEIDX661;
>   };
>
>   struct SiS_Ext2 {

