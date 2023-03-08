Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C76B04E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCHKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCHKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:46:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F01126E4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEA861716
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65ABC433D2;
        Wed,  8 Mar 2023 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272360;
        bh=2JXOcQDxEKsO60x04MVPhRSap02VmfSynU8kgTwjvT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZ37Djq8ZCZsqKFLCnONv9OcedW+Vg9+H5YIE1ca3UWuXrDLtLouhEv+Wamns3FHA
         UqfOxLvfvf/5Yel+hCMkZ5xD3nf7YtS+jGC/EPTGPgyfFtI5MIE19cNI2jVXzuQFaX
         YAhUAQ4QPCDtOhkIa+KoeHAGU9hK4b6NHEbLIwNEIQiGClyj42Ezoa3GiwRktM9P2S
         Gg5u1V2XlBzu05j/ckCYqgQ/nSO8vpQja6aDI3zznd4n144ZM+ebn+NlY4cOlA9WxC
         IKuevfKybLVOvfcT/Z11y359S1cv2xodPW/upGH0J9qt0Qf88DNyIlHTNL8wVlQNFH
         ATPY/aickzWsg==
Date:   Wed, 8 Mar 2023 11:45:55 +0100
From:   Simon Horman <horms@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] kexec: Remove unnecessary
 arch_kexec_kernel_image_load()
Message-ID: <ZAhnY6s3rUhnzLIz@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <20230307224416.907040-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-3-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:44:16PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> arch_kexec_kernel_image_load() only calls kexec_image_load_default(), and
> there are no arch-specific implementations.
> 
> Remove the unnecessary arch_kexec_kernel_image_load() and make
> kexec_image_load_default() static.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

