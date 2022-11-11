Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F3625D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiKKOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiKKOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:43:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890117A99;
        Fri, 11 Nov 2022 06:41:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f5so13025770ejc.5;
        Fri, 11 Nov 2022 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DytefXXF8dLrG7iuse8k25267CoEEf8uOlAfNXMgL1c=;
        b=R2kry5m1QG6CEbBgqvcz2Sklde3gm1nVLH624PeRVoj5qvwhwzYti8+azm1Sz2OEef
         vmZy4/bkCXyygotYM7zy/ktlt48/ExqqKYYIE4oWNnHo/hx3goaRp1T56obLsLIB3RSX
         ttftXiPuZJszV3fZxwrAXIbOASaSwtYrCCZHtu6J6wzixYa8zJ5B98JXFaIgG8AWbLAE
         zZOQ3jpERB36X58I52ZRQD6t7P38+JKV/RoQRD5T0T6HAq8ON1y+9q6pPofHTMRjgJLf
         30oHtxztymwItIRQ3BfBzKXi0d+mdAU2jOqEAePTQsQZRQp60ICFvcucNex7sp64GKbN
         uGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DytefXXF8dLrG7iuse8k25267CoEEf8uOlAfNXMgL1c=;
        b=vO1SxLm6eL+p86ccdiosmGeo8C0/7v4Ff/OBL5UkL2iPaynJNbC0xUXxdVBX+uDVOk
         WhzI5QCvW8ON5VquMfS2iNMfzfLeBu6Lf9rujwfm2J3WdGZqWKcoKO+pIVszy1dz5M9A
         v9iBjeuimVnfr0DmHC4ABnpLW8zH8MwY+lm+ydzajunAiae7gVkw9mVVopSKlN/h0XKQ
         FkvF1EeZNTkpCC9xs7QoTPz1UEImGv4OB8fwFv5UoXf2coS93QMvySK1+vHFjFWTNg4N
         tbAucXlgBMwn+5E6DljJuw5+odZsGgbx8fjr6iyV1jFdubjk7JpKuqkxQe4t8Zn7oC3H
         MqoA==
X-Gm-Message-State: ANoB5plZzsOoFwB60AQDuxXyXFBdoiH5KucXjgukotgWC/F4qpRt6KDV
        0LSWDqyIZce3YZcyTpZHHOs=
X-Google-Smtp-Source: AA0mqf5WrhHXLMqGuiJLLJgbbC08SFoHoGCFjaxu1OeHvem7yAzAa+CxY3q/Oc8U/o+CaWGlENNT2g==
X-Received: by 2002:a17:906:814:b0:78e:ebd:bf96 with SMTP id e20-20020a170906081400b0078e0ebdbf96mr2015494ejd.625.1668177694443;
        Fri, 11 Nov 2022 06:41:34 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm416336ejc.193.2022.11.11.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:41:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     sumitg@nvidia.com, ndesaulniers@google.com,
        linux-tegra@vger.kernel.org, skamble@nvidia.com, arnd@arndb.de,
        windhl@126.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        ulf.hansson@linaro.org, Kartik <kkartik@nvidia.com>,
        digetx@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] soc/tegra: fuse: use platform info with soc revision
Date:   Fri, 11 Nov 2022 15:41:29 +0100
Message-Id: <166817763540.519550.14267708110667796694.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <1668003622-13706-1-git-send-email-kkartik@nvidia.com>
References: <1668003622-13706-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Wed, 9 Nov 2022 19:50:22 +0530, Kartik wrote:
> Tegra pre-silicon platforms do not have chip revisions. This makes the
> revision soc attribute meaningless on these platforms.
> 
> Instead, populate the revision soc attribute with
> "platform name + chip revision" for Silicon. For pre-silicon platforms
> populate it with "platform name" instead.
> 
> [...]

Applied, thanks!

[1/1] soc/tegra: fuse: use platform info with soc revision
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
