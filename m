Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6800974573B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGCIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGCIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F691E6A;
        Mon,  3 Jul 2023 01:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A40860DDF;
        Mon,  3 Jul 2023 08:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896EFC433C7;
        Mon,  3 Jul 2023 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372474;
        bh=W3MFlYlRTSCPoM2yPpfMueipjIB84ln3ga7EsulXzeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JFPppq8rDi7u0cnv2R2cF2+1oTPT2ahqINPWwu2EPOvpyUu4NZ+mT+NGDum1o1cDg
         K+9IUvbcjtyydww/RPgBQun7JBhHaoAEfk4ViXp1aA41J2fi92BMqu/Ao+wrnaax49
         7qsGhc+YraMhAD2vuGPVrJXh9UBbWPHsZgxs1RQkr0U8+XKnJYCHRzqlboXJ+3R2SR
         qYWGq5XPQu/04e6Nr2Y1+kE28aKT9QzT5FzSheo1+gLOocdr6gG31FCWIxeFuwYtz2
         O7lG1aMjQWaCWbkpA1rr5PZ4dmTV/Xoh3BZa0jFEkRXNFZG8lPLhERmI4Ax+pUB4w0
         uC+IyO8CnsSNA==
Date:   Mon, 3 Jul 2023 17:21:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-trace-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 1/3] tracing/probes: Fix to avoid double count of the
 string length on the array
Message-Id: <20230703172110.6948481fb7e0254bc791d12b@kernel.org>
In-Reply-To: <25bd757c-f929-0153-4c94-f0502c5d1005@web.de>
References: <168830923752.2278819.12200306485001986374.stgit@mhiramat.roam.corp.google.com>
        <25bd757c-f929-0153-4c94-f0502c5d1005@web.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 17:44:38 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> …
> > Just set the length to the 'ret' value to aviod double count.
> 
> Would the wording “… avoid double counting” be more appropriate
> for a subsequent change description?

Yeah, thanks!

> 
> Regards,
> Markus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
