Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548596CB8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjC1H4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC1H4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975E30DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 221D1B81B8C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C409C433D2;
        Tue, 28 Mar 2023 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679990198;
        bh=yE/jM7tV7zVRxcad76jIIa1CSUYEmwjIwePWoHBA7Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5XjxfhMeSbd86cIBPTzjIPdXXWfTZhxvJnH7g4kBCy0BWmTrm7srLZUBMxWJzUFJ
         UCILVj/LN5EVL5n+SDh/Si62RS4yjr4J8qEdSwA947Ol/0c0yDbchZ1gU0U9lbboOT
         +/q4XksbjshXvg8DV5caK+mIsCZDALD4D8Mtk+Zc=
Date:   Tue, 28 Mar 2023 09:56:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Watson <ozzloy@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: move open curly to first line of if
Message-ID: <ZCKds6_2QYrZgMXh@kroah.com>
References: <ZCKYhfonZN36ZHjG@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCKYhfonZN36ZHjG@trent-reznor>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:34:29AM -0700, Daniel Watson wrote:
> Checkpatch flagged this as a fixable style error.

What exactly is "this"?

Take a look at the kernel documentation, specifically the file,
Documentation/process/submitting-patches.rst in the section entitled,
"The canonical patch format", for how to write a good subject line, and
changelog text.

Most of the time, that's the hardest part of writing a patch.

Fix that up and send a v2 please (after reading in that same file for
how to properly document that this is a version 2...)

thanks,

greg k-h
