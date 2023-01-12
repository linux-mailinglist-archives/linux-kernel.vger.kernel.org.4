Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBBD66783A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbjALOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjALOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:53:38 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FD52773;
        Thu, 12 Jan 2023 06:40:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7521932006F5;
        Thu, 12 Jan 2023 09:40:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 09:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673534421; x=1673620821; bh=Fp+f6gwmOY
        W/VUxOaVKHtgR/0ujSroQTI/JM3utiJL0=; b=UKbmcqYxJeY8aH75bezSbBNof5
        a53O9MU2/B0W8zRlOZOGyFZGBkhduRMh7AxcToFqvKUy7uMaj72phxLBoBZoJ2Ao
        6/0kUs4kLy3NCutkKzx92iaxHIgbxfENQJe8hfwxEMQxovORD7vkDNjBohtZ7L0e
        82qbt3kHtbrmYgKQQgRvLhxcjVbzH7w8HgpYV+NK/clx7L2h7TMPEE3bfcnpEp1y
        QT4gOrg+hU7IwaPGvUjBLXcif91ipTK/2R58rZdzuVSIRRAibZvBJsUy0XWXkPDZ
        Fw+ILBTuohIU+R1yuh05+Mxkmy4UHuhyyawvt5bsyJ6/Td6jSAgXc90+BnUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673534421; x=1673620821; bh=Fp+f6gwmOYW/VUxOaVKHtgR/0ujS
        roQTI/JM3utiJL0=; b=oKAjWnKmKr3hQeNAXPUXCnWAzVSSc/RNKsfCsP3ASwTd
        cPZPwd3qN4TpkGk87Ul0Et62Ewc5NQwCG8MYKFJO1w2Kvy/5qNhusf2Hp5Waytbh
        iHelp4bDSk56geZ31Nsi6VVb9L9325//+PgoXWNEoW7ZrAQUBCUZPXDv6sKTnj3B
        15Sq69kV/Q9rnc95yeCK9m5yvnFRe1bVovKXoJIFmkMDLljJPqt56f4B1d4VTinb
        xqJDdFkstl8QMsrKh5R/TCAdg0tv+hb+aH9aRn5knc3AebnA8eLx6YddIj2Wy2tz
        sW3ZV/Oj0JGd6hlURdlYkCxQvW4/a6G9JVnKiovqcA==
X-ME-Sender: <xms:0xvAY_htArAYL0d4dDDC5MjOBFp36BZq1ryknZFSHtfaKn589cWeOg>
    <xme:0xvAY8C-a9jyXPlW6ZVZDMtdMkYnVkp-RfJY0vXTx6UW9whKQxvDHEHrdag6r4b5l
    BbJACGGNMLYh_V1wHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0xvAY_EPoUNtH0TS0adH-WZktf4EZ8A5-iAhC2C7rd-pcrb-rUL09w>
    <xmx:0xvAY8S79XQRHphxwCZpfQpQImg2ix3jq54n9h8h5iWRuk-8DgYTGQ>
    <xmx:0xvAY8zORuB3i3Lbg8ILYWUmEAJcMDs8dfzTqUKMP5a3NtqQdt8w6Q>
    <xmx:1RvAY4dVwU9oawG4BlMYS2ttPz5SO6qdSnxg0Ol7XIgkgGrlIiAljA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95776B60086; Thu, 12 Jan 2023 09:40:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
In-Reply-To: <20230109180717.58855-5-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com>
Date:   Thu, 12 Jan 2023 15:40:00 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Casey Schaufler" <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, "Paul Moore" <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, "Kees Cook" <keescook@chromium.org>,
        john.johansen@canonical.com,
        "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023, at 19:07, Casey Schaufler wrote:
> +/**
> + * struct lsm_ctx - LSM context
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: context specifier and LSM specific flags
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context, a nul terminated string
> + *
> + * @ctx in a nul terminated string.
> + *	(strlen(@ctx) < @ctx_len) is always true.
> + *	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> + */
> +struct lsm_ctx {
> +	__u32		id;
> +	__u64		flags;
> +	__kernel_size_t	ctx_len;
> +	__u8		ctx[];
> +};

I think this should be changed to be the same layout on
all architectures regardless of __u64 alignment and
sizeof(__kernel_size_t) differences, to avoid the need
for compat syscalls and explicit clearing of the
internal padding.

Maybe just use __u64 fields for all three integers?

     Arnd
