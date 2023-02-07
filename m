Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7568DF56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjBGRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjBGRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:51:14 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719AB3EC48;
        Tue,  7 Feb 2023 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675792252; bh=2kq7wE5dZEcF0QAw5fmtHZR9O+wvZz27VzGJYUX5BWg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=BnI4S7hH8FPazI7HncPG1ta7KAmKLxthGhCz/t4YnhToSchNL/+8D8k7QXEFOk9Qs
         v/Xn4UqK/bX7obKzm8UYXaURZUZFSwlA19iR6jzUZpMoXNwlxpncLfi2YWymG1kTD0
         GTFzafDv4nZHj/464r2Z66i1NfkGqJvtaLF3V14E=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 18:50:51 +0100 (CET)
X-EA-Auth: XemuvO6/3Sd7GzNm1LHpxYRhRlsW8waV3eCdXjU5LCIrypPi+3MBE9S9Lxl1GNa+Uwg9F06gTVmo63o0ZZ4dYNE4MBHtz+LN
Date:   Tue, 7 Feb 2023 23:20:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Oliver Neukum <oliver@neukum.org>
Cc:     Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] scsi: dc395x: Replace arithmetic addition by bitwise OR
Message-ID: <Y+KPd4JSGR9Eyc7d@ubun2204.myguest.virtualbox.org>
References: <Y+IQoG3aYdTfMStu@ubun2204.myguest.virtualbox.org>
 <02269e84-5ca8-f150-b225-c4d8898624ec@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02269e84-5ca8-f150-b225-c4d8898624ec@neukum.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:25:09PM +0100, Oliver Neukum wrote:
> 
> 
> On 07.02.23 09:49, Deepak R Varma wrote:
> > When adding two bit-field mask values, an OR operation offers higher
> > performance over an arithmetic operation.
> 
> Hi,
> 
> I am sorry, but this change log makes no sense. These are constants.
> The compiler turns that into one value in any case.

Hello Oliver,
Yes, I received a feedback for another similar patch. Please disregard my patch
proposal.

> If you do a clean up, say so.
I did not understand this comment. Are you suggesting another opportunity that I
can take up? Could you share some details please?

Thank you.
deepak

> 
> 	Regards
> 		Oliver
> 


