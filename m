Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352B6B797F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCMNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCMNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:53:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C111650
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:53:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2911322174;
        Mon, 13 Mar 2023 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678715580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4RVJxeFhlJK4A+jfUM+KWCrLAkkkjRrUSLboxMq/ZA=;
        b=Enayjk4sGDHXlLtY39BHsb2096o6MVzmUpyxOMzFWkmVN/TmG8uytSfx+nM53cAY5BY+su
        FP8Bovou214jGFkdxSjQyvklCkqkKk7ks+phskPtcoTLPxdFTIOnLLUdafTmNRvm45CjtB
        dexX6G/cuumsUtgySTrJn3+SfLKc7X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678715580;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4RVJxeFhlJK4A+jfUM+KWCrLAkkkjRrUSLboxMq/ZA=;
        b=3uYz12eEd+nE7SoTGeiUS4CeOvlAtw1V8TKb9J+6NUA+vcRrpweOtFFc/PHSj28MgeRYRq
        309jrdmuYqG/KvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAC8113517;
        Mon, 13 Mar 2023 13:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 21SGOLsqD2QbNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Mar 2023 13:52:59 +0000
Message-ID: <d264f626-19aa-70dc-aabe-283e4296b3aa@suse.cz>
Date:   Mon, 13 Mar 2023 14:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] slab: Adjust comment after refactoring of gfp.h
Content-Language: en-US
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230312122315.3562-1-t.scherer@eckelmann.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230312122315.3562-1-t.scherer@eckelmann.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 13:23, Thorsten Scherer wrote:
> Reflect the change from the commit below.
> 
> Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>

Thanks, added to slab/for-6.4/trivial

> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..87d687c43d8c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -526,7 +526,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>   * to be at least to the size.
>   *
>   * The @flags argument may be one of the GFP flags defined at
> - * include/linux/gfp.h and described at
> + * include/linux/gfp_types.h and described at
>   * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
>   *
>   * The recommended usage of the @flags is described at

