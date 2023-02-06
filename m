Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3368BD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBFMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBFMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:39:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE57D9F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F6BE60EC8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76837C433D2;
        Mon,  6 Feb 2023 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675687139;
        bh=RA1w19+/BlXXLEPU6LDfdgnvxTpgPOmducAteQ1Z1pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixVEJGy3NnfihCkMomNNUm1V08ASB1TR+X4RvwMUt2M5E4G0/zFGkM+iD8bF7YMzb
         1njZf7UZ0vKk+9/5ULAEJPtZRGqkhT+CMFWqFQnwZ0Q3XPwBzCyIENebMB8kKVA4mb
         RFC/jUtoiJe5dw+mtnVlKyhhgLrVSxa77+ZAJTM0=
Date:   Mon, 6 Feb 2023 13:38:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Visweswara Tanuku <quic_vtanuku@quicinc.com>
Cc:     konrad.dybcio@linaro.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, quic_vnivarth@quicinc.com,
        nicolas.dechesne@linaro.org, srinivas.kandagatla@linaro.org,
        vinod.koul@linaro.org, quic_eberman@quicinc.com,
        quic_satyap@quicinc.com
Subject: Re: [RESEND] soc: qcom-geni-se: Update Tx and Rx fifo depth based on
 QUP HW version
Message-ID: <Y+D04FIti7yejya+@kroah.com>
References: <20230206122215.22090-1-quic_vtanuku@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206122215.22090-1-quic_vtanuku@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 04:22:15AM -0800, Visweswara Tanuku wrote:
> >From QUP HW Version 3.10 and above the Tx and Rx
> fifo depth bits are increased to 23:16 bits from
> 21:16 bits in SE_HW_PARAM registers accomodating
> 256bytes of fifo depth.
> 
> Updated geni_se_get_tx_fifo_depth and
> geni_se_get_rx_fifo_depth to retrieve right fifo
> depth based on QUP HW version.
> 
> Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
> ---
>  include/linux/qcom-geni-se.h | 42 ++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)

Why is this a RESEND?  What was wrong with the first version?

confused,

greg k-h
