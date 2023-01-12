Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C76668735
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjALWqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjALWqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:46:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F85EC1E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:45:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c6so21677295pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
        b=YGaM1pN0C8twUIzQgGfKjkYks+VnXiObKg1aQaTkoY3olojecUD3RTItE7YfBzxsXQ
         ap49M0nIV5gwf/pkXPjh3bX8XHcHw2MqaSz2nwdIGfXeyGzq/xzLxr3Cigh1uBhm0PdQ
         xXPPrdT6WSBM60Mci5MPFJD/YztPmxYo5yMbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
        b=G1mXpoP/mTly+4HVzJ3R9xFK6T9pWT8kC4NppGgvzVvQp8WJnF0Kz9xgVW9gnnOtI5
         L8SscvEsllAfKo6KJ6kkdPUqz//SxhuynAPA4hG1csvy8Ml4dJ+Z1YT9YQ0hHFhVWfuk
         WodQTqEyMxA9wkVDOvqRt5vmXUMmbUUxqv4KHvgKeh3RTnyfhrO/XmnnPsOujqKns11x
         iwue8YHKS/yyKblg+4+N0Y16RtgtM59x638NfrPqCBBOe/FvxQjXW3Mk64NRvuFd9j5w
         4pcpeLDuK8Uk17/tjBVWLArefvE3lVJcGZ/abBhzUkVG3rBJMj4Scpl+7vtUU4B01Nwg
         3r4A==
X-Gm-Message-State: AFqh2krAyoLb89dScjRoMO1yagYQFVkzFsOgPuTmQhFP1zM3RXXVgTqf
        cgIJxeXUGvei51GwwyMQOGlQvA==
X-Google-Smtp-Source: AMrXdXvGve+4kNjBvlBdmOxwGLXehsNBREHOMLlomMlydd2DdmmiiiqSkLXYqlPUtwZFaLbLOdvQUw==
X-Received: by 2002:a17:90b:2356:b0:226:e1a0:6596 with SMTP id ms22-20020a17090b235600b00226e1a06596mr8726077pjb.12.1673563541660;
        Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a474700b00219463262desm10980238pjg.39.2023.01.12.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:45:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Coverity: dm_dmub_sw_init(): Incorrect expression
Message-ID: <202301121445.393EAD9B21@keescook>
References: <202301121425.FB249B61B4@keescook>
 <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:39:20PM +0000, Limonciello, Mario wrote:
> This particular one was fixed already in https://patchwork.freedesktop.org/patch/518050/ which got applied today.

Ah-ha; thanks!

-- 
Kees Cook
