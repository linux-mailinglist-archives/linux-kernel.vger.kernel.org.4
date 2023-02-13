Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAE69408B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBMJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjBMJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:41 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3FB467
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:15:39 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id u8so4907395ilq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKOvhHJRhphSbPBn3so0B0jvZpigwezTNOs/N/XEZ5E=;
        b=NpOzWZNs52fgyDSK1zxl40/0Dx5n4NeCWXkovOvBUzksGQJuoq6r+M0XwUjPUjuDCp
         qWok95Yjwl+m/Az8N2txe+NGa8UJQ6w1D6ZUcOP4ToksLnuXERCRpsxGDlakBAYJgh6s
         Rp0BvUGfcnhQRb2j1HZf4p2P+Tc9Tyj2zYD8AF0KHCWuG4UTkJZvIrnK8l0t7ReoHwxe
         gMnovtxvi8PQmQGD+//6EPW8YdgUNjFdr7vDNlcPbgQzvPQsmrjqn8yHZDpr8z9JPCCT
         piLyeX8Z32ssmSc7mGqQMUdIvdh2+8LlEAOh+/IbJa8x2mxYyZRF2KJ1LQgWht5qXNGF
         6h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKOvhHJRhphSbPBn3so0B0jvZpigwezTNOs/N/XEZ5E=;
        b=KzZnI58fZL+qPaUij0gxZi5JbSMZ9Zis1DE6vovvqwe/pBnVrVNWo0u9uGoT0LBXXB
         xWLXAvfvxHTaj61dyJ7as9qPvPn7ZWrAAuYo910DBsjZh5niIl0n5AUEUnSTs4DpvoQU
         Pk5Ady+Trfo4zwYrP6tu54ZbNwQ+lOHzkwM2fTVQbARA17d3MHIVrCoZajPUFudbmWQp
         jKy0QQu5/GcQNZc9mc3cS6k5Vcyo8Ab9WmEtdZA+GhdCxD9NmrLAHiGmZzeL9RMKqkoP
         a/gwqgf1lfD2NrXXxRFSclz/St53jsIiImLaWizpmZ9wAwiMNqSInj0dEFHmefGoRBWs
         8YYA==
X-Gm-Message-State: AO0yUKW0OEQqkNtE9GmojInw/u80J4DG8mcRcXz7csbMk0ZHQALVqd92
        iNssttxL6cSH9fMmMQ0Zn4FBrw==
X-Google-Smtp-Source: AK7set8THxgVNnrm5T7fH0oGDH5+xMK5o9ph9mqDpQvxPFgROHNMVHH7uqtLR54GHK9o5hhn791ktQ==
X-Received: by 2002:a05:6e02:156b:b0:315:2a3f:5a1d with SMTP id k11-20020a056e02156b00b003152a3f5a1dmr10081627ilu.30.1676279738433;
        Mon, 13 Feb 2023 01:15:38 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:2487:f87c:fb5b:9046? ([2a0e:41a:894f:0:2487:f87c:fb5b:9046])
        by smtp.gmail.com with ESMTPSA id q11-20020a92050b000000b0030c68d38255sm3639612ile.38.2023.02.13.01.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:15:37 -0800 (PST)
Message-ID: <447fa1c7-4992-838f-b5cd-91245deae188@baylibre.com>
Date:   Mon, 13 Feb 2023 10:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] drm/meson/meson_venc: Relax the supported mode checks
Content-Language: en-US
To:     Da Xue <da@lessconfused.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230210-relax_dmt_limits-v1-0-a1474624d530@baylibre.com>
 <CACdvmAgKrRMdX+R0nScGwazq7C=f=B_k-2w-ONk_iCyM_XAnSA@mail.gmail.com>
From:   Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <CACdvmAgKrRMdX+R0nScGwazq7C=f=B_k-2w-ONk_iCyM_XAnSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 08:09, Da Xue wrote:

>     -       if (mode->hdisplay < 640 || mode->hdisplay > 1920)
>     +       if (mode->hdisplay < 480 || mode->hdisplay > 1920)
>                      return MODE_BAD_HVALUE;
> 
>     -       if (mode->vdisplay < 480 || mode->vdisplay > 1200)
>     +       if (mode->vdisplay < 480 || mode->vdisplay > 1920)
>                      return MODE_BAD_VVALUE;
> 
> Should these be lowered to 400 instead of 480?

If you want to support 400x1280 then we need to tweak mode->hdisplay as 
well.

I'll push a v2.

-- 
Carlo Caione

