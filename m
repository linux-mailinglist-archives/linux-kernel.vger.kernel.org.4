Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A826738FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFUTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFUTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541F1BCD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3F1C616B5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC2EC433C0;
        Wed, 21 Jun 2023 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687375073;
        bh=rhMq0Ov2yU+4ukHFiSj71YNGaaJUkmnZuTppfMroecs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKqYeO6DVQt92s2GG6bzGnUETbnsIWOf1Zk3uYYKPtxlgPUvUhi81Y3ZYWgTQC0lT
         PCiaS7l2DQmZ0sVVBLaMA0RDt8pScSr2OyLzTW5M+PQDxlEv5vKVrLCPFHZGhdhwZ5
         xhF2Ju+ywCX7/8FjUWRxEXS2VuroVntvQ/8DwjKA=
Date:   Wed, 21 Jun 2023 21:17:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, nathan@kernel.org,
        quic_hazha@quicinc.com, u.kleine-koenig@pengutronix.de,
        yangyicong@hisilicon.com, coresight@lists.linaro.org
Subject: Re: [GIT PULL] coresight: updates for v6.5
Message-ID: <2023062157-cymbal-shrubbery-fb61@gregkh>
References: <20230621171608.573041-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621171608.573041-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 06:16:08PM +0100, Suzuki K Poulose wrote:
> Greg,
> 
> Please find the changes for coresight and hwtracing subsystem, targeting v6.5.
> Please note that, I have pulled James' devm_krealloc_array() patch -
> 
>  ( commit d388f06aced3 "devres: Provide krealloc_array" )
> 
> - into the coresight tree from your driver-core-next, for CTI module refcount
> fixes depend on it.
> 
> Please let me know if this looks alright and kindly pull if it is fine.

Pulled and pushed out, thanks.

greg k-h
