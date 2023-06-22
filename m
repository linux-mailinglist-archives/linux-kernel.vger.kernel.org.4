Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4573AB75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFVVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27898F1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCCA6190E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A149C433C0;
        Thu, 22 Jun 2023 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687468716;
        bh=DZ6KSu/L/tBR0J1/oT6QXZ3+nwsYKmM+bE2i/fxRL7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4NNu7Suak7UiG/ID6dX+Q+PBZg+Tp8u6Cq7kclS9Fq4i+V31quJnKzfrEtLzEavW
         cuGQ3acLp7V5aKeOmYL1GVhxoymK6cGMViF5sc0AR/iv2JfVwk7JlEJ+RAc+Iy40KI
         MC1Go7Ptj9DAw6lcarXaue6pDNB56gIHeUj8b/uS908ACdSbTDDUj+ck7lFTAzEFs+
         WK8Kh11BS5qEsBXCz9wmFsLz8F9nrwa9f5A7JnKCaI97BtYeax1Mt89E2RmO4oOsJf
         VFHROCKPGXrRcxa0Q0kIS65s6fq/iRk+RaxUBxAM+KG/c7N0RGz6dzCLfHA51ibNLQ
         vEOlXOxI3VRxA==
Date:   Thu, 22 Jun 2023 23:18:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 08/45] posix-timers: Convert timer list to hlist
Message-ID: <ZJS6qMzF-thMEUzj@localhost.localdomain>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.475141256@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606142031.475141256@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 06, 2023 at 04:37:31PM +0200, Thomas Gleixner a écrit :
> No requirement for a real list. Spare a few bytes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
