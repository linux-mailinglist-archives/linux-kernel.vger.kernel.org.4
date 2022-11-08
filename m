Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1E621789
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKHO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiKHO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:57:50 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938421AC;
        Tue,  8 Nov 2022 06:57:47 -0800 (PST)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 2FDC360F5F;
        Tue,  8 Nov 2022 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667919466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDxqWEg7EmzP7uNyet2C2UZ9qYQKD/iRbvjSirUCd1Q=;
        b=nYSOFqU9AwgKTT5oailgdjYOXNHtBMEGXmRP5tnJ8SSyxoE4TofkAu8NQlJibfAmc/bMSM
        Ct8eJL02jjHHmH8FMG9FQ5KS9ESmk19lcNhXo4PqusIAJf5e275+sOMmVWbhGXBfg18cgj
        dFARsxZzyG2a2Khp29L3dDPoDkUC39o=
Received: from [IPv6:::1] (unknown [IPv6:2a01:598:a083:6a1c:1:2:c9fa:536d])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 0CDFC3603CF;
        Tue,  8 Nov 2022 14:57:44 +0000 (UTC)
Date:   Tue, 08 Nov 2022 15:57:40 +0100
From:   Frank Wunderlich <linux@fw-web.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Re=3A_=5BPATCH_v2=5D_dt-bindings=3A_pinctrl=3A?= =?US-ASCII?Q?_update_uart/mmc_bindings_for_MT7986_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdZFkeX7J9R2C0rhF+WZJXe65y6FfeBEMBGGkSTh4AWmsQ@mail.gmail.com>
References: <20221025070255.14407-1-linux@fw-web.de> <e7192d9b-df86-a860-d5cb-8b4b9184e5bc@linaro.org> <trinity-889b4468-8a50-4eae-80a1-6bd9ffbeaaf2-1667577856206@3c-app-gmx-bs24> <CACRpkdZFkeX7J9R2C0rhF+WZJXe65y6FfeBEMBGGkSTh4AWmsQ@mail.gmail.com>
Message-ID: <835560A3-5FFE-40A8-84F6-6FE03091A89D@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 780f83ac-7c36-4eef-8b9d-c735a36ce353
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 8=2E November 2022 15:50:44 MEZ schrieb Linus Walleij <linus=2Ewalleij@l=
inaro=2Eorg>:
>Squash and send av v3 if you haven't already! Easiest for me=2E
>
>Yours,
>Linus Walleij

Have already here:

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/202211060801=
14=2E7426-3-linux@fw-web=2Ede/

regards Frank
