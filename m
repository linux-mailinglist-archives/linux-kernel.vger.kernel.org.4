Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7D74F35A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGKP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGKP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CD9E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B0A61548
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3CDC433C8;
        Tue, 11 Jul 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089180;
        bh=nNzm7/fIFcKCgpTFubxPRirAZXOaJPx4vFAcO8ouciE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rv9BbNYM+e8Xg4BZoWlF/P6n2/aoo3KcJ1HEBSlAp/+jPoJHPNV/tRT61i+oX7ha7
         7UQ4iHAl6NT/Elm2keUAYAQ+mu3GeCSBfduZo0q1Ep3hQ0rkzwYd8IFPrH12F/MUkk
         DcRX4ILiOGBRYfb0lerztsVcm4pniu2t+4dM9RIEiMiU4augIAzndnm85IIKhzBX/e
         +FjE6LmpR4VNz62CIw2oaIF0loo8TOjd6Iuc2Rvb57DTZ19IradlyAf+K+pcWK1Jrr
         QiVvHcJzN09pZeMr6s9iDRriPUeM5OtMiFB3TDmgV3TE1EBTn0CRju+tJEme1yhb91
         luQKwi8QDU4Cg==
Message-ID: <1e8b9935-9a1c-3417-124f-0a8694e06f30@kernel.org>
Date:   Tue, 11 Jul 2023 23:26:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 0:12, Gao Xiang wrote:
> It's unnecessary to use kmap_atomic() compared with kmap_local_page().
> In addition, kmap_atomic() is deprecated now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
