Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A56641DDF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLDQWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLDQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:22:18 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03131402A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1670170904; bh=US8RV8rLRBc3Y6eYRhoB9PNQiWAAaPE+LmyqRq6Fb2U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ep5o62z/3URHOiHCgJe/2yW/NEWPSMmEGsOXTs0vw71T0MO3pTNjZ1OmfSu8avoN/
         ll+5xnoc6TuC3v57y70g06DfHjZBm6bJRQ3klXkyTWaznXMoz1t5dEIiLoRXZrbbnp
         9uJpLBpnyjfG/57D770NuSnReTsxE9BAtPogGEJn3Nx8HUH6BmO0eSRD4JeMKalM6l
         8yx0azQQ9zVJ1uQSvHfQ0AHF9Li1bG+/YCpfX1jQv0grEZj1FOZzb6VoQK3moJZHtn
         U4smZQ0jztBM0hwPF9Ec8mSHPK1ETxZ0dGbdrGf/Y07EGq7x8oPK7Q5k1RJz4QR2Yg
         +CrY3cBJpZC1g==
Received: by gentwo.de (Postfix, from userid 1001)
        id E6BCAB000B5; Sun,  4 Dec 2022 17:21:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id E3B1FB0001A;
        Sun,  4 Dec 2022 17:21:44 +0100 (CET)
Date:   Sun, 4 Dec 2022 17:21:44 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Baoquan He <bhe@redhat.com>
cc:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
        tj@kernel.org, dennis@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/1] percpu: cleanup invalid assignment to err in
 pcpu_alloc
In-Reply-To: <Y4yOMmnrT772wFSL@MiWiFi-R3L-srv>
Message-ID: <6a732c63-125e-c033-3869-87dea6c53e8f@gentwo.de>
References: <20221204031430.662169-1-mawupeng1@huawei.com> <Y4yOMmnrT772wFSL@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022, Baoquan He wrote:

> Can we change the conditional checking in fail part as below?

Yes please. This is potentially a rare condition that should get some
visibility.
