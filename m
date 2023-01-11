Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6422665DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjAKOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjAKObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:31:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321931EEF6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:29:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 640CE4A8A;
        Wed, 11 Jan 2023 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673447370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11TdC+X9GAIhdtANdYb0FG8UhriEm5EsKvnTy5Yrh1Q=;
        b=yTf0OrrqnBcDK4s+2mupR8LUxKxMsW9Jjxi7o8GF7kgUibFhTL4iR2QMW13gDsanjViqG+
        bs4vl1Jw+YGEj93r9qMSNQzJUKPyaR3xyW28Qqle6J8pJgGvI+tlKfAK9TkwdoJYLwJkba
        PqX31jtXzEhE+HpOQjAAMPZpxu3Kzg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673447370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11TdC+X9GAIhdtANdYb0FG8UhriEm5EsKvnTy5Yrh1Q=;
        b=NMWlc0vLV6oE131HarQzWLZoYOV7/5mMYxF1lMqKYlmDvRLN5AP6bLOKDx4+fHOF7CgKgy
        eVOZjEqEeD1acWBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C65D13591;
        Wed, 11 Jan 2023 14:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2NEpDsrHvmPhEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Jan 2023 14:29:30 +0000
Message-ID: <953dda90-5a73-01f0-e5b7-2607e67dec13@suse.cz>
Date:   Wed, 11 Jan 2023 15:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: mm/kmsan/instrumentation.c:41:26: warning: no previous prototype
 for function '__msan_metadata_ptr_for_load_n'
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <202301020356.dFruA4I5-lkp@intel.com>
 <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
 <CAG_fn=XmHKvpev4Gxv=SFOf2Kz0AwiuudXPqPjVJJo2gN=yOcg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG_fn=XmHKvpev4Gxv=SFOf2Kz0AwiuudXPqPjVJJo2gN=yOcg@mail.gmail.com>
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

On 1/11/23 13:10, Alexander Potapenko wrote:
> On Mon, Jan 2, 2023 at 11:01 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> +CC kmsan folks.
>>
>> I think it's another side-effect where CONFIG_SLUB_TINY excludes KASAN which
>> in turn allows KMSAN to be enabled and uncover a pre-existing issue.
> 
>  Thanks for bringing this up, I'll fix this as Marco proposes.
> 
> Would it also make sense to exclude KMSAN with CONFIG_SLUB_TINY?

If the root causes are fixed, then it's not necessary? AFAIK SLUB_TINY only
indirectly caused KMSAN to be newly enabled in some configs, but there's no
fundamental incompatibility that I know of.
