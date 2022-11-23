Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7406361E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiKWOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiKWOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:33:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470012665
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:33:19 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t10so21648149ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9i29hKC558luL+ije/Z+4OQ5bKnyF8zYP/+J9mb+xx8=;
        b=Z+yKhDvaZRD31W/63u7XrUkknX4Aa0JiVAUuiTP8clGLQTLu5qPC33Fojq4DKKxf0y
         pl4gzYpgVsUcP+sRcR9QNmJWxyXIQzyDtIvCsUDHa9yzY3TuIKYyIzQCLq5NbVQjXbbJ
         vwoynz1b4O8RXNPRXK7uv0J/yvY1o0vTJbC/Lozwo4hqvsq6uB0hJzOrFwlpKGbiCoRe
         b4bDRMD4b29EMd10Cp2XGhdhPpq388Oak5rA4AsMlH1JKCKVLH8UKbmT4dD9x1QkeP8B
         SvtpeTF2aexCEBo5UyJRL8W9OJLt2MidgGxfIAUWHeEDUEICKL0CspaLxywzrCNDyUgI
         kUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i29hKC558luL+ije/Z+4OQ5bKnyF8zYP/+J9mb+xx8=;
        b=EQFwfaTZpyAI92qtBw/3TslFHirZhfMxH98YWfdHDwmbGeig+DTXYoMQg+nszNW3Iy
         h93v2OWiRAy/MHkOSoeEQXA8R6oEVBSlrLa9nkeaezk2u3xvZpv1S6LnIXn+nH0MXOqQ
         bRQGK0+dYvMzv15PEVC2smTKX4+AQwbdNQc3qOORqXDcd4hv06BeA7xAU03h2NEDwj4F
         AGj0ED5FYbrUMy3LjNpPOfoHIW1qlIRfe20fyvSfJhGp5Y0VrWB/6r/yr3w10QHmmV/k
         8mCPkIw7fqF1fF0PLEuxju0ywLjX0zC6TDFT7dslS9DxEmrJDyfzdUBYXFTY8a+jLGO3
         bVgQ==
X-Gm-Message-State: ANoB5pkAeNBGexXjrXUFrgUi5UHpmpdB3/hPXi/qBKSEMY5alA/4ve0R
        OZxq9Bp1wnoV1xGwRq7mfcLptkZnTyX4joD+JkY=
X-Google-Smtp-Source: AA0mqf7F2JkuQVJ/Ju5QBTZIvTVQD8FceFUmv8Z0iLRb6C/1OphyjbM3f5Le393kMm+eOnJ8V3omHkKjuNlbFbaxwTA=
X-Received: by 2002:a2e:a552:0:b0:278:eef5:8d13 with SMTP id
 e18-20020a2ea552000000b00278eef58d13mr9020196ljn.56.1669213997471; Wed, 23
 Nov 2022 06:33:17 -0800 (PST)
MIME-Version: 1.0
Sender: abelmouhamedfolly@gmail.com
Received: by 2002:a05:6504:80d:b0:200:b618:4d44 with HTTP; Wed, 23 Nov 2022
 06:33:16 -0800 (PST)
From:   Miss Sherri <sherrigallagher409@gmail.com>
Date:   Wed, 23 Nov 2022 14:33:16 +0000
X-Google-Sender-Auth: wKYDAMoEugjMOvC3rDNNtOf8Al8
Message-ID: <CAF5EFSrPeVmh=Lvvf=y32g82kCLNSi68L_VH8K=BThAF7c_HzA@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
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
