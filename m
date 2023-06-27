Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1A7406C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjF0XQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF0XQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:16:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26441BCF;
        Tue, 27 Jun 2023 16:16:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687907774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRwoGOoZ7TfS3mJRWihfbPocmOKxdlsrgSr40GGWDkk=;
        b=H3TnR2/dn+iIhdhhgfSpvtynaVPPqWUAlALbmY6cd+k0ZU/4a748f9uZwlJKdT421E7g8S
        2n9g6Q6LPM6fbKCTVFcJ1hy2cx2s/C2s5Nxnw29AXuJpFKP0vdA/uCIybstHEu/AYNxVg1
        KoNrKEGKiKgzo5fWzRO7K/MgPUN+Af1XWwuDbPG8Vh6KMGYdwyQLKTX4MEnfsqVQHjz3mr
        ofBZ+WbFFGNguJPOkjmpBIdZfl5Ow0AALJRxB1qMq3+VZOAT5v/Sag+QE7KlWg622X+8SG
        lSrejnH8ZpsCnH+78CpRINbBEPHqTKWz58app4L07ZSMHemagVrGagTHxfNEnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687907774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRwoGOoZ7TfS3mJRWihfbPocmOKxdlsrgSr40GGWDkk=;
        b=Q4gkUxqHAUXqzDp75Hqv4RlphQUUFvAeBJDBmNhwpsFmNnrWlJSQ6WBdOvSNlGbSpojief
        TdTps/8Ue79NweAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: clean out
 empty and unused entries
In-Reply-To: <2023062742-mouse-appease-7917@gregkh>
References: <2023062742-mouse-appease-7917@gregkh>
Date:   Wed, 28 Jun 2023 01:16:13 +0200
Message-ID: <87edlw4htu.ffs@tglx>
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

On Tue, Jun 27 2023 at 13:26, Greg Kroah-Hartman wrote:

> There are a few empty entries in the company/project list, which
> confuses people as to why they are there, so remove them entirely, and
> also remove an entry that doesn't wish to participate in this process.
>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
