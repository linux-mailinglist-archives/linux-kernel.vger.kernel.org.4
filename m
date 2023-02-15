Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159AE697E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBOOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:11:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669E38E95;
        Wed, 15 Feb 2023 06:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0C47B82239;
        Wed, 15 Feb 2023 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D28C433D2;
        Wed, 15 Feb 2023 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676470247;
        bh=DH4FUCFelIwcOz1OdcH5C5gJ2pv9hdKWARuNwh3qNf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O62MQzlZQVSRwF8JNJvyNoW/vWClJ1QmggGzwoWb2HLHePLVAQa+KhvVcHC+Zpz7x
         DhT9BriMs//wHDdsOj32fsGRuJNQGWrPSSIXkZSmmfS7wLV7II1Jqogfd7L62CUyqk
         Ze8+wl6kUzeDMLnSBKHieZai9Y0sk+syXleyYu20gFAsxAdPxl+wUt7Br//AVF42GF
         4U+l1SMQa0Vt25hiqO93G0uyQHtjoeHXMDJXele6Roo72G4t1qnj/X+zmn8pap++js
         S5/vnNi0EzCywdffkTVC98Q1X5I6beTTyiF0IxqNPahJRhKqK6LqEGKdPKuR1oQkI1
         pwJCKeBJCjT6g==
Received: by mail-vs1-f45.google.com with SMTP id k6so19987950vsk.1;
        Wed, 15 Feb 2023 06:10:47 -0800 (PST)
X-Gm-Message-State: AO0yUKX7W4AI9oWegOiew2IlVG0nBB8qTDgSElF/rRA5h2NVIsJBKkrF
        AivUwQ3A5zwqUjVG8BFDWOs0vR/62eXH+iO7yw==
X-Google-Smtp-Source: AK7set8FnCBbdFH5FS8uz/h537D4O/PkLn8ucaYp0tl88XAE8QbZciEJDn4ZrAQ8MTmxXSdd9hcSaq5R87m25bM+WaQ=
X-Received: by 2002:a67:f5da:0:b0:3d3:cb5a:df05 with SMTP id
 t26-20020a67f5da000000b003d3cb5adf05mr345658vso.83.1676470246464; Wed, 15 Feb
 2023 06:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org> <167639581474.996065.4144950480631659648.b4-ty@kernel.org>
In-Reply-To: <167639581474.996065.4144950480631659648.b4-ty@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Feb 2023 08:10:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpsiermwLON5B8Z99XQMAaK36Nv_GKLvRFQQokEwKY0w@mail.gmail.com>
Message-ID: <CAL_JsqLpsiermwLON5B8Z99XQMAaK36Nv_GKLvRFQQokEwKY0w@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM
 G-Link node with bindings
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:28 AM Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
> > Bindings expect (and most of DTS use) the RPM G-Link node name to be
> > "rpm-requests".
> >
> >
>
> Applied, thanks!
>
> [6/7] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
>       commit: fdafdddf7b2f5cab8d233ef97f1fad8ec7d2e7a0
> [7/7] dt-bindings: remoteproc: qcom,glink-edge: correct label description
>       commit: 6f9c2f19a8743c880903a031c7f3f3c534d4b813

You need to apply patch 4 too. There's a warning in linux-next now without it.

Rob
