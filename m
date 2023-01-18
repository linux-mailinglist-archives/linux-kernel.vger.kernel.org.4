Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B205F6720EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjARPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjARPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:15:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E34AA6B;
        Wed, 18 Jan 2023 07:11:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC9561882;
        Wed, 18 Jan 2023 15:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B7C433EF;
        Wed, 18 Jan 2023 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674054679;
        bh=sCr67gWivJseBF45jgOCyYIoZmtdfEOxspjP2kKsFN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bg6UDs8jtgE5JPen7pxURdeNdaiDy8g9RB2czgHGlm9tLQ5UgYmmHm3DyKtwYqxqx
         YZ+aXKioVXtG1BpFYS83XKQiMwckISE4pkyAIXg8vfFjJumLsLwLBuZxa1vQnFtIJb
         kJo3wDacC3/cq1EUcaaQYEehBvne/ZiUD4+X+jBteqgnadYJQ4LSqqlPiGA9T/1MLb
         XhfextH7IoYJ5ovfb5xV4f5hmZUIkDcdf0zNWNb2y2ZfmkjqL6zzHvswYsLzMCi/vr
         DftT+0cOmxbtprdjejXNTBcYzjpobxVuCGDo40w0GestkCU88OqT6RGjOijbElqfTK
         Nsy1oR68xhTOA==
Date:   Wed, 18 Jan 2023 15:11:14 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, avid.rheinsberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: Provide new max_buffer_size attribute to
 over-ride the default
Message-ID: <Y8gMEn+wivZRhIsd@google.com>
References: <20230113150557.1308176-1-lee@kernel.org>
 <nycvar.YFH.7.76.2301181002550.1734@cbobk.fhfr.pm>
 <Y8fTd0VJXqKkPIuo@google.com>
 <nycvar.YFH.7.76.2301181554370.1734@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2301181554370.1734@cbobk.fhfr.pm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Jiri Kosina wrote:

> On Wed, 18 Jan 2023, Lee Jones wrote:
> 
> > > > Presently, when a report is processed, its size is compared solely 
> > > > against the value specified by user-space.  
> > > 
> > > While I am generally fine with the idea, I don't understand this sentence. 
> > > What exactly do you mean by 'specified by user-space'? It's defined as a 
> > > compile-time constant.
> > > 
> > > > If the received report ends up being smaller than this, the
> > > > remainder of the buffer is zeroed. 
> > 
> > Apologies for any ambiguity.
> > 
> > "its size" == "compile-time constant"
> > 
> > Would "its maximum size" read better?
> 
> I think that the confusion comes from the fact that the changelog is 
> written solely with the UHID usercase on mind ... ? (which is dealt with 
> in the independent followup patch).

Quite possibly, yes.  Since this is the way the bug was reported to me
and how I presently view it.  However, I suppose reports do not always
originate from user-space.  Good point.

How would you like me to move forward?  Would you like me to re-write
the commit log to be more generic?

-- 
Lee Jones [李琼斯]
