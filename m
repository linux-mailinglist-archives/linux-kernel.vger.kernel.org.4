Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250D0640FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLBU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiLBU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34DEBC9E;
        Fri,  2 Dec 2022 12:59:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D64FB822B1;
        Fri,  2 Dec 2022 20:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F5BC43141;
        Fri,  2 Dec 2022 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014745;
        bh=joGYk9dwiA9FLOs0C7yYliD3619UgJO1LXlq7zOukqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEqATaso6fMxx1DVjbUqB0UTvc5tiFnuUf9AlBpBTVtAXjeh0RWNCqicxk0c3RQZg
         X9kCxImCCamJXXGUqwUHi68uwDCHa6wMNALoQo+xJbmd40HRNGE5nCBqZwLeKV94Sm
         CtnjASVybzuNkxXEg1kWnfM3LrslIGENbkSqjIO5KlFwRy7W0t3vK60Br0odPuGYdb
         203sv3bU/Vw0+8CgXWNddKhBeDs6CVdp3qnRgHOrYdatL3BWcmhHDGcTyRYpxX2zPo
         FioCAdmU6x2pRdWtz3G5URty5Esz0hjYO8CQoWiAXJ8WQFwkmE8qWQDi9CL18GiHgJ
         Dwi5OvORyXg2Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robimarko@gmail.com, konrad.dybcio@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] clk: qcom: ipq8074: populate fw_name for all parents
Date:   Fri,  2 Dec 2022 14:58:51 -0600
Message-Id: <167001472424.2721945.9873510086467091950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116214655.1116467-1-robimarko@gmail.com>
References: <20221116214655.1116467-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 22:46:55 +0100, Robert Marko wrote:
> It appears that having only .name populated in parent_data for clocks
> which are only globally searchable currently will not work as the clk core
> won't copy that name if there is no .fw_name present as well.
> 
> So, populate .fw_name for all parent clocks in parent_data.
> 
> Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: ipq8074: populate fw_name for all parents
      commit: 35dc8e101a8e08f69f4725839b98ec0f11a8e2d3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
