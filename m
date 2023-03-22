Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3606C4C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCVNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCVNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:47:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA264223;
        Wed, 22 Mar 2023 06:47:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peyoM-0000eD-2s; Wed, 22 Mar 2023 14:47:30 +0100
Message-ID: <165bd284-580d-df03-ab04-f5214b1e6be4@leemhuis.info>
Date:   Wed, 22 Mar 2023 14:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <87a60frxk0.fsf@meer.lwn.net>
 <d233a796-1cb8-a9b3-5a50-043dd2f98b3e@leemhuis.info>
 <87edpomtzn.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <87edpomtzn.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1679492855;0d768313;
X-HE-SMSGID: 1peyoM-0000eD-2s
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.23 19:27, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Documentation/doc-guide/contributing.rst says that "books" are meant to
>> "group documentation for specific readers"; creating a new book for
>> tutorials would work against that, as readers (users and administrators
>> in this case) then would have to consult two books.
> 
> The idea behind that guideline is that readers should be able to know
> where to look and to not have to dig through a lot of material that was
> not intended for them.  Not that, for any given reader, there should be
> exactly one book that has everything they might want.

But having things for one kind of reader together within one book also
has benefits.

And I don't see a lot more documents of this kind coming down the pipe,
so it might become a really thin book if we create a new one.

And I still don't understand once aspect the bigger picture here. Would
that new book also contain tutorials for kernel developers and
application developers? Or do those readers get a separate book as well?
I guess they should, as having a clear kind of reader in mind when
writing something is just as important as the question "am I writing a
tutorial or a reference documentation".

> One could also argue, of course, that readers seeking tutorials are a
> different group than those seeking reference material.
> 
>> And isn't for example Documentation/process/submitting-patches.rst also
>> more of a tutorial than reference material (which we also have in the
>> form of Documentation/process/development-process.rst)?
> 
> It's a pretty clear example of what happens when you try to combine both
> types of documentation - you get something that isn't ideal for either
> type of reader.

Yup.

>  It tries to take people through the process, but it is
> also the only reference document we have on how patches should be
> submitted. 

Well, there is also Documentation/process/5.Posting.rst (but *irrc* some
information is only in one of the two documents, some only in the
other). But whatever, that duplication in the discrepancy between them
is a different topic.

>> Does that mean
>> it should be moved? Into the same book or a separate book, as it has a
>> different target audience? I fear that might quickly get confusing for
>> readers without any real benefits
> 
> No, I wouldn't move it.  We could, someday, consider splitting it into
> two more focused documents, one of which could (say) go under tutorials/.
> 
>> Or did I understand the idea of a new book wrong and you meant something
>> else? Like creating Documentation/admin-guide/tutorials/ and putting the
>> text there? That might work and would help future authors to get the
>> right mental model when writing new texts. But I'm not sure that's worth it.
> 
> I wasn't thinking of doing it that way, but we could certainly consider
> it.  It doesn't seem like we would have vast numbers of these, though,
> and they would mostly cover relatively elementary topics, so a single,
> top-level directory might be better if we decide to take this path.

I didn't reply earlier as I had hoped others would join in and share
their opinion. Sadly that didn't happen. :-(

I currently can't really see the need for another book/top-level
directory and to be honest it's by far my least favorite solution among
the options on the table.

I'm taken back and forth between the other two options (e.g. put the
text in Documentation/admin-guide/ or
Documentation/admin-guide/tutorials/). Maybe I prefer the latter a
little bit more.

So how to move forward now?

Ciao, Thorsten
