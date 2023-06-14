Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1772F668
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbjFNHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjFNHeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:34:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AFBE62;
        Wed, 14 Jun 2023 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/ux0V+hWpeqZe1y6Lv0wFsb0Uq7wh+rm8EMEdQa6UWo=;
        t=1686728040; x=1687937640; b=XXxC/lfv3V4KdPXsq5JEyIrE7wTw1Whrk1J98ady22jRjmg
        IlaueyK02wtP9MI6kpxIY25I+ShlX6yhThv0dDQeKa8V3lVk0L05nj9jLOYOIyvAmmh7m/zqqN4jI
        XG789tczscFmBnN9m616m6yk19cnASCn82i9l3RQiHbHC26mhOvDj5WyzWGfYxrMjKAKdOnDE7SFf
        z9588qNlH2EVAleKR4o1VC3NQNqDNir9J6qQKrk+9GJpQ93G2NaF7UWMisjrmtAPZtirF/S749zge
        0WriF/r9NKn1j9UIswTsHYtQpTAv4ybPKCWPV7v1syKXYKJMfbP4FS2GohR6B9wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9L0l-005yrq-2x;
        Wed, 14 Jun 2023 09:33:47 +0200
Message-ID: <bb17265969d1850462bd1d89df71d43f6d40967b.camel@sipsolutions.net>
Subject: Re: [PATCH] b43legacy: Remove unneeded variable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     wuyonggang001@208suo.com, Larry.Finger@lwfinger.net,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Jun 2023 09:33:46 +0200
In-Reply-To: <5e1b466986b2371f71f99d7123f1de6d@208suo.com>
References: <20230612044742.58785-1-zhanglibing@cdjrlc.com>
         <2caa7e16691b9cecab28aec323785a35@208suo.com>
         <e598894f5a32c00ff905b010bd8e286f@208suo.com>
         <5e1b466986b2371f71f99d7123f1de6d@208suo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-14 at 13:52 +0800, wuyonggang001@208suo.com wrote:
> Fix the following coccicheck warning:
>=20
> drivers/net/wireless/broadcom/b43legacy/debugfs.c:68:9-14: Unneeded=20
> variable: "count".

That may be a warning that it gives.

> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   drivers/net/wireless/broadcom/b43legacy/debugfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c=20
> b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
> index 6b0e8d117061..55a067eaa52d 100644
> --- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
> +++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
> @@ -73,7 +73,7 @@ static ssize_t tsf_read_file(struct b43legacy_wldev=20
> *dev, char *buf, size_t bufs
>           (unsigned int)((tsf & 0xFFFFFFFF00000000ULL) >> 32),
>           (unsigned int)(tsf & 0xFFFFFFFFULL));
>=20
> -    return count;
> +    return 0;
>=20

However, that doesn't even fix the warning, and it is actually also
completely wrong.

Please don't submit patches where you don't even understand the code.

johannes
