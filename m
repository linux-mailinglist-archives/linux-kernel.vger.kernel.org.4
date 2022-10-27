Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14D60ED99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiJ0BuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiJ0BuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F212D836
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0743B8243D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D0BC433C1;
        Thu, 27 Oct 2022 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666835416;
        bh=9r3lqgGPcDjT+4jQOcIBTl7K7GeVbKmf/TyASW9/37I=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=t80l3foRX6O/9IFgANuhULcwZVbvs/f5valfitFAM3dm6SU+8tWE2SbVjz18Gh/Ew
         YoC7IzR7iVch+yqtd4SFEmJHWskh6Kh2IXt+6lFjKL7oltzYQgpP5cLTa5bloPS6vP
         NA+djexdVlxoKfxErDpw/g4y0cAgAsbDsZzbAQVq0IvieTiU9YFLzEc7cr0sZnqzOa
         PadnLWxK+cXuX9ZHhlBMzQ3DN6YbE63lj3eLPN/oG6uKDUUTI1tEQortF8kVVCFCml
         JMhLm//eLNkprYyFOVeLOOMK+07NvvTiFaBDKClntkmi5SoS4wgm+NKcTcf5TFnK5O
         KhRl2KeKpXckA==
Message-ID: <afa670ca-2b20-85be-163f-188af0b5ad08@kernel.org>
Date:   Thu, 27 Oct 2022 09:50:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow to set compression for inlined
 file
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221024233634.803695-1-jaegeuk@kernel.org>
 <Y1lpAJiPCMSXf1d5@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y1lpAJiPCMSXf1d5@google.com>
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

On 2022/10/27 1:06, Jaegeuk Kim wrote:
> The below commit disallows to set compression on empty created file which
> has a inline_data. Let's fix it.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
