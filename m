Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940A46C14DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCTOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCTOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:36:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D03244AD;
        Mon, 20 Mar 2023 07:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3184AB80E99;
        Mon, 20 Mar 2023 14:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0498C4339B;
        Mon, 20 Mar 2023 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679323005;
        bh=m6LM86bMDwt2Qv4Ord+ipumhxJZcyykeD1YSz/JgoZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqYd9ukk8FlyVyi+VkirOB0ZRnUva2Ql0RJtDcqEGGH+pNsUK6CSTaCqloEvSCRfB
         cfvH4A/wGQoWwCsPh5YJAr2dFGtC/99vubv2FGFtYCS4lF6eK/hFJ9B2DofH79dRrb
         Ne3Nf9tB+4m2Dn9MyZoS26H8X4wqQ5GSK9GW9DBVXACOwF8pjT7BtJUkeBtnuhD2UQ
         +UebFLNUpSvyZ/fDei1Z82P37q8BH/3Lf3jm6qyGzkGb+NkfbiVEWw2WhgzYEhp/k4
         p3ctV4EtkB6Oym5zdPKCI/LpR4FQ2Zaj1RmGKm6cYWiwypajBtOnshoCgXNmG1uH0Y
         c3NRb27NxThcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1peGeF-0000nB-5U; Mon, 20 Mar 2023 15:38:07 +0100
Date:   Mon, 20 Mar 2023 15:38:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg'
 property
Message-ID: <ZBhvz8guAnrVMSvk@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-3-johan+linaro@kernel.org>
 <1a009919-a1c9-7a0c-9f93-bdcb8cf316bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a009919-a1c9-7a0c-9f93-bdcb8cf316bc@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:11:39PM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2023 14:57, Johan Hovold wrote:
> > The SPMI PMIC register region width is fixed and should not be encoded
> > in the devicetree.
> 
> It also violates size-cells=0.

That's the same thing.

Johan
