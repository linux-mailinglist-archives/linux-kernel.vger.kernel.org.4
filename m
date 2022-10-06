Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC05F6EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiJFUMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:12:14 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B2C6978;
        Thu,  6 Oct 2022 13:12:13 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r186so3301601oie.4;
        Thu, 06 Oct 2022 13:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/Fd7V0AZhPxva2thTU44cSzp0J58T48TzpEQrhv93Q=;
        b=NHWcE85ObPrlaMSYZ/1+B8CJ+km1B1E1ejSX6bhxoLs+57U1fsgPHNMnqxse8U5gD6
         7ZV6Zi4UgnT0mnxtSY2zQjffmJqJFn6ZvR/kOafMAhKriTscoxgHHbCgu3pDSKR8CCjV
         yIIhZxZJB5ehwlqqIGQVoNns6o3+4tfQoGHJNLGf39yJ6uJOzP33rdu8HzLcSl9RdqPx
         9Vp0iqCrr4hZcTRMCJgtUdjYoA2FApn0dt2Rn653m7+shqmXAGlqfadJjPHdiC2fDgR8
         uvKjzLKyNBouG6GFyb2WllrLie38NJNCS27j2wKpJFayEboQj0FRKuaJv+JVeQVm9Fdq
         Avtw==
X-Gm-Message-State: ACrzQf0+KvWZZRp9WbnVWVbPAYG1YfMj9U+VoflXfkQSzBNouz8ZQU38
        sq3ghpCbm5b6eEhgIlNpBA==
X-Google-Smtp-Source: AMsMyM5ZJeK4ZyzNfG4rtH8hctFnOJm7aVsdKBQi6FiocwcM81pSr8YMcutx5OsHoWKMapJylMS3zQ==
X-Received: by 2002:a05:6808:1303:b0:350:cba9:197d with SMTP id y3-20020a056808130300b00350cba9197dmr660337oiv.83.1665087133170;
        Thu, 06 Oct 2022 13:12:13 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id j19-20020acaeb13000000b003430d6696e8sm70461oih.8.2022.10.06.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:12:12 -0700 (PDT)
Received: (nullmailer pid 93184 invoked by uid 1000);
        Thu, 06 Oct 2022 20:12:11 -0000
Date:   Thu, 6 Oct 2022 15:12:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT8173
Message-ID: <166508713049.93127.2543598366027906776.robh@kernel.org>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-9-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006120715.24815-9-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 20:07:15 +0800, Allen-KH Cheng wrote:
> Add the mediatek,mt8173-wdt compatible using mediatek,mt6589-wdt as
> fallback.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
