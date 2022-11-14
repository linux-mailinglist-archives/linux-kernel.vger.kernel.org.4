Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4980627F25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiKNMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiKNMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:55:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DB2792B;
        Mon, 14 Nov 2022 04:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A780ACE1017;
        Mon, 14 Nov 2022 12:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD622C4347C;
        Mon, 14 Nov 2022 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430545;
        bh=PVNoHXT6G+m3J7WFKNR3wufjyq6Oy9PAVmaeUdCeTxg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pYBEmBfSRlzwPUHnSnUfqnxfV1Jud0g5HpfzScA/n6n1vexy5S0yM/mr0yayzGnnT
         2gjaWMHg6TBQq17l0OevXkSz7YVBwG8k6EEK6BY0Y6qerVAMY3ETyoI1SrX2j4jzEG
         dmnMAESVE+LrnOFnoEdJ+/mrEpoqJMM9l/4oBjqAj9ER9l3kv++05oe9AgMSijJVRP
         AJxiS+PSSoaxa9C9sU0n28GsjzZGQNpmNAqg5Jp24XQvur9EWB6PByeTj++8oPBEnj
         2IL++wabmRdoYiwLgz/OG9KgIn5vaxAHknz0IQpizhN4uF549GSWG8xVvyCecQ0Iv9
         IpakIFwcnavgw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: OMAP2+: pdata-quirks: stop including wl12xx.h
In-Reply-To: <Y2yknekcTus8CB2J@atomide.com> (Tony Lindgren's message of "Thu,
        10 Nov 2022 09:13:33 +0200")
References: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
        <Y2yknekcTus8CB2J@atomide.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 14 Nov 2022 14:55:40 +0200
Message-ID: <87mt8tbsqb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221109 22:33]:
>> As of commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora
>> quirks for mmc3 and wl1251") the code no longer creates an instance of
>> wl1251_platform_data, so there is no need for including this header.
>
> Best to merge this together with the rest of the series:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, so I'll plan to take the full series to wireless-next. Please let me
know if I misunderstood.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
