Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B54633747
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKVIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiKVIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:39:45 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C08630F68
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:39:44 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 1C16F2A0360;
        Tue, 22 Nov 2022 09:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1669106383;
        bh=9BwFbFRve6bL4FHZrorF4v2oi949y0toC5Y2K7JTwZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcdKkLDI4vyGWXL03z7k9f74X5bKn7k662zcj+NwCRR7+bkT2sxihiNeWB0NrOyiO
         +esDQN3WuAj1DOwahgBIEXWtaRrzmZpzJz1K3t+Xx3WsUJ8GHskS4omjZ1Hna0O7Ck
         iaDXtBlOw3gvpcZQHKV3aZNpUbMXH4giG/11aE6mPSQmzTJfLRTJ9dP/F4egc/WaF+
         jq89cEbhw6hAJXdC9pyuANgvDOiB+61acOCVK2B+2roYa+ivy3uZ0Yk0he4e0b9uEP
         m4Y4wn3k0I0aH7cFY8OFXMedw5qyRXyUoz9tSDDWq2p9fuFlnk+rCcfadXY4C2Qq91
         Wa6hxaD87jcIQ==
Date:   Tue, 22 Nov 2022 09:39:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.2
Message-ID: <Y3yKzdAB2QXxHOgv@8bytes.org>
References: <20221121214549.GA8910@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121214549.GA8910@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:45:50PM +0000, Will Deacon wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
