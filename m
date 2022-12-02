Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC96407D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiLBNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiLBNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:43:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5098E96
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:43:05 -0800 (PST)
Received: from zn.tnic (p200300ea9733e73a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e73a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D27DD1EC081C;
        Fri,  2 Dec 2022 14:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669988583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QOfot9XtOv+EtbLeAcn31z7GVqdtaj7ePsgNf7RUhYc=;
        b=qPNIKGUuoP+1sZWnHNRz4X8mtptFzUn8BLHoGHiPI1VnDEY2JQGxcU7S2YqUo7U6Yvgh1Z
        29dfJemnh3inWi/tEbIdQS8mYxMR0xOYsSfQDuXhBtZmKeU+cyIJvTWlirwaMpAOTjZ6hY
        fcBxu+fI6zRhVZ4uPs1XZx/FNlbbmME=
Date:   Fri, 2 Dec 2022 14:42:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest
 request
Message-ID: <Y4oA31Nal+OVoAfB@zn.tnic>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-5-dionnaglaze@google.com>
 <b332c967-cbe5-891a-3d15-f9fbb514d8e6@amd.com>
 <CAAH4kHY-zq_WrZK1-Jne8LURwY5K_6orK3NuZbVn9u+gwQdN=w@mail.gmail.com>
 <CAAH4kHaq+vNRkQRA9WX_V+R_hoXn3SKcRfJcyd2ddJqQ8ZzmkQ@mail.gmail.com>
 <CAAH4kHbptSSCyPERr+3VejaJrBnsc1QKYLwTVPS=SYkNq-YTMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHbptSSCyPERr+3VejaJrBnsc1QKYLwTVPS=SYkNq-YTMw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:18:17AM -0800, Dionna Amalie Glaze wrote:
> Confirming with Borislov, since you've queued "[PATCH V4] virt: sev:
> Prevent IV reuse in SNP guest driver" for inclusion, have you also
> queued this patch series? The IV reuse patch without this patch series
> will cause host throttling to render the guest unable to use
> sev-guest.

As Tom said, the relevant patches have Fixes: tags so they will get
picked up eventually. But lemme go through the set first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
