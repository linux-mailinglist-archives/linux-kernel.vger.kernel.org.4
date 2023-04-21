Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF06EA790
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjDUJtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDUJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:48:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428AEB6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:48:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38c0a331d3cso1148038b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070510; x=1684662510;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7dCMSjJGAVJYULPoH8k/oYToGR+HAi8zsg4GGXON8+w=;
        b=JvHiLX433kxJhabVkljd6QnUf06nXuVMGBzO492RGxToEmlXUpcgiyEK75urzLP6cF
         Tw+VjJcN8DCTxnuR3Jfl+HDK63Sms/2wr7wMa0DgV1F33I3LVQcvd/x8//IZ8fmqZ4o+
         q7HepGqTHeQOaAD8e0sTu97YTzdhzRa1yMzknwzWIe6xKaGpIFycRNeQy2358EL3Dty6
         L/IcSLTVKNqpeWy8YZoAvD1YqNPtqefa8Cb+cr/RSVHh2AYovo95T0WxSTh9Sb0Iw0TJ
         ObvF1Sw3nEVB1wzVFioNz3ck5eyamQjDkQxERq2urPkJ0e536JKg509Fpa0dwHoRdQKq
         tEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070510; x=1684662510;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dCMSjJGAVJYULPoH8k/oYToGR+HAi8zsg4GGXON8+w=;
        b=PQi3mhGlPv+fOFdyu+jy0kF1BIs8hkebA1JBLL5vom7+3R9kxt4C8xtQcAO69SQSb+
         ZaZSJ22Vq2LELbRPP8OSHjvhGFBYqkg3EpmHJO6zM4QfZ1PqzpjNeBqa8oZta7KndurK
         1BS+UYwGWoD/BZ9rHJ0a0kGqoSp0WLaPOGK+YhsPZgSNyrY7soiJ79cxLDn15FyOsrTr
         ZhBkIPfXci8RdFZfmu7p/5G/iSGBBvyYWKP49w8orR9v+DLDZv0hzvOYmyL8meS+bEQb
         ApdvVfJjLyez/hAz6gSosTeNQ6Ohs61nk7XbCIhZdNG3VHj/0YsblhMh+5X1lM/G6B28
         M1Ig==
X-Gm-Message-State: AAQBX9ehUca+T3I8Gq2j+/IKs4MHrJ22S6i0wI0cCt1c1JtARpqs2Tqq
        5YC6Q8hAfg+6NfBuhbmM8hE5I2DnyOjXsFcQWSI=
X-Google-Smtp-Source: AKy350b9Y1SN3tQoXcrhF1HZa0E3vbmD7H8qzZJPgxbQHOKO+ZWn962eT624EEGc+ZJ2VekAA4WIelaAu3D07UpWz9s=
X-Received: by 2002:aca:2315:0:b0:386:c61c:555 with SMTP id
 e21-20020aca2315000000b00386c61c0555mr2536859oie.2.1682070510626; Fri, 21 Apr
 2023 02:48:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:4795:b0:11a:7816:60e5 with HTTP; Fri, 21 Apr 2023
 02:48:30 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <mrsblessingkoffi04@gmail.com>
Date:   Fri, 21 Apr 2023 11:48:30 +0200
Message-ID: <CALh=pzXDwdYtP1P0QocB4HgtGDH=TES2enzvhK_-gnpZmLPoyw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150NCg0K16nXnteZINeSJ9eV16jXkicg15HXqNeQ15XXnyDXkNeg15kg16LXldeo15og
15PXmdefINeR157Xp9em15XXoteZLiDXkNeg15kg16jXldem15Qg15zXlNem15nXoiDXnNeaINeU
16fXqNeV15Eg15zXnNen15XXlw0K16nXnNeZLiDXkNeq15Qg16rXmdeo16kg15DXqiDXlNeh15vX
ldedINep15wgKDguNSDXnteZ15zXmdeV158g15PXldec16gpINeT15XXnNeo15nXnSDXqdeU15zX
p9eV15cg16nXnNeZINeU16nXkNeZ16gNCteR15HXoNenINec16TXoNeZINee15XXqteVLg0KDQrX
lNec16fXldeXINep15zXmSDXlNeV15Ag15DXlteo15cg15HXnteT15nXoNeq15og16nXnteqINeR
16rXkNeV16DXqiDXk9eo15vXmdedINei150g15DXqdeq15Ug15XXkdefINeZ15fXmdeTLiDXkNeg
15kg15DXlNeZ15QNCteW15vXkNeZINei150gNTAlINee16HXmiDXlNen16jXnyDXldeQ15nXnNeV
IDUwJSDXmdeU15nXlSDXnNeU15nXldeqINeR16nXkdeZ15zXmi4NCteQ16DXkCDXpteV16gg16fX
qdeoINei150g15TXk9eV15Ai15wg15TXpNeo15jXmSDXqdec15kg15vXkNefINec16TXqNeY15nX
nSDXoNeV16HXpNeZ1506IGdlb3JnZWJyb3duMDAwNEBnbWFpbC5jb20NCg0K16jXkSDXqteV15PX
ldeqINee16jXkNepLA0K157XqCDXkifXldeo15InINeR16jXkNeV158sDQo=
