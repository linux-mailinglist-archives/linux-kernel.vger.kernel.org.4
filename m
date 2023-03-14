Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456D6B92B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjCNMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCNMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:08:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E334F5F;
        Tue, 14 Mar 2023 05:07:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id da10so61171818edb.3;
        Tue, 14 Mar 2023 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678795636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGJ/J3etGXzzl0b+NHW/iN6M3fmzVQmhjKRcIxTWVds=;
        b=ka8JGNS5D9SBcMnt4d472x2hwdFkFyldNKxnGEnO6pkvYSlUbIPqO4QQXn8NmzwyVC
         8rk0yUI9Ytm+zUIbnPDGByyhREZTWaoVHCxqr4ft5G7ajdPtRGbMnPcEvfISWe33JRdS
         2zRjYKlZv0ukmKIM/H+sCicuGvpuDBWpJEavqLje0lpLqJ6a2VYTridpp5gFZJJD/8JH
         OGSN3wph8HBzAGDNII2yYIqbjNDKCH0vsLyK6uYB3NXGFwph+zJjCETmmrwsneflYZSh
         CNI3KkJJK1fAfWwer4wZpllE82hWWa8pfYSbJKnUcfO0jTEFk/Iz//RQLwUCp3Me57+v
         VDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGJ/J3etGXzzl0b+NHW/iN6M3fmzVQmhjKRcIxTWVds=;
        b=CLUOrZl1slwXwTtGA6dYbTgtrI2Xy2AXViuSITlTjvZcoO2w0UbLdJ29eb2VMiPAQI
         41q1u8VLH7lw6OP7lIfTNlhEzlPCSWdkVb92UfY0eX5fxiiXXY2bWzEuXrNtJ9Wijito
         E1ik1JmmfZ1rehvaH3Y9hB7SIHlysSqMkmGyZzu+s7F2qzLpiQycUebiiSpj8Jyyb71r
         Iojr7uepPBlFlZxPn6IEJIQAxpuONEOM2Pz96gJ5AmNWyEcMT4cT908/u+pOR7uFJyP3
         zLcJV/D6aELISJ/s2zaQV3yVern005VJ1Q6J6kAE/bLyf/2RPIi///uzmRenftQ3qm/9
         QaJA==
X-Gm-Message-State: AO0yUKWn4aYxtqsBKLUpOrrM5FAqWk8pFlO112MzqR+BZ4VzTFS1Hp54
        J2wfECZO/8jZ9Ubp2VgEEoY=
X-Google-Smtp-Source: AK7set/ZXQ+XfAoC7QvC3zJZuOUeUmwsfD1u7z9CGxTW9HvRYx2Fw+SlEkD2QSWMCctkfcyjX1j1Tw==
X-Received: by 2002:aa7:d38b:0:b0:4fb:fd9f:7375 with SMTP id x11-20020aa7d38b000000b004fbfd9f7375mr7624487edq.2.1678795636347;
        Tue, 14 Mar 2023 05:07:16 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id v30-20020a50d59e000000b004af7191fe35sm948475edi.22.2023.03.14.05.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:07:15 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id BBA70BE2DE0; Tue, 14 Mar 2023 13:07:14 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:07:14 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Joost Roeleveld <joost@antarean.org>,
        Christoph Hellwig <hch@infradead.org>, jejb@linux.ibm.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <ZBBjcu2YH9HFY06l@eldamar.lan>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
 <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
 <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>
 <4c5de098-5cd3-116b-54cb-6972c6c06818@suse.com>
 <8cc36c16-4aa0-9c47-ab2f-c75c1e22772f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cc36c16-4aa0-9c47-ab2f-c75c1e22772f@citrix.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Mar 14, 2023 at 11:41:08AM +0000, Andrew Cooper wrote:
> On 14/03/2023 11:23 am, Juergen Gross wrote:
> > On 14.03.23 12:17, Joost Roeleveld wrote:
> >>> On Mon, Oct 24, 2022 at 05:28:05PM +0000, Andrew Cooper wrote:
> >>>> I don't know exactly how this translates to Linux internals, but most
> >>>> devices are fine and it's routinely the mpt2/3sas drivers which
> >>>> encounter problems.  It would be lovely if we could get to the
> >>>> bottom of
> >>>> this for once and for all.
> >>>
> >>> So to summarize my two mails: I think te use of dma_get_required_mask
> >>> in mpt3sas is wrong, and the dma_get_required_mask return value from
> >>> xen-swiotlb is also wrong. Fixing either one should fix this problem,
> >>> and I think we should fix both.
> >>
> >> Hi all,
> >>
> >> Is there anything that can be done to get this fixed in xen and the
> >> kernel somehow?
> >> I keep having to manually patch the mpt3sas driver to prevent it from
> >> being able to switch to 32bit mode each time I upgrade the kernel.
> >
> > Just use 5.10.173.
> 
> Its still broken even in 6.1
> 
> We've just stumbled over this yet again in XenServer.

The mentioned commit has been backported to 6.1.16, 5.15.100 and
5.10.173. Is the issue still reproducible with 6.1.16?

Regards,
Salvatore
