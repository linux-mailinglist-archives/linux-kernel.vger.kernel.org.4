Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEB731C67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjFOPX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbjFOPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294142711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6906C63263
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFC6C433C0;
        Thu, 15 Jun 2023 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686842599;
        bh=UUaBlQvJDmZAEgBVEl4WeOCM/2fO1LJvnAzyR/K4LZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIHnmEkNw+LhkbV5n6yCOQDZmXKa+M/sDt4Aw1vFsThfNawSkr44MlwzX+XEy+Jat
         i4+NViiA6QCa86ttkJLxInyGIsPAqpODAlQp69Yl3Z2UPC2JjzKJwlvFzkAtAap3KE
         nbZWa1mkG/iL0QqT1MDaoPTTGgrBgXyJbji7nF4dfJc2OHa+2bOmAs5bYycl1kF1Ek
         pRFS5TH6TKqgMwad7ymScwEDOjuElATODLoTny1PGCZC7C5D75abN9XpSiDo2ggeDB
         iEETwfJNC2OWCRaJPVgOj+k4B36abIKECKWP4Xjom2hBFKuT90/SEbq5BysvzmqAmw
         AtmNzhMHF7lmQ==
Date:   Thu, 15 Jun 2023 16:23:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Use of_property_read_reg() to parse "reg"
Message-ID: <20230615152316.GK3635807@google.com>
References: <20230609183159.1766429-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609183159.1766429-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Rob Herring wrote:

> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/mfd-core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
