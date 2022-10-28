Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB2611BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJ1UzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJ1Uy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:54:59 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E84525290
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:54:50 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MzZYP5kP1z9sNV;
        Fri, 28 Oct 2022 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666990490; bh=qu4T1UVN0jQRdhupG16JY63wa4HUyVvIw/bgINVvosA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gP4d/zoqAwFgE+RynjkJpRPfN4H7styT86iBirjV5uMhTiAy+cZYWwBsMAMffgLP9
         4MdM6mjTb64ULA2cZ3CWMdlWEX56IZgMOHIilNqNsPwNoxkc2xaGG+Tsfa2322y+Ru
         SSmV60r9FkxvqWUDwBvi3LcknMVfsEIKhlbHOBkA=
X-Riseup-User-ID: 8C4B558F0986691C6DEDEED7AB1412EB7E7987B9881D003CD3E43A7845713F73
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MzZYK1lqYz5vTk;
        Fri, 28 Oct 2022 20:54:45 +0000 (UTC)
Message-ID: <97fb8a27-e547-5bbb-f148-5d3d7630749f@riseup.net>
Date:   Fri, 28 Oct 2022 17:54:42 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v4] drm/tests: Add back seed value information
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, andrealmeid@riseup.net,
        melissa.srw@gmail.com,
        =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
References: <20221028141715.290903-1-arthurgrillo@riseup.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221028141715.290903-1-arthurgrillo@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

Just a small nit below, but besides that:

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

On 10/28/22 11:17, Arthur Grillo wrote:
> As reported by Michał the drm_mm and drm_buddy unit tests lost the
> printk with seed value after they were refactored into KUnit.
> 
> Add kunit_info with seed value information to assure reproducibility.
> 
> Reported-by: Michał Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
> v1->v2: https://lore.kernel.org/all/20221026211458.68432-1-arthurgrillo@riseup.net/
> - Correct compilation issues
> - Change tags order
> - Remove useless line change
> - Write commit message in imperative form
> - Remove redundant message part
> - Correct some grammars nits
> - Correct checkpatch issues
> 
> v2->v3: https://lore.kernel.org/all/20221027142903.200169-1-arthurgrillo@riseup.net/
> - Change .init to .suite_init
> - Correct some grammars nits
> 
> v3->v4:
> - Correct compilation issues
> 
> ---
>  drivers/gpu/drm/tests/drm_buddy_test.c | 6 ++++--
>  drivers/gpu/drm/tests/drm_mm_test.c    | 8 ++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 62f69589a72d..90ec5e8a485b 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -726,11 +726,13 @@ static void drm_test_buddy_alloc_limit(struct kunit *test)
>  	drm_buddy_fini(&mm);
>  }
>  
> -static int drm_buddy_init_test(struct kunit *test)
> +static int drm_buddy_init_suite(struct kunit_suite *suite)

Just to keep complaint to the rest of the KUnit tests (such as kcsan,
kfence, kmsan), could you change "init_suite" to "suite_init"? Same
thing for the drm_mm test.

Thanks for the quick respin of the patch!

Best Regards,
- Maíra Canal

>  {
>  	while (!random_seed)
>  		random_seed = get_random_u32();
>  
> +	kunit_info(suite, "Testing DRM buddy manager, with random_seed=0x%x\n", random_seed);
> +
>  	return 0;
>  }
>  
> @@ -746,7 +748,7 @@ static struct kunit_case drm_buddy_tests[] = {
>  
>  static struct kunit_suite drm_buddy_test_suite = {
>  	.name = "drm_buddy",
> -	.init = drm_buddy_init_test,
> +	.suite_init = drm_buddy_init_suite,
>  	.test_cases = drm_buddy_tests,
>  };
>  
