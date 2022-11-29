Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8763BA28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK2HEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK2HEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:04:04 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4E3AC08
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:04:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c15so3517515pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/PkiaqMA4pruVICxaOXfAOMV97w0GDIaiLIs6DhGNM=;
        b=nGI3f7XP/n/CdTE3+JdBxX2OdJBGXnOdwKBO6a3E48X5d8smdFtn/2hxZbNUtah2Dd
         cxfTDN9eNDTMnCC+BqSWW/mm+m4DaMosJHySTssipXXk/Nb/bfIyqJPD86rEPMMep4X5
         pJ+oy0ybnSOkPyPSHFNlXabUR0+LCM5JaA5UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/PkiaqMA4pruVICxaOXfAOMV97w0GDIaiLIs6DhGNM=;
        b=U/pAtGSHLPb/b+p3Qw4/HvZ2IHRSlnLVGIVkro/Tot5lxfHJIOCMtCW5yptyNLnzX7
         kmBowGLYYv9X1FszuDgKCFh/VYRqMQfp7dV2s2H9ODOAM4SXhTsPRBti4NkDYRZRfLPY
         /YZvN2mlSmksdCTipt9ZG+jCjrkCYEuNxGIzusSJcSQYMM4j3LpPKOf05UJBYkw0EW7u
         QKJKpVNgK/VzBPYsCLJWI//qZebnV143TJMIQHS222Bw5DTydJNl27TcOwvJESmkc7ln
         Pq0XgozAVgF3yxxKSN9ntab6TJNEEf1Q0/zD89Qd8wbLQHZGMl9VvEHnbagnxL1v9rCE
         PkQw==
X-Gm-Message-State: ANoB5pmejLbI78UJnYkfgGciM++jcoNXk5UM6QgW48FqF8tOfDIJTIuF
        IQycjTcD78gs76g6odCPpr/BBw==
X-Google-Smtp-Source: AA0mqf7s3IK+L7jg0NoOsZxFQ3QK1mU67M0nikga25/eRo5XmoKdR7cZJQKNoYU72QRaWfGTGksv5Q==
X-Received: by 2002:aa7:8b56:0:b0:56c:6f8:fe14 with SMTP id i22-20020aa78b56000000b0056c06f8fe14mr57113596pfd.75.1669705443377;
        Mon, 28 Nov 2022 23:04:03 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ac4a:f96:259:b58a])
        by smtp.gmail.com with ESMTPSA id y69-20020a62ce48000000b0056d3b8f530csm9140261pfg.34.2022.11.28.23.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 23:04:03 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     sboyd@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, johnson.wang@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221121122957.21611-1-johnson.wang@mediatek.com>
References: <20221121122957.21611-1-johnson.wang@mediatek.com>
Subject: Re: [PATCH v5 0/4] Introduce MediaTek frequency hopping driver
Message-Id: <166970544127.607733.12688735757301419553.b4-ty@chromium.org>
Date:   Tue, 29 Nov 2022 15:04:01 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 20:29:53 +0800, Johnson Wang wrote:
> The purpose of this serie is to enhance frequency hopping and spread spectrum
> clocking feature for MT8186.
> We introduce new PLL register APIs and some helpers for FHCTL hardware control.
> For MT8186 PLL driver, we replace mtk_clk_register_plls() with newly added API
> to support frequency hopping and SSC function for specific PLLs.
> 
> Changes in v5:
> - Add the reviewed-by tags.
> - Move binding document to bindings/clock folder.
> - change some coding style in clk-pllfh.c
> 
> [...]

Applied, thanks!

[1/4] clk: mediatek: Export PLL operations symbols
      commit: 029c936ae7e14ce49d043527087abb5f4b0ea48c
[2/4] dt-bindings: clock: mediatek: Add new bindings of MediaTek frequency hopping
      commit: cfcefe36bf939107eeba7b1114e3d82e31f92893
[3/4] clk: mediatek: Add new clock driver to handle FHCTL hardware
      commit: d7964de8a8ea800910fdd4e365c42a9e7d5c54aa
[4/4] clk: mediatek: Change PLL register API for MT8186
      commit: 633e34d0f46ed36f1de15ede00e4b31f4d7cccae

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>
