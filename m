Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C056E3958
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDPOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDPOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A963C35
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768F46115E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B47C433D2;
        Sun, 16 Apr 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655768;
        bh=ZyWpvvtl6ausC+L04T+VxmLWEhXr4qGI8K0y/PTwvKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jT11b1ZELErTHW52Xlnjqn0vjBpk0wYfTSqu1b9afDEUfMIrVAwZVd0pTFWnKyiI/
         ZmOx5sqYbINdXzucXIMMyqZWaSeu3Nz54gr2HEK5A/DDCnIp++f0IczDTllafAmB+v
         DyBPKFVrIsJTRWtUPVl2F4xeBocfhi6rPIC6/BhXQ9eq87PSF2lDx46ay9tetOVOiT
         7zEiUgMdFyG7Zh4wMdKnqZcACj+x0zwi8atbXRR8hmrlAL5MbkKGpHe7ofBI14viqh
         0Qemr3T8EFwPJITZOBnAxXhFvC4h13raljkYbjEmEgP0i9hVSrkkSKROWll08z790h
         69R9ouhQZdA0A==
Message-ID: <c6c6cce7-7e00-cb31-a3f6-2d3e47098050@kernel.org>
Date:   Sun, 16 Apr 2023 22:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: get rid of z_erofs_fill_inode()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
 <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 17:22, Gao Xiang wrote:
> Prior to big pclusters, non-compact compression indexes could have
> empty headers.
> 
> Let's just avoid the legacy path since it can be handled properly
> as a specific compression header with z_erofs_fill_inode_lazy() too.
> 
> Tested with erofs-utils exist versions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
