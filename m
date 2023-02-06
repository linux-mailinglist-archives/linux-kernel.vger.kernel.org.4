Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE268C96A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBFW25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBFW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD81043B;
        Mon,  6 Feb 2023 14:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA22B81661;
        Mon,  6 Feb 2023 22:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27C5C4339B;
        Mon,  6 Feb 2023 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722510;
        bh=eG8mGuQ8kOjC/UhEwyM2fFwvvdGE2saDASuR2IgCBso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpUjak8Rm2Nfudig4mmNAwi0/NFyg1y/mpqLRAkD+J9U+JflN8eAZjCuwY7dfWTMz
         /zLTlNv4yrbOOvGuiVtfI81nD3Ug55Zpg6+9pBjG6yq+J+IS5e92uC5hrRNoPv0pvk
         SpapIkZRs2TDoXHDARAup4JlluKteEIV1DcXgMcOnaiEJCL2iiEMS+atQiG1Y2Z3wv
         ZLUYaJUL3/mAiihVoBvpBjTj7i7A3U86zXCg4oGOaTsAumZcPGLq+ZeXYCVZ7AcfDb
         fXQ5SJi41OjM0PJYB2IYzS/4ixwl3HGiledRLuS9GeMhfKlMF3XFXuqsRctw2eneT5
         NwGSGCQGqqBvA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Naman Jain <quic_namajain@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com
Subject: Re: [PATCH v2] soc: qcom: socinfo: Add support for new field in revision 17
Date:   Mon,  6 Feb 2023 14:30:37 -0800
Message-Id: <167572263442.3569822.4492847852634663778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127041200.29094-1-quic_namajain@quicinc.com>
References: <20230127041200.29094-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 09:42:00 +0530, Naman Jain wrote:
> Add support for new field coming with socinfo structure under v17 to get
> hardware platform's oem variant id. This is to enable OEMs to have minor
> changes in the board, but to use the same platform subtype as the one
> supported by Qualcomm. The new field is to be used in platform overlay
> file. Default value is 0, reserved for Qualcomm platforms. Also, add
> debugfs support to read this field for a device.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: socinfo: Add support for new field in revision 17
      commit: 6bdab60d5cbd7996e371305433e943a82cde0d4c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
