Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B067B69EE00
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBVEjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjBVEiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:38:54 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DBA31E3F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:38:48 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id d12so2132784uak.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjnhtH64eML55ISxgIP0mbjGK87d9wufZ0dMxupwBB8=;
        b=lqrWBFFqj06m2wFc1tGmWC/sZDK+C19hDP4UIu5cVpbUtFfwJOsq8t6KqUwp+puZTM
         xlxcOhBFLwnQEXS/+AJA6bzHgUSP7bhC3Epgdd6YRaOAUCpXfcYDN21kgpjtnuydVfTS
         xmjsDddgoEcBvU3bv1C7mLsikIeNWew45cDD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjnhtH64eML55ISxgIP0mbjGK87d9wufZ0dMxupwBB8=;
        b=4tvck3DzU9WWgi1ROBDlENHrNuVvwYiVuuta4Z85nNlwBPydyOMu8I4LML4vrnRaGH
         PIED3IlAjuWSdzT9Ivobk+/BeDICBileAZ044HZQEZCDqT3gsVS4tq9Oqkvf+wlMKD+F
         T0BJuiAM0vtCg3xT63MWhXAFFa18Whh393AFWrYR1od+G5ilXHJRiNjlnhPRazn6tYCr
         sjHqdaPlyfiqeIYN69My+rsER/hB7uN0SWgyefhqun1Gjf9Rq8z7MMtXgYSaRQ/D3VrJ
         H2kwub6UDzrnNxfEPKRDRsO7VyVHqDsE79HmMZRHuP2irdwzEGh/589JL06oUw4CSw2M
         Q2Bg==
X-Gm-Message-State: AO0yUKVDHQxWT03Os1gI0eYdrps8Tf1hC3vOQLIv60u8WeipgrtVi7+L
        iCE/+IxTspq9mHCOzon9RpkPe2FTfdK/NAVNpf+M1A==
X-Google-Smtp-Source: AK7set83ZvblSYZh7JNvc7QCFEKUZbLt9LcnNtZrdB1tyX1tEXVX1rHD9xKFOJ5X0MZjFwaqGFlydH4WbQIiF5KY8zE=
X-Received: by 2002:a1f:208d:0:b0:3e8:66ce:a639 with SMTP id
 g135-20020a1f208d000000b003e866cea639mr1238225vkg.2.1677040727547; Tue, 21
 Feb 2023 20:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 12:38:36 +0800
Message-ID: <CAGXv+5FuKJ7ce_tPeOt_+yPw+hZwiiePRHp+QsWBm-sf7UD4Dw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] drm/panfrost: Increase MAX_PM_DOMAINS to 5
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> Increase the MAX_PM_DOMAINS constant from 3 to 5, to support the
> extra power domains required by the Mali-G57 on the MT8192.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
