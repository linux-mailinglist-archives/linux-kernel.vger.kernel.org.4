Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC136DC208
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 01:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDIXmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDIXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 19:42:05 -0400
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Apr 2023 16:42:00 PDT
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9933595;
        Sun,  9 Apr 2023 16:42:00 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A26B416181D;
        Mon, 10 Apr 2023 01:32:06 +0200 (CEST)
From:   David Heidelberg <david.heidelberg@collabora.com>
To:     konrad.dybcio@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        quic_abhinavk@quicinc.com, rfoss@kernel.org, robh+dt@kernel.org,
        sean@poorly.run, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: display: msm: sm8350-mdss: Fix DSI compatible
Date:   Mon, 10 Apr 2023 01:31:55 +0200
Message-Id: <20230409233154.135495-1-david.heidelberg@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321213557.1737905-1-konrad.dybcio@linaro.org>
References: <20230321213557.1737905-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RDNS_DYNAMIC,SPF_FAIL,SPF_HELO_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Heidelberg <david@ixit.cz>
