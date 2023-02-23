Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761C6A12F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBWWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBWWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:43:56 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8666E4C2C;
        Thu, 23 Feb 2023 14:43:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp25so15819395lfb.0;
        Thu, 23 Feb 2023 14:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNaOqOCPpq1ndzqLedSspxae9I63sTlFiJ8Ui7FMY9o=;
        b=hBRyUxAREwRiRYyR4JMMLb9J4JUUhgSovXBAhTXSgwtzFknD1e5gaQdsg2UMZVoBm5
         HDR88wFnB4NNeU45xvF3lDNprQi7W0D+MDH//9VhJoNKkUKbzSBAFccmUKJw2gE3NxW4
         8L9mTGFokhimMo5gnDF79U/gg9knez9no1O6m+0Wk1d+1DW2h4n0IIrVdy5DorMCWCBE
         lc3jZbcPQjgtMWGcowNZK6h3eD9Gz5bviiLQxvP4O2Gwr0BVMu7tRElsTsAjQyy2XpV0
         YCgQ/D0YMCN+Bp0lctyzdUj4Uhqt381x7MwmDKvNbk9MoRAyGd7GsJ4TLGDcT6SMqfhC
         8GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNaOqOCPpq1ndzqLedSspxae9I63sTlFiJ8Ui7FMY9o=;
        b=cXB3AcDH4bk1jpm4OGOizSGwVIv/UMYwqt3mQAVs8hHTn+gNPuud1YG4n0rzv7CJRp
         +140gJRxN1gSojSdP0T2/xuVd6gbWhDIwdqqPuAZXt/E9sIjCxDXz/6SVjH/HJFvBNxY
         VTutim3NBY9ZriKnMCvn88mjJTaCLX0fCwNeHfC/hu5snCsxLKVRFvAm+lXHr0wctmFE
         JOEcxkrgnrSxLis1VjJfVH0i1msGrac9aJGLXcIyGaOz3SKb5tP3u6VyNaF7FuwY5r9n
         pi1jpH3KIkRs9KVy+CKMi15uDWuLKzqcLZVdyAYM3cCYdqLCkXqqVyVLOwpRfrJj85LK
         YHMA==
X-Gm-Message-State: AO0yUKXhp+QXX0oHHqAw2Q4dTS0uQJGCN/SqUBPva/WBZM3wTgCQupOL
        zCVBv66D2UIVLn6b0dLUus2btkzJ18WeG5rUDd0KSgXI
X-Google-Smtp-Source: AK7set+NIzWM7lae+k2kz33lbmR7Os5+CsjVpNXozaWKxGOKknyJHNDak4eXxI5hLf6cv++xbW0bFSudZ5DxEsdhNMM=
X-Received: by 2002:a05:6512:340f:b0:4d5:ca32:6ed6 with SMTP id
 i15-20020a056512340f00b004d5ca326ed6mr6420581lfr.4.1677192233838; Thu, 23 Feb
 2023 14:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20230224080931.6433105a@canb.auug.org.au> <1659485.1677187658@warthog.procyon.org.uk>
In-Reply-To: <1659485.1677187658@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 23 Feb 2023 16:43:42 -0600
Message-ID: <CAH2r5mts6edG_a1bj7oxF5LdNU-qpor-xEoKFsf4L5-9fnNdTA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed. And updated now in cifs-2.6.git for-next

On Thu, Feb 23, 2023 at 3:27 PM David Howells <dhowells@redhat.com> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > In commit
> >
> >   d7830041d59a ("cifs: Add some missing xas_retry() calls")
> >
> > Fixes tag
> >
> >   Fixes: 5f0955c98375 ("cifs: Add some helper functions")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe you meant
> >
> > Fixes: b8713c4dbfa3 ("cifs: Add some helper functions")
>
> Sorry, yes, I was on my branch and not the one with Steve's applied version of
> the patches.
>
> David
>


-- 
Thanks,

Steve
