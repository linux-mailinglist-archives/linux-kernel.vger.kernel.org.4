Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C835567A54C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjAXWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjAXWBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:01:11 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC84FCC8;
        Tue, 24 Jan 2023 14:01:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8361599C;
        Tue, 24 Jan 2023 22:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8361599C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674597666; bh=MRcXfRT3encc2WhT9wUAe6vr0xv440A2voNd+2qi1gQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dzT7X2HcbGjWTXJwTXhHK/5++x2j1Q/Vo7JmOsccGZQ16qdCf9eev73fgEp/ESkeT
         ISMSKuWKtLfGZ7RMVH39t7ch8E61ap5Xo2k6fajsRNZdL24sZmbEnQnW4FAteNMGID
         YK5MRokishBudR5uVNCla5Z7guqTb3mZjZHBE8iF0iY8WSBrYN1xve8fuWaDyeIcxJ
         wrNtnNFKeLcOujBE8fb/HjUHIL68fBczkbpIDr/U1rrdJ3xPnyLb8VWt8JmvkaQQsW
         PEWODXn65japhyyuPrgzwvtBy3qag9hAUPefHLoraeXtE46ATzVALGuxxNU75f706i
         qePSjhiyxNKxQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
In-Reply-To: <20230123103341.56f42e72@gandalf.local.home>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
 <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
 <20230123103341.56f42e72@gandalf.local.home>
Date:   Tue, 24 Jan 2023 15:01:05 -0700
Message-ID: <87v8kvfv8e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Jon, care to take this series through your tree?

Done, thanks.

jon
