Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EC6D85AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjDESHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjDESHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:07:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BE7683
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:07:10 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2C281EC0104;
        Wed,  5 Apr 2023 20:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680718013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IruhkEGZZCoFzKGgFnTGC1NJqEOuwMvRvEbYMgFxXUc=;
        b=eHH+9g929JkpCyAzbzKst67IZsNmNd2C26rlAtkQ8eniAIWhIuj158xXsqIjso7oQolSeh
        3+nnsnsI12CiKDcLjy5ZY65XKBKt0FDvxfXqdc+PWOs7aMf1zdo7D2O+r/2WURNyA59vea
        0tOugR2zfWSfGVlRuU/5H8Eh+fOjHB0=
Date:   Wed, 5 Apr 2023 20:06:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Message-ID: <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:36:40PM -0400, Yazen Ghannam wrote:
> Yes, that's fine. Should I send another revision?

On a second thought, I think we should do what you said in the write
function too. Because the write can fail too. So if it can, we need to
handle that potential error too.

Care to send a new version which does this check in the read and in the
write function? Basically what you had initially but with the write side
check added too to amd_smn_write.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
