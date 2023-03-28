Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBF6CBA24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1JJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC1JJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:09:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841CD10F6;
        Tue, 28 Mar 2023 02:09:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso11799363pjb.3;
        Tue, 28 Mar 2023 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679994578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVfqXcdff5sBvdoyudvkSG88Q0WNyPL7PXC0W5JT+Co=;
        b=LKOmLEjZIV8d97qPCsmMqm7Epg1lJIHl+exvXBLuo3YVfxrURYCobgqzJNOUcet/W0
         qd2BkY+m3hkSrYPsOvvM4tEp78FB4/ylIUiIgv+ZAuDPTPO7QFa6oXZD6102kWJU555n
         ZNw4tLosmcq+A2zQBA+QJYDdsxK2ZmMGWcVP9BxDT+M+YlwbxpL14D04xMJmKuliIH5W
         G4a1Xpq2St4UPtuShaaKaYpIMxKSweA74ukkrHhp8Llx/QOFi9jbERcyK+3Ahm6GaThw
         RPNF0/diyk6HtrcbW9nJ9uT3svmhebYhwWQelZ3CPK/NnQaW4secdvhd22pPp1Zj4N5r
         uN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVfqXcdff5sBvdoyudvkSG88Q0WNyPL7PXC0W5JT+Co=;
        b=cu5mPHOmHfgrVVnmESAoloVk7kx15BBsrdgmmuo0GOz8shNW1CUC1YSAd1HwdYv3dn
         fO6MgtzM3TA3Z5/T/uOyQO5TmY24njCyXlmTQk82r20r3mhtPtplmrqfISiJ4HyMl0SQ
         KzfNUE7x/zEvfAfIlGX6O7cR2TpOs97cR9dENioaV3BzaiI1T+KGBeJvzsFXAPsMXUDk
         EJLzPcjkyuSTJbI5GS6QXKpR7eM3NSQ0U16ZORSrYc1BQixafFs2IpVbC6TL2VfvSF39
         BmOSl4rasUCZTms6ijPffknojQHD+1rFmcc7aEjqWTnjkMCGXeNJ0UYpelmxnIqGcyv+
         PkNg==
X-Gm-Message-State: AAQBX9eFfG6hLjl9XBV0UPMdCe61GwYqM1u7k6+TAvA0hUomuXgQgVr1
        ogbE8nqoqlX1QpxO4pzZwnU=
X-Google-Smtp-Source: AKy350aCLmIqn5fOD3rMtd2U59Wt0WKO0kRHUFDjn/CxdhlzZx47warIbtGER/yadRtEtD+rGk3zXA==
X-Received: by 2002:a17:902:d4c6:b0:1a1:cc5a:b07 with SMTP id o6-20020a170902d4c600b001a1cc5a0b07mr17809434plg.37.1679994577807;
        Tue, 28 Mar 2023 02:09:37 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b0019e88453492sm20742412plb.4.2023.03.28.02.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:09:37 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        leon@leon.nu, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, leon@kernel.org
Subject: Re: [PATCH v4] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Tue, 28 Mar 2023 14:39:32 +0530
Message-Id: <20230328090932.55409-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0824738d-d431-bb4a-16d8-e4e4064969c5@linaro.org>
References: <0824738d-d431-bb4a-16d8-e4e4064969c5@linaro.org>
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

> git format-patch -1 -5
> scripts/get_maintainer.pl v5-*
> and you will get a bit different results.

There was a new entry this time, while the rest of the output was same.
Leon Romanovsky <leon@kernel.org> (in file)

I added him as a CC here

Thank you,

Saalim
