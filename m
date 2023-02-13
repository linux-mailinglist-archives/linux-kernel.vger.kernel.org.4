Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550266953CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBMWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBMWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812261F93E;
        Mon, 13 Feb 2023 14:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EAD361328;
        Mon, 13 Feb 2023 22:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF75FC433A1;
        Mon, 13 Feb 2023 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326868;
        bh=lct3SIBk29WDEkZbWpKXBfQCGiXSky/TtI18x5QLFRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9TfZ7d/ebrKESjD1jYR3Kmuf6AVVFnO3w2DOxzETAS3Px6CT54i8LxtHysZJ2IIl
         X23adJuGDOGk8KeobkNwZJvhTBn+O/B33Gy8OOxtUVp1ISTKXpXP9wW2XFIOBjofJd
         8oG7jvY9ZeGBoJOu9cu8TGRz5j+UZgKSWL4fHwTRwz7lck/uMjpldrAY57z3rILKHU
         B8+DiAGkZtaKb8fZOK4UR1a3Kc3inMa+J8p35jGVMrEoDlVitICi6i8yyjHpOEOPlQ
         ExjgHsiBZ+3r/SqjZZzFnWM/nHu9cH3r1L4SzWoL2ZwnBeSHi39RpRyD7Ho/lTwFM5
         KcuIc6p7314Fw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Enable remaining I2C busses on sm7225-fairphone-fp4
Date:   Mon, 13 Feb 2023 14:23:04 -0800
Message-Id: <167632698310.557014.13955392492218965629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
References: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 15:46:29 +0100, Luca Weiss wrote:
> The first patch consolidate the two different styles where the status
> property is placed in the dts, and the second patch enables all the I2C
> busses used on the phone even if no subnode is added yet.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm7225-fairphone-fp4: move status property down
      commit: 65aedb0b48c09595065c81722d9cca53760f7220
[2/2] arm64: dts: qcom: sm7225-fairphone-fp4: enable remaining i2c busses
      commit: 574f2ffd45dc786dc443c5e11ea477420ffa5f52

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
