Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4482D61085A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiJ1CnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiJ1CnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69D9D510
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF60F625F1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC9BC433D7;
        Fri, 28 Oct 2022 02:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666924998;
        bh=yP9Mp7mnc/566BWrPMyhrgwrKWfXYoU3X9h4DV4JM5U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TlN8lYNcQG70MpuVcJc9DXLflVqSysjT3LfAS4QfhsURfSziohSws/k07QWudIVpm
         yloqZt0crw8+9uAemWBocU3JcJL28rj4A/h9fx95jyCFGnjNev4W8UQDMayLherkP2
         uFSte6ai7qMFwHCpPHDN4Q3Wyld5hMJftTxHTveaQvy7eFEA6U81R6fBSUkHOkjKJr
         4dCVpEcdYuSM7FFP3CmhZZ8Vsw32yPJTLOfNS+8sUlIUlSKwxYW4M5iZSG8uhaaEJa
         gU2gHHLJpX8eZYUn+oMssw04ZznDeNg4TdYtUQCsQgenGg/H4wJEZt/KAxXFryHZO9
         mHK8PR/WHLerQ==
Message-ID: <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
Date:   Fri, 28 Oct 2022 10:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when
 errors=remount-ro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
 <20221028023303.28020-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221028023303.28020-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/28 10:33, Yangtao Li wrote:
>> It won't pollute global namespace since it's a static function just be used in f2fs/super.c...
> 
> emm, I think it would be nice to see the f2fs_record_error_work symbol
> in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.

Oh, yes, let me update in original patch as well.

> 
>> Do you mind letting me merge these two patches into original patch?
>> since original patch is still in dev branch, rather than mainline.
> 
> Glad to see, if resend.

Thanks, :)

> 
>> I guess it needs to stop ckpt thread as well...
> 
> agree, :)
> 
> Thanks,
