Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCDC72EF69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjFMW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbjFMW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F52136;
        Tue, 13 Jun 2023 15:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B4763BA1;
        Tue, 13 Jun 2023 22:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246BFC433C9;
        Tue, 13 Jun 2023 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695253;
        bh=kRaCoHkKjZMQJa2FjhmA3kyz1iWcP9/uQ8Azcg3KTus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0TTJqiSZ3kFLx96ZuK42CPBO/TsOUkQA1ewpxV7usNqUHBr3iKWDep7lbRybkUE9
         6bjoCoVErDWGWOWSD8XWcTmbP9LyfFpvU/e6fNpqjxHutzstEipngktTmvEp09YWzA
         IzgW0P4jwLQqSYb5EjeFGKFpfPnVEV6x5sfJ9y1U6gX5nbcvTJl1V3DRRMmSqwiHFz
         tFD4KDBXI71ng8YEVnaxgNvZiozxqNCfJx8lWulVuotMzhU40PmKsepVfKlJQTIMzM
         9FTWwloVlibw5vVH4R3bZmFwsTejwHRPxFyiU0g/yOl0Aoeh6FsYWbLF/wdFx7L/NJ
         ngwOtLaMrHawA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Naman Jain <quic_namajain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Robert Marko <robimarko@gmail.com>, quic_pkondeti@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_kaushalk@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qcom: socinfo: Add v18, v19 support
Date:   Tue, 13 Jun 2023 15:30:30 -0700
Message-Id: <168669542894.1315701.10780452748994021143.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606134626.18790-1-quic_namajain@quicinc.com>
References: <20230606134626.18790-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 19:16:24 +0530, Naman Jain wrote:
> Changes in v2:
>  - rebased on linux-next tip after Robert's comment as socinfo
>    SMEM structure has moved to socinfo.h with a recent change.
> 
> Naman Jain (2):
>   soc: qcom: socinfo: Add support for new fields in revision 18
>   soc: qcom: socinfo: Add support for new fields in revision 19
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: socinfo: Add support for new fields in revision 18
      commit: 158826c73d48097f843bacc1bcafa6dbc114f4e5
[2/2] soc: qcom: socinfo: Add support for new fields in revision 19
      commit: d9c2a255cfe026c8bf85a39631734f022ecefaff

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
