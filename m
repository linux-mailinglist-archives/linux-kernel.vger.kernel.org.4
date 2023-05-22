Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFD70C1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjEVPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjEVPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:19 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD9B41A7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:01:10 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C3F3E2434D7;
        Mon, 22 May 2023 17:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684767669;
        bh=5VQBXOpnwnQTeAxZ+dp1+XASSAtMPtkiirJfrWe6bl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03RYkTt17CrSBLQ9nOIq3wBrkPUHFrAEy327KzA5mFoaCdAh8B+Z2GKVYooEqprz9
         NkozzoPUon4rTbN4txKaZMxvdMsb2w/KcAuOa9VmJQFCF6pZg2sVRFNiyhhnUqwM+q
         2pdzXhox5WivPPx7Te6w8IEhizHrv+/QbwOuL7QVUUB5uMO2+eHK/XD9zjU0WugPDz
         piqKDVAclWlnQgrqJzVjOO0It1XPMrFDBHxj/U/s2NSWZFBz0u7XCnIn9QZmBNFR91
         +SdAiaqwfLqBS9RYIxOTJN+izI848s0bJGiFc6y4XkatWbIOdLw+hXuAPvg7tPmZuI
         u8/Tr4RP20CTw==
Date:   Mon, 22 May 2023 17:01:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Conor Dooley <conor@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] iommu: make IPMMU_VMSA dependencies more strict
Message-ID: <ZGuDtM22nay0NC2z@8bytes.org>
References: <20230330165817.21920-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330165817.21920-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:58:17AM -0700, Randy Dunlap wrote:
> ---
>  drivers/iommu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied for 6.4, thanks.
