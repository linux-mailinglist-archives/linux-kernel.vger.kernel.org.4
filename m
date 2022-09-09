Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680945B4105
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIIUry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiIIUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:47:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B51AF4A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:47:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso1821735otb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ctBj19lXOSEAyh1C28UnDwMWPyBLl2d98Ybb5NQ3Hpo=;
        b=iuGPTsfMp1NLIEZHZAPWw5d6sEmLrxK3sDvVQ62rW3vFn4NnGwKgcKlPopYhtpt3Y0
         G1TFMRos64Y9tcPqSTvAlGxsKYDwHmFcVxSjSBwAKLZCtTPauF2HVlFfgrgOd0tWt6rx
         fPUNODtIJ8u8YEHzakdi/SLg2+8ZQTx8elW1Zfsu1A/MymzVJ7p1uBoA/pY7ogxMLrSD
         bCYYDaT54dWsdJN/sbb9ju6QKcrcyX+nsqKehiVwXET2RmvkD47yQsiR9V4ImTjmzdKP
         n8RHpNgZ/Pp622K6GtZHBrjY9xpGCB9HAiUgMnFa079xH50MI78jta+EGWh7+USy034Q
         adqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ctBj19lXOSEAyh1C28UnDwMWPyBLl2d98Ybb5NQ3Hpo=;
        b=C7OV1EAktHEHPJ71vHzkzUWtX/xQCCsYcE2WDfDeq3+769NlyU0ssCug6kuRhVijUY
         PcP2/Qow78gctPSqpCSKjK/zIUNxoPV+mD8Cc2XigirhW01H6ioIQb/pPfZtFBhRAnrc
         RmsWS2jeaE1+RyyNvpDL3UvcsXr0DzszeIgDxrLBS8ZKDhEa41vf4GLtKUC29D6JfVsS
         tBghZajuYJcGAukxKlKuPWRJJOKrbV/sxp/6ifhqqXM1YrzGy8He7FSiRkgQe9TudeJ0
         N6BWnXCRe3wOyInWdCMy0hVgN7t10VGW9XTTb7VYwRx3TgYfFoueKTTp6K1OF5LF65D4
         vEfw==
X-Gm-Message-State: ACgBeo1wO4NZWjA5XBmL/Pllv3du7WQYal4JkYsyOCtnAppwffmtGBUK
        ZRE3TdUSDSvFDR7qYsjdAjJHn3mTnBC/3aEB9e0=
X-Google-Smtp-Source: AA6agR4RQJLT8qIZlpEO6stNFrHhIBxAwc918rt2nme3NTrorkRuJjc8eZFzhQc6GM8r3MWq7LGUkYYN7AoldJjmfpU=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr1332692otv.233.1662756428882; Fri, 09
 Sep 2022 13:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220902080401.320050-1-zhang.songyi@zte.com.cn>
In-Reply-To: <20220902080401.320050-1-zhang.songyi@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:46:57 -0400
Message-ID: <CADnq5_NQByVi1dnxzc4jdPX+sKtA6OtU9j-L9M+uGXqvrJP+kA@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, Jack.Xiao@amd.com, airlied@linux.ie,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        ray.huang@amd.com, Stanley.Yang@amd.com,
        dri-devel@lists.freedesktop.org, Likun.Gao@amd.com,
        zhang.songyi@zte.com.cn, christian.koenig@amd.com,
        Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Sep 2, 2022 at 4:04 AM <cgel.zte@gmail.com> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> Return the sdma_v6_0_start() directly instead of storing it in another
> redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 2bc1407e885e..2cc2d851b4eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1373,12 +1373,9 @@ static int sdma_v6_0_sw_fini(void *handle)
>
>  static int sdma_v6_0_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = sdma_v6_0_start(adev);
> -
> -       return r;
> +       return sdma_v6_0_start(adev);
>  }
>
>  static int sdma_v6_0_hw_fini(void *handle)
> --
> 2.25.1
>
>
