Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898796BC134
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCOXdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjCOXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BDA21BA;
        Wed, 15 Mar 2023 16:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC2861EB2;
        Wed, 15 Mar 2023 23:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF4C4339E;
        Wed, 15 Mar 2023 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923146;
        bh=fOuH7YMkRF26sgDPvvscgEMDwuT1ycjPuV5HnFf9/Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/hOmpcl3mrpwEOtm+8GtBXG5csIII1KnydKbraRWP/+s7SXo8TT8EdrQtSjZDV5+
         2MbBNxzF0+3n8JOsqYHNBYWJf97DJJ95q1rnp8OIHabtKXTghep5mNiS30/30sYOX3
         mTIE88ukjGMuzHPWRPnwsFUjIPDloDNDHwd9zirrExiAfkfHbD7R2HMS+gQ5ahE8/0
         8fhgAVYxs8zjn1Uz7RvBUluCxxJ573rsgb64NPgw9TV1oCsizBdis7KppT5naPw+W/
         UYAPUifR+zJFtKAUsH4jS4F8btWN+DQWQvQdFhIVHJ7hsMf8fFkY4O+Pl/v41JaURn
         lZLuUWR+DLiRA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: Fix opp table child name
Date:   Wed, 15 Mar 2023 16:34:56 -0700
Message-Id: <167892332567.4030021.13287398448880084688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220120831.1591820-1-konrad.dybcio@linaro.org>
References: <20230220120831.1591820-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 13:08:31 +0100, Konrad Dybcio wrote:
> The opp-320000000 name is rather misleading with the opp-hz value
> of 450 MHz. Fix it!
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom-apq8064: Fix opp table child name
      commit: b9745c275246a7e43c34d1b3be5ff9a9f3cf9305

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
