Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87C5F0A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiI3Lay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI3L3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:29:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF632DA2;
        Fri, 30 Sep 2022 04:20:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9EE261F8E2;
        Fri, 30 Sep 2022 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664536849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sq16qV9KAC6HhtR2SG4ysqHRgl4G28JmjfBwyTS++Oc=;
        b=xxu3ODCsAN/Qh9LG/9w9HvEk9+uSHbPptVsQndei0FIbAGoONJX7zSj2B0QzNCEy5/Sv2U
        UAVogGGl8qdWEwK36P4QkR9PyAGmjnhfm7Kz9/XFZ6ckRaTgH/e3LNrHqBbYLL6Dmdp5lU
        AizZB04SST5axA2ZXXsJg+Q01sM/8lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664536849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sq16qV9KAC6HhtR2SG4ysqHRgl4G28JmjfBwyTS++Oc=;
        b=oLziVKiJ4TCUaUb+Rhirru0RKAyr6bCwI+NCwTrjHrHjDM4Sj5fPJo8KAbE260ETGaJXC5
        sr6Qlb7NqZsN1jAQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 847A12C161;
        Fri, 30 Sep 2022 11:20:49 +0000 (UTC)
Date:   Fri, 30 Sep 2022 13:20:49 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove redundant module_sysfs_initialized
 variable
In-Reply-To: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
Message-ID: <alpine.LSU.2.21.2209301320330.11771@pobox.suse.cz>
References: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022, Rasmus Villemoes wrote:

> The variable module_sysfs_initialized is used for checking whether
> module_kset has been initialized. Checking module_kset itself works
> just fine for that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
