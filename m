Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF562084E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKHEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKHEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:36:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A771220D6;
        Mon,  7 Nov 2022 20:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0DDDB818F7;
        Tue,  8 Nov 2022 04:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5EDC4347C;
        Tue,  8 Nov 2022 04:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667882192;
        bh=l9ph8ckWx4YlAC89hByp72hKFrJFFjF3pTK7kkfaqtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6YNkDehv0PROg5Daw47bjPLCQfmD+lOefEqz0jUXWwau7rU/OdTAVroVPPfvE693
         QDeXnp9AoJ1Ir+WPvfoZCmrfBf67qZoP4/SqcalxNSY9w6NxCMD6FzkS9bWGx7wpA/
         doRodPbWzBduXf2uHxhCTe4NpOPJAs0oJNcemjzJRCuV49ldhxZuuOen73TD8HISXF
         P1oFqEBiVfOXZJfT6Wf1mAdz/jwtt3zNubCfvSS4V+DPsJbxujvfW5G3E8A/1cV3cz
         9pe//2f4obIA0NGIatN4QECX6k7Hbeo7eYh8pDPBfAs3iR1DQg47x7HtwiFngzzAdt
         VS5CFcaUqBJ+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        job@noorman.info, robh+dt@kernel.org,
        Henrik Rydberg <rydberg@bitmath.org>, agross@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, luca@z3ntu.xyz,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v6 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
Date:   Mon,  7 Nov 2022 22:36:26 -0600
Message-Id: <166788218323.625965.12217737552806429204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107105604.26541-4-job@noorman.info>
References: <20221107105604.26541-1-job@noorman.info> <20221107105604.26541-4-job@noorman.info>
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

On Mon, 7 Nov 2022 11:56:04 +0100, Job Noorman wrote:
> Add Himax hx83112b touchscreen to the FP3 DT.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen
      commit: 6d9a666d49bf57c6a176e5fcf1b39046ee6a728f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
