Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1C659C04
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiL3UXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiL3UWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:22:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD91B9C6;
        Fri, 30 Dec 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VNS6f3OvTSGCAOQIBsZyhnlAHMi3sUvuzkVH6AUStJw=; b=m7NlslhTSfDZ4ZmUtfxp/Xnu39
        wcMW9Fs6D61tkVOkb9aNJzUeDxCMFpfhokxj4Iw7og/X9ymIO6TuAPxilfBxTro6vt5RwDuOQ06Nx
        cTa2IDxucTDOSrb+D2KAysnWe4vtMRZLRo6gt4jaePiEqE0AB1wKXuKcjAJLcXNjPAy7GoWLUJaqa
        F0r5pTDYKbUyvnHoBH6rutQ+T1fLyCK+3HoWkT1ZXczYLvKri+ToDnSC/pBUiSuQ2JeCRURvOoWQj
        VtyOJlOHwCn8iJV5S7avqZR8wVgsOBaoTwrFSSfs8tjHpUS0NGxrX3LuodOWmnERikKe7sCEbh9L8
        v1hkV1Mg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBLty-00DF6m-Ka; Fri, 30 Dec 2022 20:22:50 +0000
Message-ID: <855df2ca-0760-2106-4e3b-2af7ce15b9eb@infradead.org>
Date:   Fri, 30 Dec 2022 12:22:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] doc: fix typo in botching up ioctls
To:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221230172328.58612-1-federico.vaga@vaga.pv.it>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221230172328.58612-1-federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/22 09:23, Federico Vaga wrote:
> The type contained a typo `uintprt` -> `uintptr`
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/process/botching-up-ioctls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v1 -> v2 fix the typo in the commit message
> 
> diff --git a/Documentation/process/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
> index ba4667ab396b..9739b88463a5 100644
> --- a/Documentation/process/botching-up-ioctls.rst
> +++ b/Documentation/process/botching-up-ioctls.rst
> @@ -41,7 +41,7 @@ will need to add a 32-bit compat layer:
>     structures to the kernel, or if the kernel checks the structure size, which
>     e.g. the drm core does.
>  
> - * Pointers are __u64, cast from/to a uintprt_t on the userspace side and
> + * Pointers are __u64, cast from/to a uintptr_t on the userspace side and
>     from/to a void __user * in the kernel. Try really hard not to delay this
>     conversion or worse, fiddle the raw __u64 through your code since that
>     diminishes the checking tools like sparse can provide. The macro

-- 
~Randy
