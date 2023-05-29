Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC71476F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjE2Jsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjE2Jsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:48:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94EAF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:48:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561b7729a12so58776647b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685353724; x=1687945724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkLT+DVMzICOnkgjPvqf4ZsRIt+r0mHmPWKwJTBzXWU=;
        b=CyDVTNmv1DnZ4uqfsBFy4mv/pjTmzqCkJpWiVzdJpXG2ug0CxBEqgyYxdlZjvSxSfI
         LUHvbKq8eYW7LzoUsp3uQ/aS+LGNCavbyjMbsXRhYBOSxEsWx4p1wiTweTbHK1m+eob6
         IqlIP3hjDac3skT4Eq7fAr5ljdVssSgOQ7ZWKCRa28Gxbe+DJYuYu36CmzpIZ4dJF84g
         egCaQxMqG9mAEs+bzE5smlDv8Bcx2ELQY4B3bsEM/QsuMfLdOR9vbGFWateb7AdUAeG2
         lmwug8b8FgVkUcFq7YhBcPRiUIzZ8nLwbCetyk+pZypV/3F0IblhNVai4APo7W9+u7lQ
         ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353724; x=1687945724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkLT+DVMzICOnkgjPvqf4ZsRIt+r0mHmPWKwJTBzXWU=;
        b=KjQa3F7fuXPoD+pEi+zuaPmNrgX3pxeaiuIt/hUbjsgCA+6j3tEQMzJnqErzoD4iSS
         cLa59v2um9M0gKSyGEV8FcEmicJrPhp8ffUemHORU/JPTthssUT/URzwd1MJ9lEyM4DL
         KPFft74RAbq9TRE9hv8X4zQCkwFSglRFvfBTUdfLL0dDQtHuaiwHEPaaMJ+2SxomX177
         hsWIWqhts+0c4/5AL9i8ugICxAZqJ8iV7GFRcDaXBSrTsMfbEbuqC2H0vAMkEcXneLMK
         Q7SPwbVFkGAwnPeDXszKSKweqjNjElqccCvbAwkZChuMOJh8CzUoP7vLDhWAcdSo1QdR
         h9/Q==
X-Gm-Message-State: AC+VfDzgxmXCiWP/bwyHAHqKYNk7bzsKQRMDv0aSOJi2UX48BSl9TCAX
        YJ2VjWVvprouyZigfuILuQWZS6c6x86ywacLPC87nw==
X-Google-Smtp-Source: ACHHUZ45PczqAN4JRC6veTjLq/Vb+3bm10ke8fPRMdk1dEMz8VzTvJT1CAFvipsfEvpARvYvLwKiaBMuDU7HWiITYEs=
X-Received: by 2002:a0d:d948:0:b0:561:89f1:6bb with SMTP id
 b69-20020a0dd948000000b0056189f106bbmr8975758ywe.6.1685353724684; Mon, 29 May
 2023 02:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <1684425432-10072-1-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1684425432-10072-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 11:48:33 +0200
Message-ID: <CACRpkdYOOsOwLRw_5=MzmrwpBg8EnkgNKD1+gXjSUHqvtRuqkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add pinctrl support for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 5:57=E2=80=AFPM Rohit Agarwal <quic_rohiagar@quicin=
c.com> wrote:

> Changes in v3:
>  - Addressing minor comments from Bhupesh related to reusing variable.

v3 patch set applied for kernel v6.5!

Good work on this!

Yours,
Linus Walleij
