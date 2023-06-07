Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1857267AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjFGRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjFGRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6C1FCF;
        Wed,  7 Jun 2023 10:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D836616A8;
        Wed,  7 Jun 2023 17:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBDCC433D2;
        Wed,  7 Jun 2023 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159831;
        bh=pZcTVLLiIRL735nUNe2nRR+4NmAQlsIK40zLI6qlujk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=si6CZLulOOFQBwBLvCrGPujNsZgJJv/o7yK0rUP061dgsOcNkqrtpIFMXnEBrHssV
         vksE/O1f8ba1i6P8FaMH41D2MBI2e1xzfrsocFKuRcY+AMFSq9ZOFyl+/+MohsfCjG
         LqWncXg5pnJSlsfUnC2ECdCdDpRGn+RHw85Zv/C2FgSaKdbOieW5yf5iGQzeeqNG0+
         EgudZmd16HbPkMVmNTjYX+F5Kft7RBWe7QP3bFHSY8yP/6vR8ayv/66yOEfriHqMYY
         zZEZnav0PSAgb7IB+pG0bw7n8/vL/Rv1toWKRgHUfxqL7xOphTlctNJ0gQIuxMbdjy
         gJD5Pw6uPfJUw==
Date:   Wed, 7 Jun 2023 10:43:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20230607104350.03a51711@kernel.org>
In-Reply-To: <20230607171153.GA109456@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
        <20230607094922.43106896@kernel.org>
        <20230607171153.GA109456@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 22:41:53 +0530 Manivannan Sadhasivam wrote:
> > In any case, I'm opposed to reuse of the networking stack to talk
> > to firmware. It's a local device. The networking subsystem doesn't
> > have to cater to fake networks. Please carry:
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > 
> > if there are future submissions.  
> 
> Why shouldn't it be? With this kind of setup one could share the data connectivity
> available in the device with the host over IP tunneling. If the IP source in the
> device (like modem DSP) has no way to be shared with the host, then those IP
> packets could be tunneled through this interface for providing connectivity to
> the host.
> 
> I believe this is a common usecase among the PCIe based wireless endpoint
> devices.

We can handwave our way into many scenarios and terrible architectures.
I don't see any compelling reason to merge this.
