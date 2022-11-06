Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1618061E0CA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKFIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKFIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:09:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F9DF2E;
        Sun,  6 Nov 2022 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667722118;
        bh=HTNFq3TyDhFyNWIAWgSh9mMvlsrOJm3pLpGjJrBym60=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZTjTIQ5tgWtBUGXuP5NdP2uWnuhLQAE5DIvsBGFvFVQXIgtxH95sdOMg5coexIt1t
         LU3Ic2UAKnGsoKOeHAKbUSFJ/Qm3keYE4n6APEz96aLcglUD3C167kPei4c7qrTYMa
         hsOpq51y9QjW4nAmu5WUkII0FC1g18+fL2HOiFFhrHunj/BUf3gaTnoxfBJgYz5c1/
         isDVTeeCDf0TLNPUJ17Oj89JjzG7nHbO0kYA8PUh9t9C6PZp9i/TnUoLweGs3F1xf7
         1Usi2TKKA0HRnpP77wMAVfbUkcXVwzEO+ea8NtJex9hKdlJqTOIP9lOM1FHOhJBm+O
         py0iCkJnl9fcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.199] ([80.245.79.199]) by web-mail.gmx.net
 (3c-app-gmx-bap30.server.lan [172.19.172.100]) (via HTTP); Sun, 6 Nov 2022
 09:08:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-82c4e225-5699-4c03-bc04-cea1a2d5b3f6-1667722118679@3c-app-gmx-bap30>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh@kernel.org>, Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>
Subject: Aw: Re: [PATCH v3] dt-bindings: pinctrl: update uart/mmc bindings
 for MT7986 SoC
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 6 Nov 2022 09:08:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-93c64b9b-8363-406b-aa0b-07e6802ec84b-1667660667233@3c-app-gmx-bap26>
References: <20221105092500.12145-1-linux@fw-web.de>
 <166765939212.4158869.5881767839110614067.robh@kernel.org>
 <trinity-93c64b9b-8363-406b-aa0b-07e6802ec84b-1667660667233@3c-app-gmx-bap26>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:EMz+lrjrmCAlVksKsxn0azOOpK6Wc0cDQzr6u804gLqwdXRbJ4LHgABsPteviC2OPicw4
 WxfBVlWrhF7266MetBJotdeEWiyXZHY39hQBpuHumEq+TfQKASSJAmgYhwwoUiGlWHk5X7nd8xA1
 UpRbSg1Acu4cncnaKDj9Ohl80yxR1+nngsjhuAtwXOKEt9UI0e2SIeKwr9z2fgh+xZAjV52U9tEW
 0/4vXcT8btC+yVpyyD398y70mKMoilF9kx872A8GbPyyDcuBiDRprr8IatT3CyT1ahJZFB98JHhJ
 /c=
UI-OutboundReport: notjunk:1;M01:P0:MfjkpulsvRo=;ruPvxJlI/AytI0KCjmc/m9Jb5B0
 LEXvXaJ4IfVEvdWDwgbnQ/4sJNiKRUnfcehTucqUxeeNVPdZ5PUuIpYhGCnNOuE7Xk4Wgjyt9
 +4A0hqMM887wGdHYRkWBaH5QnSPGmwD3uuF1qcqnWmC5i7QwD+eGZbrkUSZEj0ElO24Uotjwb
 iGMtSvCRqNzjyyOLIfxvSenK43IhTuNOLyJkCs4W2VRBYyjqLRbKNkb/6V+bJL/BZtXCDQIcH
 FKlqh+LgsxMd+dYBU3SB5X0+rZnCrpSJvYvczd9gzFjjXcz7vlqLF7gOx6s9ZMgFVRzThKTNp
 TwcNewLIBNCWJGJQeUQoDPPE1qVN5NcLRBc4pYCMmVgPkr6Xr+IcQZ/L+D7pHJ2GkVAyPhDiA
 j620Cc0bWhRSVyysSwvL5zcUqHVfgD4bg4SbbTOBTvz9aLKh/azEwP7THrXQyJKK5EVIcpo+r
 XKmxiMvfRg9t6MetmewF6tcFaPzXLF3W5SUbTKTIhR3x0DoqRjWva+s0nvnfIP9ohML4Qly1c
 O7vSQM8SBx5t0rJhPMUYEdz2O6clAgjNslemg2KfL7kzAyxZtuOfTmRBYiITN4hIpNw11YnTY
 QJKqblGyimCwVXscTOplYBqSh6IAXXSshXIorjgpz7L3imSvcfiM3lGX++NRVB4TLQxp0LQBG
 dMX7y/dkdkxJ/y9UC6/ZHb/D2K8y+ibHRLf6SGBDQNmTXmRoyVI4yrGfESOkNBb+RTbAza79Q
 GxYxKKW9AJuTfF4S4sTe1Bx5Xl5Hz8pUM6NEEqtO2Xfb9SLlYyQb7Xpl33qTpoQF8+fAVgmS0
 6FwWtkqCEXc708UOtCdy85Mg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

included this Patch in the pinctl series here:

https://patchwork.kernel.org/project/linux-mediatek/list/?series=692462

regards Frank
