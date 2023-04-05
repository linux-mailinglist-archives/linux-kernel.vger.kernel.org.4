Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E76D7F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjDEO1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbjDEO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:27:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1935E4EFD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:27:11 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-545e907790fso564294437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680704830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2CDOKe00GnUjHdkbrE4uqIZXQFd1rirDCgy3XORGC0=;
        b=GlbqkCpig7IPrSTg10DT1HGJE3iQoSZSheTEkp/deI4+kgPyCkyhoySWQ5r3W7NLdd
         FmGo4FMUOjBa1S+ZRhlMQtLzMxvcV3kk1Cmb+Qu3hfkoR+mUd4+27gm5haAPFqTDeMgn
         sLGcXrToa9ecnD4n3NOE27F48KvgYq/ixq1/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2CDOKe00GnUjHdkbrE4uqIZXQFd1rirDCgy3XORGC0=;
        b=VdNZejN+M1i0vS6xSGU/q6UC3BJxN8dl4lpORWx2l39T8knfK7UcovGptBwxyGUagy
         wDxB3zWXXDP/ChtvrsFiT6FyXYXLsnDeBO45tjwt+1EGNZ/eRAiUuY1TQ8BvKOtXe4Xb
         UV+2vEdFmkqmYZ45ZpSYfcBgA7Uj0es2oTMpNxfrbzlJKC6wesC2T7FLGDhBHZvhii87
         WD3jtLUACR1JThcuWAGbjxjXCSmAfb5usnaUmZG1YX8mZR1y04tafjsCdZar267GwuSk
         fXqEeQaz3rygX1jbUCv3ZVQyH/JaJusRwgFp7tDjt+pXVESTFShmdCGbUSMJA0tNH7m6
         F2Kw==
X-Gm-Message-State: AAQBX9cG+bnpw0zjUTS+uRN7JTYTaAJ8H2hWefvbJpBznR3Ay1jxLEFt
        NaFDpPNUCyI3prBVfzJBbERVumhaVh2NSMNBwlj8zg+klVLPWNvbU9bOmA==
X-Google-Smtp-Source: AKy350Y9iYQEAuwm8U51IV0OzmCsUWkboTMxqxuC2KD5swgILlish/b/RdhzJdJOdC+GBvdZWmpSqpuyclhyYclJ2ng=
X-Received: by 2002:a81:c509:0:b0:549:143f:3d3 with SMTP id
 k9-20020a81c509000000b00549143f03d3mr3713100ywi.0.1680704830604; Wed, 05 Apr
 2023 07:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230330012725.124031-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230330012725.124031-1-yang.lee@linux.alibaba.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Apr 2023 19:56:58 +0530
Message-ID: <CAMty3ZCVBCTZ=jRKBmdP1uHQfEK-Fu_vTGx3T0NFOzeAnHhFmQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm: bridge: samsung-dsim: fix platform_no_drv_owner.cocci
 warning
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     inki.dae@samsung.com, neil.armstrong@linaro.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 6:57=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/bridge/samsung-dsim.c:1957:6-11: No need to set .owner =
here. The core will do it.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4640
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
