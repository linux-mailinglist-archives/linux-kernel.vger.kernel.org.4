Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36272624A87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKJTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiKJTUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:20:50 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C545A35;
        Thu, 10 Nov 2022 11:20:48 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id z192so3553650yba.0;
        Thu, 10 Nov 2022 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5bxCyKZFPEMnYesOrxO0GPZIIFmmUudJDEr+9p0CwI=;
        b=SB6+Zp37yrYl1KjihfUXIB2fnmBj5/nehOR6lap2Kdjm+IIKRwZYIhQty9NZzVRRC1
         DxWcuwrmU6MsMba24hfDpnNrl8yoEqHULg7D2445JtXimJQzf6ica9lErDKxLkm+heJE
         2CNGMb3VW7mVD2ay2uLuHckxmyNpDR16FYCLwk7ZaN93NTDs/JN9bFhIvRNwhXJ6rVMA
         RFywIK0NEXlfpYeCTJam+U5bflZGn+R338pSq5XNaRkk1Tl6lX3d8wpqJ0zRm7T7wqIl
         RtB7EOVFR7vd3hTvRw2Ee2AJgiVYu7HIebcgwQVCsfe8iiBOk1UZ3maL+h1GwVZJb5Gw
         ew0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5bxCyKZFPEMnYesOrxO0GPZIIFmmUudJDEr+9p0CwI=;
        b=ufH0cJrdqmjR0+Q03DRujfDodf604e58OMUxmXe5cxadMtGsokbtGv3K3Mi8lqDAZS
         HgBGAwXSb2NSK1DXbvi4HhlNr7UQyUkvQ6XSRFnkPMXIIJMywuoZFO/ZuAbUlrE/FrEz
         kSQiKfseESl9luAFBeO5RgFYkxH9CYQaNnSIA3JQe3oL2qaaqKTXn2DxXj4t8+sqmAjE
         lnMu6muKunPY/lGQVe8vdYr69NJXLy0gE64R4g7PGX0zbr5u3C0B+octAM7HlW0chocV
         zDGtnfRYL5fYc4K121ExJrEEb/VDO4sd10vZumaWLHi5jmjTiTajBy3dEJtsVnZ8Q8JJ
         CvVg==
X-Gm-Message-State: ACrzQf0bQzAjpXhwmO1IduklCI0rEuP1mv7HHIJ52ElKYRlv1wUMLATx
        BmC+NF3+t5jO0tiE8vwj8J6Ze5LCyfZxyOOU0sY=
X-Google-Smtp-Source: AMsMyM6ujXB3E5qr8ACm7ChQ/98dmuYWx1qvcPzOksm2hYQukBm3DXCr5HN1zEsHEYSqPgDLPnegt62/qQ7BID7N4G4=
X-Received: by 2002:a25:bc81:0:b0:6cb:8949:fdbb with SMTP id
 e1-20020a25bc81000000b006cb8949fdbbmr1288650ybk.328.1668108048105; Thu, 10
 Nov 2022 11:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-24-ojeda@kernel.org>
 <Y208lVCN3VweD5iI@Boquns-Mac-mini.local> <CANiq72kR3YZv65NYPx+H57XO7T85kioMWMZajRnk7f+ru-3x+w@mail.gmail.com>
 <Y21N+GtGsqzaPSFp@Boquns-Mac-mini.local>
In-Reply-To: <Y21N+GtGsqzaPSFp@Boquns-Mac-mini.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Nov 2022 20:20:37 +0100
Message-ID: <CANiq72mXxcLyf0EU7bcSHGMHZHNKmkxtyMEA72a4gfZeJH+z8w@mail.gmail.com>
Subject: Re: [PATCH v1 23/28] rust: std_vendor: add `dbg!` macro based on
 `std`'s one
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Niklas Mohrin <dev@niklasmohrin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 8:16 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Yeah, having some kernel contexts is better ;-)

Agreed, and being able to tweak the docs is, after all, one of the
advantages of having a custom version in-tree anyway :)

Thanks a lot!

Cheers,
Miguel
