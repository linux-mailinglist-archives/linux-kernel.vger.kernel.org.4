Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C964C418
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiLNG4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiLNG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:56:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726D4186D7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:56:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w23so2369648ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKE88QtgGJgv8d1/Wb6M77477MuPZk35pDMels8C3Ek=;
        b=S4AX3dvEha5oMubOoQK6b7JZp+RnmglxJ0toFV1gNihvjDZMnRwE8N3vS6jfrINHEK
         cWk3LonXEeRL87z7a+F/lL1FEt8B+1efHLdDO47M4IQ9TZfTLPyGM/fY7xMTUsNVQBri
         ownH/veq53nXqgG68QLDSlrOxJVkDsk49s3HELCnPYTDN9BEHIDgCD4eX5J8I+/8nM5q
         JjETZpLVCVz3GI0ybl3TxwzP6xkeQ/fyGmk5IVnfyXkOjYaTu4EV7i7wtnAL4IxUmSVu
         C1Xl19jBFxrAw4rkz1HALl3P58oySk24C64nP+Z7cJ3mjNYzIwqUQl/eDSUFKl34Nytf
         +9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKE88QtgGJgv8d1/Wb6M77477MuPZk35pDMels8C3Ek=;
        b=w/98PPpm0NSsuoN6VAjk/HRSrzQLs+L8E2R/Jt8alM/dcYAjYSsCpCTPD+oO4rzOCN
         j00AKIpJmOfSP4CM3kMiy6mhpURSzRQkwIX0wXt0PMrbXIDqdmPP2XM78iB6m1FeGhih
         GMH9gbwXJZux5HJ/VhG2WUGx9L+CQEQNa3n2htHxeZlLQbDdmXUND4qXB2Ac34G5XPdZ
         UqkFvlPzYuReHD+agXH4m/y3iOiFkc9vTsSDdsmUvfctOkAp6MmbycLwuAh3H5A1uC79
         y3PeoSkAlvW36ivcoNF+VjYSP4zIT3tz43d8fj4yrenj3E1rRVUIr+VsMuqR93Y1gXhk
         8ldg==
X-Gm-Message-State: AFqh2krD1k7Ps+wCy6DAtWOXLaXXO2up89rAHu2WQ180EUD6CaZjfYv5
        dv8pa2suHM9Gtm98iZ3gfxBRKVvzRD1oewwIit0=
X-Google-Smtp-Source: AMrXdXuruIgTAJ8cu29cpmDykjaRN7NZlH1q/I6bvReF9TreFVFOIW1dVopdxWi4y3cMYuJ4eXCIQQ9nlVbxxMJnhIk=
X-Received: by 2002:a17:90b:3a84:b0:218:8759:f159 with SMTP id
 om4-20020a17090b3a8400b002188759f159mr171557pjb.32.1671000981731; Tue, 13 Dec
 2022 22:56:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:818c:b0:89:73ea:7291 with HTTP; Tue, 13 Dec 2022
 22:56:20 -0800 (PST)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <allyfaita22@gmail.com>
Date:   Wed, 14 Dec 2022 09:56:20 +0300
Message-ID: <CAORs_C7-ZzAirqX0BWZBBY_YrddMscrVdGCpg+Mv3B9Tm7MOAw@mail.gmail.com>
Subject: =?UTF-8?B?ZG9uYcibaWUgw65uIG51bWVyYXI=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

--=20
Suma de 500.000,00 =E2=82=AC v-a fost donat=C4=83 de STEFANO PESSINA. V=C4=
=83 rug=C4=83m s=C4=83
reveni=C8=9Bi pentru mai multe informa=C8=9Bii prin stefanopessia755@hotmai=
l.com
