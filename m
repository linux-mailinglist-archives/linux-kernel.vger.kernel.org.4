Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1F5FD884
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJMLkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJMLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:40:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1F26AC1;
        Thu, 13 Oct 2022 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665661206; x=1697197206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwBNvrTGhKx7haBmbfNDVoNRn8CE3KTouJoIXdepuVk=;
  b=uxALg9MfiogGkx1Jk0Jk08w4QKYCn/e5Q1OqtPQO+Gi2Nao2cGrcv0CL
   B9pm12p3d08zY1CK2rd4RAghRp4s0QaK5rbvN0hbGeGtoZbo1p2iVjsQd
   t8BhNsRWsQeqYVZWBIxCbpJZS8ystAe9wXvtXN9jbh5dS5+HTvBjjWN9y
   4poyG/e1XHZhXtjstj/mSMc7zIC30o1LBz67Z5yDNnGZqJs9LoJjn4Pqa
   S4obbkeULGb+1ETyTYhJtmNmr11pndvytRROKVOnJEEy4cE6Z2fhFbpEQ
   No4mDhkLfd+y6Q//itk78lDJMVx0e1NHMbCfdE7QLYZ/xuqxmkBWSUrVX
   g==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="178539448"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2022 04:40:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 13 Oct 2022 04:40:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 13 Oct 2022 04:40:02 -0700
Date:   Thu, 13 Oct 2022 12:39:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@rivosinc.com>
Subject: Re: [PATCH 4/4] Documentation: RISC-V: patch-acceptance:
 s/implementor/implementer
Message-ID: <Y0f4+xfKls4qB1Ea@wendy>
References: <20221013045619.18906-1-palmer@rivosinc.com>
 <20221013045619.18906-5-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221013045619.18906-5-palmer@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:56:19PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Implementor does appear to be a word, but it's not very common.
> 
> Suggested-by: Conor Dooley <conor@kernel.org>

The overlords would probably rather this email got the credit but
doesn't really matter for S-b tags.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  Documentation/riscv/patch-acceptance.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
> index 9fed6b318b49..89c7d8abd4bb 100644
> --- a/Documentation/riscv/patch-acceptance.rst
> +++ b/Documentation/riscv/patch-acceptance.rst
> @@ -26,7 +26,7 @@ specifications from the RISC-V foundation this means "Frozen" or
>  ECR.  (Developers may, of course, maintain their own Linux kernel trees
>  that contain code for any draft extensions that they wish.)
>  
> -Additionally, the RISC-V specification allows implementors to create
> +Additionally, the RISC-V specification allows implementers to create
>  their own custom extensions.  These custom extensions aren't required
>  to go through any review or ratification process by the RISC-V
>  Foundation.  To avoid the maintenance complexity and potential
> @@ -38,5 +38,5 @@ RISC-V extensions, we'll only accept patches for extensions that either:
>    for which a timeline for availability has been made public.
>  
>  Hardware that does not meet its published timelines may have support
> -removed.  (Implementors, may, of course, maintain their own Linux kernel
> +removed.  (Implementers, may, of course, maintain their own Linux kernel
>  trees containing code for any custom extensions that they wish.)
> -- 
> 2.38.0
> 
