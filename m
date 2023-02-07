Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EAB68D413
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBGK21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjBGK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:28:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED61E5D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:28:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675765697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMi0GSgNip0tkfsmFb4eL5iRtfXpuzws4YX+EtRms+Q=;
        b=zOKxInj9JPN54iu2DhHgHeY88vfuZJV7f4AHGGnjzuluo/iA5Xc5bL0X4O98y3fSxx2qvv
        IhWv5y0l+iziz9acklCHnlPFIhrEp+t4TOJ4i56+MWTS6rf8ILXoJ9wnPmYHWo15aXK222
        MY9ypGbMKivXCCMkYDTuCnOc/zmUBozQxyUtUXm6Ord79Act6bz4QUi0LTHgzPk1eoUz6u
        m5W7xh7oCIV31wjBqsYu5yANGMtK5pUF2cXMNOGRfB9Cu6Sc5HGy7njIrIhhqfX50broil
        dyYv1N/a5+0CbS2SvQrNSz9C2nahpdsPT345IkUPGDRpKpxemnMRlfM4stBIPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675765697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMi0GSgNip0tkfsmFb4eL5iRtfXpuzws4YX+EtRms+Q=;
        b=/ELnWfJVySzvUkK8kFMTbJBTSRUBm5GQQv47IZckt+HwYSoBtMLwcJdDhi3oClvZHLF1XY
        V0NX9V3jo7meAoCQ==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq: Allocate IRQ descriptors at boot time for
 !SPARSEIRQ
In-Reply-To: <d0cef09a-a440-d61b-b541-d3d040a295cf@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-3-sdonthineni@nvidia.com> <87mt5z12t4.ffs@tglx>
 <d0cef09a-a440-d61b-b541-d3d040a295cf@nvidia.com>
Date:   Tue, 07 Feb 2023 11:28:17 +0100
Message-ID: <87a61pwz0e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2023 at 10:41, Shanker Donthineni wrote:
> On 1/31/23 03:16, Thomas Gleixner wrote:
>> That's not what I meant. I was pondering to remove !SPARSEIRQ
>> completely.
>> 
> It's touching many files to drop CONFIG_SPARSE_IRQ=n support. Worried
> about removing !SPARSEIRQ without testing on legacy platforms.

This needs some thought.

> Can work on this after moving it to maple tree?

Yup. Just drop this patch.

Thanks,

        tglx
