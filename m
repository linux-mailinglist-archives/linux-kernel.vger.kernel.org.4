Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879A607D69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJURWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJURVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:21:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4E24B31F;
        Fri, 21 Oct 2022 10:21:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u15so3967771oie.2;
        Fri, 21 Oct 2022 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6BqgqIxQ+q3oABy/KVS7FxTx0acwuSVWX67BzMj1gk=;
        b=f0nVmiNw0x2GGqQ57S0MHq3NjFd8sUe5YLfcPOwspvxvypgP+cCpLhpNjPq6N6+CXP
         +Q0C/RoViUG+lyDIum7B7rwHu9/lqryapUDDBwzENKf051uyNXPT1Eu9fIgFQ1VFbqZf
         6XkDVmSa9qwO0qiTxQaAgB+yJfoRh3noPTlNLizvy6WRHLxedoEXqVuTmx9ic2Ccaegy
         HI0Xci1CnQUW7bVAVDIttvYeUfCyCf1jH5un9YxdPJlISULB2whXDSj9SPZRlE5Yolgh
         tBAxGNaVZir22XaGDM8po83dHjz7yWQrhde0v7cPOVIvfPX54xGmHI+f6cYmRTkphONF
         KyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6BqgqIxQ+q3oABy/KVS7FxTx0acwuSVWX67BzMj1gk=;
        b=fhNwr5u/bgmykOWLzC1ClZc3x/LsIaXI/huLdmvdksW2qQbZL+MSB3Y5y4qao4OXax
         p/vjCKXVkE0BqoNMvZwlL3dRAiioVbCIp2xo5rIwYSOI6KWTXWNTV7OuQdimJW6io1PU
         7yltb0EeFRzSCUbT7gzEPXw1/Vs0pmCgq0rwp3pq4MMXEPqa5t+u2IVAVQwMArBdIqOE
         MM1LZlIsG1W4L/2KZ6+cfsuTSAf1uaAeL8WP3rqi1ZgchaHsZsA6zFtXxi/tqT64Mc0f
         xYT6EYrmAQjyw7REomDJxYLMJ5K2nmkUYqj5bejUwHpbo8Jo+yGjRoO3hTSPnDo45IkJ
         FTgA==
X-Gm-Message-State: ACrzQf2dslSwytftp/6RZeq4xu0zOQxBIxOeeGgRbfJVVLBJ0ARpSHyz
        /AgiWwx5BPijgkQAmfonVC4=
X-Google-Smtp-Source: AMsMyM6MoqvyIyxliKOCqZiFkvP91AsjRQGjeNSwYlnxadYUwlrS7DJ88HFJP0uITquBRGXm8Nv8tQ==
X-Received: by 2002:a05:6808:1994:b0:354:d97e:d4aa with SMTP id bj20-20020a056808199400b00354d97ed4aamr23292247oib.148.1666372894339;
        Fri, 21 Oct 2022 10:21:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a05680809a200b00350a8b0637asm1305671oig.47.2022.10.21.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:21:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Oct 2022 10:21:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 3/4] hwmon: lm90: simplify using
 devm_regulator_get_enable()
Message-ID: <20221021172132.GA1890681@roeck-us.net>
References: <cover.1666357434.git.mazziesaccount@gmail.com>
 <a1fa4364cbb775de25478117dd22dda0742089e3.1666357434.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1fa4364cbb775de25478117dd22dda0742089e3.1666357434.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:18:43PM +0300, Matti Vaittinen wrote:
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable().
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter
