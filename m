Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCF64385D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiLEWth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiLEWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:49:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8D920E;
        Mon,  5 Dec 2022 14:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF0FF6146A;
        Mon,  5 Dec 2022 22:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A49CC433D6;
        Mon,  5 Dec 2022 22:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670280573;
        bh=vtkCzJjaJz2NbCG4zHvNZrsu3+zbmbPfubvrskhvQBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhX4/H7ukZhrhq3B+SvY//EcSTOKrlc87WikbOP91kXi5/d/i7lhqXJuZOOwGP793
         Mq/V/RRiUjq1NJNe/7Zgg+GmY/GE7Z0+NAG/qlOBABZ+C46Gz0mkTJP4/7VispO9CP
         o2kATitKDlvHTbV7ENWP/NNF/lZZ+gtqO2E6ugeuz+ZtIFep4mDRc7RBLelT9LFzdR
         rVYEVWVQLNP/88/PAAe4RheFAQ7FCGvjJs+JtvtSpSNkaHZDuUUtVVzQElTqrckGk7
         QAxK9FYAq4zpGHbO5oMfXo7IvhD4JMUB3KEcdEiNIXQjzFHDUfymy1wwKd8Gfe4CYb
         6wcjeazDtR/vQ==
Date:   Mon, 5 Dec 2022 16:49:29 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sm6115: Add WCN node.
Message-ID: <20221205224929.jlvrgrt4nth2bd7u@builder.lan>
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-12-a39.skl@gmail.com>
 <382df687-c535-4dd6-125a-5f3b6022cbd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382df687-c535-4dd6-125a-5f3b6022cbd2@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:38:16AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2022 21:09, Adam Skladowski wrote:
> > Add WCN node to allow using wifi module.
> > 
> 
> A nit: Drop full stop from commit subject.
> 

Done. Thanks for pointing it out :)

Regards,
Bjorn

> Best regards,
> Krzysztof
> 
