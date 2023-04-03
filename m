Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB96D4C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjDCPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjDCPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:36:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85007212E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:36:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l37so17361685wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680536201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36U2ODXozF5pK2igNm59zmr3WO0Khg7qUSKHoeCIVWg=;
        b=BwhoJqaLNoSSLvyTTvqW2nbcAZCdpTdsmovvaVb46KV8S92dsIpcEftkCQPkVmRicT
         di3DThQ76Jz7UWmuKb2Z+xmLg8C7CINouWrhKwmNiyT/3pwEFnaOyhwb2jA7W3kOHCqi
         XNcKS5fu7J91yI0Mbbd0Wep/f27+bMZHv9bn08qHAye7QpYEEOCyANigbqe4PAea7qav
         gK3mRThCvxzYVnP1otso0mwRZjXIyGIjYi0XX8RPiytPzBvNRe8GrWNBY+jV4vmOk7Y6
         RFlY9NLj9xZYbh96VHzvCpUk7nQE5E9szTOdziOjDrG+a05ijkuPPzur2hzRlOY3oZ8o
         sQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36U2ODXozF5pK2igNm59zmr3WO0Khg7qUSKHoeCIVWg=;
        b=cAUU7wbIjuTug/Hm55f9QaaXyAk1NSH6Q0CrtQm1Q+ReOFJMeUIow6NJCf7LXMG3M4
         XxNEapts2ZqrUZEf2kbfEHqyuskb/kfUdodhfYPUVP56mrazdEJ8mhg3k+rqwQRLZdkR
         J+EGiT+4CmZ4TAp42uMnTv2TETjvAOBq4KAp306Tn3+w7Z0rfCZLg9DiTn8qDC1uOflq
         auIJxT7HqGG0MBi9QjvjuzFRFOVdkJblgiPq3mCUyPaUOm3Jd8LQlGK6xUCqZv6HHzbw
         SOEHahKkFSQ89VDtVBzvI4mOTuWAVyv20JWfyvFr+Sm8vcy/bDQc7rsH7jxnGMQmjFES
         0H9Q==
X-Gm-Message-State: AO0yUKUL8bZjH0XNUoS+RcW1Hhx4zQDhZHSLhFj7u20Ohycz61dz4Ef0
        3dTNkZ1YmLOEKq1A7K4DOh4=
X-Google-Smtp-Source: AK7set8/sU4cta/hloqerAxo76VH1Rd5+pxr7aQzErcOpUbbqvbepfu9Plu/0J3se17SDrn0HIgzvQ==
X-Received: by 2002:a05:600c:22cd:b0:3eb:29fe:7343 with SMTP id 13-20020a05600c22cd00b003eb29fe7343mr25598754wmg.33.1680536200817;
        Mon, 03 Apr 2023 08:36:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p1-20020a7bcc81000000b003ef5b011b30sm12426240wma.8.2023.04.03.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:36:40 -0700 (PDT)
Date:   Mon, 3 Apr 2023 18:36:36 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Liliang Ye <yll@hust.edu.cn>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        hust-os-kernel-patches@googlegroups.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl_mqs: move of_node_put() to the correct
 location
Message-ID: <a256ab25-bafa-4600-ab90-522bf90103fb@kili.mountain>
References: <20230403152647.17638-1-yll@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403152647.17638-1-yll@hust.edu.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:26:47PM +0800, Liliang Ye wrote:
> of_node_put() should have been done directly after
> mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
> otherwise it creates a reference leak on the success path.
> 
> To fix this, of_node_put() is moved to the correct location, and change
> all the gotos to direct returns.
> 
> Fixes: a9d273671440 ("ASoC: fsl_mqs: Fix error handling in probe")
> Signed-off-by: Liliang Ye <yll@hust.edu.cn>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> ---

These patches are from a university.  I think this patch was based on
manual review rather than static analysis.  They have not been tested
and this one affects the success path so that's always extra risky.

However I do believe the patch is correct and reviewed it before it was
sent publically.

regards,
dan carpenter

