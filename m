Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28A621CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKHTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:18:13 -0500
X-Greylist: delayed 1826 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 11:18:13 PST
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30C67F5F;
        Tue,  8 Nov 2022 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8LLwr9lg+hA/QOowh3EjKMaaNzsCxbGFre4zlBG4jUM=; b=VSpqWfZI3/zAHSlCytnw/7m+SF
        DYAZHNiPj1TOjB/6rz1oYsc2j9IPCbVw9+B7F082xn3AKUyy8VWVUk23G0RW+RHXv1j5JdZWcASF9
        mcFYkJh6Ka33O3Hk+kfKuICSQcy3MntCZ1cpyrAQXPlYpGeQqe2AHC44m/YUw92pOyTR/FPpyAub5
        O+0xbyNDZk/gUpddaL9TA5H+4t9FYBPkYheSI3REfmFYiTF8hKAJcqnclrHFahGSJuKALxZhoFk5S
        VON8D00MEI/RyIT/AjcoXRrFyJCmOPkrkngbvBADgSodbGySBW0GbIr3rsJyrKG7yVmRRhteoilW8
        zuW6oEcA==;
Received: from p200300ccff1252001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:5200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1osTdQ-0006ZU-AE; Tue, 08 Nov 2022 19:47:44 +0100
Date:   Tue, 8 Nov 2022 19:47:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Jackson <mpfj@newflow.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        tony@atomide.com
Subject: Re: [PATCH] Update Nanobone
Message-ID: <20221108194742.0d9340f4@aktux>
In-Reply-To: <CAAbcLfiCoa=-20cydPG9=42G9npaeBOCRXPPPTwkNFU-3yGoCg@mail.gmail.com>
References: <20221004143901.130935-1-mpfj@newflow.co.uk>
        <CAAbcLfiCoa=-20cydPG9=42G9npaeBOCRXPPPTwkNFU-3yGoCg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Nov 2022 17:18:54 +0000
Mark Jackson <mpfj@newflow.co.uk> wrote:

> Any update on this patch ?
> Did it ever get through ?

it got probably caught in peoples "internal spam filter"
reasons: 
 - bad subject line 
     look at  git log arch/arm/boot/dts/am335x-nano.dts for sane values
 - bad recipient list
     get_maintainer.pl is your friend

Hmm, you already have contributed long time ago, it looks better:
Author: Mark Jackson <mpfj-list@newflow.co.uk>
Date:   Thu Dec 15 10:52:13 2016 +0000

    ARM: dts: Update Nanobone dts file to add external FRAM chip

That looks ok. But maybe reread the documentation/SubmittingPatches again


Regards,
Andreas
