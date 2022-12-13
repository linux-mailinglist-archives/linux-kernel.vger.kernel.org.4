Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10E64AE85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLMEDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiLMEDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:03:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A1BF72;
        Mon, 12 Dec 2022 20:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2966130D;
        Tue, 13 Dec 2022 04:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1B3C433F0;
        Tue, 13 Dec 2022 04:02:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p1ZsKnET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670904173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XSkE9XEDwIeL1wCcRgHqeRshArevzsrmXKCW6tdvJw=;
        b=p1ZsKnETLbhinTN7l6f5RMsTOv0iS4qexHhb54loDYQDF9y2vnFGvjjWbO5kmb5gYXcUgY
        ZlS4PxgDpcqqIqIoe/i/OJEohqDtOulB/QDRAl8e6++2+xz48/h8sS8XGMmlv/vUokRmOM
        zPuxsa93DPyQF8zVEGNB/Wiw7GufaXw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 84d75ca8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Dec 2022 04:02:52 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3f15a6f72d0so176110647b3.1;
        Mon, 12 Dec 2022 20:02:52 -0800 (PST)
X-Gm-Message-State: ANoB5pl3n5DVWjf3AFNVY1sLx3zqKZb+uPpPWGIKc+wFrRgunhNFV1NZ
        WVHdy1o0RbxkggSP0S34+wLHPz0Deo1leqAH88k=
X-Google-Smtp-Source: AA0mqf7fcAs/ILLlOSGzhQE2i1v4eh2YESooRlTxcjlcKUC9CnxP2wYjTidXDupX4lU2Vx5AZunnVpZPAQKpKA2jeLg=
X-Received: by 2002:a81:6d86:0:b0:368:e6b8:77f1 with SMTP id
 i128-20020a816d86000000b00368e6b877f1mr27276845ywc.414.1670904172008; Mon, 12
 Dec 2022 20:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20221213143622.5b2cde33@canb.auug.org.au>
In-Reply-To: <20221213143622.5b2cde33@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 12 Dec 2022 21:02:41 -0700
X-Gmail-Original-Message-ID: <CAHmME9q91kY=_pGCbwP2RxYpMFqJK_1vyc0=q7nVQ-bi+2HY2Q@mail.gmail.com>
Message-ID: <CAHmME9q91kY=_pGCbwP2RxYpMFqJK_1vyc0=q7nVQ-bi+2HY2Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the random tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, addressed.
