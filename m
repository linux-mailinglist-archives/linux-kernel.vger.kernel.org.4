Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DB729ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjFIM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjFIM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:58:55 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13B681A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:58:54 -0700 (PDT)
Received: from 8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 98027224B97;
        Fri,  9 Jun 2023 14:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1686315532;
        bh=UFNw8aIZXzP10GiHCjImDZ/A5kFejFNCGxeFW07L8lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbwZt39UrSPDO7MwAi9RgoieiVepk2NvW9pD+jbUYdR3k7mZyH9tvF8s3xSqTiBm3
         x04t/y8MxFfS0Nyml70AUiCFdBJf6UzrhwEQn2FLsUUCIlbBuDYlHi8ySs945sMOuU
         p2aNLIuQZa4dM18zVHDYQqdyU/osxXLEzi83lqe6rCOFiN3D54+UywegrkqohqV37k
         sADfaF/JTfYserBB5ce/p20q/igalJ91c+g7L9CHRG5xhm8QlWMNoL3aJPrJBh9pHq
         zfjtX1GtgI2EbGEuFMUo6TeKxdOPeGeMid2JUpG7kcGbHPpoGaAHS+L28fDcgbP+B5
         5No9bg4XSLINg==
Date:   Fri, 9 Jun 2023 14:58:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.5
Message-ID: <ZIMiC_-GIKRzwB8Y@8bytes.org>
References: <20230609091435.GA3741@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609091435.GA3741@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:14:36AM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
