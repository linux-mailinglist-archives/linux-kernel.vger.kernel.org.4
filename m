Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF07192C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjFAFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFAFyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E4132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F0164132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A10EC433D2;
        Thu,  1 Jun 2023 05:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685598753;
        bh=+kSrPSy30WrPPb97+wFDdfpXxxXIri6f+YbeBWlxfK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qwdpR/1aMpjLDhF+6cXoj1YX/Bgh2avJOUcT/U5K6RJiGf01o2xw20SHZ1jCSJp3/
         d477JgoeisIsv5tgXHutruqcUVKWvCRu5X59j2jEylT/Fn73X1Bhis2xgzU6tqxNoP
         9I+nyQnP9QKzvsfAyE6ZN54GBjEcvM2k2ZT3e0SU2w1eguvASm/fp3H2D/fokb4iw+
         UWBGLWfgwmf6vrUdZtJRxWa38k0cG9LNz2PhxbBMZj+8CHmLJ9i6r1g2uwyY0khC/f
         /Je4A6kA4ydiRYwU7OusBmjaYacR63EUr02C6yAlWMC+PRXjRNOg3MbW4yah5srm9O
         y9EijM8KeKbow==
Date:   Wed, 31 May 2023 22:52:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        davthompson@nvidia.com, asmaa@nvidia.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxbf_gige: Add missing check for platform_get_irq
Message-ID: <20230531225232.4e83d6ae@kernel.org>
In-Reply-To: <20230531075451.47524-1-jiasheng@iscas.ac.cn>
References: <20230531075451.47524-1-jiasheng@iscas.ac.cn>
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

On Wed, 31 May 2023 15:54:51 +0800 Jiasheng Jiang wrote:
> Add the check for the return value of the platform_get_irq and
> return error if it fails.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")

You need to CC all the authors of the patch limings@nvidia.com seems 
to be missing.
-- 
pw-bot: cr
