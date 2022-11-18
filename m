Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFD62FED3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiKRU2O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Nov 2022 15:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiKRU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:28:10 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DFB44
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:28:02 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so9303352pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XBIIsbYjFQlxqPutQtC3YZdHA7lM3DSVyPcn1CRdwE=;
        b=FgzkqS8Y1yHLYGh4o96wZt3PNVtZWPQ+ycWqRZBLaXNaLg7NOtE8OxS3r5hEoJFK4I
         qOxrL6uMaPV1C9XRW0u0kRdrN7FsolJXFcmiD5LursgHXZlNg+yUR7aVc8cu3QrrgjPz
         OxY8TvYpyNCWBowYFc7cF3SofGrs6krLFQCiATh3A1/BZLP2nQbxePXLqDAQM+Znherf
         eeGcra/8ptpPGvgFaWsAz11u8xl4holTk9AWQnOuYJcMWhZOhYqhn/8t8440HJzPHTJm
         O9EtjL5URPqartz2OBAww/31sHU1Q0wDq3Gm9Wm7dmoxvbe7gPxzEnS23fwCxE0VEWaN
         EnMA==
X-Gm-Message-State: ANoB5pnGKfIAbWp/lO/ERnbUglkjr9hvAIfS2gmtwHz2s51/a9E4q4eU
        fF3TeV3j3p4nc5y5ZqtCiPmq5Q==
X-Google-Smtp-Source: AA0mqf4WqWyM2o3krfJjKP6HKQ83bfsi3Jrz07p/fPicZ49O43m8mXK8WX3ZaOquvP7dOZrMFsJZjw==
X-Received: by 2002:a17:902:ccc7:b0:17e:4b8a:827c with SMTP id z7-20020a170902ccc700b0017e4b8a827cmr1112491ple.115.1668803281786;
        Fri, 18 Nov 2022 12:28:01 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001788ccecbf5sm4118348plb.31.2022.11.18.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:28:01 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: mediatek: Initial mt8365-evk support
In-Reply-To: <20221117210356.3178578-8-bero@baylibre.com>
References: <20221117210356.3178578-1-bero@baylibre.com>
 <20221117210356.3178578-8-bero@baylibre.com>
Date:   Fri, 18 Nov 2022 12:28:01 -0800
Message-ID: <7hy1s880tq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkränzer <bero@baylibre.com> writes:

> From: Fabien Parent <fparent@baylibre.com>
>
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add L2 cache]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

Boot tested on mt8365-evk and works well.  When this lands we can get
finally this board into KernelCI. :)

Kevin

