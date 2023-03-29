Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D26CF61E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC2WDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC2WD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:03:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55093211D;
        Wed, 29 Mar 2023 15:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE1F9CE1AD9;
        Wed, 29 Mar 2023 22:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD06AC433D2;
        Wed, 29 Mar 2023 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127402;
        bh=A0tV3BERahKWejUelWbXZkkJbjJP/zPU+MZ1Y3XDirQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zr10bsBUbEamf4P6I2+fCD28zslCt/G7bCAc3J7eGSJ1guUEn6LBDWpp+OqM/iUS9
         NrBgS/F4agKgaDfN5FAoIcQQwJxSmGn4lIp0jbat4/apxXLE5cKBXqHh/e0bV6fAWr
         ck8P/GpGv4LJvZtcQa7G3HZp+9qxGyekXYXVoZR9Qs9Y2B2bDaUrfVJTnKSgPytCEG
         qm1SmQ5+F0Zu3i+Znp4T6I+QuWd27zpae00IWk6tZRS9Qs1lpLJ2EAvz3OLwcqQsv4
         lnWOlS9RdwPsV17TNC/rttoCDOFXSrFLmW2rJ43aA9MrGHCEtEJVhiBhH/E2WLcnpi
         G0jUfhaVW3j0Q==
Date:   Thu, 30 Mar 2023 01:03:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20230329220319.sxihrtujnatfzjym@kernel.org>
References: <20230321115413.106fa139@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321115413.106fa139@canb.auug.org.au>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:54:13AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tpmdd tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/char/tpm/tpm-chip.c: In function 'tpm_amd_is_rng_defective':
> drivers/char/tpm/tpm-chip.c:531:15: error: too many arguments to function 'tpm_request_locality'
>   531 |         ret = tpm_request_locality(chip, 0);
>       |               ^~~~~~~~~~~~~~~~~~~~
> drivers/char/tpm/tpm-chip.c:35:12: note: declared here
>    35 | static int tpm_request_locality(struct tpm_chip *chip)
>       |            ^~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   923c8dfa9a36 ("tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk")
> 
> I have used the tmpdd tree from next-20230320 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell

My mistake. I've removed the commit from my tree. Apologies.

BR, Jarkko
