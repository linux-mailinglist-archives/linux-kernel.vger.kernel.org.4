Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E3961802A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKCOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKCOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:53:32 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CEC11A80D;
        Thu,  3 Nov 2022 07:53:18 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 0E894260033;
        Thu,  3 Nov 2022 15:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667487197;
        bh=W+503lTP2jRAK3Vj/frLD3iD/xxYLTMy9NfG9rA+raI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inVtOODTjwGgyJlA7Iw794Ad9BngxsaqLHg7pXU8cE21CYQBhPuH9VdUpIQOeaTSA
         fJRx4FJ0TaD8loMduyufhX8+Le3tGOOTTSCzJkzEbwBKjIrdm/eN28sgxmf+v0n8Aq
         3PFZrjec5c0TcKVsuoVv048G4EeBWwcabN+T7uc6MXQoi+GwA8IWO8eAfAM/qbbB+6
         PqSTLVX+5sgCz7aSyOxDrkdrzQFN7TnyvR6B1E8PpBd97S+SidrA2xTFoaLtyIY69b
         0jUBi9bVQBURoAIydeT86AZeQ/oLUb0hIbNNjzY2aYTLZEbhFbCGKSy7KiYEeAbsC5
         lMxXjvVEer9cQ==
Date:   Thu, 3 Nov 2022 15:53:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
        robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [GIT PULL iommu] Please pull iommu errno changes
Message-ID: <Y2PV26igcbY6Atu+@8bytes.org>
References: <Y2Jn7Jskqzz95XB4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Jn7Jskqzz95XB4@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:51:56AM -0300, Jason Gunthorpe wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg

Pulled, thanks Jason and Nicolin.
