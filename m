Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2D5F74E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJGHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJGHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:51:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3385CA886
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:50:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so5031762ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d43Kc+sf0b+0gI7JhaX+bifdCL/AboMx8MiNJnmjLL8=;
        b=LN/05YM/grW1uSGN+zcI+mTidBIhPocOeAjw/fPrFwLJJ9893ZRAhjyJTSAlVt9Um5
         FFHeqQE3BqKZNeQBvNVn+dp/aP+lNR2de+HKELe3UrTWatBBT1Rwjst/6ZUim/y9obm1
         ut15FEO5DOAajmNm+oLMW2SSX9ApUMi1e9C6lWCpYKn8ZSbTONs2N6zQ1pXRpd0B2/fG
         o1tG4a+jEI0tkcZW+FNt+wsEjKN80N6aOWuUicoNx03uO/FGefvS0EZSn1jalinszZQq
         Rzb9BLDoO6zuIpef1Q+7lZQCnIqW/vVOiISwysibQctHAowvrwI7CfhZLVPKWgtl4Qft
         gLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d43Kc+sf0b+0gI7JhaX+bifdCL/AboMx8MiNJnmjLL8=;
        b=jIcLlqUSfO0qJ9yqq/MgYIXn2/za4ywq5P6i9TVkwDcI/rYf3idKoWONo6+SvegY6U
         4PuhFiJX1gqXZxClcM5GKaUA92NV4+00rMWmrnQXJvq1HmNGdP5/gRueV0ELGicg9Wrj
         XajkncA2wTO3oSaOsUb4TNfXDCskSEovy4VUNsR9k8rYiKHH3Z/I5Xd1QdwvqZwAO1Gi
         mXdr1zFhXZDOo5N6b9WmOa0OS6Y/WxRRkcmkr9L+FkCzVbSD4jFys7fbSsJT5XMhmXhB
         BrMhi/r1IhKRR1DOLfbxKEW1P0ApEuB51x0TEqJ61Uu0Ha6Apr1vfULdmSWmx8cvEYho
         1ZFQ==
X-Gm-Message-State: ACrzQf2mLdmVd8hjaupeEibbccCIpvqpYGd9FA0JP5wJykPFoJHC9j/+
        yD3cqv0Se4oGlyBzUiiIVQiZfM9C1jKi9XuhFpyAKY8Y0EA=
X-Google-Smtp-Source: AMsMyM6A7cwEhN3EIN0f+rK7Fpn1c55XHAwNGcq5W6O7tUtmFSQsLL9Mh+RrNLVkT9GPuUmJI3P8s42SjKNyJgiecuU=
X-Received: by 2002:a17:907:70a:b0:741:78ab:dce5 with SMTP id
 xb10-20020a170907070a00b0074178abdce5mr3079629ejb.527.1665129040960; Fri, 07
 Oct 2022 00:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
In-Reply-To: <Yz/ZWBeNZvKenEVM@kroah.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 7 Oct 2022 13:20:24 +0530
Message-ID: <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Thanks Greg.. will wait for it!

On Fri, Oct 7, 2022 at 1:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 07, 2022 at 01:07:54PM +0530, Kaiwan N Billimoria wrote:
> > Greetings!
> > I'm working on the 2nd edition of the Linux Kernel Programming book
> > (https://www.amazon.com/gp/product/B07RW915K4/ref=dbs_a_def_rwt_bibl_vppi_i0)
> > and request your help...
> >
> > I'd like to base the book upon as recent a kernel version as is
> > feasible, of course, with the caveat that it's a long-term (LTS) one
> > that will be around for a while. Currently, the 5.10 LTS kernel's EOL
> > date - Dec 2026 - makes it an ideal candidate.
> >
> > However, if possible, I'd (also) like to use a 6.x kernel; so, my
> > question comes down to this: will a 6.1 kernel release occur soon (I
> > heard it should be around Dec this year)? Will it be an LTS kernel
> > (again, should be I guess), and, if so, very important for me, what's
> > the likely EOL date?
>
> I usually pick the "last kernel of the year", and based on the normal
> release cycle, yes, 6.1 will be that kernel.  But I can't promise
> anything until it is released, for obvious reasons.
>
> thanks,
>
> greg k-h
