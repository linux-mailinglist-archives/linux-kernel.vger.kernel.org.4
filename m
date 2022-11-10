Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2648262437D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiKJNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKJNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:46:07 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0F3FBA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:46:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A8975C01C7;
        Thu, 10 Nov 2022 08:45:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 10 Nov 2022 08:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668087959; x=
        1668174359; bh=19++3Vi/MimtPuuPOkXfPImCVesnLn5qoCUVppmD3sc=; b=K
        pt6mtxrmqu8dYU5O8qXui74BmqL5Y+eS9OXO8wQObK73ULI8UV7CjAmOZ+8e1L5P
        ZXBemJgycQNpr9Ynu0Nm1iU5Mapcij/Rz9uVJ404m2G61yxeo5Fzmw6gXAxRhChw
        KtMxZoeSTFdNmPivpkV4h9fUtqRzA0nWDwz91W2V9bd3u/LYXdlxjQLZwlYVTXOV
        nB9NW+DRv4GX4gNVws2w3rwojBl2tU1jV3lEMLZ44tPBIyW7l33ZQwcTu7VlHpi3
        nBmrWBfN7kzOzZLBs9wWw5Okegoe/QqPQzLujhmw3gkiIX2hG5lUFppG0Aib5mRt
        IgsweDBxzTv6HKC2wL1TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668087959; x=
        1668174359; bh=19++3Vi/MimtPuuPOkXfPImCVesnLn5qoCUVppmD3sc=; b=G
        VyxyVl8Gvb030ftFEXyVojDyEl99IDEwlHrekl6WoJhWjqPcvf0L7XS+5BdSWQoh
        KIJDHLe3LwFXXBnGxHecUpzxnkQHTgJSeMLWG+r5DEtlZh+nqD/wZYUlzZTA1K2a
        kmPirOQ50Y1ERc9YJgBwqiArTSr1OSakFTZahTmSJtVJ7OZXX35Dsw6T5bcuImvN
        0PenvxUS/EPOKngxhQfzXx0EdI2DkurY4wQ/efmdVqOhsEdtXahevi8J5leuTYjb
        43acr8ev7Vzc+GfW6pR62YhhEhwgg/cpgrDUmh+MOyo7sZGM30bH2ZD7HdLAbqr1
        pe+D17FZkNv8hcikHEQQA==
X-ME-Sender: <xms:lgBtY4mwwLcZ13VTE3P0unfzN6z67qCnD59miR8M_6BYaJJ0b4EWNA>
    <xme:lgBtY31c6C-dDgA3YTwDfOQjuyLq0CsmKo9E4YU-Bh2dz3YXhP1jCFk3yBJfuveA3
    aBKGbffK-QXbPyUe8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lgBtY2oHpMlhxgops79KmpbdN3ul2qupJ9ljsgXlrf3j0281bXQqcQ>
    <xmx:lgBtY0nQG0CK1oUa7iVv5FQhv0lq5r0c2gD1l9EZ1yJlzVlJ6B6QbQ>
    <xmx:lgBtY20JidY8m5YltRT2hWb2hvxqe-RTW9SFNgl27Mc3tMqiMb4LJw>
    <xmx:lwBtYwpKzzI9UilXf38wfcQgPaHaoouKcHdxeQWUBzYqedcDvSb4_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 52E30B60086; Thu, 10 Nov 2022 08:45:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <97c529f2-c5a2-4ed6-89eb-c79f020e9d0c@app.fastmail.com>
In-Reply-To: <CAHJ8P3+g7dr3PBZFQCD5HQLZ2b0WHe=b6Jt7ha1o7mqZJ7_-BQ@mail.gmail.com>
References: <1667889638-9106-1-git-send-email-zhiguo.niu@unisoc.com>
 <202211101659.j9z9jLHv-lkp@intel.com>
 <88fce16b-5092-4246-8bbf-23f2c03224f3@app.fastmail.com>
 <CAHJ8P3+g7dr3PBZFQCD5HQLZ2b0WHe=b6Jt7ha1o7mqZJ7_-BQ@mail.gmail.com>
Date:   Thu, 10 Nov 2022 14:45:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhiguo Niu" <niuzhiguo84@gmail.com>
Cc:     "kernel test robot" <lkp@intel.com>,
        "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2] f2fs: fix atgc bug on issue in 32bits platform
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022, at 11:20, Zhiguo Niu wrote:
> Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2022=E5=B9=B411=E6=9C=8810=E6=97=
=A5=E5=91=A8=E5=9B=9B 17:07=E5=86=99=E9=81=93=EF=BC=9A
>> On Thu, Nov 10, 2022, at 09:33, kernel test robot wrote:
>> > base:  =20
>> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git=20
>> > dev-test
>> > patch link:   =20
>> > https://lore.kernel.org/r/1667889638-9106-1-git-send-email-zhiguo.n=
iu%40unisoc.com
>> > patch subject: [PATCH V2] f2fs: fix atgc bug on issue in 32bits pla=
tform
>> > All warnings (new ones prefixed by >>):
>> >
>> >    In file included from fs/f2fs/gc.c:22:
>> >>> fs/f2fs/gc.h:65:2: warning: field  within 'struct victim_entry' i=
s less aligned than 'union victim_entry::(anonymous at fs/f2fs/gc.h:65:2=
)' and is usually due to 'struct victim_entry' being packed, which can l=
ead to unaligned accesses [-Wunaligned-access]
>> >            union {
>>=20
>> It looks like the problem is the extra unqualified __packed annotation
>> inside of 'struct rb_entry'.=20
> yes, I agree, but this modification is about the following commit:
> f2fs: fix memory alignment to support 32bit=20
> (48046cb55d208eae67259887b29b3097bcf44caf=EF=BC=89

Ah, I see. So in this case, the line

        en =3D (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,

requires the second field of 'struct extent_node' to be
in the same place as the corresponding field of 'struct rb_entry'.

This seems harmless then, though I would have put the __packed
annotation on the 'key' member instead of the union to
better document what is going on. Ideally the casts between
structures should not be used at all, but I don't know if
changing f2fs for this would involve a major rewrite of that
code.

> so I think is the following modifiction more better?=20
>
> @@ -68,7 +68,7 @@ struct victim_entry {
>
>                         unsigned int segno;         /* segment No. */
>
>                 };
>
>                 struct victim_info vi;       /* victim info */
>
> -       };
>
> +      } __packed;

So here is the construct with

        ve =3D (struct victim_entry *)re;

that relies on vi->mtime to overlay re->key, right?

I'm not sure why there is a union in victim_entry, it would
be a little easier without that. Clearly both sides
of the union need the same alignment constraints, so
you could annotate the two 'mtime' members as __packed,
which gives the anonymous struct and the struct victim_info
32-bit alignment and avoids the warning. Having the=20
__packed at the end of the structure or union would
result in only single-byte alignment for structure
and not solve the problem that the compiler warns about.

The other alternative is to revert rb_entry back to
having 64-bit alignment on the key, but then also mark
extent_node as requiring the same alignment on the
'extent_info' member for consistency:

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -580,11 +580,11 @@ struct rb_entry {
                        unsigned int len;       /* length of the entry */
                };
                unsigned long long key;         /* 64-bits key */
-       } __packed;
+       };
 };
=20
 struct extent_info {
-       unsigned int fofs;              /* start offset in a file */
+       unsigned int fofs __aligned(8); /* start offset in a file */
        unsigned int len;               /* length of the extent */
        u32 blk;                        /* start block address of the ex=
tent */
 #ifdef CONFIG_F2FS_FS_COMPRESSION

      Arnd
