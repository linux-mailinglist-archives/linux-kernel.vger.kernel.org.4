Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25695B5348
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 06:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiILEdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 00:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILEdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 00:33:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7481186E3;
        Sun, 11 Sep 2022 21:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 244C3CE0E90;
        Mon, 12 Sep 2022 04:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F78DC433C1;
        Mon, 12 Sep 2022 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662957190;
        bh=DMQ+sxIyLswWvHP3+zJbCqQBrGsYh656ROvOi0OPCoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuwNCfCdW91UgMz5U/j36uF6Zveo1OJJmPNvgj7AhMXjX2dCQnp5YwF10QU2j3tZ8
         sPWM6JS5rBdSqElWNEtqozNj2/O8r6mY279xK1rQNQn/PaDD3JxR9Jo0a/WJar3RgJ
         8WrfYqA6fZqBdJa4lAXx2YLfXANh4vwo0FWvtmGHb6edmjpmM9FK4RnAHYr9UxjxjM
         EDJHI6oDDjlIHS+zPlIK5IbjRj73wNMPMtmd7k6FsHFdQAUhOG2LD3/zP+39qS7JYo
         hQz0Os4/L+nAgaTB7SC22Y6xD71+QOqoNAdqTQa4Z7mfnYAB4Qh8r2oYFOEkFOYlv3
         K/rnWcbAfFffw==
Date:   Mon, 12 Sep 2022 10:03:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com
Subject: Re: [RESEND PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add
 new compatible "qcom,pmk8350-pon"
Message-ID: <Yx62gekFa3hguPWL@matsya>
References: <20220909204207.15820-1-quic_amelende@quicinc.com>
 <20220909204207.15820-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909204207.15820-2-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-22, 13:42, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
> 
> Add a new compatible string "qcom,pmk8350-pon" for GEN3 PMIC PON
> peripherals and update "reg" property.
> Also, Add an optional "reg-names" property to differentiate between
> GEN1/GEN2 and GEN3 peripherals. GEN1/GEN2 peripherals only need one
> register address to be specified (e.g. "pon") whereas GEN3 peripherals
> can have two register addresses specified ("hlos", "pbs").

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
