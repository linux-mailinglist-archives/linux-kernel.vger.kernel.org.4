Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F66D814D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbjDEPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbjDEPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:13:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8991990;
        Wed,  5 Apr 2023 08:11:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-4fa3c1a7a41so487858a12.2;
        Wed, 05 Apr 2023 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680707460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMNiMInW3HUbCjLEIC5JIbfFmqCERgeRsCuCIkHaiuE=;
        b=IlLcCACfKSefPyakpGvt5kBsAEPfd5ctQPCH7yMmaxmv17urKgPkQDoZIwuGkjDx0f
         vxaNuMqS/jNi5BeMzJxDCzNgHWUPlaxRqorAVDDNHezDR/3rIP3AAd7P9IcK+oOWksvF
         8nM/YVG/aPN7bCtiiF2FwGu5H1V84uRy8QJvR+t5I1IA042Jdqt3dCJ26Um/wXNwMtxY
         ry8+ELAAY5nI8HM3hlz4a9QB9ihFW+UGjvnqTEkF+6XQtJCaVrZpBy0RxpNZKyh4Pq1I
         b3IpUDBxw2K75giPKyE4ezYROCRSEEkxvcdwXxhTliJLsi+7pQF8AyfiW5jUncxVB+F8
         6NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMNiMInW3HUbCjLEIC5JIbfFmqCERgeRsCuCIkHaiuE=;
        b=mL6weA5iU8xpdK2WJ69OGR5Pzp+t7Yyyyo+p08HqSfS+sR7PssmeX6U21P/BooBrNM
         cHnwZtSX0IH2uGQq/FWhO+WtboaQKlNwyvhlyQMDhJGbg5VvEDbLRI0VF8WiFcfnEy3c
         wbKx5o/4bGIaAqmnsn7HRqKJQBCB+c1jJ1T/YjpQtredw8R+rDe7OMKMaAGPtnyEk1E8
         VepvuvvA6D7t1GUURF3ohTOyRuszpQO5srMV8DIHFmV8T5zzdsqHSPKf8FG3gVBeLpwV
         mBKghF5cfFZXjpHLBRAGnr//Oc1m1qjLyaFlC7BjZi/a1QIidn9pvAFUMtR6YAF308gF
         wH9Q==
X-Gm-Message-State: AAQBX9cAefUul+kCPO+OCCqt5oXXHRGxy/6TrB9IOAqucPnlePXotYVV
        GNBIIT9H+8BioeFHOy9rEWg=
X-Google-Smtp-Source: AKy350YmEPnLXaazQRn8ZjJTBCn46vz/EiJi2YWD04lWCeHj/p9aJ4cJ/thhsGhabKGu5sJOW3PnKw==
X-Received: by 2002:a05:6402:6c5:b0:502:9d16:fd00 with SMTP id n5-20020a05640206c500b005029d16fd00mr2029242edy.9.1680707460286;
        Wed, 05 Apr 2023 08:11:00 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gx20-20020a1709068a5400b00931faf03db0sm7453250ejc.27.2023.04.05.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:10:59 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     skamble@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Kartik <kkartik@nvidia.com>,
        thierry.reding@gmail.com, windhl@126.com, pshete@nvidia.com,
        arnd@arndb.de, jonathanh@nvidia.com
Subject: Re: [PATCH] soc/tegra: fuse: Remove nvmem root only access
Date:   Wed,  5 Apr 2023 17:10:59 +0200
Message-Id: <168070745086.1048656.13825441875980867510.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <1673944255-8041-1-git-send-email-kkartik@nvidia.com>
References: <1673944255-8041-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Tue, 17 Jan 2023 14:00:55 +0530, Kartik wrote:
> To read fuse values, various "non-root" userspace applications require
> access to nvmem binary interface.
> 
> Remove root only access for nvmem userspace binary interface.
> 
> 

Applied, thanks!

[1/1] soc/tegra: fuse: Remove nvmem root only access
      commit: 821d96e3a006d09ca9aa3d982c50f3d86fa55500

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
