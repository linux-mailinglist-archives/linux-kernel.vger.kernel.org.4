Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24560EAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiJZVjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiJZViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:38:55 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969A13A5AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:38:54 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MyMd94dPbz9t1g;
        Wed, 26 Oct 2022 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666820333; bh=DR9ZuA2jI503i7m2Ln1EFsfaplZ1ceRDedCOBNN4phs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mG6LZmEm7jARDa5Pr8FCii4i4uWlGV1DIs+YdODaxRUFX4xL3Z9XCDHCMVsznQMkL
         MHhtvlvFoEf/j8WIGYpbxkPcbcvKU42IVj1HAHpvnxkzbOz0LGqknN9sDWK7AkY4Ip
         rPMwhJbUiILlNOBb3Oqi4DenwE3pwF6FDwIus7iI=
X-Riseup-User-ID: 1BFB477598C653AF8E841CA8C8FF5E3C505961834BD473209E07EF89D7C9BD7B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MyMd610VJz5vVd;
        Wed, 26 Oct 2022 21:38:49 +0000 (UTC)
Message-ID: <c542030e-feed-2e3f-1bcc-65b04fc1c210@riseup.net>
Date:   Wed, 26 Oct 2022 18:38:38 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/tests: Add back seed value information
Content-Language: en-US
To:     Arthur Grillo <arthurgrillo@riseup.net>
Cc:     dri-devel@lists.freedesktop.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, melissa.srw@gmail.com,
        =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
References: <20221026211458.68432-1-arthurgrillo@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20221026211458.68432-1-arthurgrillo@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grillo :)

On 10/26/22 18:14, Arthur Grillo wrote:
> As reported by Michał the drm_mm and drm_buddy unit tests lost the
> printk with seed value after they being refactored into kunit. This
> patch adds back this important information to assure reproducibility
> converting them to use the kunit api.
> 

You should write you commit message in imperative form, like "Add back 
this important [...]"

> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> Reported-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>   drivers/gpu/drm/tests/drm_buddy_test.c | 3 +++
>   drivers/gpu/drm/tests/drm_mm_test.c    | 4 +++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 62f69589a72d..83c8863bc643 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -731,6 +731,9 @@ static int drm_buddy_init_test(struct kunit *test)
>   	while (!random_seed)
>   		random_seed = get_random_u32();
>   
> +	kunit_info("Testing DRM buddy manager (struct drm_buddy), with random_seed=0x%x\n",

DRM buddy manager (struct drm_buddy)

seems a bit redundant to me.

> +		random_seed);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index c4b66eeae203..492347069d58 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -2214,6 +2214,9 @@ static int drm_mm_init_test(struct kunit *test)
>   	while (!random_seed)
>   		random_seed = get_random_u32();
>   
> +	kunit_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
> +	random_seed, max_iterations, max_prime);
> +
>   	return 0;
>   }
>   
> @@ -2251,6 +2254,5 @@ static struct kunit_suite drm_mm_test_suite = {
>   };
>   
>   kunit_test_suite(drm_mm_test_suite);
> -
>   MODULE_AUTHOR("Intel Corporation");
>   MODULE_LICENSE("GPL");
