Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB95BBEF5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIRQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIRQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 12:26:16 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDBD91
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:26:15 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MVtTy2FZxz9sLw;
        Sun, 18 Sep 2022 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663518374; bh=lCfXquK6EWEiEcb9sTvw0gOAWM9cgnrwXCfPo/JZM0I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oui1Rrs0VhUYiX0/VF5nJZGRbLpZv7t1DtewUgGUimb19RYRofdTyoBenFR+aSylL
         Y6hHkctt49WZkS1D21ncIhoYXLH0SG8VdbTalq4pKOZwrOyemDTTwWu3smEo7gF3NA
         l4OV8XaYvfgRmm6Xr1vCdacitOyV9LlOCtzmpkng=
X-Riseup-User-ID: 0AA5ED39BAE1FE48A2D23E73CDE3DCB96BF21CA35E708EF1E627E2474DD35EA4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MVtTs39B1z1xx2;
        Sun, 18 Sep 2022 16:26:09 +0000 (UTC)
Message-ID: <2436e241-dd04-bcd3-f832-13e5497e0469@riseup.net>
Date:   Sun, 18 Sep 2022 13:26:06 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        magalilemes00@gmail.com, airlied@linux.ie, maira.canal@usp.br,
        dlatypov@google.com, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, tales.aparecida@gmail.com,
        davidgow@google.com, isabbasso@riseup.net,
        kunit-dev@googlegroups.com
References: <20220828164517.185092-1-jose.exposito89@gmail.com>
 <20220918132240.GA7818@elementary>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220918132240.GA7818@elementary>
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

Hi Jose,

On 9/18/22 10:22, José Expósito wrote:
> Hi!
> 
> On Sun, Aug 28, 2022 at 06:45:14PM +0200, José Expósito wrote:
>> Hello everyone,
>>
>> This series is a follow up on my work adding KUnit test to the XRGB8888
>> conversion functions. This time RGB888, XRGB2101010 and gray8 are added.
>>
>> Best wishes,
>> Jose
>>
>> v1 -> v2:
>>
>>     Tested-by: Maíra Canal <mairacanal@riseup.net>
>>     Reviewed-by: David Gow <davidgow@google.com>
>>
>> v2 -> v3:
>>
>>     Export symbol drm_fb_xrgb8888_to_xrgb2101010()
> 
> This patchset is being in the mailing list for a while. Unless someone
> has a reason to not merge it, I'd like to push it next week.

I believe this patchset doesn't apply anymore due to this patch [1],
that applied a naming convention for the DRM tests. Maybe you could send
a v3 rebasing the patchset.

[1]
https://lore.kernel.org/dri-devel/20220911191756.203118-1-mairacanal@riseup.net/T/#mb794103c8e39cdb76734f4e22ce90806f11d99bc

Best Regards,
- Maíra Canal

> 
> Thanks,
> Jose
>  
>> José Expósito (3):
>>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
>>   drm/format-helper: Add KUnit tests for
>>     drm_fb_xrgb8888_to_xrgb2101010()
>>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
>>
>>  drivers/gpu/drm/drm_format_helper.c           |   1 +
>>  .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
>>  2 files changed, 191 insertions(+)
>>
>>
>> base-commit: 61a9fa154d217c13eea90aa5bc635bc4b1fcb66e
>> -- 
>> 2.25.1
>>
