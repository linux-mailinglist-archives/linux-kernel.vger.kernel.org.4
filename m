Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1988461F3F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKGNGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKGNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:06:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629F17078
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:06:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n12so29848381eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huVRBaBa1UsBmB4k/zxht1N9AGT1Vl1CB7EEZBcTDjM=;
        b=eiSqk8Ye5man3Th2qiFioZ4ZOY6Qc29FxQIvvuN/kq68Ht6CdrocisTuNR7PX8PjIJ
         HgRhBcmtIpJgpu5SVOhWzNlyz+iFSQFLV/wO8CDXXQqIJFfkjMAsEbqMmX9BdfpayH+v
         ERWZ99xgRM6fUOLuhBah5vHXJaS/Pfkh4DtSq948Cgv0xK2dNBHSURSRYaUBdintB9SC
         Jbs6s3oNHkskiOJLY5Kp2GyM/+Mq3nSf7cjedBrMD+OOGhFagGoTwX/ggMQO2QewNV+b
         UlGh16vSWdaHeJk5gK23MHeqki3e3UvdtIM/x8eL7BYp1cb44E2zHWZEQT1wt0zHqSk9
         SxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huVRBaBa1UsBmB4k/zxht1N9AGT1Vl1CB7EEZBcTDjM=;
        b=CPjFcJms+cmSIXVJ673kBwWiDEP+qVuepoxQMtD2T2WHn9ncPr7sJtSeaVghkRUP74
         WCL+jALyCC1Dqy9umzes1KObd/wu5K6lqQgfafm2mF77PxMGSscKrtWczPx2U1vF6wye
         wxXKAEtdR5fOUWytKjFoM8TjXhYNkOJBe0qjMJWihvW95OUAreAEhNNiXdHFQPuLP+G/
         fSkzJiPgxxwkORLdnFAESnU4gyPGueQF/TMbrz/+u2n9XoVnjp+HbQ76NGEBhYTHiyMi
         sC5iENQZkLtvF0HrT+5lqzkF0AiKypHAdHNh2ug0cvXzrC1HQVoUOO/WQ/xdWjrGEkE2
         dt1A==
X-Gm-Message-State: ACrzQf0zt6QcKtUDr942/NxEEu2soIwRMScj7IaOS9j+I/G1+dRtAStA
        Hw0J3m5K4CaVJxDg2oe61QkjtEAeuo8N8LT/r0I=
X-Google-Smtp-Source: AMsMyM4uXrYhxSazFeNfSyfOu24I/xIGtPVF5BrCDearJSlNEW3UofEQBoaY5Ug2AsEFs7Px69v58cwpLCk5kaUk2ok=
X-Received: by 2002:a17:907:3186:b0:777:3fe7:4659 with SMTP id
 xe6-20020a170907318600b007773fe74659mr47890440ejb.336.1667826407036; Mon, 07
 Nov 2022 05:06:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:c41c:b0:5d:21ac:12b7 with HTTP; Mon, 7 Nov 2022
 05:06:46 -0800 (PST)
Reply-To: georgebrown0004@gmail.com
From:   george brown <eddywilliam0002@gmail.com>
Date:   Mon, 7 Nov 2022 14:06:46 +0100
Message-ID: <CAP8Jzx+nfPH17Ukk8ZhKD+p=4iddy2DwqYpD5A-Utfhg=SP5Zw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150NCg0K16nXnteZINeSJ9eV16jXkicg15HXqNeQ15XXnyDXkNeg15kg16LXldeo15og
15PXmdefINeR157Xp9em15XXoteZLiDXkNeg15kg16jXldem15Qg15zXlNem15nXoiDXnNeaDQrX
lNen16jXldeRINec15zXp9eV15cg16nXnNeZLiDXkNeq15Qg16rXmdeo16kg15DXqiDXlNeh15vX
ldedINep15wgKDguNSDXnteZ15zXmdeV158g15PXldec16gpDQrXk9eV15zXqNeZ150g16nXlNec
16fXldeXINep15zXmSDXlNep15DXmdeoINeR15HXoNenINec16TXoNeZINee15XXqteVLg0KDQrX
lNec16fXldeXINep15zXmSDXlNeV15Ag15DXlteo15cg15HXnteT15nXoNeq15og16nXnteqINeR
16rXkNeV16DXqiDXk9eo15vXmdedINei150g15DXqdeq15UNCteV15HXnyDXmdeX15nXky4g15DX
oNeZINeQ15TXmdeUINeW15vXkNeZINei150gNTAlINee16HXmiDXlNen16jXnyDXldeQ15nXnNeV
IDUwJSDXmdeU15nXlQ0K15zXlNeZ15XXqiDXkdep15HXmdec15ouDQrXkNeg15Ag16bXldeoINen
16nXqCDXotedINeU15PXldeQItecINeU16TXqNeY15kg16nXnNeZINeb15DXnyDXnNek16jXmNeZ
150g16DXldeh16TXmdedOiBnZW9yZ2Vicm93bjAwMDRAZ21haWwuY29tDQoNCteo15Eg16rXldeT
15XXqiDXnteo15DXqSwNCtee16gg15In15XXqNeSJyDXkdeo15DXldefLA0K
