Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E2741738
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF1RcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF1RcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:32:09 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C71715;
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=4mtcRlXWQpbbslXjCfhS0B8/3iHNiw5vVznGMLX6XwQ=; b=hN89nE4eelVc4iK+8FPnE7PZBr
        RF4dDkftNlYx1W/yDLUC661l1MUszbN91MrC25V6MePXXjZxbb1zMAZbg7yYAP07MnLn3/Iwrelua
        tcX5YGVUWJ9eBW86grHHxwSkKh8suyGLVEFLgbFLcfb623nskQm0U8l8lNuLLkG4YPRfSyFEqArt5
        c7knLC1K310NXbKBDnNRDN4wryygsQ7ARZhqlFbl5yOkG/6q3DtC411EzOni4EW5QTIRZnsUgSzx6
        i1oZWGj7d/+ZfNdtIanqrfvNFvP8bbePZrKiFc3ZKpDKjUT2QQMbK7pdVliG1orAwZS6lcBvh2Ujt
        SalUM0ng==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qEZ1C-00GV9p-AS; Wed, 28 Jun 2023 17:31:50 +0000
Date:   Wed, 28 Jun 2023 17:31:50 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/smb: Swing unicode common code from server->common
Message-ID: <ZJxuhjWdZlaV8iQw@gallifrey>
References: <20230628011439.159678-1-linux@treblig.org>
 <20230628011439.159678-3-linux@treblig.org>
 <CAKYAXd-KeNM56ecmnaDR2wA4meTqPRa=e+KT3JJkpvC9=PCeiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKYAXd-KeNM56ecmnaDR2wA4meTqPRa=e+KT3JJkpvC9=PCeiw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 17:31:26 up 101 days,  4:05,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Namjae Jeon (linkinjeon@kernel.org) wrote:
> 2023-06-28 10:14 GMT+09:00, linux@treblig.org <linux@treblig.org>:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Swing most of the inline functions and unicode tables into smb/common
> > from the copy in smb/server.
> >
> > UniStrcat has different types between the client and server
> > versions so I've not moved it (although I suspect it's OK).
> ksmbd doesn't use this function. You can move it to smb_unicode_common.h.

Ah OK, thanks.

Dave

> Thanks.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
