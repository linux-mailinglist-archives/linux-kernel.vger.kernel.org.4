Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF865E64A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiIVOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIVOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539952E4C;
        Thu, 22 Sep 2022 07:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B866B83708;
        Thu, 22 Sep 2022 14:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72489C433C1;
        Thu, 22 Sep 2022 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663855453;
        bh=VgWUO4Ckjan3w0JYAK63vpjVgU/HRN09V887VEmZ824=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hf7hYytrI3XkOXHq3SP1OR8h4PTC79Oy5j8QfIE5Oy/W4R9kcFue8GZgjuthalwv4
         LY3LplmSIxs6jvir8GCkpTLWRUaGUXVT6EJ+dfpC4VOdbdcmDjLeS+w4CCKlL+JUPi
         6dtUjNorb9JPS8xEZz0DdjI2E7Adh/7Nn5lEvRnLfmiIafKL8+lLmFc9BcQrWNRBAa
         Gmsazl2KSUEqoSoqvzG3cQ0SMV7nEMgUDQymMndHaM4hwpRIXiQiXVMJ7oW0WwVPFW
         VDn6kbPzXMAzoi9v2KThd+bcr1XRZmbwfUvEbOZLUv7ak5NdhPJw7wOV+rqhqCYw9a
         oo0ihb+N1NMQg==
Date:   Thu, 22 Sep 2022 15:04:07 +0100
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, leo.yan@linaro.org, john.garry@huawei.com,
        catalin.marinas@arm.com, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Message-ID: <20220922140406.GG12095@willie-the-truck>
References: <20220901132658.1024635-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901132658.1024635-1-james.clark@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 02:26:56PM +0100, James Clark wrote:
> I'm resubmitting this with a few of the changes suggested by Will on V2.
> 
> I haven't made any changes regarding the open questions about the
> discoverability or saving the new reg and passing to output_sample()
> because I think it's best to be consistent with the implementations on
> other platforms first. I have explained in more detail on v2 [1].
> 
> [1]: https://lore.kernel.org/lkml/5fcf1a6f-c8fb-c296-992e-18aae8874095@arm.com/

Fair enough, I can't argue against being consistent.

Given that this exposes subtle new user ABI, do we have any coverage in
the selftests? If not, please could you add something?

Thanks,

Will
