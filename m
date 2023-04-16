Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39C6E393B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDPO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDPO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F62D78
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A4760C8F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B3CC433D2;
        Sun, 16 Apr 2023 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655358;
        bh=7FStxHBdst1il4TwvF6jUyQJzCfiTLjd/zo+/SZnMGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AtWc1soElWRYxqrPL3w7G5ukmunGLzsMGO7GgYIE+VusxKsZ2nZNV+IIyMYprPhMB
         gPq+5PM/eZ45zDuYF7HcmQd6sIItNHbbzqoyNbmvgNyIDPpkJ5wDIP8JXToUPOUVWA
         RnaIXsinVRjZw3fFTQrEH90s05tlpoHrsmG+xTrg8Z8mKmas5YG8oEedSl3m+uS0pB
         vcB4mR1Y0W6z9WGGarE4Z8GjIAKbfQzjbLP6YBhm5WwevB3ixz8pSZIeLj/HkPV63O
         Ux0Ob+ZsdnB/MLlufnE/i1XEYaYnuvDkaQDT5QfistxrY1rw3Issz+z0favyNUicCr
         wqyFQcAIhCenw==
Message-ID: <1cc4f1e8-d15d-37d0-b59b-b073fe0cf976@kernel.org>
Date:   Sun, 16 Apr 2023 22:29:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-4-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
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

On 2023/3/30 16:29, Jingbo Xu wrote:
> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
