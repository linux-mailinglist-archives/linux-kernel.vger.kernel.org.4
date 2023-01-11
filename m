Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BB665988
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjAKKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjAKKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:55:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690814D3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:55:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v2so3620856wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RJ2+vogMYyR5gnsFMlmW8P3w570KHe4FHmJ4WhU0lY=;
        b=ebytURdaLisFy7tdkqeP9h4y5Fd8Ob225F/H01t3xyp8EwFXrw1ePzDp//JwMGYDAK
         jn/cF61XwU6t0xtsseay7ehswcgL/CAQBuTBcyL/POuNB5TsBpZgptgrzfMwm7Z0RBfd
         oaSgLPQcN3QR+S9Dn8Sm4KqWXCkL4YjX9kEJ787cOvyQj40PQ58Q8zGZyI9NlzhF6wUm
         gO9sXXc4zgDoggtSUspFE9A24/puATNrldUHCdb9U2aPMnVYCN2bPxz+tGf41QPFDYwA
         ceo04CvCszIZghdxkIsbaah4vzjxXE4dspIA9NWUMRjuxEZz4JfiwvHIj2FZzQM1XdvT
         dYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RJ2+vogMYyR5gnsFMlmW8P3w570KHe4FHmJ4WhU0lY=;
        b=XP60J/3iGyH/QbwU6ef8Qxdaau7eB5zyJKgoUz27Ockc7IQz66SALenDHCqHsOsvZU
         ryIRarRLRX3yNn7Bs4aIBjds1hCJbgIs/e2jts+SKUsYmzmAtjOhqTpOEYfZjH0Ivx6B
         4GG/QcIH5noSNqEgYNZpSt8TjiE8zZH5fybJ8+zfqhT6B4r3qT07RpbHsIBfWXYOEemT
         UlcmVLEhmlRY92qr5Rng7D6zKTTnX8EaNxizCvoFSkEs9xeIVMx+RN5hlCNRH8HU6d6V
         eTb3jXvNuF6vzHsddCAJwLXSpuyQUKCCWvlwNe2I/xnGhzcn+JttA3cjGGVdSNS+8KfO
         enUw==
X-Gm-Message-State: AFqh2kqIDtnr1qef/O6aqgGHQvmqeVE60GiKgZguABxu6Cmq3IY0Bhji
        F9I/kg9Z8Q81wbiPV6E3eV0J6sWRaLtQoVd979Y=
X-Google-Smtp-Source: AMrXdXtMH9OIs2BHiguISvZu18YcEHRP7vSmCjAWLjIUATaoU6E2bS5S633k3a5/Jx+6+EaK4sNeJ09skRVEpAEYzJc=
X-Received: by 2002:a5d:6e04:0:b0:2a3:52d2:a448 with SMTP id
 h4-20020a5d6e04000000b002a352d2a448mr563232wrz.561.1673434536383; Wed, 11 Jan
 2023 02:55:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1866:b0:284:3108:9c92 with HTTP; Wed, 11 Jan 2023
 02:55:35 -0800 (PST)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano pessina <bnymutuku770@gmail.com>
Date:   Wed, 11 Jan 2023 13:55:35 +0300
Message-ID: <CAEfCVcga_32=3hHvfYBxcYjO8BWRr5asFtrd-=3VdgfijLe=tQ@mail.gmail.com>
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





The sum of =E2=82=AC500,000.00 has been donated to you by STEFANO PESSINA.
Kindly get back for more info via stefanopessia755@hotmail.com
