Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88849627A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKNKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKNKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:18:15 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFDADF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:18:14 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5E8CD3200927;
        Mon, 14 Nov 2022 05:18:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 05:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668421090; x=
        1668507490; bh=Sqoo4IjMdLl+gwYK44DprelnuA9DnGWY/ANBVWRBeWM=; b=O
        4HviMU7BF8TBeb9tfyMcLULD0aVhJ7koWP772po3dNCAycEcSgGfVlruglHjEzDa
        4WGTa404Jt7Cxeg0saCJ1u0O2rWYzJqekU9mj8aObr6JsrWU2vONPI56yoXGxb0p
        r7wWU7HdyneKkwPXG8CrHJMtDs7qpx977S6ZzL3p2PUgTrTRn4qemzIxZY1l3ZSV
        v+AtV8Ekj7YQ//H0PO1bmZyeou4LGa5yWTbaA410DudlqpVTcfgGFi3kxgl0NAkL
        o5T6iqOIH96GwIwZb9M3q4SDa9cyfAD9Yx6OvHT5ufCK7xKSwEyYf0+syzpPPjCc
        H/LV0jLMI/7GXuuuyMEcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668421090; x=
        1668507490; bh=Sqoo4IjMdLl+gwYK44DprelnuA9DnGWY/ANBVWRBeWM=; b=F
        qScHq0ujafwzGkr779E18cB59whIxm5LcmWTz6Q2fBThdEuUkGZnIfQvqPRbv7gY
        14UuBRHofadY1DLFaC76caHTIEGpgQQwqzygWMLy5DNzY1xPLjcoE9HwH8UdtPu3
        UFovcZn1NVfWBNqAhJcQUth8oTxMFgCerTDWyBYIabyBDvpw8kxdMO1i2SXqyrtb
        AmHV2LuvOmPZOKH60wSK33+O1WBSiGmtNkXCFoW3H1iLyha+af4dfte0jGbvFmrd
        3Wr1nHazxxF+ZOdnQ4gvumABx+y6QhIAI5Jvh2bkOXQz3N317azoN/OBN3o4qcSv
        bBEiUBgD4Rc8WDTCQFjMA==
X-ME-Sender: <xms:4hVyY0j_bIq4eU9mHK9KJ86oEPuq_wCdANSEojuo8IYqv6IY6u23_w>
    <xme:4hVyY9B9GexXuEo3cH1PA2fc_vWT3qxoPubyfR9o4uvtO2YaAFAhejRtJ-Gv4nyIY
    a2RsSjOeNAWsfZQ1Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4hVyY8HJA8F9bhpB-rNfcIBLSTniCbrHtzzdrqwKohf6-Hl5sjJ_Kg>
    <xmx:4hVyY1S5rzYR7A3utjDTX-qJEH4kDoLCjq9jiSRbeaJ2YMkHGot5LA>
    <xmx:4hVyYxwlBxdrRto32c7Yf454A2ECiH6t4Tp65kLPGhq6H6l7iIKGjg>
    <xmx:4hVyY4nGuFfQ0rBtdF6FbD1-uEKuEpHfaOHMjPZ3CxiEH-dGbP4U_A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28ACFB60086; Mon, 14 Nov 2022 05:18:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <d6cf3090-ac0c-4627-b3cb-268fd213056f@app.fastmail.com>
In-Reply-To: <CAHJ8P3JHVu=Qy0ft9Sorq2Zxvu7whFV72OU+NVMhvK8SK6+6MA@mail.gmail.com>
References: <1667889638-9106-1-git-send-email-zhiguo.niu@unisoc.com>
 <202211101659.j9z9jLHv-lkp@intel.com>
 <88fce16b-5092-4246-8bbf-23f2c03224f3@app.fastmail.com>
 <CAHJ8P3+g7dr3PBZFQCD5HQLZ2b0WHe=b6Jt7ha1o7mqZJ7_-BQ@mail.gmail.com>
 <97c529f2-c5a2-4ed6-89eb-c79f020e9d0c@app.fastmail.com>
 <CAHJ8P3KU4NBr9ftqp1J_QWxGUjusoUZo6JjefPN-4YazD4mrUQ@mail.gmail.com>
 <cd818e0c-4c8c-421e-ae39-c7cea79eeb7e@app.fastmail.com>
 <CAHJ8P3JHVu=Qy0ft9Sorq2Zxvu7whFV72OU+NVMhvK8SK6+6MA@mail.gmail.com>
Date:   Mon, 14 Nov 2022 11:17:48 +0100
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022, at 10:23, Zhiguo Niu wrote:
> Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2022=E5=B9=B411=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=94 17:57=E5=86=99=E9=81=93=EF=BC=9A

> so I just modify struct victim_entry as your suggestion:
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 19b956c2d697..e2f25b8fd865 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -56,16 +56,16 @@ struct gc_inode_list {
>  };
>=20
>  struct victim_info {
> - unsigned long long mtime; /* mtime of section */
> - unsigned int segno; /* section No. */
> + unsigned long long mtime __packed; /* mtime of section */
> + unsigned int segno; /* section No. */
>  };
>=20
>  struct victim_entry {
>   struct rb_node rb_node; /* rb node located in rb-tree */
>   union {
>   struct {
> - unsigned long long mtime; /* mtime of section */
> - unsigned int segno; /* segment No. */
> + unsigned long long mtime __packed; /* mtime of section */
> + unsigned int segno; /* segment No. */
>   };
>   struct victim_info vi; /* victim info */
>   };

Right, this should work. I'm still unsure where you need
a union inside of victim_entry rather than just having the
'victim_info' portion in there by itself, but that is not
a matter of correctness.

> There is no problem with functional verification in both 64bit and=20
> 32bit platforms,=20
> sorry I don't have the environment to verify is  build warnig reported=20
> by the kernel test robot still there.

I had a bit trouble reproducing this as well. It looks like this
only happens when -Wunaligned-access is enabled for a config, but
that requires two things:

- building with CC=3Dclang for a target architecture that does
  not support unaligned access natively, such as ARMv5.
  ARMv7 is interesting because it disables the warning, though
  it only supports unaligned load/store on 32-bit and 16-bit
  words but not 64-bit words using the ldrd/strd instructions.

- Even on architectures with no unaligned load/store, the
  warning is disabled by default unless you use "make W=3D1" to
  enable extra warnings.

Alternatively, you can enable the warning manually by passing
"CFLAGS_MODULE=3D-Wunaligned-access" to make, which should trigger
the warning on any 32-bit architecture.

      Arnd
