Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEF6106D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiJ1Aaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ1Aan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8E5BC92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89576255E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D56AC43470;
        Fri, 28 Oct 2022 00:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666917041;
        bh=1cgQsn8Dl8oXXAx8gvKuL8W/RjgtqyJAH9sgnpZyd8Y=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AzadYNM69bZgFK5FQbyUM3syPXPVbs+PDGuRBl8e/w7FuXXt7a5R37YusxtHWZBb/
         r7jrETa6edX5JkceiAvS9MkzI3q7Ga/0Q/Jt2MLvYdOtjjkfozqftAd78QlTKQ0Bu8
         tSTgPy/UX5XNhskAR5OtuWoroldW3Zd8Bpup1pGTCKtpSTiKeu13HId2RAVL0YUlaA
         t97L5UvVKFv/3h7X2BuENXopk1uM32aBnbfgys8667lOutidYRYRMRJp80qJSkripQ
         jhenbmDEqIv6LjX7DPaNYb67wxDT9l+x0sIjhmp+tArSD5E8cBDX6MVuL91hcIjotU
         QjD+zm3r+JQ5g==
Date:   Fri, 28 Oct 2022 01:30:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, apatel@ventanamicro.com
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_clocksource/drivers/riscv=3A?= =?US-ASCII?Q?_Events_are_stopped_during_CPU_suspend?=
User-Agent: K-9 Mail for Android
In-Reply-To: <40abce35-b8de-cd5c-f544-fcf344e7057c@sholland.org>
References: <mhng-298aa3f7-7054-4695-bcb6-89be226a786b@palmer-ri-x1c9a> <40abce35-b8de-cd5c-f544-fcf344e7057c@sholland.org>
Message-ID: <6354C70F-86C7-430D-AF0A-3483B772B02C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 October 2022 00:41:45 IST, Samuel Holland <samuel@sholland=2Eorg> wr=
ote:
>
>I still don't see why you consider this patch to have broken anything=2E
>Can anyone explain why getting an RCU stall is better than not getting on=
e?

Taking that to the extreme, why even have RCU stall detection at all? It's=
 not a case of with the patch the system works fine and without it there ar=
e stalls=2E With the patch, the system completely locks up during boot and =
never makes progress=2E I think I've done a bad job of getting across that =
the system just dies during boot=2E

(Apologies for formatting, mobile=2E=2E=2E)
