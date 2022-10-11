Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B55FAD60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJKHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJKHVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9AA7B788;
        Tue, 11 Oct 2022 00:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBC94B811FC;
        Tue, 11 Oct 2022 07:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205ECC433D6;
        Tue, 11 Oct 2022 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665472897;
        bh=fpA2CLhghAgNp9uGr6caPeXx7Hj5XJxzoPmmKzYbBJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFbTwl1zWi6KSjSh2HZ5tF2hdOae8JeUNQ9giF1cqh0NYIlLbEuMwFLAukqeahUTn
         prDbiB+guW0eS952j8R0i5W126UCXd7AQD88GSv69Ck2AdmPiud8w0/X5gJvCVkE96
         H72TBsQ1lq+qZcPM/dJCdBGDkrw2/LniowzoTGaY=
Date:   Tue, 11 Oct 2022 09:22:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/13] arm64: smccc: Include alternative-macros.h
Message-ID: <Y0UZrAavHNxkJVm9@kroah.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-5-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011000840.289033-5-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:08:31PM -0700, Elliot Berman wrote:
> Fix build error when CONFIG_ARM64_SVE is selected and
> asm/alternative-macros.h wasn't implicitly included by another header.
> 
> Fixes: cfa7ff959a78 ("arm64: smccc: Support SMCCC v1.3 SVE register saving hint")
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Shouldn't this be independant of this whole series and get merged now
and backported to stable kernels if it really is causing a build problem
today?

thanks,

greg k-h
