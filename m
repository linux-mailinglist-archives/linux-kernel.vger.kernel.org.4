Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419406C6C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjCWPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCWPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:21:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266481BAD3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BADCAB81F10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9560BC433D2;
        Thu, 23 Mar 2023 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584894;
        bh=wDNZypUN3pUlKsoLg7F1xpHMXCzrpFZE6n63BErOVPk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rEaAOL6Es2N0HyP3hVvjRdkPuh45Nbw+xFfMk0W3cMJXSerXAJj0pS2yiEGmnDB+5
         GcbP/o97JVVbtmh+jFXZdp5YPjJgmoFCmEpbB9Ltx2xcKfEHfwB91HkIEQ8ziB/A6D
         STY+f+Gyawhntzay8BYIpLuJkEF7Etp6QSX5PSdYEyVpEhmA0PwI1CX0fhqy3XHirG
         4RJf+tIOHv2ri34ugm64K95qcDVpqntGgEao6Kl+84Co0+mSSUtC9kwuD4UsvlcZyP
         DYEfT1DuiaNLtKD4f9CP2qQiLvyoDK/XBoi1byFNimjoAPsMuhW+xU25QXdnVSKTR5
         kbZsRYknhE+sQ==
Message-ID: <90993654-9fff-685e-55a2-8698bc719cf5@kernel.org>
Date:   Thu, 23 Mar 2023 23:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: fix to handle filemap_fdatawrite() error in
 f2fs_ioc_decompress_file/f2fs_ioc_compress_file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230302095509.53720-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230302095509.53720-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/2 17:55, Yangtao Li wrote:
> It seems inappropriate that the current logic does not handle
> filemap_fdatawrite() errors, so let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
