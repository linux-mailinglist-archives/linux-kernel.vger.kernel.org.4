Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816966C72BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCWWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D375E39C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC91162864
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01901C433EF;
        Thu, 23 Mar 2023 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679609277;
        bh=reLqZ6mL7WqZDYYjDhmQkKBmgPIHanFWRcBr7gpKytk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yWnmA7jho28TdcB1GYNPLBSK1E0F2yavbxbGf5yE5BOHyqq4nxKHTwWpAFBQ7gqdq
         kK4H+M4qD3qNbibUmbwo3f5JF0Hn3Xf21nMMrCr7TMJobLuTsAkNci/EDg68VV2ZT6
         A/q4A6FXFsWJh+LO4VGt3pxf9RZ+HpGXB6OyFJ2o=
Date:   Thu, 23 Mar 2023 15:07:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-Id: <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
In-Reply-To: <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
        <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 15:49:20 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi,
> 
> On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> > 
> > v1 is at:
> > https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> > 
> > This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> > slightly.
> 
> This is an obvious and good cleanup patchset, who should I ping to ask
> for accepting?  It's touching kexec generic code, while the hook
> only exists on x86 ARCH.

I grabbed them
