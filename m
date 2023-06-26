Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8D73EC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFZUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjFZUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:53:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA7AA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:53:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687812805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Su68VIu+dg/n5c1KBGJpzO46FLlcIaMW5gQxLAU91pk=;
        b=WB9IkQadhnFGM9Raa6b3gcXSnt6H131s73t45t+2RpYUxxkxeLiPXkbw2WinGPk1aVqINZ
        c8LKvHLSzLJiu7ql1W0YXkjSVJ0+VMr7k5OqIHy/dBU6v1fILy6xsWdywz/6udi4SG2R+p
        6lHLqUHmy5QkG2uno0BGKIBOi1UdXVJX7sqT9DHWhxbXrQHKVd8mEP4Qbrs9UOaRh1+Uw2
        +KQfOknX5pOmFw1Ath3PEC1AKdftDpcj7SmK5HKZ0yoVAoaEpXh/lzDchUAZ0gq73BsZq7
        XLF8wjscefS6so9QIg0/CJoFmrZn+9MZCOjv6ccKbfglPhIT4ieCA4wNOrOJQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687812805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Su68VIu+dg/n5c1KBGJpzO46FLlcIaMW5gQxLAU91pk=;
        b=JCf9HO+noemHUtdmNE8L+dNs4Zsu2tTQtKeWY6imVzJRfS95JsotbINXH8UBM2WS6B0JWr
        BNPuwBNhvhhBYpBg==
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: ntp: Remove unnecessary =?utf-8?B?4oCYLUVOT0RF?=
 =?utf-8?B?VuKAmQ==?= values from err
In-Reply-To: <20230627182540.5243-1-zeming@nfschina.com>
References: <20230627182540.5243-1-zeming@nfschina.com>
Date:   Mon, 26 Jun 2023 22:53:24 +0200
Message-ID: <875y7a54jf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28 2023 at 02:25, Li zeming wrote:
> err is assigned first, so it does not need to initialize the
> assignment.

I don't know how you or the broken tool you rely upon came to that
conclusion.

There is clearly an error exit path which proves you wrong.

Please look at your changes and compile them before posting. There are
existing tools which do a better job than that.

Thanks,

        tglx
