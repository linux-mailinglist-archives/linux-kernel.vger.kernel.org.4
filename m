Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DD68BAED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBFLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBFLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:05:29 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A118163
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:05:28 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4c24993965eso150127117b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/M2w1f1ejppYwVpoetXPL96oEOLajNyNTStbmuIHEpo=;
        b=xGHo67xRTX9pLb5kk2u67bMm/hPlTDlsYQXnCUd56vACLLE78E+lcaQlH6KkqPBlAl
         NRBcxWTN38cwngSDXzHN4lU2ByvsYY/4jjBGwvfQRm2Chgw0qPM2fiS6q4vo2/lS07KD
         zcgMdwCS8JD3iXk/TCmrerZ1lZm70p6pnYGEdoHueSDtFG5spnN+G9Xepl70YJBImqjq
         +xNQFiLJqKKhVNAf2uaf1TMD8bf68vs0YyjiIHDhVNNyRlbPOBmimKbW55/cio/Zasmm
         D67q2tZn54CjNpPFbGqyCWhQCpozKDHdDJjO3uC8oxJWy4MZfA+KeQkRnjjXVQHzhFRi
         JfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M2w1f1ejppYwVpoetXPL96oEOLajNyNTStbmuIHEpo=;
        b=VO+ET7lZBq5EsXStNXhQnLPPnzW8ifzdHydD/jReZ6pnnlSr0R6MLGwTxjkk80R1nA
         swZx0Sjap8hCbEWvXQlEE4TtNVCX+4n/eE+Sdn7iM2SfuZJa/vXsxwQK2U5mcaHtmeEh
         byfxvp2/ayEt26xTtV22gq1Tl9gWW1BlNpKY/R4epgyfbRamRc3FNK/QhWQIA2xbNUNY
         6LxopEooFD4uMiQTT7rhl+iaDnWo/j7+c6+F9J1q/yp1/X9ZNKEWwWXcd5cK3mGFXaQz
         FE7yoExDplIf17qCC21a5/Hc60+Iqtue/wofxLm3bHbWMJykdHmsgfp+L6rKLngtFGLL
         cZXA==
X-Gm-Message-State: AO0yUKVna/l9YmuXwu5/jvnldmsSP2iAKRK5V2eZ0SBXWuc5v5Nhv++/
        QgvgPSv5leCDMI0ToMEts9H775TBCj1TxheRTCTDAg==
X-Google-Smtp-Source: AK7set8uRY1iPUNVeg8z7fv5kUvghcudKzgjd/jPHL1FKPpv6pI8uYSe9BYjHJoOQbZGd46g1+MzuqNfR5Q5Wbniop0=
X-Received: by 2002:a0d:dfcb:0:b0:527:1c51:fba6 with SMTP id
 i194-20020a0ddfcb000000b005271c51fba6mr879420ywe.477.1675681527673; Mon, 06
 Feb 2023 03:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20230127101832.93789-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127101832.93789-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 12:05:16 +0100
Message-ID: <CACRpkdbMaM93m_av-1-Qguct_w0upMiXPiELr2WzMGaFOmaD-w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ixp4xx: use "okay" for status
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:18 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> "okay" over "ok" is preferred for status property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied, will probably be for v6.4 at this point.

Yours,
Linus Walleij
