Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCA710500
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjEYE5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjEYEzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2F19B4;
        Wed, 24 May 2023 21:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE997642B5;
        Thu, 25 May 2023 04:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CF0C433A0;
        Thu, 25 May 2023 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990323;
        bh=Mh2011iz1WZfSziCV0xQ5xa8csdr9NNFZDv/44j+tN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/VNv2uRVXfcYcf2G/sJmaljtSKeya1ZTJWE7Qa6QZW+YISnfE+N4fIjKTF1pAvhT
         zbqcZLsJlX4UHU1pHaiN5dsVNtasHeXvphGYWYAiwnVVaQyEoFd/eXPJAo+fUJnS84
         fyWGuKt4/9ddzY79H+YiV/iVgREDFfOSxhBgEdR6/f/+vhdIJF/+K0Bb6p/RrNGOlp
         E5lx5XgSdN0RqVCuNelEas1MXmnM0VnjPZlOCZJ9MZ+bUiUng0tvA/TNOsKmj1nAov
         h6p6HTrROgGB0xpCV7aSjEUYBgX9CLfTMA9zAs09OcKBijplaW+l0J8JehuFE8T/HM
         SU0YzkDDjAU5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_skakitap@quicinc.com,
        quic_cponnapa@quicinc.com
Subject: Re: [PATCH V2] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
Date:   Wed, 24 May 2023 21:54:40 -0700
Message-Id: <168499048179.3998961.13200486557003967075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501142932.13049-1-quic_tdas@quicinc.com>
References: <20230501142932.13049-1-quic_tdas@quicinc.com>
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

On Mon, 1 May 2023 19:59:32 +0530, Taniya Das wrote:
> Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
> top GDSC is required to be enabled before enabling any other camera GDSCs
> and it should be disabled only after all other camera GDSCs are disabled.
> Ensure this behavior by marking titan top GDSC as parent of all other
> camera GDSCs.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
      commit: 3e4d179532423f299554cd0dedabdd9d2fdd238d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
