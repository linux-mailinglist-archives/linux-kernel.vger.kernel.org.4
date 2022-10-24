Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B0609767
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJXAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJXAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:07:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53704604B4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:07:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EBB4C32004E7;
        Sun, 23 Oct 2022 20:06:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 23 Oct 2022 20:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666570019; x=
        1666656419; bh=ZBXKiM1nTxIPIkdsp9XBL0jYPGGjwxJL9lSz+ktQ7pc=; b=M
        usun7jJR3MlJW+PhUWSHuUS7N3fXwAd9UEfbZmDblTeYNkPAwqcO+Q1Q0UifvvnP
        h/MnlukroYzh7VlMoZeOKkpyq+kWiizKVg2tCePM/nrwSAeMDoC3E/2TJfjg0adu
        wftRNiNcA8H9dlpz+4hU/5W/7JdNUW8xCok0kCm3YPkzqLEQl2wbBKCNgC47qCsw
        hPkN5xQRuuVVfobT4BU4r6OiTTZKEFcFA2wB+HOp+LBfQlgTJ+Ln3BIv5t5ffISN
        i77TuYn9nrEAxInxGw01/zXc9UFfLGqu/GDy1LqKbHYnFuk8ILArgHNOERm9MBEf
        fp8w+kCwNiZqSM4I0P8Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666570019; x=
        1666656419; bh=ZBXKiM1nTxIPIkdsp9XBL0jYPGGjwxJL9lSz+ktQ7pc=; b=o
        /yrG3t8qyYFyjJIn6FjGWYkr7w8Oj/TLskyD/tSXaHUuKKAHq1B4NOPUQRx6fNtL
        IKtyn5redt25pHOhooyaaQUC5KjAp+240eF4ma4r7Bd7ZVH0K/KzjB4firMpES4x
        WiuP9vOg6R6tdaqBPQBt1isxBVqjDBJlCMpeIk4LDaCBHbbZ2lmKdp5gcDWYa4Dg
        Gk2jiuOmBI9WVRGWgIRm+vz3uY+0dn9/xUPS9pHY1KAku/v2wU4Tl8IZwdlDd/g/
        SxQDMAW+Cr3xBddpFKze+AJmqWXcJdAGesLVrvlzuAvmfK/TULr81tqVwlWQWti9
        BH248ph+JYofBxHiQdoBQ==
X-ME-Sender: <xms:ItdVY3AlrKxyZjbyYR7S1Lo_S4tqU7Gcclrq08uFxcM5s8zMsX-uLA>
    <xme:ItdVY9isJBpsSpAvvFKHw7jpKh0tqy8QZioaW0N9pxB_WQv3SLIHy_rfviwycenj_
    dO32dG5EfCV>
X-ME-Received: <xmr:ItdVYykAaLOe3gnUM6r3cyLuXyHlm5aCGNftC84954oSHcIb77p8aSRwkKt5uG264Jc4j04oxBpNPLN3-cJ1v-GwfqfAzHOkDrwSHpT2k72pDWhWnig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:ItdVY5xTHMykQtyD9SxkD9KbvZAEXFm_C731OIkWQ-pe3sqOpl7jJQ>
    <xmx:ItdVY8SFQfNjudos9ajcCTMfHGGGibe6-lkU0OxVJ3IH87tocxRKRA>
    <xmx:ItdVY8aoqjp1WBXZJP2OiCpddLmTfSSVKaskUe7qoQJfez9sCB1mCg>
    <xmx:I9dVYwZ59DLxm1dGIOoO8Ci8VFA7hGCUsu904NJX6JDjuQFrV-56tA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Oct 2022 20:06:53 -0400 (EDT)
Message-ID: <55fad458-e2ef-3e5f-e1fa-b389167858f4@themaw.net>
Date:   Mon, 24 Oct 2022 08:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] general protection fault in _parse_integer_fixup_radix
Content-Language: en-US
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
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <17a1fdc-14a0-cf3c-784f-baa939895aef@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

It's not quite as simple at that.


Not allowing a zero length string will break cases where mount "source"

can be empty.


Maybe parsing of "source" would be better handled separately, rather than

with options handling code, it is slightly different ... mmm ... I'll check

the reported cases ...


Ian

