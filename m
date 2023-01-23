Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A655677827
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjAWKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjAWKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:01:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C883EA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so8568653wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDRXGMLivFOcZ79NQl3aMUkhwQ0hIeAn1Ufeiz9Vo2Y=;
        b=fu7mfQyJWuiY5HuPpDK6cdHqLRbimSOEqokU4KyVJ6X3zD/9XYNNwp7YiLLHOWMq7l
         2DRLQHBaaXsRxKH1CE3tOm0HXRpjALtHpU279MBJRdJi0uLP3oCv0wcIg3X2MVmAOUiv
         ULfPo8sEOl+CqwQkJ9Js7a8ixloxaR8jjHrVxJd7eA+RuZVcwAvHiQR4Pcq9gsZvWUG2
         iDxo/QY+ovTtcKrbVv4rDZrgwrCPQbcOxf5GQNCS0SDz1dshEz+Kvxdqsvb7kpyD5QiM
         NmXROIU2UMDIUGYFKVtUXD9MyYvWkpDW0VvkG5e6JktsXcaK8dpSuTV9avdxt2mraW97
         wgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDRXGMLivFOcZ79NQl3aMUkhwQ0hIeAn1Ufeiz9Vo2Y=;
        b=3eik/bLXM4TDVAT3crOIDjTlp2dn/AeYazCXHtr3MLORP2m2ayn9xShDqha8Cx0PHW
         Jl1XR9QDNTNVE+jgqcG4AKDkxBHJEu1IPCVX9mDXWceHGah/zVWA12/Esuule3Gk/yLJ
         +Q2cga9o6v+QEz8j+JjSdDymo6klAx10KMv36Cbl6Ga/uIr6w4UK+CYZnzpyCDxwM0Lr
         TIA6AC0MKxRWkHHZA/ZcjKcBGnS3mRSHYT0rdB9cbPY15j/l1NGz8VxvWWribdnNFj6I
         UKAki5Gn3DwEpX+AD02HznOlnMXGSkYKm7nlPAC5p5UHdeAUTcUedkT1pQl5R9sAC0ge
         3zfQ==
X-Gm-Message-State: AFqh2kokVFh77nwbR2p+RNe+tUEnmZcrhVH6hqCXWsvsYTxCdxyOKEfZ
        I+cZA+Sw0RtZ72ZYE7Ndez4gpQ==
X-Google-Smtp-Source: AMrXdXvxxcmeGtlioatlJ2BEj26cKVQDb3mhBz/+8zADp/Rkia6XVRhOQ4/fKNi90ZleYySqOW4uGA==
X-Received: by 2002:a05:600c:3583:b0:3d2:2d2a:d581 with SMTP id p3-20020a05600c358300b003d22d2ad581mr23431609wmq.30.1674468109516;
        Mon, 23 Jan 2023 02:01:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm11050831wmq.28.2023.01.23.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:01:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ARM: dts: exynos: align OPP table names with DT schema
Date:   Mon, 23 Jan 2023 11:01:40 +0100
Message-Id: <167446806831.57213.14407925625428994492.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120064724.40621-1-krzysztof.kozlowski@linaro.org>
References: <20230120064724.40621-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 07:47:24 +0100, Krzysztof Kozlowski wrote:
> DT schema expects names of operating points tables to match certain
> pattern:
> 
>   exynos5422-odroidxu3-lite.dtb: opp-table0: $nodename:0: 'opp-table0' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: align OPP table names with DT schema
      https://git.kernel.org/krzk/linux/c/e1c7def07c5c1d1cd6d28aefa8f11e31032c90fe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
