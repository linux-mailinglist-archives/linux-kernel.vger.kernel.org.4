Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805656C4E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCVOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjCVOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D1664D9;
        Wed, 22 Mar 2023 07:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9E86217C;
        Wed, 22 Mar 2023 14:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D98C433D2;
        Wed, 22 Mar 2023 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496150;
        bh=7oZmRM7OFO/FuWohS7k0V74nm+3Qny+p7t/M7GzkTrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LW5Oyc6rUcynJ9IRuTw2lwDTCoXMoUd5yBjKzYsEQnjzc8laalPNeyn0GVmDjTCdb
         eUgzqS/LNcb8IOguJF+FomOfLtvKP1wsd6keA9EFVYPI6Br1TA93+H5Jm/NOuMfDww
         l6ZqYa49PtjbD7RRaQKZp1jlfMP8oQanKmgqobeHH5brsjQnV+mrU4q1zovl8XCI7z
         zQ/34H3VXxr3nhVyBXHvjgxuFks8JdFD4s2dYAm/yeHAZuUDzi7dUO9etabyi14Mxb
         pFXmsrSkDJkikYGf+y14Q8ueocoCRo3Qcl3QHs8avQlhWhFnaO9dKc2LzuEWuM47DK
         aJNpYwx0FNuoQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: add Hall sensor
Date:   Wed, 22 Mar 2023 07:45:23 -0700
Message-Id: <167949631653.1081726.6096488505993355745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306174147.185239-1-soyer@irl.hu>
References: <20230306174147.185239-1-soyer@irl.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 18:41:47 +0100, Gergo Koteles wrote:
> Enable the Hall effect sensor (flip cover) for OnePlus 6/6T.
> The GPIO is mapped to SW_LID events as in msm8916, msm8994,
> msm8998 devices.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-oneplus-common: add Hall sensor
      commit: 80dc42d9facc9232072855340c2285682c0c3b19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
