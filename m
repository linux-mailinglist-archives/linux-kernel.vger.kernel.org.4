Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673BA5B5991
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiILLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiILLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:46:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F13C17F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:46:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id wc11so4963284ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=dU6qTsmX+AR4sN4oTS+ciGVK85MYdIPdrKWG8ScWOgNhX7cCJ1mgYJErWyquyiWpR8
         ZKKXhlelu5FWOHV4vLu1oUfC5+RQIt9Ek3b1XvEU2+pbFQS3DjW/sRiQ9mpmtYKFpISA
         G7UoxEOCCHg4KJd2JKkNxXrmyhBpYN9IeX9zEGX+KAwnwG3rBFC7NbXuTA+I1IuDUlSI
         PES1FOqjb1RRn8F8dtr/015vox2A4xpyxn7gc7vE/5NKqBqkl+LMINRYjncSuj+fqY18
         7M4szXd5CGWL60jmccOgh2ugbDNV3xsSe7bSJjCGmWPXFnj1IGzRCjKMnDXz8tbBvJg3
         R06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=PPYxO7MmtcpIqP6lB+a2OxZmVbhfHpq07GGR+HqIR1bgiFZYpMrvHnGL3e0j1B7mHC
         kFgIz7jsdDC3Rq6JAEe/6EMGrC+yecr4DhIXiageI+jGPrmFY9uHX+T0ye0dKKSX2+VI
         GTg4oopIWDTQvo+0RdG6lswF8vfJOtL1AAON0MEU0zEBh/NTSHLaH8BEdofI0kVHTl5O
         rV3HReO9lZhHAld+f6/zVfXc7g/esViFyKzNW9JqyNBbSHsH66ALAlxqTYECaSD7YHg6
         TvtdJsJ2SH/8KOtUzi0fEdlF4QP+YPcaByGhK4MwAMhR2eB/LIKlY1cpC77PKiYjIPUp
         hx5w==
X-Gm-Message-State: ACgBeo1vqt7xkNd6GoOhSQ3c2ms9nvvU2NZgz9zqt4oBKHNqPwrnCgjt
        S6uVSSk1m9v6PL7kSJVTxoJruL+CL6urFTvJimZr4Q==
X-Google-Smtp-Source: AA6agR4itWEF5fG4C5Mcg4cNALXMb1B1eC0ZYWG9pXsheQJmPgQNvBk382aGfE0updA8rpqzChb4xjGhpIx3cChP2Gs=
X-Received: by 2002:a17:907:94d0:b0:77e:c2e5:a35e with SMTP id
 dn16-20020a17090794d000b0077ec2e5a35emr1638818ejc.648.1662983160325; Mon, 12
 Sep 2022 04:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220910224816.15058-1-someguy@effective-light.com> <eb8173f6-74cb-3010-f1c2-5eac6939e1f7@collabora.com>
In-Reply-To: <eb8173f6-74cb-3010-f1c2-5eac6939e1f7@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 12 Sep 2022 13:45:49 +0200
Message-ID: <CAG3jFyt-6-i1aYJ4ntTNqd__EnYejvMnfi_NEgXHOd+U9xtYJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: use drm_debug_enabled() in it6505_debug_print()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
