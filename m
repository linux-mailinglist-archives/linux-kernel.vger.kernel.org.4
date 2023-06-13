Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30472D695
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjFMAp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjFMApZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E68110D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A004462A5F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375C5C433EF;
        Tue, 13 Jun 2023 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686617121;
        bh=eFkokBRn7jvPbmEIYaLNA1SVW4wN9lOQvNF/OeMvoFg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ArllJx54DLzD1TeRGUZOnBIcE5S3MjymuzHypXbwscaR2H9u+r+nLbcNDzUHrsDup
         mgp3b/W2fUUTZDtK6iHrLP9OsZjQM440k9V1SyvgEg0zkgbhhA/gY7Mh/9yQeMTu0E
         X2xtrrWAyr+/PFoP9JtS5dedJKGJwkj0RjoSy0Q3dyt9gdrRI4siHe2G9MjcqtgSy9
         cWIu1YLuyZuIyH8ZS5tmMPn520h8i8Tps66L+Rl/sggKnUjvObzjDbFNyaZaMqN2VE
         Sy4bcgKrJdZ/dyyJyNsMrEbmnL5I7wmcM0o1GHpKRQEc/mUm+jbpzCngUUgdYeS3Qs
         WyGXzgy2JP9OA==
Message-ID: <d92516e1-2eed-c46b-78a0-4a93573c0ed7@kernel.org>
Date:   Tue, 13 Jun 2023 08:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to
 ZSTD_CLEVEL_DEFAULT
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
 <ZIc28R76RSEC6uo1@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZIc28R76RSEC6uo1@google.com>
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

On 2023/6/12 23:17, Jaegeuk Kim wrote:
> ZSTD does not support compress_level=0.
> 
> The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
> started to complain this.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
