Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58F6D097B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjC3PZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjC3PYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:24:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29387D534
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:24:24 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE2A81EC0691;
        Thu, 30 Mar 2023 17:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680189509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qd5om9gxT9ZJJOv9i3uITg1LtQmZSSw65wvXHgs9mtE=;
        b=hCfQNGx/0JvRA587z1H5a9oPV7u3HC7TMyxb1X8zYxewgoIeJD0dUNQjNrpBySSdVTJi8s
        Z3rfrWu6ADgFLY9yLRS+Qa4d0suBz9/qz0SmT4UhZYX+QgcEkgnUIcC73ZJZPp07iiXcIS
        8E1IhfNkH68AfFV3yYu1FCP6gDbwSYs=
Date:   Thu, 30 Mar 2023 17:18:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Simon Horman <horms@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
Message-ID: <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
 <20230330111523.4b98c8ce@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330111523.4b98c8ce@gandalf.local.home>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > Make sure that the .text section is not divided in multiple overlapping
> > sections. This is not supported by kexec_file.

And?

What is the failure scenario? Why are you fixing it? Why do we care?

This is way too laconic.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
