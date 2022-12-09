Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24A648791
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiLIRRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLIRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:16:52 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F843867
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:16:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 96BA232002E2;
        Fri,  9 Dec 2022 12:16:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670606208; x=1670692608; bh=yn1ZIx4lgv
        SNSxmiMuQyPB+UaVdlOREBNJWA8RKV91E=; b=PhmZXUtBqChjqpZHQiVnMBo3WR
        CScBwG3IAVPZPBKyLX7CwZrZ+5Ynn3ezGwdVo/UXvlRZA5mg9+lOdo9bpxIy7Dk1
        A/coid9sP6cFADl+WGUIiIGmuGlFXRgnprqTrVph3/DSkTV0cIJXoDNgX5scZlUY
        f5cK7TVP9hf8Iv/VFxjOqRWJVxzZwzz3www2n12zlXiXgkn9uh5eGzulp0lwSOP7
        kIMaqdrHifQhrQArheel7oypQZN6kQM+JQWJl13dgYixT8kWj2AkXiD6KfxRYU/n
        mYkFR8mIvPpiaVSolv/ikl2pZIs0Vl+wke0beUiYz0UZpBq5yntp7T8uPiuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670606208; x=1670692608; bh=yn1ZIx4lgvSNSxmiMuQyPB+UaVdl
        OREBNJWA8RKV91E=; b=dz92Boo7CRhsgxRAnilT3D1Typh2ncSNJ+ciZnBjpd7V
        YR+F14MP1xxid85C/MZ5ehN3ocpkAr+Af8iqGWY3bhMFmPpN3z8A0dj+91jk3xCR
        UUz/4irItW1oVXh3grWgHIXjdBLbFQl0kdmz0ppqCfgfv3bgVXnZbx1nAVzio+S3
        FzwzRU6W4nu3J6mHXQqL+s+0nptGF3Djq2lFh0lmlLWlNbgAA0u2Aed08EcRAlpm
        Zxh6QlsZE30gg3STOCjv/DnfYlYrg4ERCyiDl9DFrzxfaE6xQKuKWfaBQ53OAjw/
        U03ROeYcCES2qBk3qzlhVNkfLZwhNSA9CLq1eYODBA==
X-ME-Sender: <xms:f22TY_1f_Lsjf9v-HNEYBqsnoyQtUZCnigwo1yGBeFc33yGUipUI1w>
    <xme:f22TY-FI5POzw_CaNXIePSWIPhehhjas8SBTzNbLpauwy2LMwyZDrYXMxuAfezEOK
    NzEVVzcd7iDpzZPDcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f22TY_6FeTZnYCgR-mj_LPlC4JFribOgyYkZi2Ka8nXMdYwXwWah0w>
    <xmx:f22TY02tK29x4B5BnS6Qfxy2SBynQ4LK0RtGsDzUk9UrJ6zqEyInXQ>
    <xmx:f22TYyG8i1jNWfw2KlEn4XVWcxe0cL3f4GOigETpHtmKmSDJ5cmjmg>
    <xmx:gG2TYwbqrfZ8hpiONrvI0XmM-KLuyzRWD6HG2SyiaArgVcrLTPdroQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D58F6B60086; Fri,  9 Dec 2022 12:16:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b0c38501-440f-42a3-ae0f-dd95527b0e56@app.fastmail.com>
In-Reply-To: <20221209154843.4162814-1-andrzej.hajda@intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
Date:   Fri, 09 Dec 2022 18:16:25 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrzej Hajda" <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Andi Shyti" <andi.shyti@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/5] linux/minmax.h: add non-atomic version of xchg
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022, at 16:48, Andrzej Hajda wrote:
> The pattern of setting variable with new value and returning old
> one is very common in kernel. Usually atomicity of the operation
> is not required, so xchg seems to be suboptimal and confusing in
> such cases. Since name xchg is already in use and __xchg is used
> in architecture code, proposition is to name the macro exchange.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

While I generally don't like type invariant calling conventions
of xchg() and cmpxchg(), having a new function that has a similar
name without being able to tell which one is which from the
name seems more confusing.

Since __xchg() is only used on 11 architectures as an internal
name for the backing of arch_xchg() or arch_xchg_relaxed(),
maybe we can instead rename those to __arch_xchg() and use the
__xchg() name for the new non-atomic version?

> +/**
> + * exchange - set variable pointed by @ptr to @val, return old value
> + * @ptr: pointer to affected variable
> + * @val: value to be written
> + *
> + * This is non-atomic variant of xchg.
> + */
> +#define exchange(ptr, val) ({		\
> +	typeof(ptr) __ptr = ptr;	\
> +	typeof(*__ptr) __t = *__ptr;	\

I think you can better express this using __auto_type than typeof(),
it is now provided by all supported compilers now.

     Arnd
