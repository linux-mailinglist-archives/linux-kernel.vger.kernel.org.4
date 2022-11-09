Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BE622320
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKIEbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKIEa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:30:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876118D;
        Tue,  8 Nov 2022 20:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51D54CE1CF6;
        Wed,  9 Nov 2022 04:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4674C433D6;
        Wed,  9 Nov 2022 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667968252;
        bh=4Rz6wgqWZLPyeSPEWet9jm6iMjiOYPopushiLvtLfiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro7FisNy+HJzQoC3cw8P4m76mXxr+ZtPfrgFGObsH9hJuesMl2BXn9cPDD2zj3k8b
         bdBKCwCg2dJWejAQqXx+vV+yxTZvyJ7lledzJ/LIobcffcWSloracw/PxKVyC5If5N
         BttiBKDthhKJhOZJp4wW55VFpmtmtVGAwUbVaKTR39k2a8MzjE97xco2PTtsIDgIkA
         pbrX+l8H3++TjMuj3n1vb4ruQkUQm5k3X41PL2ldnGONLP6OEJ54h7Yy5t14tFhDdE
         2jq9Wu0PoZnQE8ns0YlgG1Bhmaz2L6xLxKsWe6pbvCQzPf+fBu2etP1mS/pITWXNh0
         N2OC2Eap4rwvw==
Date:   Wed, 9 Nov 2022 10:00:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Subject: Re: [PATCH v6 4/4] dt-bindings: soundwire: Convert text bindings to
 DT Schema
Message-ID: <Y2ss+NN3ZHJ4sIbR@matsya>
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
 <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667918763-32445-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-22, 20:16, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree, as it is not
> appropriately described in text file.
> Update some of the properties description with minimum and maximum range.
> Update secondary node info which is used to describe slave devices.

Applied, thanks

-- 
~Vinod
