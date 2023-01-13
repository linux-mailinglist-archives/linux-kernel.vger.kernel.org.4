Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53C669CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAMPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAMPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:44:54 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF814DE90;
        Fri, 13 Jan 2023 07:35:21 -0800 (PST)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id E886A261BE3;
        Fri, 13 Jan 2023 16:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673624121;
        bh=HQll+dtETcToYPK0AFX1WAMkvWIdTPoYlWHDFOoqErY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIoRgGoPLXf3TmS73/3zYA9xxsm8n6zU03O0tcCLrwrIlW9fsgXJSA59NGVMyjjl9
         Vt7HlxkXoDiMQOgujailfp2yQE6XmxyZcywA2Ot+jv6zJvvfwLDWBZQ9BGxVg9uKKB
         Pmh7OeXCRnLW2Q70jzms5n5Z9iLDG6Ys0CQA4CCGi0prMTnB7voo7RGh7hLtQ/CAdJ
         UYGsKCM05h35y3F8UG9GVpo3qI5B7qYj5l/DeeZ0WlkBH3kguQLeOkO0vuaI96iYin
         9EMUcVFg6F4vBcbpCk2z12HbKwcj5+ShaSIga0eAwfIGfYA2T+3JDARww6iRBNwZ+i
         7aFT92K2O/RYw==
Date:   Fri, 13 Jan 2023 16:35:19 +0100
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
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Message-ID: <Y8F6NxYpJELbvogC@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103010903.11181-7-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 07:09:03PM -0600, Samuel Holland wrote:
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++

This file does not exist in v6.2-rc3, what tree ist this patch-set based
on?

Regards,

	Joerg

