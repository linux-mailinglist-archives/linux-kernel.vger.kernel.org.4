Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6ED73AE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFWBmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjFWBmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41122130
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E626192D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7DEC433C0;
        Fri, 23 Jun 2023 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687484550;
        bh=Pu/Ud2S7x4FkiUyqYdunAGU8qjyJ9i83PmWbbVE3LlQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SOGM/z6kpzjBZ9JgNQ+Jav+IF0NFglgtCIwh6u+SCtoTBF5+w3yj6PY5KufCFF/Qs
         BG2Og0lGEQH07yR8uD+hk4yKYDG2vEVFxLrCxOV0JcaYy3Fb9NBJ0OAnUt0pj5HRuk
         PucQRxVKxbv9ay2iDnFKVeTLXeV2Gwt99zExf2pgjqvq6aLlHj6SVRRoJKwMkMZqnz
         FR/zOBRDXFeso8Eok9TWsPVhHXIG7iUaEhHsXc+D/wGOKqrnGMCyA0n+HaEuI8Dg+a
         X1c7f0/fu9S1azfceZTaZdJXEWn1uhjz7FJHuXZ2izc1GmOBELwjszJenOhTDiVWht
         9aqBbl8cdPPqQ==
Message-ID: <1cea02d3-6f3b-726f-bb31-748f144434a5@kernel.org>
Date:   Fri, 23 Jun 2023 09:42:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH 2/2] f2fs: truncate pages if move file range
 success
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230622161647.742012-1-heyunlei@oppo.com>
 <20230622161647.742012-2-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230622161647.742012-2-heyunlei@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/23 0:16, Yunlei He wrote:
> If move file range success, it should remove old data from
> src and dst page cache.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
