Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B5707BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjERIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjERIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDAC10D0;
        Thu, 18 May 2023 01:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F95648B7;
        Thu, 18 May 2023 08:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4672C433EF;
        Thu, 18 May 2023 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398070;
        bh=GR2nFvTtJZy4UyCufRkfx+kYWz4p6a0F2EAW+weYMe0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O5nQ6YQaOkWa0A9Hut2cGFTX7PxU3SSBAoNC+0jT0TLWJiPpo1/7bp8xB+GYqLri3
         YuEDXrdenQz6ms0QA85UXhd1gOUIxRgsLcoRVoHR+FaY/WrqZg3U6Jc4kbAefDE/u4
         q5K8MaKKaBnpVAun2pW4Lr+u34t+Rv48ky2sUAsNoa6ujDCb0cW8py32WxZW/S7xgs
         O0iLSFqWY30+sBx8cMDs992yJ3C9RRT6IMTIgnwIStBdCxtRQwPQDi9X28hAaN6aBw
         ftMDxrdJZDCXINfEjLhhfT5s2oUcvLaUOdLTizFtkMWSNjfeVtMbpwXiiRk4gcXzey
         lS3t/USvzTAwQ==
Message-ID: <a422a4ec-5fc9-9b4b-0cdc-8ea4e9dfc292@kernel.org>
Date:   Thu, 18 May 2023 10:21:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] dt-bindings: net: Add QCA2066 Bluetooth
To:     Tim Jiang <quic_tjiang@quicinc.com>, marcel@holtmann.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com, mka@chromium.org
References: <20230518050826.27316-1-quic_tjiang@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230518050826.27316-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 07:08, Tim Jiang wrote:
> Add bindings for the QCA2066 chipset.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.


Beside that patch looks incomplete.

Best regards,
Krzysztof

