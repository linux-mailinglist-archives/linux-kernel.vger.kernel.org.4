Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C6665C87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjAKNbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbjAKNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:31:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2881B1CE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:26:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A73CCE1B8A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF97C433EF;
        Wed, 11 Jan 2023 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443594;
        bh=5uTuSkRij3tB7MfvutYSz+QKNc1AdosporoRVPXJjFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JMUSmLn3nsr0FqbgNcr33Rn7Xr20dlr0DUAHpvqJgynkz9yh478mvYKm+3UmVEAk9
         4vcApuxn3n2I5nF/IDWPdf9TLEcvuUfS0VBKdl6tSJFa9bFmMSmLybA5In96bI7mY4
         X7fqPX4Q4zsrjZYnSQPL9m6BU+PD45mQLaJMGJlqYtXkd5ZpCXE8EGTlur+lfDM1BY
         PYg492teGQVkuFF1Ahi6n5YB1KQQkcilKAH9XLN0k2kXz5D3eNlSVlT7O8DVHk+nSN
         DOyzlPbmTLd9IMI/Yabr5zcjoGxXTaVq61ZMv6BuHJ9RY+XUhjEAfMYBGeqwgi0rFO
         bPmSiA/d4yLPQ==
Message-ID: <c22f71b9-84e5-3a1c-34a9-a29e6c31de98@kernel.org>
Date:   Wed, 11 Jan 2023 21:26:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: add a f2fs_ prefix to punch_hole() and
 expand_inode_data()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221220191212.58042-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221220191212.58042-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 3:12, Yangtao Li wrote:
> For example, f2fs_collapse_range(), f2fs_collapse_range(),
> f2fs_insert_range(), the functions used in f2fs_fallocate()
> are all prefixed with f2fs_, so let's keep the name consistent.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
