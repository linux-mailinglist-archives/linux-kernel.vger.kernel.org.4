Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69582690BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjBIOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjBIOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:32:45 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87211EAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:32:37 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16aca2628c6so512835fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LKj6y9Z9IvpBl0jxMUlOB98r+8XwPKm+/9oH/+jgH+A=;
        b=IVDPMcPlukIfsCfo145XvWKWae7B04hhyFiWBRq9J+K6aWc+cyQh85M/m5/2zmAOkG
         OLC6Akt28l95cibrdjMYdYpex34u9PyPw4TtJYy6lRygGxsbG/0fHcpAcqGSWPn2fItQ
         o6YAsZ5sN2//jS4bMg3QZCXoVBPxwTDUm8li0L8cnTe1HwtznWrpTAHf1n/rP6T6X2H2
         ef7xbl41/mFGCXsWpeYqU71AlU2DziUXhGYDNYmaBlVSMfJLYarlVBxIKo234lYN0quM
         dZTsMBjur/UststIY4hWvDhvCiny5o1ZnHoGxB6HqtSf6Sju9GssX040shZAwThUkyVt
         5ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKj6y9Z9IvpBl0jxMUlOB98r+8XwPKm+/9oH/+jgH+A=;
        b=YDx1kHQqeFxr+gB//hZMRxJCp6fqlDS74IwBr05IZDAaNPqb1M/uuYYvSoL93vnPb8
         bIvAPpXsf6zefJbw2nkVF9ew2n9AgMFn9mClOtp3gX+0ppvB4WcoNv7sGelYbBS0DvZK
         qeI5f/oHO2bjHXgSY9AFX4waZg4tjijQVaZRDsda/1Jl4lIPb9ENGjNNRelFv1HaK0yC
         G0+ht3ESaW1j9ASJsWLlPuLaQdJRiXHwdN2NCLia9ApomNyWXWvz1qFYcsGAPxpCfX/N
         jhcmocGtvv0eVbRzTdusklXu0B5MQCiqTrRQDAtqZ9iCPprY43tk6A7ARxcUxOHccYXE
         tetw==
X-Gm-Message-State: AO0yUKVjTeI3J93J8KmkoEF0anSv+lE5MNlyvAFyIgVLkhqbDrt9XJlh
        NIIqum7paCei9L4vymdoHqaJ1EbfKoybFFvyOK8mn0T0
X-Google-Smtp-Source: AK7set+3USxeqX4PBZMGHOkvS2plp2YCQOH/qwTDyDN1wGmHqvN/vX1MIptJN9ZicpG4pHKkIqnl3xdCoWzhtmkbTaw=
X-Received: by 2002:a05:6871:29c:b0:163:8cc6:86a with SMTP id
 i28-20020a056871029c00b001638cc6086amr1084007oae.46.1675953156618; Thu, 09
 Feb 2023 06:32:36 -0800 (PST)
MIME-Version: 1.0
References: <202302091847543326041@zte.com.cn>
In-Reply-To: <202302091847543326041@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Feb 2023 09:32:25 -0500
Message-ID: <CADnq5_MLTxWSVwdd9=WuV63HLRHqfYqos-Myn6VLdSM5Q0FymQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: remove duplicate include header
To:     ye.xingchen@zte.com.cn
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com,
        qingqing.zhuo@amd.com, xinhui.pan@amd.com,
        rodrigo.siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, wenjing.liu@amd.com,
        dri-devel@lists.freedesktop.org, george.shen@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Feb 9, 2023 at 5:48 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> link_hwss.h is included more than once in link_dpms.c .
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
> v1 -> v2
> Fix the U+00A0 non-breaking space in the subject line.
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 9cdfa7f7dc77..0c26b3589608 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -51,7 +51,6 @@
>  #include "link_enc_cfg.h"
>  #include "resource.h"
>  #include "dsc.h"
> -#include "link_hwss.h"
>  #include "dccg.h"
>  #include "clk_mgr.h"
>  #include "atomfirmware.h"
> --
> 2.25.1
