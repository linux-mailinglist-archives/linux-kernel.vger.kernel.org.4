Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5276C94E3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCZOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjCZN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704118698
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11490B80C9F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2D2C433D2;
        Sun, 26 Mar 2023 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679839158;
        bh=sy5oB1jGl5NyPGDEk6ucFnmB2CrWfwzaQ7l94wppgDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HLFelDOAaeF5K1Ycx3pKqaZeThP9jqqJvLnnb5aetp5J6vJIyIBZXZPTAYjaCYwU4
         EcckWajVjpK8pcPJvFVsXBbgizOAPnxF0AHkQGajQZlhE2NtRJe4bzAN99gPVhZrB6
         GpP7xm0O0uOrwY7vazFFyWJ4sPjFZUgdIRPp5VC3EsP5maIf+dz+JsnZUYaNZI0Loo
         B8mCxRjpcsWGGOzI0zBsa5F89tSAqAaE900Q73CRxWyZRXqFi9fJqJLv1/Q5zlUOJJ
         8ldMYFqtknc9e7S0lezYwlzCA5jvCjbKuqjZFfWVyXoD1Sw1ahDznTS/NSsmRDcTLo
         Gfdgw6//Cr8jg==
Message-ID: <99c78643-1b34-4b4c-67ae-61aabeea7f0b@kernel.org>
Date:   Sun, 26 Mar 2023 21:59:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND] f2fs: convert is_extension_exist() to return bool type
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230319075822.79337-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230319075822.79337-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/19 15:58, Yangtao Li wrote:
> is_extension_exist() only return two values, 0 or 1.
> So there is no need to use int type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
