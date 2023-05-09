Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524AA6FCCA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjEIRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:24:19 -0400
Received: from out-58.mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F32D46
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:24:18 -0700 (PDT)
Date:   Tue, 9 May 2023 13:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683653057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7hnasKG1blcL4tI3zd8y3iDMiHcxwqxHNL+ouXrPko=;
        b=JrBoQOW+ah/tspvHkY69W/IE7B20fHP0tN4ICL8eyH6dmA26A4nJUFIB17X2pNGh/03uoo
        EJp1RhRgNNmjGv4LVZ7PCSV7EA2Xj2ZYY0y3y4Xgnxyq6IDFUrAxq0GuXJFKOsp93G0SdH
        +XihR3r2l2k4zXHZvsUHivXdPtuFhq4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 01/32] Compiler Attributes: add __flatten
Message-ID: <ZFqBvs1+yZ8aYRIW@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-2-kent.overstreet@linux.dev>
 <CANiq72mLmAG1Vus5-r4ynQciyypZbO8ueva2jbiEvaOAQTTzdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mLmAG1Vus5-r4ynQciyypZbO8ueva2jbiEvaOAQTTzdQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 07:04:43PM +0200, Miguel Ojeda wrote:
> On Tue, May 9, 2023 at 6:57 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > This makes __attribute__((flatten)) available, which is used by
> > bcachefs.
> 
> We already have it in mainline, so I think it is one less patch you
> need to care about! :)
> 
> Cheers,
> Miguel

Wonderful :)

Cheers,
Kent
