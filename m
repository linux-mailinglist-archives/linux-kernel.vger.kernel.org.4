Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCE712B66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbjEZRIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEZRIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:08:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0738F2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:08:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb5e91ab4so2208991276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685120924; x=1687712924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vGiA8RDXZNla+9oLRBME/ADstNGcLr0myZFsD2x+srs=;
        b=q+q1fbB+HvtjpmCLptxf0KQdqQ7cCTrflxak5hyAfDyMsl8AwPsS/9dDGqqkCEAbUo
         XPoOzeWmF2a8QKGAVE3Od0fimzYo47YvWifrxI2j0sYTNVKIGeQ4Rgm/6UwQRExZh02H
         CozoI7wPYLqEdvkW+Ox56sAS9YqON7dKmdzRU+jS9uZL4g14DSC2+otYfVEr7fzBh359
         eqO59zmFqtj+qxbx3xnCLVjkYgGbnACaUO2nWt0FFghfZ3TNh+K/3ZqbwH9Xf6JPwso2
         QjzKIp/3sPi2X15/Z5NGp3sms/bOwF8FfDFAXHjXyIaO32GOw5v+L88cApu9MXYDvO4L
         fbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120924; x=1687712924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGiA8RDXZNla+9oLRBME/ADstNGcLr0myZFsD2x+srs=;
        b=eJX1ZEmOQaNDLra5gIGzO7v9QMSOskh+y2Nz2L31n3s7/sruYLlzb0sl8Akc8q2iyK
         Qc3eYJp4St5nwfoaLekndoCWLyiWqEcXSDVtX++VfkQh4En2/XXsObyZo4GOLqCow33G
         ucgJdKogQfBk84Xn5VY+4wFjWbtOb+KmwyarX6qzYx5w7cmwawWnM/UTW/pH6Pe+8/Cn
         od4VP+E/QJRQX2V/sx9/0OddIpEagxW5mTShwQV1ECmDDKLTqfbikuM4/4d6AnHtFwbN
         jT+8Ns8K4VVGkLRLFDTe2EP39F75bxmqBvIG2BAMFE1dZcURwYPoP8CpZT4Xvq0S5BEb
         I4qA==
X-Gm-Message-State: AC+VfDwAcO6P865DWYdQuU9bVOZxaZupUtEIu/PzyVdjio/GzmaruVfU
        Gqs/Aw0J3O5v7fxYgb09fFSURbiSnzA=
X-Google-Smtp-Source: ACHHUZ7VjHLnfQxu/pU7xV959/3MV2Qr6me2Aeb/bJmRXm4sLgHq/1MYjPL1W1sqOE2PzCWjfoiItTSNzlA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bf89:0:b0:bad:600:1833 with SMTP id
 l9-20020a25bf89000000b00bad06001833mr1322707ybk.0.1685120923900; Fri, 26 May
 2023 10:08:43 -0700 (PDT)
Date:   Fri, 26 May 2023 10:08:42 -0700
In-Reply-To: <ZHDflnVNGw1fN6VD@google.com>
Mime-Version: 1.0
References: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
 <88db2d9cb42e471692ff1feb0b9ca855906a9d95.camel@amazon.com> <ZHDflnVNGw1fN6VD@google.com>
Message-ID: <ZHDnmiyCIXFVxzh9@google.com>
Subject: Re: [ANNOUNCE] KVM Microconference at LPC 2023
From:   Sean Christopherson <seanjc@google.com>
To:     James Gowans <jgowans@amazon.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>, Alexander Graf <graf@amazon.de>,
        Nicolas Saenz Julienne <nsaenz@amazon.es>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023, Sean Christopherson wrote:
> On Fri, May 26, 2023, James Gowans wrote:
> > On Tue, 2023-05-09 at 11:55 +0200, Paolo Bonzini wrote:
> > > Hi all!
> > > 
> > > We are planning on submitting a CFP to host a KVM Microconference at
> > > Linux Plumbers Conference 2023. To help justify the proposal, we would
> > > like to gather a list of folks that would likely attend, and crowdsource
> > > a list of topics to include in the proposal.
> > 
> > Hi Paolo,
> > 
> > This MC sounds great! There are two topics I'd be keen to discuss, both in
> > the KVM + memory-management realm:
> > 
> > 1. Guest and kernel memory persistence across kexec for live update.
> > Specifically focussing on the host IOMMU pgtable persistence for DMA-
> > passthrough devices to support kexec while guest-driven DMA is still
> > running. There is some discussion happening now about this [1] and
> > hopefully the discussion and prototyping will continue in the run up to
> > LPC.
> 
> I don't think a KVM MC conference would be the right venue for this discussion.
> IIUC, KVM does not need to be involved in preserving guest memory or the IOMMU
> page tables.

Ah, I assume the KVM involvement comes from a potentially new filesystem for guest
memory?

  5. More "advanced" memory management APIs/ioctls for virtualisation: Being
  able to support things like DMA-driven post-copy live migration, memory
  oversubscription, carving out chunks of memory from a VM to launch side-
  car VMs, more fine-grain control of IOMMU or MMU permissions, etc. This
  may be easier to achieve with a new filesystem, rather than coupling to
  tempfs semantics and ioctls.
