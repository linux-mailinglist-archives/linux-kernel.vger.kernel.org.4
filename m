Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C616E4AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDQOIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDQOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2BABAD3F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86FEA1FB;
        Mon, 17 Apr 2023 07:08:10 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44A053F5A1;
        Mon, 17 Apr 2023 07:07:25 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 0/4] cacheinfo: Correctly fallback to using clidr_el1's information
Date:   Mon, 17 Apr 2023 15:07:19 +0100
Message-Id: <168174038149.1898503.2929035642599343206.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414081453.244787-1-pierre.gondois@arm.com>
References: <20230414081453.244787-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 10:14:48 +0200, Pierre Gondois wrote:
> v4:
> arch_topology: Remove early cacheinfo error message:
> - Only remove the error message if the error code is -ENOENT
> cacheinfo: Add use_arch[|_cache]_info field/function:
> - Use a static variable instead of a per-leaf 'use_arch_info'
> - Reformat the use_arch_cache_info() define
> 
> [...]

Applied to sudeep.holla/linux (for-next/cacheinfo), thanks!

[1/4] cacheinfo: Check sib_leaf in cache_leaves_are_shared()
      https://git.kernel.org/sudeep.holla/c/7a306e3eabf2
[2/4] cacheinfo: Check cache properties are present in DT
      https://git.kernel.org/sudeep.holla/c/cde0fbff07ef
[3/4] arch_topology: Remove early cacheinfo error message if -ENOENT
      https://git.kernel.org/sudeep.holla/c/3522340199cc
[4/4] cacheinfo: Add use_arch[|_cache]_info field/function
      https://git.kernel.org/sudeep.holla/c/ef9f643a9f8b

--
Regards,
Sudeep

