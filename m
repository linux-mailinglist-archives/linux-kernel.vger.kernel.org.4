Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5C626958
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKLMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 07:15:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5552B1A386
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 04:15:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x2so11050270edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MONdjG0schDl4h6ZHaz0uRvYs4Ys6NIRsl4cjekglXU=;
        b=LQVLXft2/9mefrdTshjBFK7CvFYzhcZiiNJHrBpofTrDslxzqR6xJDNy66yhYyAcXQ
         T4JDL51Vvpo4I+Xf/VsgWAf+06TW5R+6sLHERLH9FX8gIJVWrGEkWyJqrY3XpGQI92S1
         k/uHyUtgx4BuwBEMEHb/ib9GuAioerSmvCJHKbURqwTM1SkTsGNsntc9KraCp9x/i/pm
         0gsBjZ8SYwOD3pZlYMFDMTWxTdBbc8669gy8VB7PxwbWpuZaon4rSv9gPrzv+ohJwJhu
         QDNtf63+kuzzNETe35VV57a4/9Mz8BvbVBNckKngSE/kxZ6jJvSUmiftiakbfDsCB+rS
         CC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MONdjG0schDl4h6ZHaz0uRvYs4Ys6NIRsl4cjekglXU=;
        b=ZukHDsrPsYGFQMwRSCUpbPF2PyBQXgIe2oKCQtF8buHRx6V0WBihUCVDQYhFwpuB56
         hR4z31GSoo4CEAnbPh2CP3uy7agkVK5DWdw2kMkbIWFE7DLoxOUBOdToMqT7Zf//YIyH
         ZKAmK+ZUgPWQ0d0nipK7HJF+tswpV6U33iNxCEA6Q5WfATiHm0nEDjpjSEORHlfkd59B
         rF4FVZpSnTD0L62Pzm6lJQnLa/ySIjvXVrdyoUYPFDmDe/fChzWiUtZ4DVXjQVCXACTR
         3wl39BgGv4PQcvcr5kdASfcJ1pD2QtbfQX1863xtpcAAemvOReIPBezVWYTZyhNI+nA1
         4Yuw==
X-Gm-Message-State: ANoB5pkzpLfzPSdRJckqXuR6v/gmJHRl7j5b27RxHVjEI+1kPGxqKvhG
        B+ZcmP2iz0gGvL8114H10vFavkr26n/ZOvF/huc2t6+Q
X-Google-Smtp-Source: AA0mqf7J52WmCh65THoIoO118jTvRkhchkFFmURXZZS/maR6gUWp5P3DFkRi1x6HE+NEn4DonVl1MtbKplclv0yXpHs=
X-Received: by 2002:a05:6402:d77:b0:459:aa70:d4fd with SMTP id
 ec55-20020a0564020d7700b00459aa70d4fdmr5015546edb.162.1668255345833; Sat, 12
 Nov 2022 04:15:45 -0800 (PST)
MIME-Version: 1.0
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
 <20221112074759.GA5111@1wt.eu> <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
 <20221112113410.GA5553@1wt.eu> <CAOM0=dbuPP1j7MYkZCxbXQKxUsjeO0QXfE_g-xapFXYSpCAgXw@mail.gmail.com>
 <20221112120109.GA5592@1wt.eu>
In-Reply-To: <20221112120109.GA5592@1wt.eu>
From:   A <amit234234234234@gmail.com>
Date:   Sat, 12 Nov 2022 17:45:34 +0530
Message-ID: <CAOM0=dbM_WSkPAEKtC7_h2eZ4RUBMrhW4Q+QodXkXkWVLna4Vw@mail.gmail.com>
Subject: Re: Setting variable NULL after freeing it.
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 5:31 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Sat, Nov 12, 2022 at 05:28:04PM +0530, A wrote:
> > I was just thinking that when this is good practice (where its usage
> > is genuine), then why is there not a kernel wide macro that would call
> > kfree(x) and then set (x) = NULL. So, this will be done automatically
> > for everyone and the developer will not have to decide whether to do
> > this or not.
>
> Very likely because developers want to decide.
>
> Willy

Yeah, may be they want to save the time the kernel will spend in doing
(x) = NULL.

Amit
