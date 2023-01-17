Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53F66E150
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjAQOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAQOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:51:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4A3B3DB;
        Tue, 17 Jan 2023 06:51:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 453B0688C5;
        Tue, 17 Jan 2023 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673967108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTVeN2Bi9Z9fSTLDdrvLfcxsXOF6CNTVmA7ARmZ4o3Q=;
        b=qxg4Q5qN/+xs80/V3voVIOMVPWX4qnwvTIgAzVkzlaCbfjTbCP6NQBf4gcCODirCddL58d
        7QZojPW59Pj+DfNqtFUoRtttKoqNuuwvdImH4VDkjDLlwnoX/n9HsqoqRtvHmwlrt1X5Pp
        lV9pA6pyFNMtVFnDTtOVOaAFOOXvO3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673967108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTVeN2Bi9Z9fSTLDdrvLfcxsXOF6CNTVmA7ARmZ4o3Q=;
        b=HBpePNQTd+YVmdzaVz+mdNDmd0EXkdiNXWYxPLfPzD2CgdpqN8H8ZLzyh12Ij/90Pyjzy0
        jHRaQh0p+0wKjbAA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 226142C141;
        Tue, 17 Jan 2023 14:51:48 +0000 (UTC)
Date:   Tue, 17 Jan 2023 15:51:52 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     linux@rasmusvillemoes.dk, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] kernel/params.c: Use kstrtobool() instead of
 strtobool()
In-Reply-To: <a0abd4f77374428bd3c9dd8b69b2afe52544c994.1673687215.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.LSU.2.21.2301171550500.24433@pobox.suse.cz>
References: <a0abd4f77374428bd3c9dd8b69b2afe52544c994.1673687215.git.christophe.jaillet@wanadoo.fr>
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

On Sat, 14 Jan 2023, Christophe JAILLET wrote:

> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Luis, will you take it through your modules tree?

M
