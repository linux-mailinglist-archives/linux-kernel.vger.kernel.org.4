Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3966DC9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDJQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB31FCF;
        Mon, 10 Apr 2023 09:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDE460FF4;
        Mon, 10 Apr 2023 16:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1187C433A0;
        Mon, 10 Apr 2023 16:59:35 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: tegra: read values from correct device
Date:   Mon, 10 Apr 2023 18:59:27 +0200
Message-Id: <168114590173.12295.16629807729065292748.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322234050.47332-1-diogo.ivo@tecnico.ulisboa.pt>
References: <20230322234050.47332-1-diogo.ivo@tecnico.ulisboa.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 23:40:50 +0000, Diogo Ivo wrote:
> When reading MR18 for Dev1 the code was incorrectly reading the
> value corresponding to Dev0, so fix this by adjusting the index
> according to the Tegra X1 TRM.
> 
> 

Applied, thanks! It's late, so it might miss current cycle.

[1/1] memory: tegra: read values from correct device
      https://git.kernel.org/krzk/linux-mem-ctrl/c/be4c5c6e84429e87cfdf1c8be350a49a714a93e2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
