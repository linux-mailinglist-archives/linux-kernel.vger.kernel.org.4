Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDC646C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLHKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiLHKMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:12:45 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D889B959A;
        Thu,  8 Dec 2022 02:12:37 -0800 (PST)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 78C9D3F406;
        Thu,  8 Dec 2022 11:12:33 +0100 (CET)
Date:   Thu, 8 Dec 2022 11:12:32 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Message-ID: <20221208101232.536i3cmjf4uk2z52@SoMainline.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <20221106193722.j64xrhitdencrjxy@SoMainline.org>
 <20221202093658.vg6t2ptar2arh7hn@SoMainline.org>
 <2656622.mvXUDI8C0e@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2656622.mvXUDI8C0e@g550jk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-04 17:19:05, Luca Weiss wrote:
> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
> [..]
>
> So the way this patch does it is good or does it need changes?

Except the typo(s?) pointed out in my first reply, this is good to go.

If we stick with generic adc-chan node names that should be documented
in the bindings IMO, as it is currently only captured implicitly in the
examples.  Krzysztof, what is your thought on this?

- Marijn
