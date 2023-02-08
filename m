Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AFC68F3A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBHQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBHQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:44:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1CC18B32
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:43:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14C65341C8;
        Wed,  8 Feb 2023 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675874636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8k3Rjg4PaCS2IxrnyzGhVgW/FDjVB2k5vyLOUXYNc4=;
        b=KnJu5ARZqYGvfqldBDzeKfE7VX1ZWjOWBd4xbipFt0xYdDHntl/FGNlxV7UyDtboQaH4Sb
        48PDJbp2B6nExRDufYsLaYvlm+8HwONlkXcFiJH62CDmDObMKlVpwszFmSJ5b2uZtzouk6
        NYt4dzIBjQSA/w8odi4F/C2ju8+g+xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675874636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8k3Rjg4PaCS2IxrnyzGhVgW/FDjVB2k5vyLOUXYNc4=;
        b=h6RhsLdjNFvyQAoZ+q8/xjJzZ6a2LiFZOWXfPsyc9vjkINb16SRJa/kdk4nj3oxfhwHzeI
        KDTFWtmaeMi7mfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4BF31358A;
        Wed,  8 Feb 2023 16:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TBQfN0vR42PsYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 16:43:55 +0000
Message-ID: <00da0073-745c-ddef-5e9d-960346adef73@suse.cz>
Date:   Wed, 8 Feb 2023 17:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 11/18] lib/stackdepot: rename slab variables
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        andrey.konovalov@linux.dev, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
 <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
 <CAG_fn=WxZf_kfn8-G8hvoxvUT8-NKNkXuP5Tg2bZp=zzMXOByw@mail.gmail.com>
 <CA+fCnZdOFOUF6FEPkg2aU46rKYz8L9UAos4sRhcvfXKi26_MUw@mail.gmail.com>
 <CANpmjNNgoHdmZEmnOMzBTXZ_Px=fipg-iSk3Hv1fE7MO7+fovg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNNgoHdmZEmnOMzBTXZ_Px=fipg-iSk3Hv1fE7MO7+fovg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 13:38, Marco Elver wrote:
> On Tue, 31 Jan 2023 at 20:06, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>>
>> On Tue, Jan 31, 2023 at 12:59 PM Alexander Potapenko <glider@google.com> wrote:
>> >
>> > On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
>> > >
>> > > From: Andrey Konovalov <andreyknvl@google.com>
>> > >
>> > > Give better names to slab-related global variables: change "depot_"
>> > > prefix to "slab_" to point out that these variables are related to
>> > > stack depot slabs.
>> >
>> > I started asking myself if the word "slab" is applicable here at all.
>> > The concept of preallocating big chunks of memory to amortize the
>> > costs belongs to the original slab allocator, but "slab" has a special
>> > meaning in Linux, and we might be confusing people by using it in a
>> > different sense.
>> > What do you think?
>>
>> Yes, I agree that using this word is a bit confusing.
>>
>> Not sure what be a good alternative though. "Region", "block",
>> "collection", and "chunk" come to mind, but they don't reflect the
>> purpose/usage of these allocations as good as "slab". Although it's
>> possible that my perception as affected by overly frequently looking
>> at the slab allocator internals :)
>>
>> Do you have a suggestion of a better word?
> 
> I'd vote for "pool" and "chunk(s)" (within that pool).

+1, also wasn't happy that "slab" is being used out of the usual context here :)

Thanks
