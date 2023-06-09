Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E125729DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjFIPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjFIPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:08:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDF359A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:08:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686323290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZd+Oo92Qi7oLu3blWbTQ3tlDlTIWl9/PxVYgxXQHOI=;
        b=0C/USPdaOlI/XdjGaFa12TUur5NbEg1zPbJPETBRoPWbBkhjBfvI9tVmldOEjCSS7q9LuO
        iwj16eiU3lbaDeCSBACEfZZKqzMNwStJLF3jhOrGTNRuKZ9sbJ22Y2VZyct4FpsQ/v+mIC
        r8NYrzdUf6fv6YNTbh5HUtM7U+IMOnKTFkV4GiFopVvWwieImytDGfnrVh9UREkkS/FieT
        lvSoaUQyz1sjFRblZAWU7weFfzZCxLbM0ig611Xw8kY+urZw3W31+VnJqp+PXK2o4Svn5g
        HFGCBhLZ4EkcmJ2v26haM9laiYoyM8/+H3yOsPNkNuGJIb/TAMue3fI1dYCWuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686323290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZd+Oo92Qi7oLu3blWbTQ3tlDlTIWl9/PxVYgxXQHOI=;
        b=z7dh/aAFSCLnUKSLLP9J+MtJM1Hx4b02lu7nE2aA6vUP//lNONw0E6cTuF8gy/Pr0oWzAj
        ynXtGzMG6m7gwMDA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 2/4] x86/entry: Rename ignore_sysret and compile it
 unconditionally
In-Reply-To: <20230609111311.4110901-3-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-3-nik.borisov@suse.com>
Date:   Fri, 09 Jun 2023 17:08:09 +0200
Message-ID: <87h6rgish2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09 2023 at 14:13, Nikolay Borisov wrote:
> Give ignore_sysret a more descriptive name as it's actually used to make
> 32bit syscalls a noop and return ENOSYS, rather than doing anything
> special to sysret. While at it also compile the function unconditinally
> as this is going to be used in the patch disabling ia32 syscalls due to
> 'ia32_disabled' parameter.

ONE patch does ONE thing. Rename is ONE thing. Make it undonditional is
ANOTHER thing. They are independent and especially the second one is
not 'while at it'.

Thanks,

        tglx
