Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6740621840
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiKHP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:29:21 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0F10D0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:29:20 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13b23e29e36so16586732fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9i29hKC558luL+ije/Z+4OQ5bKnyF8zYP/+J9mb+xx8=;
        b=jt0fOY18I/NuC1Y9B0+x7/HbHG0S5n/hwlS2TpAd0vBa6w3Oi6bP5Dy7pDRloR9JSH
         0qED/R4c72+gi1j3CWY5VWHZ3EP2coqBN3f77FWdsAKZ2qq1nHGeOr3kixISYo1bNJdD
         TrGUi0Rc+RPWxQ8yacE8wMr4txokohUAjGyl02UquZlKXDm8KFqT187I2d/bqzw8ERCg
         xCb7YQwFBdz5acApe4/tVvHVUpZBowW5kKzNzv7wKffXfh0LmxJbxieCygGneHAgten9
         Hga6zxU1COhrUs43IbKzMoEprfAq2mlsMqCLCYoqCuOySO71AAFuw9Ns9t/CFric6imd
         SNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i29hKC558luL+ije/Z+4OQ5bKnyF8zYP/+J9mb+xx8=;
        b=6Q+Dt4ipMfisj8HLndJJPzrBGDVt93JSc9WLWjEegiD3VD0eTRTgnVjPADA4tlwS/K
         H0srS0TIjXBQeW/vbScqFZ447sXZPaVOafBhlWu9xVlp/UPS/LKDjEGxZS0baDOfeaV6
         uINsFYDXnRsLpGfK5Vcepp8PoCq4HLikQ99xl2PBlp6a9yExJ9A+PH97kDNBIRr+DFwK
         l/Gx0FLRlnjfFHsldxb0Knx9AxHhV/TiQ2/7QkI4QxVCEvz80BKwN0nNr7XXCwuhilNC
         rMCPZMMKNL2l6LcvRcxirOu4iw+LmZagxKSCs3EkOEwitt+6491fG+M/zIGQv6K19XK9
         1DTw==
X-Gm-Message-State: ACrzQf3oYiBH8g+nM/+8CQ9XFaAaA2jq/u3TvOD7Q4StZC3aevjXRBf7
        TsuyCUbynO+XJM3XKiR3pqZ2mQPVSskQ9ttSiuk=
X-Google-Smtp-Source: AMsMyM79CzNuRDpGiuO44PrC56o0Z8rxOEvV4Hi4OBCb8YfjaGYV+l+WKhM9H/c65qxIR6fha7WEg2ZYm64OmRdZ1B0=
X-Received: by 2002:a05:6871:b13:b0:13b:1e06:493d with SMTP id
 fq19-20020a0568710b1300b0013b1e06493dmr44586398oab.247.1667921360082; Tue, 08
 Nov 2022 07:29:20 -0800 (PST)
MIME-Version: 1.0
Sender: marchallthierry@gmail.com
Received: by 2002:a05:6808:1b21:0:0:0:0 with HTTP; Tue, 8 Nov 2022 07:29:19
 -0800 (PST)
From:   Miss Sherri <sherrigallagher409@gmail.com>
Date:   Tue, 8 Nov 2022 15:29:19 +0000
X-Google-Sender-Auth: vL_j-K9RmA3y-a4tTjMipy8PK5o
Message-ID: <CAN3qK0Vo+wWzGLfJGte5B7Bn-T_nW7c1+4aUQMLeOwWBVawZ4w@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Szia,

Megkaptad az el=C5=91z=C5=91 =C3=BCzenetem? M=C3=A1r kor=C3=A1bban felvette=
m =C3=96nnel a
kapcsolatot, de az =C3=BCzenet nem siker=C3=BClt visszak=C3=BCldeni, ez=C3=
=A9rt =C3=BAgy
d=C3=B6nt=C3=B6ttem, hogy =C3=BAjra =C3=ADrok. K=C3=A9rem, er=C5=91s=C3=ADt=
se meg, ha megkapja ezt, hogy
folytathassam.

V=C3=A1rok a v=C3=A1laszodra.

=C3=9Cdv=C3=B6zlettel,
Sherri kisasszony
