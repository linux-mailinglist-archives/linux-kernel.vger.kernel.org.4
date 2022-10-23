Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37744609759
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJWXri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJWXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:47:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B645B529
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:47:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FEB45C0079;
        Sun, 23 Oct 2022 19:47:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 23 Oct 2022 19:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666568853; x=
        1666655253; bh=SEexSojSEsUM9N+Ow1IsnK/nrCRGJAod2sk6WmNyEY8=; b=u
        scImcc4baXfoAo7sanlkEY0oma7MmwICTGh2rMQUCOJWzREg5uTmyh22Ib1rOWAV
        LD4BwZtJcB3fQxNlA9c42qgqcLPo85BiK6fLBrwpAyWPdNJwXgWX4PfOANw6kV2w
        +IkJU3LylCb6gLJkj4jtcQE5irk5P6glzpI5t3+tDQfUHpXNCnp+9X8UihRrOOpK
        0jfq6p145p2bjA8mC+LW8mzIQWowHRpmorCslCxvBANGOhiRLlb0XLn+oIGzCe1W
        gp06zX/uW6+v8iAdJBYrp1qdDq0oUCr6GE72IVBB6kfEtU5fVZuzyK4SBP3aK4Cg
        p9nncJrGayva2yfAiz8uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666568853; x=
        1666655253; bh=SEexSojSEsUM9N+Ow1IsnK/nrCRGJAod2sk6WmNyEY8=; b=C
        jXF3MD78vwE6SMK1UpBfwJspF38pIe1olEegUi755yykdh6cdjFCkhVvMUhWzwiF
        dCC9Xg2XQJur8j4bW79D//QJ2igpx9LJd6oUV/H6cUGNf2V1NxvRi/KbfNeBFpgT
        lX527PpULX9kRpBQbkDwa56nxJRRXVc+ZH0+t7eq5D8VueB//C8GVhktmUn3lYXZ
        +vb7N5e/4CERFhS2E3lUD9i4q4oVDpKA8KW84was73ByB7//C1ZYWm+CQ2pTGx+o
        unX5NFGRadt3CpppCU9/4hJ9S7d5ezTeCNnEEF+ddwXKmY4E2YaUI9Nl2jHsdZOd
        1RTF1RgyE3AqwHnTcTlSQ==
X-ME-Sender: <xms:k9JVY1OV3HuhQg05BFoqLxSRR2kC3nl6ack6_QVSfW8RBzYLvEeVBg>
    <xme:k9JVY39CjtVKqC9SYgpBNEBfmCni76OStohdmA-EpqQL0FJdGwfvDih6l6WrVyDgl
    WS4dD92TVw8>
X-ME-Received: <xmr:k9JVY0TCxCO_2-rb-E3flhODKtQtli96Uol7jrCe1Es8LJl7Jh-epWq4Ib_uZoei8dsFAXpOpG3icCXi1kty4RdBu0BY30dwotdl26bZb9Jmy3lqytY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    eptddvvefhueefleeigfekjeekhfdtjedtlefhffelgffhtddthefhueelieefkefgnecu
    ffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:k9JVYxs741Rqi6yEwIt9czx8WDlnDZRLokBDnBW0z9R_7NQWfSIpZw>
    <xmx:k9JVY9cwAm8Xo_dJ3PzdkfPg-gWQNRfmNjZ-lKIqge9tMxDvmCmhYw>
    <xmx:k9JVY92R6jQk44QVNKlrqbLSFfc2ITKismsaGgKH4n3d0Ee3DK3IZA>
    <xmx:ldJVY93VbHvdwjfzrJvbJxhJu4tXwzM4xB_pKim6nqTXg3HXz0TOgQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Oct 2022 19:47:26 -0400 (EDT)
Message-ID: <625dfe41-c665-fc9c-00a3-e8e2e13c07bc@themaw.net>
Date:   Mon, 24 Oct 2022 07:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] general protection fault in _parse_integer_fixup_radix
To:     Hugh Dickins <hughd@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Hawkins Jiawei <yin31149@gmail.com>
References: <0000000000002feb6605eb71458e@google.com>
 <ce198a72-92c9-e09a-ca92-2860326c2938@I-love.SAKURA.ne.jp>
 <17a1fdc-14a0-cf3c-784f-baa939895aef@google.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <17a1fdc-14a0-cf3c-784f-baa939895aef@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/22 02:50, Hugh Dickins wrote:
> On Sun, 23 Oct 2022, Tetsuo Handa wrote:
>
>> syzbot is reporting that "vfs: parse: deal with zero length string value"
>> in linux-next.git broke tmpfs's mount option parsing, for tmpfs is expecting that
>> vfs_parse_fs_string() returning 0 implies that param.string != NULL.
>>
>> The "nr_inodes" parameter for tmpfs is interpreted as "nr_inodes=$integer", but
>> the addition of
>>
>> 	if (!v_size) {
>> 		param.string = NULL;
>> 		param.type = fs_value_is_empty;
>> 	} else {
>>
>> to vfs_parse_fs_string() and
>>
>> 	if (param->type == fs_value_is_empty)
>> 		return 0;
>>
>> to fs_param_is_string() broke expectation by tmpfs.
>>
>>    Parsing an fs string that has zero length should result in the parameter
>>    being set to NULL so that downstream processing handles it correctly.
>>
>> is wrong and
>>
>>    Parsing an fs string that has zero length should result in invalid argument
>>    error so that downstream processing does not dereference NULL param.string
>>    field.
>>
>> is correct for the "nr_inodes" parameter.
>>
>>
>>
>> How do we want to fix?
>> Should we add param.string != NULL checks into the downstream callers (like
>> Hawkins Jiawei did for https://syzkaller.appspot.com/bug?extid=a3e6acd85ded5c16a709 ) ?
>> Or should we add
>>
>> 	if (!*param.string)
>> 		param.string = NULL;
>>
>> rewriting into downstream callers which expect
>>
>>    For example, the proc mount table processing should print "(none)" in this
>>    case to preserve mount record field count, but if the value points to the
>>    NULL string this doesn't happen.
>>
>> behavior?
> I've given it no thought at all: I was hoping, as Al suggests in
> https://lore.kernel.org/lkml/Y1VwdUYGvDE4yUoI@ZenIV/
> that the breaking commit would soon be reverted, and Ian think again.

Except that I didn't see the message so I haven't given it extra thought

myself either, oops!


akpm and Theodore also had concerns about the series.


The other way to fix this is to modify the proc processing to check

for zero length strings and check for any other places that need

fixing. But that means handling it downstream for individual allocated

empty string instances rather than at the source which is what I was

hoping to avoid.


But clearly there are hard to find assumptions in code that I've missed

and this instance isn't the first case of it so may be we have to drop

the series.


I can't think of any other way to do this without requiring NULL be

handled, does anyone have any thoughts to offer?


Ian

