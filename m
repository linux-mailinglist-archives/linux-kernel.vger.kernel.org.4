Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8334D63307F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKUXJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKUXJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:09:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83ED06FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:09:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so6661314pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thMZF7GVx7htOzAN9ugFbTafPjK5gmEMHGomXo9SsGA=;
        b=Jcy6AooXlRh0hEsSFf1DzNkliYQhfAcewcnAqdPxaNmwOLi+I71GyB7VvrVtG8Jwk1
         vsREUbqnknfyTaePyzfqgt1S2IjNBr+xj6dyf1A7P7JPwfBj+BplBOmMxzhDVp44ZXbA
         s9jnCQV+cpYLOp5fTWU1tbyQqeAhtbkSRysxY2pq77VOGUH+XSxe/S5vE5fzXGGNcV1c
         nyE2MWeyuoaP03Vws9ogt9uFCn/5CwspPm8msEUThHISfETU2pNjdJ9PsPXmMGIn5V2J
         k3bqs6eIo6cL8454Rg/2AGtUomM/CrdXOvQjFSeYb3sv0ma+KvpnDTzmi1WuL4dLfHv4
         jKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thMZF7GVx7htOzAN9ugFbTafPjK5gmEMHGomXo9SsGA=;
        b=GTR9aCulw5D2dy5bqozdhkEIfNnKcfbmw9ZfJkle7m3bfZo/YCa7lRRA4w5KNzf9R3
         C7B3fzRGdXUc0sAEiEiLQL+8+5MFn98G/Uf0KumcX/N0dDUMyaL3VO6xi2x38MPKcIP8
         +qC52X7gsp45Bsfrn9pCZwpjL3rQvfyiDLEO5yPDHSg9eSKQdacVSR3o0ox3RSD+sD/3
         6hujNdLMsQOBkK39Yeynl9I5MQMiAJaAcdFIRoeH7fjgrk54BbmMmo8t8l53tcLELNbd
         AGgm7o6ilE6Nv/UJGoze5PocsVOI5iYtjVJBcg81zPX7NMswhGyP3ky0XhmZ+xqAB/b5
         XvpQ==
X-Gm-Message-State: ANoB5pnILmht31EkgBllmxuvR/p9ZmGAhGU/5J6kjQeChBLPWpqJbyB4
        TEnE4l+Nx6HKNbuVQyCcSybKBq2J08HYmkmcYYGH
X-Google-Smtp-Source: AA0mqf4ly1vQzytQGDiPTYJYTJc+VcaLXE8b1ssQBwtsMnU4IisxFSoxDoCOzXIfCJtqk1Q58KczuQutbb2oiIG62cY=
X-Received: by 2002:a17:90b:3d0d:b0:1fd:5b5d:f09d with SMTP id
 pt13-20020a17090b3d0d00b001fd5b5df09dmr23052926pjb.69.1669072160948; Mon, 21
 Nov 2022 15:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20221121142014.0ae7c8ff@canb.auug.org.au> <CAHC9VhSTLnEX58gGFCEDHo8K3CBkU33b2oqVKUvDhRyz33ibmw@mail.gmail.com>
 <20221122085550.3b8bdef9@oak.ozlabs.ibm.com>
In-Reply-To: <20221122085550.3b8bdef9@oak.ozlabs.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Nov 2022 18:09:09 -0500
Message-ID: <CAHC9VhQcxSJHM-mM--EFY9tJKDr-8x-B2__QV10vw7t1ShqQWA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with Linus' tree
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:56 PM Stephen Rothwell <sfr@rothwell.id.au> wrote:
>
> Hi Paul,
>
> On Mon, 21 Nov 2022 13:47:18 -0500 Paul Moore <paul@paul-moore.com> wrote:
> >
> > I asked this on a previous conflict but never received an answer so
> > I'll ask it one more time: is there a recommended way to notify
> > linux-next of an upcoming conflict?  I generally notice the merge
> > conflict within a few minutes of merging the patches into a -next
> > branch, and fix it shortly afterwards.  I'm happy to provide a
> > heads-up, and a merge example, but I'm not sure what the process is
> > for that, if any.  Or, would you simply prefer to notice it yourself?
> > I'm not bothered either way, I just thought you might appreciate the
> > heads-up.
>
> Sorry about that.  Some maintainers will just send a "heads up" email
> with a suggested resolution patch (but I don't get very many).  That
> can be very helpful for complicated (or non obvious) conflicts.  I
> still generally look at how to fix them myself (and report them), but
> it can save me considerable time in particularly obscure cases.

Okay, I'll make a mental note to send a FYI to the linux-next list
next time I notice a merge conflict.  The real trick will be to see if
I actually manage to remember the next time I see one ;)

-- 
paul-moore.com
