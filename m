Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B008A6BF0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCQS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCQS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731C37700;
        Fri, 17 Mar 2023 11:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 853E6B8269E;
        Fri, 17 Mar 2023 18:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196DFC433EF;
        Fri, 17 Mar 2023 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679077629;
        bh=qRA/LX/H0BHVtpxz2Hq8VN+lza6VppR+WNwBlF/2bFc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EC3ukvMB8RbvxQQOwkSMYJipwYJ/T9kr7K+lTRFpG9RAxjtgYt61f6tuc1zYDvcHZ
         xDaHzeIGCV1HMmPowROd2z0cg/tEjytysFJVCiII09OKG95CrCChvh0MEhDhvxGdY0
         qb53Yxd3Qsj6ejRX/ylyFaC9zbgDjJBLGlamSXY7cgNeQTMuSje6aR9NuHi3QqQMiE
         jcGyKcQdIqVqMm5aEE+775ysjwzgXaK59DE4frYSjhDeOWCERNfxa9uI/FtokybfiM
         z+iS2V+7C5wSj703V4ABtTcgPtkAnJ/qk1ysplc4pM0FsBKZ8l4nQl/rFSRepcnulz
         RNMLCWCId3q9Q==
Message-ID: <406d02f72767afafa8e563ec2ee7f310.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230317141622.1926573-5-quic_mohs@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com> <20230317141622.1926573-5-quic_mohs@quicinc.com>
Subject: Re: [PATCH v9 4/4] clk: qcom: lpassaudiocc-sc7280: Modify qcom_cc_probe to qcom_cc_probe_by_index
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_visr@quicinc.com, robh+dt@kernel.org,
        swboyd@chromium.org
Date:   Fri, 17 Mar 2023 11:27:06 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-17 07:16:22)
> Modify AHB clocks explicit registration from qcom_cc_probe to
> qcom_cc_probe_by_index.

Why? Isn't it the same?
