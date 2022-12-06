Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA280644581
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiLFOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiLFOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:22:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06FB2DA96
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E5D6176A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35EFC433D6;
        Tue,  6 Dec 2022 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670336533;
        bh=TpKURkk+sASQmNIaZKp+Krx4lS0RDFgA3OYkx6AYYSI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C20jz1UPh+YIQkWDZfE26I50SgijlSNRFakXXnU4ETUyKADHFhOzBFUyzidFKv6y+
         msrJZmzoIEFsnCQ0fmR3568WPwUhsVY40sGV+WYvt1IqAa7RpDEcMMBzSTav2Zv+NX
         KjrsoRHgqR0H4jg5LzC8vxbbzB7MSL/uduqyZOtVHJSev+2Xo6hCzNrWlhZGyfNrYq
         vwuDJIywf0ffrEtWnVK4kBN6ZVTnKzON9ScsHTTTpSpQZ0xLKZ1W8EB9Wya06XKh8a
         SIOMSNHSX+1Q0kP5WQQXNdm4OC1zUQi1q5fBAIxkyyrBVk5WImgBTm6NgDjuVQIr28
         n0qxwXvZMMmHA==
Message-ID: <ea5b67c4-d7ab-199c-d4bd-c6d353145864@kernel.org>
Date:   Tue, 6 Dec 2022 22:22:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] erofs: update documentation
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
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

On 2022/11/30 17:56, Gao Xiang wrote:
> - Refine highlights for main features;
> 
> - Add multi-reference pclusters and fragment description.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
