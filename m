Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441868957F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjBCKWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjBCKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:22:19 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 747F1305F5;
        Fri,  3 Feb 2023 02:22:01 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id EF54A223E73;
        Fri,  3 Feb 2023 11:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1675419696;
        bh=aNTbAULS7WsWPSOr/TReq3Mz/0kZAyyR8eXbUDeUWRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpFKNyxyIFsx8S0NQ982PN/4BwNkSFDbL+Z6uxkQO7EOPZwdC7j0iinDL/mrr4t4o
         lbBvvvtO1il46wDSoJOxxL8HLq1ao/yAc51Lxf9uUUqeEsNGxlWRIFy9nVftaVN5AR
         FYo6IKSmNUkRFivi0or3CecJPjM8amf0bnh5IYe40fc9dZ7KevQMvybu5pnoJfrMb/
         Jal6Tat9buiK45YnJbkalAIbLjcUVAjG8nx8mHQtZWjKuNZeM92JZuz9Ilnpzb8mD2
         HGCVb5OMIahRuKf8HfCZnRmz+hGVGTyxifIBTaJDbcvEOYNnOCGRnZNTiPKALxNbZU
         MXIMMmFt89MEg==
Date:   Fri, 3 Feb 2023 11:21:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 0/6] iommu/sun50i: Allwinner D1 support
Message-ID: <Y9zgKUUjjPq8ifPn@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <Y8qvIRXcCdLZjDCK@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qvIRXcCdLZjDCK@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Fri, Jan 20, 2023 at 04:11:30PM +0100, Joerg Roedel wrote:
> Once this is fixed I will include the arm/allwinner branch into my next
> branch again.

Since there was no reply to this I nuked the patches from the IOMMU
tree. If this is still relevant please resubmit them after the next
merge window.

Regards,

	Joerg
