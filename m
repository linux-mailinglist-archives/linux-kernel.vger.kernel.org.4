Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843663FA76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiLAWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLAWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:22:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89215725;
        Thu,  1 Dec 2022 14:22:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vv4so7580484ejc.2;
        Thu, 01 Dec 2022 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=43iXTOhymkFYi+I/PnHOBFe/3hsQ6zcPY1HFPaZnmCE=;
        b=AA7gdaGirrsn3n2VYahqjSR/5UUKnOeyXYZL3/QBZCSags6Fbx5mz52UAtNVA4InCf
         edmQXi2mmMMipJEePqDHVrUk4hCFHyKqkt4CgvRblHntIJ04ACcep8QwYyOUQwmhj94V
         BzZ8LX6XGXlvLg04Rldp5Mz6byKMb4TIYMbkRMRzMfK2fZ1HJcXCejS+5u+zk02s+7uS
         nh6YZUhfyeTRIGs+67jAWndAiiDv3J7Yx9f3oj7nFlERtcejAPV4wESjSEAePsbpDNlE
         OL4SeWqojn9ikb7SCJtt4VU+cGO4d2UFOUH//iS7b7B0zGYiNhRTqg5z07anWn1m7PmH
         9FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43iXTOhymkFYi+I/PnHOBFe/3hsQ6zcPY1HFPaZnmCE=;
        b=ExwBnCqMTRrouqvr/bce/RIjRywZ+uBWB1b22OWMqbX6a1nQrB97XIGDAuqO4VHZYx
         1lioRwNK43zM8dq3gWmNRb5dM807T9/ZLh+B1BBGQZSCsaSMg2fuXYhcvcFBN/eFImaa
         QHNlsSUAeJuqDIWMLdR8iTtU5gJgfVWl7loouCQ97r297u5NmY3YksAILkWHtLkAFRRv
         evVFb+CkSLMzUNbVyKtLqewzID4RTOgVV05+Bq1by8MdUFd4dMM+5cQwHqZqFRzOWnAt
         sylXJ88cQAuY7aHVOZSwlUJUQxeGoGNPIW+Z7h/b1dngC1dInJnee1BkaYc5COnUvW7N
         oYGw==
X-Gm-Message-State: ANoB5pkhOH8pBTI+bhbHLxsB7zNXfNPFQp0Lx2AXQ1R3eRrrHWS59YBy
        CsYTCGX7AadC53upV2CGPqkkZRSEQOeX7xnA3Pk=
X-Google-Smtp-Source: AA0mqf47JtVd8xCV1Di9WxT5/mZR1O5eoQCsz4gXAgvql2Da0VICEr1QZE6Pkh83nNHDWXkA0C0hrr4SM+v7cZErJso=
X-Received: by 2002:a17:906:179b:b0:7c0:ae1c:3eb7 with SMTP id
 t27-20020a170906179b00b007c0ae1c3eb7mr4545268eje.510.1669933364900; Thu, 01
 Dec 2022 14:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com> <20221201103026.53234-3-tomeu.vizoso@collabora.com>
In-Reply-To: <20221201103026.53234-3-tomeu.vizoso@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Dec 2022 23:22:34 +0100
Message-ID: <CAFBinCD+UWsky=u8FVqEb+nrhgXVXyEJ4=GMdaPZ024s9w-HcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: power: Add G12A NNA power domain
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Dec 1, 2022 at 11:30 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Add define for the NNA power domain for the NPU in the G12A.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
