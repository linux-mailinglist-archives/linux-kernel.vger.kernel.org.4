Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18656FC185
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjEIIPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjEIIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:14:53 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F098;
        Tue,  9 May 2023 01:14:52 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so5303033a91.2;
        Tue, 09 May 2023 01:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620092; x=1686212092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZJaCcrG3WkS6P+WY8HNquPOtmx7oDilaWUheXN/6Uc=;
        b=PGW5C6CJzZo/3gjB6pzHbMH2nwDefHZEiw7sHIN90e5Lx1vuIKur0QU8il2ztlpj08
         XVgaCGwqO10hxELUxIxQBzY9OI94OnSNjid+jKL6gfvtK9r5hIt8fB8RnO/VxW5Lg5kO
         OJbzXkaupZEA3iSpAB9QJvxvpQJDdNKYrn0n1axBgLsnSCGNofcuEOkUhfVsdb3VMd8j
         HAGPbk08l5+GuZcLSrrHmcRfYhdNdDFohzkRH3XWn4OSol4Ww1auWN5/KZ89plpMbVAa
         vOJ4NMXbVUT5OH9eg5UfeP7QzZzETV8IPzCKA+CivV7+Qh+A7mwgczeYInXfX5/YVJTA
         84Rg==
X-Gm-Message-State: AC+VfDyvhPG4YvYfuH9eiRCf+M4gB2GXNEXh9qWO71EGWTURCu82VU7l
        GVGge2frHNzNoIi7Rnrj/9sz9j0nJn3tQjOhEjX/YN1Hfzc=
X-Google-Smtp-Source: ACHHUZ7Gn5qMvzm0s0ZGKu9F2tKjuRsw+zEOiui58vsNB+7CKE8uPZ8/TaO3UKvuOFLppaGhpbdYuZtwuSNwKM3gBRU=
X-Received: by 2002:a17:90a:ab81:b0:24b:a860:a09 with SMTP id
 n1-20020a17090aab8100b0024ba8600a09mr12838101pjq.49.1683620091774; Tue, 09
 May 2023 01:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
 <CAMZ6RqL42d04S-pKuMEEMwd0ZoKhrHc2EDci8fv0SoSJVTf3Hg@mail.gmail.com> <20230509-helmet-oozy-c1136e384d2e-mkl@pengutronix.de>
In-Reply-To: <20230509-helmet-oozy-c1136e384d2e-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 17:14:40 +0900
Message-ID: <CAMZ6RqLh1kQvCaGwjOS2fQuLAVuF_XJyAEqLtS89ufxBRhXvWA@mail.gmail.com>
Subject: Re: RE: [PATCH] can: length: add definitions for frame lengths in bits
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        marex@denx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 9 May 2023 at 15:50, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 09.05.2023 13:16:08, Vincent MAILHOL wrote:
> > > The diagram in https://www.can-cia.org/can-knowledge/can/can-fd/
> > > suggests that IMF is part of the frame.
> >
> > ISO 11898-1:2015 section 10.4.6 "Specification of inter-frame space"
> > makes it clear that the intermission is not part of the frame but part
> > of the "Inter-frame space".
>
> For this reason, it is good to have open standards...oh wait!

It is open is you (or your company, wink, wink) pay CHF 187:

  https://www.iso.org/standard/63648.html
