Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA56491CB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLKCPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLKCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:15:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD1C12AA6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB0E5B80943
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9544CC433D2;
        Sun, 11 Dec 2022 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670724945;
        bh=ZKf+4o/V97273q0lMwldddaurWkXAWLL/7zTyt41EzU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uNZagrMJDnJ1kCfTcrPOjHiblSXjo2oFYhTHhA27spxGJC3YCnIRe9bM97Qxkzvsk
         CFkxNiNuHi8fFEkSKztq59WL8USUvPWSNM8vJCgEEV7FnHz7m92O9azd73nlDWnFaA
         wQvp3BKK/RS6RqI5/LLMzyQdo++s2eshZ6cAHtCLMdj4FAkWAKAcqaCQNh4OSa/soA
         qN8R4jFwjVHRs7GEf25v0rdp9gXZZv5MG8kNX3f2h19Nh4v8L9vRZi0TcEYWrk3nlL
         7Yy+xXNszKSPfZJKYXzX51Z45FIGDGS5vfhcM6CpBs0VZEigmrsjmzH3Nxqt7O51Wc
         /T3BJM67MItGA==
Message-ID: <04a1cbf0-30ac-11c0-91ec-84f47f9b77f6@kernel.org>
Date:   Sun, 11 Dec 2022 10:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] f2fs: introduce f2fs_is_readonly() for readability
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221124024842.4809-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221124024842.4809-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 10:48, Yangtao Li wrote:
> Introduce f2fs_is_readonly() and use it to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
