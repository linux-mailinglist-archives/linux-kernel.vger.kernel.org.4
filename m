Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F296742E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjASTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjASTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:32:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC99402C7;
        Thu, 19 Jan 2023 11:32:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674156755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHxykVY6P+CjvCy3BM/v+eaFbSdX57m2P+2wz/O0ELw=;
        b=iNnOhimeyI7dlFF9r/d3A60O5YHoZubdJeoBRFd4qs6qhTVUKhHJd16w1sy0gLPKlq0ttO
        JKzF/Wwh1tjgHYCdX3ycl2Cgv8N2Jng2ndyw1FUJN+kWYrF+aSJriPCYBLpTYtt/Isyaaz
        ZjR6aeOqAa16PMpySfI3CS9rcCNKZEnmIui3mEYdQ2WPQAJkCJSMMjY2A4+QbovbqaO3ap
        GvOkCmMtSR2ZtpwbPxT1OQxY0EJsXvk8CBBu3g2M1mlmgsywjM8cq6MLExV1+mXX1drAxS
        qeFNtFh1Cl6ySWiqCKdGTnjUVzgOJB6typ9eXts1SySwLwnwvDXZISmPoS16Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674156755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHxykVY6P+CjvCy3BM/v+eaFbSdX57m2P+2wz/O0ELw=;
        b=AaPaVme/sKpCnlh+tVrWSlI5TkptV7MVp/WmAM5NfSMvKL34v23rLPa8iuFR/gxfXGP6zo
        XoIdw10zTxJgrHDg==
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add x86 ACPI paths to the ACPI entry
In-Reply-To: <12136077.O9o76ZdvQC@kreacher>
References: <12136077.O9o76ZdvQC@kreacher>
Date:   Thu, 19 Jan 2023 20:32:34 +0100
Message-ID: <87ilh2ialp.ffs@tglx>
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

On Thu, Jan 19 2023 at 19:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In order for things like get_maintainer.pl to print linux-acpi as a
> list to receive copies of ACPI-related patches, add paths to ACPI files
> in the arch/x86/ directory to the ACPI entry in MAINTAINERS.
>
> While at it, make the list of ACPI files listed in the suspend-to-RAM
> entry more precise.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
