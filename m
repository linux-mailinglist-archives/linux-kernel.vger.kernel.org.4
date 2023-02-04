Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35C68AD53
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjBDXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBDXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:05:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046C22029;
        Sat,  4 Feb 2023 15:05:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so8346909eda.11;
        Sat, 04 Feb 2023 15:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SsffKkQbD1Qv01ydUNK4favIJJi7ReNERIe710JhOLc=;
        b=QX1kKPY2S9den3sFFq9zBF6oaoNhXwtsiXVec6pyWYmj5eaQemIMz1mM+QULn39HDz
         dYBNcKmZIKouYOSXeXneMDWL8gaAoIIV+VOMaKVmvq8YO+SRxuLpj5I2OliK4gd8rMsz
         zKgzAPPtIqnyTpLmWZiGNQNDFPuCvJMRMN9m8t3U0mACWmDd66k3QV6PldYWHfWjhVpG
         d2NiJ2UGwHnHLoYNJ/nHQuiuHQb9Mj1cIuMBuIZj5rro9C89naZqXZPVJ/9uNmhsQYKY
         IParG5s9MhY67K+abbJILJN4d2HL8Zsv+4b74cX9aFtvzdrc0QAt8JF5l9byhuchfaMg
         5L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsffKkQbD1Qv01ydUNK4favIJJi7ReNERIe710JhOLc=;
        b=bVwgxmhRvnFB1oo03J11SkhdYwyKCSH7YmDreK9T01tsU5EPovEK8hg9qhTlNRVkdL
         mIBUeMKXfuu88maQ8HBEAg32a97vVcRFaVMSBZUC25wrbVE2WEKniHp6l1qtTYeKb9v/
         X23rShVnDUhVYRBL1U2pe9GAPmNG1d8B71wXySQCSpv01lZsWNrbS1a+O7DV4039jAAT
         ckZEh1aOG1uOiN/tKhDwP9uFIPftNXYsXDgFQ6KVl53TAaTz0TJWy0/OR+05joFJqfrc
         nujldMBkglVIw+0AjR3cs/1vXus7fq60khscbrllmwCkqtRydmFe0tKbF1Qgymlxrs+5
         +Gww==
X-Gm-Message-State: AO0yUKVx1qM+u8hNc55kthPSXA2FZCN2YcunMLNDGLhQ3aV6ONftXUSG
        /gTY69/LDZkiyI08PnblsW4PK7qab9iwoVHRaSU=
X-Google-Smtp-Source: AK7set8QzdCT6rdHSN26GRk6gqcqpBSqwKuLjmP897qShiN/tHqfvEeG/Nr2ga8bMvWh7H7Y/+Kp68maCVfvhkCUaRE=
X-Received: by 2002:a05:6402:1110:b0:48e:b978:cf63 with SMTP id
 u16-20020a056402111000b0048eb978cf63mr3883209edv.57.1675551957173; Sat, 04
 Feb 2023 15:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
In-Reply-To: <20230202141520.40003-1-avromanov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Feb 2023 00:05:46 +0100
Message-ID: <CAFBinCC7=QR3Dd_N8VN-L7CpFWETTTehNo6j54f9Y53w8emwUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Thu, Feb 2, 2023 at 3:15 PM Alexey Romanov <avromanov@sberdevices.ru> wrote:
>
> Add gpio interrupt controller node.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
I have no way to verify the register offset or interrupt numbers.
Overall it looks good though, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
