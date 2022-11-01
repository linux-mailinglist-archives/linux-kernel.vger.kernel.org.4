Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0C614E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKAPjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKAPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFEBCB1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF30161633
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D7C433D6;
        Tue,  1 Nov 2022 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667317159;
        bh=65CZL2l1IBOmMGUelHQiR1wpkyHLMFLr7kZuNM7OCGE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=pUk9QZid7zs08/+OcIlt14B3aGnShZLGKET+sTGEI7U9P0jO4rnFZG1wIkgULUGbk
         R+yjtmEHm/roUpUgnxQ1GsyuRM2wRZnGP+Rz/33f3AGCVEL9G7gyq5q2pAsqDouHT+
         ZMhjM72Nc3OoC3m/6K21uJJyiaz0VbqVirHYBfHqicsFKe2FTtWVtCFq9KOIEM35cX
         4S07QuKnNO+7QfwMujpV8UW5V3AxIBV6PCZ9aPztAYgjYJu8manD7Qnw6uQwIU3X25
         xHUeaRe/NmhCe9ZR4dEE4drjram1n1zua00M4Ffj540cC8Rdc+6xV8OJ1lJXjU0zvk
         PoxcpYZbYlCyA==
Message-ID: <e4ae8a72-3e29-637f-2cbb-0e81020da1d5@kernel.org>
Date:   Tue, 1 Nov 2022 23:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: use sysfs_emit instead of sprintf
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221028165827.11558-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221028165827.11558-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/29 0:58, Jaegeuk Kim wrote:
> Let's use sysfs_emit.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
