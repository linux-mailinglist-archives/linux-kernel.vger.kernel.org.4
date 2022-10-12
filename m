Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702C5FCBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJLTrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJLTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:47:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F80937B1;
        Wed, 12 Oct 2022 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yhi88whDAxkWtc01TIA26aAnE8AEbY8JfuWtgY57GaA=; b=hMNCB6gZDp6F59CsajRPU0/7h2
        oeTM39B5vi3VOY49PQAF+Xt9+Fqk9KDUzjZmydubfspBFMk7BVR26RVgw3kgni+UOETgLIpLcFEtU
        RKMeDTV+HqROe6DRDoWYf2d+zKll8dp/FmytDgsGtfFsCBiXEoW4Gfa306GVoh/AwZBO1PI6leH9R
        8bDmdYsGBrHjrGwUlLx4YQdmezR4Ng+maWYFBZQHH3qnKTpkifkfhGETvWMBkWQ/LX7x59sShyhbn
        RTJVGNg2I9DhYnqK2AFypmbfT38zswHL3HJ7Is1XI/6HmHu6EhyYcveB5zGlrFhkDkjfJeWJeowgh
        aSKxy1Og==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oihgv-000OQ0-MM; Wed, 12 Oct 2022 21:46:57 +0200
Message-ID: <5fdffa8b-04cb-b42f-e29a-03e9e9045424@igalia.com>
Date:   Wed, 12 Oct 2022 16:46:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 3/5] pstore/ram: Move internal definitions out of
 kernel-wide include
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-4-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> Most of the details of the ram backend are entirely internal to the
> backend itself. Leave only what is needed to instantiate a ram backend
> in the kernel-wide header.
> 
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Tested by building and booting the kernel - since it's just header file
rework, guess this is enough right?

BTW, let me know if you prefer me to respond on the series once or per
patch Kees (as I'm doing here).

Cheers,

Guilherme
