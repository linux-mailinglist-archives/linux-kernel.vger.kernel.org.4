Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5808272004C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjFBLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFBLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:23:36 -0400
X-Greylist: delayed 788 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 04:23:35 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEFF18D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:23:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=61q3OwamPbGx/ro9KiQNc+v6drxwXKz2zrM0A0GL1uedVHnoxXJDAFSJa490A4aQHlZlHNbXEM2LwX3x52KUm+bBHnBDZ6VuCa6ZY81S3g1/0vtDW9rgCHGSAbAQVgVq2FhethrEuWDs9oPVD/b+HChDdV8agNp+RmLYLwSkn5JJQLmLAMmP3qE3Epno7AQW+95/sGy9Bi9yNn3Q8ngsH7/RAz/MmIKH1KH/QSPeFxFU6SmqIZX2H9f13xNGsfnYW/UDfqHZgeR+IeEd8LOqAk4feEAupmDuMLtqac4HVhJf9CzPs2c7iXk8+9VVsqW89QDWF+SxDmQ6NaaxwNXhvQ==; s=purelymail1; d=iskren.info; v=1; bh=9glP7S3bzL4kyCTsFMdSym0Q2pPbCIRMlIsGoQdrp3k=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=7GAh/pzd6kx0tAv72MXMlwua0xEuxQHe3LDW48s4D6cSWHQPIIrgrDymIbL7hp1r+WzN9kGfj0D02JQrRdmulPHJaYTu7ADu2I2vWH6KKIiyRNvLcjhk/Ur/doPa3kqWntNtaY+j+9/O1OuIBCqPecTWRmcJxLGheljG1cWj8iKf24opIw9eHnvqZgnw/mUioyG4fRrtcMMFheXNYlVIu4mg/+pyA65cuYkOP2TM/tV3XuUbhSTDoerySLrznZ9EWyM2z3HYOWuz+SC3ugc0caYAperK2a7Liz6AQEbCHfa2zdLjUsWXkHmlYMjH+DWnBHDBhyNHrDw9qWPatSZMRg==; s=purelymail1; d=purelymail.com; v=1; bh=9glP7S3bzL4kyCTsFMdSym0Q2pPbCIRMlIsGoQdrp3k=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1231945857;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 Jun 2023 11:08:40 +0000 (UTC)
Date:   Fri, 02 Jun 2023 14:08:37 +0300
From:   Iskren Chernev <me@iskren.info>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Update parts of PLL_TEST_CTL(_U) if required
User-Agent: K-9 Mail for Android
In-Reply-To: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
References: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
Message-ID: <9F5D5FD2-1D35-4EFF-B7A5-9459CB409309@iskren.info>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 1, 2023 12:39:06 PM GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lina=
ro=2Eorg> wrote:
>Some recent-ish clock drivers touching on the "standard" Alpha PLLs
>have been specifying the values that should be written into the CTL
>registers as mask-value combos, but that wasn't always reflected
>properly (or at all)=2E

Yeah, that would be me=2E I didn't feel confident enough to add the mask p=
arameter, but it seems very reasonable=2E

> This series tries to fix that without affecitng
>the drivers that actually provide the full register values=2E
>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Iskren Chernev <me@iskren=2Einfo>

>---
>Konrad Dybcio (2):
>      clk: qcom: clk-alpha-pll: Add a way to update some bits of test_ctl=
(_hi)
>      clk: qcom: gcc-sm6115: Add missing PLL config properties
>
> drivers/clk/qcom/clk-alpha-pll=2Ec | 19 +++++++++++++++----
> drivers/clk/qcom/clk-alpha-pll=2Eh |  2 ++
> drivers/clk/qcom/gcc-sm6115=2Ec    |  8 ++++++++
> 3 files changed, 25 insertions(+), 4 deletions(-)
>---
>base-commit: 571d71e886a5edc89b4ea6d0fe6f445282938320
>change-id: 20230601-topic-alpha_ctl-ab0dc0ad3654
>
>Best regards,
