Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A46EACCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjDUO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjDUOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:25:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9C13C13;
        Fri, 21 Apr 2023 07:25:57 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE2C7660327A;
        Fri, 21 Apr 2023 15:25:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682087155;
        bh=yKwA0nyhzB/UO0XdgVA+ywU0OaEnb8ZR3NfuifZEl8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5LFmSAk8QWKR7yqAmTExPhRMkzXpq/g2+oIdM1V0O3sBELjjol7TDA6hdHPe0Vsb
         qJt5oAxcFUKp6xhCxzrPWEbhx3jTiW1KHBzNxKyhCuTqaDOupWC4xFR+jZOoCXzkKh
         QBxS1w8anmuGcS8H07AOpmfk668OiD6cCDOML2DfIKgBAkWDFrbhFgo39Ws+ESRoyd
         MnZ0XN8JPtNxPFEU3Jn95xSWBja5wGalfkJdbqW593g2jIJfCzP8xt4QVxQ8F5wdxh
         LEQrxy0d9Ecvb44iqEVsYUxK6xm37pUEv4E1WT/s5X1Jg0wE4fTrbHUbli+eWcifQs
         LlqhrN8fEnOrw==
Date:   Fri, 21 Apr 2023 10:25:50 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: mediatek: Enable all MT8192 clocks by default
Message-ID: <1742f1a5-52a9-4146-bd1d-6b383c878561@notapiano>
References: <20230421111125.2397368-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421111125.2397368-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:11:25PM +0800, Chen-Yu Tsai wrote:
> Currently the base MT8192 clock drivers are enabled by default, but all
> the other clock drivers need to be enabled by hand. This is extremely
> confusing and inconvenient for end users. For the MT8192 platform to be
> useful, most if not all the clock drivers driving the hardware blocks
> need to be enabled.
> 
> Enable them by default whenever MT8192 base clock driver is enabled.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
