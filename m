Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6136C9859
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCZWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCZWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:01:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC659FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:01:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k17so8191108ybm.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679868071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nW5Zc8I9D3NwW9JUY8UwDM40P3d6d2p4PO1EwU3IDaI=;
        b=lttfX1kJ6ZctCFBJbQWMDHXaxHbnu4g/vIZsHhvCzMCsHG8wsta1JHfgSA8+nTGo9i
         GTjVry/Ilt1WouW13iOy1ER+vxb6jQmGK6Re+SfNiJswO5v80Ltj+934ZOu22GNA4Dky
         SlSN6yLPHTxe/Vt0qV2hB7UWrIBWTgs2KtXyUPR2T8KPK7FMoIfazqBl/GZGxLme3i6X
         1ld59Ac0M/+x47RyMuMXz19MssYL1s8Dd0wu381+1B2AF6CF3R63lZpUpz/UPGrFi9SO
         Nmy8KbH4p8InCxAtR1RSvwKaEA76UEURU43lmjRRwPfKtsFmgtE+Uo0bUf8qcPMUlPar
         wzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679868071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW5Zc8I9D3NwW9JUY8UwDM40P3d6d2p4PO1EwU3IDaI=;
        b=u0slMYrQIjn2hpzJDATCEYWECIU9PwH2AntGaHp2XNGgWRtyNILnFw3QqGrboJo+dM
         gRL5PGXAnkMfznwIv286KZ4SNWf4hn5ie9PeDpotfPHDlh0s20WrWfDYOQpC8MMWeFr2
         FZg8d/s1fk/Lc+wvapn3dr12ReGO4W1ZiEfqShIpfiLTo3r7Ad5MN0W5t9hGUwhzqhs1
         llr/MHOrvdVj1USBILdlm2qh8fxPtta/Cbg+iTg0n4+XPOiLOYWFBUTQEMCggMV9wxhk
         hPkhKT4gdXZVdq/XdipzmwYIq8++KUNUdaZXo/vmCye3XagBLjoyyDPTejzAceJKQKCM
         53JA==
X-Gm-Message-State: AAQBX9eCrWLdZ26SHNrIeqJMmKqV+NdejZ2ImD8mSx4ROyemAewYtd+A
        44TAb8fkBxk73T204MF9l/WpjtKXWi/Y3hzNYYYAWQ==
X-Google-Smtp-Source: AKy350YT/xl8gofmmkVhwL2aCMeTVFx6UYQ8WocHxT1/FSBcMYEXjfM1wbj2q4875vnX5Bile5Tlmms3fT3yVFoFri8=
X-Received: by 2002:a25:234c:0:b0:b35:91cc:9e29 with SMTP id
 j73-20020a25234c000000b00b3591cc9e29mr6997010ybj.5.1679868071581; Sun, 26 Mar
 2023 15:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230326163813.535762-1-robdclark@gmail.com>
In-Reply-To: <20230326163813.535762-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 01:01:00 +0300
Message-ID: <CAA8EJpp2vhiq5WWaU=shG-tqDjt3pzw-NGTZbMMkx2cyp+ETCg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Rename drm_msm_gem_submit_reloc::or in C++ code
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 at 19:38, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Danylo Piliaiev <dpiliaiev@igalia.com>
>
> Clashes with C++ `or` keyword
>
> Signed-off-by: Danylo Piliaiev <dpiliaiev@igalia.com>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
