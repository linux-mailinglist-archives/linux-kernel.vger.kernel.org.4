Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29E7385E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFUN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFUN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:58:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82516199D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:58:15 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17DDA1EC0102;
        Wed, 21 Jun 2023 15:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687355894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AqXqCwT8601+wX7x/MzKVxUk1eR8+dlSANet0W7tTV4=;
        b=TksNZUcQ01hfar/C9QxcsLNNMPnD5Y2naxjHpEG5mtgqAEV/3N6Cu6g3KJWOh+B5yCLdIf
        mIoT2dl8PHVyJ3edH2nd0J8Kik2oP47oF3PFsULKIjks0V9yQs62JYfWkOMK5p7vlqo8TJ
        OkDmOFWGn1NQKjg1BI+A1fOBcPEcDoc=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hi4oIO-y2c9a; Wed, 21 Jun 2023 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687355888; bh=AqXqCwT8601+wX7x/MzKVxUk1eR8+dlSANet0W7tTV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yg82FnwacpC2Xcth5GmyY/sHgD9zfzZbXwgR9f1s0cmhpAy3vDkICo5jfqqCcFkQx
         /HG4N5kQ++/c5ijxET91Ovp5aDWaFu89/rQRp6jD3AHS+nZfpFX9wM+ZgozF737/db
         3K2JSGuJfyJzMEuOkxfl3n1c/rnY658jKFz2ExQBq/rthJvRurp+BxK8yN80lUdCDb
         satoTPN0OZcfz/pzD52GjOVDOpRr9di0CJOgJpZQeazzQRAapQZ/9DqcsN17wJS2mH
         q/KGU+mMd3RUygFq0hvdK4uJE/Aa1SSu/3E+GVpfVeoiOkRG1LqKWdpKCBOVt4zQme
         gSu1GqfDzKSkt1/YymVN0UR/5gs6rNLXdHhTJYSpTS1sxQ08+x2ljIxg1ght+UWpIP
         XfHjapwMKobf2DsOrmHU+gxJ0OwvpUDeumKo4PKDIKh4sbxVANUoOlngsCpUj6UIJX
         NUaBjYwcH5i7dG6MG6KpgxeyXdLdrRNLKDkQR0zs6uuwaR2gO03Mv8DGDJe2FSPJDW
         WhJhzMM2zMTLCWoJk2br9QP2m5C8vO+RLECw+MVTXV4JzK2SUvwwtMhY4qK+y/8b9e
         sMtSptkRPiXUdIHOnEvkk1jt+qnkhvgQNHQruV+Q0fSiXl+v1cOz5Qg7NWUqBFiImz
         0iDNkRqD0rHzm/k1F5E2iP6A=
Received: from zn.tnic (p200300ea971dc565329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D48640E019B;
        Wed, 21 Jun 2023 13:58:04 +0000 (UTC)
Date:   Wed, 21 Jun 2023 15:57:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
Message-ID: <20230621135758.GJZJMB5lkIt9b6tgdc@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
 <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
 <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
 <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
 <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
 <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
 <20230621130955.GHZJL2o771lIEPURUl@fat_crate.local>
 <29beee7faf370ea892cb4e5a85ddd1f7ee132164.camel@xry111.site>
 <20230621134645.GIZJL/Rf1IdeLMQGl2@fat_crate.local>
 <e7113e249fa0fc1f259408c9f97655ec199dba5e.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7113e249fa0fc1f259408c9f97655ec199dba5e.camel@xry111.site>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:47:36PM +0800, Xi Ruoyao wrote:
> Oh s**t, I'm completely stupid :(.

No worries, happens to the best of us.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
