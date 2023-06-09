Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2519B72A4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFIUok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFIUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:44:32 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E232D7C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:44:30 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686343468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o69IPIN/viI4SWUaXunctnkielbnA1XTEOpw5H6g5Qo=;
        b=WONNX+3yMGV0208hiCWY96K4M4G7bs5xxSy/gLqGycEC0ZHJQ97Yar6KK7TKe49P+wOF5J
        0dugGwFZNlka2TqVuuXF4Bf3Q9lGKb/Iuvnqp847XvuomdpJLF9GXT7zekk8Wj9KM1tQGB
        z2lRWu0FAUuas+FN0u9lz9S/f4hrpW8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/5] block: Rework bio_for_each_segment_all()
Message-ID: <ZIOPJ7y7V9WtrQTH@moria.home.lan>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605212717.2570570-1-kent.overstreet@linux.dev>
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

Jens - I've updated the branch at
https://evilpiepirate.org/git/bcachefs.git block-for-bcachefs

which now has the patches you'll want to take for now (bio iterator)
first, only changes being bio_iter_all_end() based on Ming's feedback.
