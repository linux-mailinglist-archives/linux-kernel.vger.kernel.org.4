Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7275066A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjGLLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGLLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:42:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5278F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:41:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso855760866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689162101; x=1691754101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkLaNoWskYXvslP1Qpy+TOolPrbyrAyjVa+N07spH6w=;
        b=GdjQR8SX+x1pUX1Mtuv5xuheRUWPa4xiVxpkVzvnVRdbcp1cUzjP0h14IUqu6A49uh
         +ILaIzXUf2Mhdwplokt+KkGbaABFpL8/iEI694YXvZbBt7Sog7sBDmxeW+Y0f7ZsOdWe
         5ofrVDPbBcKUZHkbjXE8r4GO44GkCD/FlM/TEQSYzuMasTPzjCcd+Lq+xCrQ3EVK+2mK
         pv8A4mjEVcn1b4BRijKkmUZeFw8rnVWf32GcC4Xpfs95QPNVnjLryFYlRJay1WKbzbXy
         rPBtfLVfj+D1a26xpFSgBL4hhG0LAYfs7ama2jywMK6z6E0r+9Jtm/p/MKJkAvGCu6eJ
         zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162101; x=1691754101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkLaNoWskYXvslP1Qpy+TOolPrbyrAyjVa+N07spH6w=;
        b=LXHhNfVITuUmg0EN5cNZVh29oWFAijxxlo/rKezNPtMIYhRMraWrYMf2WZjIAw1xXO
         3uD6hc9MoRO1uZk88vwDkJ98k67d3WomtBvAMABVRlPTSOXNinAly/Ec2qzZWviROEiN
         cSvyhRpSaUzikJ7FrcBOp2L7JQdAWdWAOyhaMqd3qEo66LHISWv/TCYatIkNcNFDYXL0
         nQ7QQdNCP7R2Re8q2SXWJeSVo5y9dW3JGmlig3VJKmaCUEoHS5KKD6LeZ2IMIKDt2axS
         Z/PuEQbkrgCRw0ZlCRRNB1JkOczNBWerHl/TLS1ci95j9FQbq/DwBa34/UyQBDsxeA0U
         FuRw==
X-Gm-Message-State: ABy/qLYWTzdwrObH3+XMwohsV7C7yjmu6MoLmLNu97jIfW77ROZLIxpZ
        Jq82+zj4kfsIDpe7TF2SKqb2GlclSULznPy9J4qQVA==
X-Google-Smtp-Source: APBJJlETTVGODR20/rwVslhngoGW4fSKBoGdRTlMwhh0V6YrmWG0usTUtZoVfuLIpCAbQ7YW2JEtyp8nTpjT009g3QQ=
X-Received: by 2002:a05:6402:1293:b0:51e:5789:a71d with SMTP id
 w19-20020a056402129300b0051e5789a71dmr11910654edv.12.1689162101091; Wed, 12
 Jul 2023 04:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083741.7615-1-slark_xiao@163.com>
In-Reply-To: <20230712083741.7615-1-slark_xiao@163.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 12 Jul 2023 13:41:03 +0200
Message-ID: <CAMZdPi_qcLYGSUYg+4skkNUzUVSV5Fk1Ohe75ZWwyN7=MpfkUg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add support for Dell DW5932e
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, fabio.porcedda@gmail.com, bhelgaas@google.com,
        song.fc@gmail.com, duke_xinanwen@163.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 10:38, Slark Xiao <slark_xiao@163.com> wrote:
>
> The DW5932e has 2 variants: eSIM(DW5932e-eSIM) and non-eSIM(DW5932e).
> Both of them are designed based on Qualcomm SDX62 and it will
> align with the Foxconn sdx65 settings.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
