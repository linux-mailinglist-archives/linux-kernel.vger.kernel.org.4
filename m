Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01A2729EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbjFIPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjFIPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D83588;
        Fri,  9 Jun 2023 08:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E8BA6594A;
        Fri,  9 Jun 2023 15:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8DEC433EF;
        Fri,  9 Jun 2023 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325291;
        bh=D9BRGojXtiVX/FpQDfUF2IkmBGVctRI5JTe2iHqd9Mk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AUjBxF6pYnEFCfHl2RA1q9jo1v+DdzmiXm+FdJZZiKXQ4uxOigl0tfJH1sAeVYKTj
         i46bEkpys88X4CoQt9gUEoUrQs2jT2BfbSOzgVgfyd9EXW+bhjujPokJx7tEgVv1aq
         +s7folPg5KIloE5Qm0za8hB5eTGLxukCgJlr0xsjq6Z65GF5d/EI4NZnjR6XaapHYe
         dlf58qAVVPn2SlmnEjzEETlYU36HBPcWTrudjUJMRGYeA5jzJnCB6zdxfYrL74q77W
         vqflsw3G4FiGDwNJJ7kqrCc68XbBzDkh4xrbgFNYWqaKaIxgdYTRrwqTtTSXRrhC3j
         ywAYCaL0X11vA==
Date:   Fri, 9 Jun 2023 17:41:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lasse Brun <bruners@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: apple: Option to swap only left side mod keys
In-Reply-To: <20230522184013.42621-1-bruners@gmail.com>
Message-ID: <nycvar.YFH.7.76.2306091741170.5716@cbobk.fhfr.pm>
References: <20230522184013.42621-1-bruners@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Lasse Brun wrote:

> On the Keychron K8 keyboard, and probably others, the right side keys
> should not be swapped to maintain PC layout.
> 
> Swapping the right side keys moves 'Super' before 'Alt gr' which is not
> intended by the default Keychron layout or the ISO layout.
> 
> Signed-off-by: Lasse Brun <bruners@gmail.com>

Applied, thanks, and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

