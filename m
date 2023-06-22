Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F273A9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVUuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjFVUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:50:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BB1D2133;
        Thu, 22 Jun 2023 13:50:32 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.121])
        by linux.microsoft.com (Postfix) with ESMTPSA id 79F7A21C20B1;
        Thu, 22 Jun 2023 13:50:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79F7A21C20B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687467032;
        bh=PTggkHNckUu7CgoZ5GCLKrdt98eLD2Ch+hR6UTGKCy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfT40bb4PhfdUo2AsTKUGo/NY8BzOomVqkTHztHvR99AbDIelwaFgchO7PeAx4Svt
         955PAdgMHWl6n/blDfxCKUhVb3DqBbUea4MPN/U/EGnLVCRwT155G7OEwL6GCLwf4Y
         72G4HqIdTFwtPlRW30LVzP1O0SHBI0l5hclBLs2g=
Date:   Thu, 22 Jun 2023 20:50:27 +0000
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     sunliming <sunliming@kylinos.cn>, mhiramat@kernel.org,
        kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/user_events: Add test cases when event
 is diabled
Message-ID: <ZJS0EyaneKuS9Rsh@CPC-beaub-VBQ1L.localdomain>
References: <20230621063502.154378-1-sunliming@kylinos.cn>
 <ZJSuvC9bfcTQMWvI@CPC-beaub-VBQ1L.localdomain>
 <20230622163036.1e68d25b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622163036.1e68d25b@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 04:30:36PM -0400, Steven Rostedt wrote:
> On Thu, 22 Jun 2023 20:27:40 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Wed, Jun 21, 2023 at 02:35:02PM +0800, sunliming wrote:
> > > When user_events are disabled, it's write operation should return zero.
> > > Add this test cases.
> > > 
> > > Signed-off-by: sunliming <sunliming@kylinos.cn>  
> > 
> > I don't have a problem with the chagne to the test, however, the patch
> > title has a typo in it for "disabled" that should be corrected. I've
> > ACK'd the other 2 patches, so you only need to resubmit this one with a
> > correct title.
> 
> Ah, I misunderstood when we talked earlier today. I thought the typo was in
> the text of the start selftest. That is, it was part of the patch.
> 
> For a typo in the subject, I can make that fix when I pulled it in. I just
> avoid touching content of the patch itself.
> 

Great, thanks!

> Care to ack it?
> 

Sure thing:
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

> Thanks!
> 
> -- Steve
