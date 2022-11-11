Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890062576E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKKJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiKKJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:57:46 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88844686A8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:57:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F40C55C00D7;
        Fri, 11 Nov 2022 04:57:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 11 Nov 2022 04:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668160662; x=
        1668247062; bh=b7XPwc4bj4pQJuvSbD7H9uyA+buey1LxLq7ggZ+S3dQ=; b=P
        PeCk4miRzjy7uOJpTTtcn5CH/PaA/dCTbj6Bg95I4Xgr4OjR+8hNFkEth8tuS36X
        GSY9tPZfXgwd+OoNrSIPj/FMV7cFJvvPP5joYP7DYkeAfeYkX31EPchnfjfbTU0a
        1RNndw1sN3PqZvcPpW/5GkFCUI3m9o8lcWxSyOGqwhrVQIMhRft1KoQNxsXnNd8c
        l3ImG/LfTz7OyaDw6cTodgRWLgC1bhHK7x4Hj4RwGMElbljT8aB9uLirvfKFd0AA
        ljXUdEfSXBiEsc/C0xBfCB9QKUraIyOsLf7wXdnwgEBhXTiamvjz+7C0nK5yMxVA
        ocDwgegVj7975SB8jYdsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668160662; x=
        1668247062; bh=b7XPwc4bj4pQJuvSbD7H9uyA+buey1LxLq7ggZ+S3dQ=; b=V
        O8XvIEzSKRD3P+VLEJnCwZALf2Ce/+l2ZV85fH9Qyc+fZA1QbBI43Z/Kn3CcVta3
        SODi5QVGAQgHnMenUQV94I+WH8WarAeH/9tQa0zd8EgL/x91VVc4bjpwQD8dJ9rc
        SKCyr5NknlVvZ6abbZ8kAwNOxWlOg0zEf3rgQxypOqTDqvDnGnn1DqNsMeVBRYEe
        VYaENgOeqTDA1ApQn3pKedQtPBVnEAafTDF+8naxqbejf2WQRVPs2SAhonNvibQ0
        IH/NewvZ69v92OEhSxz+cuwyyslF8spUQZlsIfgqvcGgHPQ7aADbvQ6Vdlk78yvM
        VZP0dA7RuZn5SCLeca+oQ==
X-ME-Sender: <xms:lhxuY2UGHr_zNh_QYLXdiSdr6yJVlMtBf3dIZ9X1OTP58vaJ8EAXMQ>
    <xme:lhxuYymTmRyntiAb1x4ZpnKYKUjAnPiUtIDfaxwH00K-p7RnPmD4U-LdTSU8wdO4m
    -In60vg9Mff4qNshMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lhxuY6bWxlZJQM_ah-xk5zayo_mM9oaD8SpER4Kxanwhi8R9m2ix1A>
    <xmx:lhxuY9X0bbHfEFKGlMCUv3wABgQ8tiJzW0Ls_DpFTFPuyS3tvfQ3Qg>
    <xmx:lhxuYwlhaPwWxqBJjZr7ho-ma-DULVYkZ2401-OnDN367-Od_5K-7Q>
    <xmx:lhxuY-bO3TPsKdIRISlEq4dWpkIrMJrpd33U6McLpLgSHM2jsfQgsw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02B5FB60089; Fri, 11 Nov 2022 04:57:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <cd818e0c-4c8c-421e-ae39-c7cea79eeb7e@app.fastmail.com>
In-Reply-To: <CAHJ8P3KU4NBr9ftqp1J_QWxGUjusoUZo6JjefPN-4YazD4mrUQ@mail.gmail.com>
References: <1667889638-9106-1-git-send-email-zhiguo.niu@unisoc.com>
 <202211101659.j9z9jLHv-lkp@intel.com>
 <88fce16b-5092-4246-8bbf-23f2c03224f3@app.fastmail.com>
 <CAHJ8P3+g7dr3PBZFQCD5HQLZ2b0WHe=b6Jt7ha1o7mqZJ7_-BQ@mail.gmail.com>
 <97c529f2-c5a2-4ed6-89eb-c79f020e9d0c@app.fastmail.com>
 <CAHJ8P3KU4NBr9ftqp1J_QWxGUjusoUZo6JjefPN-4YazD4mrUQ@mail.gmail.com>
Date:   Fri, 11 Nov 2022 10:57:21 +0100
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022, at 10:40, Zhiguo Niu wrote:
> Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2022=E5=B9=B411=E6=9C=8810=E6=97=
=A5=E5=91=A8=E5=9B=9B 21:45=E5=86=99=E9=81=93=EF=BC=9A
>   I thinks the gcc complier build warning :
> ----------------------------------------------------------------
>     In file included from fs/f2fs/segment.c:24:
>>> fs/f2fs/gc.h:73:1: warning: alignment 1 of 'struct victim_entry' is=20
>
>>> less than 8 [-Wpacked-not-aligned]
>
>       73 | } __packed;
>
>          | ^
>
>  ---------------------------------------------------------------
>
> It is because struct rb_node has the attribute=20
> "__attribute__((aligned(sizeof(long)", it is 8 bytes in 64bits platfor=
m.
>
> struct rb_node {
> unsigned long  __rb_parent_color;
> struct rb_node *rb_right;
> struct rb_node *rb_left;
> } __attribute__((aligned(sizeof(long))));
>
> so I just try to put __packed on union of struct victim_entry and i=20
> also keep consistent with struct rb_entry.

No, that attribute has no effect on any architecture other
than m68k, which defaults to 16-bit alignment for 32-bit
members. I'm fairly sure the alignment attribute on
rb_node is entirely unrelated to the problems you are
seeing in f2fs that come from having a structure with
stricter (4 byte or 8 byte) alignment requirements embedded
in a structure with relaxed (single-byte) alignment:

> struct rb_entry {
> struct rb_node rb_node; /* rb node located in rb-tree */
> union {
> struct {
> unsigned int ofs; /* start offset of the entry */
> unsigned int len; /* length of the entry */
> };
> unsigned long long key; /* 64-bits key */
> } __packed;
> };

This tells the compiler that the anonymous union is=20
entirely unconstrained, but the anonymous struct inside
it has the default alignment, which is the contradition
that gcc correctly warns about.

Since the only thing you need here is to lower the
alignment constraint from 8 bytes to 4 bytes, the easiest
way is to have the __packed annotation on the 'key'
member. This avoids all warnings, as long you do not
take the address of the 'key' member and pass it to
a function that expects an aligned 'u64' pointer.

     Arnd
