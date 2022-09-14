Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740295B8A08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiINOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiINOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF2FFCA;
        Wed, 14 Sep 2022 07:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5550461DCE;
        Wed, 14 Sep 2022 14:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43711C433D6;
        Wed, 14 Sep 2022 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663164646;
        bh=RKdAhJmHQHgkapWrL0u+5jLAaWEEGdAMCSADr+xPYUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtqY7flpg+M1CWCSEXVW6LxWxXq/A/NH0mnm9idjlh5dQQCdBaAabLaks6Y0QGlvu
         suSH5979UEv7SHohINDqBERrtCZlZLSY9Vr8geNQ9nxgWwDzVz5cw3/lF5ImjhHBQT
         v3WmVuQdiaRbytFenRzR/M5Kd2Wy0npYe43+hqx1BgY8Q9xxkX1TumlqGrg4GlmPKo
         eybHdBUGPMARfHc94unkihGJxmjtMkUOg/CRe15k/fEcKoBD4QdUq+UytrhoXsIXcN
         FW297Sw+7jknECFpVbdcU2K7ZuMP2GhbJUo10BBG40kRucJyvMjJJB79QBBTF1ul0a
         z4MKxj6SlE5Yw==
Date:   Wed, 14 Sep 2022 09:10:44 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        David Dai <daidavid1@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <20220914141044.jaepzwcqyo2nt4cw@builder.lan>
References: <20220914112139.3680354-1-vkoul@kernel.org>
 <20220914112139.3680354-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914112139.3680354-3-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:51:39PM +0530, Vinod Koul wrote:
> From: David Dai <daidavid1@codeaurora.org>

David Collins wrote the downstream patch that this is based on, so this
should be David Collins <collinsd@codeaurora.org>

> 
> PMIC v7 has different offset values and seqeunces, so add support for
> this new version of PMIC
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>

Ditto.

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450 HDK

The rest looks reasonable to me.

Regards,
Bjorn
