Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1C607D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJURXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJURWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:22:55 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE971AD687;
        Fri, 21 Oct 2022 10:22:54 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-136b5dd6655so4373817fac.3;
        Fri, 21 Oct 2022 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlHj7n3i5o3yXLa4ETHRTpxvwrBu3YafH8lL3TZQo7c=;
        b=mfKFX0fSUZxTyWGet7HLjN5KSNIIKvyVtQYoZsLLgdG68Yakqkgp2WJCOVzeO5GHCh
         yANi9hjw5ikEB67N8ZxxJKlfSvDFlB1pwODfttxygGfSi0EpBEzaL4U+q9EnKkXB8zM4
         Kpy3knTJtufMaIDXCnTxfQ5ityhf0XE//ULX0EfgX5moVheH0+IlYH7rFaVYlw7h1IZC
         f3hvRzN3Is7mdZ6SjqQK+HqlYEc7b/vJJi/DHEaOZ5SLMYgzInSE2cZqQCd6vFovU8W+
         GC/OSC40v6iY2wHSha8o+Px7g7bYjOTCm+V4YkcfWMW6rmsOzqVXzjwkL/eK9USq23tn
         RQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlHj7n3i5o3yXLa4ETHRTpxvwrBu3YafH8lL3TZQo7c=;
        b=yNI6KRowwxaQ0yJs/KYbnTOdXOBbqJlzcJFFQdx3AZ5iot5perE4goOSpIXE4gOSUD
         nLAZAYby/l+Ih0l7rY1SS4hz604r3I81wWL/2gQpB2JvG6uOJLR3AiPGmdrSmcBJne4s
         moWSDeiTEbDstLLeq/Ti3GUngrnvc8FARSi67pBewKWqEJI4btcR6iHU6fbHsAzFlJ5R
         ufXdx92wOwvGmB76LUkDQ4NQ5KIZ3djJIg4Fa9Nxs0LP7a9id1mnTiwWEmNvenm9rx9Q
         wE7OqAXTa+4lW1P+Wm3FTL1obDznW9rEwiUECpZ4wZxehl5ry7Z5rK1U6qqctUKUpu/B
         yl8Q==
X-Gm-Message-State: ACrzQf0qzyUs5+ucY6CtJyCkvyZ6G2ZiV3wetEL+2LjGcwVtCO8kh9o8
        L5rOKM2JuEYrNTQ5FdmO0h0=
X-Google-Smtp-Source: AMsMyM6Gt5PNxUQH7m5Kz7f+QJp+blLH3aodobQDZ0VnhqQZBBrggpcw5I5WICKa7m1ONsnecjhzHg==
X-Received: by 2002:a05:6870:2427:b0:13b:1f89:ab27 with SMTP id n39-20020a056870242700b0013b1f89ab27mr3799543oap.20.1666372973425;
        Fri, 21 Oct 2022 10:22:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id em40-20020a0568705ba800b001226d2100f2sm10482749oab.33.2022.10.21.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:22:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Oct 2022 10:22:51 -0700
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
Subject: Re: [PATCH v4 4/4] hwmon: adm1177: simplify using
 devm_regulator_get_enable()
Message-ID: <20221021172251.GA1891003@roeck-us.net>
References: <cover.1666357434.git.mazziesaccount@gmail.com>
 <7773541795f280db31dd981ffc21df8a630b794a.1666357434.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7773541795f280db31dd981ffc21df8a630b794a.1666357434.git.mazziesaccount@gmail.com>
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

On Fri, Oct 21, 2022 at 04:19:04PM +0300, Matti Vaittinen wrote:
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter
