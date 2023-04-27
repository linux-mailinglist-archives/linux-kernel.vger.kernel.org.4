Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6916F03A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbjD0Jqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbjD0Jqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2340F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6BC63C1A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF1CC433D2;
        Thu, 27 Apr 2023 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682588801;
        bh=faO1Iiushfs5WZXOoTBrEe2Q8A6BFQcPbVG1Q2MeGEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g8R58B66hbkMv+pphipwP7OoCK6NoAbYBVvkBypg/Ts2a5kqUgkS/ovd/cmy2C2VT
         zdcSKs8cDo9qMw6WYSuI82iBpNYZV6HLTldJqt2BI7dbR/6gjwkyNXIV7fwyKN9xGD
         B2Gk7htoBwg6Fpdm8S+xNJDgaUO15IFjrPbJto3TUiwDLAqZVxHNaXLqkV2pM6j4Xs
         becs6xwX8UwjLL9BhBZT4djDy+9gNUMgY9DJl57ZA0AbmvMiHVGZM1Z9/k/WIzitOU
         WUmRlCkmX/XGLYblF7SnNU5y9ERvux08nWTHxDSUdRgD0n7+xmx6XX0w3V7Qcd8R8L
         FKRip5qFNEaVw==
Message-ID: <1a602371-d9b0-7148-c916-a02c40649d53@kernel.org>
Date:   Thu, 27 Apr 2023 17:46:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: do not allow to defragment files have
 FI_COMPRESS_RELEASED
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230425164711.19826-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230425164711.19826-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/26 0:47, Yangtao Li wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Oh, I just see v2.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
