Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB7608AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiJVJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiJVJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADF233A0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B2C60B6B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B74C433C1;
        Sat, 22 Oct 2022 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426668;
        bh=6ptY5uf7J44ni3G95NeCYn/H8y8m/dT21iyKp4jpFRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1c3FBZ6y13cqv5ES3YZK45atU8jlF+YxWY0MWkPtqVeelRabGu8UmiVvwxk5rFFJI
         Hyf+PFHlZSYOfut/9H0k5GWdncx1A5wxR3kfBdp4CLU1YOyKfPSrx+Ubx9aTITyjg8
         k3bwB+AyQk7SOyDH/jCD5f+TW3acAeR2hdhAD55M=
Date:   Sat, 22 Oct 2022 10:11:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 2/6] staging: vt6655: refactor long lines of code in
 s_uGetRTSCTSDuration
Message-ID: <Y1OlmdhJ564Y4H05@kroah.com>
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-3-tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022070612.13009-3-tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 07:06:08AM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_uGetRTSCTSDuration

So your commit to fix a "too long of a line" has a changelog text line
that is "too long".

The irony is deep here...

thanks,

greg k-h
