Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E906D5DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjDDKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjDDKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F91BD7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3240C63169
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD8C433EF;
        Tue,  4 Apr 2023 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680605288;
        bh=5m+oqv+VG4vlFEAz1qs/LGut7wc74gTjeaa4PysObi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hc1x1Pbis7mqXeu8Cv9dHaLD4Rj1AXAYEybuq5NAf6ZbBa0dR27od/rXDYDBcJbiD
         H06f0TQQk0+kRvEmeTjcjFASsw0/RruC/rqZ7i4RpUxsvDZ4TjQGfIPOe/5ECyQaaR
         lmVUiDD7lFJTMOhJw5gXA6HD5vfWgfYSvEHU8Gc6kQfS7Pn8jX98DJlXS5JK58X75q
         n43loDc4AOtfEJWydPWV172r9O5ekkCz0yqwOsUCpYKu+etWU3KUmb4hEYfMUbuJuy
         1J9puP/WIciJ0i4CeIA+0E1jpmw1JW2AtU3SRMzGDsYGvfYoJjQYPL4mb1/YlHHpLG
         ytbCe1ug+v3hQ==
Message-ID: <4ffab766-c1ff-e009-f6e4-a602c4a0db79@kernel.org>
Date:   Tue, 4 Apr 2023 18:48:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] f2fs: remove struct victim_selection default_v_ops
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230404040051.50726-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230404040051.50726-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 12:00, Yangtao Li wrote:
> There is only single instance of these ops, and Jaegeuk point out that:
> 
>      Originally this was intended to give a chance to provide other
>      allocation option. Anyway, it seems quit hard to do it anymore.
> 
> So remove the indirection and call f2fs_get_victim() directly.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
