Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8366BC10C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjCOXc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjCOXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C32799B;
        Wed, 15 Mar 2023 16:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43B93B81F96;
        Wed, 15 Mar 2023 23:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52435C433EF;
        Wed, 15 Mar 2023 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923132;
        bh=uMdqXmLCW6XxpDcvFL+8bJdyxLlPbAThgt4e3MklO9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrR05VNDibK3st2Hj7gg6k/9/UGdejWAWnzEEO3ExuIo92vdwO64TAd1S9+Sg+a83
         1NCxVEdZXB3s4tHCKkaeBQwVRK+oF+AIlF1spkvRKUyIJqPNcad5RoyVtUYtNz5KHA
         yC68dTuGItMiGEOD7MdDtvnungvGFjkBt+Na5d9TgsilaKVSFyAI0f5cjz5fwFo1Y1
         3hVjOlNnwMItBfkBtIB+TIlvRh/ZX7CW9QTx0ElKUwlFDPFjww84CmI7EZjALSnCoL
         MoWDg1mfPYgofC23lpSW5UHiVLx4juPcc31+NWzTR6rgTNdNh05T/zO4DsK6g/aTKY
         k3jGHOUqFhK2Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add remoteproc nodes
Date:   Wed, 15 Mar 2023 16:34:41 -0700
Message-Id: <167892332563.4030021.18124590243696134852.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230128054256.2100501-1-bhupesh.sharma@linaro.org>
References: <20230128054256.2100501-1-bhupesh.sharma@linaro.org>
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

On Sat, 28 Jan 2023 11:12:56 +0530, Bhupesh Sharma wrote:
> Add the adsp, cdsp and modem remoteproc nodes to sm6115.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add remoteproc nodes
      commit: 96ce9227fdbcfe32265ffb2803bfbbfa692cb445

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
