Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6598568AF7D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBELMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBELMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:12:31 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9551E287
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:12:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bf19so9451938ljb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dqZWvkSJWN5NuJvNVddPjyRIjY2ImtBCuIdITn3pMZA=;
        b=XbEH8w0xY/skS4GdJSMydKRypbczol6kGALiJNBRbP/IRdWUISDzel8S4RTrEvAThi
         xs9UIrpgqQ96whjlfLNALk7JVtkZekzMIkPS9F5FGWB2OksqqEMrihVW3eVXq1C8X/jc
         5TBI7HNpVrWKnxd+E4HYTYqgi9gGE9D4EtNGKn7RgBzta3rfGcElUPoBo73VbIxWwibx
         ugtm5xfUSxjqQr1LutwVipZlZVfPa/Kv21qEUhLGlaBYCbe/1rnioPJMqPTsgayVms2F
         FjNlT1B1EF89wvx85gjO3bYsVmDfyeTklbRjO0rVZx10F5bT+poZMTJSKdm3ElwDhaET
         QR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqZWvkSJWN5NuJvNVddPjyRIjY2ImtBCuIdITn3pMZA=;
        b=rtRY168fXMxDbmjCedrAIzfOi0OQj2Q408hH0oZZjh1UyRxgtq04aeQ4oxGEhIQ7Ll
         L3yGVtQkAg0vGJubP9k9hVxr9Ej9CiS2mviMEvFjIHLWINh47fzWbKIuzSDrdBCllfJ0
         SaPakmwZn2yup+7W2iEy2f8L1F10D7oTMXNMuHv2z3S2dA3BAoyadjiAx9RDUeNIKKZc
         h780GwQ6g7NuGCDdhldWol/g6qo8LchZgFxzzHeDJ7T5j65n5G2medtYe+AMLALdrmws
         AnIlrbdcbY0nMlS1Ga1ayzQlci1l2zcHXjxJ1xDJD9uJsumY8TKIFV6bH1tVmGAXxDG8
         djyQ==
X-Gm-Message-State: AO0yUKXi7rFvVJ4ERLy4wXmfSqa4MzSPMna3/bWLQK/ZXImpP4MR+ffR
        kLtHThazQbSHTjf2o/RUX9D5HmU4jp0GCOy0b84=
X-Google-Smtp-Source: AK7set/g0/RNsd0vxb0YHfUwE+sevpLB1QHnH+kUbTLDgoCuAHH+1sJOBSk8/xNkbz0AQPvAdbZ27LNhVPpaWK3VHN8=
X-Received: by 2002:a2e:8802:0:b0:290:6531:39ab with SMTP id
 x2-20020a2e8802000000b00290653139abmr2855761ljh.73.1675595547799; Sun, 05 Feb
 2023 03:12:27 -0800 (PST)
MIME-Version: 1.0
Sender: orinjulie89@gmail.com
Received: by 2002:a05:6520:2e0c:b0:23f:4117:228c with HTTP; Sun, 5 Feb 2023
 03:12:27 -0800 (PST)
From:   Rose Darren <Rosedarren44@gmail.com>
Date:   Sun, 5 Feb 2023 11:12:27 +0000
X-Google-Sender-Auth: n5CLWvtCnVWrKHMuMNvDHtUJkBY
Message-ID: <CA+fiOCfgEwszm9mSc3XbTkThtHKHEqLy9QgZ_J8c4m1c4f-maw@mail.gmail.com>
Subject: azq
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO YOU SPEAK ENGLISH?
Ar pra=C4=97jusi=C4=85 nakt=C4=AF gavote mano =C5=BEinut=C4=99, kad gal=C4=
=97tume daugiau aptarti?
