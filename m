Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF365BFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjACM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbjACM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:26:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FCA1AD;
        Tue,  3 Jan 2023 04:26:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1523611B5;
        Tue,  3 Jan 2023 12:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EABEC433D2;
        Tue,  3 Jan 2023 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672748770;
        bh=bmxIHRqgWvKDdr1qYHBhef4wxIcwA+BuKZF9xJgM/4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdYg0VrWxzScm3JYYPUIpgNVGAHObvp4MumhtUcV05p8R33ATg5DIkxxM6zPM5osf
         bg6MFP3/JGzs5rYESwi8VNaO+0Jqw43+4gV77LQQZTnOdmdowOfvjZAbGqx0FJ0mLD
         ES8fnAZ2yba1TdLeTanwa9Ww2zhD8EMAzB3e6yIGWz+pEYuiAkPxiD5iQuyw6y3IjC
         AhZ9Lr8O0EY75vUQ/QMHe+mw/TJksgPxuiA1L1xuEo+PXtW34iIIw5UFHwL8gEljZ+
         F8Iz8wg5K+tz1CXPrhplHZiY6qRgHaOPUswIuudRgAshrCxSNm1GnYF9/7tmWdU9bE
         /DMTpO4xsNBvA==
Date:   Tue, 3 Jan 2023 12:26:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     jstrauss <jstrauss@mailbox.org>
Cc:     conor@kernel.org, christophe.jaillet@wanadoo.fr,
        jansimon.moeller@gmx.de, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <Y7Qe3Rx+9jzdK1g8@google.com>
References: <20221227223131.um6muahhxbom7crg@libretux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227223131.um6muahhxbom7crg@libretux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022, jstrauss wrote:

> Hi Conor,
> 
> Thanks for the insight, I suspected it was some silent Proton issue. I
> have switched to Mailbox.org, so all of my future emails and patches
> will originate from this address.

Thanks.

Although when replying to this message, I get:

  Reply to Y6slQLto568WfmfZ@spud? ([yes]/no/?):

No idea what that is either.

Also, you will have to resubmit your patch please.

-- 
Lee Jones [李琼斯]
