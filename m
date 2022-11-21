Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13630632EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiKUVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKUVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:39:55 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CBECEBB3;
        Mon, 21 Nov 2022 13:39:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 628695CC;
        Mon, 21 Nov 2022 21:39:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 628695CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669066794; bh=201//sdzNxxq4Gn7UTQ3vnOqvotm3GdM2Zb03A1wocQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FmijKIOLJpn30WQ+WUpBf22xi7fxsDyG+hNVcfwrHj+f2BUmnTarQvSPBpgaPai0t
         bA6lX5BCymXJzZ5ryLNpKoBuF+OdQeEPUF6CSzj7x1gziFz/1T7hOASvyHOpWE/bHF
         7Ntmfjvs+S5Dp2g4apCQ7g597GiY6+TKLT+zuEuVqlkLCz54gDZMwr9Ld6CTtyylxM
         BO7MB6iGCiVXz1Ndow1XO6zhxgAAB8Faya7QYZmGuXuEyXNOilRclpqeMLvwnU1n54
         JPLmSrNoPRCZwpAxXqLhfBLyPGbHoGhUVUIUVHOig2/2I7wLogdNUWonUxglJtXSAV
         EfkOxyYYAMiBQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <bilbao@vt.edu>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Carlos Bilbao <bilbao@vt.edu>
Subject: Re: [RFC] Integrate Rust code documentation into Documentation/
In-Reply-To: <20221119165921.18806-1-bilbao@vt.edu>
References: <20221119165921.18806-1-bilbao@vt.edu>
Date:   Mon, 21 Nov 2022 14:39:53 -0700
Message-ID: <87o7t07zrq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <bilbao@vt.edu> writes:

> I propose we include in 'make htmldocs' the option to integrate
> rustdoc-generated information. We could create and use
> Documentation/rust/rustdoc.rst as linking point for that HTML. This
> wouldn't be costly for the kernel itself. More importantly, the kernel
> website could host this information by default.

I'm all in favor of including that output, just haven't had the time to
try to figure out how to make it actually work.  Got a patch that
implements this behavior? :)

jon
