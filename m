Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361D72EEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFMWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B719A;
        Tue, 13 Jun 2023 15:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DC062012;
        Tue, 13 Jun 2023 22:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D1C433C0;
        Tue, 13 Jun 2023 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686694543;
        bh=qcO5Gh4O8Q63aCjwkm3HeTPqucX4BuJEg4NLQuZYNpc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ob8kwTkjuXGGi6Ir+cBZ1TDTBMLhGcEgvPTwUfQ5At2Zag3f/sFmki0LmICMkwBWc
         Elp6J1hDCTuWwXfRdxul3qMkFO0IipYBWKT7FhFAHFvbt3e5MmUwiIoITaLIpI5YYN
         jkiuUwgayewfKYwrDY6gK0vQKuPmWpc/4FD1IwzRfVJ/4+Re290rRYoBSX5kkqs8cQ
         H67Kr+zHf13r8/g2+lSew1fzVgkjTsp8/Jkzmp+kN4hA9QCsf/Ia/WjUYRMB1gTcc9
         8HGzRfwQciNi0UjYBbM2bVsrTMcVLK2p+KieuBu26DJEupIsYDPy0t5CNQb41VqRze
         nV2Un1I/YgENg==
Message-ID: <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org>
Date:   Tue, 13 Jun 2023 17:15:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530162358.984149-1-azeemshaikh38@gmail.com>
 <202305301620.346CC541@keescook>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <202305301620.346CC541@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 18:20, Kees Cook wrote:
> On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>> No return values were used, so direct replacement is safe.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
>> [2] https://github.com/KSPP/linux/issues/89
>>
>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Applied!

Thanks,
Dinh
