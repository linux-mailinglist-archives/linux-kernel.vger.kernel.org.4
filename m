Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B2600893
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJQIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJQIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8DD48C83;
        Mon, 17 Oct 2022 01:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EAE3B81055;
        Mon, 17 Oct 2022 08:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EC3C433D7;
        Mon, 17 Oct 2022 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665994562;
        bh=xYJ/B7Kacgvm4DOq0+mPr8ee/za2TacV2VrkXYB+A1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjpepaLfN9bxKUBVuZ+hgYkJSqSsmcF460JoUIpdUtbzdzkW9G5fdglOCUrzf6YhE
         5OBE4SzjA8qJ0N3vCZivbSxEml8S2HqnVoRQyhSpcYtNW/Y/cyUawYYmAri3YFkNEa
         sVUJyP9J1rqxi/DcD875Wm0qRNi8nr2+29tGh424P+xoKs+94JYyxz5aH56xPZYmQP
         dQg4jcpQ8Dj3SrtpiI1dsoBsUEaEPi6TeE8xM78txLX4Sr/MNnRQAlkDPDDrQvU6nB
         WnvA9eyXeBSELiOYWhd1OHHbcBqVxcvD3oRE+HOZZ92k+4uqsRNde1tNaFMaZ1s+ug
         LhE9hJzU0J7bA==
Date:   Mon, 17 Oct 2022 13:45:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] phy: qcom-qmp: more fixes and cleanups (set 1)
Message-ID: <Y00PPSxezyr+WhY3@matsya>
References: <20221017065013.19647-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017065013.19647-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-22, 08:50, Johan Hovold wrote:
> Here's the next batch of QMP driver fixes and cleanups.
> 
> Dmitry suggested that the register layout structs could all be using
> per-IP version defines, which in principle sounds like a good idea. It
> is a separate change though, and one which would require some more work
> as it is not always clear which IP version a specific SoC uses (e.g.
> some of the IPQ platforms appear to mix and match currently).
> 
> As such a change shouldn't block these clean ups, I've dropped the
> merging of the IPQ SDM845 PCIe layout structs in v2.

Applied, thanks

-- 
~Vinod
