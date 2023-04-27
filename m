Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C66F03E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbjD0KBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbjD0KB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:01:27 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF254EE0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:01:21 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Q6WTq2YPrz1r1fx;
        Thu, 27 Apr 2023 12:01:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Q6WTq1kjFz1qqlW;
        Thu, 27 Apr 2023 12:01:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hVYOSslHL2R2; Thu, 27 Apr 2023 12:01:18 +0200 (CEST)
X-Auth-Info: BxpfRXbYdAlU+alKyuzMgXEsMWjl7nMCeseQ5E3Un0ZJ2UQV8UaGNq/LvelGee6O
Received: from igel.home (aftr-82-135-86-255.dynamic.mnet-online.de [82.135.86.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Apr 2023 12:01:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 6A7222C13E8; Thu, 27 Apr 2023 12:01:11 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_maintainer.pl wrong and undeterministic?
In-Reply-To: <87cz3plkbj.fsf@igel.home> (Andreas Schwab's message of "Thu, 27
        Apr 2023 11:56:48 +0200")
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
        <20230328160756.30520-3-quic_kriskura@quicinc.com>
        <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
        <CAMuHMdXdP6fPPQxvAdQCz2P_SPnCLjEpqiTHerF05e7tJmWHFg@mail.gmail.com>
        <2070d2fc-9bdc-57f8-d789-4fa6412fc7ed@quicinc.com>
        <CAMuHMdUKqo6paF5efFVr0tmA3mpOAraZORoKyVFi8Pkt=H4z6Q@mail.gmail.com>
        <592c2095-a6dc-de4b-713d-a9a582f966e0@quicinc.com>
        <CAMuHMdW4whkqdj+CXbSbnJK+hA+ePf81O_1gh+VP-saY6-e=HQ@mail.gmail.com>
        <87cz3plkbj.fsf@igel.home>
X-Yow:  I'm having fun HITCHHIKING to CINCINNATI or FAR ROCKAWAY!!
Date:   Thu, 27 Apr 2023 12:01:11 +0200
Message-ID: <878redlk48.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore that, typo on my side.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
