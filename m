Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708F6022A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJRD2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJRD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91194A02EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71344B81BDD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5BC43141;
        Tue, 18 Oct 2022 03:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666062667;
        bh=Gip3f0QPrY6uBAqLxW8qLROPW//86SurfO8n34fVZME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAx18OLSusDZNN5TVF+6rus+S7GQ+yfYqavwZfAZ9sDPLCIEaDiMVxmcj2KJEyqLo
         MK9M60OnbZ9u9TlQ0QoY8ZXzg7r/79eKrCabyqfDefD4slycdG3da+8AL6ASZoFWMd
         Y7+y+k5VXUU/9RaNC5+evDZMQPwxmNBrfI/6zQxE=
Date:   Mon, 17 Oct 2022 20:11:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 5/8] documentation: Add recompression documentation
Message-Id: <20221017201106.c7226051be402de4ca1fb163@linux-foundation.org>
In-Reply-To: <Y04N4YkBFl2+STBB@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
        <20221009090720.1040633-6-senozhatsky@chromium.org>
        <Y04N4YkBFl2+STBB@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 11:22:25 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> D'oh, this patch should not contain any code changes, only
> documentation updates. It's the previous patch in the series
> that should contain these coding-style tweaks. Rebasing did
> not go spectacularly well here...
> 
> Andrew, what's the best way to handle this?

May as well resend the whole patchset.
