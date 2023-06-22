Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5D73A0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFVMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:22:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A576171C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687436544; x=1718972544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wf83aDcpJeS39HIRskk4tzy+j0m7Vs5UikVdiXiphUo=;
  b=ZCZDPVnT9gIO8zsieC2/ZZ/sSppVO8gtOxOmumlnUXCQQiuXO0V0LrxY
   cpkH9R333rwm8wftKNzXdZpKZoxZVrXH/sarlExCAeBZH2JXJR8L2wx1q
   mgZX7z/4hIxvUlF3RjXYqvhh/ZfZObbLs1ja1tST+bKGfApbSH5KNOM1+
   3bptf3iNn+IhE/pkrH00XlOlplx8HrwvkOqxmbfxdclBDbVFc9a/cZQDz
   yntnx5e0B1/lQMHTJo94Wwd2X9xzUcBxDeGp2pthl3Vk7kovyXNjZgBBG
   m7Id1tifGYDovY+fwiJHFEeACNk1CFsynQoGthS96fEJNC3sztdAhcluD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360488800"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="360488800"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="665040571"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="665040571"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 05:22:14 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lee@vger.kernel.org,
        Kah Jing <kah.jing.lee@intel.com>
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Date:   Thu, 22 Jun 2023 20:21:15 +0800
Message-Id: <20230622122114.592791-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee, Kah Jing <kah.jing.lee@intel.com>

> 
> >
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> > Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig
> > b/arch/arm64/configs/defconfig index a24609e14d50..23a6ebcb1a9e
> 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -470,6 +470,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_SI=m
> > CONFIG_HW_RANDOM=y  CONFIG_HW_RANDOM_VIRTIO=y
> > +CONFIG_MTD_UBI=y
> > +CONFIG_UBIFS_FS=y
> 
> Not modules?
Yes, we need to boot with rootfs with UBIFS.

> 
> Are you sure you added the lines in appropriate place (matching
> savedefconfig)?
Updated in v2.

> 
> 
> Best regards,
> Krzysztof

Thanks. 

Regards, 
Kah Jing
