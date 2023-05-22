Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D170C24F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjEVPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjEVPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:24:17 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84DEFA1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:24:16 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B6549248072;
        Mon, 22 May 2023 17:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684769055;
        bh=ptyW7oCx/HCiX20PieqrlaUejHk1DbuuffHff0LY8CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqooSWknRU1uMkmjiI7s7Tgiclq+xv4JVB2sL0S23XYozi+DU6Yc7A2mhhIozqvZf
         aeAhXLoI0o7VdF/vQdcBhu/bZz2jWxs/LpbFzmBUCe5GFuA9PUpW6OYJX+CgUy4gf2
         uQBZwDdPl1nbVYB3Z0XWkYd2OJio58H7/lfouFfXAj8y9S7tV/rmNbDEPIpWGBK38P
         8QhCjCpkZDep5UmMU33cHVfhF0y3gTH+ay7enYUsPus5ocn02SPYhkxgHROqf8HOJH
         g7JDTW4BFDS7963K97bJks8DPwpiS0bxscGdpeIOO/r/bb9kWukkg0gNQ7HPVIkHxI
         SQknXJEW9ta0Q==
Date:   Mon, 22 May 2023 17:24:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: amd: Fix up merge conflict resolution
Message-ID: <ZGuJHu1hWBaM-8em@8bytes.org>
References: <20230420192013.733331-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420192013.733331-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 12:20:13PM -0700, Jerry Snitselaar wrote:
>  drivers/iommu/amd/amd_iommu.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied for 6.4, thanks.
s
