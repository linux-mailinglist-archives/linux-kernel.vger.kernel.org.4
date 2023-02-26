Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA686A33AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBZTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBZTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:35:25 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3610AA2;
        Sun, 26 Feb 2023 11:35:24 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id b12so2902406ils.8;
        Sun, 26 Feb 2023 11:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66rKgYfZ0JLlcjc08pOa7T5lBmt7OeLV5Mls9m6P4To=;
        b=VL6EcHDs88sm9QM0CmbMxVP5y2YH2CjX/PntPxA626mzmTR8Kw7LMXr4r5aAgphziz
         nCqpNKZ7LZR6qZwvAVw4XgM9YNlmUPQt3PEnxeokwk3tI9qUsgrNaZ24L7WXmR+Wvm7C
         1e7bl2NVOEky2Qpy82lC61AracAqvZdu/IE/yzf8phavvqAAuE1oyhlmkMrn9IvfNG3u
         Yq55NL7zp3J+dmpxnQdVfXrsHaX3pbWYSXmb/4ct1b6nwrJCGhXlcM6x7z4k8erRbMQG
         I2wlIZwrjPQjnmoGMyCTnNtclvgkwvf6ZbpXFx7zRhNeuBYL8cGZeZOHxNA7Z246Z5xM
         SQ4Q==
X-Gm-Message-State: AO0yUKXeBrT7JlDL8MJ5ZS05MmGcMki0VmwoHL6jnu4KUulzQQkBNRN5
        cOYpmAJuBZbe4ewOTgNMGQ==
X-Google-Smtp-Source: AK7set8Bj7b1HrLAuEwFy1Z07OGWlcmrCj32SezzjBkYQCTEExRPs577ubZoQrkIYamfFRL3si5Dxw==
X-Received: by 2002:a05:6e02:1a6f:b0:315:3d25:231b with SMTP id w15-20020a056e021a6f00b003153d25231bmr22091467ilv.9.1677440123270;
        Sun, 26 Feb 2023 11:35:23 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cecc000000b003154f7c11f7sm1417544ilq.39.2023.02.26.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:35:22 -0800 (PST)
Received: (nullmailer pid 187425 invoked by uid 1000);
        Sun, 26 Feb 2023 19:35:19 -0000
Date:   Sun, 26 Feb 2023 13:35:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-staging@lists.linux.dev,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 01/10] dt-bindings: sound: nvidia,tegra-audio-common:
 add new property
Message-ID: <167744011865.187365.15488649749142004179.robh@kernel.org>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-2-clamor95@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 20:32:02 +0200, Svyatoslav Ryhel wrote:
> Add nvidia,coupled-mic-hp-det property to use Mic detect GPIO only
> if HP GPIO is in active state.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra-audio-common.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

