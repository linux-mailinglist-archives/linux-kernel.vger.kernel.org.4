Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185465C4CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjACRLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjACRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:11:26 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562313E15;
        Tue,  3 Jan 2023 09:08:36 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4NmfMM4n23z9scc;
        Tue,  3 Jan 2023 18:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1672765711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XXChUq9cZxAJabA8F5zXFbjsZKkHZn7tcyaZj5xUcs=;
        b=BWsg5eCALMPxw1BU3MeHdZmI2S7ZNhHdx994rcUxw/T0w2z5awOrF2H1sJZw5bpJN+8vHh
        ZVLZFRhxHrghcDyCRzMk3E0u2oFXrLzpSI6RqTtoTYqDdtI+OIflh2zrPcTm8vREzrJOPr
        EpxfFvpFBta3+/UZaT9oF7oUn0NhRhV/eNkVZog5hZJkDQihNgtxYID0evFdBIUs/uorCH
        1nh7PygsL+vJWnWWVcSmmLZ/ee2A5FUJxenEtPZCXrNYzbQPAuTiGg3TYMdUKXmVu+TP44
        wWPg/nPC557sB5lJfTOwlJfV4/5hbKuqUVk8mOsjBnS8kiroFENC/ZX9m/fcbg==
Date:   Tue, 3 Jan 2023 11:08:27 -0600
From:   jstrauss <jstrauss@mailbox.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <20230103170827.ihl3aqjmz4ohzowk@libretux>
References: <20221227223131.um6muahhxbom7crg@libretux>
 <Y7Qe3Rx+9jzdK1g8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Qe3Rx+9jzdK1g8@google.com>
X-MBO-RS-META: csi3bt83eeuecfdoz794tybd1pdjxufk
X-MBO-RS-ID: f6d9d50a1e8cb8b9e6f
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/03 12:26PM, Lee Jones wrote:
> Also, you will have to resubmit your patch please.

I have just recently submitted a newer version of this patch here:
https://lore.kernel.org/all/20221228010958.9670-1-jstrauss@mailbox.org/

Joe
