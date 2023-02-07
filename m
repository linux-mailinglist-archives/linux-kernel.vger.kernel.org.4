Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEB68DF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBGRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBGRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:48:20 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136061BC3;
        Tue,  7 Feb 2023 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675792092; bh=INTRB0N7BpdF+teyRFI0Qeti5EPCWNIgXybtVQ5JoD4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=R3TLKiuXViEFnrRw/BMf5MamY+a9PF06ZKXek4RfQiLDVRwa7BBLW0Cn4PZTV8nuc
         neG56DpseLniHODVf39JMjwsp1/jJ9qShRwGKkgGSEPPgPcGhngUoz6TVJ/kMsg35M
         /zWPep3jn6W+PZuCIbAzH9Mpsg9olJwXXG6MWVeE=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 18:48:12 +0100 (CET)
X-EA-Auth: pgENd/GktoM51Ggttl86NVq0et33TifRvHT9XZxr9rXWuSNKmcItM90kP+PYHSLlIp0ZhBF3Ofel/qNOuogJEzHICYdKt+lF
Date:   Tue, 7 Feb 2023 23:18:04 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by bitwise
 OR
Message-ID: <Y+KO1CuOdd/LCNIW@ubun2204.myguest.virtualbox.org>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
 <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
 <47e6d710-d666-5f5b-5d65-4f31afe4359d@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e6d710-d666-5f5b-5d65-4f31afe4359d@gonehiking.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:28:22AM -0700, Khalid Aziz wrote:
> On 2/7/23 05:26, James Bottomley wrote:
> > On Tue, 2023-02-07 at 16:51 +0530, Deepak R Varma wrote:
> > > When adding two bit-field mask values, an OR operation offers higher
> > > performance over an arithmetic operation. So, convert such additions
> > > to an OR based expressions. Issue identified using orplus.cocci
> > > semantic patch script.
> > 
> > No it doesn't, at least not for constants, which is the entirety of
> > this patch: the compiler can find the value at compile time, so the
> > whole lot becomes a load immediate of a single value.  Whether the
> > compiler sees OR or + is immaterial to the compile time computation.
> > Perhaps Coccinelle should be fixed not to complain about this case?
> > 
> > James
> > 
> 
> Agreed. This would be lot of code changes for no benefit.

Hi Khalid,
I understand. Please disregard/drop the patch proposal.

Regards,
deepak.

> 
> --
> Khalid


