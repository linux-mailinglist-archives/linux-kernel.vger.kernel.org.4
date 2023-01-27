Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2832667EDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjA0SjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjA0SjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:39:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D613511
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:39:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so5529922pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrjxXNdK4I+dKRJl+RazyEkZMnW15ppGiBRRJzwAjlI=;
        b=M2CZG0TsCW2EfMEir+0n0tq6W7MFgvZGhrib8KUa1MaqPIq3z5mkkKpsq27u8R1/s+
         BsJ8LiG+W15gvEMmtXGpUQOGoeAK7kFrWCS+n5BvpTOAKLo9RybRhBnel3EXxzvU9ED4
         gpkSFU1Q62myy3SfHnvEpx08R6r1lxOZHNMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrjxXNdK4I+dKRJl+RazyEkZMnW15ppGiBRRJzwAjlI=;
        b=x/15CIitMimlTHC6Iyo3kv6FI166MZQpHFT1l4WwlXUzNvsLuthl/ghVMUu3k7RKvk
         z6gqopRImX9bi4AS+IcytcvXdtGViWTMs+MfLeCcGWCFfCDk3TYsM+6jE9MHNPOZgAwy
         yJAn9Z3YuH3zrhMQawL8/PZ5VK41HFRvwWQHt2/IqwpkPQFH1wZjNDrilsC+xzOXUn/P
         BR/qnJnaYneK+E3Zi5ir+yblMGBoDCOQn4UAJNiWl6BNzWOE5Uo2NA3xlgt5Pv0PM6Rh
         SXIUq+fnMNMW/XV3DdEquTJRpvXrDlRoQHno4EZxyQesyxOIMRvvY13AI8qrE0P8w/Jq
         V6IQ==
X-Gm-Message-State: AFqh2kpP8ayfcaS0FuFqtQOjfTITFzNY5SJmFDnk1DbQuPcoH9yvpOBB
        CrcIuzIH3QMLZ8IuDdShDUbPDA==
X-Google-Smtp-Source: AMrXdXtPXtXIzrdadZKq6vmQXDs0rCcf4OFWXSTd+Fo+rccWx2CbqlOGRPnsBOn3l8Fz8X1aaaB7Ow==
X-Received: by 2002:a17:902:6a89:b0:194:88a3:6e28 with SMTP id n9-20020a1709026a8900b0019488a36e28mr38669680plk.51.1674844748988;
        Fri, 27 Jan 2023 10:39:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b0018725c2fc46sm3146551plg.303.2023.01.27.10.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:39:08 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:39:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the tty tree
Message-ID: <202301271038.8790DBA2AE@keescook>
References: <20230127155753.1f9b9517@canb.auug.org.au>
 <Y9N3GNBKzOKuSOMJ@kroah.com>
 <82cfbb3e-cb2c-199c-8833-35498ce894e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cfbb3e-cb2c-199c-8833-35498ce894e2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:12:46AM +0100, Jiri Slaby wrote:
> On 27. 01. 23, 8:02, Greg KH wrote:
> > On Fri, Jan 27, 2023 at 03:57:53PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the kspp tree got a conflict in:
> > > 
> > >    drivers/tty/vt/vt.c
> > > 
> > > between commit:
> > > 
> > >    feb36abbedea ("tty: vt: remove struct uni_screen")
> > > 
> > > from the tty tree and commit:
> > > 
> > >    19c30ead3938 ("vt: Replace 0-length array with flexible array")
> > > 
> > > from the kspp tree.
> > 
> > Kees, I was waiting for a new version of your 0-length patch before
> > applying it as I thought there were review comments on it.  So you
> > should probably drop it from your tree or resend it so I can merge it
> > into the tty tree if it's acceptable.
> 
> feb36abbedea removes the array completely, so obsoletes 19c30ead3938.

Yup, looks great. I've dropped the patch now.

-- 
Kees Cook
