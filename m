Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956772A441
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFIUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFIUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4130D8;
        Fri,  9 Jun 2023 13:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43FE65BBC;
        Fri,  9 Jun 2023 20:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA29C433EF;
        Fri,  9 Jun 2023 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686341877;
        bh=wj1b0dkXJQwh8KMgUAauXapvZkooYQVM2RHawbET22c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yx0U0eJO0CUaPux7M5d3t1fAX/XQAC6XJPEKv41+P1S5TuYz/eR7ndXpb/MA5RZQ+
         dfsvWeEsSEskKTqT4ld9+HAOdG4ju7tNmcQ0efY+KW5YndCVI7T6hD8qi2pEmOD+QH
         5a227Dm9DcH7zDPWw+Jy1XIq4PDChFe+n0k3ZM6ZwxNGyLchzfoXOhhU9M6zdbUEkc
         mePEsy73rzGSYrdibBmerLvba9AvRmvTkUcEZ6KlHo+t0O7KtlIbSVkLfL0/V4jbxE
         Vdg3Fg1BNVnrWvclOTfKrB7YI4GMALh6o7bOYuOtv90f1rw2JT8w8dRrh3LJWXO34c
         8E+fmtTSLan7Q==
Date:   Fri, 9 Jun 2023 13:17:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] drm/amd/amdgpu: enable W=1 for amdgpu
Message-ID: <20230609201754.GA3961359@dev-arch.thelio-3990X>
References: <20230609164207.430377-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609164207.430377-1-hamza.mahfooz@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Masahiro and linux-kbuild

On Fri, Jun 09, 2023 at 12:42:06PM -0400, Hamza Mahfooz wrote:
> We have a clean build with W=1 as of
> commit 12a15dd589ac ("drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Move
> SYNAPTICS_DEVICE_ID into CONFIG_DRM_AMD_DC_DCN ifdef"). So, let's enable
> these checks unconditionally for the entire module to catch these errors
> during development.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

I think this is fine, especially since it will help catch issues in
amdgpu quickly and hopefully encourage developers to fix their problems
before they make it to a tree with wider impact lika -next.

However, this is now the third place that W=1 has been effectively
enabled (i915 and btrfs are the other two I know of) and it would be
nice if this was a little more unified, especially since it is not
uncommon for the warnings under W=1 to shift around and keeping them
unified will make maintainence over the longer term a little easier. I
am not sure if this has been brought up in the past and I don't want to
hold up this change but I suspect this sentiment of wanting to enable
W=1 on a per-subsystem basis is going to continue to grow.

Regardless, for clang 11.1.0 to 16.0.5, I see no warnings when building
drivers/gpu/drm/amd/amdgpu/ with Arch Linux's configuration or
allmodconfig.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 86b833085f19..8d16f280b695 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -40,7 +40,18 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>  	-I$(FULL_AMD_PATH)/amdkfd
>  
>  subdir-ccflags-y := -Wextra
> -subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
> +subdir-ccflags-y += -Wunused
> +subdir-ccflags-y += -Wmissing-prototypes
> +subdir-ccflags-y += -Wmissing-declarations
> +subdir-ccflags-y += -Wmissing-include-dirs
> +subdir-ccflags-y += -Wold-style-definition
> +subdir-ccflags-y += -Wmissing-format-attribute
> +# Need this to avoid recursive variable evaluation issues
> +cond-flags := $(call cc-option, -Wunused-but-set-variable) \
> +	$(call cc-option, -Wunused-const-variable) \
> +	$(call cc-option, -Wstringop-truncation) \
> +	$(call cc-option, -Wpacked-not-aligned)
> +subdir-ccflags-y += $(cond-flags)
>  subdir-ccflags-y += -Wno-unused-parameter
>  subdir-ccflags-y += -Wno-type-limits
>  subdir-ccflags-y += -Wno-sign-compare
> -- 
> 2.40.1
> 
