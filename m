Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F64604202
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiJSKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiJSKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:49:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D214DF06
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666174961; x=1697710961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Doivr+wgZN/Rz/fRhQp3xUvpBxG0TBrKhUsF2CC1td4=;
  b=xnwgVAaQOHM3nG28mUwlEuo1q84NiNLHDV9+6HVbPn4+rVWR/FkHUkD6
   D7CM0FE3coa4VhTGtq0RhvRfqNAWoZwYTTiLE+ZnmLvuN615HOQuAPOqE
   eyad6l6XE5irWP3tz3WEYlGJDyhvyrm6TbonHoxxom/4gi7XhqbbuT6yq
   B0ZjL8kNpJazsTvMPZsCtV1pg1hEn++ojjZmBgHsdA5Brfh+MOHiGgj74
   jiUNQmDv9DGm5iSGbAh+TXIv5RMRzzbBPGbln1amwu/fjrIhVzszebRka
   3IctGLPQyaWRhSjUDRh6pxc8Rj4xzwbimzKQo3BtKaYkZ8ureiR5y7vzS
   g==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="185373617"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2022 03:21:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 19 Oct 2022 03:21:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 19 Oct 2022 03:21:00 -0700
Date:   Wed, 19 Oct 2022 11:20:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Cleo John <waterdev@galaxycrow.de>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Message-ID: <Y0/PfL5SWNw8HCLr@wendy>
References: <20221010182848.GA28029@watet-ms7b87>
 <5631093.DvuYhMxLoT@watet-ms7b87>
 <Y0SDZEXQ5kXGJZLh@spud>
 <4763163.GXAFRqVoOG@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4763163.GXAFRqVoOG@watet-ms7b87>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:07:58PM +0200, Cleo John wrote:
> 
> Hey, because I am new to Kernel submissions I wanted to ask if there is a way for me to see / track how far this commit has gone in the pipeline of commits?

https://patchwork.kernel.org/project/linux-riscv/patch/20221010182848.GA28029@watet-ms7b87/

IIRC you sent the patch during the merge window, so it wouldn't be
applied for v6.1-rc1. You'll get an email from the patchwork-bot when it
gets applied.

HTH,
Conor.
