Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A2A60F062
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiJ0Ggz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiJ0Ggx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17515F93A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184E96218D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC59C433D6;
        Thu, 27 Oct 2022 06:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666852611;
        bh=MaDXykNOBsnRbQk4Wd2jrRSc2YVPdFhx76PUgnX43H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5E2AOA/HVxtWehd3uWyckq/HI2+WEvX6cpH/Ep81vOAKQFPPBwomo8Bt1nulKTmt
         k5a9Lg5Y/c8or506PPYI41PBvPQr86DFZ9wrsCBdOUqz8o4HWrRyYFOyXrbR8GWJtU
         c1jrrECIoNbSk9jfYWqOq7RfhIteKblYkkM1a/EE=
Date:   Thu, 27 Oct 2022 08:37:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: vt6655: refactor code in
 s_uGetRTSCTSDuration
Message-ID: <Y1onOBNpAlIM1c80@kroah.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:01:26AM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_uGetRTSCTSDuration

Um, this is 93 characters long.

I don't see it changed from before :(

Please fix _ALL_ changelog texts...

greg k-h
