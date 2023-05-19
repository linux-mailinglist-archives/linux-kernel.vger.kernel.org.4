Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7B1709E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjESRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjESRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78CF9;
        Fri, 19 May 2023 10:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BAFD659A4;
        Fri, 19 May 2023 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B0FC433EF;
        Fri, 19 May 2023 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684518518;
        bh=MpiL+YCRJdZiqq849A/3vM4VGc/aBh9GjJgAruPcz+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCTKz0Nhju9Ju4Z89uDp5CEo+bqaKivicq3EDMZj7+vP3h6pl3I1I6LWN8D9voIMc
         rQnwWcltGyW5cdu11CI90EAg8fKBjL0840p/XZyt+W2UAmmTjjaEhKe11KwxvaV6Dt
         zaZkZiwPIlllWslaBF38iIChk/cZ4MLRqdT56FamdMN8THLCQZ72RvBBheXPT/ZlG/
         ifhf2ZF38L+c4QuOJVS58TI65i15Qh334ag4Frap8VSZk3fM14RRBTjD0CrfYZ70s1
         GNsw97anaEfY1i7rVMlDakfWD7FERoq5B6HuUq5CMiimWM8JeHggewlp2pbMNunwsq
         Uttqd5DTrUMNw==
Date:   Fri, 19 May 2023 23:18:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] phy: qcom-qmp-combo: Support orientation switching
Message-ID: <ZGe2cjmja4KGr05r@matsya>
References: <20230515032743.400170-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515032743.400170-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-23, 20:27, Bjorn Andersson wrote:
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.

Applied phy patches, thanks

-- 
~Vinod
