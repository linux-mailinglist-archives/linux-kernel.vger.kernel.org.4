Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053526D8E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDFEfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFEe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:34:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973083E4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:34:55 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n14so37056769qta.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680755694; x=1683347694;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqFvIMuXG6qy2oIHQp9Me/HQZXKmC9KtKVOs/l6KpIs=;
        b=XPo5v/9pkxFa3dQ+GxqN77+yhdLPmc7mBegfNoaFyY/G7+x0vod5ULdyoYIkqYQFdY
         z3DJgcH+PmNu6TrbBKPxLiMKOG7+/yDMLWMJz7mKUVq+tCXn1GL2O7gL4jjECYs/cz40
         qzUjc5y7Bqzeenki/N2ykIq4FYk3o16LdM8tH3oB40SfQvSvV+6egSkWZzm15v+Ttfx1
         Sa8U4aAzHj96mjIxFblhixy7sStCpWbrPrkLGOX+BmGJ0gWLgWc6LnRRBVYHU4LE9RG5
         WkBd6uUSlod9hMkQe54dw6AqmTH3QAE30LquBLIKm3CaSk5RGKTXx8UDPfuNFoBEfpSd
         H4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680755694; x=1683347694;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqFvIMuXG6qy2oIHQp9Me/HQZXKmC9KtKVOs/l6KpIs=;
        b=TuxxuDt7PPJyYuLTjq16yQURQ1gSTpxzvufe6Lp1IVXBXp0xkVTpIsF/bjpNBBSd8j
         SmKxiDz75+76U/uOo+AUba2m87q/jW0ASYQFOuzD3lrQUF9MslaHMl0J6CmndRa4F8NL
         PLimx/xgK6mW2lPIGagyR9sgxNF/zldUKB7cw8ITR12rt6sbRAQoiV5KlainS4mTIkK+
         dyCI3WiSl1nTyflOk9EU1KF6qXFjoCpwJwWJeOxIVrEIRekb+KFkH9TqQb8kTLwJdL3+
         qEmpDrViNNH54O5TRJWuEaZe3LdMwsioNJTdXYCDbD6huyUatRbK2haKnNSRTe7H04Vb
         wu+Q==
X-Gm-Message-State: AAQBX9eHhGwQnV7zDGtRqc98LpHK/vJPkpMQKaciRHwIeHJ6n7JuCLjH
        OUEvcwcaUshXoerfVUUDnFjDizHc1QyWJg==
X-Google-Smtp-Source: AKy350Ymx2SX0kjN7sDlJyB4Ro6eCpf3Q7bkkF3N9/vNlESG3wt4MQk3dhVJFS+ytPOjDZ8C6sMmww==
X-Received: by 2002:a05:622a:104c:b0:3e3:5f85:631b with SMTP id f12-20020a05622a104c00b003e35f85631bmr9325916qte.66.1680755694175;
        Wed, 05 Apr 2023 21:34:54 -0700 (PDT)
Received: from Gentoo ([191.96.227.90])
        by smtp.gmail.com with ESMTPSA id o14-20020ac8554e000000b003e4dab0776esm166681qtr.40.2023.04.05.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:34:53 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:04:37 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: testing for mail address if not blocked by spamaasain rule 
Message-ID: <ZC5L3RgDqQzOIZGR@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a1aF/u+D1xWd3u2Y"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1aF/u+D1xWd3u2Y
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

testing ...please stand by
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--a1aF/u+D1xWd3u2Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmQuS90ACgkQsjqdtxFL
KRU4hwgAvM1Mqq5H7o+ZJhcz3ZONJmIzHYq8oLEYqdvfuhSkaq9KKDKzEh413CXd
6A5EkVeyw+pdli2WGlNjk1lc1fMB+4G+qxYfOfawX8qVex5VgzaBJLWjM24smQAk
Q9ERBeUcA6+2hXm1dWpeOG7o2v8dXXbewx7t2XYhiIsn2Ke7wsIzBPkt99jnrrE7
xIn4lYDEnrScP7iioyEYU1Ic/FSHcwOjlMFLZc9Fygg2E4i80PfwvHb3job51RWB
nCXKv/HUJn2v0/tSjGD3Pl5ewUH9outlNWEqo4Yk6/+YV9scUybNYT12uTMsNprU
OwRqyJrED2PPTc1QLFxqs04/kyD4ng==
=PzMp
-----END PGP SIGNATURE-----

--a1aF/u+D1xWd3u2Y--
