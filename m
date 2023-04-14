Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641066E1998
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDNBXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDNBXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DA10C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEA16097C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73474C433EF;
        Fri, 14 Apr 2023 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681435395;
        bh=XYBB62Apz0vDm2QneI+v9A6E4O1dcjYUuUjQ4/vo600=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=l3aRwe86tu5oI2Z1JsemzLheunaKdn9qM5xy5gfdwlEXWbvV+eodkqXcPhTn4TAEw
         2qZKxG1CAu2zgEfyC02170XNy5xuDfHpN5FtpiM8BqTDwacvQrhT817DHcP1QOcZ9E
         HbOTrMtYzYtwHy2Wj5SNMIdzk/aaY89O6i08F4agyxqpsmklD0KwcqDulF2USnJe3X
         zGonzrqKb5ou/RO1POp9ZklsRsRz7UH7W6mLJc6liVKFPbVissGa5AgMYdfUzZOFpR
         NTbDhohOMKt5ijEMTr9lmZfdoy3Vm9jrebQe8uzowY93gpPAancTZJ9xokCRgL7lxB
         SVdRQ524Emhig==
Message-ID: <504dcb25-f45d-f189-2743-1152cb944380@kernel.org>
Date:   Fri, 14 Apr 2023 09:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: relax sanity check if checkpoint is
 corrupted
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230407181539.4136580-1-jaegeuk@kernel.org>
 <ZDbZlwH5u3/nOTwL@google.com> <ZDiI2ypb3FECoSK9@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDiI2ypb3FECoSK9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 6:57, Jaegeuk Kim wrote:
> 1. extent_cache
>   - let's drop the largest extent_cache
> 2. invalidate_block
>   - don't show the warnings
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Oh, just notice v3.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
