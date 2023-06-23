Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866F573AE68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFWBmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWBmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A162120
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F00611D0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEF0C433C0;
        Fri, 23 Jun 2023 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687484537;
        bh=cJxVoMY9xjzzczcnG6Wx/YgMPUGQAZLGMTbwz1sVih0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sWB6/SsM+KGbb7N1cyDmOikfSV1uc7l8IUQzvSC8FcgIUfsHqZzsJKQGjP+ZY8Eyi
         6tUaamhpSsDfeFfZE9Rn/XkYh/9xXmDtSgL5P3HRKqF4Fxol0cykkMQL8T2NpAyqiv
         Mojz09Kk9KH4z+CIdBdr8H0Luc1L5NNMRqbcmCM7Voo+p4QPYBuN5AdHSuih+8o9oW
         N+WXDaudTZTeVXp3wwwU2HJ0pqvI/Bu5OT7gY5GDzVfdEsm7OndD9ZTCEdwanGLEHT
         CwmFYSbsJ1rrqv/UEi611So4AQmNvfufPtYFZkyPugB6f/XaoITtgmOjR9GBjmOvwG
         B7jyaaUmcWAcw==
Message-ID: <9a340123-1f11-44da-5090-b1acc669a309@kernel.org>
Date:   Fri, 23 Jun 2023 09:42:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move
 file range method
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230622161647.742012-1-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230622161647.742012-1-heyunlei@oppo.com>
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
> Mtime and ctime stay old value without update after move
> file range ioctl. This patch add time update.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
