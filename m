Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D06BC773
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCPHkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCPHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:40:38 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035465B5CC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qEPB1OV4lhu+yEz1IMcjSvJh7ZC2UDdKQIeQ4FynUXY=;
  b=Oa9YuU+hDBLcgyp3jfCn56DLnykLgah/yuKYJ5VcuAYvE4hOygjZflQ3
   59L1SNT68G0kLg1etzmABb59BLtZHI+KYJguof+eTF3nfmkZ11kbH7Yoc
   9cobnvvakIlRCf8S5a5OB/5H5kEFwHlnBUmsB8hLTDJ154jfDzFGtumd7
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,265,1673910000"; 
   d="scan'208";a="97477327"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:40:29 +0100
Date:   Thu, 16 Mar 2023 08:40:29 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Nathan Chancellor <nathan@kernel.org>
cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
In-Reply-To: <20230315150656.GA2938956@dev-arch.thelio-3990X>
Message-ID: <60638fd8-29a3-c89c-af56-a2b0732ae28@inria.fr>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <ZBEJ+8DbhADSBTLr@aschofie-mobl2> <ZBG699SriXWy1I2K@khadija-virtual-machine> <16148020.1MiD057Pog@suse> <ZBHUr7bANuhnOnIV@khadija-virtual-machine> <20230315150656.GA2938956@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just repeat the last step as you investigate. If you have any further
> issues or questions, please let me know. For the record, I am not
> associated with Outreachy (I am one of the maintainers of clang/LLVM
> support in the kernel), so if I have messed something up or overstepped
> some boundary, I do apologize.

Definitely not.  Thanks for helping out!

julia
