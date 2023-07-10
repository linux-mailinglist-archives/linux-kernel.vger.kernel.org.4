Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2C74CBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGJFIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjGJFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A9E7C;
        Sun,  9 Jul 2023 22:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6036760E8D;
        Mon, 10 Jul 2023 05:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01FC433C9;
        Mon, 10 Jul 2023 05:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965512;
        bh=Yqhw+N8sNA2UMULxqlVBSDFI0gUznoTPUD4zxIT+OtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFkEvb4yzGu+Zp4GNM+hWvTFj5zZGxvFnDUoUh35wy3uNdXzMo+v8znvMQC6W8oY1
         vEk+nZ2+IOvFsgusjEaImyRP2i9XGzLmprt8E8MVnowrkr90yhrsnR5iExm/EpMCr9
         vXjV01s1XLwPxuzt5MFa5e8092zv64hQuirLGLf1UtwQE6Of4lGOXxPO4kR4g3a08K
         TipH4Pu6JDzRqmuBfCzAsNeawispv5oSs2wWa1sRwlbPjhbYly4+AuAndZIBpuyONi
         JFjAH9xBQMtVIZRkVa/UBGsrsZm3ZmQN0EMi7abMCdv3HnzgL8RiLSVWS9dGTcCz28
         rrvJaJTBNpusQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Fix "status" value
Date:   Sun,  9 Jul 2023 22:07:50 -0700
Message-ID: <168896565972.1376307.14829191830751177958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220957.3945972-1-robh@kernel.org>
References: <20230626220957.3945972-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2023 16:09:57 -0600, Rob Herring wrote:
> The defined value for "status" is "disabled", not "disable".
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: Fix "status" value
      commit: 55179c92c7346ab20991975195c3dc0ba7b74c50

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
