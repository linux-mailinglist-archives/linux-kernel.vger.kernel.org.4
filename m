Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BA67B08F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjAYLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjAYLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:05:09 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC5F72CC59;
        Wed, 25 Jan 2023 03:05:08 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 2C55D262E57;
        Wed, 25 Jan 2023 12:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674644707;
        bh=oWJS0LBFuo75V0UDkvT4uRIAxgDGoN8u+uH5AtaO5Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mV3tL2Qj4IsD4klO7XjicPz8pjaUpUPGzwcyQPmKJ5sOfRXIaHbKX1QGcDKf7nrLM
         jmjqQT6lF6/7yNzH6GcBle8jFIyX7J+GCAmlNZm7KhzmKWb9cZFbarrcWWi66TMq/Y
         9cEzObSD0Lo4PQVOPzEqzJ3h91ENCCMOGAQ62hbnF1W9MvaIDGqEBP75CGtHjXedNV
         cZVuW8VFYs5pxo8xwtetdyrGVEjHrD+UHm90kNMy9MXKnB1yDfoQKtQO5sbWPvRrZJ
         cBiUmt2QfHC62DK4W/gUajjgisJK9SEiUEfsuZSBvHUaro+V5oW9jBh8l7ZPm3K2l4
         5TNiBRxKGYTGQ==
Date:   Wed, 25 Jan 2023 12:05:06 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/exynos: Add fault handling on SysMMU v7
Message-ID: <Y9EM4v0uZC9BaAm7@8bytes.org>
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726200739.30017-1-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:07:37PM +0300, Sam Protsenko wrote:
> Sam Protsenko (2):
>   iommu/exynos: Abstract getting the fault info
>   iommu/exynos: Implement fault handling on SysMMU v7

Applied, thanks.
