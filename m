Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC86B6512
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCLKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:49:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98D4392A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:49:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g17so12211623lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678618158;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXEKhZDtuayyLnwYmi1ZaNEFCsCEA/0Tnk/LxoHckJU=;
        b=RhOazhZ6ToqfSeqplx3lPODbjCF5KbtC6UlYyAYuI3VF4g5aG07U8w2usLOZiaDmUF
         a3fndSCLeqcQVVrZWfoxSd6CZ4riucOugWnjOVO2cXoi9oHJoBwQqnB6ygk+KjOkZ8Mp
         ULUTV8+E55o2SE/Y0WcGtt8qtTyGFxi6OIXvfph2f15jt/tr4TGiGofo/AmcK7pGQMu7
         yWdtYcJaQCEpb131t+H+LsQSPD1mtdoxKJQtDQhd1Ty5OTU89uUT+qGoxlXe+BFpmOlv
         JZIWBTw5lR5cwU9wza+02CxdoSyBXRWW8LInPOJGGyGOOI3zICzORbjJ8mJ2omusDubS
         f+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618158;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXEKhZDtuayyLnwYmi1ZaNEFCsCEA/0Tnk/LxoHckJU=;
        b=o0ffs4zDz3n9HsSyI8VGUaO2CtO34+oG3y1HXGKA8YlFhvPp26IHq1O6xX8Ny20/KR
         E5mNSiObT/8NNIhUokvs5DMFqhYA/D7oR8hljnF50veVuFgNFSGS1w93FdiZjKGz3XUb
         61QDDe5/Vp9pS37WClOX27LId5Ib0sL3W973TPicATRibl7OIXYlafrm+h1f8fcd+IWL
         jlvmqKPnOtxEdstqz645OK/0lWcMOf6CBSejTycaXpUN4HNJjRRzyeRJ5oasghsbYBdW
         UPy2UQuuWLRrrl9Os8wqrcp2NpUFhTnelxNNXBbv8dsb53tl+IREStpPhUIiCQKGN3ql
         1DJw==
X-Gm-Message-State: AO0yUKUpdh4NxEHajyrWw+TLVqYHKQTo19j+CNziIEIqBIYhweX7zAu6
        XF3JBtUMOnp+wiW9awV/DMX9JVR15AXc8kkL
X-Google-Smtp-Source: AK7set+VbEOIAJgocd4OKbAyT6z2uLIGQTWSip8qe0TRJ5oXjxVbK3p3X6wBRdz3XH/bgbilzlqQPA==
X-Received: by 2002:ac2:5449:0:b0:4dc:4c53:4466 with SMTP id d9-20020ac25449000000b004dc4c534466mr8565700lfn.37.1678618158013;
        Sun, 12 Mar 2023 03:49:18 -0700 (PDT)
Received: from letter3.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id g15-20020a19ee0f000000b004d887e0e9edsm606476lfb.168.2023.03.12.03.49.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 03:49:17 -0700 (PDT)
Message-ID: <640dae2d.190a0220.316fc.160c@mx.google.com>
Date:   Sun, 12 Mar 2023 03:49:17 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Missing changelog (I did not get cover letter, so no changelog there
> either).
> 

Got it, will fix in the next revision.

> 
> Anyway, I said last time this looks compatible-specific, so I don't
> think we need another property.
> 
> Best regards,
> Krzysztof

I agree, but I'm afraid of introducing regressions by enabling this
workaround on systems that don't actually need it.

