Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB56C0378
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCSR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSR2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:28:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2C4C24;
        Sun, 19 Mar 2023 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679246870; i=deller@gmx.de;
        bh=pGgSjCEmWeDil7zrhTyjLq3b1K8MW/82h+HLFgzvdGw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=G0eoyGz54Ard7r5tc1yXVag3ZAclH2inRTJ3vtTh//ncM/7PpcURBbtBQElTREKJL
         suuGBeMm1+agJIbaSRXR5cvVmo5zgWt2iaKej8S3TXOLmZrAy5ehPmTBnltr2daHdC
         jtdb4cer6z2yAb90OI1GvrXlTZIjfTd5fRH0WZTVCY3NvMjnVeXzdMVVCXrhvNJC0h
         VxZ1RvaDCdiEeauLwPSgtoW4CdyY0TPkhz7YV+0VFMK72/f+jbqIF6oH4P6e/AhfAL
         WfACfUsHPaKm4UQ/usrP9+IBJrA9fnJTRLPxk/Rx1/cYmVRRFNPOoyFSozkRukAZhs
         QNejggK/ZKsJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1ppRI00jhu-00NmMi; Sun, 19
 Mar 2023 18:27:50 +0100
Message-ID: <ea59e85a-5d0f-e51d-6175-60713664ceb2@gmx.de>
Date:   Sun, 19 Mar 2023 18:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] video: ARM CLCD: Use of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230319163241.226984-1-robh@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230319163241.226984-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xUXmNB+W6FxYtcdyXxshqnZDIpBervrOU4jbTnwZ0hnLYM/TRei
 hnfUBeq53PrnQ2w2/qgv41PBDQ+AGd4h7JWotvFFbz7ka//KLhzn53n6ZJEC9ZeINd6Cys3
 RBBjsne65fXGhQBuMKXPz3TFT/cbtOzDIQThjTHxEfQU/uwgbTVedGRNfrYBj/8WGT99j/J
 2O86jKMUgmGusnOG56WNg==
UI-OutboundReport: notjunk:1;M01:P0:6BcQ5ovVnyo=;orot5fBFxHGC9d86342vTEEufgn
 EOyGxo0laYA4It9x/tV0hH9uA8s7g8D9CnIGVGREZjH6cNgcelDbjp7hkhDGyatXvE8E5GdlM
 ryQxFwUck7DaQcf+bl7nZkWABvI6aRmTZHj8c+fRPPs+oPIOrfJ5feM1t1WXzWQzD0gTZ1bLc
 vTUoUKKPOvjc8Dm9K8PC12b3wnIiyx3lDuebJk/MCYeemivZRPKawWuThMjWZCSMWE/N9DIGD
 Z8Qm9CftbGFEL6FS8rRjKj+j30EKdxTSD/qkTRj9MKe2MX8hS1zqkxsK2jZ1xE3V+Gj2yGx3M
 DIiwSCqAEhHQ2gct7byS2Spg3ZM5nLWUhHMhavu/UahfW5Ze8wfiAz9kGsycKriGl62bJsm2t
 RqhDwI5fsNFrb3Nxzz+A/aELa588OZn8ydpnoOZ4nDJhPTMVNNRdEgVgY58PVxqACG/41i4Yn
 4LB55kmRNVQ8d8sTIlkME1CyBHqfV603UXSABg0TOSFqwduu1sl3DvsVQsAb9UDWSeKoLtC/l
 8ifsJjFZWvx0AARoO34PL0meQ9GtwdeXU55k53Ix3en5NyQ2ONZxzdIjWHCroLjvGDeQnI2EN
 dQh6T2cbs/FBQsSCJiwEpDDP+5QEi0E59J8iF6wauyuZnWypsz1IGaj0jXVdV5vQ0Yr9q5G3e
 6sXxYMm/dj8j4We34B1TJNoad6nUJxIAYvVuRPASXiIBr//9bEUBMjxtzcAO/rJqJ+8nTenVC
 ivfByro7y2HghuOL3pjEZ6PipJJTQ4yvMRthAFUqQsZnlms5L8ZuePGIHO11fnME4wbV+NdO7
 2FSmwGGuX5UPsnNuIKdwnZJBRCVWsejTiVp57skhoVN5lV4aDx/4G/EKql1Se91dzfhdxd76C
 pP5yQ53dsd3ZS7Gh1/Z6artqJP0rKODtHdbC8LIQF7hMHP3jBL4ZyKEWnp3ya6h2kcYoeO4Fb
 knkGpEr1r1bkebVf8sDMf1URJB4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/23 17:32, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() with single call
> to of_address_to_resource(). With this, use ioremap() instead of
> of_iomap() which would parse "reg" a second time.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

applied.

Thanks!
Helge


> ---
>   drivers/video/fbdev/amba-clcd.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-=
clcd.c
> index f65c96d1394d..1289bfe6e872 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -759,7 +759,7 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
>   {
>   	int err;
>   	struct device_node *memory;
> -	u64 size;
> +	struct resource res;
>
>   	err =3D clcdfb_of_init_display(fb);
>   	if (err)
> @@ -769,18 +769,20 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb=
)
>   	if (!memory)
>   		return -ENODEV;
>
> -	fb->fb.screen_base =3D of_iomap(memory, 0);
> -	if (!fb->fb.screen_base) {
> -		of_node_put(memory);
> -		return -ENOMEM;
> -	}
>
> -	fb->fb.fix.smem_start =3D of_translate_address(memory,
> -			of_get_address(memory, 0, &size, NULL));
> -	fb->fb.fix.smem_len =3D size;
> -	of_node_put(memory);
> +	err =3D of_address_to_resource(memory, 0, &res);
> +	if (err)
> +		goto out;
>
> -	return 0;
> +	fb->fb.screen_base =3D ioremap(res.start, resource_size(&res));
> +	if (!fb->fb.screen_base)
> +		goto out;
> +
> +	fb->fb.fix.smem_start =3D res.start;
> +	fb->fb.fix.smem_len =3D resource_size(&res);
> +out:
> +	of_node_put(memory);
> +	return err;
>   }
>
>   static int clcdfb_of_vram_mmap(struct clcd_fb *fb, struct vm_area_stru=
ct *vma)

