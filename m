Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB56993A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBPLuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBPLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361AC3;
        Thu, 16 Feb 2023 03:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F97D61F8D;
        Thu, 16 Feb 2023 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0209C433D2;
        Thu, 16 Feb 2023 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676548213;
        bh=Ax7Me4YeJAUjRFCF4QhByzkiVqUL/AVTark9B3zFjmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SugBHHy3x3waR1UP5S7RN363gBDHI+eOk+9D78nPutSyvtZRz5t9VYR4Vkue8U3Sd
         LM7psSg8nj3CZNNkd1XUEmpimr2Jrg0aGoXIWIjrZodyktp0K0MPh9ip70BVY1ATu8
         jC15qumk7Qv6EtRqUgY4d3jmBaKAtbkOMl7YGjI4=
Date:   Thu, 16 Feb 2023 12:50:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     qi feng <fengqi706@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
Message-ID: <Y+4YcnbPwWAnhrPt@kroah.com>
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
 <Y+4C6srdFygrWsLr@kroah.com>
 <CACOZ=ZUFZ7YvB+uRWthECf-xKpZkbG4XE7Lhh5gWsLFN9TY+AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOZ=ZUFZ7YvB+uRWthECf-xKpZkbG4XE7Lhh5gWsLFN9TY+AA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Thu, Feb 16, 2023 at 07:37:51PM +0800, qi feng wrote:
> Is there something wrong with this, I can correct it

Nothing wrong at all, look at the bottom of the email where I wrote:

> Greg KH <gregkh@linuxfoundation.org> 于2023年2月16日周四 18:18写道：
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



