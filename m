Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34AA6C9462
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjCZM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:58:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8233599;
        Sun, 26 Mar 2023 05:58:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o11so6013285ple.1;
        Sun, 26 Mar 2023 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679835506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqYkWJkaO4sQG1+IkZaD7pCpxyjI18qQfmgn5wQQcKc=;
        b=nZpaa6gyehqtQLFxFkiTBb2f7dnSewWh+fRxYQdlcsNT1qSTpg4LdeyJsOn2TsZjj+
         leUPQG3nfr3FAIRu1xQRKuQ/YnuFIRlPB+U1cjxcQOMwm0SOBFLLloWBovhSGA6W1YlW
         l+bD0xSnBZQtFfKlxAjUJE0571HfhpB0IMCZ7EWO5cvSHhgUpt3NAjUd0W2mv3nlF5P/
         9+Vet/qUQAd++7x1ggxKfd/+FRkrERMKQ+zSXm4I0hqVZOPS0/dX2imiogSxIF2mZgM+
         K3GZ84ioKL7qFPLQcUHf+rjRiv7XqUf6kQ8G45u89d29FXHXCuyrzxoSKUKRHHArSRRU
         ErRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqYkWJkaO4sQG1+IkZaD7pCpxyjI18qQfmgn5wQQcKc=;
        b=p8A2ay8LB4qqQAr/HQw/LzY/EsBoAfABA1m9S3towhdrqBxY6tUuBH9uCkjPM/dq/S
         Ab/I8YFFRg5LYZvXzpRwyNIzkLnebNo8R6ihz40miUM2f0xUC9UfqOO0m8C0vXotEXg0
         iRLW+DLH/IjWngEfxUYyK12Em3Qf+/mZMW7axtxQigGtzjGNTI9ITNzr2WVIgc6dFg+B
         e5Tn2hGsTVbl/B8NjOPfidqv6AcNBgKUJYLX9/jpzn6nTGoWKtJdKpqKFDx1tcDI4AVn
         qJNN12SEZJeB3irpUJfHiEkymU5i3cc2bRu8kD6bEeF5e97OBd4pvMg8DJ5bbKPjn0VU
         CrFg==
X-Gm-Message-State: AAQBX9fRZdH0AR0gdgu98pt3cLuzF9DUzlSwsShBjyTBOQhSABMAaZim
        5q+r78XnFIVS1NqSIgPcMS0=
X-Google-Smtp-Source: AKy350YlWB8TR1kFc7Kd+zh62anGXPBz3sTBsxn8Plm8A4fgNv1bB72UCrkUdCgr7cr2K58/7Tt8pg==
X-Received: by 2002:a17:903:230b:b0:1a0:4fb2:6623 with SMTP id d11-20020a170903230b00b001a04fb26623mr10801275plh.40.1679835506433;
        Sun, 26 Mar 2023 05:58:26 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:1d70:a8f1:a55a:6f4a])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019a773419a6sm17300476plp.170.2023.03.26.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:58:26 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Sun, 26 Mar 2023 18:28:19 +0530
Message-Id: <20230326125819.18986-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4762f4a1-5e99-4e5a-72c0-9c4c61cdc856@linaro.org>
References: <4762f4a1-5e99-4e5a-72c0-9c4c61cdc856@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> allOf:
> - if:
>      properties:
>        compatible:
>          enum:
>            - ak4458.....
>  then:
>    properties:
>      dsd-path: false

Do we also require to add a descriptioon to explain the pins which will be selected based off on the value?
Or have you disabled it based on, that it is disabled for ak4458 codecs?

Thank you,

Saalim
