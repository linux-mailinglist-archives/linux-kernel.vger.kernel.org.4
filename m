Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B615F446D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJDNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:39:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640A564F0;
        Tue,  4 Oct 2022 06:39:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1h2yB1z4xHW;
        Wed,  5 Oct 2022 00:39:04 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Lynch <nathanl@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, jmorris@namei.org, paul@paul-moore.com,
        ajd@linux.ibm.com, serge@hallyn.com, gcwilson@linux.ibm.com,
        mpe@ellerman.id.au
In-Reply-To: <20220926131643.146502-1-nathanl@linux.ibm.com>
References: <20220926131643.146502-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] powerpc/pseries: restrict error injection and DT changes when locked down
Message-Id: <166488995179.779920.16022330580724234832.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:25:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 08:16:41 -0500, Nathan Lynch wrote:
> Add two new lockdown reasons for use in powerpc's pseries platform
> code.
> 
> The pseries platform allows hardware-level error injection via certain
> calls to the RTAS (Run Time Abstraction Services) firmware. ACPI-based
> error injection is already restricted in lockdown; this facility
> should be restricted for the same reasons.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/pseries: block untrusted device tree changes when locked down
      https://git.kernel.org/powerpc/c/99df7a2810b6d24651d4887ab61a142e042fb235
[2/2] powerpc/rtas: block error injection when locked down
      https://git.kernel.org/powerpc/c/b8f3e48834fe8c86b4f21739c6effd160e2c2c19

cheers
