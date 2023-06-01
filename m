Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F8719339
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjFAG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjFAG1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F3E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DABD964177
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7413C433D2;
        Thu,  1 Jun 2023 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685600843;
        bh=B01TcQGDboiLGShWWyZcY4lDUPQ6pacYmh5T9cOJ9nU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjZryNE/di2tcvyRk9knd6WUruHc2ePrJSF1kBDCpcRDVz/CuWqIsYMMkNDqr7nc8
         xDKJRbF9uyIIowvfGZDFmwcfFPOCB86GgJj9UpPTGFoSRCiwnECUFAzCsHj3lxSWL2
         moEHOMBYVGEAxJaP3yueWHGQtRV5tXmKeWpaPvGSy+wky7b93d9tKUH+XD46yemn7j
         pyQhxwOtBe5bIahgmBUueFgYPivEtvFNmsbWAb01ULEZ42hybf+6QElbiJC8AsnPi6
         t6gIgn5IeKNp12ZLCHJEthAU8vf4KSrmuLxYvFJMRuUdWt/W/iNCLrDY6jfH441WO0
         GJ5dD9YXslO+g==
Date:   Wed, 31 May 2023 23:27:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        davthompson@nvidia.com, asmaa@nvidia.com, mkl@pengutronix.de,
        limings@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxbf_gige: Add missing check for platform_get_irq
Message-ID: <20230531232721.4ee4a46f@kernel.org>
In-Reply-To: <20230601061908.1076-1-jiasheng@iscas.ac.cn>
References: <20230601061908.1076-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 14:19:08 +0800 Jiasheng Jiang wrote:
> Add the check for the return value of the platform_get_irq and
> return error if it fails.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

BTW I looked thru my sent messages and I complained to you about not
CCing people at least twice before. Please start paying attention or
we'll stop paying attention to your patches.
